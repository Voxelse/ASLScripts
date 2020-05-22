// Script made by faultyserver, badBlackShark and Voxelse

state("ActionHenk") {}

startup {
    // Array of number of medals required to unlock each new batch of levels
    vars.anyMedalsUnlock = new int[] {7, 16, 27, 38, 43, 57, 72, 85};

    settings.Add("category_any", true, "Any% Splitting");
    for (int i = 0; i < vars.anyMedalsUnlock.Length; i++)
        settings.Add("any_"+vars.anyMedalsUnlock[i], true, "Split when unlocking "+vars.anyMedalsUnlock[i]+" medals", "category_any");
    settings.Add("any_the_wall", true, "Split when beating \"The Wall\"", "category_any");
    settings.Add("any_pinball", true, "Split when beating \"Pinball\"", "category_any");
    settings.Add("any_kentinator", true, "Split when beating \"Kentinator's Challenge\"", "category_any");
    settings.Add("any_credits", true, "Split when beating \"Credits\"", "category_any");

    settings.Add("category_all_levels", false, "All Levels Splitting");
    settings.Add("all_levels_batch", true, "Split at each batch cleared", "category_all_levels");
    settings.Add("all_levels_track", false, "Split at every track cleared", "category_all_levels");
    
    settings.Add("category_all_rainbows", false, "All Rainbows Splitting");
    settings.Add("all_rainbows_batch", true, "Split at each batch rainbowed", "category_all_rainbows");
    settings.Add("all_rainbows_track", false, "Split at every track rainbowed (or completed for specials)", "category_all_rainbows");
    
    settings.Add("category_hundo", false, "100% Splitting");
    settings.Add("hundo_batch", true, "Split at each batch fully completed", "category_hundo");
    settings.Add("hundo_track", false, "Split at every track rainbowed (or completed for specials)", "category_hundo");

    settings.Add("category_45classics", false, "45 Classics Splitting");
    settings.Add("45classics_batch", true, "Split at each last classic track of each batch", "category_45classics");
    settings.Add("45classics_track", false, "Split at every track done", "category_45classics");
    
    settings.Add("reset_tracking", false, "Reset Tracking");
    settings.SetToolTip("reset_tracking", "Tracks the amount of times you reset during a run. Only works on retry, not checkpoint restart");

    settings.Add("medal_tracking", false, "Medal Tracking");
    settings.SetToolTip("medal_tracking", "Tracks the amount of medals (Sp->Special, B->Bronze, S->Silver, G->Gold, R->Rainbow)");

    // Array of ids of the last classics levels of batches 
    vars.classicBatchEnd = new int[] {14, 7, 50, 23, 47, 66, 26, 76, 31};

    // Id of levels sorted by batches
    vars.levelsCode = new int[][] {
        new int[] {13, 34, 03, 02, 14, 17, 54},
        new int[] {04, 16, 32, 27, 07, 52, 55},
        new int[] {18, 20, 30, 35, 50, 51, 42},
        new int[] {48, 15, 08, 24, 23, 53, 56},
        new int[] {43, 44, 45, 46, 47, 39, 57},
        new int[] {64, 36, 28, 65, 66, 68, 67},
        new int[] {69, 70, 29, 71, 26, 73, 72},
        new int[] {74, 10, 25, 75, 76, 78, 77},
        new int[] {79, 21, 19, 80, 31, 82, 81},
        new int[] {83, 84, 85, 86, 87, 89, 88},
        new int[] {98, 99,100,101,102,104,103}
    };

    // Can't use enum so put GUIScreens in vars instead
    vars.GUIScreen_MainMenu    =  1;
    vars.GUIScreen_Loading     =  5;
    vars.GUIScreen_PreGame     =  8;
    vars.GUIScreen_InGame      =  9;
    vars.GUIScreen_PostGame    = 10;
    vars.GUIScreen_Cutscene    = 11; // Actually GUIScreen_None
    vars.GUIScreen_BatchSelect = 37;

    // Reset tracker variables
    vars.textSettingReset = null;
    vars.totalResets = 0;

    // Medal tracker variables
    vars.textSettingMedal = null;
    vars.medalsTypeCount = new int[5];
    vars.medalsTypeName = new string[5] {"Sp", "B", "S", "G", "R"};

    // Update function of the reset tracker
    vars.UpdateResetTracker = (Action)(() => {
        if(vars.textSettingReset == null)
            vars.textSettingReset = vars.SearchOrCreateComponent("Resets This Run:");

        vars.textSettingReset.Text2 = vars.totalResets.ToString();
    });

    // Update function of the medal tracker
    vars.UpdateMedalTracker = (Action)(() => {
        if(vars.textSettingMedal == null)
            vars.textSettingMedal = vars.SearchOrCreateComponent("Medals Count:");

        string medalText = "";
        for (int medalTypeId = 0; medalTypeId < vars.medalsTypeCount.Length; medalTypeId++) {
            if(vars.medalsTypeCount[medalTypeId] == 0) continue;
            medalText = string.Concat(medalText, vars.medalsTypeName[medalTypeId], ": ", vars.medalsTypeCount[medalTypeId], " ");
        }
        vars.textSettingMedal.Text2 = (medalText == "" ? "No medals yet" : medalText);
    });

    // Search a text component with a specified name. Create it if not found.
    vars.SearchOrCreateComponent = (Func<string, dynamic>)((name) => {
        dynamic textSetting = null;
        foreach (dynamic component in timer.Layout.Components) {
            if (component.GetType().Name == "TextComponent" && component.Settings.Text1 == name) {
                textSetting = component.Settings;
                break;
            }
        }

        if(textSetting == null)
            textSetting = vars.CreateTextComponent(name);

        return textSetting;
    });

    // Component creation function
    vars.CreateTextComponent = (Func<string, dynamic>)((name) => {
        var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
        dynamic textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
        timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));
        textComponent.Settings.Text1 = name;
        return textComponent.Settings;
    });

    vars.InitVars = (Action)(() => {
        // Number of medals sorted by batches
        vars.levelsMedals = Enumerable.Range(0, 11).Select(i => new int[7]).ToArray();

        // Number of medals the player has earned
        vars.curSumMedals = vars.oldSumMedals = 0;
        // Number of batches the player has completed (counts if all normal levels are completed with at least bronze)
        vars.curFullBatches = vars.oldFullBatches = 0;
        // Number of perfect batches the player has completed (counts if all normal levels are completed with rainbow)
        vars.curRainbowBatches = vars.oldRainbowBatches = 0;
        // Number of batches the player has fully completed (counts if all normal levels are completed with rainbow, and the challenge/bonus levels are beaten)
        vars.curCompletedBatches = vars.oldCompletedBatches = 0;
    });

    vars.InitVars();

    // Function called when the timer start to reset local variables
    vars.ResetVars = (EventHandler)((s, e) => {
        vars.InitVars();
        
        if(settings["medal_tracking"]) {
            vars.medalsTypeCount = new int[5];
            vars.UpdateMedalTracker();
        }
        if(settings["reset_tracking"]) {
            vars.totalResets = 0;
            vars.UpdateResetTracker();
        }
    });
    timer.OnStart += vars.ResetVars;

    // Function called when the timer reset to reset tracking display
    vars.ResetDisplay = (LiveSplit.Model.Input.EventHandlerT<TimerPhase>)((s, e) => {
        if(vars.textSettingReset != null) vars.textSettingReset.Text2 = "0";
        if(vars.textSettingMedal != null) vars.textSettingMedal.Text2 = "No medals yet";
    });
    timer.OnReset += vars.ResetDisplay;

    // Return if the current level is completed with at least bronze medal(param false) or with rainbow medal(param true)
    vars.IsCurrentLevelCompleted = (Func<bool, bool>)((isRainbow) => {
        if(vars.oldSumMedals == vars.curSumMedals) return false;
        int levelId = Array.IndexOf(vars.levelsCode[vars.lookingAtBatchNum.Current], vars.levelCode.Current);
        return vars.levelsMedals[vars.lookingAtBatchNum.Current][levelId] > (isRainbow ? (levelId < 5 ? 3 : 0) : 0);
    });
}

