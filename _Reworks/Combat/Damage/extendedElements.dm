// TESTED
/mob/proc/handleElementPassives(mob/defender)
    var/list/debuffVars = list("Burning", "Scorching", "Chilling","Freezing", "Crushing", \
        "Shattering", "Shocking", "Paralyzing", "Poisoning","Toxic")
    var/list/debuff2Element = list("Burning" = "Fire", "Scorching" = "Fire", \
        "Chilling" = "Water", "Freezing" = "Water", "Crushing" = "Earth", \
        "Shattering" = "Earth", "Shocking" = "Wind", "Paralyzing" = "Wind", \
        "Poisoning" = "Poison", "Toxic" = "Poison")
    var/list/messages = list("Fire"= "<font color='[rgb(204, 153, 51)]'>[defender] erupts in flames!!</font color>", \
    "Water" = "<font color='[rgb(51, 153, 204)]'>[defender] freezes to the bone!!</font color>", \
    "Earth" = "<font color='[rgb(51, 204 , 153)]'>[defender] falters; their guard is crushed!!</font color>", \
    "Wind" = "<font color='[rgb(153, 255, 255)]'>[defender] twitches erratically; they're shocked!!</font color>", \
    "Poison" = "<font color='[rgb(204, 51, 204)]'>[defender] looks unwell; they've been poisoned!!</font color>")
    for(var/debuff in debuffVars)
        var/PreviousElement = ElementalOffense
        if(call(src, "Has[debuff]")())
            ElementalOffense = debuff2Element[debuff]
            if(!defender.HasDebuffImmune())
                switch(ElementalOffense)
                    if("Fire")
                        if(!defender.Burn)
                            OMsg(src, messages[ElementalOffense])
                    if("Water")
                        if(!defender.Slow)
                            OMsg(src, messages[ElementalOffense])
                    if("Earth")
                        if(!defender.Shatter)
                            OMsg(src, messages[ElementalOffense])
                    if("Wind")
                        if(!defender.Shock)
                            OMsg(src, messages[ElementalOffense])
                    if("Poison")
                        if(!defender.Poison)
                            OMsg(src, messages[ElementalOffense])
            . += ElementalCheck(src, defender, DebuffIntensity = clamp(call(src, "Get[debuff]")(), 1, 50))
            ElementalOffense = PreviousElement	

/mob/proc/addElementalPassives(obj/Skills/Q)
    var/list/debuffVars = list("Burning", "Scorching", "Chilling","Freezing", "Crushing", \
        "Shattering", "Shocking", "Paralyzing", "Poisoning","Toxic")
    for(var/elePassive in debuffVars)
        if(Q.vars[elePassive])
            passive_handler.Increase(elePassive, Q.vars[elePassive])

/mob/proc/removeElementalPassives(obj/Skills/Q)
    var/list/debuffVars = list("Burning", "Scorching", "Chilling","Freezing", "Crushing", \
        "Shattering", "Shocking", "Paralyzing", "Poisoning","Toxic")
    for(var/elePassive in debuffVars)
        if(Q.vars[elePassive])
            passive_handler.Decrease(elePassive, Q.vars[elePassive])
