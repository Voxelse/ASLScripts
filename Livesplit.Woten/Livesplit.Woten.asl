state ("Woten___Resubmission_Build___v10") {
    int mapcode : 0x00E6A060;
    int dialog : 0x00E5A420, 0x60, 0x10, 0x58, 0xE4;
}

startup {
    settings.Add("aedling", true, "Aedling");
    settings.SetToolTip("aedling", "Split when speaking to Aedling");
    settings.Add("maps", false, "Maps");
    settings.SetToolTip("maps", "Split on maps transition");

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
    settings.Add("map10", true, "0-0 Start");
    settings.Add("map11", false,"0-1 Crow");
    settings.Add("map12", true, "0-2 First Apples");
    settings.Add("map13", false,"0-3 Aedling");
    
    settings.CurrentDefaultParent = "world1";
    settings.Add("map14", true, "1-0 Hanging Tree - Apricot");
    settings.Add("map15", true, "1-1 Hanging Tree - Leap");
    settings.Add("map16", true, "1-2 Item - Soldier Face");
    settings.Add("map17", false,"1-3 Crow");
    settings.Add("map18", true, "1-4 First Blobs");
    settings.Add("map19", true, "1-5 Item - Compact Disk");
    settings.Add("map20", true, "1-6 Spiky Blob");
    settings.Add("map21", false,"1-7 Aedling");
    
    settings.CurrentDefaultParent = "world2";
    settings.Add("map22", false,"2-0 Crow");
    settings.Add("map23", true, "2-1 Escalator Blobs");
    settings.Add("map24", true, "2-2 Big Roof Blob");
    settings.Add("map25", true, "2-3 Crystals Teleport");
    settings.Add("map26", true, "2-4 Cave Blobs");
    settings.Add("map27", true, "2-5 Item - ");
    settings.Add("map28", false,"2-6 Fall");
    settings.Add("map29", true, "2-7 First Skulltulas");
    settings.Add("map30", false,"2-8 Adeling");
    
    settings.CurrentDefaultParent = "world3";
    settings.Add("map33", false,"3-0 Crow");
    settings.Add("map34", true, "3-1 Item - Horny Head");
    settings.Add("map35", true, "3-2 Two Blobs");
    settings.Add("map36", true, "3-3 Big Blobs");
    settings.Add("map37", true, "3-4 First Bees");
    settings.Add("map38", false,"3-5 Aedling");
    
    settings.CurrentDefaultParent = "world4";
    settings.Add("map41", false,"4-0 Crow");
    settings.Add("map42", true, "4-1 Javelin Chains");
    settings.Add("map43", true, "4-2 Item - Audiotape");
    settings.Add("map44", true, "4-3 First Clouds");
    settings.Add("map45", true, "4-4 Cloud for Bees");
    settings.Add("map46", true, "4-5 Cloud Leap");
    settings.Add("map47", true, "4-6 Flower Guy Delivery");
    settings.Add("map48", false,"4-7 Aedling");
    
    settings.CurrentDefaultParent = "world5";
    settings.Add("map51", false,"5-0 Crow");
    settings.Add("map52", true, "5-1 Overhang tree");
    settings.Add("map53", false,"5-2 Straight");
    settings.Add("map54", true, "5-3 First Lightning Clouds");
    settings.Add("map55", true, "5-4 Clouds Jumps");
    settings.Add("map56", true, "5-5 Triggers & Chain");
    settings.Add("map57", true, "5-6 Two Clouds for Crystals");
    settings.Add("map58", true, "5-7 One Cloud Crystals");
    settings.Add("map59", true, "5-8 Two Clouds for Blob");
    settings.Add("map60", true, "5-9 First Salamanders");
    settings.Add("map61", true, "5-10 Salamander and Lightning");
    settings.Add("map63", true, "5-11 Bear");
    settings.Add("map64", false,"5-12 Straight");
    settings.Add("map65", false,"5-13 Fall");
}

init {
    // Store the higher visited level to avoid multiple splits by going back and forth
    vars.higherVisitedLevel = 10;
}

start {
    if(current.mapcode == 10) {
        vars.higherVisitedLevel = 10;
        return true;
    }
}

split {
    if(vars.higherVisitedLevel < current.mapcode) {
        vars.higherVisitedLevel = current.mapcode;
        return settings.ContainsKey("map"+old.mapcode) && settings["map"+old.mapcode];
    }

    if(old.dialog == 0 && current.dialog == 0x3FF00000) {
        if(current.mapcode == 66) return true; // End Split
        return settings["aed"+current.mapcode];
    }
}

reset {
    return current.mapcode == 7;
}