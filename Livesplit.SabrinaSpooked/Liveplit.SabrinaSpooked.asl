state("bgb") {}
state("bgb64") {}
state("emuhawk") {}
state("gambatte") {}
state("gambatte_qt") {}
state("gambatte_qt_nonpsr") {}

startup {
    refreshRate = 0.5;

    settings.Add("w1", true, "World 1 - Candy");
    settings.Add("w2", true, "World 2 - Beach");
    settings.Add("w3", true, "World 3 - Cavern");
    settings.Add("w4", true, "World 4 - Space");

    for(int world = 1; world <= 4; world++) {
        settings.CurrentDefaultParent = "w"+world;
        var worldLvl = (world-1)*4;
        settings.Add("l"+(worldLvl+1), true, "Level "+world+"-1");
        settings.Add("l"+(worldLvl+2), true, "Level "+world+"-2");
        settings.Add("l"+(worldLvl+3), true, "Level "+world+"-3");
        settings.Add("l"+(worldLvl+4), true, "Level "+world+"-4");
        settings.Add("l"+(24+world), true, "Level "+world+"-Boss");
    }
}

init {
    IntPtr ptr = IntPtr.Zero;
    var target = new SigScanTarget(0, "FF 10 00 00 00 00 00 00 00 FF");

    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        if((ptr = scanner.Scan(target)) != IntPtr.Zero)
            break;
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.start = new MemoryWatcher<byte>(ptr+0x26AB);

    vars.level = new MemoryWatcher<byte>(ptr+0x10B);
    vars.endPortal = new MemoryWatcher<byte>(ptr+0xAE);
    vars.endDissapear = new MemoryWatcher<byte>(ptr+0x11B);
    
    refreshRate = 60;
}

update {
    vars.level.Update(game);
    vars.endPortal.Update(game);
    vars.endDissapear.Update(game);
}

start {
    vars.start.Update(game);
    return vars.level.Current == 1 && vars.start.Old == 0 && vars.start.Current == 128;
}

split {
    if((vars.level.Current < 20 ? vars.endDissapear.Current == 1 : true) && vars.endPortal.Old == 1 && vars.endPortal.Current == 0)
        return settings["l"+vars.level.Current];
}