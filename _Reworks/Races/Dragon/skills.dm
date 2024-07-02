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
    ComboMaster = 1
    adjust(mob/p)
        var/asc = p.AscensionsAcquired
        Crippling = 10
        Shearing = 5
        Shattering = 5
        switch(p.Class)
            if("Wind")
                Knockback = 0.25
                Distance = 8 + (asc * 5)
                Paralyzing = 8 + (8 * asc)
                DamageMult = 6 + (asc * 1)
                Rounds = 8 + (asc * 2)
                DamageMult = DamageMult/Rounds
            if("Fire")
                Distance = 5 + (asc * 2)
                Scorching = 8 + (8 * asc)
                DamageMult = 8 + (asc * 1)
                Rounds = 4 + (asc * 1)
                DamageMult = DamageMult/Rounds
                PullIn = Distance / 2
            if("Metal")
                Distance = 5 + (asc * 2)
                Shattering = 3 + (3 * asc)
                Crippling = 8 + (8 * asc)
                EndDefense = 0.9 - (0.1 * asc)
                DamageMult = 5 + (asc * 1)
                Rounds = 3 + (asc * 2)
                DamageMult = DamageMult/Rounds
                PullIn = Distance / 2
            if("Water")
                ElementalClass="Water"
                Distance = 10 + (asc * 2)
                PullIn = Distance + (4 * asc)
                Deluge = (300 + (300 * asc)) // 30 seconds + 30 each as
                DamageMult = 12 + (asc * 1)
                NoLock = 1
                WindUp=0.25
                WindupMessage="brings forth the rain..."
                ActiveMessage="swarms the area with a flood!"
                TurfReplace='PlainWater.dmi'
                Area="Circle"
				SpecialAttack=1
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				TurfStrike=1
    verb/Dragon_Roar()
        set category="Skills"
        adjust(usr)
        usr.Activate(src)