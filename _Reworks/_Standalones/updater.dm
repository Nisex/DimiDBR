/*
essentially check if we are -on update x, if not, update to x, if so, do nothing
*/

// make it so on world load we make the current version datum and use it for all people
proc/generateVersionDatum()
	var/updateversion = text2path("update/version[glob.UPDATE_VERSION]")
	if(updateversion)
		glob.currentUpdate = new updateversion

globalTracker
	var/UPDATE_VERSION = 1
	var/tmp/update/currentUpdate

	proc/updatePlayer(mob/p)
		if(p.updateVersion + 1 == UPDATE_VERSION)
	        // we dont need to generate new datums to update him
			var/updateversion = "/update/version[p.updateVersion + 1]"
			var/update/update = new updateversion
			update.updateMob(p)
		else
			for(var/x in 1 to abs(p.updateVersion - UPDATE_VERSION))
				// get the number of updates we are missing
				var/updateversion = "/update/version[p.updateVersion + 1]"
				var/update/update = new updateversion
				update.updateMob(p)
				del update // i guess loc = null doesn't work cause datums have no loc


mob/var/updateVersion = 1

update
	var/version = 1

	proc/updateMob(mob/p)
		p << "You have been updated to version [version]]"
		p.updateVersion = version

	version1

	/* FRAMEWORK FOR UPDATES
	version2
		version = 2
		updateMob(mob/p)
			// essentially do the update needed her
			// for example, with the next thing we will be finding fiber stacks and reducing their asc giving power
			..()
	*/

	version2
		version = 2
		updateMob(mob/p)
			if(p.isRace(DRAGON))
				p.AngerMax = 1.5
			..()


	version3
		version = 3
		updateMob(mob/p)
			if(p.isRace(NAMEKIAN))
				p.AngerMax = 1.5
			if(p.isRace(DEMON))
				if(length(p.demon.BuffPassives) < 1 && length(p.demon.DebuffPassives) < 1)
					p.demon.selectPassive(p, "CORRUPTION_PASSIVES", "Buff")
					p.demon.selectPassive(p, "CORRUPTION_DEBUFFS", "Debuff")
				for(var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire/hf in src)
					if(!hf.possible_skills["Corruption"])
						hf.possible_skills["Corruption"] = new/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Space
			..()
	
	version4
		version = 4
		updateMob(mob/p)
			if(p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm))
				Log("Admin", "[ExtractInfo(p)] has old devil arm.")
				p <<"old devil arm is removed, if you are not demon, ahelp for the new one. or have the demon use the pact system. "
			if(p.isRace(DEMON))
				if(!p.FindSkill(/obj/Skills/Utility/Imitate))
					p.AddSkill(new/obj/Skills/Utility/Imitate)
					p << "Imitate added"
				del p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm)
				p << "Deleted old Devil Arm"
				p.AddSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2)
				p << "Added new Devil Arm (Apparently Stable)"
				if(!p.race?:devil_arm_upgrades)
					p.race?:devil_arm_upgrades = 1
				p << "devil arm upgrades set to 1. if your devil arm doesn't work, a help"

			if(p.isRace(GAJALAKA))
				for(var/obj/Items/mineral/min in p)
					Log("Admin", "[ExtractInfo(p)] has a mineral stack with [min.value] total.")
					world.log<< "[ExtractInfo(p)] has a mineral stack with [min.value] total."
				p.EnhancedHearing = 0
				if(p.EconomyMult==2)
					p.EconomyMult /= 2
				p.Intelligence = 0.75
			..()
	version5
		version = 5
		updateMob(mob/p)
			if(p.isRace(DEMON))
				var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire/hf = p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire)
				if(!hf)
					for(var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire/hellfire in p)
						hf = hellfire
				hf.possible_skills["HellFire"] = new/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm
				p << "hellstorm changed"
			..()
	version6
		version = 6
		updateMob(mob/p)
			if(length(p.generateMagicList()) >= 1)
				p.legacyRefundmagic()
			if(p.isRace(SAIYAN))
				p.passive_handler.Increase("Brutalize", 0.25)
			if(p.isRace(BEASTMAN) && p.AscensionsAcquired < 1)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in p.Buffs)
					b.NeedsHealth = 10
					b.passives = list("Brutalize" = 0.5, "DemonicDurability" = 0.25)
			..()
	version7
		version = 7
		updateMob(mob/p)
			if(p.Desperation)
				src << "tht sure was strange."
				p.Desperation = 0
			..()
	version8
		version = 8
		updateMob(mob/p)
			if(p.DefianceCounter)
				p.DefianceCounter = 0 
			..()