state("Kunai") {}

startup {
    refreshRate = 0.5;

    settings.Add("weapons", false, "Weapons");
    settings.Add("events", false, "Events");
    settings.Add("scenes", false, "Scenes (split when entering the zone)");
    settings.Add("upgrades", false, "Upgrades");

    settings.CurrentDefaultParent = "weapons";
    settings.Add("weapon_1", false, "Katana");
	settings.Add("weapon_64", false, "Right Kunai");
	settings.Add("weapon_32", false, "Left Kunai");
	settings.Add("weapon_4", false, "Shuriken");
	settings.Add("weapon_8", false, "P90");
	settings.Add("weapon_16", false, "Rocket Launcher");
	// settings.Add("weapon_2", false, "Scythe (???)");
    
    settings.CurrentDefaultParent = "events";
    settings.Add("event_4", false, "Killed First Boss");
    settings.Add("event_8", false, "Resistance Camp Destroyed");
    settings.Add("event_1", false, "Picked Up Air Base Core");
    settings.Add("event_2", false, "Delivered Air Base Core");
    settings.Add("event_16", false, "Shrine Boss Killed");
    settings.Add("event_32", false, "Spider Boss Killed");
    settings.Add("event_64", false, "Blob Boss Killed");
    settings.Add("event_4096", false, "Cave Collapsed");
    settings.Add("event_128", false, "Zen Boss Killed");
    settings.Add("event_8192", false, "Lava Flow Enabled");
    settings.Add("event_16384", false, "Joined Church Of Skebin");
    settings.Add("event_1024", false, "Got Captured");
    settings.Add("event_2048", false, "Got Weapons Back");
    settings.Add("event_256", false, "Escaped From Prison");
    settings.Add("event_32768", false, "Flew To Mars");
    settings.Add("event_512", false, "Completed Dream Sequence");
    settings.Add("event_lemonkus", false, "Lemonkus Killed (test)");

    settings.CurrentDefaultParent = "scenes";
    // settings.Add("scene_FallenCity", false, "Fallen City");
    settings.Add("scene_Forest", false, "Forest");
    settings.Add("scene_Desert", false, "Desert");
    settings.Add("scene_Subway", false, "Subway");
    settings.Add("scene_Factory", false, "Factory");
    settings.Add("scene_Caves", false, "Caves");
    settings.Add("scene_ZenMountains", false, "Zen Mountains");
    settings.Add("scene_City", false, "City");
    settings.Add("scene_AirBase", false, "Air Base");
    settings.Add("scene_Mars", false, "Mars");

    settings.CurrentDefaultParent = "upgrades";
	settings.Add("upgrade_32", false, "Map");
	settings.Add("upgrade_2", false, "Extra Jump");
	settings.Add("upgrade_4", false, "Dash");

	settings.Add("upgrade_16", false, "Solar Panel");
	settings.Add("upgrade_64", false, "Coin Magnet");
	// settings.Add("upgrade_128", false, "NOT_USED");
	settings.Add("upgrade_256", false, "Charge Attack");
	settings.Add("upgrade_512", false, "Attunement");
	settings.Add("upgrade_4096", false, "Slingshot");
	settings.Add("upgrade_8192", false, "Lightning Strike");
	settings.Add("upgrade_16384", false, "Steady Ground");
	settings.Add("upgrade_32768", false, "Shotgun Blast");
	settings.Add("upgrade_65536", false, "Clip Size");
	settings.Add("upgrade_131072", false, "Precision");
	settings.Add("upgrade_262144", false, "Missile Barrage");
	settings.Add("upgrade_524288", false, "Rocket Jump");
	settings.Add("upgrade_1048576", false, "Recoil Reduction");

    settings.Add("upgrade_1", false, "Focus Chip");
	settings.Add("upgrade_8", false, "Zen Mode Chip");
	settings.Add("upgrade_1024", false, "Soulbound");
	settings.Add("upgrade_2097152", false, "Cellular Network");
	// settings.Add("upgrade_4194304", false, "Exploit");
	// settings.Add("upgrade_8388608", false, "GodMode");

    vars.visitedScenes = new HashSet<string>();

    vars.ResetVars = (EventHandler)((s, e) => {
        vars.visitedScenes = new HashSet<string>();
    });
    timer.OnStart += vars.ResetVars;

    vars.scanGameLoad = new SigScanTarget(0, "55 8B EC 56 83 EC 24 8B 75 08 B8 ?? ?? ?? ?? 8B 4D 0C 89 08");

    vars.scanPlayerSystem = new SigScanTarget(0, "90 E8 ?? ?? ?? ?? 85 C0 74 38 BA");
}

