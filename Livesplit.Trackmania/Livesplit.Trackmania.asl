state("Trackmania") {}

startup {
    settings.Add("track", true, "Split at every track done");
    settings.Add("checkpoint", false, "Split at every checkpoint");

    settings.Add("cStart", false, "Auto-start on every track");
    settings.Add("cLog", true, "Log the game time of completed runs in a file (Livesplit folder -> TrackmaniaTimes)");
    settings.Add("cTraining", false, "Training individual splits (overridden by settings 1 and 2)";
    settings.Add("cSeason", false, "Season individual splits (overridden by settings 1 and 2)";

    for (int trackId = 1; trackId < 26; trackId++) {
        string trackNb = trackId.ToString("D2");
        settings.Add("t"+trackNb, true, "Training - "+trackNb, "cTraining");
        settings.Add("s"+trackNb, true, "Season - "+trackNb, "cSeason");
    }

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

    vars.FormatTime = (Func<int, bool, string>)((time, file) => {
        return TimeSpan.FromMilliseconds(time).ToString(file ? @"mm\.ss\.fff" : @"mm\:ss\.fff");
    });

    vars.GetTrackNumber = (Func<string>)(() => {
        return vars.loadMap.Current.Substring(vars.loadMap.Current.Length-3, 2);
    });

	vars.GetMapName = (Func<string>)(() => {
		return System.Text.RegularExpressions.Regex.Replace(vars.loadMap.Current.Substring(0, vars.loadMap.Current.Length-1), "(\\$[0-9a-fA-F]{3}|\\$[wnoitsgz]{1})", "");
	});
}

init {
    vars.timerLogTimes = (EventHandler)((s, e) => {
        if(timer.CurrentPhase == TimerPhase.Ended) {
            string separator = "  |  ";
			string category = timer.Run.CategoryName;
            string timesDisplay = "Trackmania - "+category+Environment.NewLine+Environment.NewLine+"   Sum   "+separator+" Segment "+separator+"  Track";
            int cumulatedTime = 0;
            bool isFirst = true;
            foreach(KeyValuePair<string, int> kvp in vars.logTimes) {
                cumulatedTime += kvp.Value;
                timesDisplay += Environment.NewLine+vars.FormatTime(cumulatedTime, false)+separator+vars.FormatTime(kvp.Value, false)+separator+kvp.Key;
                if(isFirst) {
                    isFirst = false;
                }
            }
            string path = Directory.GetCurrentDirectory()+"\\TrackmaniaTimes\\"+
                          category+"_"+System.DateTime.Now.ToString("yyyyMMddHHmm_")+
                          vars.FormatTime(cumulatedTime, true)+".log";
            string directoryName = Path.GetDirectoryName(path);
            if(!Directory.Exists(directoryName))
                Directory.CreateDirectory(directoryName);
            File.AppendAllText(path, timesDisplay);
        }
    });
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
                    (vars.trackData = new MemoryWatcher<IntPtr>(new DeepPointer(trackData, 0xEC0))),
                    (vars.checkpoint = new MemoryWatcher<int>(new DeepPointer(trackData, 0xEC0, 0xD78, 0x660, 0x0, 0x678))),
                    (vars.inRace = new MemoryWatcher<bool>(new DeepPointer(trackData, 0xEC0, 0xD78, 0x660, 0x0, 0x6C0)) {FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull}),
                    (vars.raceTime = new MemoryWatcher<int>(new DeepPointer(trackData, 0xEC0, 0xD78, 0x8E8, 0xCD8, 0x140, 0x0, 0x32C0, 0x488, 0x4))),
                    (vars.isFinished = new MemoryWatcher<bool>(new DeepPointer(trackData, 0xEC0, 0xD78, 0x8E8, 0xCD8, 0x140, 0x0, 0x32C0, 0x488, 0x14))),
                    (vars.gameTime = new MemoryWatcher<int>(new DeepPointer(gameTime))),
                    (vars.loadMap = new StringWatcher(new DeepPointer(loadMap, 0x9), 64))
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
}

start {
	vars.StartMap = vars.GetMapName();
	return !vars.inRace.Old && vars.inRace.Current;
}

split {
    if(vars.trackData.Current == IntPtr.Zero || !vars.inRace.Current)
        return false;

    if(vars.raceTime.Old != vars.raceTime.Current && (vars.lastCP.Item1 != vars.loadMap.Current || vars.lastCP.Item2 < vars.checkpoint.Current)) {
        vars.lastCP = Tuple.Create(vars.loadMap.Current, vars.checkpoint.Current);
        if(vars.isFinished.Current) {
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

reset {
	return (vars.inRace.Current && !vars.inRace.Old) && (vars.StartMap == vars.GetMapName());
}

isLoading {
    return true;
}

gameTime {
    if(vars.inRace.Old && !vars.inRace.Current) {
        vars.totalGameTime += vars.gameTime.Old;
        if(!vars.isFinished.Current || vars.lastCP.Item1 != vars.loadMap.Current) {
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
        if(vars.raceTime.Changed) {
            return TimeSpan.FromMilliseconds(vars.totalGameTime+vars.raceTime.Current);
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
