state("gambatte_qt_nonpsr") {}
state("gambatte_qt") {}
state("gambatte") {}
state("emuhawk") {}
state("bgb64") {}
state("bgb") {}

startup {
    for(int hall = 2; hall < 37; hall++) settings.Add("h"+hall, true, "Hall "+(hall-1));
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
                var target = new SigScanTarget(0, "47 47 47 47 00 00 00 00 47 47 47 47 00 00 00 00 47 47 47 47 00 00 00 00 47 47 47 47 00 00 00 00 47 47 47 47");
                ptr = vars.SigScan(target)-0x101;
            }
            if (ptr != IntPtr.Zero) {
                vars.watchers = new MemoryWatcherList() {
                    (vars.room = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xAD)) : new MemoryWatcher<byte>(ptr+0xAD)),
                    (vars.life = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0xB2)) : new MemoryWatcher<byte>(ptr+0xB2)),
                    (vars.bubbleX = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x16A)) : new MemoryWatcher<byte>(ptr+0x16A)),
                    (vars.bubbleY = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x16B)) : new MemoryWatcher<byte>(ptr+0x16B))
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
    return vars.room.Old != vars.room.Current && vars.room.Current == 255;
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

exit {
    vars.tokenSource.Cancel();
}

shutdown {
    vars.tokenSource.Cancel();
}