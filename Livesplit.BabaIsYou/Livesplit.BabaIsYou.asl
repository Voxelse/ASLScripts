state("Baba Is You") {}

startup {
    vars.versions = new Dictionary<int, string>() {{0x402000, "GF"}, {0x404000, "GJ"}, {0x405000, "GK"}, {0x412000, "GQ"}, {0x415000, "GR"}};

    vars.addresses = new Dictionary<string, List<int>>() {
        {"GF", new List<int>{0x34A974, 0x34BBC4, 0x34C50C, 0x355E98}},
        {"GJ", new List<int>{0x34C9BC, 0x34DC0C, 0x34E554, 0x357EE8}},
        {"GK", new List<int>{0x34D9D4, 0x34EC24, 0x34F56C, 0x358EF8}},
        {"GQ", new List<int>{0x362BFC, 0x363E4C, 0x364794, 0x36E120}},
        {"GR", new List<int>{0x364E1C, 0x36606C, 0x3669B4, 0x370378}}
    };

    settings.Add("ld", false, "Split at every level done");

    settings.Add("cl", true, "Clear Worlds");
    vars.clearCount = new Dictionary<short, byte>() {
        {177, 15-8}, {207, 18-8}, {206, 10-6}, {16, 20-7}, {169, 20-9}, {87, 15-8}, {180, 12-6}, {179, 15-9}, {182, 16-9}, {232, 9-6}, {282, 7-4}
    };
    
    settings.Add("cp", true, "Complete Worlds");
    
    settings.Add("l", true, "Levels");
    vars.levels = new Dictionary<Tuple<short, string>, HashSet<Tuple<short, string>>>() { {
            Tuple.Create((short)106, "0.Map"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)0, "0: Baba Is You"),
            Tuple.Create((short)1, "1: Where Do I Go?"),
            Tuple.Create((short)189, "2: Now What Is This?"),
            Tuple.Create((short)3, "3: Out Of Reach"),
            Tuple.Create((short)2, "4: Still Out Of Reach"),
            Tuple.Create((short)90, "5: Volcano"),
            Tuple.Create((short)5, "6: Off Limits"),
            Tuple.Create((short)6, "7: Grass Yard"),
            Tuple.Create((short)243, "8: Slideshow"),
            Tuple.Create((short)245, "9: Fragile Existence"),
            Tuple.Create((short)117, "10: Hostile Environment"),
            Tuple.Create((short)78, "?: ?"),
            Tuple.Create((short)203, "Finale: A Way Out?")}
        }, {
            Tuple.Create((short)177, "1.The Lake"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)20, "1: Icy Waters"),
            Tuple.Create((short)212, "2: Turns"),
            Tuple.Create((short)10, "3: Affection"),
            Tuple.Create((short)4, "4: Pillar Yard"),
            Tuple.Create((short)93, "5: Brick Wall"),
            Tuple.Create((short)209, "6: Lock"),
            Tuple.Create((short)15, "7: Novice Locksmith"),
            Tuple.Create((short)8, "8: Locked In"),
            Tuple.Create((short)236, "9: Changeless"),
            Tuple.Create((short)210, "10: Two Doors"),
            Tuple.Create((short)136, "11: Jelly Throne"),
            Tuple.Create((short)30, "12: Crab Storage"),
            Tuple.Create((short)166, "13: Burglary"),
            Tuple.Create((short)211, "Extra 1: Submerged Ruins"),
            Tuple.Create((short)314, "Extra 2: Sunken Shrine")}
        }, {
            Tuple.Create((short)207, "2.Solitary Island"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)310, "0: Poem"),
            Tuple.Create((short)205, "1: Float"),
            Tuple.Create((short)218, "2: Warm River"),
            Tuple.Create((short)171, "3: Bridge Building"),
            Tuple.Create((short)172, "4: Bridge Building?"),
            Tuple.Create((short)234, "5: Victory Spring"),
            Tuple.Create((short)319, "6: Research Facility"),
            Tuple.Create((short)107, "7: Assembly Team"),
            Tuple.Create((short)37, "8: Tiny Pond"),
            Tuple.Create((short)7, "9: Catch The Thief!"),
            Tuple.Create((short)68, "10: Wireless Connection"),
            Tuple.Create((short)65, "11: Prison"),
            Tuple.Create((short)215, "12: Evaporating River"),
            Tuple.Create((short)219, "Extra 1: Boiling River"),
            Tuple.Create((short)173, "Extra 2: ...Bridges?"),
            Tuple.Create((short)41, "Extra 3: Tiny Isle"),
            Tuple.Create((short)134, "Extra 4: Dim Signal"),
            Tuple.Create((short)318, "Extra 5: Dungeon")}
        }, {
            Tuple.Create((short)206, "3.Temple Ruins"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)199, "1: Fragility"),
            Tuple.Create((short)52, "2: Tunnel Vision"),
            Tuple.Create((short)58, "3: A Present For You"),
            Tuple.Create((short)17, "4: Unreachable Shores"),
            Tuple.Create((short)23, "5: But Where's The Key"),
            Tuple.Create((short)33, "6: Love Is Out There"),
            Tuple.Create((short)71, "7: Perilous Gang"),
            Tuple.Create((short)72, "8: Double Moat"),
            Tuple.Create((short)56, "9: Walls Of Gold"),
            Tuple.Create((short)129, "Extra 1: Further Fields")}
        }, {
            Tuple.Create((short)16, "4.Forest Of Fall"),new HashSet<Tuple<short, string>> {
            Tuple.Create((short)238, "1: Hop"),
            Tuple.Create((short)221, "2: Grand Stream"),
            Tuple.Create((short)235, "3: Rocky Road"),
            Tuple.Create((short)62, "4: Telephone"),
            Tuple.Create((short)194, "5: Haunt"),
            Tuple.Create((short)220, "6: Crate Square"),
            Tuple.Create((short)36, "7: Ghost Friend"),
            Tuple.Create((short)26, "8: Ghost Guard"),
            Tuple.Create((short)35, "9: Leaf Chamber"),
            Tuple.Create((short)137, "10: Not There"),
            Tuple.Create((short)160, "11: Catch"),
            Tuple.Create((short)174, "12: Dead End"),
            Tuple.Create((short)77, "A: Literacy"),
            Tuple.Create((short)29, "B: Broken Playground"),
            Tuple.Create((short)269, "C: Fetching"),
            Tuple.Create((short)307, "D: Scenic Pond"),
            Tuple.Create((short)70, "E: Skeletal Door"),
            Tuple.Create((short)239, "Extra 1: Jump"),
            Tuple.Create((short)138, "Extra 2: Even Less There"),
            Tuple.Create((short)308, "Extra 3: Deep Pool")}
        }, {
            Tuple.Create((short)169, "5.Deep Forest"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)66, "1: Renovating"),
            Tuple.Create((short)246, "2: Toolshed"),
            Tuple.Create((short)69, "3: Kepp Out!"),
            Tuple.Create((short)34, "4: Baba Doesn't Respond"),
            Tuple.Create((short)57, "5: Patrol"),
            Tuple.Create((short)85, "6: Canyon"),
            Tuple.Create((short)151, "7: Concrete Goals"),
            Tuple.Create((short)98, "8: Victory In The Open"),
            Tuple.Create((short)191, "9: Moving Floor"),
            Tuple.Create((short)248, "10: Supermarket"),
            Tuple.Create((short)67, "11: Lock The Door"),
            Tuple.Create((short)54, "12: Skull House"),
            Tuple.Create((short)28, "13: Factory"),
            Tuple.Create((short)233, "14: Tiny Pasture"),
            Tuple.Create((short)50, "A: Nearly"),
            Tuple.Create((short)257, "B: Not Quite"),
            Tuple.Create((short)260, "C: Passing Through"),
            Tuple.Create((short)271, "D: Salvage"),
            Tuple.Create((short)268, "E: Insulation"),
            Tuple.Create((short)193, "Extra 1: Crumbling Floor")}
        }, {
            Tuple.Create((short)87, "6.Rocket Trip"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)9, "1: Empty"),
            Tuple.Create((short)11, "2: Lonely Flag"),
            Tuple.Create((short)13, "3: Babas Are You"),
            Tuple.Create((short)80, "4: Please Hold My Key"),
            Tuple.Create((short)201, "5: Horror Story"),
            Tuple.Create((short)111, "6: Aiming High"),
            Tuple.Create((short)112, "7: Trio"),
            Tuple.Create((short)79, "8: Bottleneck"),
            Tuple.Create((short)216, "9: Platformer"),
            Tuple.Create((short)226, "10: The Pit"),
            Tuple.Create((short)115, "11: Heavy Words"),
            Tuple.Create((short)82, "12: Guardians"),
            Tuple.Create((short)217, "13: Sky Hold"),
            Tuple.Create((short)315, "Extra 1: Eye Of A Needle"),
            Tuple.Create((short)125, "Extra 2: Heavy Cloud")}
        }, {
            Tuple.Create((short)180, "7.Flower Garden"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)59, "1: Condition"),
            Tuple.Create((short)94, "2: Thicket"),
            Tuple.Create((short)242, "3: Sorting Facility"),
            Tuple.Create((short)124, "4: Relaxing Spot"),
            Tuple.Create((short)64, "5: Maritime Adventures"),
            Tuple.Create((short)89, "6: Got All This Stuff Here"),
            Tuple.Create((short)150, "7: Blockade"),
            Tuple.Create((short)91, "8: Jaywalkers United"),
            Tuple.Create((short)130, "9: Overgrowth"),
            Tuple.Create((short)92, "10: Adventurers"),
            Tuple.Create((short)142, "Extra 1: Out At Sea"),
            Tuple.Create((short)127, "Extra 2: Secret Garden")}
        }, {
            Tuple.Create((short)179, "8.Volcanic Cavern"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)95, "1: Mouse Hole"),
            Tuple.Create((short)148, "2: Tour"),
            Tuple.Create((short)47, "3: Peril At Every Turn"),
            Tuple.Create((short)266, "4: Fireplace"),
            Tuple.Create((short)146, "5: Torn Apart"),
            Tuple.Create((short)46, "6: Vital Ingredients"),
            Tuple.Create((short)270, "7: Backstage"),
            Tuple.Create((short)101, "8: The Heist"),
            Tuple.Create((short)109, "9: Join The Crew"),
            Tuple.Create((short)119, "10: Automaton"),
            Tuple.Create((short)145, "11: Trick Door"),
            Tuple.Create((short)176, "12: Trapped"),
            Tuple.Create((short)122, "13: Tunnel"),
            Tuple.Create((short)178, "14: Broken Expectations"),
            Tuple.Create((short)51, "Extra 1: Coronation")}
        }, {
            Tuple.Create((short)182, "9.Chasm"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)21, "A: Rocky Prison"),
            Tuple.Create((short)241, "B: Siege"),
            Tuple.Create((short)31, "C: Elusive Condition"),
            Tuple.Create((short)240, "D: Treasury"),
            Tuple.Create((short)19, "E: Looking For A Heart"),
            Tuple.Create((short)110, "F: Lava Flood"),
            Tuple.Create((short)18, "G: Entropy"),
            Tuple.Create((short)25, "H: Floodgates"),
            Tuple.Create((short)60, "I: Lonely Sight"),
            Tuple.Create((short)155, "Extra 1: Metacognition"),
            Tuple.Create((short)164, "Extra 2: Multitool"),
            Tuple.Create((short)175, "Extra 3: Broken"),
            Tuple.Create((short)167, "Extra 4: Alley"),
            Tuple.Create((short)156, "Extra 5: Keke And The Star"),
            Tuple.Create((short)165, "Extra 6: Visiting Baba"),
            Tuple.Create((short)163, "Extra 7: Automated Doors")}
        }, {
            Tuple.Create((short)232, "10. Mountaintop"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)105, "1: Shuffle"),
            Tuple.Create((short)100, "2: Love At First Sight"),
            Tuple.Create((short)195, "3: Solitude"),
            Tuple.Create((short)116, "4: What Is Baba?"),
            Tuple.Create((short)120, "5: Connector"),
            Tuple.Create((short)118, "6: Floaty Platforms"),
            Tuple.Create((short)99, "7: Seeking Acceptance"),
            Tuple.Create((short)104, "8: Tectonic Movements"),
            Tuple.Create((short)48, "Extra 1: The Floatiest Platforms")}
        }, {
            Tuple.Create((short)200, "11. ???"), new HashSet<Tuple<short, string>> {
            // Tuple.Create((short)106, "Enter ???"),
            Tuple.Create((short)192, "1: Glitch"),
            Tuple.Create((short)197, "2: Error"),
            Tuple.Create((short)84, "3: Whoops"),
            Tuple.Create((short)227, "4: Mean Fence"),
            Tuple.Create((short)141, "5: Scale"),
            Tuple.Create((short)272, "6: Parade"),
            Tuple.Create((short)247, "7: Turn The Corner"),
            Tuple.Create((short)231, "8: VIP Area"),
            Tuple.Create((short)250, "9: Tense Atmosphere"),
            Tuple.Create((short)230, "10: Tag Team"),
            Tuple.Create((short)275, "11: Security Check"),
            Tuple.Create((short)168, "12: Ultimate Maze"),
            Tuple.Create((short)-2, "Extra 1: Castle Disaster"), //n2
            Tuple.Create((short)196, "Extra 2: Hazel Den"),
            Tuple.Create((short)-1, "Extra 3: Baba Has Keke"), //n1
            Tuple.Create((short)293, "Secret: Huh?"),
            Tuple.Create((short)294, "Secret: A Prize Well Earned"),
            Tuple.Create((short)306, "Secret: Orb")}
        }, {
            Tuple.Create((short)282, "12. ABC"), new HashSet<Tuple<short, string>> {
            Tuple.Create((short)255, "1: Lunar Gallery"),
            Tuple.Create((short)252, "2: BA"),
            Tuple.Create((short)253, "3: AB"),
            Tuple.Create((short)279, "4: Queue"),
            Tuple.Create((short)280, "5: Wall"),
            Tuple.Create((short)313, "6: Stardrop"),
            Tuple.Create((short)281, "Extra 1: Meteor Strike")}
        }, {
            Tuple.Create((short)264, "13. Depths"), new HashSet<Tuple<short, string>> {
            // Tuple.Create((short)200, "Enter Depths"),
            Tuple.Create((short)261, "1: Cleaning Service"),
            Tuple.Create((short)251, "2: Exercise Hall"),
            Tuple.Create((short)263, "3: Crushers"),
            Tuple.Create((short)262, "4: Collaborative Effort"),
            Tuple.Create((short)265, "5: Living Lands"),
            Tuple.Create((short)274, "Extra 1: Priority Lane"),
            Tuple.Create((short)75, "Extra 2: Secure Cottage"),
            Tuple.Create((short)222, "Extra 3: Hidden Relic"),
            Tuple.Create((short)223, "Extra 4: Buried Treasure"),
            Tuple.Create((short)135, "Extra 5: Endless Corridor")}
        }, {
            Tuple.Create((short)283, "14. Meta"), new HashSet<Tuple<short, string>> {
            // Tuple.Create((short)264, "Enter Meta"),
            Tuple.Create((short)288, "1: Hot Potato"),
            Tuple.Create((short)287, "2: Adventure"),
            Tuple.Create((short)302, "3: Booby Trap"),
            Tuple.Create((short)285, "4: Canister"),
            Tuple.Create((short)291, "5: Avalanche"),
            Tuple.Create((short)132, "6: One-Way Entrance"),
            Tuple.Create((short)295, "7: Bramblevine"),
            Tuple.Create((short)297, "8: Mutual Feelings"),
            Tuple.Create((short)298, "9: Delicate Star"),
            Tuple.Create((short)303, "10: Just No"),
            Tuple.Create((short)289, "11: Acrobatics"),
            Tuple.Create((short)309, "12: The Return Of Scenic Pond"),
            Tuple.Create((short)292, "13: Breaking And Entering"),
            Tuple.Create((short)284, "14: Tangle"),
            Tuple.Create((short)277, "15: The Box"),
            Tuple.Create((short)299, "Extra 1: Hidden Path"),
            Tuple.Create((short)188, "Extra 2: Triplets"),
            Tuple.Create((short)286, "Extra 3: Getting Together")}
        }, {
            Tuple.Create((short)304, "15. Center"), new HashSet<Tuple<short, string>> {
            // Tuple.Create((short)283, "Enter Center"),
            Tuple.Create((short)305, "Gallery"),
            Tuple.Create((short)198, "The End")}
        }
    };

    foreach(KeyValuePair<Tuple<short, string>, HashSet<Tuple<short, string>>> vk in vars.levels) {
        if(vars.clearCount.ContainsKey(vk.Key.Item1))
            settings.Add("cl"+vk.Key.Item1, true, vk.Key.Item2, "cl");
        settings.Add("cp"+vk.Key.Item1, true, vk.Key.Item2, "cp");
        settings.Add("w"+vk.Key.Item1, ((vk.Key.Item1 == 106 || vk.Key.Item1 == 304) ? true : false), vk.Key.Item2, "l");
        foreach(Tuple<short, string> tup in vk.Value)
            settings.Add("l"+tup.Item1, ((tup.Item1 == 203 || tup.Item1 == 198) ? true : false), tup.Item2, "w"+vk.Key.Item1);
    }

    settings.Add("ls", false, "Start on every level change");

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.lastPhase = false;
        vars.levelsDone = new Dictionary<short, HashSet<int>>();
        foreach(KeyValuePair<Tuple<short, string>, HashSet<Tuple<short, string>>> vk in vars.levels) {
            var set = new HashSet<int>();
            foreach(Tuple<short, string> tup in vk.Value)
                set.Add(tup.Item1);
            vars.levelsDone.Add(vk.Key.Item1, set);
        }
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    string verId = vars.versions[modules.First().ModuleMemorySize];

    if(verId == null)  return false;

    version = verId;

    vars.level = new StringWatcher(new DeepPointer(vars.addresses[verId][0], 0x14, 0x30), 8);
    vars.end = new MemoryWatcher<int>(new DeepPointer(vars.addresses[verId][1]));
    vars.menuId = new MemoryWatcher<int>(new DeepPointer(vars.addresses[verId][2]));
    vars.fade = new MemoryWatcher<double>(new DeepPointer(vars.addresses[verId][3]));

    vars.lastPhase = false;
    vars.levelsDone = new Dictionary<short, HashSet<short>>();
}

