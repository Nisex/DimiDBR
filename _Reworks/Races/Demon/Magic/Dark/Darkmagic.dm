
/obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball
    scalingValues = list("MultiShot" = list(2,3,3,4,4), "DamageMult" = list(3,3,4,4,5), "EndRate" = list(0.85, 0.75, 0.65, 0.55, 0.45), "IconSize" = list(1, 1.15,1.25,1.5,2))
    MultiShot = 2
    DamageMult = 3
    AdaptRate = 1
    IconLock='shadowflameball.dmi'
    Trail='shadowfire.dmi'
    TrailDuration=30
    TrailSize=1
    TrailX=-8
    TrailY=-8
    AccMult = 3
    Speed = 1.25
    Cooldown = 30
    ManaCost = 5
    Deviation = 240
    Cooldown = 120
    CorruptionGain = 1
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        if(p.getTotalMagicLevel() >= 10 && p.isRace(DEMON))
            Homing = 1
            Speed = 0.75
    proc/Shadow_Ball()
        set category = "Skills"
        adjust(usr)
        usr.UseProjectile(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind
    var/corruptionGain = list(5,5,8,8,10)
    Range = 25
    ManaCost = 15
    AffectTarget = 1
    Cooldown = 60
    TimerLimit = 10
    applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    adjust(mob/p)
        if(p.isRace(DEMON) && applyToTarget.type != /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon)
            applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon

    Trigger(var/mob/User, Override=0)
        if(!altered)
            adjust(User)
            applyToTarget?:adjust(User)
        if(..())
            if(User.isRace(DEMON))
                var/asc = User.AscensionsAcquired
                if(asc < 1)
                    asc = 1
                User.gainCorruption(corruptionGain[asc])
            . = 1
/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    BuffName = "Dominate Mind Applied"
    MagicNeeded = 0
    StunAffected = 10
    InstantAffect = 1
    TimerLimit = 10
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 0
        var/list/timers = list(2,3,3,4,4)
        if(asc == 0)
            TimerLimit = 2
        else
            TimerLimit = timers[asc]



/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon
    BuffName = "Mind Dominated"

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech
    scalingValues = list("TimerLimit" = list(12,10,8,5,5), "ManaHeal" = list(5,10,15,20,25), "HealthHeal" = list(1,1,2,2,3), "EnergyHeal" = list(2,4,8,10,10))
    Cooldown = 90
    StableHeal = 1
    applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech_Apply
    Trigger(var/mob/User, Override=0)
        if(!altered)
            if(!applyToTarget)
                applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech_Apply
            adjust(User)
            applyToTarget?:adjust(User)
        . = ..()
    adjust(mob/p)
        scalingValues = /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech::scalingValues
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        ManaHeal = (ManaHeal / TimerLimit) * world.tick_lag
        HealthHeal = (HealthHeal / TimerLimit) * world.tick_lag
        EnergyHeal = (EnergyHeal / TimerLimit) * world.tick_lag
    
    verb/Soul_Leech()
        set category = "Skills"
        if(!altered)
            adjust(usr)
            Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech_Apply
    scalingValues = list("TimerLimit" = list(12,10,8,5,5), "ManaHeal" = list(-5,-10,-15,-20,-25), "HealthHeal" = list(-1,-1,-2,-2,-3), "EnergyHeal" = list(-2,-4,-8,-10,-10))
    StableHeal = 1
    DeleteOnRemove = 1
    Cooldown = 0
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        ManaHeal = (ManaHeal / TimerLimit) * world.tick_lag
        HealthHeal = (HealthHeal / TimerLimit) * world.tick_lag
        EnergyHeal = (EnergyHeal / TimerLimit) * world.tick_lag
    Trigger(mob/User, Override = 0 )
        var/aa = ..()
        if(aa)
            User.SlotlessBuffs.Add(src)
        . = 1
        