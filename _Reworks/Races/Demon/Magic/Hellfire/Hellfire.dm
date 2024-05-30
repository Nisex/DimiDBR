/obj/Skills/Projectile/Magic/HellFire/Hellpyre
    var/list/scalingValues = list("Blasts" = list(1,1,2,2,3), "DamageMult" = list(10,15,15,20,20), \
    )
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
    var/scalingValues = list("Rounds" = list(10,15,20,25,30), "DamageMult" = list(0.05,0.05,0.1,0.1,0.2), "Distance" = list(10,10,20,25,25), \
    "DarknessFlame" = list(5,10,15,20,30), "ApplySlow" = list(3,6,8,12,20), "Burning" = list(10,15,20,25,30,50))
    Area="Circle"
    AdaptRate = 1
    Rounds = 10
    NoLock=1
    NoAttackLock=1
    DamageMult=0.05
    Distance=10
    Slow=100
    SpecialAttack = 1 
    Icon='BloodRain.dmi'
    TurfStrike=1
    TurfShift='BurnedGround.dmi'
    TurfShiftDuration=180
    Cooldown=10
    proc/adjust(mob/p)
        var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
        for(var/x in scalingValues)
            vars[x] = scalingValues[x][asc]
        Size = Distance
    verb/TestHellStorm()
        set category = "Skills"
        adjust(usr)
        usr.Activate(src)