/obj/Skills/Projectile/Magic/HellFire/Hellpyre
    scalingValues = list("Blasts" = list(4,5,6,6,8,10), "DamageMult" = list(8,10,12,12,15,15), \
    "Delay" = list(8,4,3,2,1,1))
    ElementalClass="Fire"
    DamageMult = 3
    AdaptRate = 1
    IconLock='Fire Blessing.dmi'
    IconSize=3
    Trail='Aura_Fire_Small.dmi'
    MultiTrail = 1
    TrailDuration=5
    TrailSize=1
    TrailX=0
    MultiHit = 5
    TrailY=0
    AccMult = 1.125
    Speed = 0.75
    Cooldown = 90
    ActiveMessage = "unleashes a wave of Fire!"
    ManaCost = 5
    Delay = 8
    CorruptionGain = 1
    proc/returnToInit()
        if(!altered)
            scalingValues = /obj/Skills/Projectile/Magic/HellFire/Hellpyre::scalingValues
    adjust(mob/p)
        if(p.isRace(DEMON))
            scalingValues = list("Blasts" = list(4,5,6,6,8,10), "DamageMult" = list(2,3,4,4,4,4), \
    "Delay" = list(8,4,3,2,1,1))
        else
            scalingValues = /obj/Skills/Projectile/Magic/HellFire/Hellpyre::scalingValues
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired + 1 : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        if(p.isRace(DEMON))
            Homing = 1
            DarknessFlame = asc + round(p.Potential/15)
            Scorching = asc * 2
        else
            DarknessFlame = round(p.Potential/15)
            Scorching = asc * 5
        DamageMult = (DamageMult / MultiHit) / Blasts
    verb/Hellpyre()
        set category = "Skills"
        adjust(usr)
        usr.UseProjectile(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm
    ElementalClass="Fire"
    scalingValues = list("Damage" = list(0.2,0.3,0.3,0.4,0.6,0.8), "Distance" = list(6,9,12,12,15,18), \
    "DarknessFlame" = list(4,10,12,15,20,25), "Slow" = list(6,10,12,12,15,20), "Burning" = list(5,8,10,15,20,20), "Duration" = list(200,300,300,350,400,600), \
    "Adapt" = list(1,1,1,1,1), "CorruptionGain" = list(1,1,1,1,1) )
    makSpace = new/spaceMaker/HellFire
    var/icon_to_use = 'Flaming Rain.dmi'
    var/states_to_use = list("","1")
    var/layer_to_use = MOB_LAYER+0.1
    Cooldown=90
    ManaCost = 8
    TimerLimit = 10
    EndYourself=1
    ActiveMessage = "rains down an onslaught of fire!"
    adjust(mob/p)
        scalingValues = /obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm::scalingValues
        if(p.isRace(DEMON))
            scalingValues = list("Damage" = list(0.05,0.05,0.1,0.1,0.2,0.3), "Distance" = list(3,4,6,8,12,15), \
            "DarknessFlame" = list(1,2,4,6,8,10), "Slow" = list(1,2,4,6,8,10), "Burning" = list(1,3,4,6,8,10), "Duration" = list(100,150,200,200,200,200), \
            "Adapt" = list(1,1,1,1,1), "CorruptionGain" = list(1,1,1,1,1) )
        else
            scalingValues = /obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm::scalingValues
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired + 1 : 1
        makSpace.toDeath = scalingValues["Duration"][asc]
        makSpace.range = scalingValues["Distance"][asc]
        makSpace.configuration = "Fill"
        makSpace.getDmg(p, src)
    verb/HellStorm()
        set category = "Skills"
        adjust(usr)
        src.Trigger(usr)
    Trigger(mob/User, Override = 0)
        . = 1
        adjust(User)
        var/aaa = ..()
        if(aaa && !User.BuffOn(src))
            makSpace.makeSpace(User, src)
            . = aaa
    proc/applyEffects(mob/target, mob/owner, static_damage)
        if(!owner||!target) return
        var/asc = owner.AscensionsAcquired ? owner.AscensionsAcquired + 1 : 1
        for(var/x in scalingValues)
            switch(x)
                if("Damage")
                    static_damage *= scalingValues[x][asc]
                    owner.DoDamage(target, static_damage, 0, 0 , 0 , 0 , 0 , 0 , 0)
                    owner.gainCorruption((static_damage * 1.25) * glob.CORRUPTION_GAIN)
                if("DarknessFlame")
                    target.AddPoison(scalingValues["Burning"][asc] * 1 + (scalingValues[x][asc] * 0.33), Attacker=owner)
                if("Burning")
                    target.AddBurn(scalingValues[x][asc])
                if("Slow")
                    target.AddCrippling(scalingValues[x][asc])
        if(!target:move_disabled)
            if(prob(5*asc))
                target:move_disabled = TRUE
                spawn(3*asc)
                    target:move_disabled = FALSE





/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat
    ElementalClass="Fire"
    scalingValues = list("CrippleAffected" = list(12,15,15,20,25,25), \
    "PoisonAffected" = list(6,12,15,20,25,30), "BurnAffected" = list(6,12,15,20,25,30), "ConfuseAffected" = list(8,12,15,15,20,25), \
    "TimerLimit" = list(3,6,10,15,20,25))
    ManaCost=5
    AffectTarget=1
    Range=10
    CrippleAffected=10
    PoisonAffected = 10
    ConfuseAffected = 1
    BurnAffected = 10
    TimerLimit = 5
    Cooldown = 60
    ActiveMessage = "swells fire within their target."
    proc/returnToInit()
        if(!altered)
            scalingValues = list("CrippleAffected" = list(12,15,15,20,25,25), \
    "PoisonAffected" = list(6,12,15,20,25,30), "BurnAffected" = list(6,12,15,20,25,30), "ConfuseAffected" = list(8,12,15,15,20,25), \
    "TimerLimit" = list(3,6,10,15,20,25))
    
    adjust(mob/p)
        if(p.isRace(DEMON))
            scalingValues = list("CrippleAffected" = list(2,3,4,4,4,4), \
    "PoisonAffected" = list(2,3,4,6,8,10), "BurnAffected" = list(2,3,4,6,8,10), "ConfuseAffected" = list(2,3,4,6,8,10), \
    "TimerLimit" = list(3,6,10,15,20,25))
        else
            scalingValues = list("CrippleAffected" = list(12,15,15,20,25,25), "PoisonAffected" = list(6,12,15,20,25,30), "BurnAffected" = list(6,12,15,20,25,30), "ConfuseAffected" = list(2,4,6,8,10,10), "TimerLimit" = list(3,6,10,15,20,25))

        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired + 1 : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
    Trigger(mob/User, Override)
        adjust(User)
        ..()
        
