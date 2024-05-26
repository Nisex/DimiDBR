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
