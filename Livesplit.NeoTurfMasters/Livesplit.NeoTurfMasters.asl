state("WinKawaks") {}

startup {
    refreshRate = 0.5;

    for(int hole = 1; hole <= 18; hole++)
        settings.Add("hole"+hole, true, "Hole "+hole);

    vars.scanTarget = new SigScanTarget(0, "01 FF FF 00 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? FF FF FF FF");
}

init {
    IntPtr ptr = IntPtr.Zero;
    
    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        if((ptr = scanner.Scan(vars.scanTarget)) != IntPtr.Zero)
            break;
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.course = new MemoryWatcher<byte>(ptr+0x7);
    vars.hole = new MemoryWatcher<byte>(ptr+0xB);
    vars.end = new MemoryWatcher<byte>(ptr-0x642F);
    
    refreshRate = 60;
}

update {
    vars.course.Update(game);
    vars.hole.Update(game);
    vars.end.Update(game);
}

start {
    return vars.course.Old == 0 && vars.course.Current == 2;
}

split {
    if(vars.end.Old == 0 && vars.end.Current == 255)
        return settings["hole"+vars.hole.Current];
}

reset {
    return vars.course.Old != 0 && vars.course.Current == 0;
}