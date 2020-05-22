state("WinKawaks") {}

startup {
    settings.Add("ger", true, "Germany");
    settings.Add("jap", true, "Japan");
    settings.Add("aus", true, "Australia");
    settings.Add("usa", true, "U.S.A (auto start not available)");

    for(int hole = 1; hole <= 18; hole++) {
        settings.Add("hole1_"+hole, true, "Hole "+hole, "ger");
        settings.Add("hole2_"+hole, true, "Hole "+hole, "jap");
        settings.Add("hole3_"+hole, true, "Hole "+hole, "aus");
        settings.Add("hole0_"+hole, true, "Hole "+hole, "usa");
    }
}

init {
    vars.threadScan = new Thread(() => {
        var scanTarget = new SigScanTarget(0, "01 FF FF 00 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? FF FF FF FF");

        IntPtr ptr = IntPtr.Zero;
    
        while(ptr == IntPtr.Zero) {
            print("[Autosplitter] Scanning memory");
            foreach (var page in game.MemoryPages()) {
                var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
                if((ptr = scanner.Scan(scanTarget)) != IntPtr.Zero)
                    break;
            }
            if (ptr != IntPtr.Zero) {
                vars.watchers = new MemoryWatcherList() {
                    (vars.course = new MemoryWatcher<byte>(ptr+0x7)),
                    (vars.hole = new MemoryWatcher<byte>(ptr+0xB)),
                    (vars.end = new MemoryWatcher<byte>(ptr-0x648A))
                };
            } else {
                Thread.Sleep(2000);
            }
        }
        print("[Autosplitter] Done scanning");
    });
    vars.threadScan.Start();
}

update {
    if(!((IDictionary<string, Object>)vars).ContainsKey("watchers"))
        return false;

    vars.watchers.UpdateAll(game);
}

start {
    return vars.hole.Current == 1 && vars.course.Old == 0 && (vars.course.Current == 1 || vars.course.Current == 2 || vars.course.Current == 3);
}

split {
    if(vars.end.Old == 0 && (vars.end.Current == 1 || vars.end.Current == 255))
        return settings["hole"+vars.course.Current+"_"+vars.hole.Current];
}

reset {
    return vars.course.Old != 0 && vars.course.Current == 0;
}

shutdown {
    vars.threadScan.Abort();
}