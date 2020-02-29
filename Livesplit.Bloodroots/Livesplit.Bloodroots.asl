state("Bloodroots") {}

startup {
    refreshRate = 0.5;

    settings.Add("act", false, "Split at each Act (3 splits)");
    settings.Add("level", true, "Split at each Level (24 splits)");
    settings.Add("room", false, "Split at each Room (129 splits)");
    settings.Add("custom", false, "Custom Splits");
    settings.Add("ILstart", false, "Auto-Start for Individual Levels");
    
    settings.CurrentDefaultParent = "custom";
    settings.Add("act1", false, "Act 1");
    settings.Add("act2", false, "Act 2");
    settings.Add("act3", false, "Act 3");

    settings.CurrentDefaultParent = "act1";
    settings.Add("Level_0_0", false, "Prologue"); //1
    settings.Add("Level_0_1", false, "1-1 A Monument To Excess"); //4
    settings.Add("Level_0_2", false, "1-2 Working Stiffs"); //5
    settings.Add("Level_0_3", false, "1-3 Party Crasher"); //7
    settings.Add("Level_0_4", false, "1-4 Huff And Puff"); //6
    settings.Add("Level_0_4_Arcade", false, "1-4b Bonus Level"); //1
    settings.Add("Level_0_5", false, "1-5 Catch Of The Day"); //8
    settings.Add("Boss_0_10", false, "1-6 A Pig In Shit"); //3

    settings.CurrentDefaultParent = "act2";
    settings.Add("Level_1_1", false, "2-1 Room For Desert"); //8
    settings.Add("Level_1_2", false, "2-2 Will There Be Blood?"); //8
    settings.Add("Level_1_2_Arcade", false, "2-2b Bonus Level"); //1
    settings.Add("Level_1_3", false, "2-3 Mineshaft"); //9
    settings.Add("Level_1_4", false, "2-4 Nobody's Vault"); //8
    settings.Add("Level_1_4_Arcade", false, "2-4b Bonus Level"); //1
    settings.Add("Level_1_5", false, "2-5 Road To Ruin"); //7
    settings.Add("Boss_1_10", false, "2-6 Proving Grounds"); //1

    settings.CurrentDefaultParent = "act3";
    settings.Add("Level_2_1", false, "3-1 Ice To See You"); //8
    settings.Add("Level_2_2", false, "3-2 Gold Rush"); //8
    settings.Add("Level_2_2_Arcade", false, "3-2b Bonus Level?"); //1
    settings.Add("Level_2_3", false, "3-3 Slumming It"); //7
    settings.Add("Level_2_3_Arcade", false, "3-3b Bonus Bonus Bonus Bonus!"); //1
    settings.Add("Level_2_4", false, "3-4 Burying The Lede"); //10
    settings.Add("Level_2_5", false, "3-5 Fortified"); //10
    settings.Add("Boss_2_10", false, "3-6 End Of An Era"); //3

    settings.Add("Level_3_0", false, "Epilogue"); //3
    for (int i = 1; i <= 3; i++) settings.Add("Level_3_0_"+i, false, (i == 3) ? "End" : "Room "+i, "Level_3_0"); 

    vars.roomSplits = new byte[][] {
        new byte[] {4, 5, 7, 6, 8, 3},
        new byte[] {8, 8, 9, 8, 7, 1},
        new byte[] {8, 8, 7,10,10, 3}
    };

    for (byte actId = 0; actId < vars.roomSplits.Length; actId++) {
        byte[] roomByLevel = vars.roomSplits[actId];
        for (byte levelId = 0; levelId < roomByLevel.Length; levelId++) {
            byte roomCount = roomByLevel[levelId];
            if(roomCount < 2) continue;
            for (byte roomId = 1; roomId <= roomCount; roomId++) {
                if(levelId != roomByLevel.Length-1) {
                    settings.Add("Level_"+actId+"_"+(levelId+1)+"_"+roomId, false, (roomId == roomCount) ? "Complete" : "Room "+roomId, "Level_"+actId+"_"+(levelId+1));
                } else {
                    settings.Add("Boss_"+actId+"_10_"+roomId, false, (roomId == roomCount) ? "Complete" : "Phase "+roomId, "Boss_"+actId+"_10");
                }
            }
        }
    }

    vars.levelManagerTarget = new SigScanTarget(0x5, "41 FF D3 49 BA ?? ?? ?? ?? ?? ?? ?? ?? 90 49 BB ?? ?? ?? ?? ?? ?? ?? ?? 41 FF D3 85 C0 74 24");
    vars.menuManagerTarget = new SigScanTarget(0x2, "48 B8 ?? ?? ?? ?? ?? ?? ?? ?? 48 89 30 48 8B CE 66 66 90 49 BB ?? ?? ?? ?? ?? ?? ?? ?? 41 FF D3 66 66 90");
}

