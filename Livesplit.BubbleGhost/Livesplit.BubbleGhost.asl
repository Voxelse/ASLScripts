// state("gambatte_qt_nonpsr") {}
// state("gambatte_qt") {}
// state("gambatte") {}
state("emuhawk") {}
// state("bgb64") {}
// state("bgb") {}

//TODO implement gambatte & bgb support

startup {
    refreshRate = 0.5;

    for(int hall = 2; hall < 37; hall++) settings.Add("h"+hall, true, "Hall "+(hall-1));

    vars.SigScan = (Func<Process, SigScanTarget, IntPtr>)((proc, target) => {
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
        //TODO implement gambatte & bgb
        // var target = new SigScanTarget(0, "FF FF 10 00 00 00 00 FF FF");
        // ptr = vars.SigScan(game, target);
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.watchers = new MemoryWatcherList() {
        (vars.room = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xAD)) : new MemoryWatcher<byte>(ptr+0x0)),
        (vars.life = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xB2)) : new MemoryWatcher<byte>(ptr+0x0)),
        (vars.bubbleX = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x16A)) : new MemoryWatcher<byte>(ptr+0x0)),
        (vars.bubbleY = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x16B)) : new MemoryWatcher<byte>(ptr+0x0))
    };
    
    refreshRate = 200/3d;
}

update {
    vars.watchers.UpdateAll(game);
}

start {
    return vars.room.Old == 0 && vars.room.Current == 255;
}

split {
    if(vars.room.Current == 36)
        return settings["h36"] && vars.bubbleX.Old < 109 && vars.bubbleX.Current >= 109;
    else
        return settings["h"+vars.room.Current] && ((vars.bubbleX.Changed && (vars.bubbleX.Current == 3 || vars.bubbleX.Current == 156)) || (vars.bubbleY.Changed && (vars.bubbleY.Current == 26 || vars.bubbleY.Current == 101)));
}

reset {
    return vars.room.Changed && vars.room.Current == 0 && vars.room.Old != 255 && vars.life.Old == 0;
}