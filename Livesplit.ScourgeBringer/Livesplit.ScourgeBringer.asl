state("ScourgeBringer") {}

startup {
    settings.Add("realm", true, "Split at every realm");
    settings.Add("realmCustom", false, "Custom realm splits");
    
    settings.CurrentDefaultParent = "realmCustom";
    settings.Add("realm0", false, "The Entangled Ingress");
    // 1 Hub
    settings.Add("realm2", false, "The Still Bastion");
    settings.Add("realm3", false, "The Wasted Pit");
    // 4 Tuto
    settings.Add("realm5", false, "The Living Walls");
    settings.Add("realm6", false, "The Old World");
}

init {
    vars.tokenSource = new CancellationTokenSource();
    
    vars.threadScan = new Thread(() => {
        var scanGameStates = new SigScanTarget(0x32, "E9 ????????" + String.Concat(Enumerable.Repeat("48 8D 05 ???????? 48 8B 00 48 8B 00 C3", 6)) + "48 8D 05 ???????? 48 8B 00 48 8B 00 48 8D 0D");
        var ptrGameStates = IntPtr.Zero;
        var module = modules[0];
        var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);

        while(!vars.tokenSource.IsCancellationRequested) {
            print("[Autosplitter] Scanning memory");

            if((ptrGameStates = scanner.Scan(scanGameStates)) != IntPtr.Zero) {
                print("[Autosplitter] GameStates Found : " + ptrGameStates.ToString("X"));
                IntPtr gameStates = ptrGameStates+0x4+game.ReadValue<int>(ptrGameStates);
                vars.watchers = new MemoryWatcherList() {
                    (vars.playerHP = new MemoryWatcher<int>(new DeepPointer(gameStates, 0x0, 0x8, 0xB4))),
                    (vars.tileset = new MemoryWatcher<int>(new DeepPointer(gameStates, 0x0, 0x8, 0x128))),
                    (vars.gameTime = new MemoryWatcher<float>(new DeepPointer(gameStates, 0x0, 0x8, 0x130))),
                    (vars.end = new MemoryWatcher<bool>(new DeepPointer(gameStates, 0x0, 0x8, 0x1D5)))
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
    return (vars.tileset.Changed && (settings["realm"] || settings["realm"+vars.tileset.Old]))
        || (vars.end.Current && !vars.end.Old && (settings["realm"] || settings["realm6"]));
}

reset {
    return vars.playerHP.Current == 0 && vars.playerHP.Old > 0;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromSeconds(vars.gameTime.Current);
}

exit {
    vars.tokenSource.Cancel();
}

shutdown {
    vars.tokenSource.Cancel();
}