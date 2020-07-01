state("gambatte_qt_nonpsr") {}
state("gambatte_qt") {}
state("gambatte") {}
state("emuhawk") {}
state("bgb64") {}
state("bgb") {}

startup {
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
    vars.SigScan = (Func<SigScanTarget, IntPtr>)((target) => {
        print("[Autosplitter] Scanning memory");
        IntPtr ptr = IntPtr.Zero;
        foreach (var page in game.MemoryPages()) {
            var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
            if ((ptr = scanner.Scan(target)) != IntPtr.Zero)
                break;
        }
        return ptr;
    });

    vars.tokenSource = new CancellationTokenSource();
    vars.token = vars.tokenSource.Token;
    
    vars.threadScan = new Thread(() => {
        IntPtr ptr = IntPtr.Zero;
        bool useDeepPtr = false;
        while(!vars.token.IsCancellationRequested) {
            if (memory.ProcessName.Equals("emuhawk", StringComparison.OrdinalIgnoreCase)) {
                var target = new SigScanTarget(0, "05 00 00 00 ?? 00 00 00 00 ?? ?? 00 00 ?? ?? 00 00 ?? ?? 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? F8 00 00 00");
                IntPtr wram = vars.SigScan(target);
                if (wram != IntPtr.Zero)
                    ptr = (IntPtr)((long)(wram-0x40)-(long)modules.First().BaseAddress);
                useDeepPtr = true;
            } else {
                var target = new SigScanTarget(0, "FF 10 00 00 00 00 00 00 00 FF");
                ptr = vars.SigScan(target);
            }
            if (ptr != IntPtr.Zero) {
                vars.start = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x3091)) : new MemoryWatcher<byte>(ptr+0x26AB);
    
                vars.watchers = new MemoryWatcherList() {
                    (vars.level = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xAF1)) : new MemoryWatcher<byte>(ptr+0x10B)),
                    (vars.endPortal = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xA94)) : new MemoryWatcher<byte>(ptr+0xAE)),
                    (vars.endDisappear = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xB01)) : new MemoryWatcher<byte>(ptr+0x11B))
                };
                print("[Autosplitter] Done scanning");
                break;
            }
            Thread.Sleep(2000);
        }
        print("[Autosplitter] Exit thread scan");
    });
    vars.threadScan.Start();
}

update {
    if(vars.threadScan.IsAlive)
        return false;
        
    vars.watchers.UpdateAll(game);
}

start {
    vars.start.Update(game);
    return vars.level.Current == 1 && vars.start.Old == 0 && vars.start.Current == 128;
}

split {
    if((vars.level.Current < 20 ? vars.endDisappear.Current == 1 : true) && vars.endPortal.Old == 1 && vars.endPortal.Current == 0)
        return settings["l"+vars.level.Current];
}

exit {
    vars.tokenSource.Cancel();
}

shutdown {
    vars.tokenSource.Cancel();
}