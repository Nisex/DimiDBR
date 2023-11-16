var/MANAOVERLOADMULT = 1
var/senjutsuOverloadAlert = FALSE
/mob/proc/diedFromSenjutsuOverload()
    if(Secret == "Senjutsu" && (CheckSlotless("Senjutsu Focus") || CheckSlotless("Sage Mode")))
        if(icon_state == "Meditate") return
        var/maxMana = ((ManaMax) * GetManaCapMult())
        if(ManaAmount > maxMana)
            if(senjutsuOverloadAlert == FALSE)
                senjutsuOverloadAlert = TRUE
                src << "You have drawn in too much natural energy and started to turn to stone!" 
            ManaDeath = 1
            return TRUE
    return FALSE


/mob/proc/getManaStatsBoon()
    var/manaStatPerc = GetManaStats() // 1 per tick
    var/maxStatBoon = 1.5
    var/baseBoon = 0.25 // 0.1 extra stat for 1 mana stat
    if(ManaMax >= 100 && manaStatPerc > 1 && Secret == "Senjutsu") // essentially senjutsu
        maxStatBoon = 4
    var/manaMissing = (ManaAmount / 100) 
    var/bonus = (baseBoon * manaMissing) * manaStatPerc >= maxStatBoon ? maxStatBoon : (baseBoon * manaMissing) * manaStatPerc
    return bonus


    /*
    
    Notes for potential boons for sage mode
    In the case that the max boon w/ generic manastats is instead 1.5, Then make the max boon for sage mode to be 3

    In all normal cases ManaStats is given 0.2 per ascension for races, which have a max of 5 typically
    So, a race can only get 1 max manastats, whereas sagemode could get 3 max manastats
    if a sagemode user is a race with manastats and max sagemode they would have 4 max manastats, this will be our extreme case of sagemode
    our average case of sagemode will be 3 max manastats

    now, our average mana stats user would have 1 max manastats
    a sagemode user at tier 4 would have 3 manastats, + 1 from racial boons, and 25 * 4 = 100 extra mana and a max mana of 300
    300 / 100 = 3 mana missing
    3 mana missing * 0.2 = 0.6
    0.6 * 4 manastats = 2.4
    2.4 < 3

    this accounts for absolute late game, max they can be, below will outline a mid-game case





    mid-game = asc 3, secret tier 2 (2 manastats), 50 extra mana, with a max of 200 mana

    200 mana / 100 = 2 mana missing
    2 mana missing * 0.2 = 0.4
    0.4 * 2 manastats = 0.8
    0.8 < 1.5










    */