init {
    IntPtr ptrGameLoad = IntPtr.Zero;
    IntPtr ptrPlayerSystem = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(ptrGameLoad == IntPtr.Zero && (ptrGameLoad = scanner.Scan(vars.scanGameLoad)) != IntPtr.Zero)
            print("[Autosplitter] Game:Load Found : " + ptrGameLoad.ToString("X"));

        if(ptrPlayerSystem == IntPtr.Zero && (ptrPlayerSystem = scanner.Scan(vars.scanPlayerSystem)) != IntPtr.Zero)
            print("[Autosplitter] PlayerSystem Found : " + ptrPlayerSystem.ToString("X"));

        if(ptrGameLoad != IntPtr.Zero && ptrGameLoad != IntPtr.Zero)
            break;
    }

    if(ptrGameLoad == IntPtr.Zero || ptrGameLoad == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");
    
    vars.watchers = new MemoryWatcherList() {
        (vars.isLoading = new MemoryWatcher<bool>(new DeepPointer(ptrGameLoad+0x3E, 0x0, 0x20))),

        (vars.scene = new StringWatcher(new DeepPointer(ptrGameLoad+0x8D, 0x0, 0x20, 0xC), 64)),
        (vars.playtime = new MemoryWatcher<float>(new DeepPointer(ptrGameLoad+0x8D, 0x0, 0x44))),
        (vars.weapons = new MemoryWatcher<int>(new DeepPointer(ptrGameLoad+0x8D, 0x0, 0x50))),
        (vars.upgrades = new MemoryWatcher<int>(new DeepPointer(ptrGameLoad+0x8D, 0x0, 0x54))),
        (vars.worldEvents = new MemoryWatcher<int>(new DeepPointer(ptrGameLoad+0x8D, 0x0, 0x68))),

        (vars.controlsDisableStack = new MemoryWatcher<int>(new DeepPointer(ptrPlayerSystem+0xB, 0x24, 0x4, 0x0, 0x0C, 0x10, 0xCC)))
    };

    refreshRate = 200/3d;
}

start {
    return !vars.isLoading.Old && vars.isLoading.Current && vars.playtime.Current == 0;
}

update {
    vars.watchers.UpdateAll(game);
}

split {
    if(vars.weapons.Changed) {
        return settings["weapon_"+(vars.weapons.Old^vars.weapons.Current)];
    }

    if(vars.worldEvents.Changed) {
        return settings["event_"+(vars.worldEvents.Old^vars.worldEvents.Current)];
    }

    if(vars.controlsDisableStack.Old == 1 && vars.controlsDisableStack.Current == 2 && vars.scene.Current.Equals("Mars")) {
        return settings["event_lemonkus"];
    }

    if(vars.scene.Changed && vars.visitedLevels.Add(vars.scene.Current)) {
        return settings["scene_"+vars.scene.Current];
    }

    if(vars.upgrades.Changed) {
        return settings["upgrade_"+(vars.upgrades.Old^vars.upgrades.Current)];
    }
}

isLoading {
    return vars.isLoading.Current;
}

shutdown {
    timer.OnStart -= vars.ResetVars;
}