state ("Flinthook") {}

startup {
    settings.Add("s", true, "Split at each ship");

    settings.Add("1", true, "Bad Billy Bullseye");
    for (int s = 1; s < 4; s++) settings.Add("1_"+s, false, "Ship "+s, "1");
    settings.Add("1_4", true, "Boss", "1");

    settings.Add("2", true, "Goldfeathers");
    for (int s = 1; s < 5; s++) settings.Add("2_"+s, false, "Ship "+s, "2");
    settings.Add("2_5", true, "Boss", "2");

    settings.Add("3", true, "Baron Von Guu");
    for (int s = 1; s < 6; s++) settings.Add("3_"+s, false, "Ship "+s, "3");
    settings.Add("3_6", true, "Boss", "3");

    settings.Add("4", true, "Gwarlock");
    for (int s = 1; s < 4; s++) settings.Add("4_"+s, false, "Ship "+s, "4");
    settings.Add("4_4", true, "Bad Billy Bullseye", "4");
    for (int s = 5; s < 8; s++) settings.Add("4_"+s, false, "Ship "+s, "4");
    settings.Add("4_8", true, "Goldfeathers", "4");
    for (int s = 9; s < 12; s++) settings.Add("4_"+s, false, "Ship "+s, "4");
    settings.Add("4_12", true, "Baron Von Guu", "4");
    settings.Add("4_13", true, "Gwarlock", "4");

    vars.InitVars = (Action)(() => {
        vars.sumBountyTimes = 0;
        vars.trackTotalMissionTime = true;
    });

    vars.InitVars();

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.InitVars();
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    vars.threadScan = new Thread(() => {
        var gameInfoTarget = new SigScanTarget(6, "55 8B EC 56 83 3D ?? ?? ?? ?? 00 75 18");
        var totalMissionTimeTarget = new SigScanTarget(13, "55 8B EC 57 56 53 83 EC 10 8B F1 8B 0D");

        IntPtr gameInfoPtr = IntPtr.Zero;
        IntPtr contextInfoPtr = IntPtr.Zero;
    
        while(gameInfoPtr == IntPtr.Zero || contextInfoPtr == IntPtr.Zero) {
            print("[Autosplitter] Scanning memory");
            foreach (var page in game.MemoryPages()) {
                var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

                if(gameInfoPtr == IntPtr.Zero) {
                    IntPtr ptrGameInfoOrDropManager = scanner.Scan(gameInfoTarget);
                    if(ptrGameInfoOrDropManager != IntPtr.Zero && game.ReadValue<int>(game.ReadPointer(game.ReadPointer(ptrGameInfoOrDropManager))+0x14) != 1) {
                        gameInfoPtr = ptrGameInfoOrDropManager;
                        print("[Autosplitter] GameInfo Found : " + gameInfoPtr.ToString("X"));
                    }
                }

                if(contextInfoPtr == IntPtr.Zero && (contextInfoPtr = scanner.Scan(totalMissionTimeTarget)) != IntPtr.Zero)
                    print("[Autosplitter] ContextInfo Found : " + contextInfoPtr.ToString("X"));

                if(gameInfoPtr != IntPtr.Zero && contextInfoPtr != IntPtr.Zero)
                    break;
            }
            if (gameInfoPtr != IntPtr.Zero && contextInfoPtr != IntPtr.Zero) {
                int relGameInfoPtr = (int)((long)gameInfoPtr - (long)modules.First().BaseAddress);
                int relContextInfoPtr = (int)((long)contextInfoPtr - (long)modules.First().BaseAddress);

                vars.watchers = new MemoryWatcherList() {
                    (vars.runProgression = new MemoryWatcher<int>(new DeepPointer((int)relGameInfoPtr, 0x0, 0x6C))),
                    (vars.bountyType = new MemoryWatcher<int>(new DeepPointer((int)relGameInfoPtr, 0x0, 0x6C, 0x30))),
                    (vars.missionsCompleted = new MemoryWatcher<int>(new DeepPointer((int)relGameInfoPtr, 0x0, 0x6C, 0x34))),
                    (vars.totalBountyTime = new MemoryWatcher<float>(new DeepPointer((int)relGameInfoPtr, 0x0, 0x6C, 0x40))),
                    (vars.contextInfo = new MemoryWatcher<int>(new DeepPointer((int)relContextInfoPtr, 0x0, 0xC, 0x4, 0x8, 0x8))),
                    (vars.totalMissionTime = new MemoryWatcher<float>(new DeepPointer((int)relContextInfoPtr, 0x0, 0xC, 0x4, 0x8, 0x8, 0x58))),
                };
            } else {
                Thread.Sleep(2000);
            }
        }
        print("[Autosplitter] Done scanning");
    });
    vars.threadScan.Start();
}

update {
    if(!((IDictionary<string, Object>)vars).ContainsKey("watchers"))
        return false;

    vars.watchers.UpdateAll(game);
    
    if(vars.runProgression.Changed) return false;

    if(vars.totalBountyTime.Old < vars.totalBountyTime.Current) {
        vars.sumBountyTimes += vars.totalBountyTime.Current - vars.totalBountyTime.Old;
        vars.trackTotalMissionTime = false;
    }

    if(vars.totalMissionTime.Current < vars.totalMissionTime.Old)
        vars.trackTotalMissionTime = true;

    if(vars.contextInfo.Changed) return false;
}

start {
    return vars.totalMissionTime.Old == 0 && vars.totalMissionTime.Current > 0 && vars.totalBountyTime.Current == 0;
}

split {
    return vars.missionsCompleted.Old < vars.missionsCompleted.Current && (settings["s"] || settings[vars.bountyType.Current+"_"+vars.missionsCompleted.Current]);
}

reset {
    return vars.totalBountyTime.Old != 0 && vars.totalBountyTime.Current == 0;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromSeconds(vars.sumBountyTimes+(vars.trackTotalMissionTime ? vars.totalMissionTime.Current : 0));
}

shutdown {
    vars.threadScan.Abort();
    timer.OnStart -= vars.timerResetVars;
}