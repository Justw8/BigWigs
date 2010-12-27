﻿local L = BigWigs:NewBossLocale("Atramedes", "esES")
if L then
	L.tracking_me = "Tracking on ME!"

	L.shield = "Ancient Dwarven Shield"
	L.shield_desc = "Warning for the remaining Ancient Dwarven Shields."
	L.shield_message = "%d Ancient Dwarven Shield left"

	L.ground_phase = "Fase en el suelo"
	L.ground_phase_desc = "Aviso cuando Atramedes aterriza."
	L.air_phase = "Fase aérea"
	L.air_phase_desc = "Aviso cuando Atramedes despega."

	L.air_phase_trigger = "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"

	L.sonicbreath_cooldown = "~Aliento sónico"
end

L = BigWigs:NewBossLocale("Chimaeron", "esES")
if L then
	L.bileotron_engage = "The Bile-O-Tron springs to life and begins to emit a foul smelling substance."

	L.next_system_failure = "Siguiente fallo del sistema"
	L.break_message = "%2$dx Romper en %1$s"

	L.warmup = "Entrar en calor"
	L.warmup_desc = "Contador para entrar en calor"
end

L = BigWigs:NewBossLocale("Magmaw", "esES")
if L then
	L.inferno = (GetSpellInfo(92191))
	L.inferno_desc = "Summons Blazing Bone Construct"

	L.slump = "Slump"
	L.slump_desc = "Slumps forward exposing itself"

	L.slump_trigger = "%s slumps forward, exposing his pincers!"
end

L = BigWigs:NewBossLocale("Maloriak", "esES")
if L then
	--heroic
	L.darkSludge = (GetSpellInfo(92987))
	L.darkSludge_desc = ("Warning for when you stand in %s."):format((GetSpellInfo(92987)))

	--normal
	L.final_phase = "Final Phase"

	L.release_aberration_message = "%s adds left!"
	L.release_all = "%s adds released!"

	L.bitingchill_say = "Biting Chill on ME!"

	L.flashfreeze = "~Flash Freeze"

	L.phase = "Phase"
	L.phase_desc = "Warning for Phase changes."
	L.next_phase = "Next Phase"

	L.you = "%s on YOU!"

	L.red_phase_trigger = "Mix and stir, apply heat..."
	L.red_phase = "|cFFFF0000Red|r phase"
	L.blue_phase_trigger = "How well does the mortal shell handle extreme temperature change? Must find out! For science!"
	L.blue_phase = "|cFF809FFEBlue|r phase"
	L.green_phase_trigger = "This one's a little unstable, but what's progress without failure?"
	L.green_phase = "|cFF33FF00Green|r phase"
	L.dark_phase = "|cFF660099Dark|r phase"
	L.dark_phase_trigger = "Your mixtures are weak, Maloriak! They need a bit more... kick!"
end

L = BigWigs:NewBossLocale("Nefarian", "esES")
if L then
	L.phase = "Phases"
	L.phase_desc = "Warnings for the Phase changes."

	L.phase_two_trigger = "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!"

	L.chromatic_prototype = "Chromatic Prototype" -- 3 adds name
end

L = BigWigs:NewBossLocale("Omnotron Defense System", "esES")
if L then
	L.nef = "Lord Victor Nefarius"
	L.nef_desc = "Warnings for Lord Victor Nefarius abilities"
	L.switch = "Switch"
	L.switch_desc = "Warning for Switches"

	L.next_switch = "Next Switch"

	L.nef_trigger1 = "Were you planning on using Toxitron's chemicals to damage the other constructs? Clever plan, let me ruin that for you."
	L.nef_trigger2 = "Stupid Dwarves and your fascination with runes! Why would you create something that would help your enemy?"

	L.nef_next = "~Next ability buff"

	L.acquiring_target = "Acquiring Target"

	L.cloud_message = "Cloud on YOU!"
end
