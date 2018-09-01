state ("TheMessenger") {
	string16 currentSceneName : "mono.dll", 0x00299AE8, 0x20, 0x648, 0x8, 0xE8, 0x14;
	bool arcaneGolemDead : "mono.dll", 0x002685E0, 0xA0, 0x610, 0x8, 0x58, 0x10, 0xD8, 0x20, 0x12C;
}

startup {
    settings.Add("01", true, "Ninja Village");
    settings.Add("02", true, "Autumn Hills");
    settings.Add("03", true, "Forlorn Temple");
    settings.Add("04", true, "Catacombs");
    settings.Add("06", true, "Bamboo Creek");
    settings.Add("05", true, "Howling Grotto");
    settings.Add("07", true, "Quillshroom Marsh");
    settings.Add("08", true, "Searing Crags");
    settings.Add("09", true, "Glacial Peak");

    settings.CurrentDefaultParent = "01";
	    settings.Add("Level_01", true, "Level");

	settings.CurrentDefaultParent = "02";
	    settings.Add("Level_02", true, "Level");

	settings.CurrentDefaultParent = "03";
	    settings.Add("Level_03", true, "Level");

	settings.CurrentDefaultParent = "04";
	    settings.Add("Level_04", true, "Level");

	settings.CurrentDefaultParent = "06";
	    settings.Add("Level_06", true, "Level");

	settings.CurrentDefaultParent = "05";
	    settings.Add("Level_05", true, "Level");

	settings.CurrentDefaultParent = "07";
	    settings.Add("Level_07", true, "Level");
    
    settings.CurrentDefaultParent = "08";
	    settings.Add("Level_08", true, "Level");

	settings.CurrentDefaultParent = "09";
	    settings.Add("Level_09", true, "Level");
}

start {
	return old.currentSceneName == "" && current.currentSceneName == "Level_01";
}

split {
	if((old.currentSceneName != current.currentSceneName) && (old.currentSceneName.StartsWith("Level") && current.currentSceneName.StartsWith("Level"))) {
		return settings[old.currentSceneName];
	}

	//End 8bit
	if(current.currentSceneName == "Level_10" && !old.arcaneGolemDead && current.arcaneGolemDead) return true;
}

reset {
	return current.currentSceneName == "";
}