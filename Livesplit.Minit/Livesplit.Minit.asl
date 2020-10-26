state ("minit") {}

startup {
    settings.Add("end", true, "End (Boss/Toilet)");
    
    settings.Add("items", false, "Items");
    settings.SetToolTip("items", "Split after items obtained");
    
    settings.Add("coins", false, "Coins");
    settings.SetToolTip("coins", "Split after coins obtained");
    
    settings.Add("hpups", false, "Hearts");
    settings.SetToolTip("hpups", "Split after hearts obtained");
    
    settings.Add("maps", false, "Deaths");
    settings.SetToolTip("maps", "Split after dying in maps");
    
    settings.Add("trans", false, "Transitions");
    settings.SetToolTip("trans", "Split on map transitions");

    settings.CurrentDefaultParent = "items";
    settings.Add("item16", false, "Watering Can");
    settings.Add("item17", false, "Gardening Glove");
    settings.Add("item26", false, "Fast Shoes");
    settings.Add("item32", false, "Turbo Ink");
    settings.Add("item45", false, "Sword Thrower");
    settings.Add("item48", false, "Flippers");
    settings.Add("item68", false, "Camera)");
    settings.Add("item67", false, "Press Pass");
    settings.Add("item66_1", false, "Press Pass (Second Run)");
    settings.Add("item66_2", false, "Boatwood (Second Run)");
    settings.Add("item71", false, "Boatwood");
    settings.Add("item73", false, "Lighthouse Key");
    settings.Add("item79", false, "Coffee");
    settings.Add("item90", false, "Flashlight");
    settings.Add("item101", false, "Basement Key");
    settings.Add("item111", false, "Grinder");
    settings.Add("item117", false, "Mega Sword");
    settings.Add("item136", false, "Trophy");

    settings.CurrentDefaultParent = "coins";
    settings.Add("item14", false, "Quicksand");
    settings.Add("item25", false, "Dumpster");
    settings.Add("item27_1", false, "Temple Death");
    settings.Add("item39", false, "Temple Bat");
    settings.Add("item43", false, "Lost Truck");
    settings.Add("item46", false, "Hostel");
    settings.Add("item49", false, "Bandits");
    settings.Add("item56", false, "Coffee Sewer Out");
    settings.Add("item72", false, "Waterfall");
    settings.Add("item74", false, "Snake Cave");
    settings.Add("item76_1", false, "Home");
    settings.Add("item81", false, "Coffee Headland");
    settings.Add("item84", false, "Coffee Sewer In");
    settings.Add("item97", false, "Turtle Island");
    settings.Add("item104", false, "Island House (Second Run)");
    settings.Add("item119", false, "Drill");
    settings.Add("item122", false, "Waiting Room");
    settings.Add("item125", false, "Factory Truck");
    settings.Add("item126", false, "Secret Wall");
    settings.Add("item129", false, "Factory Sewer");

    settings.CurrentDefaultParent = "hpups";
    settings.Add("item11", false, "Bull");
    settings.Add("item27_2", false, "Sneaker Hut");
    settings.Add("item34", false, "Secret Temple");
    settings.Add("item35", false, "Secret Temple (Second Run)");
    settings.Add("item51", false, "Bird");
    settings.Add("item76_2", false, "Dog");
    settings.Add("item77", false, "Flower");

    settings.CurrentDefaultParent = "maps";
    settings.Add("map9", false, "Desert House");
    settings.Add("map22", false, "Lost Person");
    settings.Add("map24", false, "Lost Person (Second Run)");
    settings.Add("map29", false, "Desert Tentacle");
    settings.Add("map47", false, "Hotel House");
    settings.Add("map52", false, "Tree Resident");
    settings.Add("map59", false, "Diver");
    settings.Add("map65", false, "Box Resident");
    settings.Add("map76", false, "Start House");
    settings.Add("map85", false, "Coffee Sewers Shark");
    settings.Add("map97", false, "Turtle Island");
    settings.Add("map102", false, "Island Bottom Puzzle");
    settings.Add("map103", false, "Island Left Puzzle");
    settings.Add("map104", false, "Island House");
    settings.Add("map107", false, "Island Right Puzzle");
    settings.Add("map109", false, "Island Right Tentacle");
    settings.Add("map111", false, "Box Grinder");
    settings.Add("map117", false, "Conveyor Cog");
    settings.Add("map132", false, "Tent House");

    settings.Add("trans40_9", false, "Temple for Desert House");
    settings.Add("trans40_47", false, "Temple for Hotel House");
    settings.Add("trans40_76", false, "Temple for Start House");
    settings.Add("trans40_104", false, "Temple for Island House");

    settings.CurrentDefaultParent = "trans";
    settings.Add("trans8_9", false, "Enter Desert House");
    settings.Add("trans46_47", false, "Enter Hostel House");
    settings.Add("trans48_49", false, "Hotel to Bandits");
    settings.Add("trans49_53", false, "Bandit Resident to Card Resident");
    settings.Add("trans52_50", false, "Tree Resident to Graveyard");
    settings.Add("trans62_63", false, "Bombs to Bridge");
    settings.Add("trans70_71", false, "Sake Cave to Outside");
    settings.Add("trans111_112", false, "Left Conveyor to Right");
    settings.Add("trans113_116", false, "Right Conveyor to Bottom");
    settings.Add("trans120_119", false, "Enter Drill Room");
    settings.Add("trans112_128", false, "Enter Boss Room");

    // Tentacles
    // 29   Left Desert
    // 33   Tentacle House
    // 57   Left from Camera
    // 85   Shark
    // 97   Turtle Island
    // 100  Boat ride
    // 109  Home Island Labyrinth
    // 123  Factory Paper

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.doubleItemRooms = new Dictionary<int, int> {{27, 0},{66, 0},{76, 0}};
        vars.transitionsDone = new HashSet<string>();
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    switch (modules.First().ModuleMemorySize) {
        case 0x613000: version = "Release";
            vars.watchers = new MemoryWatcherList() {
                (vars.map = new MemoryWatcher<int>(new DeepPointer(0x005DA568))),
                (vars.end = new MemoryWatcher<byte>(new DeepPointer(0x005DC900))),
                (vars.isDead = new MemoryWatcher<bool>(new DeepPointer(0x003D8104, 0x0, 0x20, 0xC, 0xBC))),
                (vars.isItem = new MemoryWatcher<bool>(new DeepPointer(0x003D8104, 0x0, 0xEC0, 0xC, 0xBC))),
                (vars.gameTime = new MemoryWatcher<double>(new DeepPointer(0x005DA5A4, 0x80, 0x34, 0x10, 0x1B4, 0x0)))
            };
            break;
        case 0x784000: version = "Speedrun";
            vars.watchers = new MemoryWatcherList() {
                (vars.map = new MemoryWatcher<int>(new DeepPointer(0x006AAA58))),
                (vars.end = new MemoryWatcher<byte>(new DeepPointer(0x006ACDF0))),
                (vars.isDead = new MemoryWatcher<bool>(new DeepPointer(0x00498610, 0x0, 0x20, 0xC, 0x68))),
                (vars.isItem = new MemoryWatcher<bool>(new DeepPointer(0x00498610, 0x0, 0xEC8, 0xC, 0x68))),
                (vars.gameTime = new MemoryWatcher<double>(new DeepPointer(0x006AAA30, 0x80, 0x2C, 0x10, 0xE70, 0x0)))
            };
            break;
        default: version = "Unknown";
            break;
    }
}

