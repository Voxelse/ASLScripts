state ("Katana Zero") {
    int map : 0x1BC5898;
    int state : 0x19B4640, 0x0, 0x3C, 0x8, 0x80;
}

startup {
    settings.Add("tape1", true, "1 - Factory");
    settings.Add("tape2", true, "2 - Hotel");
    settings.Add("tape3", true, "3 - Club");
    settings.Add("tape4", true, "4 - Prison");
    settings.Add("tape5", true, "5 - Studio");
    settings.Add("tape6", true, "6 - Mansion");
    settings.Add("tape7", true, "7 - Chinatown");
    settings.Add("tape8", true, "8 - Drg.tape");
    settings.Add("tape9", true, "9 - Sltr.house");
    settings.Add("tape10", true, "10 - Bunker");
    settings.Add("tape11", true, "11 - Bunker Pt.2");

    settings.CurrentDefaultParent = "tape1";
    settings.Add("fight1", false, "Individual Fights");
    settings.Add("1_11", false, "Target (End Mission)");
    settings.Add("1_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight1";
    settings.Add("1_6", false, "Tutorial");
    settings.Add("1_7", false, "Phone");
    settings.Add("1_8", false, "Fight 1");
    settings.Add("1_9", false, "Fight 2");
    settings.Add("1_10", false, "Fight 3");

    settings.CurrentDefaultParent = "tape2";
    settings.Add("2_149", false, "Dossier");
    settings.Add("fight2", false, "Individual Fights");
    settings.Add("2_19", false, "Target (End Mission)");
    settings.Add("2_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight2";
    settings.Add("2_13", false, "Reception");
    settings.Add("2_14", false, "Fight 1");
    settings.Add("2_15", false, "Fight 2");
    settings.Add("2_16", false, "Fight 3");
    settings.Add("2_17", false, "Fight 4");
    settings.Add("2_18", false, "Fight 5");


    settings.CurrentDefaultParent = "tape3";
    settings.Add("3_149", false, "Dossier");
    settings.Add("fight3", false, "Individual Fights");
    settings.Add("3_30", false, "Dance Out (End Mission)");
    settings.Add("3_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight3";
    settings.Add("3_22", false, "Dance In");
    settings.Add("3_23", false, "Fight 1");
    settings.Add("3_24", false, "Fight 2");
    settings.Add("3_25", false, "Fight 3");
    settings.Add("3_26", false, "Fight 4");
    settings.Add("3_27", false, "Fight 5");
    settings.Add("3_29", false, "Target");

    settings.CurrentDefaultParent = "tape4";
    settings.Add("4_149", false, "Dossier");
    settings.Add("fight4", false, "Individual Fights");
    settings.Add("4_32", false, "Fight 4 (End Mission)");
    settings.Add("4_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight4";
    settings.Add("4_41", false, "Target");
    settings.Add("4_40", false, "Fight 1");
    settings.Add("4_38", false, "Fight 2");
    settings.Add("4_34", false, "Fight 3");

    settings.CurrentDefaultParent = "tape5";
    settings.Add("5_45", false, "Studio Entrance");
    settings.Add("fight5", false, "Individual Fights");
    settings.Add("5_59", false, "Boss (End Mission)");
    settings.Add("5_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight5";
    settings.Add("5_46", false, "Fight 1");
    settings.Add("5_47", false, "Elevator");
    settings.Add("5_48", false, "2nd floor Fight 1");
    settings.Add("5_49", false, "2nd floor Fight 2");
    settings.Add("5_50", false, "2nd floor End");
    settings.Add("5_51", false, "3rd floor Fight 1");
    settings.Add("5_52", false, "3rd floor Fight 2");
    settings.Add("5_53", false, "3rd floor End");
    settings.Add("5_54", false, "Basement floor Fight 1");
    settings.Add("5_55", false, "Basement floor Fight 2");
    settings.Add("5_56", false, "Basement floor End");
    settings.Add("5_58", false, "Fight 2");

    settings.CurrentDefaultParent = "tape6";
    settings.Add("6_149", false, "Dossier");
    settings.Add("fight6", false, "Individual Fights");
    settings.Add("6_67", false, "Exit Mansion");
    settings.Add("6_68", false, "Moto Chase (End Mission)");
    settings.Add("6_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight6";
    settings.Add("6_60", false, "Fight 1");
    settings.Add("6_61", false, "Fight 2");
    settings.Add("6_62_63", false, "Fight 3");
    settings.Add("6_63", false, "Fight 4");
    settings.Add("6_64", false, "Fight 5");
    settings.Add("6_65", false, "Fight 6");
    settings.Add("6_66", false, "Boss");

    settings.CurrentDefaultParent = "tape7";
    settings.Add("7_149", false, "Dossier");
    settings.Add("7_70", false, "\"Boss\"");
    settings.Add("fight7", false, "Individual Fights");
    settings.Add("7_79", false, "Mask Choice (End Mission)");
    settings.Add("7_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight7";
    settings.Add("7_71", false, "Fight 1");
    settings.Add("7_72", false, "Fight 2");
    settings.Add("7_73", false, "Fight 3");
    settings.Add("7_74", false, "Fight 4");
    settings.Add("7_75", false, "Fight 5");
    settings.Add("7_76", false, "Fight 6");
    settings.Add("7_77", false, "Fight 7");
    settings.Add("7_78", false, "Fight 8");

    settings.CurrentDefaultParent = "tape8";
    settings.Add("fight8", false, "Individual Fights");
    settings.Add("8_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight8";
    settings.Add("8_80", false, "Fight 1");
    settings.Add("8_81", false, "Fight 2");
    settings.Add("8_82", false, "Fight 3");
    settings.Add("8_83", false, "Fight 4");

    settings.CurrentDefaultParent = "tape9";
    settings.Add("9_129", false, "Therapy Hall");
    settings.Add("fight9", false, "Individual Fights");
    settings.Add("9_103", false, "Target (End Mission)");
    settings.Add("9_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight9";
    settings.Add("9_92", false, "Fight 1");
    settings.Add("9_93", false, "Fight 2");
    settings.Add("9_94", false, "Fight 3");
    settings.Add("9_95", false, "Fight 4");
    settings.Add("9_96", false, "Fight 5");
    settings.Add("9_97", false, "Fight 6");
    settings.Add("9_98", false, "Fight 7");
    settings.Add("9_99", false, "Fight 8");
    settings.Add("9_100", false, "Fight 9");
    settings.Add("9_101", false, "Fight 10");
    settings.Add("9_102", false, "Fight 11");

    settings.CurrentDefaultParent = "tape10";
    settings.Add("10_149", false, "Dossier");
    settings.Add("fight10", false, "Individual Fights");
    settings.Add("10_115", false, "Jump (End Mission)");
    settings.Add("10_tape", true, "End Tape");
    settings.CurrentDefaultParent = "fight10";
    settings.Add("10_104", false, "Reception");
    settings.Add("10_105", false, "Fight 1");
    settings.Add("10_106", false, "Fight 2");
    settings.Add("10_107", false, "Fight 3");
    settings.Add("10_108", false, "Fight 4");
    settings.Add("10_109", false, "Fight 5");
    settings.Add("10_110", false, "Fight 6");
    settings.Add("10_111", false, "Fight 7");
    settings.Add("10_112", false, "Fight 8");
    settings.Add("10_113", false, "Fight 9");
    settings.Add("10_114", false, "Fight 10");

    settings.CurrentDefaultParent = "tape11";
    settings.Add("fight11", false, "Individual Fights");
    settings.Add("11_tape", true, "Boss 2 (End)");
    settings.CurrentDefaultParent = "fight11";
    settings.Add("11_117", false, "Fight 11");
    settings.Add("11_118", false, "Fight 12");
    settings.Add("11_119", false, "Fight 13");
    settings.Add("11_120", false, "Boss 1");

    vars.endTape = new HashSet<string>() {"12_128", "127_132", "127_126", "127_80", "84_126", "143_126", "151_117", "121_122"};
    
    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.tape = 1;
    });
    timer.OnStart += vars.timerResetVars;

    vars.startKill = false;
}

start {
    if(current.map != 6 || (current.map != old.map)) vars.startKill = false;

    if(current.map == 6 &&  old.state == 0 && current.state == 11) {
        if(!vars.startKill)
            vars.startKill = true;
        else
            return true;
    }
}


split {
    if(old.map != current.map) {
        if(vars.endTape.Contains(old.map+"_"+current.map))
            return settings[(vars.tape++)+"_tape"];
        var split = vars.tape+"_"+old.map;
        return (settings.ContainsKey(split) && settings[split]) || (settings.ContainsKey(split+"_"+current.map) && settings[split+"_"+current.map]);
    }
}

reset {
    return old.map != current.map && current.map <= 4;
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}