init {
    // Create a separate thread to scan the game's memory
    vars.threadScan = new Thread(() => {
        // AOB signature for ActionHenk:Start
        var scanActionHenkStart = new SigScanTarget(0, "55 8B EC 53 57 56 83 EC 1C 8B 7D 08 8B 47 20");
        // AOB signature for State_InGame:FixedUpdate
        var scanStateInGameFixedUpdate = new SigScanTarget(0, "55 8B EC 53 57 56 83 EC 1C C7 45 DC 00 00 00 00");

        IntPtr ptrActionHenkStart = IntPtr.Zero;
        IntPtr ptrStateInGameFixedUpdate = IntPtr.Zero;
        while(ptrActionHenkStart == IntPtr.Zero || ptrStateInGameFixedUpdate == IntPtr.Zero) {
            print("[Autosplitter] Scanning memory");
            foreach (var page in game.MemoryPages()) {
                var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);

                if(ptrActionHenkStart == IntPtr.Zero && (ptrActionHenkStart = scanner.Scan(scanActionHenkStart)) != IntPtr.Zero)
                    print("[Autosplitter] ActionHenk:Start Found : " + ptrActionHenkStart.ToString("X"));

                if(ptrStateInGameFixedUpdate == IntPtr.Zero && (ptrStateInGameFixedUpdate = scanner.Scan(scanStateInGameFixedUpdate)) != IntPtr.Zero)
                    print("[Autosplitter] State_InGame:FixedUpdate Found : " + ptrStateInGameFixedUpdate.ToString("X"));

                if(ptrActionHenkStart != IntPtr.Zero && ptrStateInGameFixedUpdate != IntPtr.Zero)
                    break;
            }
            if (ptrActionHenkStart != IntPtr.Zero && ptrStateInGameFixedUpdate != IntPtr.Zero) {
                int relPtrActionHenk = (int)((long)ptrActionHenkStart - (long)modules.First().BaseAddress);
                int relPtrStateInGame = (int)((long)ptrStateInGameFixedUpdate - (long)modules.First().BaseAddress);

                // Global variable watchers
                vars.globalWatchers = new MemoryWatcherList() {
                    // LevelBatchManager
                    // Number of medal earned in the current level
                    (vars.bestMedal =         new MemoryWatcher<int>(new DeepPointer((int)relPtrActionHenk+0x472, 0x24, 0x4, 0x0, 0x2C, 0x34))),
                    // Id/code of the current level
                    (vars.levelCode =         new MemoryWatcher<int>(new DeepPointer((int)relPtrActionHenk+0x472, 0x24, 0x4, 0x0, 0x2C, 0x74))),
                    // Total number of medals while in the main menu. Otherwise total number of rainbow medals
                    (vars.numMedals =         new MemoryWatcher<int>(new DeepPointer((int)relPtrActionHenk+0x472, 0x24, 0x4, 0x0, 0x38))),
                    // Id of the current batch
                    (vars.lookingAtBatchNum = new MemoryWatcher<int>(new DeepPointer((int)relPtrActionHenk+0x472, 0x24, 0x4, 0x0, 0x40))),

                    // GUIManager
                    // The active GUI screen being displayed
                    (vars.activeScreen = new MemoryWatcher<int>(new DeepPointer((int)relPtrActionHenk+0x568, 0x24, 0x4, 0x0, 0x20)))
                };

                // Medal tracker related watchers. Only used if both medal tracker and 45 Classics settings are checked
                vars.medalTrackerWatchers = new MemoryWatcherList() {
                    // LevelBatchManager
                    // Pointer of currentLevel used to read track medal/bonus times with offsets
                    (vars.trackTimePtr = new MemoryWatcher<int>(new DeepPointer((int)relPtrActionHenk+0x472, 0x24, 0x4, 0x0, 0x2C))),

                    // CheckpointManager
                    // The finish time at track done
                    (vars.finishTime = new MemoryWatcher<float>(new DeepPointer((int)relPtrStateInGame+0x16D, 0x24, 0x4, 0x0, 0x24)))
                };

                // Initialization of tracking if settings are checked
                if(settings["medal_tracking"]) vars.UpdateMedalTracker();
                if(settings["reset_tracking"]) vars.UpdateResetTracker();
            } else {
                Thread.Sleep(2000);
            }
        }
        print("[Autosplitter] Done scanning");
    });
    vars.threadScan.Start();    
}

