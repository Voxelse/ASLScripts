state("GRIS") {} //Need to replace custom ReadPointers to DeepPointers when 64bits pointers will be supported

startup {
    refreshRate = 0.5;

    settings.Add("end", true, "End");
    settings.Add("colors", false, "Colors");
    settings.Add("powers", false, "Powers");
    settings.Add("constellation", false, "Constellation");

    settings.CurrentDefaultParent = "colors";
    settings.Add("color0", false, "Red");
    settings.Add("color2", false, "Green");
    settings.Add("color1", false, "Blue");
    settings.Add("color3", false, "Yellow");
    settings.Add("color4", false, "Black");
    settings.Add("color5", false, "Lilac");

    settings.CurrentDefaultParent = "powers";
    settings.Add("power0", false, "Agility");
    settings.Add("power1", false, "Heavy");
    settings.Add("power2", false, "Lightness");
    settings.Add("power3", false, "Dive");
    settings.Add("power4", false, "Sing");

    settings.CurrentDefaultParent = "constellation";
    settings.Add("const3", false, "3 - Start");
    settings.Add("const8", false, "8 - Red");
    settings.Add("const10", false, "10 - Green");
    settings.Add("const16", false, "16 - Blue");
    settings.Add("const22", false, "22 - Yellow");

    vars.ReadPointers = (Func<Process, IntPtr, int[], IntPtr>)((proc, basePtr, offsets) => {
        IntPtr ptr = basePtr;
        foreach(int offset in offsets) {
            proc.ReadPointer((IntPtr)(ptr+offset), out ptr);
        }
        return ptr;
    });

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.oldColor = vars.curColor = 0;
        vars.oldPower = vars.curPower = 0;
        vars.oldConstellation = vars.curConstellation = 0;
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    print("[Autosplitter] Scanning memory");

    vars.ptr = IntPtr.Zero;
    var target = new SigScanTarget(14, "55 48 8B EC 56 48 83 EC 28 48 8B F1 48 B8 ?? ?? ?? ?? ?? ?? ?? ?? 48 8B 08");

    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        if((vars.ptr = scanner.Scan(target)) != IntPtr.Zero)
            break;
    }

    if (vars.ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    print("[Autosplitter] Memory at : "+vars.ptr.ToString("X"));

    vars.scenes = new HashSet<string>();
    vars.curSceneVer = vars.oldSceneVer = 0;

    vars.oldFadeColor = vars.curFadeColor = 0;
    vars.curIsStarted = vars.oldIsStarted = 0;
    vars.curStartDuration = vars.oldStartDuration = 0;

    vars.oldColor = vars.curColor = 0;
    vars.oldPower = vars.curPower = 0;
    vars.oldConstellation = vars.curConstellation = 0;

    refreshRate = 60;
}

update {
    IntPtr mainManager = vars.ReadPointers(game, vars.ptr, new int[] {0x0, 0x0});

    if(timer.CurrentPhase == TimerPhase.NotRunning) {
        //Scenes
        vars.oldSceneVer = vars.curSceneVer;
        IntPtr worldManager = vars.ReadPointers(game, mainManager, new int[] {0x90, 0x28});
        vars.curSceneVer = game.ReadValue<int>(worldManager+0x1C);
        if(vars.oldSceneVer != vars.curSceneVer) {
            int scenesSize = game.ReadValue<int>(worldManager+0x18);
            IntPtr loadedScenes = game.ReadPointer(worldManager+0x10);
            vars.scenes.Clear();
            for(int i = 0; i < scenesSize; i++)
                vars.scenes.Add(game.ReadString(game.ReadPointer(loadedScenes+0x20+0x8*i)+0x14, 128));
        }

        //GuiCamera
        IntPtr menuTimer = vars.ReadPointers(game, mainManager, new int[] {0xF8, 0x68, 0x10});
        vars.oldIsStarted = vars.curIsStarted;
        vars.curIsStarted = game.ReadValue<byte>(menuTimer+0x14);
        vars.oldStartDuration = vars.curStartDuration;
        vars.curStartDuration = game.ReadValue<float>(menuTimer+0x18);

    } else {
        //FX
        vars.oldFadeColor = vars.curFadeColor;
        vars.curFadeColor = game.ReadValue<int>((IntPtr)vars.ReadPointers(game, mainManager, new int[] {0xC8, 0x38})+0x2C);

        //PlayerProgression
        vars.nextPower = game.ReadValue<byte>((IntPtr)(vars.ReadPointers(game, mainManager, new int[] {0xD0, 0x20, 0x28})+0x20+0x1*vars.curPower));
        vars.oldPower = vars.curPower;
        if(vars.nextPower == 1) {
            vars.curPower++;
        }

        vars.nextColor = game.ReadValue<byte>((IntPtr)(vars.ReadPointers(game, mainManager, new int[] {0xD0, 0x28, 0x28})+0x20+0x1*vars.curColor));
        vars.oldColor = vars.curColor;
        if(vars.nextColor == 1) {
            if(vars.curColor == 0 || vars.curColor == 1) vars.curColor += 2;
            else if(vars.curColor == 2) vars.curColor--;
            else vars.curColor++;
        }

        vars.oldConstellation = vars.curConstellation;
        vars.curConstellation = game.ReadValue<int>(game.ReadPointer(mainManager+0xD0)+0x5C);
    }
}

start {
    return vars.scenes.Contains("Assets/Scenes/Flow/Menus/Main Menu/MainMenu.unity") && vars.curIsStarted == 1 && vars.curStartDuration == 1;
}

split {
    //Power
    if(vars.oldPower != vars.curPower)
        return settings["power"+vars.oldPower];

    //Color
    if(vars.oldColor != vars.curColor)
        return settings["color"+vars.oldColor];

    if(vars.oldConstellation != vars.curConstellation)
        return settings["const"+vars.curConstellation];

    //End Split
    if(vars.curColor == 6 && vars.oldFadeColor == 0x3F41C1C2 && vars.curFadeColor == 0)
        return settings["end"];
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}