state("Baba Is You", "GJ") {
	string8 level : 0x0034C9BC, 0x14, 0x30;
	int end : 0x0034DC0C;
	int menuId : 0x0034E554;
	double fade : 0x00357EE8;
}

state("Baba Is You", "GF") {
	string8 level : 0x0034A974, 0x14, 0x30;
	int end : 0x0034BBC4;
	int menuId : 0x0034C50C;
	double fade : 0x00355E98;
}

startup {
	settings.Add("cl", true, "Clear Levels");
	settings.Add("cp", false, "Complete Levels");
	vars.completeNb = new Dictionary<int, int>() {
		{106, 13-4},  //0.Map
		{177, 15-8},  //1.The Lake
		{207, 16-8},  //2.Solitary Island
		{206, 10-6},  //3.Temple Ruins
		{16, 20-7},   //4.Forest Of Fall
		{169, 20-9},  //5.Deep Forest
		{87, 14-8},   //6.Rocket Trip
		{180, 12-6},  //7.Flower Garden
		{179, 15-9},  //8.Volcanic Cavern
		{182, 16-9},  //9.Chasm
		{232, 9-6}    //10.Mountaintop
	};
	
	settings.Add("l", true, "Levels");
	vars.levels = new Dictionary<Tuple<int, string>, HashSet<Tuple<int, string>>>() { {
			Tuple.Create<int, string>(106, "0.Map"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(0, "0: Baba Is You"),
			Tuple.Create<int, string>(1, "1: Where Do I Go?"),
			Tuple.Create<int, string>(189, "2: Now What Is This?"),
			Tuple.Create<int, string>(3, "3: Out Of Reach"),
			Tuple.Create<int, string>(2, "4: Still Out Of Reach"),
			Tuple.Create<int, string>(90, "5: Volcano"),
			Tuple.Create<int, string>(5, "6: Off Limits"),
			Tuple.Create<int, string>(6, "7: Grass Yard"),
			Tuple.Create<int, string>(243, "8: Slideshow"),
			Tuple.Create<int, string>(245, "9: Fragile Existence"),
			Tuple.Create<int, string>(117, "10: Hostile Environment"),
			Tuple.Create<int, string>(78, "?: ?"),
			Tuple.Create<int, string>(203, "Finale: A Way Out?")}
		}, {
			Tuple.Create<int, string>(177, "1.The Lake"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(20, "1: Icy Waters"),
			Tuple.Create<int, string>(212, "2: Turns"),
			Tuple.Create<int, string>(10, "3: Affection"),
			Tuple.Create<int, string>(4, "4: Pillar Yard"),
			Tuple.Create<int, string>(93, "5: Brick Wall"),
			Tuple.Create<int, string>(209, "6: Lock"),
			Tuple.Create<int, string>(15, "7: Novice Locksmith"),
			Tuple.Create<int, string>(8, "8: Locked In"),
			Tuple.Create<int, string>(236, "9: Changeless"),
			Tuple.Create<int, string>(210, "10: Two Doors"),
			Tuple.Create<int, string>(136, "11: Jelly Throne"),
			Tuple.Create<int, string>(30, "12: Crab Storage"),
			Tuple.Create<int, string>(166, "13: Burglary"),
			Tuple.Create<int, string>(211, "Extra 1: Submerged Ruins"),
			Tuple.Create<int, string>(314, "Extra 2: Sunken Shrine")}
		}, {
			Tuple.Create<int, string>(207, "2.Solitary Island"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(310, "0: Poem"),
			Tuple.Create<int, string>(205, "1: Float"),
			Tuple.Create<int, string>(218, "2: Warm River"),
			Tuple.Create<int, string>(171, "3: Bridge Building"),
			Tuple.Create<int, string>(172, "4: Bridge Building?"),
			Tuple.Create<int, string>(234, "5: Victory Spring"),
			Tuple.Create<int, string>(37, "6: Tiny Pond"),
			Tuple.Create<int, string>(107, "7: Assembly Team"),
			Tuple.Create<int, string>(7, "8: Catch The Thief!"),
			Tuple.Create<int, string>(68, "9: Wireless Connection"),
			Tuple.Create<int, string>(215, "10: Evaporating River"),
			Tuple.Create<int, string>(65, "11: Prison"),
			Tuple.Create<int, string>(219, "Extra 1: Boiling River"),
			Tuple.Create<int, string>(173, "Extra 2: ...Bridges?"),
			Tuple.Create<int, string>(41, "Extra 3: Tiny Isle"),
			Tuple.Create<int, string>(134, "Extra 4: Dim Signal")}
		}, {
			Tuple.Create<int, string>(206, "3.Temple Ruins"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(199, "1: Fragility"),
			Tuple.Create<int, string>(52, "2: Tunnel Vision"),
			Tuple.Create<int, string>(58, "3: A Present For You"),
			Tuple.Create<int, string>(17, "4: Unreachable Shores"),
			Tuple.Create<int, string>(23, "5: But Where's The Key"),
			Tuple.Create<int, string>(33, "6: Love Is Out There"),
			Tuple.Create<int, string>(71, "7: Perilous Gang"),
			Tuple.Create<int, string>(72, "8: Double Moat"),
			Tuple.Create<int, string>(56, "9: Walls Of Gold"),
			Tuple.Create<int, string>(129, "10: Further Fields")}
		}, {
			Tuple.Create<int, string>(16, "4.Forest Of Fall"),new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(238, "1: Hop"),
			Tuple.Create<int, string>(221, "2: Grand Stream"),
			Tuple.Create<int, string>(235, "3: Rocky Road"),
			Tuple.Create<int, string>(62, "4: Telephone"),
			Tuple.Create<int, string>(194, "5: Haunt"),
			Tuple.Create<int, string>(220, "6: Crate Square"),
			Tuple.Create<int, string>(36, "7: Ghost Friend"),
			Tuple.Create<int, string>(26, "8: Ghost Guard"),
			Tuple.Create<int, string>(35, "9: Leaf Chamber"),
			Tuple.Create<int, string>(137, "10: Not There"),
			Tuple.Create<int, string>(160, "11: Catch"),
			Tuple.Create<int, string>(174, "12: Dead End"),
			Tuple.Create<int, string>(77, "A: Literacy"),
			Tuple.Create<int, string>(29, "B: Broken Playground"),
			Tuple.Create<int, string>(269, "C: Fetching"),
			Tuple.Create<int, string>(307, "D: Scenic Pond"),
			Tuple.Create<int, string>(70, "E: Skeletal Door"),
			Tuple.Create<int, string>(239, "Extra 1: Jump"),
			Tuple.Create<int, string>(138, "Extra 2: Even Less There"),
			Tuple.Create<int, string>(308, "Extra 3: Deep Pool")}
		}, {
			Tuple.Create<int, string>(169, "5.Deep Forest"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(66, "1: Renovating"),
			Tuple.Create<int, string>(246, "2: Toolshed"),
			Tuple.Create<int, string>(69, "3: Kepp Out!"),
			Tuple.Create<int, string>(34, "4: Baba Doesn't Respond"),
			Tuple.Create<int, string>(57, "5: Patrol"),
			Tuple.Create<int, string>(85, "6: Canyon"),
			Tuple.Create<int, string>(151, "7: Concrete Goals"),
			Tuple.Create<int, string>(98, "8: Victory In The Open"),
			Tuple.Create<int, string>(191, "9: Moving Floor"),
			Tuple.Create<int, string>(248, "10: Supermarket"),
			Tuple.Create<int, string>(67, "11: Lock The Door"),
			Tuple.Create<int, string>(54, "12: Skull House"),
			Tuple.Create<int, string>(28, "13: Factory"),
			Tuple.Create<int, string>(233, "14: Tiny Pasture"),
			Tuple.Create<int, string>(50, "A: Nearly"),
			Tuple.Create<int, string>(257, "B: Not Quite"),
			Tuple.Create<int, string>(260, "C: Passing Through"),
			Tuple.Create<int, string>(271, "D: Salvage"),
			Tuple.Create<int, string>(268, "E: Insulation"),
			Tuple.Create<int, string>(193, "Extra 1: Crumbling Floor")}
		}, {
			Tuple.Create<int, string>(87, "6.Rocket Trip"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(9, "1: Empty"),
			Tuple.Create<int, string>(11, "2: Lonely Flag"),
			Tuple.Create<int, string>(13, "3: Babas Are You"),
			Tuple.Create<int, string>(80, "4: Please Hold My Key"),
			Tuple.Create<int, string>(201, "5: Horror Story"),
			Tuple.Create<int, string>(111, "6: Aiming High"),
			Tuple.Create<int, string>(112, "7: Trio"),
			Tuple.Create<int, string>(79, "8: Bottleneck"),
			Tuple.Create<int, string>(216, "9: Platformer"),
			Tuple.Create<int, string>(226, "10: The Pit"),
			Tuple.Create<int, string>(115, "11: Heavy Words"),
			Tuple.Create<int, string>(82, "12: Guardians"),
			Tuple.Create<int, string>(217, "13: Sky Hold"),
			Tuple.Create<int, string>(125, "Extra 1: Heavy Cloud")}
		}, {
			Tuple.Create<int, string>(180, "7.Flower Garden"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(59, "1: Condition"),
			Tuple.Create<int, string>(94, "2: Thicket"),
			Tuple.Create<int, string>(242, "3: Sorting Facility"),
			Tuple.Create<int, string>(124, "4: Relaxing Spot"),
			Tuple.Create<int, string>(64, "5: Maritime Adventures"),
			Tuple.Create<int, string>(89, "6: Got All This Stuff Here"),
			Tuple.Create<int, string>(150, "7: Blockade"),
			Tuple.Create<int, string>(91, "8: Jaywalkers United"),
			Tuple.Create<int, string>(130, "9: Overgrowth"),
			Tuple.Create<int, string>(92, "10: Adventurers"),
			Tuple.Create<int, string>(142, "Extra 1: Out At Sea"),
			Tuple.Create<int, string>(127, "Extra 2: Secret Garden")}
		}, {
			Tuple.Create<int, string>(179, "8.Volcanic Cavern"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(95, "1: Mouse Hole"),
			Tuple.Create<int, string>(148, "2: Tour"),
			Tuple.Create<int, string>(266, "3: Fireplace"),
			Tuple.Create<int, string>(51, "4: Coronation"),
			Tuple.Create<int, string>(47, "5: Peril At Every Turn"),
			Tuple.Create<int, string>(146, "6: Torn Apart"),
			Tuple.Create<int, string>(270, "7: Backstage"),
			Tuple.Create<int, string>(46, "8: Vital Ingredients"),
			Tuple.Create<int, string>(101, "9: The Heist"),
			Tuple.Create<int, string>(109, "10: Join The Crew"),
			Tuple.Create<int, string>(119, "11: Automaton"),
			Tuple.Create<int, string>(145, "12: Trick Door"),
			Tuple.Create<int, string>(176, "13: Trapped"),
			Tuple.Create<int, string>(122, "14: Tunnel"),
			Tuple.Create<int, string>(178, "15: Broken Expectations")}
		}, {
			Tuple.Create<int, string>(182, "9.Chasm"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(21, "A: Rocky Prison"),
			Tuple.Create<int, string>(241, "B: Siege"),
			Tuple.Create<int, string>(31, "C: Elusive Condition"),
			Tuple.Create<int, string>(240, "D: Treasury"),
			Tuple.Create<int, string>(19, "E: Looking For A Heart"),
			Tuple.Create<int, string>(110, "F: Lava Flood"),
			Tuple.Create<int, string>(18, "G: Entropy"),
			Tuple.Create<int, string>(25, "H: Floodgates"),
			Tuple.Create<int, string>(60, "I: Lonely Sight"),
			Tuple.Create<int, string>(155, "Extra 1: Metacognition"),
			Tuple.Create<int, string>(164, "Extra 2: Multitool"),
			Tuple.Create<int, string>(175, "Extra 3: Broken"),
			Tuple.Create<int, string>(167, "Extra 4: Alley"),
			Tuple.Create<int, string>(156, "Extra 5: Keke And The Star"),
			Tuple.Create<int, string>(165, "Extra 6: Visiting Baba"),
			Tuple.Create<int, string>(163, "Extra 7: Automated Doors")}
		}, {
			Tuple.Create<int, string>(232, "10. Mountaintop"), new HashSet<Tuple<int, string>> {
			Tuple.Create<int, string>(105, "1: Shuffle"),
			Tuple.Create<int, string>(100, "2: Love At First Sight"),
			Tuple.Create<int, string>(195, "3: Solitude"),
			Tuple.Create<int, string>(116, "4: What Is Baba?"),
			Tuple.Create<int, string>(120, "5: Connector"),
			Tuple.Create<int, string>(118, "6: Floaty Platforms"),
			Tuple.Create<int, string>(99, "7: Seeking Acceptance"),
			Tuple.Create<int, string>(104, "8: Tectonic Movements"),
			Tuple.Create<int, string>(48, "Extra 1: The Floatiest Platforms")}
		}
	};

	foreach(KeyValuePair<Tuple<int, string>, HashSet<Tuple<int, string>>> vk in vars.levels) {
		settings.Add("cl"+vk.Key.Item1, true, vk.Key.Item2, "cl");
		settings.Add("cp"+vk.Key.Item1, false, vk.Key.Item2, "cp");
		settings.Add("l"+vk.Key.Item1, (vk.Key.Item1 == 106 ? true : false), vk.Key.Item2, "l");
		foreach(Tuple<int, string> tup in vk.Value)
			settings.Add("l"+tup.Item1, (tup.Item1 == 203 ? true : false), tup.Item2, "l"+vk.Key.Item1);
	}

	vars.timerResetVars = (EventHandler)((s, e) => {
		vars.lastPhase = false;
		vars.levelsDone = new Dictionary<int, HashSet<int>>();
		foreach(KeyValuePair<Tuple<int, string>, HashSet<Tuple<int, string>>> vk in vars.levels) {
			var set = new HashSet<int>();
			foreach(Tuple<int, string> tup in vk.Value)
				set.Add(tup.Item1);
			vars.levelsDone.Add(vk.Key.Item1, set);
		}
	});
	timer.OnStart += vars.timerResetVars;
}

init {
	if(modules.First().ModuleMemorySize == 0x404000) version = "GJ";
	if(modules.First().ModuleMemorySize == 0x402000) version = "GF";
}

start {
	return current.menuId == 1 && current.level.Equals("0level") && old.fade == 0 && current.fade != 0;
}

split {
	if(current.level.Equals("203level")) {
		if(current.end > 32) vars.lastPhase = true;
		return settings["l203"] && current.end == 1 && old.end > 1 && vars.lastPhase;
	} else vars.lastPhase = false;

	if(!current.level.Equals(old.level) && old.menuId != 6 && !string.IsNullOrEmpty(current.level) && !string.IsNullOrEmpty(old.level)) {
		int map = int.Parse(current.level.Substring(0, current.level.Length-5));
		int level = int.Parse(old.level.Substring(0, old.level.Length-5));
		if(vars.levelsDone.ContainsKey(map) && vars.levelsDone[map].Remove(level)) {
			if(settings["cl"] && vars.levelsDone[map].Count == vars.completeNb[map]) {
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

//Had a wild reset so need to test the other vars (10 duplicates vars for menuId)
// reset {
// 	return old.menuId != current.menuId && current.menuId == 5;
// }

shutdown {
	timer.OnStart -= vars.timerResetVars;
}