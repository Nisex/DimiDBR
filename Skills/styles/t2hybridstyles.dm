/obj/Skills/Buffs/NuStyle/UnarmedStyle
    Phoenix_Eye_Fist // unarmed + armed
        SignatureTechnique=2
    Divine_Arts_of_The_Heavenly_Demon // unarmed+armed
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

    Ifrit_Jambe // mystic+unarmed
        SignatureTechnique=2

    Wuju_Style // mystic+armed
        SignatureTechnique=2
        passives = list("Wuju Style" = 0.0005)

    Psycho_Boxing // mystic+unarmed (anti cyborg)
        SignatureTechnique=2

// glob.WUJU_STYLE_BASE_DAMAGE 0.0005 * 100 = 99.95