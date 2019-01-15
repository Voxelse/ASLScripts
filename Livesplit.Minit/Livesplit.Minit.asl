state ("minit") {}

startup {
    settings.Add("toilet", true, "Toilet");
    settings.Add("items", false, "Items");
    settings.SetToolTip("items", "Split after items obtained");
    settings.Add("coins", false, "Coins");
    settings.SetToolTip("coins", "Split after coins obtained");
    settings.Add("hearts", false, "Hearts");
    settings.SetToolTip("hearts", "Split after hearts obtained");
    settings.Add("maps", false, "Maps");
    settings.SetToolTip("maps", "Split after dying in maps");
    settings.Add("trans", false, "Transition");
    settings.SetToolTip("trans", "Split after map transition");

    settings.CurrentDefaultParent = "items";
    settings.Add("item16", false, "Watering Can");
    settings.Add("item17", false, "Gardening glove");
    settings.Add("item26", false, "Fast Shoes");
    settings.Add("item32", false, "Turbo Ink");
    settings.Add("item45", false, "Sword Thrower");
    settings.Add("item48", false, "Flippers");
    settings.Add("item66", false, "Press Pass (No SecondRun) [Speedrun Version] & Boatwood (SecondRun only) [Release Version]");
    settings.Add("item68", false, "Camera [Release Version only]");
    settings.Add("item71", false, "Boatwood");
    settings.Add("item73", false, "Lighthouse Key");
    settings.Add("item79", false, "Coffee");
    settings.Add("item90", false, "Flashlight");
    settings.Add("item91", false, "Sword (Start)");
    settings.Add("item101", false, "Basement Key");
    settings.Add("item111", false, "Grinder");
    settings.Add("item117", false, "Mega Sword");
    settings.Add("item128", false, "Broken Sword (Boss)");
    settings.Add("item136", false, "Trophy");

    settings.CurrentDefaultParent = "coins";
    settings.Add("item14", false, "Quicksand");
    settings.Add("item25", false, "Sneaker Hut Dumpster");
    //settings.Add("item27", false, "Secret Temple Deaths");  Unavailable since heart on same map
    settings.Add("item39", false, "Secret Temple Bat");
    settings.Add("item43", false, "Lost Truck");
    settings.Add("item46", false, "Hotel");
    settings.Add("item49", false, "Bandits");
    settings.Add("item56", false, "Coffee Sewer Out");
    settings.Add("item72", false, "Waterfall");
    settings.Add("item74", false, "Snake Cave");
    //settings.Add("item76", false, "Home");  Unavailable since heart on same map
    settings.Add("item81", false, "Coffee Headland");
    settings.Add("item84", false, "Coffee Sewer In");
    settings.Add("item97", false, "Turtle Island");
    settings.Add("item104", false, "Island House (SecondRun only)");
    settings.Add("item119", false, "Drill");
    settings.Add("item122", false, "Waiting Room");
    settings.Add("item125", false, "Factory Truck");
    settings.Add("item126", false, "Sneaker Hut Wall");
    settings.Add("item129", false, "Factory Sewer");


    settings.CurrentDefaultParent = "hearts";
    settings.Add("item11", false, "Bull");
    //settings.Add("item27", false, "Sneaker Hut");  Unavailable since coin on same map
    settings.Add("item34", false, "Secret Temple");
    settings.Add("item35", false, "Secret Temple (SecondRun only)");
    settings.Add("item51", false, "Bird");
    //settings.Add("item76", false, "Dog");  Unavailable since coin on same map
    settings.Add("item76", false, "Dog (SecondRun only)");
    settings.Add("item77", false, "Flower");

    settings.CurrentDefaultParent = "maps";
    settings.Add("map9", false, "Desert House");
    settings.Add("map22", false, "Lost Person");
    settings.Add("map24", false, "Lost Person (SecondRun only)");
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
    settings.Add("map117", false, "Cog");

    settings.Add("map40_9",  false, "Temple - Desert House");
    settings.Add("map40_47", false, "Temple - Hotel House");
    settings.Add("map40_76", false, "Temple - Start House");
    settings.Add("map40_104",false, "Temple - Island House");

    settings.CurrentDefaultParent = "trans";
    settings.Add("trans49_53",  false, "Bandit Resident to Card Resident");
    settings.Add("trans62_63",  false, "Bombs to Bridge");
    settings.Add("trans70_71",  false, "Sake Cave to Outside");
    settings.Add("trans112_128",  false, "Enter Boss");

    // Tentacles
    // 29   Left Desert
    // 33   Tentacle House
    // 57   Left from Camera
    // 85   Shark
    // 97   Turtle Island
    // 100  Boat ride
    // 109  Home Island Labyrinth
    // 123  Factory Paper
}

init {
    vars.watchers = new MemoryWatcherList();
    
    if(modules.First().ModuleMemorySize == 0x613000) { //ver1.0.0.0 Release
        vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x005DA568)) {Name = "map"});
        vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x003D8104, 0x0, 0x28, 0x1C, 0xBC)) {Name = "isDead"});
        vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x003D8104, 0x0, 0x0, 0x4, 0x4BC, 0xBC)) {Name = "isItem"});
    }
    if(modules.First().ModuleMemorySize == 0x784000) { //ver1.0.0.3 Speedrun
        vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x006AAA58)) {Name = "map"});
        vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x00498610, 0x0, 0x20, 0xC, 0x68)) {Name = "isDead"});
        vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x00498610, 0x0, 0x3F0, 0xC, 0x8, 0x10, 0x490, 0x84, 0x7E8)) {Name = "isItem"});
    }
}
update {
    vars.watchers.UpdateAll(game);
}

start {
    return vars.watchers["map"].Old == 0 && (vars.watchers["map"].Current == 76 || vars.watchers["map"].Current == 91);
}

split {
    if (vars.watchers["isItem"].Old == 1 && vars.watchers["isItem"].Current == 0)
        return settings.ContainsKey("item"+vars.watchers["map"].Current) && settings["item"+vars.watchers["map"].Current];

    if(vars.watchers["map"].Old != vars.watchers["map"].Current && vars.watchers["map"].Current == 2)
        return settings["toilet"];

    if(vars.watchers["isDead"].Old == 1 && vars.watchers["isDead"].Current == 0) {
        if(vars.watchers["map"].Old == 40) // Temple Death
            return settings["map40_"+vars.watchers["map"].Current];
        return settings.ContainsKey("map"+vars.watchers["map"].Old) && settings["map"+vars.watchers["map"].Old];
    }

    if(vars.watchers["map"].Old != vars.watchers["map"].Current)
        return settings.ContainsKey("trans"+vars.watchers["map"].Old+"_"+vars.watchers["map"].Current) && settings["trans"+vars.watchers["map"].Old+"_"+vars.watchers["map"].Current];
}

reset {
    return vars.watchers["map"].Current == 0;
}