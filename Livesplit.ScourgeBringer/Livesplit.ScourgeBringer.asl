state("ScourgeBringer") {}

startup {
    settings.Add("realm", true, "Split at every realm");
    settings.Add("realmCustom", false, "Custom Realm Split");
    
    settings.CurrentDefaultParent = "realmCustom";
    settings.Add("realm0", false, "The Entangled Ingress");
    // 1 Hub
    settings.Add("realm2", false, "The Still Bastion");
    settings.Add("realm3", false, "The Wasted Pit");
    // 4 Tuto
    settings.Add("realm5", false, "The Living Walls");
    // settings.Add("realm6", false, "Realm 5");
    // settings.Add("realm7", false, "Realm 6");
}

init {
    vars.tokenSource = new CancellationTokenSource();
    vars.token = vars.tokenSource.Token;
    
    vars.threadScan = new Thread(() => {
        var scanGameStates = new SigScanTarget(0x17, "90 48 B9 ?? ?? ?? ?? ?? ?? ?? ?? BA 68 01 00 00");
        
        IntPtr ptrGameStates = IntPtr.Zero;

        while(!vars.token.IsCancellationRequested) {
            print("[Autosplitter] Scanning memory");
            foreach (var page in game.MemoryPages()) {
                var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

                if((ptrGameStates = scanner.Scan(vars.scanGameStates)) != IntPtr.Zero) {
                    print("[Autosplitter] GameStates Found : " + ptrGameStates.ToString("X"));
                    break;
                }
            }
            if (ptrGameStates != IntPtr.Zero) {
                vars.watchers = new MemoryWatcherList() {
                    (vars.playerHP = new MemoryWatcher<int>(new DeepPointer(ptrGameStates, 0x0, 0x64))),
                    (vars.tileset = new MemoryWatcher<int>(new DeepPointer(ptrGameStates, 0x0, 0xB8))),
                    (vars.gameTime = new MemoryWatcher<float>(new DeepPointer(ptrGameStates, 0x0, 0xBC)))
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
    return vars.gameTime.Changed && vars.gameTime.Old < 0.1 && vars.gameTime.Current < 0.1;
}

split {
    return vars.tileset.Changed && (settings["realm"] || settings["realm"+vars.tileset.Old]);
}

reset {
    return vars.playerHP.Old > 0 && vars.playerHP.Current == 0;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromSeconds(vars.gameTime.Current == 0 ? vars.gameTime.Old : vars.gameTime.Current);
}

exit {
    vars.tokenSource.Cancel();
}

shutdown {
    vars.tokenSource.Cancel();
}