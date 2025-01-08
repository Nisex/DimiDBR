mob/var/dainsleifDrawn = FALSE

obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Ruin//Dainsleif
	name="Blade of Ruin"
	icon='Dainsleif.dmi'
	passives = list("Shearing" = 1, "CursedWounds" = 1, "MortalStrike" = 0.5)
	var/hasKilled = FALSE
	proc/drawDainsleif(mob/p)
		hasKilled = FALSE
		if(!p.dainsleifDrawn)
			p << "You draw the blade from it sheathe and are barely able to contain its immense bloodlust. The sword cries out, waning for blood."
			OMsg(p, "[p.name] draws their blade from its sheathe and they can barely contain it. The Sword of Ruin wans for blood...")
		p.dainsleifDrawn = TRUE
		spawn(20) dainsleifDrain(p)
	proc/onKill(mob/atk, mob/defend)
		hasKilled = TRUE
		OMsg(atk, "The Sword of Ruin's blood lust has been sated by [defend.name]'s death!")

	proc/putAway(mob/p)
		if(!hasKilled)
			if(p.HealthCut >=0.3)
				p << "The blade refuses to be sheathed."
				return FALSE
			else
				var/choice = input(p, "The blade resists your attempts to sheathe it. Do you wish to sheathe it anyway?") in list("Yes", "No")
				switch(choice)
					if("Yes")
						p << "The blade forces itself into your body and you feel your life force being drained away."
						OMsg(p, "The blade shoves itself into [p.name]'s body, absorbing their life force!")
						p.HealthCut += 0.1
						p.dainsleifDrawn = FALSE
						return TRUE
					if("No")
						p << "You decide to keep the blade out."
						return FALSE
		else
			hasKilled = FALSE
			p.dainsleifDrawn = TRUE
			return TRUE

	proc/dainsleifDrain(mob/p)
		if(glob.DainsleifDrain && p.dainsleifDrawn)
			while(p.dainsleifDrawn)
				sleep(10)
				if(!p.KO)
					p.DoDamage(p, glob.DainsleifDrainAmount / p.SagaLevel)
		else
			return .

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Dainsleif
	name = "Heavenly Regalia: Ruined World"
	StrMult=1.5
	OffMult=1.5
	passives = list("Instinct" = 3, "LifeStealTrue" = 1, "PureDamage" = -1)
	IconLock='EyeFlameC.dmi'
	ActiveMessage="soaks the world in blood: Heavenly Regalia!"
	OffMessage="'s treasure loses its ruinous luster..."
	verb/Heavenly_Regalia()
		set category="Skills"
		src.Trigger(usr)