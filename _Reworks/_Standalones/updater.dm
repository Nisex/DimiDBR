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
			var/updateversion = "update/version[p.updateVersion + 1]"
			var/update/update = new updateversion
			update.updateMob(p)
		else
			for(var/x in 1 to abs(p.updateVersion - UPDATE_VERSION))
				// get the number of updates we are missing
				var/updateversion = "update/version[p.updateVersion + 1]"
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