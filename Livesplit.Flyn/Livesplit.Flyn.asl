state("Flyn") {}

startup {
    settings.Add("w1", true, "1 - Tricoton");
    settings.Add("w2", true, "2 - Tripatio");
    settings.Add("w3", true, "3 - Trilab");
    settings.Add("w4", true, "4 - Elektri");
    settings.Add("w5", true, "5 - Megaben");

    for(int w = 1; w < 6; w++) {
        settings.Add("levels"+w, true, "Levels", "w"+w);
        settings.CurrentDefaultParent = "levels"+w;
        var wO = (w-1)*10;
        for(int l = 1; l < 8; l++)
            settings.Add("l"+(wO+l), true, w+"-"+l);
        settings.Add("l"+(wO+8), true, w+"-Boss");
        settings.Add("l"+(wO+9), true, w+"-Inside Boss");
    }

    for(int s = 1; s < 6; s++)
        settings.Add("secrets"+s, false, "Secrets", "w"+s);
    
    settings.CurrentDefaultParent = "secrets1";
    settings.Add("l50", true, "Graby");
    settings.Add("l51", true, "Astep_Ping");
    settings.Add("l52", true, "Salvay");
    settings.CurrentDefaultParent = "secrets2";
    settings.Add("l53", true, "Ylona");
    settings.Add("l54", true, "AstralZ");
    settings.Add("l55", true, "Medy");
    settings.CurrentDefaultParent = "secrets3";
    settings.Add("l56", true, "Safaway");
    settings.Add("l57", true, "Popaf");
    settings.Add("l58", true, "Ollon");
    settings.CurrentDefaultParent = "secrets4";
    settings.Add("l59", true, "Korly");
    settings.Add("l60", true, "Plincty");
    settings.Add("l61", true, "Germion");
    settings.CurrentDefaultParent = "secrets5";
    settings.Add("l62", true, "Buccoly");
}

init {
    vars.threadScan = new Thread(() => {
        var scanTargetGame = new SigScanTarget(2, "8D 15 ?? ?? ?? ?? E8 ?? ?? ?? ?? 89 75 E0 A1");
        IntPtr targetPtr = IntPtr.Zero;
        while(targetPtr == IntPtr.Zero) {
            print("[Autosplitter] Scanning memory");
            foreach (var page in game.MemoryPages()) {
                var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

                if((targetPtr = scanner.Scan(scanTargetGame)) != IntPtr.Zero) {
                    print("[Autosplitter] Target Found : " + targetPtr.ToString("X"));
                    break;
                }
            }
            if (targetPtr != IntPtr.Zero) {
                int relPtr = (int)((long)targetPtr - (long)modules.First().BaseAddress);

                vars.watchers = new MemoryWatcherList() {
                    (vars.levelId = new MemoryWatcher<int>(new DeepPointer(relPtr, 0x0, 0xEC))),
                    (vars.gameState = new MemoryWatcher<int>(new DeepPointer(relPtr, 0x0, 0xC8, 0x1C)))
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
    return vars.levelId.Changed && (vars.levelId.Current == 1 || (vars.levelId.Current >= 50 && vars.levelId.Current <= 62));
}

split {
    if(vars.levelId.Current == 49 && vars.gameState.Changed && vars.gameState.Current == 5) return settings["l49"];

    if(!vars.levelId.Changed) return false;

    return settings.ContainsKey("l"+vars.levelId.Old) && settings["l"+vars.levelId.Old];
}

reset {
    return vars.levelId.Current == 70;
}

isLoading {
    return vars.gameState.Current == 2;
}

shutdown {
    vars.threadScan.Abort();
}