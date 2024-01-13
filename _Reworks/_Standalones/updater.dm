/*

essentially check if we are -on update x, if not, update to x, if so, do nothing


*/

// make it so on world load we make the current version datum and use it for all people

/proc/generateVersionDatum()
	var/updateversion = "/datum/update/version[glob.UPDATE_VERSION]"
	glob.currentUpdate = new updateversion

/datum/globalTracker/proc/updatePlayer(mob/p)
	// essentially
	p << "UPDATING..."
	p << "VERSION [p.updateVersion]]"
	p << "CURRENT VERSION IS [UPDATE_VERSION]]"
	if(p.updateVersion + 1 == UPDATE_VERSION)
        // we dont need to generate new datums to update him
		var/updateversion = "/datum/update/version[p.updateVersion + 1]"
		var/datum/update/update = new updateversion
		update.updateMob(p)
	else
		for(var/x in 1 to abs(p.updateVersion - UPDATE_VERSION))
			// get the number of updates we are missing
			var/updateversion = "/datum/update/version[p.updateVersion + 1]"
			var/datum/update/update = new updateversion
			update.updateMob(p)
			del update // i guess loc = null doesn't work cause datums have no loc




/datum/globalTracker/var/UPDATE_VERSION = 6
/datum/globalTracker/var/tmp/datum/update/currentUpdate
// LETS HAVE EVERYONE BE 1

/mob/var/updateVersion = 1

/datum/update
    //XD

/datum/update/proc/updateMob(mob/p)
	p << "You have been updated to version [version]]"
	p.updateVersion = version

/datum/update/var/version = 1
// a small package that just does a proc, i think thats bascially what we can do?

/* FRAMEWORK FOR UPDATES
/datum/update/version2
	version = 2
	updateMob(mob/p)
		// essentially do the update needed her
		// for example, with the next thing we will be finding fiber stacks and reducing their asc giving power
		..()
*/ 