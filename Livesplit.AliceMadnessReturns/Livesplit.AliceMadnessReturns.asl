state("AliceMadnessReturns") {}

startup {
    settings.Add("Chapter1", true, "Chapter 1 - Hatter's Domain");
    settings.Add("Chapter2", true, "Chapter 2 - Deluded Depths");
    settings.Add("Chapter3", true, "Chapter 3 - Oriental Grove");
    settings.Add("Chapter4", true, "Chapter 4 - Queensland");
    settings.Add("Chapter5", true, "Chapter 5 - The Dollhouse");
    settings.Add("Chapter6", true, "Chapter 6 - Infernal Train");
    settings.Add("C_Start", false, "Auto-Start for Individual Chapters");

    vars.splitPos = new Dictionary<string, List<Tuple<bool, string, Vector3f>>>() {
        {"Chapter1_L1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Houndsditch Home - Rooftop", new Vector3f(-121104.8f, 133311.8f, -109116.9f))
        }},
        {"Chapter1_W1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "The Vale of Tears", new Vector3f(-143162.8f, -71054.6f, -134682.3f)),
            // Slug with a Shell
            // The Crockery
            Tuple.Create(false, "Trigger: Horn To Hatter's Gate", new Vector3f(-105929.5f, -134021.8f, -131036f)),
            Tuple.Create(true, "Hatter's Gate", new Vector3f(-50729.85f, -137103.9f, -130469.1f))
            // Always Elevenses
        }},
        {"Chapter1_W2_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Always Elevenses - Clockwork Bomb", new Vector3f(-91048.02f, 947.9908f, -4818.92f)),
            Tuple.Create(true, "About Face - Liddell Memory", new Vector3f(-84845.62f, 6713.691f, -1947.022f)),
            // About Face
            Tuple.Create(true, "About Face - Elevator", new Vector3f(-94517.91f, 7217.387f, -1193.873f)),
            Tuple.Create(true, "Smelling and Regurgitating", new Vector3f(16976.97f, -92662.27f, 1497.406f)),
            Tuple.Create(true, "Smelling and Regurgitating - Zone 2", new Vector3f(24200.41f, -105594f, 2662f)),
            Tuple.Create(true, "About Face - Back to Center", new Vector3f(-95021.53f, 4842.74f, -1734.546f)),
            Tuple.Create(true, "About Face - Elevator bis", new Vector3f(-94479.67f, 7230.345f, -1193.873f)),
            Tuple.Create(true, "Cranking Up & Pressing Down", new Vector3f(19094.85f, 157968.5f, 479.3957f)),
            Tuple.Create(true, "Cranking Up & Pressing Down - Zone 2", new Vector3f(9029.268f, 181402.9f, 2866.101f)),
            Tuple.Create(true, "Assemblage (or Destruction)", new Vector3f(137887.9f, 8691.061f, -595.816f))
        }},        
        {"Chapter2_L1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Billingsgate", new Vector3f(-47383.54f, -15982.41f, 600.7722f))
        }},
        {"Chapter2_W1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Tundraful", new Vector3f(113254.2f, -76914.14f, 311.8564f)),
            Tuple.Create(true, "Sliding toward Oblivion", new Vector3f(125714.9f, -67787.62f, 6691.982f)),
            Tuple.Create(true, "HMS Gryphon", new Vector3f(-134187.8f, -68716.9f, 110504.2f))
        }},
        {"Chapter2_W2_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Naval Disaster", new Vector3f(-107912.4f, 132039.7f, 14325.22f)),
            Tuple.Create(true, "Barrelbottom", new Vector3f(12677.41f, 177859.7f, 43016.92f)),
            Tuple.Create(true, "Barrelbottom - Dreary Lane Theatre", new Vector3f(-33298.88f, 102112.8f, -1229.45f)),
            Tuple.Create(true, "Inky Veil", new Vector3f(80753.61f, -166550.2f, 1551.779f))
        }},
        {"Chapter2_W3_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Choral Coral", new Vector3f(-22199.14f, 68772.73f, -1649.233f)),
            // Oyster Garden: Beds Available
            Tuple.Create(true, "Lost Souls Locker", new Vector3f(-26525.89f, 140491f, 1397.072f)),
            Tuple.Create(true, "Lost Souls Locker - Right Crypt Enter", new Vector3f(133305.3f, -23020.03f, 212.8431f)),
            Tuple.Create(true, "Lost Souls Locker - Right Crypt Exit", new Vector3f(-39478.11f, 145881.1f, 3482.234f)),
            Tuple.Create(true, "Lost Souls Locker - Left Crypt Enter", new Vector3f(130968.3f, -9532.125f, 212.8431f)),
            Tuple.Create(true, "Lost Souls Locker - Left Crypt Exit", new Vector3f(-36788.85f, 145708.7f, 3348.289f)),
            Tuple.Create(true, "Lost Souls Locker - Center Crypt Enter", new Vector3f(130265.6f, 4958.536f, 212.8431f)),
            Tuple.Create(true, "Lost Souls Locker - Center Crypt Exit", new Vector3f(-38142.93f, 147456.1f, 3591.008f)),
            Tuple.Create(true, "Barrelbottom Revisited", new Vector3f(-17798.04f, 124051.6f, 9650.9f))
        }},
        {"Chapter3_L1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Threadneedle Street", new Vector3f(43539.08f, -83053.16f, 116981f)),
            Tuple.Create(true, "Vale of Doom", new Vector3f(27577.55f, -51703.76f, 117670f))
        }},
        {"Chapter3_W1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Scorched Earth", new Vector3f(123519.5f, -129330f, -2593.363f)),
            Tuple.Create(true, "Scroll of Happy Times", new Vector3f(-145791f, -234140.3f, 66619.65f)),
            Tuple.Create(true, "Scroll of Happy Times - Exit", new Vector3f(149132.6f, 43427.4f, 1586f)),
            Tuple.Create(true, "Monastery Shelf Valley", new Vector3f(110298.2f, -11904.4f, 18635.73f)),
            Tuple.Create(true, "Monastery Shelf Valley - Liddell Memory", new Vector3f(125638.3f, 34162.68f, 3840.933f)),
            Tuple.Create(true, "Monastery Shelf Valley - Glide", new Vector3f(97189.2f, 13658.15f, 17789.49f))
        }},
        {"Chapter3_W2_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Trunk", new Vector3f(-125666.7f, 132800.7f, -19598.68f)),
            Tuple.Create(true, "Trunk - Top", new Vector3f(-89304.86f, 81629.91f, 17964f)),
            Tuple.Create(true, "Scroll of Dark Skies", new Vector3f(-145758.4f, -152724.4f, 71758.59f))
        }},
        {"Chapter3_W3_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Weast Peak Prison Village", new Vector3f(40203.8f, 90877.68f, -1823.834f)),
            // Hellish Hive
            Tuple.Create(true, "Scroll of Destiny", new Vector3f(-145921.1f, -127118.9f, 73550.69f)),
            Tuple.Create(true, "Peak Temple", new Vector3f(159108.5f, 148457.3f, 4154.166f))
        }},
        {"Chapter4_L1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Bow-Sreet Lock-Up", new Vector3f(167.2345f, -992.4897f, 66f)),
            Tuple.Create(true, "Cardbridge", new Vector3f(-650.9072f, 19647.46f, -5311f)),
            Tuple.Create(true, "Cardbridge - Castle", new Vector3f(-20286.55f, 24449.96f, -32483.68f))
        }},
        {"Chapter4_W1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Least Wing", new Vector3f(79378.91f, -138761.1f, 14468.42f))
        }},
        {"Chapter4_W2_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Waste Wing Part 1", new Vector3f(-34548.13f, -68170.58f, -8198.999f)),
            Tuple.Create(true, "Waste Wing Part 1 - Executioner Fight", new Vector3f(36224.66f, -188833.4f, -6525.948f)),
            Tuple.Create(true, "Waste Wing Part 2", new Vector3f(-7103.991f, -64807.59f, -7637.99f))
        }},
        {"Chapter4_W3_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Labyrinthine Revenge", new Vector3f(-18145.9f, -58544.73f, -9087.999f)),
            Tuple.Create(true, "Harder they Fall", new Vector3f(31655.56f, -59703.04f, -25550.9f)),
            Tuple.Create(true, "Dark of Heartness", new Vector3f(34071.25f, 74200.09f, 20029f))
        }},
        {"Chapter5_L1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Rutledge Asylum", new Vector3f(-3229.494f, 115408.6f, 2512f)),
            Tuple.Create(true, "Hide Park", new Vector3f(26139.15f, 109511.4f, 2078.361f))
        }},
        {"Chapter5_W1_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Fort Resistance", new Vector3f(41046.14f, 73661.92f, -1475.516f)),
            // Frogs Way
            Tuple.Create(true, "Off With Her Head Part 1", new Vector3f(-79139.47f, -122175.3f, -4831.008f)),
            Tuple.Create(true, "Off With Her Head Part 1 - Load 1", new Vector3f(-79068.68f, -77419.27f, -15110.98f)),
            Tuple.Create(true, "Off With Her Head Part 1 - Load 2", new Vector3f(-71795.53f, -13694.27f, -8575.012f)),
            Tuple.Create(true, "Dolltown Cellars", new Vector3f(74062.09f, 99204.59f, 6709.85f)),
            Tuple.Create(true, "Dolltown Cellars - Slide", new Vector3f(46611.77f, 165909.6f, -1498.751f))
            // Dollgirl's Pursuit
        }},
        {"Chapter5_W2_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Fort Resistance Delivered", new Vector3f(-878.5466f, 55078.02f, -4566f))
        }},
        {"Chapter5_W3_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Looking Glass Railway Station", new Vector3f(51230.15f, 128246.5f, 7750.255f)),
            Tuple.Create(true, "Off With Her Head Part 2", new Vector3f(15677.7f, -11832.72f, -1563.315f)),
            Tuple.Create(true, "Off With Her Head Part 2 - Load 1", new Vector3f(35640.95f, 223.0195f, -6834.925f)),
            Tuple.Create(true, "Off With Her Head Part 2 - Load 2", new Vector3f(32916.75f, -34233.54f, -339.5117f)),
            Tuple.Create(true, "Off With Her Head Part 2 - Exit", new Vector3f(5366.389f, 110441.4f, -5174.123f)),
            Tuple.Create(true, "Dollmaker's Workshop", new Vector3f(134648.6f, -113977.7f, 34311.09f)),
            Tuple.Create(true, "Dollmaker's Workshop - Inside", new Vector3f(181540.7f, -62085.9f, 33564.5f))
        }},
        {"Chapter6_P", new List<Tuple<bool, string, Vector3f>>() {
            Tuple.Create(true, "Whitechapel", new Vector3f(208150.6f, 177302.8f, 210723f)),
            Tuple.Create(true, "Infernal Train Carriage", new Vector3f(-152821.8f, -180446.2f, -22136.82f)),
            // Dollmaker Part 1
            Tuple.Create(true, "Dollmaker Part 2", new Vector3f(58855.39f, 79584.75f, -22376.82f)),
            Tuple.Create(true, "The End", new Vector3f(230808f, 450.4799f, 86617.7f))
        }}
    };

    foreach(KeyValuePair<string, List<Tuple<bool, string, Vector3f>>> kvp in vars.splitPos) {
        string chapterName = kvp.Key.Substring(0, 8);
        foreach(Tuple<bool, string, Vector3f> tup in kvp.Value)
            settings.Add(tup.Item2, false, tup.Item2, chapterName);
    }

    settings.Add("End", true, "End", "Chapter6");

    vars.splits = new HashSet<string>();

    vars.ResetVars = (EventHandler)((s, e) => {
        vars.splits = new HashSet<string>();
    });
    timer.OnStart += vars.ResetVars;

    refreshRate = 100/3d;
}

