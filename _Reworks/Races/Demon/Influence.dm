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
        . = jsonData["[type]_[x]"]
        world<<jointext(x, " , ")
    world<<jointext(., " | ")

/mob/verb/demonRacialTest()
    var/datum/DemonRacials/dr = new()
    AscensionsAcquired = 5
    dr.selectPassive(src)

/datum/DemonRacials/proc/handlePassive(list/theList)

    return theList


/datum/DemonRacials/proc/selectPassive(mob/p)
    p << "Listing Buff Passives"
    p << jointext(BuffPassives, " ,")
    var/input = input(p, "What do you want to add to your buff passives?") in getJSONInfo(getPassiveTier(p),"CORRUPTION_PASSIVES")
    world<<jointext(input, " , ")
    world<<input
    handlePassive(input)
    BuffPassives.Add(input)
    