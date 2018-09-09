state ("TheMessenger") {
    //LevelManager
    string128 sceneName : "mono.dll", 0x002685E0, 0xA0, 0x610, 0x8, 0x48, 0x14;
    //ProgressionManager
    int bossesDefeatedCount          : "mono.dll", 0x00268B58, 0x20, 0x58, 0x748, 0x18;
    int cutscenesPlayedCount         : "mono.dll", 0x00268B58, 0x20, 0x58, 0x758, 0x18;
    long cutscenesPlayedAddr         : "mono.dll", 0x00268B58, 0x20, 0x58, 0x758, 0x10;
    int challengeRoomsCompletedCount : "mono.dll", 0x00268B58, 0x20, 0x58, 0x770, 0x18;
    long challengeRoomsCompletedAddr : "mono.dll", 0x00268B58, 0x20, 0x58, 0x770, 0x10;
    //InventoryManager
    long inventoryIdAddr : "mono.dll", 0x002685E0, 0xA0, 0x4C8, 0x8, 0x48, 0x20, 0x20;
    long inventoryNbAddr : "mono.dll", 0x002685E0, 0xA0, 0x4C8, 0x8, 0x48, 0x20, 0x28;
    int inventorySize    : "mono.dll", 0x002685E0, 0xA0, 0x4C8, 0x8, 0x48, 0x20, 0x30;
    int inventoryCount   : "mono.dll", 0x002685E0, 0xA0, 0x4C8, 0x8, 0x48, 0x20, 0x38;
    //EndingCutscene
    long endMusic : "mono.dll", 0x0027CAA8, 0x68, 0x68, 0x10, 0x10, 0x80, 0x2B0;
}

