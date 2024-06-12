
/*
/datum/SecretInfomation
	HeavenlyRestriction
		name = "Heavenly Restriction"
		givenSkills = list("/obj/Skills/Buffs/SlotlessBuffs/HeavenlyRestriction/HeavenlyRestriction")
		secretVariable = list("Restrictions" = list(), "Improvements" = list())

/mob/var/datum/SecretInfomation/secretDatum = new()

pick something to restrict
pick something to improve
depending on the rescrit and improve, give an increase to that improve
if the improve is wide like melee damage, lessen the boon, if its narrow like normal attack widen the boon
if the restrict is narrow like using a sword, lessen the boon, if it is wide like 'using armed skills' widen the boon
(sword punching exists, so somebody could not use a sword, but still use armed skills making it narrow)

at intervals of 2, 4, 6 pick another restrict and improve, if you pick the same, increase the mult of the 1 boon

throw in stat mults at 2,4,5, depending on the path of restricting
    this is to say like a melee focus will get str , a force will get for, anda  hybrid will get both
    a melee will get str but lose for, by picking to lose for they get more str
    same as for and melee, by picking both the bonous is not that much

*/
/obj/Skills/Buffs/SlotlessBuffs/HeavenlyRestriction/HeavenlyRestriction
	AlwaysOn = 1
	ActiveMessage = ""
	OffMessage = ""

var/list/heavenly_restrictions = list("Staff" = 10, "Armor" = 20, "Sword" = 10, "Modules" = 5, "Heavy Strike" = 10, "Armed Skills" = 15, "Unarmed Skills" = 15, "Universal Skills" = 15, "Magic" = 30, \
"Science" = 30, "Queues" = 20, "Autohits" = 20, "Projectiles" = 20, "Grapples" = 20, "All Skills" = 50, "Force" = 20, "Defense" = 20, "Endurance" = 20, "Melee Damage" = 30, "Ki Damage" = 30, \
"Cybernetics" = 10, "Strength" = 20, "Speed" = 20, "Offense" = 20, "Normal Attack" = 40, "Grab" = 25)

var/list/heavenly_improvements = list("Normal Attack", "Modules", "Sword", "Staff", \
"Ki Attack", "Grapples", "Defense", "Strength", "Force", "Endurance", "Speed", "Offense", "Cybernetics", "Melee Damage", "Ki Damage", "Queues", "Autohits", "Magic", \
"All Skills", "Weapons")

