/obj/Skills/Projectile/Magic/HellFire/Hellpyre
    scalingValues = list("Blasts" = list(4,5,6,6,8,10), "DamageMult" = list(10,12,13,15,18,20), \
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
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired + 1 : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        if(p.isRace(DEMON))
            Homing = 1
            DarknessFlame = asc + round(p.Potential/15)
            Scorching = asc * 10
        else
            DarknessFlame = round(p.Potential/15)
            Burning = asc * 5
        DamageMult = (DamageMult / MultiHit) / Blasts
    verb/Hellpyre()
        set category = "Skills"
        adjust(usr)
        usr.UseProjectile(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm
    ElementalClass="Fire"
    scalingValues = list("Damage" = list(0.2,0.3,0.4,0.6,0.6), "Distance" = list(6,9,12,12,15,18), \
    "DarknessFlame" = list(3,8,12,15,20,25), "Slow" = list(3,6,8,12,15,20), "Burning" = list(10,15,20,25,30,30), "Duration" = list(150,200,300,350,400,600), \
    "Adapt" = list(1,1,1,1,1), "CorruptionGain" = list(1,1,1,1,1) )
    makSpace = new/spaceMaker/HellFire
    var/icon_to_use = 'LavaRock2.dmi'
    Cooldown=90
    ManaCost = 8
    TimerLimit = 10
    EndYourself=1
    ActiveMessage = "rains down an onslaught of fire!"
    adjust(mob/p)
        scalingValues = /obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm::scalingValues
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        makSpace.toDeath = scalingValues["Duration"][asc]
        makSpace.range = scalingValues["Distance"][asc]
        makSpace.configuration = "Fill"
        makSpace.getDmg(p, src)
    verb/HellStorm()
        set category = "Skills"
        src.Trigger(usr)
    Trigger(mob/User, Override = 0)
        . = 1
        adjust(User)
        var/aaa = ..()
        if(aaa)
            makSpace.makeSpace(User, src)
            . = aaa
    proc/applyEffects(mob/target, mob/owner, static_damage)
        if(!owner||!target) return
        var/asc = owner.AscensionsAcquired ? owner.AscensionsAcquired : 1
        for(var/x in scalingValues)
            switch(x)
                if("Damage")
                    static_damage *= scalingValues[x][asc]
                    owner.DoDamage(target, static_damage, 0, 0 , 0 , 0 , 0 , 0 , 0)
                    owner.gainCorruption((static_damage * 1.25) * glob.CORRUPTION_GAIN)
                if("DarknessFlame")
                    target.AddPoison(scalingValues["Burning"][asc] * 1 + (scalingValues[x][asc] * 0.5), Attacker=owner)
                if("Burning")
                    target.AddBurn(scalingValues[x][asc])
                if("Slow")
                    target.AddCrippling(scalingValues[x][asc])
        if(!target:move_disabled)
            if(prob(25))
                target:move_disabled = TRUE
                spawn(10)
                    target:move_disabled = FALSE





/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat
    ElementalClass="Fire"
    scalingValues = list("CrippleAffected" = list(12,15,15,20,25,25), \
    "PoisonAffected" = list(15,20,20,25,30,30), "BurnAffected" = list(15,20,20,25,30,30), "ConfuseAffected" = list(15, 20, 20 ,25, 30,30))
    ManaCost=5
    EndYourself=1
    AffectTarget=1
    Range=10
    SlowAffected=10
    CrippleAffected=10
    PoisonAffected = 10
    BurnAffected = 10
    Cooldown = 60
    ActiveMessage = "swells fire within their target."
    proc/returnToInit()
        if(!altered)
            scalingValues = /obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat::scalingValues
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
