state("ScourgeBringer") {}

startup {
    refreshRate = 0.5;

    settings.Add("realm", true, "Split at every realm");
    settings.Add("realmCustom", false, "Custom Realm Split");
    settings.Add("realmAlt", false, "Split alternative at level change instead of portal trigger");
    
    settings.CurrentDefaultParent = "realmCustom";
    settings.Add("realm0", false, "The Entangled Ingress");
    // 1 Hub
    settings.Add("realm2", false, "The Still Bastion");
    settings.Add("realm3", false, "The Wasted Pit");
    // 4 Tuto
    // settings.Add("realm5", true, "Realm 4");
    // settings.Add("realm6", true, "Realm 5");
    // settings.Add("realm7", true, "Realm 6");
    
    vars.scanGameStates = new SigScanTarget(0x17, "90 48 B9 ?? ?? ?? ?? ?? ?? ?? ?? BA 5F 01 00 00");

    vars.scanWorldManager = new SigScanTarget(0x3, "90 48 B9 ?? ?? ?? ?? ?? ?? ?? ?? 48 83 39 00 0F 94 C1");
}

init {
    IntPtr ptrGameStates = IntPtr.Zero;
    IntPtr ptrWorldManager = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        if((long)page.BaseAddress < (long)modules.First().BaseAddress) continue;

        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(ptrGameStates == IntPtr.Zero && (ptrGameStates = scanner.Scan(vars.scanGameStates)) != IntPtr.Zero)
            print("[Autosplitter] GameStates Found : " + ptrGameStates.ToString("X"));

        if(ptrWorldManager == IntPtr.Zero) {
            foreach (IntPtr ptr in scanner.ScanAll(vars.scanWorldManager)) {
                IntPtr specialPromptY = game.ReadPointer(game.ReadPointer(game.ReadPointer(ptr))+0x28);
                if(game.ReadValue<int>(specialPromptY+0x08) !=  4 ||
                   game.ReadValue<int>(specialPromptY+0x10) != -2 ||
                   game.ReadValue<int>(specialPromptY+0x14) != -1 ||
                   game.ReadValue<int>(specialPromptY+0x18) !=  2 ||
                   game.ReadValue<int>(specialPromptY+0x1C) !=  1)
                    continue;

                ptrWorldManager = ptr;
                print("[Autosplitter] WorldManager Found : " + ptrWorldManager.ToString("X"));
                break;
            }
        }

        if(ptrGameStates != IntPtr.Zero && ptrWorldManager != IntPtr.Zero)
            break;
    }

    if(ptrGameStates == IntPtr.Zero || ptrWorldManager == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.watchers = new MemoryWatcherList() {
        (vars.gameStatePtr = new MemoryWatcher<IntPtr>(new DeepPointer(ptrGameStates, 0x0))),
        (vars.playerHP = new MemoryWatcher<int>(new DeepPointer(ptrGameStates, 0x0, 0x18))),
        (vars.tileset = new MemoryWatcher<int>(new DeepPointer(ptrGameStates, 0x0, 0x6C))),
        (vars.gameTime = new MemoryWatcher<float>(new DeepPointer(ptrGameStates, 0x0, 0x70))),

        (vars.worldManagerPtr = new MemoryWatcher<IntPtr>(new DeepPointer(ptrWorldManager, 0x0))),
        (vars.toNextLevel = new MemoryWatcher<bool>(new DeepPointer(ptrWorldManager, 0x0, 0x11A)))
    };

    refreshRate = 200/3d;
}

start {
    return vars.gameTime.Changed && vars.gameTime.Old < 0.1 && vars.gameTime.Current < 0.1;
}

update {
    vars.watchers.UpdateAll(game);
}

split {
    if(settings["worldAlt"])
        return vars.tileset.Changed && (settings["world"] || settings["realm"+vars.tileset.Old]);
    else
        return !vars.toNextLevel.Old && vars.toNextLevel.Current && (settings["world"] || settings["realm"+vars.tileset.Current]);
}

reset {
    return vars.playerHP.Changed && vars.playerHP.Current == 0;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromSeconds(vars.gameTime.Current == 0 ? vars.gameTime.Old : vars.gameTime.Current);
}