/obj/Skills/Projectile
    var/takeAppearance = FALSE

    Secret_Knives
        AdaptRate=1
        Blasts=4
        DamageMult=0.25
        AccMult=1
        AttackReplace=1
        ZoneAttack=1
        Distance=30
        Homing=1
        HomingCharge=3
        HomingDelay=1
        HyperHoming=1
        Striking=1
        Instinct=1
        ZoneAttackX=5
        ZoneAttackY=5
        FireFromEnemy=0
        FireFromSelf=1
        Hover=8
        IconLock='CheckmateKnives.dmi'
        Variation=8
        FlickBlast=0
        Cooldown=3
        adjust(mob/p)
            Blasts = rand(5,8)
            DamageMult = 0.15
            Cooldown = rand(6,9)
            if((p.UBWPath == "Firm" && p.SagaLevel >=3))
                Blasts = rand(2 + p.SagaLevel, 8 + p.SagaLevel)
                DamageMult = rand(0.1 + (p.SagaLevel * 0.05), 0.15 + (p.SagaLevel * 0.05))
                Cooldown = rand(7,12) - p.SagaLevel

    FTG
        AdaptRate=1
        Blasts=8
        DamageMult=0.25
        AccMult=1.5
        AttackReplace=1
        ZoneAttack=1
        Distance=30
        Homing=1
        HomingCharge=2
        HomingDelay=0.5
        HyperHoming=1
        Striking=1
        Instinct=2
        ZoneAttackX=8
        ZoneAttackY=8
        FireFromEnemy=0
        FireFromSelf=1
        Hover=6
        IconLock='CheckmateKnives.dmi'
        Variation=8
        FlickBlast=0
        Cooldown=3
        takeAppearance = TRUE
        adjust(mob/p)


    Murder_Music
        AttackReplace=1
        ZoneAttack=1
        Distance=30
        StrRate=1
        ForRate=1
        Crippling=0.5
        Blasts=5
        DamageMult=0.5
        HyperHoming=1
        AccMult=2
        Homing=1
        HomingCharge=3
        HomingDelay=1
        Striking=1
        Instinct=1
        ZoneAttackX=5
        ZoneAttackY=5
        FireFromEnemy=0
        FireFromSelf=1
        Hover=5
        IconLock='CheckmateKnives.dmi'
        Variation=8
        FlickBlast=0
        Cooldown=4
    Warsong
        AttackReplace=1
        Distance=30
        StrRate=1
        ForRate=1
        Crippling=1
        Blasts=1
        DamageMult=0.75
        HyperHoming=1
        AccMult=2
        Homing=1
        HomingCharge=1
        HomingDelay=5
        Piercing=1
        Striking=1
        Instinct=1
        IconLock='Arrow - Flare.dmi'
        IconSize=1
        Trail='Trail - Flare.dmi'
        TrailSize=1
        Variation=4
        FlickBlast=0
    Warsong_Finale
        Distance=50
        ZoneAttack=1
        ZoneAttackX=10
        ZoneAttackY=10
        FireFromSelf=0
        FireFromEnemy=1
        Hover=10
        StrRate=1
        ForRate=1
        Blasts=20
        DamageMult=0.5
        HyperHoming=1
        AccMult = 1.25
        Homing=1
        HomingCharge=3
        HomingDelay=5
        Piercing=1
        Striking=1
        Instinct=1
        IconLock='Arrow - Flare.dmi'
        IconSize=1
        Trail='Trail - Flare.dmi'
        TrailSize=1
        Variation=4
        FlickBlast=0