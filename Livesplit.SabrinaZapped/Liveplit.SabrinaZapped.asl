state("bgb") {}
state("bgb64") {}
state("emuhawk") {}
state("gambatte") {}
state("gambatte_qt") {}
state("gambatte_qt_nonpsr") {}

startup {
    refreshRate = 0.5;

    settings.Add("w1", true, "World 1 - School");
    settings.Add("w2", true, "World 2 - Beach");
    settings.Add("w3", true, "World 3 - Mall");
    settings.Add("w4", true, "World 4 - Zoo");

    for(int world = 1; world <= 4; world++) {
        settings.CurrentDefaultParent = "w"+world;
        var worldLvl = (world-1)*5;
        settings.Add("l"+(worldLvl+0), true, "Level "+world+"-1");
        settings.Add("l"+(worldLvl+1), true, "Level "+world+"-2");
        settings.Add("l"+(worldLvl+2), true, "Level "+world+"-3");
        settings.Add("l"+(worldLvl+3), true, "Level "+world+"-4");
        settings.Add("l"+(worldLvl+4), true, "Level "+world+"-Boss");
    }
}

init {
    IntPtr ptr = IntPtr.Zero;
    var target = new SigScanTarget(0, "FF FF 10 00 00 00 00 FF FF");

    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        if((ptr = scanner.Scan(target)) != IntPtr.Zero)
            break;
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.aniLeft = new MemoryWatcher<byte>(ptr+0x83);

    vars.level = new MemoryWatcher<byte>(ptr+0x92);
    vars.pause = new MemoryWatcher<byte>(ptr+0xAE);
    
    refreshRate = 60;
}

update {
    vars.level.Update(game);
    vars.pause.Update(game);
}

start {
    return vars.pause.Changed && vars.pause.Current == 128 && vars.level.Current == 0;
}

split {
    if(vars.level.Current == 19) {
        vars.aniLeft.Update(game);
        if(vars.aniLeft.Old == 0 && vars.aniLeft.Current == 1)
            return settings["l19"];
    } else if((vars.pause.Old == 0 && vars.pause.Current == 128) ||
              (vars.pause.Old == 8 && vars.pause.Current == 136)) {
        return settings["l"+vars.level.Current];
    }
}