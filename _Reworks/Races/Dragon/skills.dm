/obj/Skills/AutoHit/Dragon_Roar
    Area="Circle"
    AdaptRate=1
    DamageMult=0.1
    Rounds=1
    TurfDirt=1
    FlickAttack=1
    ShockIcon='KenShockwave.dmi'
    Shockwave=12
    Shockwaves=1
    PostShockwave=1
    PreShockwave=0
    Cooldown=180
    Earthshaking=20
    Instinct=1
    WindupMessage="ROARRRR"
    ActiveMessage="ROARRRSSS"
    adjust(mob/p)
        var/asc = p.AscensionsAcquired
        Crippling = 10
        Shearing = 5
        Shattering = 5
        switch(p.Class)
            if("Wind")
                Knockback = 0.25
                Distance = 12 + (asc * 5)
                Shocking = 12 + (8 * asc)
                DamageMult = 6 + (asc * 3)
                Rounds = 8 + (asc * 2)
                DamageMult = DamageMult/Rounds
            if("Fire")
                Distance = 5 + (asc * 2)
                Scorching = 8 + (8 * asc)
                DamageMult = 8 + (asc * 2)
                Rounds = 4 + (asc * 1)
                DamageMult = DamageMult/Rounds
    verb/Dragon_Roar()
        set category="Skills"
        adjust(usr)
        usr.Activate(src)