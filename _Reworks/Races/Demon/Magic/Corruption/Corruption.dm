/obj/Skills/AutoHit/Magic/Corruption/Corrupt_Reality
    var/list/Upgrades = list("Primordial" = list(0.25,0.5,1,1,2), "DamageMult" = list(0.05,0.1,0.2,0.25,0.4))
    Area= "Target"
    SpecialAttack=1
    AdaptRate = 1
    Distance = 10
    // Corrupt = 1
    CanBeBlocked=0
    CanBeDodged=0
    EndDefense = 0.0001
    Bang = 3
    proc/adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in Upgrades)
            vars[x] = Upgrades[x][asc]


    verb/Corrupt_Reality()
        set category = "Skills"
        adjust(usr)
        ManaCost = usr.ManaAmount
        DamageMult = 5 + (ManaCost * DamageMult)
        
        usr.Activate(src)