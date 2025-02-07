/mob/var/last_style_effect = 0

/obj/Skills/Buffs/NuStyle/MysticStyle
	StyleFor = 0.15
	passives = list("SpiritFlow" = 0.25)
	Fire_Weaving
		passives = list("SpiritFlow" = 0.25, "Burning" = 1, "Combustion" = 25)
		StyleFor = 0.3
		Finisher="/obj/Skills/Queue/Finisher/Dancing_Flame_Attack"
	Water_Bending
		passives = list("SpiritFlow" = 0.25, "Chilling" = 1, "WaveDancer" = 1)
		StyleOff = 0.15
		Finisher="/obj/Skills/Queue/Finisher/Surfing_Stream"
	Earth_Moving
		passives = list("SpiritFlow" = 0.25, "Shattering" = 1, "EntanglingRoots" = 1)
		StyleEnd = 0.15
		Finisher="/obj/Skills/Queue/Finisher/Unstoppable_Force"
	Wing_Summoning
		passives = list("SpiritFlow" = 0.25, "Shocking" = 1, "AirBend" = 1)
		StyleSpd = 0.15
		Finisher="/obj/Skills/Queue/Finisher/Whirlwind"
	Plague_Bringer
		passives = list("SpiritFlow" = 0.25, "Poisoning" = 1, "Rusting" = 1)
		StyleDef = 0.15
		Finisher="/obj/Skills/Queue/Finisher/"


/obj/Skills/AutoHit/Water_Wave
	Copyable = 0
	Area="Wave"
	ComboMaster=1
	Distance=15
	Size = 3
	AdaptRate = 1
	DamageMult=1
	Slow = 25
	Knockback = 2
	TurfStrike=2
	TurfShift='WaterBlue.dmi'
	TurfShiftDuration=3
	Cooldown=5

/mob/proc/can_use_style_effect(passive_name)
	var/static_cd = glob.STYLE_EFFECT_CD
	return static_cd - ((static_cd/5)*passive_handler["[passive_name]"])