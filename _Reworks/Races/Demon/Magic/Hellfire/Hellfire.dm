/obj/Skills/Projectile/Magic/HellFire/Hellpyre
    var/list/scalingValues = list("Blasts" = list(1,1,2,2,3), "DamageMult" = list(10,15,15,20,20), \
    )
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
    AccMult = 3
    Speed = 0.75
    Cooldown = 120
    ActiveMessage = "unleashes a wave of Fire!"
    ManaCost = 1
    Delay = 8
    CorruptionGain = 1
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        if(p.isRace(DEMON))
            DarknessFlame = asc + round(p.Potential/15)
            Scorching = asc * 10
        else
            DarknessFlame = round(p.Potential/15)
            Burning = asc * 5
        DamageMult = (DamageMult / MultiHit) / Blasts
    proc/Hellpyre()
        set category = "Skills"
        adjust(usr)
        usr.UseProjectile(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm
    ElementalClass="Fire"
    var/scalingValues = list("Damage" = list(0.08,0.1,0.1,0.1,0.2), "Distance" = list(8,12,15,20,30), \
    "DarknessFlame" = list(3,8,12,15,20), "Slow" = list(3,6,8,12,20), "Burning" = list(10,15,20,25,30,50), "Duration" = list(150,200,300,350,400), \
    "Adapt" = list(1,1,1,1,1), "CorruptionGain" = list(1,1,1,1,1) )
    makSpace = new/spaceMaker/HellFire
    var/icon_to_use = 'LavaRock2.dmi'
    Cooldown=90
    ManaCost = 15
    TimerLimit = 10
    EndYourself=1
    ActiveMessage = "rains down an onslaught of fire!"
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        makSpace.toDeath = scalingValues["Duration"][asc]
        makSpace.range = scalingValues["Distance"][asc]
        makSpace.configuration = "Fill"
        makSpace.getDmg(p, src)
    verb/HellStorm()
        set category = "Skills"
        src.Trigger(usr)
    Trigger(mob/User, Override = 0)
        adjust(User)
        if(!User.BuffOn(src) && cooldown_remaining <= 0)
            if(..())
                makSpace.makeSpace(User, src)
    proc/applyEffects(mob/target, mob/owner, static_damage)

        var/asc = owner.AscensionsAcquired ? owner.AscensionsAcquired : 1
        for(var/x in scalingValues)
            switch(x)
                if("Damage")
                    static_damage *= scalingValues[x][asc]
                    owner.DoDamage(target, static_damage, 0, 0 , 0 , 0 , 0 , 0 , 0)
                    if("CorruptionGain" in scalingValues)
                        owner.gainCorruption(static_damage / 2)
                if("DarknessFlame")
                    target.AddPoison(scalingValues["Burning"][asc] * 1 + (scalingValues[x][asc] * 0.25), Attacker=owner)
                if("Burning")
                    target.AddBurn(scalingValues[x][asc])
                if("Slow")
                    target.AddSlow(scalingValues[x][asc])
                    target.AddCrippling(scalingValues[x][asc]/2)





/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat
    ElementalClass="Fire"
    var/scalingValues = list("SlowAffected" = list(5,10,10,20,25), "CrippleAffected" = list(5,10,10,20,25), \
    "PoisonAffected" = list(10,15,20,25,30), "BurnAffected" = list(10,15,20,25,30))
    ManaCost=10
    EndYourself=1
    AffectTarget=1
    Range=10
    SlowAffected=10
    CrippleAffected=10
    PoisonAffected = 10
    BurnAffected = 10
    Cooldown = 60
    ActiveMessage = "swells fire within their target."
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
