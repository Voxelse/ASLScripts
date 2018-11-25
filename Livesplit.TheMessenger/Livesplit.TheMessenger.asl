state ("TheMessenger") {
    //Need to replace custom ReadPointers to DeepPointers when 64bits pointers will be supported (e.g vars.UpdatePointers)
}

startup {
    refreshRate = 0.5;

    settings.Add("Levels", true, "Levels");
    settings.Add("Inventory", true, "Inventory");
    settings.Add("RoomTimer", false, "Individual Room Timer");

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
        settings.Add("13_TowerOfTimeHQ", false, "Tower Of Time HQ");
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
        settings.Add("Level_02_AutumnHills", true, "First Enter Level");
        settings.Add("Boss_02_AutumnHills", false, "Leaf Golem Last Hit");
        settings.Add("Checkpoint_02_AutumnHills", false, "Checkpoints");
        settings.Add("Cutscene_02_AutumnHills", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_02_AutumnHills";
            settings.Add("Checkpoint_02_AutumnHills_0", false, "Shop 0");
            settings.Add("Checkpoint_02_AutumnHills_1", false, "Save 1");
            settings.Add("Checkpoint_02_AutumnHills_2", false, "Shop 2");
            settings.Add("Checkpoint_02_AutumnHills_3", false, "Save 3");
            settings.Add("Checkpoint_02_AutumnHills_4", false, "Shop 4");
            settings.Add("Checkpoint_02_AutumnHills_5", false, "Shop 5");
            settings.Add("Checkpoint_02_AutumnHills_6", false, "Save 6");
            settings.Add("Checkpoint_02_AutumnHills_7", false, "Save 7");
            settings.Add("Checkpoint_02_AutumnHills_8", false, "Save 8");
        settings.CurrentDefaultParent = "Cutscene_02_AutumnHills";
            settings.Add("Cutscene_LeafGolemIntroCutScene", false, "Leaf Golem Intro Fight");
            settings.Add("Cutscene_LeafGolemOutroCutScene", false, "Leaf Golem Outro Fight");

    settings.CurrentDefaultParent = "03_ForlornTemple";
        settings.Add("Level_03_ForlornTemple", true, "First Enter Level");
        settings.Add("Checkpoint_03_ForlornTemple", false, "Checkpoints");
        settings.Add("Cutscene_03_ForlornTemple", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_03_ForlornTemple";
            settings.Add("Checkpoint_03_ForlornTemple_0", false, "Shop 0");
            settings.Add("Checkpoint_03_ForlornTemple_1", false, "Shop 1");
            settings.Add("Checkpoint_03_ForlornTemple_2", false, "Save 2");
            settings.Add("Checkpoint_03_ForlornTemple_3", false, "Save 3");
            settings.Add("Checkpoint_03_ForlornTemple_4", false, "Shop 4");
            settings.Add("Checkpoint_03_ForlornTemple_5", false, "Shop 5");
            settings.Add("Checkpoint_03_ForlornTemple_6", false, "Shop 6");
            settings.Add("Checkpoint_03_ForlornTemple_7", false, "Shop 7");
            settings.Add("Checkpoint_03_ForlornTemple_8", false, "Shop 8");
        settings.CurrentDefaultParent = "Cutscene_03_ForlornTemple";
            settings.Add("Cutscene_ForlonTempleBossIntroCutscene", false, "Demon King Intro Fight");
            settings.Add("Cutscene_ForlonTempleBossOutroCutscene", false, "Demon King Outro Fight");

    settings.CurrentDefaultParent = "04_Catacombs";
        settings.Add("Level_04_Catacombs", true, "First Enter Level");
        settings.Add("Boss_04_Catacombs", false, "Ruxxtin Last Hit");
        settings.Add("Checkpoint_04_Catacombs", false, "Checkpoints");
        settings.Add("Cutscene_04_Catacombs", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_04_Catacombs";
            settings.Add("Checkpoint_04_Catacombs_0", false, "Shop 0");
            settings.Add("Checkpoint_04_Catacombs_1", false, "Save 1");
            settings.Add("Checkpoint_04_Catacombs_2", false, "Save 2");
            settings.Add("Checkpoint_04_Catacombs_3", false, "Shop 3");
            settings.Add("Checkpoint_04_Catacombs_4", false, "Save 4");
        settings.CurrentDefaultParent = "Cutscene_04_Catacombs";
            settings.Add("Cutscene_NecromancerIntroCutscene", false, "Ruxxtin Intro Fight");
            settings.Add("Cutscene_NecromancerOutroCutscene", false, "Ruxxtin Outro Fight");

    settings.CurrentDefaultParent = "06_A_BambooCreek";
        settings.Add("Level_06_A_BambooCreek", true, "First Enter Level");
        settings.Add("Checkpoint_06_A_BambooCreek", false, "Checkpoints");
        settings.CurrentDefaultParent = "Checkpoint_06_A_BambooCreek";
            settings.Add("Checkpoint_06_A_BambooCreek_0", false, "Shop 0");
            settings.Add("Checkpoint_06_A_BambooCreek_1", false, "Shop 1");
            settings.Add("Checkpoint_06_A_BambooCreek_2", false, "Save 2");
            settings.Add("Checkpoint_06_A_BambooCreek_3", false, "Shop 3");
            settings.Add("Checkpoint_06_A_BambooCreek_4", false, "Save 4");

    settings.CurrentDefaultParent = "05_A_HowlingGrotto";
        settings.Add("Level_05_A_HowlingGrotto", true, "First Enter Level");
        settings.Add("Boss_05_A_HowlingGrotto", false, "Emerald Golem Last Hit");
        settings.Add("Checkpoint_05_A_HowlingGrotto", false, "Checkpoints");
        settings.Add("Cutscene_05_A_HowlingGrotto", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_05_A_HowlingGrotto";
            settings.Add("Checkpoint_05_A_HowlingGrotto_0", false, "Shop 0");
            settings.Add("Checkpoint_05_A_HowlingGrotto_1", false, "Save 1");
            settings.Add("Checkpoint_05_A_HowlingGrotto_2", false, "Shop 2");
            settings.Add("Checkpoint_05_A_HowlingGrotto_3", false, "Shop 3");
            settings.Add("Checkpoint_05_A_HowlingGrotto_4", false, "Save 4");
        settings.CurrentDefaultParent = "Cutscene_05_A_HowlingGrotto";
            settings.Add("Cutscene_HowlingGrottoBossIntroCutscene", false, "Emerald Golem Intro Fight");
            settings.Add("Cutscene_HowlingGrottoBossOutroCutscene", false, "Emerald Golem Outro Fight");

    settings.CurrentDefaultParent = "07_QuillshroomMarsh";
        settings.Add("Level_07_QuillshroomMarsh", true, "First Enter Level");
        settings.Add("Boss_07_QuillshroomMarsh", false, "Queen Of Quills Last Hit");
        settings.Add("Checkpoint_07_QuillshroomMarsh", false, "Checkpoints");
        settings.Add("Cutscene_07_QuillshroomMarsh", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_07_QuillshroomMarsh";
            settings.Add("Checkpoint_07_QuillshroomMarsh_0", false, "Shop 0");
            settings.Add("Checkpoint_07_QuillshroomMarsh_1", false, "Save 1");
            settings.Add("Checkpoint_07_QuillshroomMarsh_2", false, "Shop 2");
            settings.Add("Checkpoint_07_QuillshroomMarsh_3", false, "Save 3");
            settings.Add("Checkpoint_07_QuillshroomMarsh_4", false, "Shop 4");
            settings.Add("Checkpoint_07_QuillshroomMarsh_5", false, "Save 5");
        settings.CurrentDefaultParent = "Cutscene_07_QuillshroomMarsh";
            settings.Add("Cutscene_QuillshroomMarshBossIntroCutscene", false, "Queen Of Quills Intro Fight");
            settings.Add("Cutscene_QuillshroomMarshBossOutroCutscene", false, "Queen Of Quills Outro Fight");
            settings.Add("Cutscene_DecurseQueenCutscene", false, "Decurse Queen");

    settings.CurrentDefaultParent = "08_SearingCrags";
        settings.Add("Level_08_SearingCrags", true, "First Enter Level");
        settings.Add("Boss_08_SearingCrags", false, "Colossuses Death");
        settings.Add("Checkpoint_08_SearingCrags", false, "Checkpoints");
        settings.Add("Cutscene_08_SearingCrags", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_08_SearingCrags";
            settings.Add("Checkpoint_08_SearingCrags_0", false, "Shop 0");
            settings.Add("Checkpoint_08_SearingCrags_1", false, "Shop 1");
            settings.Add("Checkpoint_08_SearingCrags_2", false, "Shop 2");
            settings.Add("Checkpoint_08_SearingCrags_3", false, "Shop 3");
            settings.Add("Checkpoint_08_SearingCrags_4", false, "Shop 4");
            settings.Add("Checkpoint_08_SearingCrags_5", false, "Shop 5");
            settings.Add("Checkpoint_08_SearingCrags_6", false, "Save 6");
            settings.Add("Checkpoint_08_SearingCrags_7", false, "Save 7");
        settings.CurrentDefaultParent = "Cutscene_08_SearingCrags";
            settings.Add("Cutscene_SearingCragsBossIntroCutscene", false, "Colossuses Intro Fight");
            settings.Add("Cutscene_SearingCragsPortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_SearingCragsGivePowerThistleCutscene", false, "Give Power Thistle");
        
    settings.CurrentDefaultParent = "09_A_GlacialPeak";
        settings.Add("Level_09_A_GlacialPeak", true, "First Enter Level");
        settings.Add("Checkpoint_09_A_GlacialPeak", false, "Checkpoints");
        settings.Add("Cutscene_09_A_GlacialPeak", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_09_A_GlacialPeak";
            settings.Add("Checkpoint_09_A_GlacialPeak_0", false, "Shop 0");
            settings.Add("Checkpoint_09_A_GlacialPeak_1", false, "Save 1");
            settings.Add("Checkpoint_09_A_GlacialPeak_2", false, "Shop 2");
            settings.Add("Checkpoint_09_A_GlacialPeak_3", false, "Save 3");
            settings.Add("Checkpoint_09_A_GlacialPeak_4", false, "Save 4");
            settings.Add("Checkpoint_09_A_GlacialPeak_5", false, "Shop 5");
        settings.CurrentDefaultParent = "Cutscene_09_A_GlacialPeak";
            settings.Add("Cutscene_CloudRuinsStaffTeleportEntranceCutscene", false, "Glacial Peak to Cloud Ruins (Ruxxtin's staff)");

    settings.CurrentDefaultParent = "10_A_TowerOfTime";
        settings.Add("Level_10_A_TowerOfTime", true, "First Enter Level");
        settings.Add("Boss_10_A_TowerOfTime", false, "Boss Last Hit (Arcane Golem)");
        settings.Add("Checkpoint_10_A_TowerOfTime", false, "Checkpoints");
        settings.Add("Cutscene_10_A_TowerOfTime", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_10_A_TowerOfTime";
            settings.Add("Checkpoint_10_A_TowerOfTime_0", false, "Shop 0");
            settings.Add("Checkpoint_10_A_TowerOfTime_1", false, "Save 1");
            settings.Add("Checkpoint_10_A_TowerOfTime_2", false, "Save 2");
            settings.Add("Checkpoint_10_A_TowerOfTime_3", false, "Save 3");
            settings.Add("Checkpoint_10_A_TowerOfTime_4", false, "Save 4");
            settings.Add("Checkpoint_10_A_TowerOfTime_5", false, "Save 5");
            settings.Add("Checkpoint_10_A_TowerOfTime_6", false, "Save 6");
            settings.Add("Checkpoint_10_A_TowerOfTime_7", false, "Shop 7");
        settings.CurrentDefaultParent = "Cutscene_10_A_TowerOfTime";
            settings.Add("Cutscene_TowerOfTimeBossIntroCutscene", false, "Arcane Golem Intro Fight");
            settings.Add("Cutscene_TowerOfTimeBossOutroCutscene", false, "Arcane Golem Outro Fight");

    settings.CurrentDefaultParent = "11_A_CloudRuins";
        settings.Add("Level_11_A_CloudRuins", true, "First Enter Level");
        settings.Add("Boss_11_A_CloudRuins", false, "Manfred Last Hit");
        settings.Add("Checkpoint_11_A_CloudRuins", false, "Checkpoints");
        settings.Add("Cutscene_11_A_CloudRuins", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_11_A_CloudRuins";
            settings.Add("Checkpoint_11_A_CloudRuins_0", false, "Shop 0");
            settings.Add("Checkpoint_11_A_CloudRuins_1", false, "Shop 1");
            settings.Add("Checkpoint_11_A_CloudRuins_2", false, "Shop 2");
            settings.Add("Checkpoint_11_A_CloudRuins_3", false, "Shop 3");
            settings.Add("Checkpoint_11_A_CloudRuins_4", false, "Shop 4");
            settings.Add("Checkpoint_11_A_CloudRuins_5", false, "Shop 5");
            settings.Add("Checkpoint_11_A_CloudRuins_6", false, "Shop 6");
            settings.Add("Checkpoint_11_A_CloudRuins_7", false, "Save 7");
            settings.Add("Checkpoint_11_A_CloudRuins_8", false, "Save 8");
            settings.Add("Checkpoint_11_A_CloudRuins_9", false, "Save 9");
            settings.Add("Checkpoint_11_A_CloudRuins_10", false, "Save 10");
        settings.CurrentDefaultParent = "Cutscene_11_A_CloudRuins";
            settings.Add("Cutscene_ManfredBossIntroCutscene", false, "Manfred Intro Fight");

    settings.CurrentDefaultParent = "12_UnderWorld";
        settings.Add("Level_12_UnderWorld", true, "First Enter Level");
        settings.Add("Boss_12_UnderWorld", false, "Demon General Last Hit");
        settings.Add("Checkpoint_12_UnderWorld", false, "Checkpoints");
        settings.Add("Cutscene_12_UnderWorld", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_12_UnderWorld";
            settings.Add("Checkpoint_12_UnderWorld_0", false, "Shop 0");
            settings.Add("Checkpoint_12_UnderWorld_1", false, "Save 1");
            settings.Add("Checkpoint_12_UnderWorld_2", false, "Shop 2");
            settings.Add("Checkpoint_12_UnderWorld_3", false, "Shop 3");
            settings.Add("Checkpoint_12_UnderWorld_4", false, "Save 4");
            settings.Add("Checkpoint_12_UnderWorld_5", false, "Shop 5");
            settings.Add("Checkpoint_12_UnderWorld_6", false, "Shop 6");
            settings.Add("Checkpoint_12_UnderWorld_7", false, "Save 7");
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
        settings.Add("Level_04_B_DarkCave", true, "First Enter Level");

    settings.CurrentDefaultParent = "04_C_RiviereTurquoise";
        settings.Add("Level_04_C_RiviereTurquoise", true, "First Enter Level");
        settings.Add("Boss_04_C_RiviereTurquoise", false, "Butterfly Matriarch Last Hit");
        settings.Add("Checkpoint_04_C_RiviereTurquoise", false, "Checkpoints");
        settings.Add("Cutscene_04_C_RiviereTurquoise", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_04_C_RiviereTurquoise";
            settings.Add("Checkpoint_04_C_RiviereTurquoise_0", false, "Shop 0");
            settings.Add("Checkpoint_04_C_RiviereTurquoise_1", false, "Shop 1");
            settings.Add("Checkpoint_04_C_RiviereTurquoise_2", false, "Shop 2");
            settings.Add("Checkpoint_04_C_RiviereTurquoise_3", false, "Shop 3");
            settings.Add("Checkpoint_04_C_RiviereTurquoise_4", false, "Shop 4");
            settings.Add("Checkpoint_04_C_RiviereTurquoise_5", false, "Save 5");
            settings.Add("Checkpoint_04_C_RiviereTurquoise_6", false, "Shop 6");
        settings.CurrentDefaultParent = "Cutscene_04_C_RiviereTurquoise";
            settings.Add("Cutscene_RiviereTurquoisePortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_RiviereTurquoiseBossIntroCutscene", false, "Butterfly Matriarch Intro");

    settings.CurrentDefaultParent = "05_B_SunkenShrine";
        settings.Add("Level_05_B_SunkenShrine", true, "First Enter Level");
        settings.Add("Checkpoint_05_B_SunkenShrine", false, "Checkpoints");
        settings.Add("Cutscene_05_B_SunkenShrine", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_05_B_SunkenShrine";
            settings.Add("Checkpoint_05_B_SunkenShrine_0", false, "Shop 0");
            settings.Add("Checkpoint_05_B_SunkenShrine_1", false, "Shop 1");
            settings.Add("Checkpoint_05_B_SunkenShrine_2", false, "Shop 2");
            settings.Add("Checkpoint_05_B_SunkenShrine_3", false, "Save 3");
            settings.Add("Checkpoint_05_B_SunkenShrine_4", false, "Shop 4");
            settings.Add("Checkpoint_05_B_SunkenShrine_5", false, "Shop 5");
            settings.Add("Checkpoint_05_B_SunkenShrine_6", false, "Save 6");
            settings.Add("Checkpoint_05_B_SunkenShrine_7", false, "Save 7");
            settings.Add("Checkpoint_05_B_SunkenShrine_8", false, "Save 8");
        settings.CurrentDefaultParent = "Cutscene_05_B_SunkenShrine";
            settings.Add("Cutscene_SunkenShrinePortalOpeningCutscene", false, "Portal Opening");
            settings.Add("Cutscene_DropCrestsCutscene", false, "Drop Crest");
            settings.Add("Cutscene_SunkenShrineEnterDoorCutscene", false, "Sunken Shrine Dialog");

    settings.CurrentDefaultParent = "09_B_ElementalSkylands";
        settings.Add("Level_09_B_ElementalSkylands", true, "First Enter Level");
        settings.Add("Boss_09_B_ElementalSkylands", false, "Clockwork Concierge Last Hit");
        settings.Add("Checkpoint_09_B_ElementalSkylands", false, "Checkpoints");
        settings.Add("Cutscene_09_B_ElementalSkylands", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_09_B_ElementalSkylands";
            settings.Add("Checkpoint_09_B_ElementalSkylands_0", false, "Shop 0");
            settings.Add("Checkpoint_09_B_ElementalSkylands_1", false, "Shop 1");
            settings.Add("Checkpoint_09_B_ElementalSkylands_2", false, "Shop 2");
            settings.Add("Checkpoint_09_B_ElementalSkylands_3", false, "Shop 3");
            settings.Add("Checkpoint_09_B_ElementalSkylands_4", false, "Shop 4");
            settings.Add("Checkpoint_09_B_ElementalSkylands_5", false, "Shop 5");
            settings.Add("Checkpoint_09_B_ElementalSkylands_6", false, "Shop 6");
            settings.Add("Checkpoint_09_B_ElementalSkylands_7", false, "Shop 7");
            settings.Add("Checkpoint_09_B_ElementalSkylands_8", false, "Save 8");
        settings.CurrentDefaultParent = "Cutscene_09_B_ElementalSkylands";
            settings.Add("Cutscene_ElementalSkylandsBossIntroCutscene", false, "Clockwork Concierge Intro Fight");
            settings.Add("Cutscene_SkylandsToGlacialPeakFirstTimeCutscene", false, "Skylands to Glacial Peak (Manfred)");

    settings.CurrentDefaultParent = "14_CorruptedFuture";
        settings.Add("Level_14_CorruptedFuture", true, "First Enter Level");

    settings.CurrentDefaultParent = "11_B_MusicBox";
        settings.Add("Level_11_B_MusicBox", true, "First Enter Level");
        settings.Add("Boss_11_B_MusicBox", false, "Phantom Last Hit");
        settings.Add("Checkpoint_11_B_MusicBox", false, "Checkpoints");
        settings.Add("Cutscene_11_B_MusicBox", false, "Cutscenes");
        settings.CurrentDefaultParent = "Checkpoint_11_B_MusicBox";
            settings.Add("Checkpoint_11_B_MusicBox_0", false, "Shop 0");
            settings.Add("Checkpoint_11_B_MusicBox_1", false, "Shop 1");
            settings.Add("Checkpoint_11_B_MusicBox_2", false, "Shop 2");
            settings.Add("Checkpoint_11_B_MusicBox_3", false, "Shop 3");
            settings.Add("Checkpoint_11_B_MusicBox_4", false, "Shop 4");
            settings.Add("Checkpoint_11_B_MusicBox_5", false, "Shop 5");
            settings.Add("Checkpoint_11_B_MusicBox_6", false, "Shop 6");
            settings.Add("Checkpoint_11_B_MusicBox_7", false, "Shop 7");
            settings.Add("Checkpoint_11_B_MusicBox_8", false, "Shop 8");
            settings.Add("Checkpoint_11_B_MusicBox_9", false, "Shop 9");
        settings.CurrentDefaultParent = "Cutscene_11_B_MusicBox";
            settings.Add("Cutscene_PhantomIntroCutscene", false, "Phantom Intro Fight");

    settings.CurrentDefaultParent = "Ending";
        settings.Add("Level_Ending", false, "First Enter Level");
        settings.Add("Boss_Ending", true, "Beat Mask");

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
        settings.Add("Inventory_3", false, "Scroll upgrade (Map)"); // 52 time travel
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
        settings.Add("Inventory_58", false, "Sun Crest"); //74 both
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
        settings.Add("Inventory_20", false, "Necro"); // 75 all
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

    vars.scanLevelManager = new SigScanTarget(0, "55 48 8B EC 48 83 EC 40 48 89 4D C8 48 B8");

    vars.scanProgressionManager = new SigScanTarget(0, "55 48 8B EC 56 48 83 EC 08 48 8B F1 48 8B 46 68 48 8B C8 BA 01 00 00 00");

    vars.scanInventoryManager = new SigScanTarget(0, "55 48 8B EC 56 57 41 56 41 57 48 83 EC 10 48 8B F9 48 8B F2 83 3E 00 48 8B 46 50 48 63 57 28");

    vars.scanGameManager = new SigScanTarget(6, "48 89 4D F0 48 B8 ?? ?? ?? ?? ?? ?? ?? ?? 48 8B 00 48 8B C8 83 39 00");

    vars.ResetVars = (Action)(() => {
        //Pointers
        vars.oldSceneName = vars.currentSceneName = "";
        vars.oldInventorySize = vars.currentInventorySize = 0;
        vars.oldInventoryCount = vars.currentInventoryCount = 0;
        vars.oldCheckpointIndex = vars.currentCheckpointIndex = 0;
        vars.oldBossesDefeatedCount = vars.currentBossesDefeatedCount = 0;
        vars.oldCutscenesPlayedCount = vars.currentCutscenesPlayedCount = 0;
        vars.oldChallengeRoomsCompletedCount = vars.currentChallengeRoomsCompletedCount = 0;

        //Splits
        vars.visitedLevels = new HashSet<string>();
        vars.savedCheckpoints = new HashSet<string>();
        vars.currentCutsceneToSplit = vars.oldCutsceneToSplit = "";
        vars.currentChallengeRoomToSplit = vars.oldChallengeRoomToSplit = "";

        //Items
        vars.timeshardOffset = -1;
        vars.oldTimeshardAmount = 0;
        vars.itemId = new List<int>();
        vars.itemNb = new List<int>();
        vars.itemsToSplit = new Queue<string>();

        //Room Timer
        vars.roomTimer = new Stopwatch();
        vars.previousRoomTime = vars.actualRoomTime = "0.00";
        vars.lastRoomKey = vars.oldRoomKey = vars.currentRoomKey = "";
        vars.gameManagerAddr = new MemoryWatcher<IntPtr>(IntPtr.Zero);
        
        vars.timerOldPhase = TimerPhase.NotRunning;
    });

    vars.UpdatePointers = (Action<Process>)((proc) => {
        //LevelManager
        vars.oldSceneName = vars.currentSceneName;
        vars.currentSceneName = proc.ReadString((IntPtr)vars.ReadPointers(proc, vars.levelManagerPtr, new int[] {vars.instructionsOffset[0], 0x0, 0x48})+0x14, 128);
        if(vars.currentSceneName == null) vars.currentSceneName = "";

        //ProgressionManager
        IntPtr progressionManagerPtr = vars.ReadPointers(proc, vars.progressionManagerPtr, new int[] {vars.instructionsOffset[1], 0x0});
        vars.oldCheckpointIndex = vars.currentCheckpointIndex;
        vars.currentCheckpointIndex = proc.ReadValue<int>((IntPtr)vars.ReadPointer(proc, progressionManagerPtr+0x30)+0x38);
        vars.oldBossesDefeatedCount = vars.currentBossesDefeatedCount;
        vars.currentBossesDefeatedCount = proc.ReadValue<int>((IntPtr)vars.ReadPointer(proc, progressionManagerPtr+0x48)+0x18);
        vars.oldCutscenesPlayedCount = vars.currentCutscenesPlayedCount;
        vars.currentCutscenesPlayedCount = proc.ReadValue<int>((IntPtr)vars.ReadPointer(proc, progressionManagerPtr+0x58)+0x18);
        vars.cutscenesPlayedAddr = vars.ReadPointers(proc, progressionManagerPtr, new int[] {0x58, 0x10});
        vars.oldChallengeRoomsCompletedCount = vars.currentChallengeRoomsCompletedCount;
        vars.currentChallengeRoomsCompletedCount = proc.ReadValue<int>((IntPtr)vars.ReadPointer(proc, progressionManagerPtr+0x70)+0x18);
        vars.challengeRoomsCompletedAddr = vars.ReadPointers(proc, progressionManagerPtr, new int[] {0x70, 0x10});
        
        //InventoryManager
        IntPtr inventoryManagerPtr = vars.ReadPointers(proc, vars.inventoryManagerPtr, new int[] {vars.instructionsOffset[2], 0x0, 0x48, 0x20});
        vars.inventoryIdAddr = vars.ReadPointer(proc, inventoryManagerPtr+0x20);
        vars.inventoryNbAddr = vars.ReadPointer(proc, inventoryManagerPtr+0x28);
        vars.oldInventorySize = vars.currentInventorySize;
        vars.currentInventorySize = proc.ReadValue<int>(inventoryManagerPtr+0x30);
        vars.oldInventoryCount = vars.currentInventoryCount;
        vars.currentInventoryCount = proc.ReadValue<int>(inventoryManagerPtr+0x38);
    });

    vars.ReadPointer = (Func<Process, IntPtr, IntPtr>)((proc, basePtr) => {
        IntPtr ptr = basePtr;
        proc.ReadPointer((IntPtr)(ptr), !((bool)vars.use32bit), out ptr);
        return ptr;
    });

    vars.ReadPointers = (Func<Process, IntPtr, int[], IntPtr>)((proc, basePtr, offsets) => {
        IntPtr ptr = basePtr;
        foreach(int offset in offsets) {
            proc.ReadPointer((IntPtr)(ptr+offset), !((bool)vars.use32bit), out ptr);
        }
        return ptr;
    });

    vars.ReadString = (Func<Process, IntPtr, int, string>)((proc, baseOffset, count) => {
        return proc.ReadString((IntPtr)vars.ReadPointer(proc, (IntPtr)(baseOffset+0x20+0x8*(count-1)))+0x14, 128);
    });

    vars.UpdateRoomTimer = (Action<Process, bool>)((proc, inMenu) => {
        if(vars.textSettingCurrent == null || vars.textSettingPrevious == null) {
            foreach (dynamic component in timer.Layout.Components) {
                if (component.GetType().Name != "TextComponent") continue;
                if (component.Settings.Text1 == "Current Room") vars.textSettingCurrent = component.Settings;
                if (component.Settings.Text1 == "Previous Room") vars.textSettingPrevious = component.Settings;
            }

            if(vars.textSettingCurrent == null)
                vars.textSettingCurrent = vars.CreateTextComponent("Current Room");

            if(vars.textSettingPrevious == null)
                vars.textSettingPrevious = vars.CreateTextComponent("Previous Room");
        }

        if(!inMenu && timer.CurrentPhase == TimerPhase.Running) {
            vars.gameManagerAddr.Update(proc);

            //Update GameManager Pointer
            if(vars.gameManagerAddr.Current == IntPtr.Zero || vars.gameManagerAddr.Changed) {
                vars.gameManagerAddr = new MemoryWatcher<IntPtr>(proc.ReadPointer((IntPtr)(vars.gameManagerPtr+vars.instructionsOffset[3])));
                vars.gameManagerAddr.Update(proc);
            }

            //Update Room Key
            vars.oldRoomKey = vars.currentRoomKey;
            vars.currentRoomKey = proc.ReadString(proc.ReadPointer(proc.ReadPointer(proc.ReadPointer((IntPtr)vars.gameManagerAddr.Current+0x18)+0x88)+0x10)+0x14, 32);

            //Update times
            if(vars.oldRoomKey != vars.currentRoomKey) {
                if(vars.currentRoomKey == null) {
                    vars.roomTimer.Stop(); //Stop during loading
                } else {
                    if(vars.oldRoomKey == null) {
                        if(vars.lastRoomKey == vars.currentRoomKey) {
                            vars.roomTimer.Start(); //Resume after loading
                        } else {
                            vars.previousRoomTime = vars.FormatTimer(vars.roomTimer.Elapsed);
                            vars.roomTimer.Restart(); //Restart after loading
                        }
                    } else {
                        vars.previousRoomTime = vars.FormatTimer(vars.roomTimer.Elapsed);
                        vars.roomTimer.Restart(); //Restart
                    }
                    vars.lastRoomKey = vars.currentRoomKey;
                }
            }
            vars.actualRoomTime = vars.FormatTimer(vars.roomTimer.Elapsed);
        }

        //Updating Text Components
        vars.textSettingCurrent.Text2 = timer.CurrentPhase == TimerPhase.Running ? vars.actualRoomTime : "0.00";
        vars.textSettingPrevious.Text2 = timer.CurrentPhase == TimerPhase.Running ? vars.previousRoomTime : "0.00";
    });

    vars.CreateTextComponent = (Func<string, dynamic>)((name) => {
        var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
        dynamic textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
        timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));
        textComponent.Settings.Text1 = name;
        return textComponent.Settings;
    });

    vars.FormatTimer = (Func<TimeSpan, string>)((timeSpan) => {
        string minutes = (timeSpan.Minutes > 0)?timeSpan.Minutes+":" : "";
        string seconds = ((timeSpan.Minutes != 0 && timeSpan.Seconds < 10)?"0"+timeSpan.Seconds:timeSpan.Seconds.ToString())+".";
        string milliseconds = timeSpan.Milliseconds.ToString("D3").Remove(2);
        return minutes + seconds + milliseconds;
    });
}

init {
    bool instructionsFound = false;
    vars.levelManagerPtr = IntPtr.Zero;
    vars.progressionManagerPtr = IntPtr.Zero;
    vars.inventoryManagerPtr = IntPtr.Zero;
    vars.gameManagerPtr = IntPtr.Zero;

    print("[Autosplitter] Scanning memory");
    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

        if(vars.levelManagerPtr == IntPtr.Zero) {
            vars.levelManagerPtr = scanner.Scan(vars.scanLevelManager);
            if(vars.levelManagerPtr != IntPtr.Zero) print("[Autosplitter] LevelManager Found : " + vars.levelManagerPtr.ToString("X"));
        }

        if(vars.progressionManagerPtr == IntPtr.Zero) {
            vars.progressionManagerPtr = scanner.Scan(vars.scanProgressionManager);
            if(vars.progressionManagerPtr != IntPtr.Zero) print("[Autosplitter] ProgressionManager Found : " + vars.progressionManagerPtr.ToString("X"));
        }

        if(vars.inventoryManagerPtr == IntPtr.Zero) {
            vars.inventoryManagerPtr = scanner.Scan(vars.scanInventoryManager);
            if(vars.inventoryManagerPtr != IntPtr.Zero) print("[Autosplitter] InventoryManager Found : " + vars.inventoryManagerPtr.ToString("X"));
        }

        if(settings["RoomTimer"] && vars.gameManagerPtr == IntPtr.Zero) {
            vars.gameManagerPtr = scanner.Scan(vars.scanGameManager);
            if(vars.gameManagerPtr != IntPtr.Zero) print("[Autosplitter] GameManager Found : " + vars.gameManagerPtr.ToString("X"));
        }

        instructionsFound = vars.levelManagerPtr != IntPtr.Zero && vars.progressionManagerPtr != IntPtr.Zero && vars.inventoryManagerPtr != IntPtr.Zero && (settings["RoomTimer"] ? vars.gameManagerPtr != IntPtr.Zero : true);
        if(instructionsFound)
            break;
    }

    //Waiting for the game to have booted up
    if (!instructionsFound)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.use32bit = false;//game.ReadValue<byte>((IntPtr)vars.levelManagerPtr+0x57) == 0x7E ? false : true;
    print("[Autosplitter] Use 32 bit integer : "+vars.use32bit);
    vars.instructionsOffset = vars.use32bit ? new int[] {0x800, 0xD56, 0x70, 0x00} : new int[] {0x14C, 0x6E, 0xA6, 0x00};

    vars.textSettingCurrent = vars.textSettingPrevious = null;

    vars.ResetVars();

    refreshRate = 60;
}

update {
    //Reset vars when starting
    if(vars.timerOldPhase == TimerPhase.NotRunning && timer.CurrentPhase == TimerPhase.Running)
        vars.ResetVars();

    vars.timerOldPhase = timer.CurrentPhase;

    vars.UpdatePointers(game);

    bool inMenu = vars.currentSceneName.Length < 8 || vars.oldSceneName.Length < 8;

    if(settings["RoomTimer"])
        vars.UpdateRoomTimer(game, inMenu);

    //Don't update in main menu (inMenu and : notRunning => do start() / running => don't split())
    if(inMenu) return timer.CurrentPhase == TimerPhase.NotRunning;
    
    //Remove empty id to match new inventory struct
    if(vars.oldSceneName.Length < 8) {
        for(int i = 2; i < vars.itemId.Count; i++) {
            if(vars.itemId[i] == 0) {
                vars.itemId.RemoveAt(i);
                vars.itemNb.RemoveAt(i);
            }
        }
    }

    //Timeshard amount update
    if(vars.timeshardOffset != -1) {
        vars.oldTimeshardAmount = vars.itemNb[vars.timeshardOffset];
        vars.itemNb[vars.timeshardOffset] = game.ReadValue<int>((IntPtr)(vars.inventoryNbAddr+0x20+0x4*vars.timeshardOffset));
    }

    //Inventory update
    if((vars.oldInventoryCount != vars.currentInventoryCount) || (vars.oldInventorySize != vars.currentInventorySize) || (vars.timeshardOffset != -1 && vars.oldTimeshardAmount > vars.itemNb[vars.timeshardOffset])) {
        bool firstAdd = vars.itemId.Count == 0;
        for(int offset = 0; offset < vars.currentInventorySize; offset++) {
            var id = game.ReadValue<int>((IntPtr)(vars.inventoryIdAddr+0x20+0x4*offset));
            var nb = game.ReadValue<int>((IntPtr)(vars.inventoryNbAddr+0x20+0x4*offset));

            if(vars.itemId.Count-1 < offset) { //Add Item
                vars.itemId.Add(id);
                vars.itemNb.Add(nb);
                if(id == 0) vars.timeshardOffset = offset;
                if(!firstAdd) vars.itemsToSplit.Enqueue(vars.itemId[offset].ToString());
            } else if(vars.itemNb[offset] != nb) { //Update Item
                vars.itemNb[offset] = nb;
                if(vars.itemId[offset] == 0) { //New Item
                    vars.itemId[offset] = id;
                    vars.itemsToSplit.Enqueue(vars.itemId[offset].ToString());
                } else { //Remove/Update Item
                    vars.itemsToSplit.Enqueue(vars.itemId[offset]+"_"+vars.itemNb[offset]);
                    vars.itemId[offset] = id;
                }
            } 
        }
    }

    //Challenge room update
    if(vars.oldChallengeRoomsCompletedCount != vars.currentChallengeRoomsCompletedCount) {
        vars.currentChallengeRoomToSplit = vars.ReadString(game, vars.challengeRoomsCompletedAddr, vars.currentChallengeRoomsCompletedCount);
    }

    //Cutscenes update
    if(vars.oldCutscenesPlayedCount != vars.currentCutscenesPlayedCount) {
        vars.currentCutsceneToSplit = vars.ReadString(game, vars.cutscenesPlayedAddr, vars.currentCutscenesPlayedCount);
    }
}

start {
    return vars.currentSceneName.StartsWith("Level_01") && vars.oldSceneName.Length < 8;
}

split {
    //Level split
    if(vars.oldSceneName != vars.currentSceneName && vars.oldSceneName.Length > 8 && vars.currentSceneName.Length > 8 && vars.visitedLevels.Add(vars.currentSceneName)) {
        return settings[vars.currentSceneName.Substring(0, vars.currentSceneName.Length-6)];
    }

    //Boss split
    if(vars.oldBossesDefeatedCount < vars.currentBossesDefeatedCount) {
        return settings["Boss_"+vars.currentSceneName.Substring(6, vars.currentSceneName.Length-12)];
    }

    //Item split
    while(vars.itemsToSplit.Count > 0) {
        string itemToSplit = vars.itemsToSplit.Dequeue();
        if(settings.ContainsKey("Inventory_"+itemToSplit) && settings["Inventory_"+itemToSplit]) {
            vars.itemsToSplit.Clear();
            return true;
        }
    }

    //Power Seal Split
    if(vars.oldChallengeRoomToSplit != vars.currentChallengeRoomToSplit) {
        vars.oldChallengeRoomToSplit = vars.currentChallengeRoomToSplit;
        return settings["Seal_"+vars.currentChallengeRoomToSplit];
    }

    //Checkpoint Split
    if(vars.oldCheckpointIndex != vars.currentCheckpointIndex && vars.savedCheckpoints.Add(vars.currentSceneName+"_"+vars.currentCheckpointIndex)) {
        if(vars.currentCheckpointIndex > -1)
            return settings["Checkpoint_"+vars.currentSceneName.Substring(6, vars.currentSceneName.Length-12)+"_"+vars.currentCheckpointIndex];
    }

    //Cutscene Split
    if(vars.oldCutsceneToSplit != vars.currentCutsceneToSplit) {
        vars.oldCutsceneToSplit = vars.currentCutsceneToSplit;
        return settings.ContainsKey("Cutscene_"+vars.currentCutsceneToSplit) && settings["Cutscene_"+vars.currentCutsceneToSplit];
    }
}