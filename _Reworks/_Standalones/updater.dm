/*
essentially check if we are -on update x, if not, update to x, if so, do nothing
*/

// make it so on world load we make the current version datum and use it for all people
proc/generateVersionDatum()
	var/updateversion = text2path("update/version[glob.UPDATE_VERSION]")
	if(updateversion)
		glob.currentUpdate = new updateversion

globalTracker
	var/UPDATE_VERSION = 4
	var/tmp/update/currentUpdate

	proc/updatePlayer(mob/p)
		if(!p.updateVersion)
			var/updateversion = "/update/version[glob.UPDATE_VERSION]"
			p.updateVersion = new updateversion
			p.updateVersion.updateMob(p)
		if(UPDATE_VERSION == p.updateVersion.version)
			return
		if(p.updateVersion.version + 1 == UPDATE_VERSION)
			var/updateversion = "/update/version[p.updateVersion + 1]"
			var/update/update = new updateversion
			update.updateMob(p)
		else if(p.updateVersion.version + 1 < UPDATE_VERSION)
			for(var/x in 1 to abs(p.updateVersion - UPDATE_VERSION))
				// get the number of updates we are missing
				var/updateversion = "/update/version[p.updateVersion + 1]"
				var/update/update = new updateversion
				update.updateMob(p)


mob/var/update/updateVersion

update
	var/version = 1

	proc/updateMob(mob/p)
	//	p << "You have been updated to version [version]"
		p.updateVersion = src

	version1

	version2
		version = 2
		updateMob(mob/p)
			..()
			if(p.isRace(ANDROID))
				p << "The Elysium helpfully supplies a few upgrades to aid you on your glorious mission, glory to Humanity."
				p.passive_handler.increaseList(list("TechniqueMastery" = 3, "MovementMastery" = 4, "PureDamage" = 1, "PureReduction" = 1, "Flicker" = 2))
				p.race.passives = list("TechniqueMastery" = 3, "MovementMastery" = 4, "PureDamage" = 1, "PureReduction" = 1, "Flicker" = 2)
				if(p.AscensionsAcquired >= 1)
					p.passive_handler.increaseList(list("TechniqueMastery" = 0.5, "MovementMastery" = 3))
				if(p.AscensionsAcquired >= 2)
					p.passive_handler.increaseList(list("TechniqueMastery" = 0.5, "MovementMastery" = 3))
				if(p.AscensionsAcquired >= 3)
					p.passive_handler.increaseList(list("TechniqueMastery" = 0.5, "MovementMastery" = 3))
				if(p.AscensionsAcquired >= 4)
					p.passive_handler.increaseList(list("TechniqueMastery" = 0.5, "MovementMastery" = 3))
				if(p.AscensionsAcquired >= 5)
					p.passive_handler.increaseList(list("MovementMastery" = 3))

	version3
		version = 3
		updateMob(mob/p)
			..()
			if(p.isRace(ANDROID))
				p.passive_handler.decreaseList(list("MovementMastery" = 2))
				p.race.passives = list("TechniqueMastery" = 3, "MovementMastery" = 2, "PureDamage" = 1, "PureReduction" = 1, "Flicker" = 2)
				if(p.AscensionsAcquired >= 1)
					p.passive_handler.decreaseList(list("TechniqueMastery" = 0.5, "MovementMastery" = 2))
				if(p.AscensionsAcquired >= 2)
					p.passive_handler.decreaseList(list("TechniqueMastery" = 0.5,"MovementMastery" = 2))
				if(p.AscensionsAcquired >= 3)
					p.passive_handler.decreaseList(list("TechniqueMastery" = 0.5,"MovementMastery" = 1))

	version4
		version = 4
		updateMob(mob/p)
			..()
			if(p.isRace(HALFSAIYAN))
				var/list/transpaths = subtypesof(text2path("/transformation/saiyan"))
				for(var/i in transpaths)
					p.race.transformations += new i

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