startup {
    settings.Add("Levels", true, "Levels");
    settings.Add("Inventory", true, "Inventory");

    settings.CurrentDefaultParent = "Levels";
        settings.Add("01_NinjaVillage", false, "Ninja Village");
        settings.Add("02_AutumnHills", true, "Autumn Hills");
        settings.Add("03_ForlornTemple", true, "Forlorn Temple");
        settings.Add("04_Catacombs", true, "Catacombs");
        settings.Add("06_A_BambooCreek", true, "Bamboo Creek");
        settings.Add("05_A_HowlingGrotto", true, "Howling Grotto");
        settings.Add("07_QuillshroomMarsh", true, "Quillshroom Marsh");
        settings.Add("08_SearingCrags", true, "Searing Crags");
        settings.Add("09_A_GlacialPeak", true, "Glacial Peak");
        settings.Add("10_A_TowerOfTime", true, "Tower Of Time");
        settings.Add("11_A_CloudRuins", true, "Cloud Ruins");
        settings.Add("12_UnderWorld", true, "UnderWorld");
        settings.Add("13_TowerOfTimeHQ", false, "Tower Of Time Headquarters");
        settings.Add("04_B_DarkCave", true, "Dark Cave");
        settings.Add("04_C_RiviereTurquoise", true, "Riviere Turquoise");
        settings.Add("05_B_SunkenShrine", true, "Sunken Shrine");
        settings.Add("09_B_ElementalSkylands", true, "Elemental Skylands");
        settings.Add("14_CorruptedFuture", true, "Corrupted Future");
        settings.Add("11_B_MusicBox", true, "Music Box");
        settings.Add("Ending", true, "Ending");

    settings.CurrentDefaultParent = "01_NinjaVillage";
        settings.Add("Cutscene_01_NinjaVillage", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_01_NinjaVillage";
            settings.Add("Cutscene_FutureMessengerCutscene", false, "Future Messenger");
            

    settings.CurrentDefaultParent = "02_AutumnHills";
        settings.Add("Level_02_AutumnHills", true, "Enter Level");
        settings.Add("Boss_02_AutumnHills", false, "Leaf Golem Last Hit");
        settings.Add("Cutscene_02_AutumnHills", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_02_AutumnHills";
            settings.Add("Cutscene_LeafGolemIntroCutScene", false, "Leaf Golem Intro Fight");
            settings.Add("Cutscene_LeafGolemOutroCutScene", false, "Leaf Golem Outro Fight");

    settings.CurrentDefaultParent = "03_ForlornTemple";
        settings.Add("Level_03_ForlornTemple", true, "Enter Level");
        settings.Add("Cutscene_03_ForlornTemple", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_03_ForlornTemple";
            settings.Add("Cutscene_ForlonTempleBossIntroCutscene", false, "Demon King Intro Fight");
            settings.Add("Cutscene_ForlonTempleBossOutroCutscene", false, "Demon King Outro Fight");

    settings.CurrentDefaultParent = "04_Catacombs";
        settings.Add("Level_04_Catacombs", true, "Enter Level");
        settings.Add("Boss_04_Catacombs", false, "Ruxxtin Last Hit");
        settings.Add("Cutscene_04_Catacombs", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_04_Catacombs";
            settings.Add("Cutscene_NecromancerIntroCutscene", false, "Ruxxtin Intro Fight");
            settings.Add("Cutscene_NecromancerOutroCutscene", false, "Ruxxtin Outro Fight");

    settings.CurrentDefaultParent = "06_A_BambooCreek";
        settings.Add("Level_06_A_BambooCreek", true, "Enter Level");

    settings.CurrentDefaultParent = "05_A_HowlingGrotto";
        settings.Add("Level_05_A_HowlingGrotto", true, "Enter Level");
        settings.Add("Boss_05_A_HowlingGrotto", false, "Emerald Golem Last Hit");
        settings.Add("Cutscene_05_A_HowlingGrotto", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_05_A_HowlingGrotto";
            settings.Add("Cutscene_HowlingGrottoBossIntroCutscene", false, "Emerald Golem Intro Fight");
            settings.Add("Cutscene_HowlingGrottoBossOutroCutscene", false, "Emerald Golem Outro Fight");

    settings.CurrentDefaultParent = "07_QuillshroomMarsh";
        settings.Add("Level_07_QuillshroomMarsh", true, "Enter Level");
        settings.Add("Boss_07_QuillshroomMarsh", false, "Queen Of Quills Last Hit");
        settings.Add("Cutscene_07_QuillshroomMarsh", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_07_QuillshroomMarsh";
            settings.Add("Cutscene_QuillshroomMarshBossIntroCutscene", false, "Queen Of Quills Intro Fight");
            settings.Add("Cutscene_QuillshroomMarshBossOutroCutscene", false, "Queen Of Quills Outro Fight");
            settings.Add("Cutscene_DecurseQueenCutscene", false, "Decurse Queen");

    settings.CurrentDefaultParent = "08_SearingCrags";
        settings.Add("Level_08_SearingCrags", true, "Enter Level");
        settings.Add("Boss_08_SearingCrags", false, "Colossuses Death");
        settings.Add("Cutscene_08_SearingCrags", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_08_SearingCrags";
            settings.Add("Cutscene_SearingCragsBossIntroCutscene", false, "Colossuses Intro Fight");
            settings.Add("Cutscene_SearingCragsPortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_SearingCragsGivePowerThistleCutscene", false, "Give Power Thistle");
        
    settings.CurrentDefaultParent = "09_A_GlacialPeak";
        settings.Add("Level_09_A_GlacialPeak", true, "Enter Level");
        settings.Add("Cutscene_09_A_GlacialPeak", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_09_A_GlacialPeak";
            settings.Add("Cutscene_CloudRuinsStaffTeleportEntranceCutscene", false, "Glacial Peak to Cloud Ruins (Ruxxtin's staff)");

    settings.CurrentDefaultParent = "10_A_TowerOfTime";
        settings.Add("Level_10_A_TowerOfTime", true, "Enter Level");
        settings.Add("Boss_10_A_TowerOfTime", false, "Boss Last Hit (Arcane Golem)");
        settings.Add("Cutscene_10_A_TowerOfTime", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_10_A_TowerOfTime";
            settings.Add("Cutscene_TowerOfTimeBossIntroCutscene", false, "Arcane Golem Intro Fight");
            settings.Add("Cutscene_TowerOfTimeBossOutroCutscene", false, "Arcane Golem Outro Fight");

    settings.CurrentDefaultParent = "11_A_CloudRuins";
        settings.Add("Level_11_A_CloudRuins", true, "Enter Level");
        settings.Add("Boss_11_A_CloudRuins", false, "Manfred Last Hit");
        settings.Add("Cutscene_11_A_CloudRuins", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_11_A_CloudRuins";
            settings.Add("Cutscene_ManfredBossIntroCutscene", false, "Manfred Intro Fight");

    settings.CurrentDefaultParent = "12_UnderWorld";
        settings.Add("Level_12_UnderWorld", true, "Enter Level");
        settings.Add("Boss_12_UnderWorld", false, "Demon General Last Hit");
        settings.Add("Cutscene_12_UnderWorld", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_12_UnderWorld";
            settings.Add("Cutscene_DemonGeneralBossIntroCutscene", false, "Demon General Intro Fight");
            settings.Add("Cutscene_DemonGeneralBossOutroCutscene", false, "Demon General Outro Fight");
            settings.Add("Cutscene_UnderworldManfredEscapeCutscene", false, "UnderWorld to Ninja Village (Manfred)");

    settings.CurrentDefaultParent = "13_TowerOfTimeHQ";
        settings.Add("Cutscene_13_TowerOfTimeHQ", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_13_TowerOfTimeHQ";
            settings.Add("Cutscene_ArmoireOpeningCutscene", false, "Blue Robe");
            settings.Add("Cutscene_PortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_ExitPortalAwardMapCutscene", false, "Map Award");
            settings.Add("Cutscene_DropMusicNoteCutscene", false, "Drop Music Notes");

    settings.CurrentDefaultParent = "04_B_DarkCave";
        settings.Add("Level_04_B_DarkCave", true, "Enter Level");

    settings.CurrentDefaultParent = "04_C_RiviereTurquoise";
        settings.Add("Level_04_C_RiviereTurquoise", true, "Enter Level");
        settings.Add("Boss_04_C_RiviereTurquoise", false, "Butterfly Matriarch Last Hit");
        settings.Add("Cutscene_04_C_RiviereTurquoise", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_04_C_RiviereTurquoise";
            settings.Add("Cutscene_RiviereTurquoisePortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_RiviereTurquoiseBossIntroCutscene", false, "Butterfly Matriarch Intro");

    settings.CurrentDefaultParent = "05_B_SunkenShrine";
        settings.Add("Level_05_B_SunkenShrine", true, "Enter Level");
        settings.Add("Cutscene_05_B_SunkenShrine", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_05_B_SunkenShrine";
            settings.Add("Cutscene_SunkenShrinePortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_DropCrestsCutscene", false, "Drop Crest");
            settings.Add("Cutscene_SunkenShrineEnterDoorCutscene", false, "Sunken Shrine Dialog");

    settings.CurrentDefaultParent = "09_B_ElementalSkylands";
        settings.Add("Level_09_B_ElementalSkylands", true, "Enter Level");
        settings.Add("Boss_09_B_ElementalSkylands", false, "Clockwork Concierge Last Hit");
        settings.Add("Cutscene_09_B_ElementalSkylands", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_09_B_ElementalSkylands";
            settings.Add("Cutscene_ElementalSkylandsBossIntroCutscene", false, "Clockwork Concierge Intro Fight");
            settings.Add("Cutscene_SkylandsToGlacialPeakFirstTimeCutscene", false, "Skylands to Glacial Peak (Manfred)");

    settings.CurrentDefaultParent = "14_CorruptedFuture";
        settings.Add("Level_14_CorruptedFuture", true, "Enter Level");

    settings.CurrentDefaultParent = "11_B_MusicBox";
        settings.Add("Level_11_B_MusicBox", true, "Enter Level");
        settings.Add("Boss_11_B_MusicBox", false, "Phantom Last Hit");
        settings.Add("Cutscene_11_B_MusicBox", false, "Cutscenes");
        settings.CurrentDefaultParent = "Cutscene_11_B_MusicBox";
            settings.Add("Cutscene_PhantomIntroCutscene", false, "Phantom Intro Fight");

    settings.CurrentDefaultParent = "Ending";
        settings.Add("Level_Ending", false, "Enter Level");
        settings.Add("Beat_Mask", true, "Beat Mask");

    settings.CurrentDefaultParent = "Inventory";
        settings.Add("Items", false);
        settings.Add("Abilities", false);
        settings.Add("Music Notes", true);
        settings.Add("Phobekins", false);
        settings.Add("Power Seals", false);
    
    settings.CurrentDefaultParent = "Items";
        settings.Add("Inventory_50", false, "Scroll");
        settings.Add("Inventory_7", false, "Climbing claws");
        settings.Add("Inventory_6", false, "Wingsuit");
        settings.Add("Inventory_4", false, "Rope dart");
        settings.Add("Inventory_3", false, "Scroll upgrade"); // 52
        settings.Add("Inventory_19", false, "Magic Seashell");
        settings.Add("Inventory_25", false, "Get Power Thistle");
        settings.Add("Inventory_25_0", false, "Give Power Thistle");
        settings.Add("Inventory_56", false, "Get Astral Seed");
        settings.Add("Inventory_56_0", false, "Give Astral Seed");
        settings.Add("Inventory_57", false, "Get Astral Tea Leaves");
        settings.Add("Inventory_57_0", false, "Give Astral Tea Leaves");
        settings.Add("Inventory_55", false, "Ruxxtin's Amulet");
        settings.Add("Inventory_29", false, "Candle");
        settings.Add("Inventory_60", false, "Magic Firefly");
        settings.Add("Inventory_40", false, "Lightfoot Tabi");
        settings.Add("Inventory_58", false, "Sun Crest");
        settings.Add("Inventory_59", false, "Moon Crest");
        settings.Add("Inventory_51", false, "Demon King's Crown");

    settings.CurrentDefaultParent = "Abilities";
        settings.Add("Abilities8", false, "Abilities 8bit");
        settings.Add("Abilities16", false, "Abilities 16bit");

    settings.CurrentDefaultParent = "Abilities8";
        settings.Add("Inventory_2", false, "Karuta plates");
        settings.Add("Inventory_26", false, "Energy shuriken");
        settings.Add("Inventory_64", false, "Strike of the Ninja");
        settings.Add("Inventory_61", false, "Serendipitous minds");
        settings.Add("Inventory_62", false, "Serendipitous bodies");
        settings.Add("Inventory_37", false, "Second wind");
        settings.Add("Inventory_34", false, "Path of resilience");
        settings.Add("Inventory_2_2", false, "Kusari jacket");
        settings.Add("Inventory_38", false, "Prepared mind");
        settings.Add("Inventory_39", false, "Currents master");
        settings.Add("Inventory_43", false, "Meditation");
        settings.Add("Inventory_41", false, "Aerobatics warrior");
        settings.Add("Inventory_49", false, "Devil's due");
    settings.CurrentDefaultParent = "Abilities16";
        settings.Add("Inventory_42", false, "Rejuvenative spirit");
        settings.Add("Inventory_38_2", false, "Centered mind");
        settings.Add("Inventory_63", false, "Demon's bane");
        settings.Add("Inventory_68", false, "Time sense");
        settings.Add("Inventory_69", false, "Power sense");
        settings.Add("Inventory_70", false, "Focused power sense");

    settings.CurrentDefaultParent = "Music Notes";
        settings.Add("Inventory_11", true, "Key of Courage");
        settings.Add("Inventory_12", true, "Key of Hope");
        settings.Add("Inventory_13", true, "Key of Love");
        settings.Add("Inventory_14", true, "Key of Strength");
        settings.Add("Inventory_15", true, "Key of Chaos");
        settings.Add("Inventory_16", true, "Key of Symbiosis");

    settings.CurrentDefaultParent = "Phobekins";
        settings.Add("Inventory_20", false, "Necro");
        settings.Add("Inventory_21", false, "Acro");
        settings.Add("Inventory_22", false, "Cloustro");
        settings.Add("Inventory_23", false, "Pyro");

    settings.CurrentDefaultParent = "Power Seals";
        settings.Add("Seal_01_NinjaVillage", false, "Ninja Village");
        settings.Add("Seal_02_AutumnHills", false, "Autumn Hills");
        settings.Add("Seal_03_ForlornTemple", false, "Forlorn Temple");
        settings.Add("Seal_04_Catacombs", false, "Catacombs");
        settings.Add("Seal_06_A_BambooCreek", false, "Bamboo Creek");
        settings.Add("Seal_05_A_HowlingGrotto", false, "Howling Grotto");
        settings.Add("Seal_07_QuillshroomMarsh", false, "Quillshroom Marsh");
        settings.Add("Seal_08_SearingCrags", false, "Searing Crags");
        settings.Add("Seal_09_A_GlacialPeak", false, "Glacial Peak");
        settings.Add("Seal_10_A_TowerOfTime", false, "Tower Of Time");
        settings.Add("Seal_11_A_CloudRuins", false, "Cloud Ruins");
        settings.Add("Seal_12_UnderWorld", false, "UnderWorld");
        settings.Add("Seal_04_C_RiviereTurquoise", false, "Riviere Turquoise");
        settings.Add("Seal_05_B_SunkenShrine", false, "Sunken Shrine");
        settings.Add("Seal_09_B_ElementalSkylands", false, "Elemental Skylands");

    settings.CurrentDefaultParent = "Seal_01_NinjaVillage";
        settings.Add("Seal_-436-404-44-28", false, "First");

    settings.CurrentDefaultParent = "Seal_02_AutumnHills";
        settings.Add("Seal_-52-20-60-44", false, "First");
        settings.Add("Seal_556588-44-28", false, "Second");
        settings.Add("Seal_748780-76-60", false, "Third");
        settings.Add("Seal_748780-108-76", false, "Fourth");

    settings.CurrentDefaultParent = "Seal_03_ForlornTemple";
        settings.Add("Seal_140172100164", false, "First");
        settings.Add("Seal_172268-284", false, "Second");

    settings.CurrentDefaultParent = "Seal_04_Catacombs";
        settings.Add("Seal_236268-44-28", false, "First");
        settings.Add("Seal_492524-44-28", false, "Second");
        settings.Add("Seal_556588-60-44", false, "Third");

    settings.CurrentDefaultParent = "Seal_06_A_BambooCreek";
        settings.Add("Seal_-84-52-28-12", false, "First");
        settings.Add("Seal_172236-44-28", false, "Second");
        settings.Add("Seal_300332-1236", false, "Third");

    settings.CurrentDefaultParent = "Seal_05_A_HowlingGrotto";
        settings.Add("Seal_108140-28-12", false, "First");
        settings.Add("Seal_300332-92-76", false, "Second");
        settings.Add("Seal_460492-172-156", false, "Third");

    settings.CurrentDefaultParent = "Seal_07_QuillshroomMarsh";
        settings.Add("Seal_204236-28-12", false, "First");
        settings.Add("Seal_652684-60-28", false, "Second");
        settings.Add("Seal_940972-28-12", false, "Third");

    settings.CurrentDefaultParent = "Seal_08_SearingCrags";
        settings.Add("Seal_761085268", false, "First");
        settings.Add("Seal_300332180196", false, "Second");
        settings.Add("Seal_364396292308", false, "Third");

    settings.CurrentDefaultParent = "Seal_09_A_GlacialPeak";
        settings.Add("Seal_140172-492-476", false, "First");
        settings.Add("Seal_236268-156-140", false, "Second");
        settings.Add("Seal_236268-396-380", false, "Third");

    settings.CurrentDefaultParent = "Seal_10_A_TowerOfTime";
        settings.Add("Seal_-84-522036", false, "First");
        settings.Add("Seal_-52-20116132", false, "Second");
        settings.Add("Seal_7610852116", false, "Third");

    settings.CurrentDefaultParent = "Seal_11_A_CloudRuins";
        settings.Add("Seal_-148-116420", false, "First");
        settings.Add("Seal_108140-44-28", false, "Second");
        settings.Add("Seal_748780-44-28", false, "Third");
        settings.Add("Seal_11321164-124", false, "Fourth");
    
    settings.CurrentDefaultParent = "Seal_12_UnderWorld";
        settings.Add("Seal_-276-244-444", false, "First");
        settings.Add("Seal_-180-148-44-28", false, "Second");
        settings.Add("Seal_-180-148-60-44", false, "Third");
        settings.Add("Seal_-2012-124", false, "Fourth");

    settings.CurrentDefaultParent = "Seal_04_C_RiviereTurquoise";
        settings.Add("Seal_-180-1483668", false, "First");
        settings.Add("Seal_460492-124-108", false, "Second");
        settings.Add("Seal_844876-284", false, "Third");

    settings.CurrentDefaultParent = "Seal_05_B_SunkenShrine";
        settings.Add("Seal_-148-116-124-60", false, "First");
        settings.Add("Seal_204236-124", false, "Second");
        settings.Add("Seal_172268-188-172", false, "Third");

    settings.CurrentDefaultParent = "Seal_09_B_ElementalSkylands";
        settings.Add("Seal_-52-20420436", false, "First");
        settings.Add("Seal_18361868372388", false, "Second");
        settings.Add("Seal_28602892356388", false, "Third");

    vars.InitVars = (Action)(() => {
        vars.visitedLevels = new HashSet<string>();
        vars.currentCutsceneToSplit = vars.oldCutsceneToSplit = "";
        vars.currentChallengeRoomToSplit = vars.oldChallengeRoomToSplit = "";
        vars.itemsToSplit = new Queue<string>();
        vars.itemId = new List<int>();
        vars.itemNb = new List<int>();
        vars.timeshardOffset = -1;
        vars.oldTimeshardAmount = 0;
        vars.invIdAddr = vars.invNbAddr = IntPtr.Zero;
    });

    vars.GetItemId = (Func<Process, int, int>)((proc, offset) => {
        return proc.ReadValue<int>((IntPtr)(vars.invIdAddr+0x20+0x4*offset));
    });

    vars.GetItemNb = (Func<Process, int, int>)((proc, offset) => {
        return proc.ReadValue<int>((IntPtr)(vars.invNbAddr+0x20+0x4*offset));
    });

    vars.ReadString = (Func<Process, long, int, string>)((proc, baseOffset, count) => {
        return proc.ReadString(proc.ReadPointer((IntPtr)(baseOffset+0x20+0x8*(count-1)))+0x14, 128);
    });
}

init {
    vars.InitVars();
}

update {
    //Don't update in main menu
    if(current.sceneName == "") return false;
    
    //Remove empty id to match new inventory struct
    if(old.sceneName == "") {
        for(int i = 2; i < vars.itemId.Count; i++) {
            if(vars.itemId[i] == 0) {
                vars.itemId.RemoveAt(i);
                vars.itemNb.RemoveAt(i);
            }
        }
    }

    vars.invIdAddr = (IntPtr)current.inventoryIdAddr;
    vars.invNbAddr = (IntPtr)current.inventoryNbAddr;

    //Timeshard amount update
    if(vars.timeshardOffset != -1) {
        vars.oldTimeshardAmount = vars.itemNb[vars.timeshardOffset];
        vars.itemNb[vars.timeshardOffset] = vars.GetItemNb(game, vars.timeshardOffset);
    }

    //Inventory update
    if((old.inventoryCount != current.inventoryCount) || (old.inventorySize != current.inventorySize) || (vars.timeshardOffset != -1 && vars.oldTimeshardAmount > vars.itemNb[vars.timeshardOffset])) {
        for(int offset = 0; offset < current.inventorySize; offset++) {
            if(vars.itemId.Count-1 < offset) { //Add Item
                vars.itemId.Add(vars.GetItemId(game, offset));
                vars.itemNb.Add(vars.GetItemNb(game, offset));
                if(vars.itemId[offset] == 0) vars.timeshardOffset = offset;
                vars.itemsToSplit.Enqueue(vars.itemId[offset].ToString());
            } else if(vars.itemNb[offset] != vars.GetItemNb(game, offset)) { //Update Item
                vars.itemNb[offset] = vars.GetItemNb(game, offset);
                if(vars.itemId[offset] == 0) { //New Item
                    vars.itemId[offset] = vars.GetItemId(game, offset);
                    vars.itemsToSplit.Enqueue(vars.itemId[offset].ToString());
                } else { //Remove/Update Item
                    vars.itemsToSplit.Enqueue(vars.itemId[offset]+"_"+vars.itemNb[offset]);
                    vars.itemId[offset] = vars.GetItemId(game, offset);
                }
            } 
        }
    }

    //Challenge room update
    if(old.challengeRoomsCompletedCount != current.challengeRoomsCompletedCount) {
        vars.currentChallengeRoomToSplit = vars.ReadString(game, current.challengeRoomsCompletedAddr, current.challengeRoomsCompletedCount);
    }

    //Cutscenes update
    if(old.cutscenesPlayedCount != current.cutscenesPlayedCount) {
        vars.currentCutsceneToSplit = vars.ReadString(game, current.cutscenesPlayedAddr, current.cutscenesPlayedCount);
    }
}

start {
    if((old.sceneName == "Loader" || old.sceneName == "") && current.sceneName.StartsWith("Level_01")) {
        vars.InitVars();
        return true;
    }
}

split {
    //Level split
    if(old.sceneName != current.sceneName && old.sceneName.StartsWith("Level") && current.sceneName.StartsWith("Level") && vars.visitedLevels.Add(current.sceneName)) {
        return settings[current.sceneName.Substring(0, current.sceneName.Length-6)];
    }

    //Boss split
    if(old.bossesDefeatedCount < current.bossesDefeatedCount) {
        return settings["Boss_"+current.sceneName.Substring(6, current.sceneName.Length-12)];
    }

    //Item split
    while (vars.itemsToSplit.Count > 0) {
        var itemToSplit = vars.itemsToSplit.Dequeue();
        return settings.ContainsKey("Inventory_"+itemToSplit) && settings["Inventory_"+itemToSplit];
    }

    //Power Seal Split
    if(vars.oldChallengeRoomToSplit != vars.currentChallengeRoomToSplit) {
        vars.oldChallengeRoomToSplit = vars.currentChallengeRoomToSplit;
        return settings["Seal_"+vars.currentChallengeRoomToSplit];
    }

    //Cutscene Split
    if(vars.oldCutsceneToSplit != vars.currentCutsceneToSplit) {
        vars.oldCutsceneToSplit = vars.currentCutsceneToSplit;
        return settings.ContainsKey("Cutscene_"+vars.currentCutsceneToSplit) && settings["Cutscene_"+vars.currentCutsceneToSplit];
    }

    //End split
    if(current.sceneName == "Level_Ending_Build" && old.endMusic != 0 && current.endMusic == 0) {
        return settings["Beat_Mask"];
    }
}