/mob/var/tmp/last_style_effect = 0

/obj/Skills/Buffs/NuStyle/MysticStyle
	StyleFor = 1.15
	passives = list("SpiritFlow" = 0.25)
	Fire_Weaving
		passives = list("SpiritFlow" = 0.25, "Burning" = 1, "Combustion" = 25)
		StyleFor = 1.3
		Finisher="/obj/Skills/Queue/Finisher/Dancing_Flame_Attack"
		StyleActive="Fire Weaving"
	Water_Bending
		passives = list("SpiritFlow" = 0.25, "Chilling" = 1, "WaveDancer" = 1)
		StyleOff = 1.15
		Finisher="/obj/Skills/Queue/Finisher/Surfing_Stream"
		StyleActive="Water Bending"
	Earth_Moving
		passives = list("SpiritFlow" = 0.25, "Shattering" = 1, "EntanglingRoots" = 1)
		StyleEnd = 1.15
		Finisher="/obj/Skills/Queue/Finisher/Unstoppable_Force"
		StyleActive="Earth Moving"
	Wind_Summoning
		passives = list("SpiritFlow" = 0.25, "Shocking" = 1, "AirBend" = 1)
		StyleSpd = 1.15
		Finisher="/obj/Skills/Queue/Finisher/Whirlwind"
		StyleActive="Wind Summoning"
	Plague_Bringer
		passives = list("SpiritFlow" = 0.25, "Poisoning" = 1, "Rusting" = 1)
		StyleDef = 1.15
		Finisher="/obj/Skills/Queue/Finisher/"
		StyleActive="Plague Bringer"


/obj/Skills/AutoHit/Water_Wave
	Copyable = 0
	Area="Wave"
	ComboMaster=1
	Distance=15
	Size = 6
	AdaptRate = 1
	DamageMult=1
	Slow = 0.5
	Knockback = 2
	TurfStrike=2
	TurfShift='WaterBlue.dmi'
	TurfShiftDuration=3
	Cooldown=5

/mob/proc/can_use_style_effect(passive_name)
	if(last_style_effect == 0)
		return TRUE
	var/static_cd = glob.STYLE_EFFECT_CD
	var/cd = static_cd - ((static_cd/5)*passive_handler["[passive_name]"])
	world<<"[last_style_effect] + [cd] < [world.time]"
	if(last_style_effect + cd < world.time)
		return TRUE
	return FALSE