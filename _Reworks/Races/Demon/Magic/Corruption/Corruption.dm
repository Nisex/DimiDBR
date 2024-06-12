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
    CorruptionCost = 25
    Cooldown = -1
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in Upgrades)
            vars[x] = Upgrades[x][asc]


    verb/Corrupt_Reality()
        set category = "Skills"
        adjust(usr)
        ManaCost = usr.ManaAmount
        DamageMult = 5 + (ManaCost * DamageMult)
        usr.Activate(src)


/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Space
    makSpace = new/spaceMaker/Demon
    Cooldown = -1
    TimerLimit = 300
    CorruptionCost = 25
    scalingValues = list("toDeath" = list(300,600,900,1200,1200), "range" = list(5,8,10,12,20))
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        makSpace.configuration = "Fill"
        for(var/variable in scalingValues)
            makSpace.vars[variable] = scalingValues[variable][asc]
        passives = p.demon.BuffPassives
        TimerLimit = scalingValues["toDeath"][asc]
    Trigger(mob/User, Override)
        adjust(User)
        if(!User.BuffOn(src) && cooldown_remaining <= 0)
            if(User.Corruption - CorruptionCost < 0)
                User << "Not enough corruption"
                return
            else
                User.Corruption -= CorruptionCost
                makSpace.makeSpace(User, User.demon)
            ..()



/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Time
    var/timer = list(45, 60, 90 , 120, 120)
    CorruptionCost = 25
    Cooldown = -1
    Trigger(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        var/image/i = image('Caja.dmi')
        world<<i
        missile(i,p,p.Target)
        sleep(10)
        i.loc=p.Target.loc
        i.icon_state="Active"
        p.Target.density=0
        p.Target.Grabbable=0
        p.Target.Incorporeal=1
        p.Target.invisibility=90
        p.Target.Stasis=timer[asc]
        p.Target.StasisSpace=1
        spawn()animate(p.Target.client, color = list(-1,0,0, 0,-1,0, 0,0,-1, 0,1,1), time = 5)
        OMsg(usr, "[usr] locks [usr.Target] in an isolated space!")
        spawn(1200)
            del i
        Cooldown(1, null, p)


/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Self
    Cooldown = -1


    adjust(mob/p)
        var/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon/d = p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon/)
        if(!d)
            p << "Error in setting up Corrupt Self pls gmhelp"

        passives = d.passives.Copy()
        // put it on cd
    verb/Impose_Will()
        set category = "Skills"
        set desc = "Bring forth your true form without alerting others."

    Trigger(mob/User, Override)
        ..()
        var/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon/d = User.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon/)
        if(User.BuffOn(src))
            if(User.BuffOn(d))
                d.Trigger(User, 1)
                // jump out of true form
            d.Cooldown()