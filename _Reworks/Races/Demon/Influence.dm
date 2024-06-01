/datum/DemonRacials

/mob/var/datum/DemonRacials/demon = new()

/datum/DemonRacials/var/list/BuffPassives = list()

/datum/DemonRacials/var/list/DebuffPassives = list()

/datum/DemonRacials/proc/getPassiveTier(mob/p)
    . = list()
    var/asc = p.AscensionsAcquired
    if(asc in 0 to 5)
        . += "I"
    if(asc in 2 to 5)
        . += "II"
    if(asc in 3 to 5)
        . += "III"
    if(asc in 4 to 5)
        . += "IV"
            
/datum/DemonRacials/proc/getJSONInfo(tier, type)
    var/jsonData = file('passives.json')
    jsonData = file2text(jsonData)
    jsonData = json_decode(jsonData)
    . = list()
    for(var/x in tier)
        . += jsonData["[type]_[x]"]
        for(var/y in jsonData["[type]_[x]"])
            .["[y]"] = jsonData["[type]_[x]"][y]

/datum/DemonRacials/proc/handlePassive(list/theList, input, option)
    . = TRUE
    if(vars["[option]Passives"][input])
        world<<"[vars["[option]Passives"][input]] + [theList[input][1]] > [theList[input][2]]"
        if(vars["[option]Passives"][input] + theList[input][1] > theList[input][2])
            return FALSE
        vars["[option]Passives"][input] += theList[input][1]
    else
        vars["[option]Passives"][input] = theList[input][1]
    world<<vars["[option]Passives"][input]


/datum/DemonRacials/proc/applyDebuffs(mob/p, mob/a)
    for(var/x in DebuffPassives)
        if(x in list("Def", "End", "Str"))
            if(p.vars["[x]Eroded"]<=DebuffPassives[x]/5)
                p.vars["[x]Eroded"]+=0.005
        else if(x in list("Poison", "Burn", "Slow"))
            call(p, "Add[x]")(DebuffPassives[x]/3, a)
        else
            call(p, "Lose[x]")(DebuffPassives[x]/10)


/datum/DemonRacials/proc/selectPassive(mob/p, type, option)
    p << "Listing [option] Passives"
    p << jointext(vars["[option]Passives"], " ,")
    var/list/passives =  getJSONInfo(getPassiveTier(p),"[type]")
    var/list/choices = list()
    for(var/a in passives)
        choices += "[a]"
    var/input = input(p, "What do you want to add to your [option] passives?") in choices
    var/correct = FALSE
    var/attempts = 0
    while(correct == FALSE)
        if(attempts >=3)
            p << "You tried to omany times, alert an admin"
            break
        if(!handlePassive(passives, input, option))
            p << "Too much passive value"
            correct = FALSE // have them go again
        else
            correct = TRUE
        attempts++
            