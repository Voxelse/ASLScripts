state("Trackmania") {}

startup {
    settings.Add("track", true, "Split at every track done");
    settings.Add("checkpoint", false, "Split at every checkpoint");

    settings.Add("cStart", false, "Auto-start on every track");
    settings.Add("cLog", false, "Log completed run times into a file (Livesplit folder -> TrackmaniaTimes)");
    settings.Add("cTraining", false, "Training individual splits (overridden by \"all tracks/checkpoints\" settings)");
    settings.Add("cSeason", false, "Season individual splits (overridden by \"all tracks/checkpoints\" settings)");

    for (int trackId = 1; trackId < 26; trackId++) {
        string trackNb = trackId.ToString("D2");
        settings.Add("t"+trackNb, true, "Training - "+trackNb, "cTraining");
        settings.Add("s"+trackNb, true, "Season - "+trackNb, "cSeason");
    }

    vars.oldCP = vars.curCP = 0;
    vars.oldRaceTime = vars.curRaceTime = 0;

    vars.ResetVars = (Action)(() => {
        vars.totalGameTime = 0;
        vars.lastCP = Tuple.Create("", 0);
        vars.logTimes = new Dictionary<string, int>();
    });
    vars.ResetVars();
    
    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.ResetVars();
    });
    timer.OnStart += vars.timerResetVars;

    vars.FormatTime = (Func<int, string>)((time) => {
        return TimeSpan.FromMilliseconds(time).ToString("mm\\:ss\\.fff");
    });

    vars.GetTrackNumber = (Func<string>)(() => {
        return vars.loadMap.Current.Substring(vars.loadMap.Current.Length-3, 2);
    });

    vars.GetCleanMapName = (Func<string>)(() => {
        return vars.loadMap.Current.Substring(0, vars.loadMap.Current.Length-1);
    });
}

init {
    vars.timerLogTimes = (EventHandler)((s, e) => {
        if(settings["cLog"] && timer.CurrentPhase == TimerPhase.Ended) {
            string separator = "  |  ";
            string timesAdd = "Raw Times:"+Environment.NewLine;
            string timesDisplay = "Display Times:"+Environment.NewLine+"   Sum   "+separator+" Segment "+separator+"  Track";
            int cumulatedTime = 0;
            bool isFirst = true;
            foreach(KeyValuePair<string, int> kvp in vars.logTimes) {
                cumulatedTime += kvp.Value;
                timesAdd += (isFirst ? "" : "+")+kvp.Value;
                timesDisplay += Environment.NewLine+vars.FormatTime(cumulatedTime)+separator+vars.FormatTime(kvp.Value)+separator+kvp.Key;
                isFirst = false;
            }
            string path = Directory.GetCurrentDirectory()+"\\TrackmaniaTimes\\trackmaniaTime"+System.DateTime.Now.ToString("yyyyMMddHHmmss")+".log";
            string directoryName = Path.GetDirectoryName(path);
            if(!Directory.Exists(directoryName))
                Directory.CreateDirectory(directoryName);
            File.AppendAllText(path, timesAdd+Environment.NewLine+Environment.NewLine+timesDisplay);
        }
    });
    timer.OnSplit += vars.timerLogTimes;

    vars.tokenSource = new CancellationTokenSource();
    vars.token = vars.tokenSource.Token;

    vars.threadScan = new Thread(() => {
        var trackDataTarget = new SigScanTarget(0x0, "48 8B 83 ?? ?? ?? ?? C7 44 24 ?? ?? ?? ?? ?? 48 89");
        var gameTimeTarget = new SigScanTarget(0x10, "C3 CC CC CC CC CC CC CC CC CC 89 0D");
        var loadMapTarget = new SigScanTarget(0xC, "7F 23 45 33 C0");
        
        IntPtr trackDataPtr = IntPtr.Zero;
        IntPtr gameTimePtr = IntPtr.Zero;
        IntPtr loadMapPtr = IntPtr.Zero;

        var module = modules.First(m => m.ModuleName == "Trackmania.exe");

        while(!vars.token.IsCancellationRequested) {
            print("[Autosplitter] Scanning memory");
        
            var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);

            if((trackDataPtr = scanner.Scan(trackDataTarget)) != IntPtr.Zero)
                print("[Autosplitter] Track Data Found : " + trackDataPtr.ToString("X"));

            if((gameTimePtr = scanner.Scan(gameTimeTarget)) != IntPtr.Zero)
                print("[Autosplitter] GameTime Found : " + gameTimePtr.ToString("X"));

            if((loadMapPtr = scanner.Scan(loadMapTarget)) != IntPtr.Zero)
                print("[Autosplitter] Load Map Found : " + loadMapPtr.ToString("X"));

            if(trackDataPtr != IntPtr.Zero && gameTimePtr != IntPtr.Zero && loadMapPtr != IntPtr.Zero) {
                IntPtr trackData = trackDataPtr+game.ReadValue<int>(trackDataPtr-0x4);
                IntPtr gameTime = gameTimePtr+game.ReadValue<int>(gameTimePtr-0x4);
                IntPtr loadMap = loadMapPtr+game.ReadValue<int>(loadMapPtr-0x4);
                vars.watchers = new MemoryWatcherList() {
                    (vars.trackData = new MemoryWatcher<IntPtr>(new DeepPointer(trackData, 0xEA0))),
                    (vars.inRace = new MemoryWatcher<bool>(new DeepPointer(trackData, 0xEA0, 0xD78, 0x740, 0x28, 0x660, 0x0, 0x6C0)) {FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull}),
                    (vars.raceInfo = new MemoryWatcher<IntPtr>(new DeepPointer(trackData, 0xEA0, 0xD78, 0x740, 0x28, 0x8E8, 0xCD8, 0x140, 0x0, 0x32C0, 0x488))),
                    (vars.gameTime = new MemoryWatcher<int>(new DeepPointer(gameTime))),
                    (vars.loadMap = new StringWatcher(new DeepPointer(loadMap, 0x9), 24))
                };
                print("[Autosplitter] Done scanning");
                break;
            }
            Thread.Sleep(2000);
        }
        print("[Autosplitter] Exit thread scan");
    });
    vars.threadScan.Start();
}

