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
    ActiveMessage = "unleashes a wave of Hell Fire!"
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

/obj/Skills/AutoHit/Magic/HellFire/Hellstorm
    ElementalClass="Fire"
    var/scalingValues = list("DamageMult" = list(0.05,0.05,0.1,0.1,0.2), "Distance" = list(5,10,10,15,20), \
    "DarknessFlame" = list(5,10,15,20,30), "ApplySlow" = list(3,6,8,12,20), "Burning" = list(10,15,20,25,30,50), "Duration" = list(100,150,200,250,300) )
    Area="Circle"
    Persistent = 1
    CorruptionGain = 1
    AdaptRate = 1
    NoLock=1
    NoAttackLock=1
    DamageMult=0.05
    Distance=10
    Duration = 10
    SpecialAttack = 1 
    TurfStrike=1
    TurfShift='BurnedGround.dmi'
    TurfShiftDuration=180
    Cooldown=90
    ManaCost = 15
    IgnoreAlreadyHit = 1
    CorruptionGain = 1
    ActiveMessage = "rains down an onslaught of hellfire!"
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        TurfShiftDuration = Duration
        Size = Distance
    verb/TestHellStorm()
        set category = "Skills"
        adjust(usr)
        usr.Activate(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat
    ElementalClass="Fire"
    var/scalingValues = list("SlowAffected" = list(10,15,20,25,30), "CrippleAffected" = list(10,15,20,25,30), \
    "PoisonAffected" = list(10,15,20,25,30), "BurnAffected" = list(10,15,20,25,30))
    ManaCost=10
    EndYourself=1
    AffectTarget=1
    Range=10
    SlowAffected=10
    CrippleAffected=10
    PoisonAffected = 10
    BurnAffected = 10
    ActiveMessage = "swells hellfire within their target."
    adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
