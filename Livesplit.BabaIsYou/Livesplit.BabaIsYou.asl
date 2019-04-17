state("Baba Is You") {}

startup {
    vars.versions = new Dictionary<int, Tuple<string, List<int>>>() {
        {0x5CB658C4, Tuple.Create("GX", new List<int>{0x366E8C, 0x3680DC, 0x368A24, 0x46E428})},  //GX  16/042019  – 23:21:20
        {0x5CAFC63B, Tuple.Create("GW", new List<int>{0x366E74, 0x3680C4, 0x368A0C, 0x46E408})},  //GW  12/04/2019 - 00:28:16
        {0x5CABBF04, Tuple.Create("GV", new List<int>{0x365E5C, 0x3670AC, 0x3679F4, 0x46D3F0})},  //GV  08/04/2019 – 22:43:34
        {0x5CA68278, Tuple.Create("GU", new List<int>{0x365E5C, 0x3670AC, 0x3679F4, 0x3713F0})},  //GU? 04/04/2019 – 22:40:23
        {0x5CA67109, Tuple.Create("GU", new List<int>{0x365E5C, 0x3670AC, 0x3679F4, 0x3713F0})},  //GU  04/04/2019 – 21:22:09
        {0x5CA2A41E, Tuple.Create("GT", new List<int>{0x365E1C, 0x36706C, 0x3679B4, 0x371380})},  //GT? 03/04/2019 – 17:31:41
        {0x5CA243C6, Tuple.Create("GR", new List<int>{0x364E1C, 0x36606C, 0x3669B4, 0x370378})},  //GR? 01/04/2019 – 17:33:31
        {0x5C9E8284, Tuple.Create("GQ", new List<int>{0x362BFC, 0x363E4C, 0x364794, 0x36E120})},  //GQ? 29/03/2019 – 21:49:34
                                                                                                 //GP  29/03/2019 – 11:23:14
                                                                                                 //GO? 28/03/2019 – 01:09:32
        {0x5C9BF3B8, Tuple.Create("GN", new List<int>{0x34CA4C, 0x34DC9C, 0x34E5E4, 0x357F78})},  //GN? 27/03/2019 – 22:49:23
                                                                                                 //GM? 27/03/2019 – 21:03:02
                                                                                                 //GL  27/03/2019 – 18:15:01
        {0x5C8F38F3, Tuple.Create("GK", new List<int>{0x34D9D4, 0x34EC24, 0x34F56C, 0x358EF8})},  //GK  18/03/2019 – 22:32:48
        {0x5C8B9C84, Tuple.Create("GJ", new List<int>{0x34C9BC, 0x34DC0C, 0x34E554, 0x357EE8})},  //GJ  15/03/2019 – 14:26:18
        {0x5C8580CE, Tuple.Create("GF", new List<int>{0x34A974, 0x34BBC4, 0x34C50C, 0x355E98})}   //GF  13/03/2019 – 16:00:20
    };

    settings.Add("lv", true, "Split at every level done");

    settings.Add("en", false, "Enter Worlds");
    settings.Add("ex", false, "Exit Worlds");

    vars.worlds = new Dictionary<short, string>() {
        {106, "0.Overworld"},
        {177, "1.The Lake"},
        {207, "2.Solitary Island"},
        {206, "3.Temple Ruins"},
        {16,  "4.Forest Of Fall"},
        {169, "5.Deep Forest"},
        {87,  "6.Rocket Trip"},
        {180, "7.Flower Garden"},
        {179, "8.Volcanic Cavern"},
        {182, "9.Chasm"},
        {232, "10.Mountaintop"},
        {200, "11.???"},
        {282, "12.ABC"},
        {264, "13.Depths"},
        {283, "14.Meta"},
        {304, "15.Center"}
    };

    int worldCount = -1;
    foreach(KeyValuePair<short, string> vk in vars.worlds) {
        if(++worldCount == 0) continue;
        settings.Add("en"+vk.Key, false, vk.Value, "en");
        if(worldCount > 10) continue;
        settings.Add("ex"+vk.Key+"_106", false, vk.Value.Substring(vk.Value.IndexOf('.')+1)+" To Overworld", "ex");
    }

    settings.Add("ex282_200", false, "ABC To ???", "ex");

    settings.Add("fEnd", true, "Finale: A Way Out? (End)");
    settings.Add("tEnd", true, "The End (True End)");

    settings.Add("ls", false, "Start on every level change");

    vars.timerResetVars = (EventHandler)((s, e) => {
        vars.lastPhase = false;
        vars.worldSplits.Clear();
    });
    timer.OnStart += vars.timerResetVars;
}

init {
    var buffer = new byte[2048];
    using (var stream = new FileStream(game.MainModule.FileName, FileMode.Open, FileAccess.Read))
        stream.Read(buffer, 0, 2048);

    int offset = BitConverter.ToInt32(buffer, 0x3C);
    int timeDateStamp = BitConverter.ToInt32(buffer, offset+0x8);

    Tuple<string, List<int>> verInfo = vars.versions[timeDateStamp];

    if(verInfo == null)  return false;

    version = verInfo.Item1;

    vars.level = new StringWatcher(new DeepPointer(verInfo.Item2[0], 0x14, 0x30), 8);
    vars.end = new MemoryWatcher<int>(new DeepPointer(verInfo.Item2[1]));
    vars.menuId = new MemoryWatcher<int>(new DeepPointer(verInfo.Item2[2]));
    vars.fade = new MemoryWatcher<double>(new DeepPointer(verInfo.Item2[3]));

    vars.lastPhase = false;
    vars.worldSplits = new HashSet<string>();
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
        if(vars.end.Current == 1 && vars.end.Old > 1 && vars.lastPhase)
            return settings["fEnd"] || settings["lv"];
    } else vars.lastPhase = false;

    if(vars.level.Current.Equals("198level") && vars.level.Old.Equals("198level")) {
        if(vars.fade.Old == 32 && vars.fade.Current < 32)
            return settings["tEnd"] || settings["lv"];
    }

    if(!vars.level.Current.Equals(vars.level.Old) && vars.menuId.Old != 6) {
        string oldId = vars.level.Old.Substring(0, vars.level.Old.Length-5);
        string curId = vars.level.Current.Substring(0, vars.level.Current.Length-5);
        if(oldId[0].Equals('n')) oldId = "-"+oldId.Substring(1);
        if(curId[0].Equals('n')) curId = "-"+curId.Substring(1);
        short oldLvl = short.Parse(oldId);
        short curLvl = short.Parse(curId);
        if(vars.worlds.ContainsKey(curLvl)) {
            if(vars.worlds.ContainsKey(oldLvl)) {
                string enter = "en"+curLvl;
                string exit = "ex"+oldLvl+"_"+curLvl;
                return (settings.ContainsKey(enter) && vars.worldSplits.Add(enter) && settings[enter])
                       || (settings.ContainsKey(exit) && vars.worldSplits.Add(exit) && settings[exit]);
            } else {
                return settings["lv"];
            }
        }
    }
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}