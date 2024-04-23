
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

#define NARROW_RESTRICS list("Staff", "Armor", "Sword", "Guns", "Modules", )
#define WIDE_RESTRICTS list("Armed Skills", "Unarmed Skills", "Universal Skills", "Magic", \
"Science", "Queues", "Autohits", "All Skills", "Force", "Defense", "Endurance", "Melee Damage", "Ki Damage",\
"Cybernetics", "Strength", "Speed", "Offense")
#define EXTREME_RESTRICTS list("Queues", "Autohits")
#define ULTRA_EXTREME_RESTRICTS list("All Skills")
#define NARROW_IMPROVES list("Normal Attack", "Guns", "Modules", "Sword", "Staff", \
"Ki Attack", "Defense", "Strength", "Force", "Endurance", "Speed", "Offense")
#define WIDE_IMPROVES list("Cybernetics", "Melee Damage", "Ki Damage", "Queues", "Autohits", "Magic", \
"All Skills", "Weapons", )

#define IMPROVE_BOON_NUM list("NARROW" = 2, "WIDE" = 1) // given this is the result of below
#define RESTRICT_BOON_NUM list("NARROW" = 0.33, "WIDE" = 1, "EXTREME" = 1.5, "ULTRA EXTREME" = 2) // given this is the restriction tier * number


/datum/SecretInfomation/HeavenlyRestriction/proc/pickRestriction(mob/p)
    var/restrict_type = input(p, "Narrow or Wide?") in list("Narrow", "Wide")
    var/selection
    switch(restrict_type)
        if("Narrow")
            selection = input(p, "Pick a restriction") in NARROW_RESTRICS
        if("Wide")
            selection = input(p, "Pick a restriction") in WIDE_RESTRICS
    return selection

/datum/SecretInfomation/HeavenlyRestriction/proc/pickImprove(mob/p)
    var/improve_type = input(p, "Narrow or Wide?") in list("Narrow", "Wide")
    var/selection
    switch(improve_type)
        if("Narrow")
            selection = input(p, "Pick an improvement") in NARROW_IMPROVES
        if("Wide")
            selection = input(p, "Pick an improvement") in WIDE_IMPROVES
    return selection

/datum/SecretInfomation/HeavenlyRestriction/proc/applySecretVariable(mob/p, branch, _type)
    if(p.secretDatum.secretVariable[branch][_type]) // if the restriction is already active
        p.secretDatum.secretVariable[branch][_type] += 1
    else
        p.secretDatum.secretVariable[branch][_type] = 1
    
/datum/SecretInfomation/HeavenlyRestriction/proc/setSecretVariable(mob/p, branch, _type, value)
    p.secretDatum.secretVariable[branch][_type] = value

/datum/SecretInfomation/HeavenlyRestriction/proc/calculateBoon(mob/p)
    var/boon = 0
    return boon
    


