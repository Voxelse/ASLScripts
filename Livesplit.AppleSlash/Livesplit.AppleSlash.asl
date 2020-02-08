state("Apple Slash") {}

startup {
    settings.Add("gaate_2", false, "Gate Open");

    settings.Add("pad_L_2", false, "Pad Left");
    settings.Add("pad_R_2", false, "Pad Right");

    settings.Add("chyst-eye1_2", false, "Chyst Eye Left");
    settings.Add("chyst-eye2_2", false, "Chyst Eye Right");

    settings.Add("blob-awake_1", false, "Blob Awake");
    settings.Add("blob-dead_1", false, "Blob Dead");
    settings.Add("cap_2", false, "Cap Catch");

    settings.Add("skill-boomer_1", false, "Swordorang");
    settings.Add("skill-bridge_1", false, "Bridge Caller");
    settings.Add("skill-bigsword_1", false, "Master Smash");
    settings.Add("skill-slash_1", false, "Sword Slash");
    settings.Add("skill-throw_1", false, "Charging Blades");
    
    settings.Add("key1_2", false, "Key Bridge");
    settings.Add("key2_2", false, "Key Thorns");
    settings.Add("key3_2", false, "Key Prof");
    settings.Add("key4_2", false, "Key Start");

    settings.Add("secret-gate_1", false, "Secret Gate");

    settings.Add("", false, "End split (not implemented yet)");

    vars.ResetVars = (EventHandler)((s, e) => {
        vars.regKeyDict = new Dictionary<string, int>();
    });
    timer.OnStart += vars.ResetVars;

    vars.regKeyDict = new Dictionary<string, int>();
}

update {
    vars.needStart = false;
    vars.needSplit = false;

    using(Microsoft.Win32.RegistryKey regKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey(@"Software\Agelvik\Apple Slash")) {
        foreach (string name in regKey.GetValueNames()) {
            if(char.ToUpperInvariant(name[0]) == 'M' || char.ToUpperInvariant(name[0]) == 'R' ||
                char.ToUpperInvariant(name[0]) == 'S' || char.ToUpperInvariant(name[0]) == 'U') continue;

            int value = 0;
            switch (regKey.GetValueKind(name)) {
                case Microsoft.Win32.RegistryValueKind.Binary:
                    value = ((byte[]) regKey.GetValue(name))[0]-0x30;
                    break;
                default:
                    try {
                        value = Convert.ToInt32(regKey.GetValue(name));
                    } catch (System.Exception) {
                        continue;
                    }
                    break;
            }

            if(!vars.regKeyDict.ContainsKey(name)) {
                vars.regKeyDict.Add(name, value);
            } else if(vars.regKeyDict[name] != value) {
                int slashId = name.IndexOf('/')+1;
                string cleanName = name.Substring(slashId, name.LastIndexOf('_')-slashId);
                if(cleanName.Equals("prologue") && vars.regKeyDict[name] == 0 && value == 1) {
                    vars.needStart = true;
                }
                if(settings.ContainsKey(cleanName+"_"+value) && settings[cleanName+"_"+value]) {
                    vars.needSplit = true;
                }
                vars.regKeyDict[name] = value;
            }
        }
    }
}

start {
    return vars.needStart;
}

split {
    return vars.needSplit;
}

shutdown {
    timer.OnStart -= vars.ResetVars;
}