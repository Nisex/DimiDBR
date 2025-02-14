/obj/Skills/Buffs/NuStyle/MysticStyle
	Hellfire
		passives = list("SpiritFlow" = 3, "Familiar" = 2, "Combustion" = 60, "Heavy Strike" = "Inferno",\
						"Scorching" = 1)
		ElementalOffense = "HellFire"
		ElementalDefense = "Fire"
		BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Fire"
		StyleFor = 1.6
		Finisher="/obj/Skills/Queue/Finisher/Deal_with_the_Devil"
		var/obj/Skills/demonSkill = FALSE
		Trigger(mob/User, Override)
			. = ..()
			if(!demonSkill)
				var/inp = input(User, "What demon skill do you want?") in list("/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm", "/obj/Skills/Projectile/Magic/HellFire/Hellpyre", "/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat")
				BuffTechniques = list(inp)
				demonSkill = inp
		StyleActive = "Hellfire"

	Plasma
		ElementalOffense = "Wind"
		ElementalDefense = "Fire"
		StyleFor = 1.3
		StyleSpd = 1.3
		BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Earth"
		passives = list("SuperCharge" = 1,"Familiar" = 2, "SpiritFlow" = 3, "ThunderHerald" = 1, "CriticalChance" = 20, "CriticalDamage" = 0.1, \
						"Godspeed" = 2, "AirBend" = 1.5, "Hardening" = 2, "Burning" = 2, "Shattering" = 5, "Shocking" = 2, "Chilling" = 2)
		Finisher="/obj/Skills/Queue/Finisher/Mega_Arm" // Super_mega_buster
		StyleActive = "Plasma"
	Blizzard
		ElementalOffense = "Water"
		ElementalDefense = "Wind"
		BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Water"
		passives = list("IceHerald" = 1,"Familiar" = 2, "ThunderHerald" = 1, "CriticalChance" = 20, "CriticalDamage" = 0.2, "SpiritFlow" = 3, "Hardening" = 2, \
						"Freezing" = 5, "Shocking" = 5, "AirBend" = 2, "WaveDancer" = 1.5)
		Finisher="/obj/Skills/Queue/Finisher/Frostfist"
		StyleActive = "Blizzard"
	Hot_n_Cold
		var/hotCold = 0 // -100 is 100% cold, 100 is 100% hot
		StyleActive = "Hot Style"
		ElementalOffense = "Fire"
		ElementalDefense = "Water"
		BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Fire"
		passives = list("HeatingUp" = 1,"Familiar" = 2, "Amplify" = 2, "Heavy Strike" = "Inferno", "Scorching" = 10, "Combustion" = 60, "SpiritFlow" = 3, "SpiritHand" = 1)
		StyleFor = 1.45
		StyleOff = 1.15
		StyleActive = "Hot Style"
		proc/swap_stance()
			if(StyleActive == "Hot Style")
				StyleActive = "Cold Style"
				StyleEnd = 1.45
				StyleFor = 1.15
				ElementalOffense = "Water"
				ElementalDefense = "Fire"
				BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Water"
				passives = list("CoolingDown" = 1,"Familiar" = 2, "Amplify" = 2, "Hardening" = 3, "Freezing" = 10, "IceAge" = 50, "SpiritFlow" = 3, "WaveDancer" = 2)

				Finisher="/obj/Skills/Queue/Finisher/Phosphor" 
			else
				StyleActive = "Hot Style"
				ElementalOffense = "Fire"
				ElementalDefense = "Water"
				StyleFor = 1.45
				StyleOff = 1.15
				BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Fire"
				passives = list("HeatingUp" = 1,"Familiar" = 2, "Amplify" = 2, "Heavy Strike" = "Inferno", "Scorching" = 10, "Combustion" = 60, "SpiritFlow" = 3, "SpiritHand" = 1)

				Finisher="/obj/Skills/Queue/Finisher/Jet_Kindling" 
		verb/Swap_Stance()
			set category="Skills"
			if(usr.BuffOn(src))
				turnOff(usr)
			swap_stance()
			Trigger(usr, 1)
			giveBackTension(usr)
