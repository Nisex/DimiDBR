
/datum/globalTracker/var/list/IGNORE_POWER_CLAMP_PASSIVES = list("Wrathful", "LimitBroken")


/mob/proc/ignoresPowerClamp(mob/defender)
    if(istype(src, /mob/Player/AI) || istype(defender, /mob/Player/AI))
        return TRUE
    if(!src.passive_handler || !defender.passive_handler)
        return FALSE
    for(var/passive in glob.IGNORE_POWER_CLAMP_PASSIVES)
        if(passive_handler|=passive)
            return TRUE
    var/godKi = GetGodKi()
    var/defenderGodKi = defender.GetGodKi()
    if(!defenderGodKi)
        if(godKi )
            return TRUE
    else
        if(godKi)
            if((godKi > defenderGodKi) && godKi - defenderGodKi >= 0.5)
                return TRUE
    return FALSE