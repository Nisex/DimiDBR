/obj/Items/mineral
    var/value = 1
    Destructable = FALSE
    name = "Tower Fragments"
    icon='Crystal_Fragments.dmi'
    icon_state="1"
    Stealable = 1
    layer = 5
    var/owner = null
    DropItem()
        set name = "Drop Item"
        if(!(world.time > usr.verb_delay)) return
        usr.verb_delay = world.time+1
        if((src in usr))
            var/Amount = input("Drop how much? (1-[src.value])") as num
            Amount = round(Amount)
            if(Amount>value) Amount = value
            if(Amount<1) Amount = 1
            Drop(Amount, usr)
    proc/Reduce(num)
        value -= num
        name = "[Commas(round(value,1))] Tower Fragments"
        if(value <= 0)
            del(src)
    proc/assignState(val)
        if(val <= 200)
            return icon_state = "some"
        if(val <= 400 && val > 200)
            return icon_state = "few"
        if(val <= 1#INF && val > 400)
            return icon_state = "lot"

    Drop(num, mob/p)
        var/obj/Items/mineral/mineral = new()
        mineral.value = num
        mineral.name = "[Commas(round(num))] Tower Fragments"
        mineral.loc = get_step(p, p.dir)
        mineral.icon_state = assignState(mineral.value)
        Reduce(num)
        
#define PLAYER_EXCHANGE_RATE 6
#define NPC_EXCHANGE_RATE 2

// we need an npc that when clicked will exchange these
// we also need an exchange for the player that can do it
/mob/Admin4/verb/GiveExchangeVerb()
    
    var/mob/p = input(src, "Pick a player", "Player") in players
    p.verbs += /mob/proc/ExchangeMinerals

/mob/Admin4/verb/makeExchanger()
    var/obj/Exchange/npc/exchanger = new()
    exchanger.loc = get_step(src, src.dir)
    exchanger << "You have created an exchanger."



/mob/proc/ExchangeMinerals()
    set name = "Exchange Tower Fragments"
    set category = "Roleplay"
    var/obj/Items/mineral/found = FALSE
    for(var/obj/Items/mineral/m in usr)
        if(m.type == /obj/Items/mineral)
            found = m
            break
    if(!found)
        usr << "You don't have any Tower Fragments to exchange."
        return
    exchangeMineral(found, usr, FALSE)


/mob/proc/HasFragments(cost)
    for(var/obj/Items/mineral/m in usr)
        if(m.type == /obj/Items/mineral)
            if(m.value >= cost)
                return TRUE
    return FALSE

/mob/proc/TakeFragments(cost)
    for(var/obj/Items/mineral/m in usr)
        if(m.type == /obj/Items/mineral)
            if(m.value >= cost)
                m.Reduce(cost)



/proc/exchangeMineral(obj/Items/mineral/mineral, mob/p, obj/Exchange/npc/npc)
    var/howMany = input(p, "How many would you like to exchange?") as num
    if(howMany > mineral.value) howMany = mineral.value
    if(howMany < 1) howMany = 1
    if(npc)
        npc.Replenish() // check to see if a day has passed to replenish the npc
        if(npc.bank < howMany * NPC_EXCHANGE_RATE)
            p << "The npc doesn't have enough Dollars to exchange."
            return
        else
            npc.bank -= howMany * NPC_EXCHANGE_RATE
            p << "You exchange [howMany] Tower Fragments for [howMany * NPC_EXCHANGE_RATE] Dollars."
            p.GiveMoney(howMany * NPC_EXCHANGE_RATE)
    else
        var/exchangeRate = getExchangeRate(p.information.faction)
        p.GiveMoney(howMany * exchangeRate)
        p << "You exchange [howMany] Tower Fragments for [howMany * exchangeRate] Dollars."
    mineral.Reduce(howMany)
    if(mineral.value <= 0)
        del(mineral)

/obj/Exchange/npc
    Attackable = FALSE
    Grabbable = FALSE
    var/bank = 100000
    var/lastReplenish = 0
    icon = 'Silver.dmi'
    
    Click()
        var/obj/Items/mineral/found = FALSE
        for(var/obj/Items/mineral/m in usr)
            if(m.type == /obj/Items/mineral)
                found = m
                break
        if(!found)
            usr << "You don't have any Tower Fragments to exchange."
            return
        exchangeMineral(found, usr, src)

    proc/Replenish()
        if(lastReplenish + 24 HOURS < world.time)
            lastReplenish = world.time
            var/postTenBoon = glob.progress.DaysOfWipe > 10 ? 1 : 0 
            var/extraValue
            var/replenishValue = 100000 * glob.progress.DaysOfWipe
            if(postTenBoon)
                extraValue = 150000 * round(glob.progress.DaysOfWipe/10)
            else
                extraValue = 0
            bank = replenishValue + extraValue