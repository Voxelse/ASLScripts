state("Trackmania") {}

startup {
    settings.Add("track", true, "Split at every track done");
    settings.Add("checkpoint", false, "Split at every checkpoint");

    settings.Add("cStart", false, "Auto-start on every track");
    settings.Add("cTraining", false, "Training individual splits (overridden by \"all tracks/checkpoints\" settings)");
    settings.Add("cSeason", false, "Season individual splits (overridden by \"all tracks/checkpoints\" settings)");

    for (int trackId = 1; trackId < 26; trackId++) {
        string trackNb = trackId.ToString("D2");
        settings.Add("t"+trackNb, true, "Training - "+trackNb, "cTraining");
        settings.Add("s"+trackNb, true, "Season - "+trackNb, "cSeason");
    }

    vars.loadMap = "";
    vars.isFinished = false;
    vars.raceTimeOld = vars.raceTimeNew = 0;
    vars.inRace = false;

    vars.ResetVars = (Action)(() => {
        vars.startMap = vars.loadMap;
        vars.totalGameTime = 0;
        vars.lastCP = Tuple.Create("", 0);
        vars.logTimes = new Dictionary<string, int>();
    });

    vars.ResetVars();

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.ResetVars();
    });
    timer.OnStart += vars.timerResetVars;

    vars.timerLogTimes = (EventHandler)((s, e) => {
        if(timer.CurrentPhase == TimerPhase.Ended) {
            string separator = "  |  ";
            string category = timer.Run.CategoryName;
            foreach(string val in timer.Run.Metadata.VariableValueNames.Values)
                category += " - "+val;
            string timesDisplay = string.Concat("Trackmania - ", category, Environment.NewLine, Environment.NewLine,
                                                "   Sum   ", separator, " Segment ", separator, "  Track", Environment.NewLine);
            int cumulatedTime = 0;
            foreach(KeyValuePair<string, int> kvp in vars.logTimes) {
                cumulatedTime += kvp.Value;
                timesDisplay += string.Concat(vars.FormatTime(cumulatedTime, false), separator, vars.FormatTime(kvp.Value, false), separator, kvp.Key, Environment.NewLine);
            }
            string base36Chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            long minutesDateTime = (long)(DateTime.Now - new DateTime(2020, 07, 01)).TotalMinutes;
            string base36DateTime = "";
            while(minutesDateTime > 0) {
                base36DateTime = base36Chars[(int)(minutesDateTime % 36)] + base36DateTime;
                minutesDateTime /= 36;
            }
            string path = string.Concat(Directory.GetCurrentDirectory(), "\\TrackmaniaTimes\\",
                                        category, "_", base36DateTime.PadLeft(5, '_'), "_", vars.FormatTime(cumulatedTime, true), ".log");
            string directoryName = Path.GetDirectoryName(path);
            if(!Directory.Exists(directoryName))
                Directory.CreateDirectory(directoryName);
            File.AppendAllText(path, timesDisplay);
        }
    });
    timer.OnSplit += vars.timerLogTimes;

    vars.GetTrackNumber = (Func<string>)(() => vars.loadMap.Substring(vars.loadMap.Length-2));

    vars.IsRGBHex = (Func<char, bool>)((c) => (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));

    vars.FormatTime = (Func<int, bool, string>)((time, file) => TimeSpan.FromMilliseconds(time).ToString(file ? @"mm\.ss\.fff" : @"mm\:ss\.fff"));

    vars.SetLogTimes = (Action<int, string>)((time, detail) => {
        vars.totalGameTime += time;
        int logNb = 1;
        while(true) {
            string timeEntry = vars.loadMap + (logNb == 1 && String.IsNullOrEmpty(detail) ? "" : " ("+detail+logNb+")");
            if(!vars.logTimes.ContainsKey(timeEntry)) {
                vars.logTimes.Add(timeEntry, time);
                break;
            }
            ++logNb;
        }
    });
}