update {
    if(version.Equals("Unknown"))
        return false;

    vars.watchers.UpdateAll(game);
}

start {
    return vars.map.Current == 91 && vars.isItem.Old && !vars.isItem.Current;
}

split {
    if(vars.isItem.Old && !vars.isItem.Current) {
        string splitStr = "item"+vars.map.Current;
        if(vars.doubleItemRooms.ContainsKey(vars.map.Current)) {
            return settings[splitStr+"_"+(++vars.doubleItemRooms[vars.map.Current])];
        }
        return settings.ContainsKey(splitStr) && settings[splitStr];
    }

    if(vars.isDead.Old && !vars.isDead.Current) {
        return settings.ContainsKey("map"+vars.map.Old) && settings["map"+vars.map.Old];
    }

    if(vars.map.Old != vars.map.Current) {
        var trans = "trans"+vars.map.Old+"_"+vars.map.Current;
        return settings.ContainsKey(trans) && settings[trans] && vars.transitionsDone.Add(trans);
    }

    if(settings["end"] && ((vars.map.Changed && vars.map.Current == 2) || (vars.map.Current == 128 && vars.end.Old == 0 && vars.end.Current == 128))) {
        return true;
    }
}

reset {
    return vars.map.Changed && vars.map.Current == 0;
}

isLoading {
    return true;
}

gameTime {
    return TimeSpan.FromSeconds(vars.gameTime.Current/60d);
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}