start {
    // Runs start when the player hits "Play" on the main menu and has cleared their medal data or has 45 Classics category checked
    return vars.activeScreen.Old == vars.GUIScreen_MainMenu && vars.activeScreen.Current == vars.GUIScreen_BatchSelect && (vars.numMedals.Old == 0 || settings["category_45classics"]);
}

update {
    // Don't run the rest of the script if globalWatchers isn't declared and therefore the game memory isn't yet found
    if(!((IDictionary<string, Object>)vars).ContainsKey("globalWatchers"))
        return false;

    vars.globalWatchers.UpdateAll(game);

    // Update old local variables
    vars.oldSumMedals = vars.curSumMedals;
    vars.oldFullBatches = vars.curFullBatches;
    vars.oldRainbowBatches = vars.curRainbowBatches;
    vars.oldCompletedBatches = vars.curCompletedBatches;
    
    // Update when the medal count change in the current level
    if(vars.levelCode.Old != 0 && vars.bestMedal.Old < vars.bestMedal.Current) {
        int indexOfLevel = Array.IndexOf(vars.levelsCode[vars.lookingAtBatchNum.Current], vars.levelCode.Current);
        vars.levelsMedals[vars.lookingAtBatchNum.Current][indexOfLevel] = vars.bestMedal.Current;
        vars.curSumMedals += vars.bestMedal.Current-vars.bestMedal.Old;

        // Recalculation of batches
        bool batchIsFull, batchIsRainbow, batchIsCompleted;
        vars.curFullBatches = vars.curRainbowBatches = vars.curCompletedBatches = 0;
        for (int batchId = 0; batchId < vars.levelsMedals.Length; batchId++) {
            int[] batchMedals = vars.levelsMedals[batchId];
            batchIsFull = batchIsRainbow = batchIsCompleted = true;
            for (int levelId = 0; levelId < batchMedals.Length; levelId++) {
                int numMedals = batchMedals[levelId];
                if(numMedals == 0) {
                    if(levelId < 5 || (levelId == 5 && (batchId == 4 || batchId == 8))) {
                        batchIsFull = batchIsRainbow = batchIsCompleted = false;
                        break;
                    } else {
                        batchIsFull = false;
                    }
                } else if(numMedals < 4 && levelId < 5) {
                    batchIsFull = batchIsRainbow = false;
                }
            }
            if(batchIsFull) ++vars.curFullBatches;
            if(batchIsRainbow) ++vars.curRainbowBatches;
            if(batchIsCompleted) ++vars.curCompletedBatches;
        }

        // Update medal tracking if 45 Classics is not checked
        if(settings["medal_tracking"] && !settings["category_45classics"]) {
            if(indexOfLevel > 4) {
                ++vars.medalsTypeCount[0];
            } else {
                if(vars.bestMedal.Old != 0) --vars.medalsTypeCount[vars.bestMedal.Old];
                ++vars.medalsTypeCount[vars.bestMedal.Current];
            }
            vars.UpdateMedalTracker();
        }
    }

    // Update medal tracking if 45 Classics is checked
    if(settings["medal_tracking"] && settings["category_45classics"]) {
        vars.medalTrackerWatchers.UpdateAll(game);

        // When the level is done, manually compute how much medal should be earned since medals are not reseted for 45 Classics 
        if(vars.finishTime.Changed && vars.finishTime.Current != 0) {
            int indexOfLevel = Array.IndexOf(vars.levelsCode[vars.lookingAtBatchNum.Current], vars.levelCode.Current);
            // If the level is a Challenge/Bonus, check for Bronze/Bonus time otherwise find the greatest medal earned
            if(indexOfLevel > 4) {
                if(vars.finishTime.Current < game.ReadValue<float>((IntPtr)(vars.trackTimePtr.Current+(indexOfLevel == 5 ? 0x40 : 0x50)))) {
                    ++vars.medalsTypeCount[0];
                    vars.UpdateMedalTracker();
                }
            } else {
                int medalNb = 0;
                for (int medalTimeOffset = 0; medalTimeOffset < 4; medalTimeOffset++) {
                    if(vars.finishTime.Current < game.ReadValue<float>((IntPtr)vars.trackTimePtr.Current+0x40+0x4*medalTimeOffset))
                        ++medalNb;
                    else
                        break;
                }
                if(medalNb != 0) {
                    ++vars.medalsTypeCount[medalNb];
                    vars.UpdateMedalTracker();
                }
            }
        }
    }

    // Increase reset count if track is reseted
    if(settings["reset_tracking"] && vars.activeScreen.Old == vars.GUIScreen_InGame && vars.activeScreen.Current == vars.GUIScreen_PreGame) {
        ++vars.totalResets;
        vars.UpdateResetTracker();
    }
}

