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
    // settings.Add("item1", false, "Sword");
    settings.Add("item2", false, "Coffee");
    settings.Add("item3", false, "Flashlight");
    settings.Add("item4", false, "Flippers");
    settings.Add("item5", false, "Lighthouse Key");
    settings.Add("item6", false, "Watering Can");
    settings.Add("item7", false, "Sword Thrower");
    settings.Add("item8", false, "Fast Shoes");
    settings.Add("item9", false, "Gardening Glove");
    settings.Add("item10", false, "Boatwood");
    settings.Add("item11", false, "Camera");
    settings.Add("item12", false, "Basement Key");
    settings.Add("item13", false, "Mega Sword");
    // settings.Add("item15", false, "Broken Sword");
    settings.Add("item16", false, "Press Pass");
    settings.Add("item17", false, "Turbo Ink");
    settings.Add("item18", false, "Grinder");
    settings.Add("item19", false, "Trophy");

    settings.CurrentDefaultParent = "coins";
    settings.Add("coin0", false, "House");
    settings.Add("coin1", false, "Coffee Sewer Out");
    settings.Add("coin2", false, "Snake Cave");
    settings.Add("coin3", false, "Hostel");
    settings.Add("coin4", false, "Quicksand");
    settings.Add("coin5", false, "Coffee Sewer In");
    settings.Add("coin6", false, "Coffee Headland");
    settings.Add("coin7", false, "Lost Truck");
    settings.Add("coin8", false, "Temple Bat");
    settings.Add("coin9", false, "Temple Death");
    settings.Add("coin10", false, "Dumpster");
    settings.Add("coin11", false, "Bandits");
    settings.Add("coin12", false, "Turtle Island");
    settings.Add("coin13", false, "Waterfall");
    settings.Add("coin14", false, "Secret Wall");
    settings.Add("coin15", false, "Waiting Room");
    settings.Add("coin16", false, "Factory Sewer");
    settings.Add("coin17", false, "Drill");
    settings.Add("coin18", false, "Factory Truck");

    settings.CurrentDefaultParent = "hpups";
    settings.Add("hpup0", false, "Flower");
    settings.Add("hpup1", false, "Bird");
    settings.Add("hpup2", false, "Secret Temple");
    settings.Add("hpup3", false, "Bull");
    settings.Add("hpup4", false, "Sneaker Hut");
    settings.Add("hpup5", false, "Dog");

    settings.CurrentDefaultParent = "maps";
    settings.Add("map9", false, "Desert House");
    settings.Add("map22", false, "Lost Person");
    settings.Add("map24", false, "Lost Person (SecondRun)");
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

    vars.ItemNumber = (Func<bool[], int>)((itemArray) => {
        var nbTrue = 0;
        for(int i = 0; i < itemArray.Length; i++) {
            if(itemArray[i]) nbTrue++;
        }
        return nbTrue;
    });

    vars.SearchNewItem = (Func<string, string, bool[], int, string>)((line, type, itemArray, start) => {
        var itemId = line.IndexOf("\""+type+"\\", start, StringComparison.Ordinal)+11;
        for(int i = 0; i < itemArray.Length; i++) {
            if(line.Substring(itemId+10*i, 1).Equals("1") && !itemArray[i]) {
                itemArray[i] = true;
                return type+i;
            }
        }
        return vars.itemToSplit;
    });

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.transitionsDone.Clear();
        vars.igtime = new TimeSpan();
        vars.gameTimeWatch.Restart();

        vars.items = new bool[20];
        vars.items[0] = vars.items[1] = true;
        vars.coins = new bool[19];
        vars.hpups = new bool[6];

        vars.slotId = 0;
        vars.itemToSplit = "";
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    vars.watchers = new MemoryWatcherList();
    
    if(modules.First().ModuleMemorySize == 0x613000) { //ver1.0.0.0 Release
        vars.map = new MemoryWatcher<int>(new DeepPointer(0x005DA568));
        vars.end = new MemoryWatcher<byte>(new DeepPointer(0x005DC900));
        vars.isDead = new MemoryWatcher<int>(new DeepPointer(0x003D8104, 0x0, 0x28, 0x1C, 0xBC));
        vars.isItem = new MemoryWatcher<int>(new DeepPointer(0x003D8104, 0x0, 0x0, 0x4, 0x4BC, 0xBC));
        var appdata = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
        vars.savePath = appdata.Substring(0, appdata.LastIndexOf('\\')) + @"\Local\minit\minitSaves\minit_v1.sav";
    }
    if(modules.First().ModuleMemorySize == 0x784000) { //ver1.0.0.3 Speedrun
        vars.map = new MemoryWatcher<int>(new DeepPointer(0x006AAA58));
        vars.end = new MemoryWatcher<byte>(new DeepPointer(0x006ACDF0));
        vars.isDead = new MemoryWatcher<int>(new DeepPointer(0x00498610, 0x0, 0x20, 0xC, 0x68));
        vars.isItem = new MemoryWatcher<int>(new DeepPointer(0x00498610, 0x0, 0x3F0, 0xC, 0x8, 0x10, 0x490, 0x84, 0x7E8));
        var steamPath = Environment.GetFolderPath(Environment.SpecialFolder.ProgramFilesX86) + @"\Steam\userdata";
        vars.savePath = Directory.GetDirectories(steamPath)[0] + @"\609490\remote\minit_v1.sav";
    }

    vars.lastTimeChange = File.GetLastWriteTime(vars.savePath).Ticks;

    vars.transitionsDone = new HashSet<string>();
    vars.igtime = new TimeSpan();
    vars.gameTimeWatch = new Stopwatch();

    vars.items = new bool[20];
    vars.items[0] = vars.items[1] = true;
    vars.coins = new bool[19];
    vars.hpups = new bool[6];

    vars.slotId = 0;
    vars.itemToSplit = "";
}