update {
    vars.end.Update(game);
    vars.level.Update(game);
    vars.menuId.Update(game);
    vars.fade.Update(game);
}

start {
    if(string.IsNullOrEmpty(vars.level.Old) || string.IsNullOrEmpty(vars.level.Current))
        return false;

    if(settings["ls"])
        return !vars.level.Current.Equals(vars.level.Old);
    else
        return vars.level.Current.Equals("0level") && vars.menuId.Current == 1 && vars.fade.Old == 0 && vars.fade.Current != 0;
}

split {
    if(string.IsNullOrEmpty(vars.level.Old) || string.IsNullOrEmpty(vars.level.Current))
        return false;

    if(vars.level.Current.Equals("203level")) {
        if(vars.end.Current > 32) vars.lastPhase = true;
        if(vars.end.Current == 1 && vars.end.Old > 1 && vars.lastPhase && vars.levelsDone[106].Remove(203))
            return settings["l203"] || settings["ld"];
    } else vars.lastPhase = false;

    if(vars.level.Current.Equals("198level") && vars.level.Old.Equals("198level")) {
        if(vars.fade.Old == 32 && vars.fade.Current < 32 && vars.levelsDone[304].Remove(198))
            return settings["l198"] || settings["ld"];
    }

    if(!vars.level.Current.Equals(vars.level.Old) && vars.menuId.Old != 6) {
        string levelId = vars.level.Old.Substring(0, vars.level.Old.Length-5);
        string mapId = vars.level.Current.Substring(0, vars.level.Current.Length-5);
        if(levelId[0].Equals('n')) levelId = "-"+levelId.Substring(1);
        if(mapId[0].Equals('n')) mapId = "-"+mapId.Substring(1);
        short level = short.Parse(levelId);
        short map = short.Parse(mapId);
        if(vars.levelsDone.ContainsKey(map) && ((settings["ld"] && vars.levelsDone[map].Contains(level)) || vars.levelsDone[map].Remove(level))) {
            if(settings["ld"]) return true;
            if(settings["cl"] && vars.clearCount.ContainsKey(map) && vars.levelsDone[map].Count == vars.clearCount[map]) {
                return settings["cl"+map];
            } else if(settings["cp"] && vars.levelsDone[map].Count == 0) {
                vars.levelsDone.Remove(map);
                return settings["cp"+map];
            } else {
                return settings["l"+level];
            }
        }
    }
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}