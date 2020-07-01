state("Vignettes") {}

startup {
    settings.Add("end", true, "Reach Credits (End)");
    settings.Add("ports", false, "Complete Portraits");
    settings.Add("secs", false, "Find Secrets");
    settings.Add("objs", false, "Discover Objects");

    settings.CurrentDefaultParent = "ports";
    settings.Add("port0", false, "Tuto");
    settings.Add("port1", false, "Daily Routine");
    settings.Add("port2", false, "Night Walk");
    settings.Add("port3", false, "Dream");
    settings.Add("port4", false, "Miniatures");
    settings.Add("port5", false, "Nostalgic");
    settings.Add("port6", false, "Road Trip");
    settings.Add("port7", false, "Witch's Lair");
    settings.Add("port8", false, "Shore");

    settings.CurrentDefaultParent = "secs";
    settings.Add("sec0", false, "Moth");
    settings.Add("sec1", false, "Petals");
    settings.Add("sec2", false, "Snek");
    settings.Add("sec3", false, "Apollo 11");
    settings.Add("sec4", false, "Joseph");
    settings.Add("sec5", false, "Fleur de Lys");
    settings.Add("sec6", false, "Selfie Time");
    settings.Add("sec7", false, "Tunnel Vision");
    settings.Add("sec8", false, "Crystalball");
    settings.Add("sec9", false, "Skull");
    settings.Add("sec10", false, "Summons");
    settings.Add("sec11", false, "Concerto");

    settings.CurrentDefaultParent = "objs";
    settings.Add("objs0", false, "Tuto");
    settings.Add("objs1", false, "Daily Routine");
    settings.Add("objs2", false, "Night Walk");
    settings.Add("objs3", false, "Dream");
    settings.Add("objs4", false, "Miniatures");
    settings.Add("objs5", false, "Nostalgic");
    settings.Add("objs6", false, "Road Trip");
    settings.Add("objs7", false, "Witch's Lair");
    settings.Add("objs8", false, "Shore");
    settings.CurrentDefaultParent = "objs0";
    settings.Add("obj65", false, "Tuto1");
    settings.Add("obj66", false, "Tuto2");
    settings.Add("obj64", false, "Tuto3");
    settings.Add("obj100", false, "Chest");
    settings.CurrentDefaultParent = "objs1";
    settings.Add("obj5", false, "Phone");
    settings.Add("obj1", false, "Bowl");
    settings.Add("obj8", false, "Lamp");
    settings.Add("obj9", false, "Bulb");
    settings.Add("obj37", false, "Fan");
    settings.Add("obj3", false, "Luth");
    settings.Add("obj7", false, "Pan");
    settings.Add("obj21", false, "Toaster");
    settings.Add("obj36", false, "Can");
    settings.Add("obj4", false, "TV");
    settings.Add("obj6", false, "Frame");
    settings.Add("obj0", false, "Plant");
    settings.Add("obj11", false, "Hourglass");
    settings.CurrentDefaultParent = "objs2";
    settings.Add("obj22", false, "Pillbox");
    settings.Add("obj23", false, "Hydrant");
    settings.Add("obj25", false, "Dumpster");
    settings.Add("obj24", false, "Cat");
    settings.Add("obj26", false, "Moon");
    settings.Add("obj27", false, "Streetlight");
    settings.Add("obj28", false, "Signallight");
    settings.Add("obj29", false, "Alarmclock");
    settings.CurrentDefaultParent = "objs3";
    settings.Add("obj2", false, "Hat");
    settings.Add("obj12", false, "Chalice");
    settings.Add("obj15", false, "Cage");
    settings.Add("obj14", false, "Crown");
    settings.Add("obj13", false, "Ring");
    settings.Add("obj31", false, "Mirror");
    settings.Add("obj17", false, "Knight");
    settings.Add("obj18", false, "Trumpet");
    settings.CurrentDefaultParent = "objs4";
    settings.Add("obj30", false, "Doll");
    settings.Add("obj68", false, "Snowball");
    settings.CurrentDefaultParent = "objs5";
    settings.Add("obj38", false, "Box");
    settings.Add("obj32", false, "Astrolabe");
    settings.Add("obj42", false, "Mantelclock");
    settings.Add("obj33", false, "StatueZenith");
    settings.Add("obj34", false, "RoseZenith");
    settings.Add("obj35", false, "MicroscopeZenith");
    settings.Add("obj39", false, "StatueRuin");
    settings.Add("obj40", false, "RoseRuin");
    settings.Add("obj41", false, "MicroscopeRuin");
    settings.CurrentDefaultParent = "objs6";
    settings.Add("obj56", false, "Roundcase");
    settings.Add("obj20", false, "Paperboat");
    settings.Add("obj60", false, "Boot");
    settings.Add("obj61", false, "Flatbottle");
    settings.Add("obj63", false, "Torchlight");
    settings.Add("obj43", false, "Compass");
    settings.Add("obj16", false, "Book");
    settings.Add("obj58", false, "PhotoCamera");
    settings.Add("obj59", false, "Roadmap");
    settings.Add("obj45", false, "Pocketknife");
    settings.Add("obj62", false, "Binoculars");
    settings.CurrentDefaultParent = "objs7";
    settings.Add("obj76", false, "Candelabra");
    settings.Add("obj50", false, "Pot");
    settings.Add("obj47", false, "Mortar");
    settings.Add("obj48", false, "Mushroom");
    settings.Add("obj49", false, "Flask");
    settings.Add("obj51", false, "Sphinx");
    settings.Add("obj55", false, "Ouija");
    settings.Add("obj54", false, "Fancytray");
    settings.Add("obj53", false, "Crystalball");
    settings.Add("obj52", false, "Skull");
    settings.Add("obj44", false, "Spookydoll");
    settings.CurrentDefaultParent = "objs8";
    settings.Add("obj75", false, "Amphora");
    settings.Add("obj72", false, "Venuscomb");
    settings.Add("obj71", false, "Radiolaria");
    settings.Add("obj70", false, "Cockle");
    settings.Add("obj73", false, "Urchin");
    settings.Add("obj74", false, "Coral");

    vars.InitVars = (Action)(() => {
        vars.curStartScreen = vars.oldStartScreen = 0;
        vars.curEndCredits = vars.oldEndCredits = 0;

        vars.curObjCount = vars.oldObjCount = 0;
        vars.curSecGen = vars.oldSecGen = 0;

        vars.split = "";
        vars.secs = new HashSet<int>();
        vars.portraitObjects = new Dictionary<string, HashSet<int>>();
    });

    vars.InitVars();

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.InitVars();

        for(int i = 0; i < 13; i++) vars.secs.Add(i);

        vars.portraitObjects = new Dictionary<string, HashSet<int>>(){
            {"port0", new HashSet<int>{64, 65, 66, 100}},
            {"port1", new HashSet<int>{0, 1, 3, 4, 5, 6, 7, 8, 9, 11, 21, 36, 37}},
            {"port2", new HashSet<int>{22, 23, 24, 25, 26, 27, 28, 29}},
            {"port3", new HashSet<int>{2, 12, 13, 14, 15, 17, 18, 31}},
            {"port4", new HashSet<int>{30, 68}},
            {"port5", new HashSet<int>{32, 33, 34, 35, 38, 39, 40, 41, 42}},
            {"port6", new HashSet<int>{16, 20, 43, 45, 56, 58, 59, 60, 61, 62, 63}},
            {"port7", new HashSet<int>{44, 47, 48, 49, 50, 51, 52, 53, 54, 55, 76}},
            {"port8", new HashSet<int>{70, 71, 72, 73, 74, 75}}
        };
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    vars.ReadPointer = (Func<IntPtr, IntPtr>)((basePtr) => {
        IntPtr ptr = basePtr;
        game.ReadPointer((IntPtr)(ptr), false, out ptr);
        return ptr;
    });

    vars.ReadPointers = (Func<IntPtr, int[], IntPtr>)((basePtr, offsets) => {
        IntPtr ptr = basePtr;
        foreach(int offset in offsets)
            game.ReadPointer((IntPtr)(ptr+offset), false, out ptr);
        return ptr;
    });
    
    vars.ptr = IntPtr.Zero;

    vars.tokenSource = new CancellationTokenSource();
    vars.token = vars.tokenSource.Token;
    
    vars.threadScan = new Thread(() => {
        var target = new SigScanTarget(10, "89 85 50 FF FF FF 48 8B 0C 25 ?? ?? ?? ??");
        
        while(!vars.token.IsCancellationRequested) {
            print("[Autosplitter] Scanning memory");
            foreach (var page in game.MemoryPages()) {
                var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
                if((vars.ptr = scanner.Scan(target)) != IntPtr.Zero)
                    break;
            }
            if (vars.ptr != IntPtr.Zero) {
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

    vars.split = "";

    IntPtr r = vars.ReadPointers(vars.ptr, new int[] {0x0, 0x0});

    vars.oldStartScreen = vars.curStartScreen;
    vars.curStartScreen = game.ReadValue<byte>(r+0x152);

    IntPtr secPtr = vars.ReadPointers(r, new int[] {0x68, 0x28});
    vars.oldSecGen = vars.curSecGen;
    vars.curSecGen = game.ReadValue<int>(secPtr+0x50);
    if(settings["secs"] && vars.oldSecGen != vars.curSecGen) {
        IntPtr secList = vars.ReadPointer(secPtr+0x28);
        for (int k = vars.secs.Count - 1; k >= 0; k--) {
            if(game.ReadValue<int>((IntPtr)(secList+0x20+0x4*(k-1))) == 1) {
                vars.secs.RemoveAt(k);
                vars.split = "sec"+k;
                break;
            }
        }
    }

    IntPtr objPtr = vars.ReadPointers(r, new int[] {0x68, 0x18});
    vars.oldObjCount = vars.curObjCount;
    vars.curObjCount = game.ReadValue<int>(objPtr+0x18);
    if((settings["ports"] || settings["objs"]) && vars.oldObjCount != vars.curObjCount) {
        int objId = game.ReadValue<int>((IntPtr)(vars.ReadPointer(objPtr+0x10)+0x20+0x4*(vars.curObjCount-1)));
        if(settings["ports"]) {
            foreach(KeyValuePair<string, HashSet<int>> vk in vars.portraitObjects) {
                if(vk.Value.Remove(objId) && vk.Value.Count == 0) {
                    vars.split = vk.Key;
                    break;
                }
            }
        }
        if(!vars.split.Equals(""))
            vars.portraitObjects.Remove(vars.split);
        else
            vars.split = "obj"+objId;
    }

    vars.oldEndCredits = vars.curEndCredits;
    vars.curEndCredits = game.ReadValue<byte>((IntPtr)vars.ReadPointer(r+0x88)+0x44);
    if(vars.oldEndCredits == 0 && vars.curEndCredits == 1)
        vars.split = "end";
}

start {
    return vars.oldStartScreen == 1 && vars.curStartScreen == 0;
}

split {
    return !vars.split.Equals("") && settings.ContainsKey(vars.split) && settings[vars.split];
}

reset {
    return vars.curObjCount < vars.oldObjCount || (vars.oldStartScreen != vars.curStartScreen && vars.curStartScreen == 1);
}

exit {
    vars.tokenSource.Cancel();
}

shutdown {
    vars.tokenSource.Cancel();
    timer.OnStart -= vars.timerResetVars;
}