/SecretInfomation/HeavenlyRestriction/proc/modifyRestrictionValues(mob/p, restriction)
	switch(restriction)
	    //these should probably just get the base stat instead.
		if("Force")
			if(p.BaseFor()>p.BaseStr())
				return 1.5
		if("Defense")
			if(p.BaseDef()>p.BaseOff())
				return 1.5
		if("Offense")
			if(p.BaseOff()>p.BaseDef())
				return 1.5
		if("Endurance")
			var/boon = 1
			if(p.BaseEnd() > p.BaseStr())
				boon += 0.25
			if(p.BaseEnd() > p.BaseFor())
				boon += 0.25
			return boon
		if("Strength")
			if(p.BaseStr() > p.BaseFor())
				return 1.5
		if("Cybernetics")
			if(p.isRace(ELDRITCH))
				return 2
			if(p.isRace(HUMAN) && p.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
				return 2
		if("Modules")
			if(p.isRace(ELDRITCH))
				return 2
			if(p.isRace(HUMAN) && p.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
				return 2
    return 1

/SecretInfomation/HeavenlyRestriction/proc/pickRestriction(mob/p)
	var/list/modifiedRestrictions = heavenly_restrictions - getRestrictions()
	var/list/shownRestrictions = list()
	var/ticker = 1
	for(var/i in modifiedRestrictions)
		modifiedRestrictions[i] = modifiedRestrictions[i]*modifyRestrictionValues(p, i)
		shownRestrictions[ticker] = "[i] ([modifiedRestrictions[i]])"
		ticker ++
	var/selection = input(p, "Pick a restriction. They are shown as what they'll restrict and the value in parathenses.") in shownRestrictions
	var/list/splitter = splittext(selection, " (")
	var/list/restrictionValue = list(splitter[1], modifiedRestrictions[splitter[1]])
	return restrictionValue

/SecretInfomation/HeavenlyRestriction/proc/pickImprove(mob/p, currentRestricitonChoice)
	var/atLimit = 1
	var/selection
	var/list/restrictions = getRestrictions() + currentRestricitonChoice
	while(atLimit)
		selection = input(p, "Pick an improvement") in heavenly_improvements - restrictions
		if(!(countImprovements(p, selection) >= 3))
			atLimit = 0
		else
			p << "You are at the limit for that improvement."
			selection = null
			atLimit = 1
	return selection

/SecretInfomation/HeavenlyRestriction/proc/applySecretVariable(mob/p, restr, improv)
	secretVariable["Restrictions"]["[currentTier]"] = list(restr, improv)
	updateImprove(improv)
	// secretVariable = list("Resitrictions" = list(1 = list(restr, improv), )

/SecretInfomation/HeavenlyRestriction/proc/updateImprove(improv, value)
	if(secretVariable["Improvements"][improv])
		secretVariable["Improvements"][improv] += value
	else
		secretVariable["Improvements"][improv] = value

/*
/SecretInfomation/HeavenlyRestriction/proc/resetImproves(mob/p)
    for(var/r in secretVariable["Restrictions"])
        r = secretVariable["Restrictions"][r]
        if(secretVariable["Improvements"][r[2]])
            if(r[1] in NARROW_RESTRICTS)
                secretVariable["Improvements"][r[2]]["narrow"] += 1
            else if(r[1] in WIDE_RESTRICTS)
                secretVariable["Improvements"][r[2]]["wide"] += 1
        else

            if(r[1] in NARROW_RESTRICTS)
                secretVariable["Improvements"][r[2]] = list("narrow" = 1, "wide" = 0)
            else if(r[1] in WIDE_RESTRICTS)
                secretVariable["Improvements"][r[2]] = list("narrow" = 0, "wide" = 1)*/


/SecretInfomation/HeavenlyRestriction/proc/getBoon(mob/p, improvement)
	if(!(improvement in secretVariable["Improvements"]))
		return 0
	var/totalBoon = 0
	for(var/index in secretVariable["Improvements"])
		if(index == improvement)
			totalBoon += secretVariable["Improvements"][index]

	world<<"[currentTier * totalBoon]"
	return currentTier * totalBoon


/SecretInfomation/HeavenlyRestriction/proc/countImprovements(mob/p, improv)
	var/total = 0
	for(var/index in secretVariable["Restrictions"])
		if(index == improv)
			total += 1
	return total

/SecretInfomation/HeavenlyRestriction/proc/getRestrictions()
	. = list()
	for(var/index in secretVariable["Restrictions"])
		. += index

/SecretInfomation/HeavenlyRestriction/proc/hasImprovement(improvement)
	if(secretVariable["Improvements"][improvement])
		return secretVariable["Improvements"][improvement]
	return FALSE

/SecretInfomation/HeavenlyRestriction/proc/hasRestriction(restriction)
	var/list/restricts = getRestrictions()
	for(var/x in restricts)
		if(restriction == x)
			return TRUE
	return FALSE



/mob/verb/testRestriction()
	usr.secretDatum = new/SecretInfomation/HeavenlyRestriction()
	usr.Secret = "Heavenly Restriction"
	while(usr.secretDatum.currentTier < 6)
		var/restriction = usr.secretDatum?:pickRestriction(src)
		usr.secretDatum?:applySecretVariable(src, restriction, secretDatum?:pickImprove(src, restriction))
		usr.secretDatum.currentTier++
		sleep(15)
	var/improv = input(src, "what one") in heavenly_improvements
	usr.secretDatum?:getBoon(src, improv)
	return