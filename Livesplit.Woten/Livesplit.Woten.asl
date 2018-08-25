state ("Woten___Resubmission_Build___v10") {
    int mapcode : 0x00E6A060;
    int dialog : 0x00E5A420, 0x60, 0x10, 0x58, 0xE4;
    int state : 0x010A27C4, 0x8, 0xC4, 0x8, 0x8C;
}

startup {
    settings.Add("aedling", true, "Aedling");
    settings.SetToolTip("aedling", "Split when speaking to Aedling");
    settings.Add("maps", false, "Maps");
    settings.SetToolTip("maps", "Split on maps transition");
    settings.Add("statues", false, "Statues");
    settings.SetToolTip("statues", "Split when speaking to Statues");

    settings.CurrentDefaultParent = "aedling";
    settings.Add("aed13", true, "First Encounter");
    settings.Add("aed21", true, "Second Encounter");
    settings.Add("aed30", true, "Third Encounter");
    settings.Add("aed38", true, "Fourth Encounter");
    settings.Add("aed48", true, "Fifth Encounter");

    settings.CurrentDefaultParent = "maps";
    settings.Add("world0", false, "World 0");
    settings.Add("world1", false, "World 1");
    settings.Add("world2", false, "World 2");
    settings.Add("world3", false, "World 3");
    settings.Add("world4", false, "World 4");
    settings.Add("world5", false, "World 5");
    
    settings.CurrentDefaultParent = "world0";
    settings.Add("map10", false, "0-0 Start");
    settings.Add("map11", false, "0-1 Crow");
    settings.Add("map12", false, "0-2 First Apples");
    settings.Add("map13", false, "0-3 Aedling");
    
    settings.CurrentDefaultParent = "world1";
    settings.Add("map14", false, "1-0 Hanging Tree - Orange");
    settings.Add("map15", false, "1-1 Hanging Tree - Leap");
    settings.Add("map16", false, "1-2 Item - Teer Head");
    settings.Add("map17", false, "1-3 Crow");
    settings.Add("map18", false, "1-4 First Blobs");
    settings.Add("map19", false, "1-5 Item - Compact Disk");
    settings.Add("map20", false, "1-6 Spiky Blob");
    settings.Add("map21", false, "1-7 Aedling");
    
    settings.CurrentDefaultParent = "world2";
    settings.Add("map22", false, "2-0 Crow");
    settings.Add("map23", false, "2-1 Item - Friday Head");
    settings.Add("map24", false, "2-2 Big Roof Blob");
    settings.Add("map25", false, "2-3 Crystals Teleport");
    settings.Add("map26", false, "2-4 Cave Blobs");
    settings.Add("map27", false, "2-5 Item - Floppy");
    settings.Add("map28", false, "2-6 Fall");
    settings.Add("map29", false, "2-7 First Skulltulas");
    settings.Add("map30", false, "2-8 Adeling");

    settings.CurrentDefaultParent = "statues";
    settings.Add("sta32", false, "Friday Dialog");
    settings.Add("map31", false, "Friday Transition Map");
    settings.Add("map32", false, "Friday Map");
    
    settings.CurrentDefaultParent = "world3";
    settings.Add("map33", false, "3-0 Crow");
    settings.Add("map34", false, "3-1 Item - Oasis Head");
    settings.Add("map35", false, "3-2 Two Blobs");
    settings.Add("map36", false, "3-3 Big Blobs");
    settings.Add("map37", false, "3-4 First Bees");
    settings.Add("map38", false, "3-5 Aedling");

    settings.CurrentDefaultParent = "statues";
    settings.Add("sta40", false, "Teer Dialog");
    settings.Add("map39", false, "Teer Transition Map");
    settings.Add("map40", false, "Teer Map");
    
    settings.CurrentDefaultParent = "world4";
    settings.Add("map41", false, "4-0 Crow");
    settings.Add("map42", false, "4-1 Javelin Chains");
    settings.Add("map43", false, "4-2 Item - Cassette");
    settings.Add("map44", false, "4-3 First Clouds");
    settings.Add("map45", false, "4-4 Cloud for Bees");
    settings.Add("map46", false, "4-5 Cloud Leap");
    settings.Add("map47", false, "4-6 Flower Guy Delivery");
    settings.Add("map48", false, "4-7 Aedling");

    settings.CurrentDefaultParent = "statues";
    settings.Add("sta50", false, "Oasis Dialog");
    settings.Add("map49", false, "Oasis Transition Map");
    settings.Add("map50", false, "Oasis Map");
    
    settings.CurrentDefaultParent = "world5";
    settings.Add("map51", false, "5-0 Crow");
    settings.Add("map52", false, "5-1 Overhang tree");
    settings.Add("map53", false, "5-2 Straight");
    settings.Add("map54", false, "5-3 First Lightning Clouds");
    settings.Add("map55", false, "5-4 Clouds Jumps");
    settings.Add("map56", false, "5-5 Triggers & Chain");
    settings.Add("map57", false, "5-6 Two Clouds for Crystals");
    settings.Add("map58", false, "5-7 One Cloud Crystals");
    settings.Add("map59", false, "5-8 Two Clouds for Blob");
    settings.Add("map60", false, "5-9 First Salamanders");
    settings.Add("map61", false, "5-10 Salamander and Lightning");
    // Map 62 is quote stone
    settings.Add("map63", false, "5-11 Bear");
    settings.Add("map64", false, "5-12 Straight");
    settings.Add("map65", false, "5-13 Fall");
}

init {
    // Store the higher visited level to avoid multiple splits by going back and forth
    vars.higherVisitedLevel = 10;
}

start {
    if(old.mapcode != current.mapcode && current.mapcode == 10) {
        vars.higherVisitedLevel = 10;
        return true;
    }
}

split {
    // Maps splits
    if(vars.higherVisitedLevel < current.mapcode) {
        vars.higherVisitedLevel = current.mapcode;
        return settings.ContainsKey("map"+old.mapcode) && settings["map"+old.mapcode];
    }

    // End split
    if(current.mapcode == 66 && old.state != current.state && current.state == 29)
        return true;

    // Dialog splits
    if(old.dialog == 0 && current.dialog == 0x3FF00000) {
        return current.mapcode != 66 && (settings["aed"+current.mapcode] || settings["sta"+current.mapcode]);
    }
}

reset {
    return current.mapcode == 7;
}