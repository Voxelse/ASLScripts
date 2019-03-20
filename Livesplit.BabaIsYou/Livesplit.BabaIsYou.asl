state("Baba Is You") {}

startup {
	vars.versions = new Dictionary<int, string>() {{0x402000, "GF"}, {0x404000, "GJ"}, {0x405000, "GK"}};

	vars.addresses = new Dictionary<string, List<int>>() {
		{"GF", new List<int>{0x34A974, 0x34BBC4, 0x34C50C, 0x355E98}},
		{"GJ", new List<int>{0x34C9BC, 0x34DC0C, 0x34E554, 0x357EE8}},
		{"GK", new List<int>{0x34D9D4, 0x34EC24, 0x34F56C, 0x358EF8}}
	};

	settings.Add("cl", true, "Clear Worlds");
	settings.Add("cp", false, "Complete Worlds");
	vars.clearCount = new Dictionary<short, byte>() {
		{177, 15-8},  //1.The Lake
		{207, 16-8},  //2.Solitary Island	+1
		{206, 10-6},  //3.Temple Ruins
		{16, 20-7},   //4.Forest Of Fall
		{169, 20-9},  //5.Deep Forest
		{87, 14-8},   //6.Rocket Trip		+1
		{180, 12-6},  //7.Flower Garden
		{179, 15-9},  //8.Volcanic Cavern
		{182, 16-9},  //9.Chasm
		{232, 9-6},   //10.Mountaintop
		{282, 7-4}	  //12.ABC
	};
	
	settings.Add("l", true, "Levels");
	vars.levels = new Dictionary<Tuple<short, string>, HashSet<Tuple<short, string>>>() { {
			Tuple.Create<short, string>(106, "0.Map"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(0, "0: Baba Is You"),
			Tuple.Create<short, string>(1, "1: Where Do I Go?"),
			Tuple.Create<short, string>(189, "2: Now What Is This?"),
			Tuple.Create<short, string>(3, "3: Out Of Reach"),
			Tuple.Create<short, string>(2, "4: Still Out Of Reach"),
			Tuple.Create<short, string>(90, "5: Volcano"),
			Tuple.Create<short, string>(5, "6: Off Limits"),
			Tuple.Create<short, string>(6, "7: Grass Yard"),
			Tuple.Create<short, string>(243, "8: Slideshow"),
			Tuple.Create<short, string>(245, "9: Fragile Existence"),
			Tuple.Create<short, string>(117, "10: Hostile Environment"),
			Tuple.Create<short, string>(78, "?: ?"),
			Tuple.Create<short, string>(203, "Finale: A Way Out?")}
		}, {
			Tuple.Create<short, string>(177, "1.The Lake"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(20, "1: Icy Waters"),
			Tuple.Create<short, string>(212, "2: Turns"),
			Tuple.Create<short, string>(10, "3: Affection"),
			Tuple.Create<short, string>(4, "4: Pillar Yard"),
			Tuple.Create<short, string>(93, "5: Brick Wall"),
			Tuple.Create<short, string>(209, "6: Lock"),
			Tuple.Create<short, string>(15, "7: Novice Locksmith"),
			Tuple.Create<short, string>(8, "8: Locked In"),
			Tuple.Create<short, string>(236, "9: Changeless"),
			Tuple.Create<short, string>(210, "10: Two Doors"),
			Tuple.Create<short, string>(136, "11: Jelly Throne"),
			Tuple.Create<short, string>(30, "12: Crab Storage"),
			Tuple.Create<short, string>(166, "13: Burglary"),
			Tuple.Create<short, string>(211, "Extra 1: Submerged Ruins"),
			Tuple.Create<short, string>(314, "Extra 2: Sunken Shrine")}
		}, {
			Tuple.Create<short, string>(207, "2.Solitary Island"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(310, "0: Poem"),
			Tuple.Create<short, string>(205, "1: Float"),
			Tuple.Create<short, string>(218, "2: Warm River"),
			Tuple.Create<short, string>(171, "3: Bridge Building"),
			Tuple.Create<short, string>(172, "4: Bridge Building?"),
			Tuple.Create<short, string>(234, "5: Victory Spring"),
			Tuple.Create<short, string>(37, "6: Tiny Pond"),
			Tuple.Create<short, string>(107, "7: Assembly Team"),
			Tuple.Create<short, string>(7, "8: Catch The Thief!"),
			Tuple.Create<short, string>(68, "9: Wireless Connection"),
			Tuple.Create<short, string>(215, "10: Evaporating River"),
			Tuple.Create<short, string>(65, "11: Prison"),
			Tuple.Create<short, string>(219, "Extra 1: Boiling River"),
			Tuple.Create<short, string>(173, "Extra 2: ...Bridges?"),
			Tuple.Create<short, string>(41, "Extra 3: Tiny Isle"),
			Tuple.Create<short, string>(134, "Extra 4: Dim Signal")}
		}, {
			Tuple.Create<short, string>(206, "3.Temple Ruins"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(199, "1: Fragility"),
			Tuple.Create<short, string>(52, "2: Tunnel Vision"),
			Tuple.Create<short, string>(58, "3: A Present For You"),
			Tuple.Create<short, string>(17, "4: Unreachable Shores"),
			Tuple.Create<short, string>(23, "5: But Where's The Key"),
			Tuple.Create<short, string>(33, "6: Love Is Out There"),
			Tuple.Create<short, string>(71, "7: Perilous Gang"),
			Tuple.Create<short, string>(72, "8: Double Moat"),
			Tuple.Create<short, string>(56, "9: Walls Of Gold"),
			Tuple.Create<short, string>(129, "10: Further Fields")}
		}, {
			Tuple.Create<short, string>(16, "4.Forest Of Fall"),new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(238, "1: Hop"),
			Tuple.Create<short, string>(221, "2: Grand Stream"),
			Tuple.Create<short, string>(235, "3: Rocky Road"),
			Tuple.Create<short, string>(62, "4: Telephone"),
			Tuple.Create<short, string>(194, "5: Haunt"),
			Tuple.Create<short, string>(220, "6: Crate Square"),
			Tuple.Create<short, string>(36, "7: Ghost Friend"),
			Tuple.Create<short, string>(26, "8: Ghost Guard"),
			Tuple.Create<short, string>(35, "9: Leaf Chamber"),
			Tuple.Create<short, string>(137, "10: Not There"),
			Tuple.Create<short, string>(160, "11: Catch"),
			Tuple.Create<short, string>(174, "12: Dead End"),
			Tuple.Create<short, string>(77, "A: Literacy"),
			Tuple.Create<short, string>(29, "B: Broken Playground"),
			Tuple.Create<short, string>(269, "C: Fetching"),
			Tuple.Create<short, string>(307, "D: Scenic Pond"),
			Tuple.Create<short, string>(70, "E: Skeletal Door"),
			Tuple.Create<short, string>(239, "Extra 1: Jump"),
			Tuple.Create<short, string>(138, "Extra 2: Even Less There"),
			Tuple.Create<short, string>(308, "Extra 3: Deep Pool")}
		}, {
			Tuple.Create<short, string>(169, "5.Deep Forest"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(66, "1: Renovating"),
			Tuple.Create<short, string>(246, "2: Toolshed"),
			Tuple.Create<short, string>(69, "3: Kepp Out!"),
			Tuple.Create<short, string>(34, "4: Baba Doesn't Respond"),
			Tuple.Create<short, string>(57, "5: Patrol"),
			Tuple.Create<short, string>(85, "6: Canyon"),
			Tuple.Create<short, string>(151, "7: Concrete Goals"),
			Tuple.Create<short, string>(98, "8: Victory In The Open"),
			Tuple.Create<short, string>(191, "9: Moving Floor"),
			Tuple.Create<short, string>(248, "10: Supermarket"),
			Tuple.Create<short, string>(67, "11: Lock The Door"),
			Tuple.Create<short, string>(54, "12: Skull House"),
			Tuple.Create<short, string>(28, "13: Factory"),
			Tuple.Create<short, string>(233, "14: Tiny Pasture"),
			Tuple.Create<short, string>(50, "A: Nearly"),
			Tuple.Create<short, string>(257, "B: Not Quite"),
			Tuple.Create<short, string>(260, "C: Passing Through"),
			Tuple.Create<short, string>(271, "D: Salvage"),
			Tuple.Create<short, string>(268, "E: Insulation"),
			Tuple.Create<short, string>(193, "Extra 1: Crumbling Floor")}
		}, {
			Tuple.Create<short, string>(87, "6.Rocket Trip"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(9, "1: Empty"),
			Tuple.Create<short, string>(11, "2: Lonely Flag"),
			Tuple.Create<short, string>(13, "3: Babas Are You"),
			Tuple.Create<short, string>(80, "4: Please Hold My Key"),
			Tuple.Create<short, string>(201, "5: Horror Story"),
			Tuple.Create<short, string>(111, "6: Aiming High"),
			Tuple.Create<short, string>(112, "7: Trio"),
			Tuple.Create<short, string>(79, "8: Bottleneck"),
			Tuple.Create<short, string>(216, "9: Platformer"),
			Tuple.Create<short, string>(226, "10: The Pit"),
			Tuple.Create<short, string>(115, "11: Heavy Words"),
			Tuple.Create<short, string>(82, "12: Guardians"),
			Tuple.Create<short, string>(217, "13: Sky Hold"),
			Tuple.Create<short, string>(125, "Extra 1: Heavy Cloud")}
		}, {
			Tuple.Create<short, string>(180, "7.Flower Garden"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(59, "1: Condition"),
			Tuple.Create<short, string>(94, "2: Thicket"),
			Tuple.Create<short, string>(242, "3: Sorting Facility"),
			Tuple.Create<short, string>(124, "4: Relaxing Spot"),
			Tuple.Create<short, string>(64, "5: Maritime Adventures"),
			Tuple.Create<short, string>(89, "6: Got All This Stuff Here"),
			Tuple.Create<short, string>(150, "7: Blockade"),
			Tuple.Create<short, string>(91, "8: Jaywalkers United"),
			Tuple.Create<short, string>(130, "9: Overgrowth"),
			Tuple.Create<short, string>(92, "10: Adventurers"),
			Tuple.Create<short, string>(142, "Extra 1: Out At Sea"),
			Tuple.Create<short, string>(127, "Extra 2: Secret Garden")}
		}, {
			Tuple.Create<short, string>(179, "8.Volcanic Cavern"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(95, "1: Mouse Hole"),
			Tuple.Create<short, string>(148, "2: Tour"),
			Tuple.Create<short, string>(266, "3: Fireplace"),
			Tuple.Create<short, string>(51, "4: Coronation"),
			Tuple.Create<short, string>(47, "5: Peril At Every Turn"),
			Tuple.Create<short, string>(146, "6: Torn Apart"),
			Tuple.Create<short, string>(270, "7: Backstage"),
			Tuple.Create<short, string>(46, "8: Vital Ingredients"),
			Tuple.Create<short, string>(101, "9: The Heist"),
			Tuple.Create<short, string>(109, "10: Join The Crew"),
			Tuple.Create<short, string>(119, "11: Automaton"),
			Tuple.Create<short, string>(145, "12: Trick Door"),
			Tuple.Create<short, string>(176, "13: Trapped"),
			Tuple.Create<short, string>(122, "14: Tunnel"),
			Tuple.Create<short, string>(178, "15: Broken Expectations")}
		}, {
			Tuple.Create<short, string>(182, "9.Chasm"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(21, "A: Rocky Prison"),
			Tuple.Create<short, string>(241, "B: Siege"),
			Tuple.Create<short, string>(31, "C: Elusive Condition"),
			Tuple.Create<short, string>(240, "D: Treasury"),
			Tuple.Create<short, string>(19, "E: Looking For A Heart"),
			Tuple.Create<short, string>(110, "F: Lava Flood"),
			Tuple.Create<short, string>(18, "G: Entropy"),
			Tuple.Create<short, string>(25, "H: Floodgates"),
			Tuple.Create<short, string>(60, "I: Lonely Sight"),
			Tuple.Create<short, string>(155, "Extra 1: Metacognition"),
			Tuple.Create<short, string>(164, "Extra 2: Multitool"),
			Tuple.Create<short, string>(175, "Extra 3: Broken"),
			Tuple.Create<short, string>(167, "Extra 4: Alley"),
			Tuple.Create<short, string>(156, "Extra 5: Keke And The Star"),
			Tuple.Create<short, string>(165, "Extra 6: Visiting Baba"),
			Tuple.Create<short, string>(163, "Extra 7: Automated Doors")}
		}, {
			Tuple.Create<short, string>(232, "10. Mountaintop"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(105, "1: Shuffle"),
			Tuple.Create<short, string>(100, "2: Love At First Sight"),
			Tuple.Create<short, string>(195, "3: Solitude"),
			Tuple.Create<short, string>(116, "4: What Is Baba?"),
			Tuple.Create<short, string>(120, "5: Connector"),
			Tuple.Create<short, string>(118, "6: Floaty Platforms"),
			Tuple.Create<short, string>(99, "7: Seeking Acceptance"),
			Tuple.Create<short, string>(104, "8: Tectonic Movements"),
			Tuple.Create<short, string>(48, "Extra 1: The Floatiest Platforms")}
		}, {
			Tuple.Create<short, string>(200, "11. ???"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(192, "1: Glitch"),
			Tuple.Create<short, string>(197, "2: Error"),
			Tuple.Create<short, string>(84, "3: Whoops"),
			Tuple.Create<short, string>(227, "4: Mean Fence"),
			Tuple.Create<short, string>(141, "5: Scale"),
			Tuple.Create<short, string>(272, "6: Parade"),
			Tuple.Create<short, string>(247, "7: Turn The Corner"),
			Tuple.Create<short, string>(231, "8: VIP Area"),
			Tuple.Create<short, string>(250, "9: Tense Atmosphere"),
			Tuple.Create<short, string>(230, "10: Tag Team"),
			Tuple.Create<short, string>(275, "11: Security Check"),
			Tuple.Create<short, string>(168, "12: Ultimate Maze"),
			Tuple.Create<short, string>(-2, "Extra 1: Castle Disaster"), //n2
			Tuple.Create<short, string>(196, "Extra 2: Hazel Den"),
			Tuple.Create<short, string>(-1, "Extra 3: Baba Has Keke"), //n1
			Tuple.Create<short, string>(293, "Secret: Huh?"),
			Tuple.Create<short, string>(294, "Secret: A Prize Well Earned"),
			Tuple.Create<short, string>(306, "Secret: Orb")}
		}, {
			Tuple.Create<short, string>(282, "12. ABC"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(255, "1: Lunar Gallery"),
			Tuple.Create<short, string>(252, "2: BA"),
			Tuple.Create<short, string>(253, "3: AB"),
			Tuple.Create<short, string>(279, "4: Queue"),
			Tuple.Create<short, string>(280, "5: Wall"),
			Tuple.Create<short, string>(313, "6: Stardrop"),
			Tuple.Create<short, string>(281, "Extra 1: Meteor Strike")}
		}, {
			Tuple.Create<short, string>(264, "13. Depths"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(261, "1: Cleaning Service"),
			Tuple.Create<short, string>(251, "2: Exercise Hall"),
			Tuple.Create<short, string>(263, "3: Crushers"),
			Tuple.Create<short, string>(262, "4: Collaborative Effort"),
			Tuple.Create<short, string>(265, "5: Living Lands"),
			Tuple.Create<short, string>(274, "Extra 1: Priority Lane"),
			Tuple.Create<short, string>(75, "Extra 2: Secure Cottage"),
			Tuple.Create<short, string>(222, "Extra 3: Hidden Relic"),
			Tuple.Create<short, string>(223, "Extra 4: Buried Treasure"),
			Tuple.Create<short, string>(135, "Extra 5: Endless Corridor")}
		}, {
			Tuple.Create<short, string>(283, "14. Meta"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(288, "1: Hot Potato"),
			Tuple.Create<short, string>(287, "2: Adventure"),
			Tuple.Create<short, string>(302, "3: Booby Trap"),
			Tuple.Create<short, string>(285, "4: Canister"),
			Tuple.Create<short, string>(291, "5: Avalanche"),
			Tuple.Create<short, string>(132, "6: One-Way Entrance"),
			Tuple.Create<short, string>(295, "7: Bramblevine"),
			Tuple.Create<short, string>(297, "8: Mutual Feelings"),
			Tuple.Create<short, string>(298, "9: Delicate Start"),
			Tuple.Create<short, string>(303, "10: Just No"),
			Tuple.Create<short, string>(289, "11: Acrobatics"),
			Tuple.Create<short, string>(309, "12: The Return Of Scenic Pond"),
			Tuple.Create<short, string>(292, "13: Breaking And Entering"),
			Tuple.Create<short, string>(284, "14: Tangle"),
			Tuple.Create<short, string>(277, "15: The Box"),
			Tuple.Create<short, string>(299, "Extra 1: Hidden Path"),
			Tuple.Create<short, string>(188, "Extra 2: Triplets"),
			Tuple.Create<short, string>(286, "Extra 3: Getting Together")}
		}, {
			Tuple.Create<short, string>(304, "15. Center"), new HashSet<Tuple<short, string>> {
			Tuple.Create<short, string>(305, "Gallery"),
			Tuple.Create<short, string>(198, "The End")}
		}
	};

	foreach(KeyValuePair<Tuple<short, string>, HashSet<Tuple<short, string>>> vk in vars.levels) {
		if(vars.clearCount.ContainsKey(vk.Key.Item1))
			settings.Add("cl"+vk.Key.Item1, true, vk.Key.Item2, "cl");
		settings.Add("cp"+vk.Key.Item1, false, vk.Key.Item2, "cp");
		settings.Add("l"+vk.Key.Item1, (vk.Key.Item1 == 106 ? true : false), vk.Key.Item2, "l");
		foreach(Tuple<short, string> tup in vk.Value)
			settings.Add("l"+tup.Item1, (tup.Item1 == 203 ? true : false), tup.Item2, "l"+vk.Key.Item1);
	}

	settings.Add("ls", false, "Start on Level Change");

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
			return settings["l203"];
	} else vars.lastPhase = false;

	if(vars.level.Current.Equals("198level") && vars.level.Old.Equals("198level")) {
		if(vars.fade.Old == 32 && vars.fade.Current < 32 && vars.levelsDone[304].Remove(198))
			return settings["l198"];
	}

	if(!vars.level.Current.Equals(vars.level.Old))
		print("Changed: "+vars.level.Old+" "+vars.level.Current+" "+vars.menuId.Old);

	if(!vars.level.Current.Equals(vars.level.Old) && vars.menuId.Old != 6) {
		string levelId = vars.level.Old.Substring(0, vars.level.Old.Length-5);
		string mapId = vars.level.Current.Substring(0, vars.level.Current.Length-5);
		if(levelId[0].Equals('n')) levelId = "-"+levelId.Substring(1);
		if(mapId[0].Equals('n')) mapId = "-"+mapId.Substring(1);
		short level = short.Parse(levelId);
		short map = short.Parse(mapId);
		print("Try to Split: "+level+" "+map);
		if(vars.levelsDone.ContainsKey(map) && vars.levelsDone[map].Remove(level)) {
			if(settings["cl"] && vars.clearCount.ContainsKey(map) && vars.levelsDone[map].Count == vars.clearCount[map]) {
				print("Split Clear");
				return settings["cl"+map];
			} else if(settings["cp"] && vars.levelsDone[map].Count == 0) {
				print("Split Complete");
				vars.levelsDone.Remove(map);
				return settings["cp"+map];
			} else {
				print("Split Level");
				return settings["l"+level];
			}
		}
	}
}

//Had a wild reset so need to test the other vars (10 duplicates vars for menuId)
// reset {
// 	return vars.menuId.Old != vars.menuId.Current && vars.menuId.Current == 5;
// }

shutdown {
	timer.OnStart -= vars.timerResetVars;
}