update {
    if(vars.threadScan.IsAlive)
        return false;

    vars.watchers.UpdateAll(game);

    vars.oldRaceTime = vars.curRaceTime;
    vars.curRaceTime = game.ReadValue<int>((IntPtr)vars.raceInfo.Current+0x4);
    
    vars.oldCP = vars.curCP;
    vars.curCP = game.ReadValue<int>((IntPtr)vars.raceInfo.Current+0x8);

    vars.finished = game.ReadValue<bool>((IntPtr)vars.raceInfo.Current+0x14);
}

start {
    return !vars.inRace.Old && vars.inRace.Current && (vars.GetTrackNumber() == "01" || settings["cStart"]);
}

split {
    if(vars.trackData.Current == IntPtr.Zero || !vars.inRace.Current)
        return false;

    if((vars.oldCP != vars.curCP || vars.oldRaceTime != vars.curRaceTime) && (vars.lastCP.Item1 != vars.loadMap.Current || vars.lastCP.Item2 < vars.curCP)) {
        vars.lastCP = Tuple.Create(vars.loadMap.Current, vars.curCP);
        if(vars.finished) {
            vars.logTimes.Add(vars.GetCleanMapName(), vars.gameTime.Current);
            if(settings["track"]) {
                return true;
            } else {
                string map = vars.loadMap.Current;
                if(settings["cTraining"] && map.StartsWith("Training"))
                    return settings["t"+vars.GetTrackNumber()];
                    
                if(settings["cSeason"] && (map.StartsWith("Winter") || map.StartsWith("Spring") || map.StartsWith("Summer") || map.StartsWith("Fall")))
                    return settings["s"+vars.GetTrackNumber()];
            }
        } else {
            return settings["checkpoint"];
        }
    }
}

isLoading {
    return true;
}

gameTime {
    if(vars.inRace.Old && !vars.inRace.Current) {
        vars.totalGameTime += vars.gameTime.Old;
        if(!vars.finished || vars.lastCP.Item1 != vars.loadMap.Current) {
            int resetNb = 1;
            while(true) {
                string timeEntry = vars.GetCleanMapName()+" (Reset "+resetNb+")";
                if(!vars.logTimes.ContainsKey(timeEntry)) {
                    vars.logTimes.Add(timeEntry, vars.gameTime.Old);
                    break;
                }
                ++resetNb;
            }
        }
    }

    if(vars.trackData.Current != IntPtr.Zero) {
        if(vars.oldRaceTime != vars.curRaceTime) {
            return TimeSpan.FromMilliseconds(vars.totalGameTime+vars.curRaceTime);
        } else {
            return TimeSpan.FromMilliseconds(vars.totalGameTime+(vars.inRace.Current ? vars.gameTime.Current : 0));
        }
    }
}

exit {
    vars.tokenSource.Cancel();
    timer.OnSplit -= vars.timerLogTimes;
}

shutdown {
    vars.tokenSource.Cancel();
    timer.OnStart -= vars.timerResetVars;
    timer.OnSplit -= vars.timerLogTimes;
}