/obj/Skills/Buffs/NuStyle/UnarmedStyle
    Heavenly_Demon_T3
        name = "Heavenly Demon's Chaotic Way of Shattered Realms"
        StyleActive = "Heavenly Demon's Chaotic Way of Shattered Realms"
        SignatureTechnique=3
        Copyable=0
        passives = list("Conductor" = 90, "Antsy" = 10, "CounterMaster" = 5, "SwordPunching" = 1, "NeedsSword" = 0, "NoSword" = 1)
        NeedsSword=0
        NoSword=1
        SwordPunching=1
        StyleStr=1
        StyleEnd=1
        StyleOff=1
        StyleDef=1
        StyleFor=1
        Finisher="/obj/Skills/Queue/Finisher/Cycle_of_Samsara"
    Jeet_Kune_Do
        SignatureTechnique=3

        verb/Jeet_Kune_Do()
            set hidden=1
            src.Trigger(usr)
    All_Star_Wrestling
        SignatureTechnique=3

        verb/All_Star_Wrestling()
            set hidden=1
            src.Trigger(usr)
    
    Flying_Thunder_God
        SignatureTechnique=3
        passives = list("Flying Thunder God" = 1) 
        // make it so every cooldown like iaido, also make the tracker appear on hud
        // make an animation for the tp
        verb/Flying_Thunder_God()
            set hidden=1
            src.Trigger(usr)




    North_Star_Style
        SignatureTechnique=3
        Copyable=0
        StyleStr=1.25
        StyleEnd=1.75
        ElementalClass="Earth"
        StyleActive="North Star"
        passives = list("HardStyle" = 3, "SoftStyle" = 3, "UnarmedDamage" = 3, "CounterMaster" = 5)
        HardStyle=3
        SoftStyle=3
        UnarmedDamage=3
        CounterMaster=5
        HitSpark='HitsparkStar.dmi'
        HitX=0
        HitY=0
        HitTurn=0
        Finisher="/obj/Skills/Queue/Finisher/Pressure_Point"
        verb/North_Star_Style()
            set hidden=1
            src.Trigger(usr)
    Imperial_Style
        SignatureTechnique=3
        Copyable=0
        StyleStr=1.5
        StyleFor=1.5
        ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
        ElementalOffense="Void"
        ElementalDefense="Void"
        passives = list("DarknessFlame" = 2, "UnarmedDamage" = 1, "SpiritHand" = 4, "Void" = 1)
        DarknessFlame=2
        UnarmedDamage=1
        SpiritHand=1
        Void=1
        name="Imperial Devil Style"
        StyleActive="Imperial Devil"
        Finisher="/obj/Skills/Queue/Finisher/Imperial_Assessment"
        verb/Imperial_Style()
            set hidden=1
            src.Trigger(usr)
    East_Star_Style
        SignatureTechnique=3
        Copyable=0
        StyleEnd=1.5
        StyleSpd=1.5
        passives = list("SoftStyle" = 3, "SoulFire" = 3, "CyberStigma" = 3, "CounterMaster" = 3, "VoidField" = 10, "DeathField" = 10)
        SoftStyle=3
        ManaSeal=3
        CyberStigma=3
        CounterMaster=3
        VoidField=10
        DeathField=10
        NoStaff = 0
        StyleActive="East Star"
        ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
        Finisher="/obj/Skills/Queue/Finisher/Over_The_Horizon"
        verb/East_Star_Style()
            set hidden=1
            src.Trigger(usr)
    Atomic_Karate_Style
        SignatureTechnique=3
        Copyable=0
        StyleStr=1.5
        StyleFor=1.5
        passives = list("SpiritHand" = 4, "SpiritFlow" = 1, "CyberStigma" = 4, "PureDamage" = 2, "PureReduction" = 2)
        NoStaff = 0
        SpiritHand=1
        SpiritFlow=1
        CyberStigma=3
        ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
        StyleActive="Atomic Karate"
        ElementalOffense="Ultima"
        ElementalDefense="Ultima"
        Finisher="/obj/Skills/Queue/Finisher/Atomic_Split"
        verb/Atomic_Karate_Style()
            set hidden=1
            src.Trigger(usr)