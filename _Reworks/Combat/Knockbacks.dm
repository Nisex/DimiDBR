/globalTracker/var/MAX_KB_MULT = 5
/globalTracker/var/MAX_KB_RES = 0.25
/globalTracker/var/MAX_KB_TIME = 25
/globalTracker/var/KB_SPEED = 0.5 // was 0.15
//TODO convert to glob
gatherKBMods
/mob/proc/getLegendPMult()
    return HasLegendaryPower()*0.5
/mob/proc/gatherKBMods()
    . = 0
    . += passive_handler.Get("GiantForm") * 2
    . += getLegendPMult()
    . += passive_handler.Get("HeavyHitter")
    . += 1 + passive_handler.Get("KBMult")
    if(. > glob.MAX_KB_MULT)
        . = glob.MAX_KB_MULT

/mob/proc/isForced()
    if(passive_handler.Get("HeavyHitter"))
        return 1
    return 0

/mob/proc/getKnockbackMultiplier(mob/defender)
    if(defender)
        // get the defenders anti kb measures
        if(!defender.passive_handler)
            return 1
        var/mod = ( ((defender.passive_handler.Get("GiantForm") * 0.15) + (defender.HasLegendaryPower() * 0.5) + (defender.passive_handler.Get("Juggernaut") * 0.05)) )
        mod += clamp(defender.passive_handler.Get("KBRes") * 0.1, 0, 1)
        var/res = 1 - mod
        if(res < glob.MAX_KB_RES)
            res = glob.MAX_KB_RES
        return res
