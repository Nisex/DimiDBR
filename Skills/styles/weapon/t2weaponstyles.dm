/obj/Skills/Buffs/NuStyle/SwordStyle
    Santoryu
        SignatureTechnique = 2
        NeedsThirdSword=1
        Copyable=0
        StyleOff=1.15
        StyleStr=1.3
        StyleEnd=1.15
        StyleActive="Santoryu"
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Berserk"="/obj/Skills/Buffs/NuStyle/SwordStyle/Two_Heaven_As_One",
                            "/obj/Skills/Buffs/NuStyle/SwordStyle/Phalanx_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Acrobat")
        passives = list("Fury" = 2, "BlurringStrikes" = 1, "SweepingStrike" = 1, "DoubleStrike" = 2, "TripleStrike" = 0.5,\
                    "NeedsSecondSword" = 1, "NeedsThirdSword" = 1, "Iaijutsu" = 1.5, "Musoken" = 1)
        NeedsSecondSword = 1
        NeedsThirdSword = 1
    Berserk
        SignatureTechnique = 2
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu"="/obj/Skills/Buffs/NuStyle/SwordStyle/Two_Heaven_As_One",
                            "/obj/Skills/Buffs/NuStyle/SwordStyle/Witch_Hunter"="/obj/Skills/Buffs/NuStyle/SwordStyle/Fierce_Deity")
        passives = list("Rage" = 1, "Half-Sword" = 2, "Zornhau" = 2, "Parry" = 2.5,"Disarm" = 2,\
                         "Hardening" = 1, "Deflection" = 0.5)
        StyleOff=1.3
        StyleStr=1.45
        StyleEnd=0.85
        HeavyOnly=1
        StyleActive="Guts Berserk"
    Witch_Hunter
        SignatureTechnique = 2
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Berserk"="/obj/Skills/Buffs/NuStyle/SwordStyle/Fierce_Deity")
        passives = list("FavoredPrey" = "Secrets", "SlayerMod" = 2 , "Shearing" = 6, "SwordPunching" = 1, "Secret Knives" = "Stake", \
                        "Tossing" = 2, "Half-Sword" = 2, "Zornhau" = 1.5)
        StyleOff=1.15
        StyleStr=1.3
        StyleEnd=1.15
        StyleActive="Witch Hunter"
    Phalanx_Style
        SignatureTechnique=2
        Copyable=0
        StyleOff=1.15
        StyleStr=1.15
        StyleEnd=1.3
        StyleActive="Phalanx Style"
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu"="/obj/Skills/Buffs/NuStyle/SwordStyle/Acrobat")
        passives = list("Reversal" = 0.25, "Deflection" = 1, "Hardening" = 1.5, "Parry" = 2, "Disarm" = 2, "SwordPunching" = 1,\
                 "Unnerve" = 1, "Secret Knives" = "Atlatl", "Tossing" = 2)
        Finisher="/obj/Skills/Queue/Finisher/Shield_Vault"


                    /*

					Butcher_Style
						SignatureTechnique=2
						Copyable=0

						StyleStr=1.5
						StyleSpd=1.5
						StyleActive="Butcher"
						NeedsSword=0
						SwordPunching=1
						passives = list("Shearing" = 6, "SlayerMod" = 2, "SwordPunching" = 1, "NeedsSword" = 0)
						Shearing=2
						SlayerMod=2.5
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu"="/obj/Skills/Buffs/NuStyle/SwordStyle/Five_Rings_Style")
						Finisher="/obj/Skills/Queue/Finisher/Crimson_Fountain"
						verb/Butcher_Style()
							set hidden=1
							src.Trigger(usr)


                    */
    