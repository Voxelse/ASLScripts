state("GRIS") {} //Need to replace custom ReadPointers to DeepPointers when 64bits pointers will be supported

startup {
	refreshRate = 0.5;

	settings.Add("end", true, "End");
	settings.Add("colors", false, "Colors");
	settings.Add("powers", false, "Powers");
	settings.Add("constellation", false, "Hub Constellation");
	settings.Add("mementos", false, "Mementos");
	settings.Add("achievements", false, "Achievements");

	settings.CurrentDefaultParent = "colors";
	settings.Add("color0", false, "Red");
	settings.Add("color2", false, "Green");
	settings.Add("color1", false, "Blue");
	settings.Add("color3", false, "Yellow");
	settings.Add("color4", false, "Black (end of Yellow when flipping the world)");
	settings.Add("color5", false, "Lilac (end of final boss)");

	settings.CurrentDefaultParent = "powers";
	settings.Add("power0", false, "Agility (Run)");
	settings.Add("power1", false, "Heavy (Block)");
	settings.Add("power2", false, "Lightness (Glide)");
	settings.Add("power3", false, "Dive");
	settings.Add("power4", false, "Sing");

	settings.CurrentDefaultParent = "constellation";
	settings.Add("const3", false, "3 - Start");
	settings.Add("const8", false, "8 - Red");
	settings.Add("const10", false, "10 - Green");
	settings.Add("const16", false, "16 - Blue");
	settings.Add("const22", false, "22 - Yellow");

	settings.CurrentDefaultParent = "mementos";
	settings.Add("memS", false, "Start");
	settings.Add("memR", false, "Red");
	settings.Add("memG", false, "Green");
	settings.Add("memB", false, "Blue");
	settings.Add("memY", false, "Yellow");

	settings.CurrentDefaultParent = "memS";
	settings.Add("mem0", false, "Memento 1");
	settings.Add("mem1", false, "Memento 21");

	settings.CurrentDefaultParent = "memR";
	settings.Add("mem2", false, "Memento 2");
	settings.Add("mem3", false, "Memento 3");
	settings.Add("mem4", false, "Memento 4");
	settings.Add("mem5", false, "Memento 5");
	settings.Add("mem6", false, "Memento 6");
	settings.Add("mem7", false, "Memento 7");
	settings.Add("mem8", false, "Memento 8");

	settings.CurrentDefaultParent = "memG";
	settings.Add("mem9", false, "Memento 9");
	settings.Add("mem10", false, "Memento 10");
	settings.Add("mem12", false, "Memento 11");
	settings.Add("mem13", false, "Memento 12");
	settings.Add("mem14", false, "Memento 13");
	settings.Add("mem15", false, "Memento 14");
	settings.Add("mem11", false, "Memento 15");

	settings.CurrentDefaultParent = "memB";
	settings.Add("mem16", false, "Memento 16");
	settings.Add("mem17", false, "Memento 17");
	settings.Add("mem18", false, "Memento 18");
	settings.Add("mem19", false, "Memento 19");
	settings.Add("mem20", false, "Memento 20");

	settings.CurrentDefaultParent = "memY";
	settings.Add("mem21", false, "Memento 22");
	settings.Add("mem22", false, "Memento 23");
	settings.Add("mem23", false, "Memento 24");
	settings.Add("mem24", false, "Memento 25");
	settings.Add("mem25", false, "Memento 26");
	settings.Add("mem26", false, "Memento 27");
	settings.Add("mem27", false, "Memento 28");

	settings.CurrentDefaultParent = "achievements";
	settings.Add("achColor", false, "Colors");
	settings.Add("achGrief", false, "Griefs");
	settings.Add("achInteraction", false, "Interactions");

	settings.Add("ach15", false, "Mementos");
	settings.Add("ach16", false, "Childhood");
	settings.Add("ach14", false, "The End");

	settings.CurrentDefaultParent = "achColor";
	settings.Add("ach0", false, "Red");
	settings.Add("ach2", false, "Green");
	settings.Add("ach6", false, "Blue");
	settings.Add("ach9", false, "Yellow");

	settings.CurrentDefaultParent = "achGrief";
	settings.Add("ach1", false, "Denial");
	settings.Add("ach3", false, "Anger");
	settings.Add("ach7", false, "Bargaining");
	settings.Add("ach10", false, "Depression");
	settings.Add("ach12", false, "Acceptance");
	
	settings.CurrentDefaultParent = "achInteraction";
	settings.Add("ach4", false, "Sandstorm");
	settings.Add("ach5", false, "Inuksuit");
	settings.Add("ach8", false, "Apples");
	settings.Add("ach11", false, "Eel");
	settings.Add("ach13", false, "Magic fowls");	

	vars.ReadPointers = (Func<Process, IntPtr, int[], IntPtr>)((proc, basePtr, offsets) => {
		IntPtr ptr = basePtr;
		foreach(int offset in offsets) {
			proc.ReadPointer((IntPtr)(ptr+offset), out ptr);
		}
		return ptr;
	});
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

	vars.scenes = new HashSet<string>();
	vars.curSceneVer = vars.oldSceneVer = 0;

	vars.oldFadeColor = vars.curFadeColor = 0;
	vars.curIsStarted = vars.oldIsStarted = 0;
	vars.curStartDuration = vars.oldStartDuration = 0;

	vars.oldColor = vars.curColor = 0;
	vars.oldPower = vars.curPower = 0;
	vars.initPower = 0;
	vars.oldConstellation = vars.curConstellation = 0;

	vars.mementoList = new List<byte>();
	vars.curMemento = vars.oldMemento = -1;

	vars.achievementList = new List<byte>();
	vars.curAchievement = vars.oldAchievement = -1;

	vars.timerResetVars = (EventHandler)((s, e) => {
		vars.oldColor = vars.curColor = 0;
		vars.oldPower = vars.curPower = 0;
		vars.initPower = 0;
		vars.oldConstellation = vars.curConstellation = 0;
		vars.curMemento = vars.oldMemento = -1;
		vars.curAchievement = vars.oldAchievement = -1;

		vars.mementoList.Clear();
		for(byte i = 0; i < 28; i++)
			if(settings["mem"+i]) vars.mementoList.Add(i);

		vars.achievementList.Clear();
		for(byte i = 0; i < 17; i++)
			if(settings["ach"+i]) vars.achievementList.Add(i);
	});
	timer.OnStart += vars.timerResetVars;

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

		//Power
		vars.nextPower = game.ReadValue<byte>((IntPtr)(vars.ReadPointers(game, mainManager, new int[] {0xD0, 0x20, 0x28})+0x20+0x1*vars.curPower));
		if(vars.initPower == 1) {
			vars.oldPower = vars.curPower;
			if(vars.nextPower == 1) {
				vars.curPower++;
			}			
		} else if(vars.nextPower == 0) {
			vars.initPower = 1;
		}

		//Color
		vars.nextColor = game.ReadValue<byte>((IntPtr)(vars.ReadPointers(game, mainManager, new int[] {0xD0, 0x28, 0x28})+0x20+0x1*vars.curColor));
		vars.oldColor = vars.curColor;
		if(vars.nextColor == 1) {
			if(vars.curColor == 0 || vars.curColor == 1) vars.curColor += 2;
			else if(vars.curColor == 2) vars.curColor--;
			else vars.curColor++;
		}

		//Hub Constellation
		vars.oldConstellation = vars.curConstellation;
		vars.curConstellation = game.ReadValue<int>(game.ReadPointer(mainManager+0xD0)+0x5C);

		//Memento
		vars.oldMemento = vars.curMemento;
		var collectibles = vars.ReadPointers(game, mainManager, new int[] {0xD0, 0x30});
		foreach(byte offset in vars.mementoList) {
			if(game.ReadValue<byte>(game.ReadPointer((IntPtr)collectibles+0x20+0x8*offset)+0x14) == 1) {
				vars.curMemento = offset;
				break;
			}
		}
		if(vars.curMemento != vars.oldMemento) vars.mementoList.Remove(vars.curMemento);

		//Achievement
		vars.oldAchievement = vars.curAchievement;
		var achievements = vars.ReadPointers(game, mainManager, new int[] {0x118, 0x18, 0x10});
		foreach(byte offset in vars.achievementList) {
			if(game.ReadValue<byte>(game.ReadPointer((IntPtr)achievements+0x20+0x8*offset)+0x50) == 1) {
				vars.curAchievement = offset;
				break;
			}
		}
		if(vars.curAchievement != vars.oldAchievement) vars.achievementList.Remove(vars.curAchievement);
	}
}

start {
	return vars.scenes.Contains("Assets/Scenes/Flow/Menus/Main Menu/MainMenu.unity") && vars.curIsStarted == 1 && vars.curStartDuration == 1;
}

split {
	if(vars.oldPower != vars.curPower)
		return settings["power"+vars.oldPower];

	if(vars.oldColor != vars.curColor)
		return settings["color"+vars.oldColor];

	if(vars.oldConstellation != vars.curConstellation)
		return settings["const"+vars.curConstellation];

	if(vars.curMemento != vars.oldMemento)
		return settings["mem"+vars.curMemento];

	if(vars.curAchievement != vars.oldAchievement)
		return settings["ach"+vars.curAchievement];

	if(vars.curColor == 6 && vars.oldFadeColor == 0x3F41C1C2 && vars.curFadeColor == 0)
		return settings["end"];
}

shutdown {
	timer.OnStart -= vars.timerResetVars;
}