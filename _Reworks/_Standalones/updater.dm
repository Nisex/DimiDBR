/*
essentially check if we are -on update x, if not, update to x, if so, do nothing
*/

// make it so on world load we make the current version datum and use it for all people
proc/generateVersionDatum()
	var/updateversion = text2path("update/version[glob.UPDATE_VERSION]")
	if(updateversion)
		glob.currentUpdate = new updateversion

globalTracker
	var/UPDATE_VERSION = 2
	var/tmp/update/currentUpdate

	proc/updatePlayer(mob/p)
		if(!p.updateVersion)
			var/updateversion = "/update/version[glob.UPDATE_VERSION]"
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
	//	p << "You have been updated to version [version]"
		p.updateVersion = src

	version1

	version2
		updateMob(mob/p)
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