init {
    vars.GetAbsoluteAddress = (Func<IntPtr, IntPtr>)((ptr) => ptr+game.ReadValue<int>(ptr-0x4));

    vars.ReadLoadMap = (Func<IntPtr, string>)((ptr) => {
        byte[] buffer = new byte[32];
        List<byte> stringBytes = new List<byte>(buffer.Length);
        int offset = 0;
        UIntPtr readLength;
        while(WinAPI.ReadProcessMemory(game.Handle, ptr + offset, buffer, (UIntPtr)buffer.Length, out readLength) && (int)readLength == buffer.Length) {
            int o = 0;
            while(o < buffer.Length) {
                char c = (char)buffer[o];
                if(c == '\0') {
                    return Encoding.UTF8.GetString(stringBytes.ToArray(), 0, stringBytes.Count-1);
                } else if(c == '$') {
                    if(o+3 >= buffer.Length) {
                        break;
                    } else if(vars.IsRGBHex((char)buffer[o+1]) && vars.IsRGBHex((char)buffer[o+2]) && vars.IsRGBHex((char)buffer[o+3])) {
                        o += 4;
                    } else {
                        o += 2;
                    }
                    continue;
                } else {
                    stringBytes.Add(buffer[o]);
                    o += 1;
                }
            }
            offset += o;
        }
        return "";
    });

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
                IntPtr trackData = vars.GetAbsoluteAddress(trackDataPtr);
                vars.watchers = new MemoryWatcherList() {
                    (vars.gameTime = new MemoryWatcher<int>(vars.GetAbsoluteAddress(gameTimePtr))),
                    (vars.loadMapPtr = new MemoryWatcher<IntPtr>(vars.GetAbsoluteAddress(loadMapPtr))),
                    (vars.raceData = new MemoryWatcher<IntPtr>(new DeepPointer(trackData, 0xE70, 0xCD8, 0x148, 0x0, 0x32C0, 0x488)) { FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull }),
                };
                vars.checkpoint = new MemoryWatcher<int>(new DeepPointer(trackData, 0xE70, 0xD88, 0x70, 0x690, 0x0, 0x718));
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

    vars.loadMap = vars.ReadLoadMap(vars.loadMapPtr.Current+0x9);

    if(vars.gameTime.Old == 0 && vars.gameTime.Current > 0) {
        vars.inRace = true;
    } else if(vars.gameTime.Current < vars.gameTime.Old) {
        if(vars.inRace && vars.startMap != vars.loadMap) {
            vars.SetLogTimes(vars.gameTime.Old, "Reset ");
        }
        vars.inRace = false;
    }

    if(vars.raceData.Current != IntPtr.Zero) {
        vars.checkpoint.Update(game);
        
        vars.raceTimeOld = vars.raceTimeNew;
        vars.raceTimeNew = game.ReadValue<int>((IntPtr)vars.raceData.Current+0x4);
        vars.isFinished = game.ReadValue<bool>((IntPtr)vars.raceData.Current+0x14);

        if(vars.raceTimeOld != vars.raceTimeNew && vars.isFinished) {
            vars.inRace = false;
            vars.SetLogTimes(vars.raceTimeNew, "");
        }
    }
}

start {
    return vars.gameTime.Old == 0 && vars.gameTime.Current > 0 && (vars.GetTrackNumber() == "01" || settings["cStart"]);
}

split {
    if(vars.raceTimeOld != vars.raceTimeNew && (vars.lastCP.Item1 != vars.loadMap || vars.lastCP.Item2 < vars.checkpoint.Current)) {
        vars.lastCP = Tuple.Create(vars.loadMap, vars.checkpoint.Current);
        if(vars.isFinished) {
            if(settings["track"]) {
                return true;
            } else {
                string map = vars.loadMap;
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
    return vars.gameTime.Current == 0 && vars.startMap == vars.loadMap;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromMilliseconds(vars.totalGameTime+(vars.inRace ? vars.gameTime.Current : 0));
}

exit {
    vars.tokenSource.Cancel();
}

shutdown {
    vars.tokenSource.Cancel();
    timer.OnStart -= vars.timerResetVars;
    timer.OnSplit -= vars.timerLogTimes;
}
