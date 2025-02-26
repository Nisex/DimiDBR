/*
essentially check if we are -on update x, if not, update to x, if so, do nothing
*/

// make it so on world load we make the current version datum and use it for all people
proc/generateVersionDatum()
	var/update/updateversion
	for(var/i in subtypesof(/update/))
		var/update/check = new i
		if(updateversion && check.version > updateversion.version)
			updateversion = check
		else if (!updateversion)
			updateversion = check
	if(updateversion)
		glob.currentUpdate = updateversion

globalTracker
	var/UPDATE_VERSION = 6
	var/tmp/update/currentUpdate

	proc/updatePlayer(mob/p)
		if(!p.updateVersion)
			var/updateversion = "/update/version[UPDATE_VERSION]"
			p.updateVersion = new updateversion
			p.updateVersion.updateMob(p)	
		if(UPDATE_VERSION == p.updateVersion.version)
			return
		if(p.updateVersion.version + 1 == UPDATE_VERSION)
			var/updateversion = "/update/version[p.updateVersion.version + 1]"
			var/update/update = new updateversion
			update.updateMob(p)
		else if(p.updateVersion.version + 1 < UPDATE_VERSION)
			for(var/x in 1 to abs(p.updateVersion.version - UPDATE_VERSION))
				// get the number of updates we are missing
				var/updateversion = "/update/version[p.updateVersion.version + 1]"
				var/update/update = new updateversion
				update.updateMob(p)


mob/var/update/updateVersion

update
	var/version = 1

	proc/updateMob(mob/p)
		p << "You have been updated to version [version]"
		p.updateVersion = src

	version1

	version2
		version = 2
		updateMob(mob/p)
			. = ..()
			if(p.isRace(BEASTMAN))
				switch(p.race?:Racial)
					if("Unseen Predator")
						p.passive_handler.passives["Heavy Strike"] = "Unseen Predator"
					if("Trickster")
						p.Imagination = 2
						p.Intelligence = 1
					if("Feather Knife")
						p.passive_handler.passives["SwordPunching"] = 1
					if("Feather Cowl")
						p.passive_handler.passives["SwordPunching"] = 1
		
	version3
		version = 3
		updateMob(mob/p)
			. = ..()
			for(var/obj/Skills/Buffs/NuStyle/ms in src)
				if(istype(ms, /obj/Skills/Buffs/NuStyle/MysticStyle/Magma_Walker))
					ms.BuffTechniques = list("/obj/Skills/Buffs/SlotlessBuffs/Magmic_Shield")
				if(istype(ms, /obj/Skills/Buffs/NuStyle/SwordStyle/Sword_Savant))
					ms.passives = list("SwordPunching" = 1, "SwordDamage" = 1, "NeedsSword" = 0, "Sword Master" = 1)
				
				
			if(p.isRace(HUMAN))
				p.RPPMult = 1.25
	version4
		version = 4
		updateMob(mob/p)
			. = ..()
			if(p.isRace(BEASTMAN))
				switch(p.race?:Racial)
					if("Unseen Predator")
						p.passive_handler.passives["Heavy Strike"] = "Unseen Predator"
					if("Trickster")
						p.Imagination = 2
						p.Intelligence = 1
					if("Feather Knife")
						p.passive_handler.passives["SwordPunching"] = 1
					if("Feather Cowl")
						p.passive_handler.passives["SwordPunching"] = 1
			for(var/obj/Skills/Buffs/NuStyle/ms in src)
				if(istype(ms, /obj/Skills/Buffs/NuStyle/MysticStyle/Magma_Walker))
					ms.BuffTechniques = list("/obj/Skills/Buffs/SlotlessBuffs/Magmic_Shield")
				if(istype(ms, /obj/Skills/Buffs/NuStyle/SwordStyle/Sword_Savant))
					ms.passives = list("SwordPunching" = 1, "SwordDamage" = 1, "NeedsSword" = 0, "Sword Master" = 1)
				
		
				
			if(p.isRace(HUMAN))
				p.RPPMult = 1.25
	version5
		version = 5
		updateMob(mob/p)
			. = ..()
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Dardi_Style/d in p)
				if(p.BuffOn(d))
					d.Trigger(p)
				d.passives["Disarm"] = 1.5
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Gladiator_Style/d in p)
				if(p.BuffOn(d))
					d.Trigger(p)
				d.passives["Disarm"] = 1
			p.information.resetRanking()
			p.information.title = null

	version6
		version = 6
		updateMob(mob/p)
			. = ..()
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style/turtle in p)
				turtle.StyleComboUnlock = list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Shaolin_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tai_Chi_Style",\
		"/obj/Skills/Buffs/NuStyle/MysticStyle/Fire_Weaving"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style")
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Gladiator_Style/gladiator in p)
				gladiator.StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Fencing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Dardi_Style",\
        "/obj/Skills/Buffs/NuStyle/SwordStyle/Ittoryu_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido_Style")
			for(var/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style/black_leg in p)
				black_leg.StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wushu_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Mantis_And_Crane_Style", \
		"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Magma_Walker"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Ifrit_Jambe")
			for(var/obj/Skills/Buffs/NuStyle/MysticStyle/Plague_Bringer/pb in p)
				pb.StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style")
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido_Style/is in p)
				is.StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Nito_Ichi_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu")
			if(p.isRace(ANDROID))
				p.AddSkill(new/obj/Skills/Utility/Cybernetic_Augmentation)
	
/globalTracker/var/COOL_GAJA_PLAYERS = list("Thorgigamax", "Gemenilove" )
/globalTracker/var/GAJA_PER_ASC_CONVERSION = 0.25
/globalTracker/var/GAJA_MAX_EXCHANGE = 1

/mob/proc/gajaConversionCheck()
	if(key in glob.COOL_GAJA_PLAYERS)
		verbs += /mob/proc/ExchangeMinerals

/mob/proc/gajaConversionRateUpdate()
	if(isRace(GAJALAKA) && key in glob.COOL_GAJA_PLAYERS)
		var/asc = AscensionsAcquired
		var/ascRate = 0.5 + (glob.GAJA_PER_ASC_CONVERSION * asc) // 1.25 max
		for(var/obj/Money/moni in src)
			if(moni.Level >= 10000)
				var/boon = round(moni.Level * 0.00001, 0.1)
				if(boon > glob.GAJA_MAX_EXCHANGE) // so 1.75 total
					boon = glob.GAJA_MAX_EXCHANGE
				playerExchangeRate = ascRate + boon