init {
    vars.watchers = new MemoryWatcherList() {
        (vars.isLoading = new MemoryWatcher<bool>(new DeepPointer(0x01107798))),
        (vars.level = new StringWatcher(new DeepPointer(0x01105024, 0x504, 0x0), 32)),
        (vars.player = new MemoryWatcher<int>(new DeepPointer(0x01105024, 0x47C, 0x0, 0x40, 0x22C)))
    };
}

update {
    vars.watchers.UpdateAll(game);
}

start {
    return (!String.IsNullOrEmpty(vars.level.Current) && !vars.level.Current.Equals(vars.level.Old))
           && (String.IsNullOrEmpty(vars.level.Old) || "AliceEntry".Equals(vars.level.Old))
           && ("Chapter1_L1_P".Equals(vars.level.Current) || (settings["C_Start"] && (vars.level.Current[9] == 'L' || vars.level.Current[9] == 'P')));
}

split {
    byte[] bytesPos = game.ReadBytes((IntPtr)vars.player.Current+0x64, 0xC);
    if(bytesPos == null)
        return false;

    float x = BitConverter.ToSingle(bytesPos, 0x0);
    float y = BitConverter.ToSingle(bytesPos, 0x4);
    float z = BitConverter.ToSingle(bytesPos, 0x8);

    List<Tuple<bool, string, Vector3f>> loadList;
    if(vars.splitPos.TryGetValue(vars.level.Current, out loadList)) {
        bool isStartLoading = !vars.isLoading.Old && vars.isLoading.Current;
        foreach(Tuple<bool, string, Vector3f> tup in loadList) {
            if(!isStartLoading && tup.Item1) continue;
            Vector3f vec = tup.Item3;
            if(Math.Abs(vec.X-x) <= 1f && Math.Abs(vec.Y-y) <= 1f && Math.Abs(vec.Z-z) <= 1f)
                return vars.splits.Add(tup.Item2) && settings[tup.Item2];
        }
    }

    if(vars.level.Current.EndsWith("6_P", StringComparison.Ordinal) && Math.Abs(148884.8f-z) <= 1f) {
        float dX = x - 120496.19f;
        float dY = y - 200676.96f;
        if (dX*dX + dY*dY <= 513458.2336f) 
            return settings["End"];
    }
}

reset {
    return !"AliceEntry".Equals(vars.level.Old) && "AliceEntry".Equals(vars.level.Current);
}

isLoading {
    return vars.isLoading.Current;
}

shutdown {
    timer.OnStart -= vars.ResetVars;
}