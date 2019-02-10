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

    vars.SigScan = (Func<Process, SigScanTarget, IntPtr>)((proc, target) =>
    {
        print("[Autosplitter] Scanning memory");
        IntPtr ptr = IntPtr.Zero;
        foreach (var page in proc.MemoryPages()) {
            var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
            if ((ptr = scanner.Scan(target)) != IntPtr.Zero)
                break;
        }
        return ptr;
    });
}

init {
    IntPtr ptr = IntPtr.Zero;
    bool useDeepPtr = false;

    if (memory.ProcessName.Equals("emuhawk", StringComparison.OrdinalIgnoreCase)) {
        var target = new SigScanTarget(0, "05 00 00 00 ?? 00 00 00 00 ?? ?? 00 00 ?? ?? 00 00 ?? ?? 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? F8 00 00 00");
        IntPtr wram = vars.SigScan(game, target);
        if (wram != IntPtr.Zero)
            ptr = (IntPtr)((long)(wram-0x40)-(long)modules.First().BaseAddress);
        useDeepPtr = true;
    } else {
        var target = new SigScanTarget(0, "FF FF 10 00 00 00 00 FF FF");
        ptr = vars.SigScan(game, target);
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.aniLeft = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x9FB)) : new MemoryWatcher<byte>(ptr+0x83);

    vars.level = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xA0A)) : new MemoryWatcher<byte>(ptr+0x92);
    vars.pause = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xA26)) : new MemoryWatcher<byte>(ptr+0xAE);
    
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