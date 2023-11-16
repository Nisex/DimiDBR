/var/MAX_KB_MULT = 5
/var/MAX_KB_RES = 0.01
/var/MAX_KB_TIME = 25
/var/KB_SPEED = 0.5 // was 0.15
//TODO convert to glob

/mob/proc/getLegendPMult()
    return HasLegendaryPower()*0.5
/mob/proc/gatherKBMods()
    . = 0
    . += passive_handler.Get("GiantForm") * 2
    . += getLegendPMult()
    . += passive_handler.Get("HeavyHitter")
    . += 1 + passive_handler.Get("KBMult")
    if(. > MAX_KB_MULT)
        . = MAX_KB_MULT

/mob/proc/isForced()
    if(passive_handler.Get("HeavyHitter"))
        return 1
    return 0

/mob/proc/getKnockbackMultiplier(mob/defender)
    if(defender)
        // get the defenders anti kb measures
        if(!defender.passive_handler)
            return 1
        var/mod = ( ((defender.passive_handler.Get("GiantForm") * 0.5) + (defender.HasLegendaryPower() * 0.25) + (defender.passive_handler.Get("Juggernaut") * 0.1)) )
        mod += clamp(defender.passive_handler.Get("KBRes") * 0.1, 0, 1)
        var/res = 1 - mod
        if(res < MAX_KB_RES)
            res = MAX_KB_RES
        return res
    else
        return gatherKBMods()


// ADMIN VERBS
mob/Admin3/verb/KBMult()
    set name = "Change Max KB Mult"
    set desc = "Change the maximum KB multiplier"
    set category = "Admin"
    MAX_KB_MULT = input("Enter the new max KB multiplier", MAX_KB_MULT) as num
    world << "Max KB multiplier set to [MAX_KB_MULT]"

mob/Admin3/verb/KBRes()
    set name = "Change Max KB Res"
    set desc = "Change the maximum KB resistance"
    set category = "Admin"
    MAX_KB_RES = input("Enter the new max KB resistance. Probably don't change this, will alter Dempsey", MAX_KB_RES) as num
    world << "Max KB resistance set to [MAX_KB_RES]"

mob/Admin3/verb/KBDist()
    set name = "Change Max KB Dist"
    set desc = "Change the maximum KB distance"
    set category = "Admin"
    MAX_KB_TIME = input("Enter the new max KB distance", MAX_KB_TIME) as num
    world << "Max KB distance set to [MAX_KB_TIME]"

mob/Admin3/verb/KBSpeed()
    set name = "Change Max KB SPEED"
    set category = "Admin"
    KB_SPEED = input("Enter the new max KB SPEED", KB_SPEED) as num
    world << "Max KB SPEED set to [KB_SPEED]"