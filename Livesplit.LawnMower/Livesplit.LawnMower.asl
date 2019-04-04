state("nestopia") {}
state("emuhawk") {}
state("fceux") {}

startup {
    refreshRate = 0.5;

    settings.Add("trSplit", false, "Stage Splits : transition instead of 100%");
    settings.Add("udEnd", false, "[Temporary] End Split : \"Well Done\" (UD rules) instead of 100% (SRC rules)");
    
    for(int lawn = 0; lawn <= 9; lawn++)
        settings.Add("lawn"+lawn, true, "Lawn "+(lawn>8?"":"0")+(lawn+1));
}

init {
    IntPtr ptr = IntPtr.Zero;

    SigScanTarget scanTarget = null;
    if (memory.ProcessName.ToLower().Contains("emuhawk"))
        scanTarget = new SigScanTarget(69, string.Concat("07", new String('?', 136), "0F 0B ?? ?? 0F 0B ?? ?? 0F 0B"));
    else
        scanTarget = new SigScanTarget(0, "0F 0B ?? ?? 0F 0B ?? ?? 0F 0B 1A 29 0F 0B 29 30 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F");

    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        if((ptr = scanner.Scan(scanTarget)) != IntPtr.Zero)
            break;
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.watchers = new MemoryWatcherList() {
        (vars.start = new MemoryWatcher<byte>(ptr+0x44)),
        (vars.level = new MemoryWatcher<byte>(ptr+0x8A)),
        (vars.tiles = new MemoryWatcher<byte>(ptr+0x8C))
    };
    
    refreshRate = 200/3d;
}

update {
    vars.watchers.UpdateAll(game);
}

start {
    return vars.start.Old == 0 && vars.start.Current != 0;
}

split {
    bool needSplit = ((settings["trSplit"] && vars.level.Old != 9) || (settings["udEnd"] && vars.level.Old == 9)) ? (vars.level.Old < vars.level.Current) : (vars.tiles.Old != 0 && vars.tiles.Current == 0);
    return needSplit && settings["lawn"+vars.level.Old];
}

reset {
    return vars.start.Old != 0 && vars.start.Current == 0;
}