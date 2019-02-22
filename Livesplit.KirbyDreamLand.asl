state("gambatte_qt_nonpsr") {}
state("gambatte_qt") {}
state("gambatte") {}
state("emuhawk") {}
state("bgb64") {}
state("bgb") {}

startup {
    refreshRate = 0.5;

    settings.Add("star", false, "End Stage Splits: \"Star grab\" instead of \"End dance\"");

    settings.Add("s0", true, "Stage 1 - Green Greens");
    settings.Add("s1", true, "Stage 2 - Castle Lololo");
    settings.Add("s2", true, "Stage 3 - Float Islands");
    settings.Add("s3", true, "Stage 4 - Bubbly Clouds");
    settings.Add("s4", true, "Stage 5 - Mt. DeDeDe");

    for(int w = 0; w <= 3; w++) settings.Add("w"+w, true, "End Stage", "s"+w);

    settings.Add("b0_2", false, "Mid-Boss (Poppy Bros. Sr.)", "s0");
    settings.Add("b1_8", false, "Mid-Boss (Lololo)", "s1");
    settings.Add("b3_4", false, "Mid-Boss (Kracko Jr.)", "s3");
    settings.Add("b4_5", true, "Boss (King DeDeDe)", "s4");
    settings.Add("b4_6", false, "Mid-Boss (Whispy Woods)", "s4");
    settings.Add("b4_7", false, "Mid-Boss (Kaboola)", "s4");
    settings.Add("b4_8", false, "Mid-Boss (Lololo & Lalala)", "s4");
    settings.Add("b4_9", false, "Mid-Boss (Kracko)", "s4");

    vars.endRoom = new Dictionary<byte, byte>{{0, 4}, {1, 15}, {2, 7}, {3, 9}};

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

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.animCount = 0;
        vars.diedInBoss = false;
    });
    timer.OnStart += vars.timerResetVars;
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
        var target = new SigScanTarget(0, "00 00 00 ?? FF 00 ?? ?? ?? ?? 00 00 00 00 00 01 00 00 00 00 ?? ?? ?? ?? ?? 01");
        ptr = vars.SigScan(game, target);
    }

    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.anim = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x6)) : new MemoryWatcher<byte>(ptr-0x1033);
    vars.world = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x103B)) : new MemoryWatcher<byte>(ptr+0x2);
    vars.room = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x103E)) : new MemoryWatcher<byte>(ptr+0x5);
    vars.life = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x1089)) : new MemoryWatcher<byte>(ptr+0x50);
    vars.bossHp = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x1093)) : new MemoryWatcher<byte>(ptr+0x5A);
    vars.star = useDeepPtr ? new MemoryWatcher<byte>(new DeepPointer((int)ptr, 0x13DE)) : new MemoryWatcher<byte>(ptr+0x3A5);

    vars.animCount = 0;
    vars.diedInBoss = false;

    refreshRate = 60;
}

update {
    vars.world.Update(game);
    vars.room.Update(game);
    vars.life.Update(game);
    vars.bossHp.Update(game);
   
     if(settings["star"])
        vars.star.Update(game);
    else
        vars.anim.Update(game);

    if(vars.bossHp.Current == 1 && (vars.life.Current < vars.life.Old || vars.life.Current == 5 && vars.life.Old == 1))
        vars.diedInBoss = true;
}

start {
    return vars.life.Old == 0 && vars.life.Current == 5;
}

split {
    if(vars.world.Current < 4 && settings["w"+vars.world.Current] && vars.room.Current == vars.endRoom[vars.world.Current]) {
        if(settings["star"]) {
            return vars.star.Old == 128 && vars.star.Current == 0;
        } else {
            if(vars.anim.Old != 80 && vars.anim.Current == 80) {
                if(++vars.animCount >= (vars.world.Current == 3 ? 2 : 3)) {
                    vars.animCount = 0;
                    return true;
                }
            }   
        }
    }

    if(vars.bossHp.Old == 1 && vars.bossHp.Current == 0) {
        if (vars.diedInBoss) 
            vars.diedInBoss = false;
        else {
            var bossSplit = "b"+vars.world.Current+"_"+vars.room.Current;
            return settings.ContainsKey(bossSplit) && settings[bossSplit];
        }
    }
}

reset {
    return vars.life.Changed && vars.life.Current == 0;
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}