/datum/DemonRacials


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
    if(vars["[option]Passives"][input] + theList[input][1] > theList[input][2])
        return FALSE
    vars["[option]Passives"][input] += theList[input][1]


/datum/DemonRacials/proc/selectPassive(mob/p, type, option)
    p << "Listing [option] Passives"
    p << jointext(vars["[option]Passives"], " ,")
    var/list/passives =  getJSONInfo(getPassiveTier(p),"[type]")
    var/list/choices = list()
    for(var/a in passives)
        choices += "[a]"
    var/input = input(p, "What do you want to add to your [option] passives?") in choices
    if(!handlePassive(passives, input, option))
        p << "Too much sauce"
        return FALSE // have them go again
    return TRUE
            