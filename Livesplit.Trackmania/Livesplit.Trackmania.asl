state("Trackmania") {}

startup {
    settings.Add("cInject", false, "Use advanced splitter support (experimental)");
    
    settings.Add("cStart", false, "Auto-start on every track");

    settings.Add("track", true, "Split at every track done");

    settings.Add("cTraining", false, "Training individual splits (overridden by \"all tracks\" settings)");
    settings.Add("cSeason", false, "Season individual splits (overridden by \"all tracks\" settings)");

    for(int trackId = 1; trackId < 26; trackId++) {
        string trackNb = trackId.ToString("D2");
        settings.Add("t"+trackNb, true, "Training - "+trackNb, "cTraining");
        settings.Add("s"+trackNb, true, "Season - "+trackNb, "cSeason");
    }

    vars.raceTimeSig = new byte[] { 0x41, 0x0F, 0x11, 0x01, 0xF2, 0x41, 0x0F, 0x11, 0x49, 0x10, 0x41, 0x89, 0x41, 0x18 };

    vars.injectionMode = false;
    vars.wasInjectionMode = false;
    vars.injectPtr = IntPtr.Zero;

    vars.inRace = false;

    vars.loadMap = "";
    vars.raceTimeNew = 0;
    vars.isFinishedNew = false;

    vars.ResetVars = (Action)(() => {
        vars.startMap = vars.loadMap;
        vars.totalGameTime = 0;
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
            foreach(string val in timer.Run.Metadata.VariableValueNames.Values) {
                category += " - "+val;
            }
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
            if(!Directory.Exists(directoryName)) {
                Directory.CreateDirectory(directoryName);
            }
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

    vars.StartThreadScan = (Action)(() => {
        vars.threadScanInject = new Thread((ParameterizedThreadStart)vars.ScanGame);
        vars.threadScanInject.Start(vars.injectionMode);
    });

    vars.ScanGame = (ParameterizedThreadStart)((needInjection) => {
        var gameTimeTarget = new SigScanTarget(0x10, "C3 CC CC CC CC CC CC CC CC CC 89 0D");
        var loadMapTarget = new SigScanTarget(0xC, "7F 23 45 33 C0");

        SigScanTarget raceTimeTarget;
        if((bool)needInjection) {
            raceTimeTarget = new SigScanTarget(0x0, vars.raceTimeSig);
        } else {
            raceTimeTarget = new SigScanTarget(0x0, "48 8B 83 ?? ?? ?? ?? C7 44 24 ?? ?? ?? ?? ?? 48 89");
        }
        
        IntPtr gameTimePtr = IntPtr.Zero;
        IntPtr loadMapPtr = IntPtr.Zero;

        vars.raceTimePtr = IntPtr.Zero;

        var module = modules.First(m => m.ModuleName == "Trackmania.exe");

        while(!vars.token.IsCancellationRequested) {
            print("[Autosplitter] Scanning memory");
        
            var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);

            if((gameTimePtr = scanner.Scan(gameTimeTarget)) != IntPtr.Zero) {
                print("[Autosplitter] GameTime Found : " + gameTimePtr.ToString("X"));
            }
            if((loadMapPtr = scanner.Scan(loadMapTarget)) != IntPtr.Zero) {
                print("[Autosplitter] Load Map Found : " + loadMapPtr.ToString("X"));
            }
            if((vars.raceTimePtr = scanner.Scan(raceTimeTarget)) != IntPtr.Zero) {
                print("[Autosplitter] Race Time Found : " + vars.raceTimePtr.ToString("X"));
            }

            if(gameTimePtr != IntPtr.Zero && loadMapPtr != IntPtr.Zero && vars.raceTimePtr != IntPtr.Zero) {
                if((bool)needInjection) {
                    int timeStart = (int)(DateTime.Now - game.StartTime).TotalMilliseconds;
                    if(timeStart < 10000) {
                        Thread.Sleep(10000 - timeStart);
                    }
                    game.Suspend();

                    vars.injectPtr = game.AllocateMemory(64);
                    print("[Autosplitter] Trampoline : " + vars.injectPtr.ToString("X"));

                    byte[] jmpArr = BitConverter.GetBytes((long)vars.injectPtr);
                    byte[] retArr = BitConverter.GetBytes((long)vars.raceTimePtr+0xD);

                    game.WriteBytes((IntPtr)vars.raceTimePtr,
                        new byte[] {         0x57,                          // push rdi
                                             0x48, 0xBF }.Concat(jmpArr)    // mov rdi, jumpArr
                        .Concat(new byte[] { 0xFF, 0xE7,                    // jmp rdi
                                             0x5F })                        // pop rdi
                        .ToArray()
                    );

                    game.WriteBytes((IntPtr)vars.injectPtr,
                            new byte[] {         0x5F }                                             // pop rdi
                            .Concat((byte[])vars.raceTimeSig)                                       // (add sig)
                            .Concat(new byte[] { 0x48, 0x89, 0x35, 0x0D, 0x00, 0x00, 0x00,          // mov [rip+0D], rsi
                                                 0x57,                                              // push rdi
                                                 0x48, 0xBF }).Concat(retArr)                       // mov rdi, retArr
                            .Concat(new byte[] { 0xFF, 0xE7,                                        // jmp rdi
                                                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 })  // (pointer memory)
                            .ToArray()
                    );
                    
                    game.Resume();

                    IntPtr raceTime = vars.injectPtr+0x23;
                    vars.raceData = new MemoryWatcher<IntPtr>(new DeepPointer(raceTime, 0x0));
                } else {
                    vars.raceData = new MemoryWatcher<IntPtr>(new DeepPointer(vars.GetAbsoluteAddress(vars.raceTimePtr), 0xE70, 0xCD8, 0x148, 0x0, 0x32C0, 0x488));
                }

                vars.watchers = new MemoryWatcherList() {
                    (vars.gameTime = new MemoryWatcher<int>(vars.GetAbsoluteAddress(gameTimePtr))),
                    (vars.loadMapPtr = new MemoryWatcher<IntPtr>(vars.GetAbsoluteAddress(loadMapPtr))),
                    vars.raceData
                };
                    
                print("[Autosplitter] Done scanning");
                break;
            }
            Thread.Sleep(2000);
        }
        print("[Autosplitter] Exit thread scan");
    });

    vars.RemoveInject = (Action)(() => {
        print("[Autosplitter] Remove injection");
        game.Suspend();
        game.WriteBytes((IntPtr)vars.raceTimePtr, (byte[])vars.raceTimeSig);
        game.FreeMemory((IntPtr)vars.injectPtr);
        game.Resume();
    });

    vars.injectionMode = settings["cInject"];

    vars.tokenSource = new CancellationTokenSource();
    vars.token = vars.tokenSource.Token;

    vars.StartThreadScan();
}

update {
    vars.wasInjectionMode = vars.injectionMode;
    vars.injectionMode = settings["cInject"];

    if(vars.threadScanInject.IsAlive) {
        return false;
    }

    if(vars.injectionMode != vars.wasInjectionMode) {
        if(!vars.injectionMode) {
            vars.RemoveInject();
        }
        vars.StartThreadScan();
        return false;
    }

    vars.watchers.UpdateAll(game);

    vars.loadMap = vars.ReadLoadMap(vars.loadMapPtr.Current+0x9);

    vars.raceTimeOld = vars.raceTimeNew;
    vars.raceTimeNew = game.ReadValue<int>((IntPtr)vars.raceData.Current + 0x4);

    vars.isFinishedOld = vars.isFinishedNew;
    vars.isFinishedNew = game.ReadValue<bool>((IntPtr)vars.raceData.Current + 0x14);

    if(vars.gameTime.Old == 0 && vars.gameTime.Current > 0) {
        vars.inRace = true;
    } else if(vars.gameTime.Old > vars.gameTime.Current) {
        if(vars.inRace && vars.startMap != vars.loadMap) {
            vars.SetLogTimes(vars.gameTime.Old, "Reset ");
        }
        vars.inRace = false;
    }

    if(vars.raceTimeOld != vars.raceTimeNew && vars.isFinishedNew) {
        vars.inRace = false;
        vars.SetLogTimes(vars.raceTimeNew, "");
    }
}

start {
    return vars.gameTime.Old == 0 && vars.gameTime.Current > 0 && (vars.GetTrackNumber() == "01" || settings["cStart"]);
}

split {
    if(!vars.isFinishedOld && vars.isFinishedNew) {
        if(settings["track"]) {
            return true;
        } else {
            string map = vars.loadMap;
            if(settings["cTraining"] && map.StartsWith("Training")) {
                return settings["t"+vars.GetTrackNumber()];
            }                
            if(settings["cSeason"] && (map.StartsWith("Winter") || map.StartsWith("Spring") || map.StartsWith("Summer") || map.StartsWith("Fall"))) {
                return settings["s"+vars.GetTrackNumber()];
            }
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
    return TimeSpan.FromMilliseconds(vars.totalGameTime + (vars.inRace ? vars.gameTime.Current : 0));
}

exit {
    vars.tokenSource.Cancel();

    if(vars.injectionMode) {
        vars.RemoveInject();
    }
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
    timer.OnSplit -= vars.timerLogTimes;
    
    if(((IDictionary<string, Object>)vars).ContainsKey("tokenSource")) {
        vars.tokenSource.Cancel();
    }
    if(vars.injectionMode && ((IDictionary<string, Object>)vars).ContainsKey("RemoveInject")) {
        vars.RemoveInject();
    }
}