init {
    IntPtr levelManagerPtr = IntPtr.Zero;
    IntPtr menuManagerPtr = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(levelManagerPtr == IntPtr.Zero && (levelManagerPtr = scanner.Scan(vars.levelManagerTarget)) != IntPtr.Zero)
            print("[Autosplitter] Level Manager Found : " + levelManagerPtr.ToString("X"));

        if(menuManagerPtr == IntPtr.Zero && (menuManagerPtr = scanner.Scan(vars.menuManagerTarget)) != IntPtr.Zero)
            print("[Autosplitter] Menu Manager Found : " + menuManagerPtr.ToString("X"));

        if(levelManagerPtr != IntPtr.Zero && menuManagerPtr != IntPtr.Zero)
            break;
    }

    if(levelManagerPtr == IntPtr.Zero || menuManagerPtr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.levelManager = new MemoryWatcher<IntPtr>(new DeepPointer(levelManagerPtr, 0x38, 0x10, 0x38, 0x8, 0x0));
    vars.isPanelForced = new MemoryWatcher<bool>(new DeepPointer(menuManagerPtr, 0x0, 0x20, 0xD4));

    vars.watchers = new MemoryWatcherList() {
        (vars.levelName = new StringWatcher(new DeepPointer(levelManagerPtr, 0x38, 0x10, 0x38, 0x8, 0x0, 0x20, 0x14), 32)),
        (vars.roomId = new MemoryWatcher<int>(new DeepPointer(levelManagerPtr, 0x38, 0x10, 0x38, 0x8, 0x0, 0x80))),
        (vars.time = new MemoryWatcher<float>(new DeepPointer(levelManagerPtr, 0x38, 0x10, 0x38, 0x8, 0x0, 0xAC))),
        (vars.levelComplete = new MemoryWatcher<bool>(new DeepPointer(levelManagerPtr, 0x38, 0x10, 0x38, 0x8, 0x0, 0xDC)))
    };

    vars.ResetVars = (EventHandler)((s, e) => {
        vars.totalGameTime = 0;
    });
    timer.OnStart += vars.ResetVars;

    vars.totalGameTime = 0;

    refreshRate = 200/3d;
}

update {
    vars.watchers.UpdateAll(game);
}

start {
    return vars.time.Old == 0 && vars.time.Current > 0 && ("Level_0_0".Equals(vars.levelName.Current) || (settings["ILstart"] && vars.levelName.Current[0] != 'H'));
}

split {
    if(!vars.levelComplete.Old && vars.levelComplete.Current) {
        return settings["level"] || settings["room"]
            || (settings["act"] && vars.levelName.Current[0] == 'B' && vars.levelName.Current[5] != '2')
            || settings[vars.levelName.Current+(vars.roomId.Current < 1 ? "" : "_"+(vars.roomId.Current+1))];
    }

    if(vars.roomId.Old < vars.roomId.Current && vars.roomId.Current > 0) {
        return settings["room"] || settings[vars.levelName.Current+"_"+vars.roomId.Current];
    }

    if(vars.roomId.Current == 2 && "Level_3_0".Equals(vars.levelName.Current)) {
        vars.isPanelForced.Update(game);
        if(!vars.isPanelForced.Old && vars.isPanelForced.Current)
            return settings["act"] || settings["level"] || settings["room"] || settings["Level_3_0_3"];
    }

    if(vars.levelName.Changed && "Level_0_0".Equals(vars.levelName.Old) && "Hub_0_0".Equals(vars.levelName.Current)) {
        return settings["level"] || settings["room"] || settings["Level_0_0"];
    }
}

reset {
    vars.levelManager.Update(game);
    return vars.levelManager.Old == IntPtr.Zero && vars.levelManager.Current != IntPtr.Zero && "Level_0_0".Equals(vars.levelName.Current);
}

isLoading {
    return true;
}

gameTime {
    if(vars.time.Old != 0 && vars.time.Current == 0)
        vars.totalGameTime += vars.time.Old;
    return TimeSpan.FromSeconds(vars.totalGameTime + vars.time.Current);
}

shutdown {
    timer.OnStart -= vars.ResetVars;
}