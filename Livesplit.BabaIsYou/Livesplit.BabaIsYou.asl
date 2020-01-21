state("Baba Is You") {}

startup {
    vars.versions = new Dictionary<int, Tuple<string, int[]>>() {
        {0x5DF807E8, Tuple.Create("259", new int[] {0x3FE92C, 0x3FFB7C, 0x4004C4, 0x507088})}, //20/12/2019 – 21:29:26
        {0x5DCFEB62, Tuple.Create("253", new int[] {0x3FA75C, 0x3FB9AC, 0x3FC2F4, 0x502E48})}, //16/11/2019 – 19:31:53
        {0x5D435BFA, Tuple.Create("HX",  new int[] {0x3EA714, 0x3EB964, 0x3EC2AC, 0x4F26D8})}, //01/08/2019 – 22:29:19
        //04/07/2019 – 22:48:15
        //03/07/2019 – 10:24:41
        //02/07/2019 – 21:06:04
        //02/07/2019 – 01:37:26
        //01/07/2019 – 01:38:15
        //28/05/2019 – 01:05:25
        //13/05/2019 – 20:52:22
        {0x5CD083A6, Tuple.Create("HG",  new int[] {0x36BFBC, 0x36D20C, 0x36DB54, 0x473578})}, //07/05/2019 - 02:09:27
        {0x5CBFC893, Tuple.Create("HF",  new int[] {0x36BFC4, 0x36D214, 0x36DB5C, 0x473588})}, //24/04/2019 - 02:53:14
        {0x5CBE85B4, Tuple.Create("HEb", new int[] {0x36BFDC, 0x36D22C, 0x36DB74, 0x473598})}, //23/04/2019 - 09:27:45
        {0x5CBE64C1, Tuple.Create("HEa", new int[] {0x36BFDC, 0x36D22C, 0x36DB74, 0x473598})}, //23/04/2019 - 02:02:44
        {0x5CBD24FA, Tuple.Create("HD",  new int[] {0x36BF6C, 0x36D1BC, 0x36DB04, 0x473508})}, //22/04/2019 - 02:47:13
        {0x5CBCF2F6, Tuple.Create("HCb", new int[] {0x36BF6C, 0x36D1BC, 0x36DB04, 0x473508})}, //21/04/2019 - 23:11:31
        {0x5CBCD73A, Tuple.Create("HCa", new int[] {0x36BF6C, 0x36D1BC, 0x36DB04, 0x473508})}, //21/04/2019 - 21:33:32
        {0x5CBA4FFC, Tuple.Create("HA",  new int[] {0x366E8C, 0x3680DC, 0x368A24, 0x46E428})}, //19/04/2019 - 23:40:38
        {0x5CB94138, Tuple.Create("GZb", new int[] {0x366E8C, 0x3680DC, 0x368A24, 0x46E428})}, //19/04/2019 - 04:16:07
        {0x5CB91A91, Tuple.Create("GZa", new int[] {0x366E8C, 0x3680DC, 0x368A24, 0x46E428})}, //19/04/2019 - 01:16:47
        {0x5CB7E6C7, Tuple.Create("GY",  new int[] {0x366E8C, 0x3680DC, 0x368A24, 0x46E428})}, //18/04/2019 - 03:38:40
        {0x5CB658C4, Tuple.Create("GX",  new int[] {0x366E8C, 0x3680DC, 0x368A24, 0x46E428})}, //16/04/2019 - 23:21:20
        {0x5CAFC63B, Tuple.Create("GW",  new int[] {0x366E74, 0x3680C4, 0x368A0C, 0x46E408})}, //12/04/2019 - 00:28:16
        {0x5CABBF04, Tuple.Create("GV",  new int[] {0x365E5C, 0x3670AC, 0x3679F4, 0x46D3F0})}, //08/04/2019 - 22:43:34
        {0x5CA68278, Tuple.Create("GUb", new int[] {0x365E5C, 0x3670AC, 0x3679F4, 0x3713F0})}, //04/04/2019 - 22:40:23
        {0x5CA67109, Tuple.Create("GUa", new int[] {0x365E5C, 0x3670AC, 0x3679F4, 0x3713F0})}, //04/04/2019 - 21:22:09
        {0x5CA2A41E, Tuple.Create("GTb", new int[] {0x365E1C, 0x36706C, 0x3679B4, 0x371380})}, //03/04/2019 - 17:31:41
        {0x5CA243C6, Tuple.Create("GTa", new int[] {0x364E1C, 0x36606C, 0x3669B4, 0x370378})}, //01/04/2019 - 17:33:31
        {0x5C9E8284, Tuple.Create("GPb", new int[] {0x362BFC, 0x363E4C, 0x364794, 0x36E120})}, //29/03/2019 - 21:49:34
        {0x5C9DEDBD, Tuple.Create("GPa", new int[] {0x362BFC, 0x363E4C, 0x364794, 0x36E120})}, //29/03/2019 - 11:23:14
        {0x5C9C13F3, Tuple.Create("GNb", new int[] {0x34CA4C, 0x34DC9C, 0x34E5E4, 0x357F78})}, //28/03/2019 - 01:09:32
        {0x5C9BF3B8, Tuple.Create("GNa", new int[] {0x34CA4C, 0x34DC9C, 0x34E5E4, 0x357F78})}, //27/03/2019 - 22:49:23
        {0x5C9BDA55, Tuple.Create("GM",  new int[] {0x34CA4C, 0x34DC9C, 0x34E5E4, 0x357F78})}, //27/03/2019 - 21:03:02
        {0x5C9AC6E7, Tuple.Create("GL",  new int[] {0x34CA4C, 0x34DC9C, 0x34E5E4, 0x357F78})}, //27/03/2019 - 18:15:01
        {0x5C8F38F3, Tuple.Create("GK",  new int[] {0x34D9D4, 0x34EC24, 0x34F56C, 0x358EF8})}, //18/03/2019 - 22:32:48
        {0x5C8B9C84, Tuple.Create("GJ",  new int[] {0x34C9BC, 0x34DC0C, 0x34E554, 0x357EE8})}, //15/03/2019 - 14:26:18
        {0x5C8580CE, Tuple.Create("GF",  new int[] {0x34A974, 0x34BBC4, 0x34C50C, 0x355E98})}  //13/03/2019 - 16:00:20
    };

    settings.Add("lv", true, "Split at every level done");

    settings.Add("en", false, "Enter Worlds");
    settings.Add("ex", false, "Exit Worlds");

    vars.worlds = new Dictionary<string, string>(StringComparer.Ordinal) {
        {"106", "0.Overworld"},
        {"177", "1.The Lake"},
        {"207", "2.Solitary Island"},
        {"206", "3.Temple Ruins"},
        {"16l", "4.Forest Of Fall"},
        {"169", "5.Deep Forest"},
        {"87l", "6.Rocket Trip"},
        {"180", "7.Flower Garden"},
        {"179", "8.Volcanic Cavern"},
        {"182", "9.Chasm"},
        {"232", "10.Mountaintop"},
        {"200", "11.???"},
        {"282", "12.ABC"},
        {"264", "13.Depths"},
        {"283", "14.Meta"},
        {"304", "15.Center"}
    };

    int worldCount = -1;
    foreach(KeyValuePair<string, string> vk in vars.worlds) {
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

    Tuple<string, int[]> verInfo;
    if(vars.versions.ContainsKey(timeDateStamp))
        verInfo = vars.versions[timeDateStamp];
    else 
        return false;

    version = verInfo.Item1;

    vars.watchers = new MemoryWatcherList() {
        (vars.level = new StringWatcher(new DeepPointer(verInfo.Item2[0], 0x14, 0x30), 3)),
        (vars.end = new MemoryWatcher<int>(new DeepPointer(verInfo.Item2[1]))),
        (vars.menuId = new MemoryWatcher<int>(new DeepPointer(verInfo.Item2[2]))),
        (vars.fade = new MemoryWatcher<double>(new DeepPointer(verInfo.Item2[3])))
    };

    vars.lastPhase = false;
    vars.worldSplits = new HashSet<string>();
}

update {
    if(string.IsNullOrEmpty(version)) return false;

    vars.watchers.UpdateAll(game);
    
    if(string.IsNullOrEmpty(vars.level.Old) || string.IsNullOrEmpty(vars.level.Current))
        return false;
}

start {
    if(settings["ls"])
        return vars.level.Changed;
    else
        return vars.level.Current.Equals("0le", StringComparison.Ordinal) && vars.menuId.Current == 1 && vars.fade.Old == 0 && vars.fade.Current != 0;
}

split {
    if(vars.level.Old.Equals("198", StringComparison.Ordinal) && vars.fade.Old >= 32 && vars.fade.Current < 32)
        return settings["tEnd"] || settings["lv"];

    if(vars.level.Current.Equals("203", StringComparison.Ordinal)) {
        if(vars.end.Current > 32) vars.lastPhase = true;
        if(vars.end.Current == 1 && vars.end.Old > 1 && vars.lastPhase)
            return settings["fEnd"] || settings["lv"];
    } else vars.lastPhase = false;

    if(vars.level.Changed && vars.menuId.Old != 6 && vars.worlds.ContainsKey(vars.level.Current)) {
        if(vars.worlds.ContainsKey(vars.level.Old)) {
            string enter = string.Concat("en", vars.level.Current);
            string exit = string.Concat("ex", vars.level.Old, "_", vars.level.Current);
            return (settings.ContainsKey(enter) && vars.worldSplits.Add(enter) && settings[enter]) ||
                    (settings.ContainsKey(exit) && vars.worldSplits.Add(exit) && settings[exit]);
        } else {
            return settings["lv"];
        }
    }
}

shutdown {
    timer.OnStart -= vars.timerResetVars;
}