update {
    vars.map.Update(game);
    vars.isDead.Update(game);
    vars.isItem.Update(game);
    vars.end.Update(game);

    if((vars.isItem.Old == 0 && vars.isItem.Current == 1) || (vars.end.Old == 0 && vars.end.Current == 128))
        vars.gameTimeWatch.Stop();

    if(vars.isDead.Old == 1 && vars.isDead.Current == 0 && vars.map.Current != 2)
        vars.gameTimeWatch.Restart();

    if(vars.lastTimeChange < File.GetLastWriteTime(vars.savePath).Ticks) {
        vars.lastTimeChange = File.GetLastWriteTime(vars.savePath).Ticks;
    
        var fileStream = new FileStream(vars.savePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
        using(StreamReader reader = new StreamReader(fileStream)) {
            while (reader.Peek() >= 0) {
                StringComparison strComp = StringComparison.Ordinal;
                
                var line = reader.ReadLine();
                
                if(vars.slotId == 0) {
                    var slot = line.Substring((vars.slotId = line.IndexOf("currentSlot", 300, strComp))+16, 1);                         //422
                    if(slot.Equals("0"))        //759
                        vars.slotId = line.IndexOf("\"slot0\\", vars.slotId+200, strComp);
                    else if(slot.Equals("2"))   //17238
                        vars.slotId = line.IndexOf("\"slot2\\", vars.slotId+16700, strComp);
                    else if(slot.Equals("1")) { //33711
                        vars.slotId = line.IndexOf("\"slot2\\", vars.slotId+16700, strComp);
                        bool slotEmpty = line.Substring(vars.slotId+10, 33).Equals("{ \\\"slotIsEmpty\\\": [ 1.000000 ] }");
                        vars.slotId = line.IndexOf("\"slot1\\", (slotEmpty ? vars.slotId : vars.slotId+16000), strComp);
                    }
                }

                var readId = vars.slotId;

                var nbCoin = int.Parse(line.Substring((readId = line.IndexOf("\"coins\\", readId, strComp))+12, 2).Split('.')[0]);      //1679
                var nbHpup = int.Parse(line.Substring((readId = line.IndexOf("\"hpups\\", readId, strComp))+12, 1));                    //1875

                readId += 12000;
                if(nbCoin != vars.ItemNumber(vars.coins))                                                                               //14677
                    vars.itemToSplit = vars.SearchNewItem(line, "coin", vars.coins, readId);

                var nbItem = int.Parse(line.Substring((readId = line.IndexOf("\"items\\", readId, strComp))+12, 2).Split('.')[0])+1;    //15081
    
                string lineTime = line.Substring((readId = line.IndexOf("time", readId, strComp))+10);                                  //15174
                TimeSpan baseIgt = TimeSpan.FromSeconds(int.Parse(lineTime.Substring(0, lineTime.IndexOf(".", strComp)))/60f);
                int factor = (int)Math.Pow(10, 5);
                vars.igtime = new TimeSpan(((long)Math.Round((1.0f*baseIgt.Ticks/factor))*factor));

                if(nbHpup != vars.ItemNumber(vars.hpups))
                    vars.itemToSplit = vars.SearchNewItem(line, "hpup", vars.hpups, readId);                                            //15656
                
                if(settings["item19"] && !vars.items[19] && line.Substring(line.IndexOf("\"item\\", readId, strComp)+201, 1).Equals("1")) {
                    vars.items[19] = true;
                    vars.itemToSplit = "item19";
                } else if(nbItem != vars.ItemNumber(vars.items))
                    vars.itemToSplit = vars.SearchNewItem(line, "item", vars.items, readId);                                     //16196

                if(vars.isDead.Current != 1)
                    vars.gameTimeWatch.Restart();
                else
                    vars.gameTimeWatch.Reset();

                if(vars.map.Current == 128 && timer.CurrentPhase == TimerPhase.Ended) {
                    Time splitTime = timer.Run.Last().SplitTime;
                    splitTime.GameTime = vars.igtime;
                    timer.Run.Last().SplitTime = splitTime;
                }
            }
        }
    }

    if(vars.map.Current == 2 && timer.CurrentPhase == TimerPhase.Ended) {
        Time splitTime = timer.Run.Last().SplitTime;
        splitTime.GameTime = vars.igtime;
        timer.Run.Last().SplitTime = splitTime;
    }
}

start {
    return vars.map.Current == 91 && vars.isItem.Old == 1 && vars.isItem.Current == 0;
}

split {
    if((vars.map.Changed && vars.map.Current == 2) || (vars.end.Old == 0 && vars.end.Current == 128))
        return settings["end"];

    if (!vars.itemToSplit.Equals("")) {
        var itemSplit = vars.itemToSplit;
        vars.itemToSplit = "";
        if(settings.ContainsKey(itemSplit) && settings[itemSplit]) return true;
    }

    if(vars.isDead.Old == 1 && vars.isDead.Current == 0 && settings.ContainsKey("map"+vars.map.Old) && settings["map"+vars.map.Old])
        return true;

    if(vars.map.Old != vars.map.Current) {
        var trans = "trans"+vars.map.Old+"_"+vars.map.Current;
        if(settings.ContainsKey(trans) && settings[trans] && vars.transitionsDone.Add(trans))
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
    return vars.igtime + vars.gameTimeWatch.Elapsed;
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}