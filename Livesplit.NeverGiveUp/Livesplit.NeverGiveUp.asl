state("NeverGiveUp") {}

startup {
    refreshRate = 0.5;

    settings.Add("area", false, "Split at each Area");
    settings.Add("level", true, "Split at each Level");
    settings.Add("set", false, "Split at each Set");
    settings.Add("ilMode", false, "Individual Level Mode");

    settings.Add("custom", false, "Custom Splits");

    settings.CurrentDefaultParent = "custom";
    settings.Add("a1", true, "The Warehouse");
    settings.Add("a3", true, "City");
    settings.Add("a2", true, "Dark Forest");
    settings.Add("a5", true, "Crystal Caverns");
    settings.Add("a4", true, "Lava");
    settings.Add("a6", true, "Source Code");

    settings.CurrentDefaultParent = "a1";
    settings.Add("l1_1", true, "Laboratory");
    settings.Add("l1_2", true, "Emergency Exit");
    settings.Add("l1_3", true, "Basement");
    settings.Add("l1_4", true, "Assembly Line");
    settings.Add("l1_Boss", true, "Boss");
    settings.Add("l1_5", true, "Spike Spire");

    settings.CurrentDefaultParent = "a3";
    settings.Add("l3_1", true, "Skyline");
    settings.Add("l3_2", true, "Trash Town");
    settings.Add("l3_3", true, "Highrise");
    settings.Add("l3_4", true, "Rooftops");
    settings.Add("l3_Boss", true, "Boss");
    settings.Add("l3_5", true, "Penthouse");

    settings.CurrentDefaultParent = "a2";
    settings.Add("l2_1", true, "Roundabout");
    settings.Add("l2_2", true, "Inti's Revenge");
    settings.Add("l2_3", true, "Greenwood");
    settings.Add("l2_4", true, "Frog Prince");
    settings.Add("l2_Boss", true, "Boss");
    settings.Add("l2_5", true, "Feral Thicket");

    settings.CurrentDefaultParent = "a5";
    settings.Add("l5_1", true, "Spelunking");
    settings.Add("l5_2", true, "Waterfalls");
    settings.Add("l5_3", true, "Crablantis");
    settings.Add("l5_4", true, "Dank Chasm");
    settings.Add("l5_Boss", true, "Boss");
    settings.Add("l5_5", true, "Coral Cove");

    settings.CurrentDefaultParent = "a4";
    settings.Add("l4_1", true, "Magma Rush");
    settings.Add("l4_2", true, "Mineshafts");
    settings.Add("l4_3", true, "Scorchland");
    settings.Add("l4_4", true, "Furnace");
    settings.Add("l4_Boss", true, "Boss");
    settings.Add("l4_5", true, "Molten Mountain");

    settings.CurrentDefaultParent = "a6";
    settings.Add("l6_1", true, "White Rabbit");
    settings.Add("l6_2", true, "Algorithm");
    settings.Add("l6_3", true, "For_Loop");
    settings.Add("l6_4", true, "Hard Coded");
    settings.Add("l6_Boss", true, "Boss");
    settings.Add("l6_5", true, "FATAL_ERROR");

    vars.setCount = new byte[][] {
        new byte[] {7, 6, 5, 6, 4},
        new byte[] {6, 6, 5, 5, 4},
        new byte[] {7, 5, 5, 6, 4},
        new byte[] {5, 5, 5, 5, 4},
        new byte[] {5, 5, 5, 5, 5},
        new byte[] {5, 5, 5, 5, 5}
    };

    for(byte areaId = 0; areaId < vars.setCount.Length; areaId++) {
        byte[] area = vars.setCount[areaId];
        for(byte levelSetId = 0; levelSetId < area.Length; levelSetId++) {
            string levelSetting = (areaId+1)+"_"+(levelSetId+1);
            byte levelSet = area[levelSetId];
            for(byte setId = 0; setId < levelSet; setId++)
                settings.Add("s"+levelSetting+"_"+setId, true, "Set "+(setId+1), "l"+levelSetting);
        }       
    }

    vars.saveDataTarget = new SigScanTarget(9, "48 81 EC 80 00 00 00 48 B8 ?? ?? ?? ?? ?? ?? ?? ?? C7 00 FF FF FF FF");
    vars.gameTarget = new SigScanTarget(6, "48 83 EC 30 48 B8 ?? ?? ?? ?? ?? ?? ?? ?? C7 00 01 00 00 00");
    vars.levelsTarget = new SigScanTarget(6, "48 83 EC 08 48 B8 ?? ?? ?? ?? ?? ?? ?? ?? C7 00 05 00 00 00");
}

init {
    bool instructionsFound = false;
    vars.saveData = IntPtr.Zero;
    vars.game = IntPtr.Zero;
    vars.levels = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(vars.saveData == IntPtr.Zero && (vars.saveData = scanner.Scan(vars.saveDataTarget)) != IntPtr.Zero)
            print("[Autosplitter] SaveData Found : " + vars.saveData.ToString("X"));

        if(vars.game == IntPtr.Zero && (vars.game = scanner.Scan(vars.gameTarget)) != IntPtr.Zero)
            print("[Autosplitter] Game Found : " + vars.game.ToString("X"));

        if(vars.levels == IntPtr.Zero && (vars.levels = scanner.Scan(vars.levelsTarget)) != IntPtr.Zero)
            print("[Autosplitter] Levels Found : " + vars.levels.ToString("X"));

        instructionsFound = vars.saveData != IntPtr.Zero && vars.game != IntPtr.Zero && vars.levels != IntPtr.Zero;
        if(instructionsFound)
            break;
    }

    if (!instructionsFound)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.saveData = game.ReadPointer((IntPtr)vars.saveData);
    vars.game = game.ReadPointer((IntPtr)vars.game)-0x4;
    vars.levels = game.ReadPointer((IntPtr)vars.levels);

    vars.curGameTime = vars.curExitTimer = 0;

    refreshRate = 200/3d;
}

update {
    vars.oldGameTime = vars.curGameTime;
    if(settings["ilMode"])
        vars.curGameTime = game.ReadValue<int>((IntPtr)vars.game+0x38);
    else
        vars.curGameTime = game.ReadValue<int>((IntPtr)vars.saveData+0x184);

    vars.gaveUp = game.ReadValue<bool>((IntPtr)vars.game+0x8);
    vars.oldExitTimer = vars.curExitTimer;
    vars.curExitTimer = game.ReadValue<int>((IntPtr)vars.game+0x34);
    vars.level = game.ReadValue<int>((IntPtr)vars.game+0x9C);
    vars.isBoss = game.ReadValue<bool>((IntPtr)vars.game+0x170);
    
    vars.numLevels = game.ReadValue<int>((IntPtr)vars.levels);
    vars.area = game.ReadValue<int>((IntPtr)vars.levels+0x4);
    vars.levelSet = game.ReadValue<int>((IntPtr)vars.levels+0x8);
}

start {
    return vars.oldGameTime != vars.curGameTime && vars.oldGameTime == 0 && vars.curGameTime < 1000;
}

split {
    if(vars.oldExitTimer == 0 && vars.curExitTimer != 0) {
        if(vars.isBoss)
            return settings["set"] || settings["level"] || settings["area"] || settings["l"+vars.area+"_Boss"];
        else if(vars.gaveUp || vars.level >= vars.numLevels)
            return settings["set"] || settings["level"];
        else
            return settings["set"] || settings["s"+vars.area+"_"+vars.levelSet+"_"+vars.level];
    }
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromMilliseconds(vars.curGameTime);
}