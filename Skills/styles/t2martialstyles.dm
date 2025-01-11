/obj/Skills/Buffs/NuStyle/UnarmedStyle
    Ubermensch_Style
        SignatureTechnique=2
        Copyable=0
        StyleEnd=1.3
        StyleStr=1.3
        passives = list("Muscle Power" = 4, "Grippy" = 5, "Scoop" = 2, "Iron Grip" = 1, "DeathField" = 3)
        StyleActive="Ubermensch"
        Finisher="/obj/Skills/Queue/Finisher/Command_Grab"
    Divine_Arts_of_The_Heavenly_Demon
        SignatureTechnique=2
        Copyable=0
        passives = list("Hardening" = 2, "Deflection" = 1, "Momentum" = 2, "Pressure" = 2, "SwordPunching" = 1, "NeedsSword" = 0, "NoSword" = 1)
        NeedsSword=0
        NoSword=1
        SwordPunching=1
        StyleStr=1.3
        StyleEnd=1.3
        StyleActive="Divine Arts of The Heavenly Demon"
        Finisher="/obj/Skills/Queue/Finisher/Divine_Finisher"
        verb/Divine_Arts_of_The_Heavenly_Demon_Style()
            set hidden=1
            src.Trigger(usr)
    Iron_Fist_Style
        passives = list("Deflection" = 2, "HardStyle" = 2, "HeavyHitter"= 0.5)
        StyleStr=1.3
        StyleOff=1.3
        SignatureTechnique=2
        Copyable=0
        StyleActive="Iron Fist Style"
        Finisher="/obj/Skills/Queue/Finisher/Chi_Punch"
        verb/Iron_Fist_Style()
            set hidden=1
            src.Trigger(usr)
    Long_Fist_Style
        passives = list("Fa Jin" = 2, "Gum Gum" = 1, "Acupuncture" = 1.5, "Flow" = 2, \
                        "Momentum" = 1.5, "Hardening" = 1.5, "Pressure" = 1)
        StyleEnd=1.3
        StyleOff=1.15
        StyleDef=1.15
        SignatureTechnique=2
        Copyable=0
        StyleActive="Long Fist Style"
        Finisher="/obj/Skills/Queue/Finisher/"
        verb/Iron_Fist_Style()
            set hidden=1
            src.Trigger(usr)