split {
    if(settings["category_any"]) {
        // Check if a new batch is unlocked
        if(vars.oldSumMedals < vars.curSumMedals) {
            for (int id = 0; id < vars.anyMedalsUnlock.Length; id++) {
                if(vars.oldSumMedals < vars.anyMedalsUnlock[id] && vars.curSumMedals >= vars.anyMedalsUnlock[id])
                    return settings["any_"+vars.anyMedalsUnlock[id]];
            }
        }
        // Special split for credits when level is completed without checking for medals
        if(vars.levelCode.Current == 97 && vars.activeScreen.Old == vars.GUIScreen_InGame && vars.activeScreen.Current == vars.GUIScreen_PostGame)
            return settings["any_credits"];

        // Checks for specific levels when completed with at least bronze medal
        if(vars.IsCurrentLevelCompleted(false)) {
            if(vars.levelCode.Current == 19) return settings["any_the_wall"];
            if(vars.levelCode.Current == 31) return settings["any_pinball"];
            if(vars.levelCode.Current == 82) return settings["any_kentinator"];
        }
    } else if(settings["category_all_levels"]) {
        return (settings["all_levels_track"] && vars.IsCurrentLevelCompleted(false)) ||
               (settings["all_levels_batch"] && vars.oldCompletedBatches < vars.curCompletedBatches);
    } else if(settings["category_all_rainbows"]) {
        return (settings["all_rainbows_track"] && vars.IsCurrentLevelCompleted(true)) ||
               (settings["all_rainbows_batch"] && vars.oldRainbowBatches < vars.curRainbowBatches);
    } else if(settings["category_hundo"]) {
        return (settings["hundo_track"] && vars.IsCurrentLevelCompleted(true)) ||
               (settings["hundo_batch"] && vars.oldFullBatches < vars.curFullBatches);
    } else if(settings["category_45classics"] && vars.activeScreen.Old == vars.GUIScreen_InGame && vars.activeScreen.Current == vars.GUIScreen_PostGame) {
        return settings["45classics_track"] || (settings["45classics_batch"] && Array.IndexOf(vars.classicBatchEnd, vars.levelCode.Current) != -1);
    }
}

reset {
    // Automatically reset when going to the main menu while having no medal except if 45 Classics category is checked
    return vars.activeScreen.Changed && vars.activeScreen.Current == vars.GUIScreen_MainMenu && (vars.numMedals.Current == 0 || settings["category_45classics"]);
}

isLoading {
    // Ignore time spent loading and in cutscenes, as well as network-based latency, such as submitting scores to the Steam leaderboards when on the post game screen
    return vars.activeScreen.Current == vars.GUIScreen_Loading || vars.activeScreen.Current == vars.GUIScreen_PostGame || vars.activeScreen.Current == vars.GUIScreen_Cutscene;
}

shutdown {
    vars.threadScan.Abort();
    timer.OnStart -= vars.ResetVars;
    timer.OnReset -= vars.ResetDisplay;
}