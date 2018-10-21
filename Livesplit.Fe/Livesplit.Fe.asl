// TODO
// Add seeker episode splits by checking scene name (?GameManager, 0x40, 0x88, 0x14)
// Add crystal pick up splits by checking number of crystals held (?PickupCounter, 0x120)

state("Fe") {}

startup {
    refreshRate = 0.5;

    settings.Add("perks", true, "Perks");
    settings.SetToolTip("perks", "Split at end tutorial scenes");
    settings.Add("songs", true, "Songs");
    settings.SetToolTip("songs", "Split at end voices learning");

    settings.CurrentDefaultParent = "perks";
    settings.Add("perk1", true, "Climb");
    settings.Add("perk2", true, "Glide");
    settings.Add("perk3", false, "Sprint");
    settings.Add("perk4", false, "Dash");
    settings.Add("perk5", false, "Radar");
    settings.Add("perk6", false, "Fly");

    settings.CurrentDefaultParent = "songs";
    settings.Add("song1", true, "Bird");
    settings.Add("song2", true, "Wolf");
    settings.Add("song3", true, "Lizard");
    settings.Add("song4", true, "Jelly");
    settings.Add("song5", true, "Deer");

    // 4883C420B8????????488930B8????????48C700
    vars.scanTargetPlayer = new SigScanTarget(5,
        "48 83 C4 20",  // add rsp,20
        "B8 ????????",  // mov eax,XXXXXXXX
        "48 89 30",     // mov [rax],rsi
        "B8 ????????",  // mov eax,????????
        "48 C7 00"      // mov qword ptr [rax],00000000
    );

    vars.resetVars = (Action)(() => {
        vars.initFlag = 0;
        vars.perkNb = 0;
        vars.knownVoices = new bool[] {true, false, false, false, false, false};
        vars.isPlayerSeeker = 0;
    });

    vars.UpdatePointers = (Action<Process>)((proc) => {
        vars.playerAddr = new MemoryWatcher<IntPtr>((IntPtr)vars.playerManagerPtr);
        vars.playerAddr.Update(proc);
        if(vars.playerAddr.Current != IntPtr.Zero) {
            print("[Autosplitter] Found : Struct " + vars.playerAddr.Current.ToString("X"));

            vars.watchers = new MemoryWatcherList() {vars.playerAddr};
            // PlayerCharacter
            vars.watchers.Add(new MemoryWatcher<byte>(vars.playerAddr.Current + 0x1CA) {Name = "invisible"});
            vars.watchers.Add(new MemoryWatcher<int> (vars.playerAddr.Current + 0x878) {Name = "scrollVoiceIndex"});
            vars.watchers.Add(new MemoryWatcher<byte>(vars.playerAddr.Current + 0x885) {Name = "stunned"});
            vars.watchers.Add(new MemoryWatcher<byte>(vars.playerAddr.Current + 0xAA0) {Name = "isInPerkTutorial"});
            vars.watchers.Add(new MemoryWatcher<byte>(vars.playerAddr.Current + 0xAB3) {Name = "isActivingSeekerEye"});
            // SeekerPlayer
            vars.watchers.Add(new MemoryWatcher<byte> (vars.playerAddr.Current + 0x874) {Name = "inControlOfBody"});
        } else print("[Autosplitter] Empty Address");
    });
}

init {
    print("[Autosplitter] Scanning memory");
    IntPtr ptr = IntPtr.Zero;

    foreach (var page in game.MemoryPages()) {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        ptr = scanner.Scan(vars.scanTargetPlayer);
        if(ptr != IntPtr.Zero)
            break;
    }

    // Waiting the game to create the playerManager instructions
    if (ptr == IntPtr.Zero)
        throw new Exception("[Autosplitter] Can't find signature");

    vars.resetVars();

    vars.playerManagerPtr = game.ReadValue<int>(ptr);
    vars.UpdatePointers(game);

    refreshRate = 60;
}

update {
    vars.watchers.UpdateAll(game);

    if (vars.playerAddr.Changed || vars.playerAddr.Current == IntPtr.Zero)
        vars.UpdatePointers(game);

    // Save if is in seeker because of entity polymorphism
    if(vars.watchers["isActivingSeekerEye"].Current == 1) vars.isPlayerSeeker = 1;
}

start {
    //Need to check the second time unstunned because the game unstun/stun at first display and at actual start
    if(vars.watchers["stunned"].Changed && vars.watchers["stunned"].Current == 0) {
        if(vars.initFlag == 0) {
            vars.initFlag = 1;
        } else {
            vars.resetVars();
            return true;
        }
    }
}

split {
    if(vars.isPlayerSeeker == 0) {
        // Check if we went from a pseudo cinematic
        if(vars.watchers["invisible"].Changed && vars.watchers["invisible"].Current == 0) {
            
            // Store the number of perks because they are necessarily picked in the right order (could use unlockedPerks from player struct but unnecessarily complex)
            if (vars.watchers["isInPerkTutorial"].Current == 1)
                ++vars.perkNb;

            // Voice splits : Track if we ended a voice learning by checking if a new voice is acquired/equipped
            // Store known voices because the game only have a complex/not easily accessible struct of voices so it's easier to make a new one ourselves
            if(!vars.knownVoices[vars.watchers["scrollVoiceIndex"].Current]) {
                vars.knownVoices[vars.watchers["scrollVoiceIndex"].Current] = true;
                return settings.ContainsKey("song"+vars.watchers["scrollVoiceIndex"].Current) && settings["song"+vars.watchers["scrollVoiceIndex"].Current];
            }
        }

        // Perk splits : Track if we ended a perk tutorial
        if(vars.watchers["isInPerkTutorial"].Changed && vars.watchers["isInPerkTutorial"].Current == 0)
            return settings["perk"+vars.perkNb];
            
    } else {
        // End split : Track if we loss the control of the seeker
        if(vars.watchers["inControlOfBody"].Changed && vars.watchers["inControlOfBody"].Current == 0)
            return true;
    }
}