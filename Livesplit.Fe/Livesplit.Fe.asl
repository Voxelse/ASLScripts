state("Fe") {}

startup {
	settings.Add("perks", true, "Perks");
	settings.Add("songs", true, "Songs");

	settings.CurrentDefaultParent = "perks";
	settings.Add("climb", true, "Climb");
	settings.Add("glide", true, "Glide");
	settings.Add("sprint", false, "Sprint");
	settings.Add("dash", false, "Dash");
	settings.Add("radar", false, "Radar");
	settings.Add("fly", false, "Fly");

	settings.CurrentDefaultParent = "songs";
	settings.Add("bird", true, "Bird");
	settings.Add("deer", true, "Deer");
	settings.Add("lizard", true, "Lizard");
	settings.Add("wolf", true, "Wolf");
	settings.Add("jelly", true, "Jelly");

	vars.stopwatch = new Stopwatch();

	// 41FFD34883C420B8????????488930B8????????48C70000000000
	vars.scanTargetPlayerCharacter = new SigScanTarget(8,
		"41 FF D3",				// call r11
		"48 83 C4 20",				// add rsp, 20
		"B8 ????????",				// move eax, XXXXXXXX
		"48 89 30",				// mov [rax], rsi
		"B8 ????????",				// mov eax , XXXXXXXX
		"48 C7 00 00000000"			// mov qword ptr [rax], 00000000
	);

	vars.PageScan = (Func<Process, SigScanTarget, IntPtr>)((proc, target) => {
		var ptr = IntPtr.Zero;

		foreach (var page in proc.MemoryPages()) {
			var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
			if ((ptr = scanner.Scan(target)) != IntPtr.Zero) break;
		}
		return ptr;
	});

	vars.ScanPlayerPtr = (Action<Process>)((proc) => {
		//print("[Autosplitter] Scanning memory");
		if(vars.playerManagerInstructionPtr == IntPtr.Zero)
			vars.playerManagerInstructionPtr = vars.PageScan(proc, vars.scanTargetPlayerCharacter);
		
		vars.playerManagerAddressPtr = proc.ReadValue<int>((IntPtr)vars.playerManagerInstructionPtr);
		vars.playerAddr = new MemoryWatcher<IntPtr>((IntPtr)vars.playerManagerAddressPtr);
		vars.playerAddr.Update(proc);
		if(vars.playerAddr.Current != IntPtr.Zero) {
			//print("[Autosplitter] Found : " + vars.playerManagerInstructionPtr.ToString("X") + ", " + vars.playerManagerAddressPtr.ToString("X") + ", " + vars.playerAddr.Current.ToString("X"));

			// PlayerCharacter
			vars.invisible 			= new MemoryWatcher<byte>	(vars.playerAddr.Current + 0x1CA);
			vars.scrollVoiceIndex 		= new MemoryWatcher<int>	(vars.playerAddr.Current + 0x878);
			vars.stunned 			= new MemoryWatcher<byte>	(vars.playerAddr.Current + 0x885);
			vars.isInPerkTutorial 		= new MemoryWatcher<byte>	(vars.playerAddr.Current + 0xAA0);
			vars.isActivingSeekerEye 	= new MemoryWatcher<byte>	(vars.playerAddr.Current + 0xAB3);
			
			// SeekerPlayer
			vars.inControlOfBody		= new MemoryWatcher<byte>	(vars.playerAddr.Current + 0x874);

			vars.watchers = new MemoryWatcherList() {
				vars.playerAddr,
				vars.invisible,
				vars.scrollVoiceIndex,
				vars.stunned,
				vars.isInPerkTutorial,
				vars.isActivingSeekerEye,
				vars.inControlOfBody,
			};
		}// else print("[Autosplitter] Empty Address");
	});
}

init {
	Action resetVars = () => {
		vars.perkNb = 1;
		vars.initFlag = 0;
		vars.isPlayerSeeker = 0;
	};
	vars.resetVars = resetVars;
	vars.resetVars();

	vars.playerManagerInstructionPtr = IntPtr.Zero;

	vars.playerAddr 		= new MemoryWatcher<int>  (IntPtr.Zero);
	vars.invisible 			= new MemoryWatcher<byte> (IntPtr.Zero);
	vars.inControlOfBody 		= new MemoryWatcher<byte> (IntPtr.Zero);
	vars.scrollVoiceIndex 		= new MemoryWatcher<int>  (IntPtr.Zero);
	vars.stunned 			= new MemoryWatcher<byte> (IntPtr.Zero);
	vars.isInPerkTutorial 		= new MemoryWatcher<byte> (IntPtr.Zero);
	vars.isActivingSeekerEye 	= new MemoryWatcher<byte> (IntPtr.Zero);

	vars.watchers = new MemoryWatcherList();

	vars.stopwatch.Restart();
}

update {
	vars.watchers.UpdateAll(game);

	if (vars.stopwatch.ElapsedMilliseconds > 3000 && (vars.playerManagerInstructionPtr == IntPtr.Zero || vars.playerAddr.Current == IntPtr.Zero)) {
		vars.ScanPlayerPtr(game);
		vars.stopwatch.Restart();
	} else if (vars.stopwatch.ElapsedMilliseconds > 3000) {
		//print("Inv " + vars.invisible.Current+", Voice "+vars.scrollVoiceIndex.Current+", Stunned "+vars.stunned.Current+", Perk "+vars.isInPerkTutorial.Current+", IsSeek "+vars.isActivingSeekerEye.Current+", CtrlBody "+vars.inControlOfBody.Current + ", InSeek " + vars.isPlayerSeeker);
		vars.stopwatch.Restart();
	}

	if (vars.playerAddr.Changed)
		vars.ScanPlayerPtr(game);

	if(vars.isActivingSeekerEye.Current == 1) vars.isPlayerSeeker = 1;
}

start {
	//Need to check the second time unstunned because the game unstun/stun at the beggining and where we want to split
	if(vars.stunned.Changed && vars.stunned.Current == 0) {
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
		if(vars.invisible.Changed && vars.invisible.Current == 0) {
			
			// Perk splits
			// Track if we went from a perk tutorial
			// Store the number of perks because they are necessarily picked in the right order (could use unlockedPerks from player struct but unnecessarily complex)
			if (vars.isInPerkTutorial.Current == 1 && ( (vars.perkNb == 1 && settings["climb"]) ||
									(vars.perkNb == 2 && settings["glide"]) ||
									(vars.perkNb == 3 && settings["sprint"]) ||
									(vars.perkNb == 4 && settings["dash"]) ||
									(vars.perkNb == 5 && settings["radar"]) ||
									(vars.perkNb == 6 && settings["fly"]) ) ) {
				++vars.perkNb;
				return true;
			}

			// Voice splits
			// Track if we went from a "cinematic" and if a new voice is acquired/equipped
			if( (vars.scrollVoiceIndex.Current == 1 && settings["bird"]) ||
				(vars.scrollVoiceIndex.Current == 2 && settings["wolf"]) ||
				(vars.scrollVoiceIndex.Current == 3 && settings["lizard"]) ||
				(vars.scrollVoiceIndex.Current == 4 && settings["jelly"]) ||
				(vars.scrollVoiceIndex.Current == 5 && settings["deer"]) ) {
				return true;
			}
		}
	} else {
		// End split
		// Track if we are in a seeker and if we loss the control
		if(vars.inControlOfBody.Changed && vars.inControlOfBody.Current == 0) {
			return true;
		}
	}
}