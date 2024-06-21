/*
essentially check if we are -on update x, if not, update to x, if so, do nothing
*/

// make it so on world load we make the current version datum and use it for all people
proc/generateVersionDatum()
	var/updateversion = text2path("update/version[glob.UPDATE_VERSION]")
	if(updateversion)
		glob.currentUpdate = new updateversion

globalTracker
	var/UPDATE_VERSION = 18
	var/tmp/update/currentUpdate

	proc/updatePlayer(mob/p)
		if(UPDATE_VERSION == p.updateVersion) return
		if(p.updateVersion + 1 == UPDATE_VERSION)
	        // we dont need to generate new datums to update him
			var/updateversion = "/update/version[p.updateVersion + 1]"
			var/update/update = new updateversion
			update.updateMob(p)
		else if(p.updateVersion + 1 < UPDATE_VERSION)
			for(var/x in 1 to abs(p.updateVersion - UPDATE_VERSION))
				// get the number of updates we are missing
				var/updateversion = "/update/version[p.updateVersion + 1]"
				var/update/update = new updateversion
				update.updateMob(p)
				del update // i guess loc = null doesn't work cause datums have no loc


mob/var/updateVersion = 19

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
				if(p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm))
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
				p.passive_handler.Set("Brutalize", 0.25)
			if(p.isRace(BEASTMAN) && p.AscensionsAcquired < 1)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in p.Buffs)
					b.NeedsHealth = 10
					b.passives = list("Brutalize" = 0.5, "DemonicDurability" = 0.25)
			..()
	version7
		version = 7
		updateMob(mob/p)
			..()
	version8
		version = 8
		updateMob(mob/p)
			..()
	version9
		version = 9
		updateMob(mob/p)
			if(p.GetRPPEvent()&&!global.RPPEventCharges["[p.ckey]"])
				p.RPPSpendableEvent = 0
				if(p.RPPSpentEvent > 0)
					AdminMessage("[p.name] ([p.ckey]) spent Event RPP when they shouldn't have! Please remove their latest tech / skill buy and refund any actual RPP.")
				p.RPPSpentEvent = 0
			..()
	version10
		version = 10
		updateMob(mob/p)
			if(p.GetRPPEvent())
				p.RPPSpendableEvent = 0
				if(p.RPPSpentEvent > 0)
					AdminMessage("[p.name] ([p.ckey]) spent Event RPP when they shouldn't have (maybe)! Please remove(delete) their latest tech / skill buy and refund any actual RPP(check what their total spent should be.")
				p.RPPSpentEvent = 0
			..()
	version11
		version = 11
		updateMob(mob/p)
			if(p.isRace(HUMAN))
				p.NewAnger(1.5)
				p << "Anger set to 1.5"
				p << "stats changed"
				p.stat_redo()
			if(p.isRace(ELDRITCH))
				p << "stats changed"
				p.stat_redo()
			if(p.isRace(DEMON))
				p << "stats changed"
				p.stat_redo()
			if(p.isRace(NAMEKIAN))
				p << "stats changed"
				p.stat_redo()
				p.Class = input("What clan do you hail from?", "Clan Selection")in list("Warrior", "Dragon", "Demon")
				switch(p.Class)
					if("Warrior")
						p.StrMod += 0.5
						p.EndMod += 0.25
					if("Dragon")
						p.ForMod += 0.5
						p.DefMod += 0.25
					if("Demon")
						p.SpdMod += 0.5
						p.OffMod += 0.25
			if(p.isRace(DRAGON))
				p << "stats changed"
				p.stat_redo()
			if(p.isRace(SAIYAN))
				p << "stats changed"
				p.stat_redo()
				p.passive_handler.Set("Brutalize", 0.25)
			if(p.isRace(MAKYO))
				p << "stats changed"
				p.stat_redo()

			..()
	version12
		version = 12
		updateMob(mob/p)
			if(p.isRace(DEMON))
				var/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2/da = p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2)
				da.passives = list()
				p.race?:devil_arm_upgrades = 1
				da.totalEvolvesMain = 0
				p << "devil arm reset"
			..()
	version13
		version = 13
		updateMob(mob/p)
			if(p.isRace(DEMON))
				for(var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/dm in p)
					dm = new()
			var/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style/c = p.FindSkill(/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style)
			if(c)
				c.passives = list("SwordPunching" = 1, "NeedsSword" = 0, "Shearing" = 1.5)
			if(p.isRace(HUMAN))
				p.passive_handler.Increase("Underdog", 1)
			..()
	version14
		version = 14
		updateMob(mob/p)
			if(p.isRace(DRAGON))
				p.AddSkill(new/obj/Skills/AutoHit/Dragon_Roar)

			..()
	version15
		version = 15
		updateMob(mob/p)
			if(p.isRace(DEMON))
				p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Self)

			..()
	version16
		version = 16
		updateMob(mob/p)
			if(p.isRace(MAJIN))
				p.NewAnger(1.5)
			..()
	version17
		version = 17
		updateMob(mob/p)
			if(p.isRace(YOKAI) && p.AscensionsAcquired == 1)
				p.passive_handler.Set("TechniqueMastery", 3)
				p.passive_handler.Set("ManaGeneration", 2)
				if(p.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/grand_caster)
					p.passive_handler.Set("ManaGeneration", 4)
			if(p.isRace(ELF) && p.AscensionsAcquired == 1)
				p.passive_handler.Set("SpiritFlow", 0.1)
			..()
	version18
		version = 18
		updateMob(mob/p)
			p.refund_all_copyables()
			if(p.isRace(HUMAN))
				p.passive_handler.Set("Innovation", 1)
			if(p.isRace(ELF))
				p.passive_handler.Set("Innovation", 1)
			if(p.isRace(BEASTMAN))
				p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Ticking_Bomb)
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield/sw in p.contents)
				sw.StyleComboUnlock = null
			..()

	version19
		version = 19
		updateMob(mob/p)
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wushu_Style/wus in p)
				wus.StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Heavenly_Demon_Fist_Style")
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Gladiator_Style/gla in p)
				gla.StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Shield_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield")
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Sunlit_Sky_Style/su in p)
				su.passives = list("SpiritHand" = 2, "SpiritFlow" = 0.5)
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Inverse_Poison_Style/inv in p)
				inv.passives = list("PureDamage" = 2, "Toxic" = 1)
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style/cir in p)
				cir.passives = list("CyberStigma" = 4, "PureDamage" = 0.5, "PureReduction" = 0.5)
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tranquil_Dove_Style/tranq in p)
				tranq.passives = list("StableBP" = 0.5, "Hardening" = 1, "SpiritHand" = 1)
			..()
