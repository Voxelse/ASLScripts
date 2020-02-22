state("IceAge") {}

startup {
    refreshRate = 0.5;

    settings.Add("path1", true, "Path 1");
    settings.Add("path2", true, "Path 2");
    settings.Add("path3", true, "Path 3");
    settings.Add("path4", true, "Path 4");

    settings.CurrentDefaultParent = "path1";
    settings.Add("hub2", false, "Hub to \"The Woodland Valley\"");
    settings.Add("sec2_1", false, "Complete \"The Woodland Valley\"");
    settings.Add("sec2_2", false, "Complete \"The Cascading Falls\"");
    settings.Add("sec2_3", false, "Complete \"The Glacier River\"");
    settings.Add("sec2_4", false, "Complete \"The Ancient Ice Cliff\"");
    settings.Add("sec2_5", true, "Complete Autoscroller");
    
    settings.CurrentDefaultParent = "path2";
    settings.Add("hub3", false, "Hub to \"The Endless Lake\"");
    settings.Add("sec3_1", false, "Complete \"The Endless Lake\"");
    settings.Add("sec3_2", false, "Complete \"The Ice Mountain\"");
    settings.Add("sec3_3", false, "Complete \"The Bleak Canyon\"");
    settings.Add("sec3_4", false, "Complete \"The Frozen Dam\"");
    settings.Add("sec3_5", true, "Complete Autoscroller");
    
    settings.CurrentDefaultParent = "path3";
    settings.Add("hub4", false, "Hub to \"The Gem Tunnels\"");
    settings.Add("sec4_1", false, "Complete \"The Gem Tunnels\"");
    settings.Add("sec4_2", false, "Complete \"The Scratazon Caverns\"");
    settings.Add("sec4_3", false, "Complete \"The Icebound Gallery\"");
    settings.Add("sec4_4", false, "Complete \"The Crystal Mine\"");
    settings.Add("sec4_5", true, "Complete Autoscroller");
    
    settings.CurrentDefaultParent = "path4";
    settings.Add("hub5", false, "Hub to \"The Hidden Jungle\"");
    settings.Add("sec5_1", false, "Complete \"The Hidden Jungle\"");
    settings.Add("sec5_2", false, "Complete \"The Lost Oasis\"");
    settings.Add("sec5_3", false, "Complete \"The Fiery Peak\"");
    settings.Add("sec5_4", true, "Complete \"The Magma Ruins\"");

    vars.gameTarget = new SigScanTarget(0x27, "55 8B EC 83 EC 28 C7 44 24 08 06 00 00 00");
    vars.appletTarget = new SigScanTarget(0x8, "55 8B EC 83 EC 08 8B 05 ?? ?? ?? ?? 39 00 C7");
}

init {
    IntPtr gamePtr = IntPtr.Zero;
    IntPtr appletPtr = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(gamePtr == IntPtr.Zero && (gamePtr = scanner.Scan(vars.gameTarget)) != IntPtr.Zero)
            print("[Autosplitter] Game Found : " + gamePtr.ToString("X"));

        if(appletPtr == IntPtr.Zero && (appletPtr = scanner.Scan(vars.appletTarget)) != IntPtr.Zero)
            print("[Autosplitter] Applet Found : " + appletPtr.ToString("X"));

        if(gamePtr != IntPtr.Zero && appletPtr != IntPtr.Zero)
            break;
    }

    if(gamePtr == IntPtr.Zero || appletPtr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    gamePtr = game.ReadPointer((IntPtr)gamePtr)-0x14;

    vars.visitedLevels = new MemoryWatcher<int>(new DeepPointer(gamePtr+0x88));
    vars.sectionsCompleted = new MemoryWatcher<int>(new DeepPointer(gamePtr+0x14));

    vars.watchers = new MemoryWatcherList() {
        (vars.level = new MemoryWatcher<int>(new DeepPointer(appletPtr, 0x0, 0x80))),
        (vars.section = new MemoryWatcher<int>(new DeepPointer(appletPtr, 0x0, 0x84))),
        (vars.loading = new MemoryWatcher<bool>(new DeepPointer(appletPtr, 0x0, 0x88)))
    };

    vars.IsCurrentSectionCompleted = (Func<bool>)(() => {
        vars.sectionsCompleted.Update(game);
        return game.ReadValue<bool>((IntPtr)(vars.sectionsCompleted.Current+0x10+vars.level.Current*0x6+vars.section.Current));
    });

    vars.ResetVars = (EventHandler)((s, e) => {
        vars.splits = new HashSet<int>();
    });
    timer.OnStart += vars.ResetVars;

    vars.splits = new HashSet<int>();

    refreshRate = 200/3d;
}

update {
    vars.watchers.UpdateAll(game);
}

start {
    vars.visitedLevels.Upate(game);
    return vars.visitedLevels.Changed && vars.visitedLevels.Current == 0;
}

split {
    if(((vars.level.Current > 1 && vars.section.Current == 5) || (vars.level.Current == 5 && vars.section.Current == 4)) && vars.IsCurrentSectionCompleted())
        return vars.splits.Add(vars.level.Current*6+vars.section.Current) && settings["sec"+vars.level.Current+"_"+vars.section.Current];

    if(!vars.section.Changed) return false;

    if(vars.level.Old == 1 && vars.section.Old == 0 && vars.level.Changed && vars.section.Current == 1)
        return vars.splits.Add(vars.level.Current*6) && settings["hub"+vars.level.Current];

    if(!vars.level.Changed && vars.section.Old < vars.section.Current)
        return vars.splits.Add(vars.level.Old*6+vars.section.Old) && settings["sec"+vars.level.Old+"_"+vars.section.Old];
}

reset {
    return vars.level.Changed && vars.level.Current == 0;
}

isLoading {
    return vars.loading.Current;
}


shutdown {
    timer.OnStart -= vars.ResetVars;
}