state("ScourgeBringer") {}

startup {
    refreshRate = 0.5;

    settings.Add("realm", true, "Split at every realm");
    settings.Add("realmCustom", false, "Custom Realm Split");
    
    settings.CurrentDefaultParent = "realmCustom";
    settings.Add("realm0", false, "The Entangled Ingress");
    // 1 Hub
    settings.Add("realm2", false, "The Still Bastion");
    settings.Add("realm3", false, "The Wasted Pit");
    // 4 Tuto
    settings.Add("realm5", false, "The Living Walls");
    // settings.Add("realm6", false, "Realm 5");
    // settings.Add("realm7", false, "Realm 6");
    
    vars.scanGameStates = new SigScanTarget(0x17, "90 48 B9 ?? ?? ?? ?? ?? ?? ?? ?? BA 68 01 00 00");
}

init {
    IntPtr ptrGameStates = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        if((long)page.BaseAddress < (long)modules.First().BaseAddress) continue;

        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(ptrGameStates == IntPtr.Zero && (ptrGameStates = scanner.Scan(vars.scanGameStates)) != IntPtr.Zero) {
            print("[Autosplitter] GameStates Found : " + ptrGameStates.ToString("X"));
            break;
        }
    }

    if(ptrGameStates == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.watchers = new MemoryWatcherList() {
        (vars.playerHP = new MemoryWatcher<int>(new DeepPointer(ptrGameStates, 0x0, 0x64))),
        (vars.tileset = new MemoryWatcher<int>(new DeepPointer(ptrGameStates, 0x0, 0xB8))),
        (vars.gameTime = new MemoryWatcher<float>(new DeepPointer(ptrGameStates, 0x0, 0xBC)))
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
    return vars.tileset.Changed && (settings["realm"] || settings["realm"+vars.tileset.Old]);
}

reset {
    return vars.playerHP.Old > 0 && vars.playerHP.Current == 0;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromSeconds(vars.gameTime.Current == 0 ? vars.gameTime.Old : vars.gameTime.Current);
}