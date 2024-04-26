
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

#define NARROW_RESTRICTS list("Staff", "Armor", "Sword", "Guns", "Modules", "Heavy Strike", )
#define WIDE_RESTRICTS list("Armed Skills", "Unarmed Skills", "Universal Skills", "Magic", \
"Science", "Queues", "Autohits", "All Skills", "Force", "Defense", "Endurance", "Melee Damage", "Ki Damage",\
"Cybernetics", "Strength", "Speed", "Offense", "Queues", "Autohits")
#define NARROW_IMPROVES list("Normal Attack", "Guns", "Modules", "Sword", "Staff", \
"Ki Attack", "Defense", "Strength", "Force", "Endurance", "Speed", "Offense")
#define WIDE_IMPROVES list("Cybernetics", "Melee Damage", "Ki Damage", "Queues", "Autohits", "Magic", \
"All Skills", "Weapons", )

#define IMPROVE_BOON_NUM list("NARROW" = 1.6, "WIDE" = 1.3) // given this is the result of below
#define RESTRICT_BOON_NUM list("NARROW" = 0.25, "WIDE" = 0.33) // given this is the restriction tier * number


/SecretInfomation/HeavenlyRestriction/proc/pickRestriction(mob/p)
    var/restrict_type = input(p, "Narrow or Wide?") in list("Narrow", "Wide")
    var/selection
    var/list/restrictions = getRestrictions()
    switch(restrict_type)
        if("Narrow")
            selection = input(p, "Pick a restriction") in NARROW_RESTRICTS - restrictions
        if("Wide")
            selection = input(p, "Pick a restriction") in WIDE_RESTRICTS - restrictions
    return selection

/SecretInfomation/HeavenlyRestriction/proc/pickImprove(mob/p, currentRestricitonChoice)
    var/improve_type = input(p, "Narrow or Wide?") in list("Narrow", "Wide")
    var/atLimit = 1
    var/selection
    var/list/restrictions = getRestrictions() + currentRestricitonChoice
    while(atLimit)
        switch(improve_type)
            if("Narrow")
                selection = input(p, "Pick an improvement") in NARROW_IMPROVES - restrictions
            if("Wide")
                selection = input(p, "Pick an improvement") in WIDE_IMPROVES - restrictions
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
    

/SecretInfomation/HeavenlyRestriction/proc/updateImprove(improv)
    if(secretVariable["Improvements"][improv])
        if(improv in NARROW_IMPROVES)
            secretVariable["Improvements"][improv]["narrow"] += 1
        else if(improv in WIDE_IMPROVES)
            secretVariable["Improvements"][improv]["wide"] += 1
    else
        if(improv in NARROW_IMPROVES)
            secretVariable["Improvements"][improv] = list("narrow" = 1, "wide" = 0)
        else if(improv in WIDE_IMPROVES)
            secretVariable["Improvements"][improv] = list("narrow" = 0, "wide" = 1)

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
                secretVariable["Improvements"][r[2]] = list("narrow" = 0, "wide" = 1)


/SecretInfomation/HeavenlyRestriction/proc/getBoon(mob/p, improvement)
    if(!(improvement in secretVariable["Improvements"]))
        return 0
    var/aB = 0 // additive boon
    var/mB = 1 // multiplicative boon
    var/improv = secretVariable["Improvements"][improvement]
    var/occurences = 0
    for(var/index in secretVariable["Restrictions"])
        if(secretVariable["Restrictions"][index][2] == improvement)
            occurences += 1
            if(secretVariable["Restrictions"][index][1] in NARROW_RESTRICTS)
                aB += RESTRICT_BOON_NUM["NARROW"]
            else if(secretVariable["Restrictions"][index][1] in WIDE_RESTRICTS)
                aB += RESTRICT_BOON_NUM["WIDE"]

    for(var/i = 1 to occurences)
        if(improvement in NARROW_IMPROVES)
            mB *= IMPROVE_BOON_NUM["NARROW"]
        else if(improvement in WIDE_IMPROVES)
            mB *= IMPROVE_BOON_NUM["WIDE"]
    world<<"[currentTier] * [aB] * [mB] = [(currentTier * aB) * mB]"
    return (currentTier * aB) * mB


/SecretInfomation/HeavenlyRestriction/proc/countImprovements(mob/p, improv)
    var/total = 0
    for(var/index in secretVariable["Restrictions"])
        if(secretVariable["Restrictions"][index][2] == improv)
            total += 1
    return total

/SecretInfomation/HeavenlyRestriction/proc/getRestrictions()
    . = list()
    for(var/index in secretVariable["Restrictions"])
        . += secretVariable["Restrictions"]["[index]"][1]

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
    secretDatum = new/SecretInfomation/HeavenlyRestriction()
    while(secretDatum.currentTier < 6)
        var/restriction = secretDatum?:pickRestriction(src)
        secretDatum?:applySecretVariable(src, restriction, secretDatum?:pickImprove(src, restriction))
        secretDatum.currentTier++
        sleep(15)
    var/improv = input(src, "what one") in NARROW_IMPROVES + WIDE_IMPROVES
    secretDatum?:getBoon(src, improv)
    return