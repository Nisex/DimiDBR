/mob/proc/findMecha()
    var/obj/Items/Gear/Mobile_Suit/MS = new()
    MS = locate() in src
    return MS ? MS : FALSE


/mob/proc/piloting2bonus()
    return PilotingProwess * 0.075

/obj/Items/Gear/Mobile_Suit/proc/level2bonus()
    return Level * 0.15
    // MAX 10
/mob/proc/getMechStat(obj/Items/Gear/Mobile_Suit/mech, statInQuestion)
    var/org = statInQuestion
    if(statInQuestion < mech.Level) // the user's base stat is less than the mech's
        statInQuestion = mech.Level
    else
        statInQuestion += (statInQuestion*mech.level2bonus()) // add the bonus from the mech's level
    statInQuestion += (org*piloting2bonus()) // add the bonus from piloting prowess
    return statInQuestion