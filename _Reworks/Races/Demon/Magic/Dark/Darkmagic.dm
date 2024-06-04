
/obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball
    var/list/scalingValues = list("MultiShot" = list(2,3,3,4,4), "DamageMult" = list(3,3,4,4,5), "EndRate" = list(0.85, 0.75, 0.65, 0.55, 0.45), "IconSize" = list(1, 1.15,1.25,1.5,2))
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
            if(usr.isRace(DEMON))
                var/asc = usr.AscensionsAcquired
                if(asc < 1)
                    asc = 1
                usr.gainCorruption(corruptionGain[asc])
/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    BuffName = "Dominate Mind Applied"
    MagicNeeded = 0
    StunAffected = 10
    InstantAffect = 1
    TimerLimit = 10
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 0 
        var/list/timers = list(2,3,3,4,4)
        TimerLimit = timers[asc]
        


/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon
    BuffName = "Mind Dominated"

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech
    var/list/scalingValues = list("TimerLimit" = list(15,10,10,5,5), "ManaHeal" = list(15,20,20,30,30), "HealthHeal" = list(2,2,3,5,5), "EnergyHeal" = list(15,10,10,5,5))
    Cooldown = 90
    applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech_Apply
    Trigger(var/mob/User, Override=0)
        if(!altered)
            adjust(User)
            applyToTarget?:adjust(User)
        ..()
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        ManaHeal /= TimerLimit
        HealthHeal /= TimerLimit
        EnergyHeal /= TimerLimit
/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech_Apply
    var/list/scalingValues = list("TimerLimit" = list(15,10,10,5,5), "ManaHeal" = list(-15,-20,-20,-30,-30), "HealthHeal" = list(-2,-2,-3,-5,-5), "EnergyHeal" = list(-15,-10,-10,-5,-5))
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
            ManaHeal /= TimerLimit
            HealthHeal /= TimerLimit
            EnergyHeal /= TimerLimit