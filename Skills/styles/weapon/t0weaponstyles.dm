/obj/Skills/Buffs/NuStyle/SwordStyle
    Ittoryu_Style
        passives = list("Musoken" = 1)
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Fencing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Nito_Ichi",\
        "/obj/Skills/Buffs/NuStyle/SwordStyle/Gladiator_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido",\
        "/obj/Skills/Buffs/NuStyle/SwordStyle/Ulfberht_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Kunst_des_Fechtens",\
        "/obj/Skills/Buffs/NuStyle/SwordStyle/Chain_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Fist_of_Konshu")
        StyleStr = 1.15
        StyleOff = 1.15
        Finisher="/obj/Skills/Queue/Finisher/Shishi_Sonson"
    Fencing_Style
        StyleSpd=1.15
        StyleOff=1.15
        StyleActive="Fencing"
        passives = list("Parry" = 1)
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Ittoryu_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Nito_Ichi",\
        "/obj/Skills/Buffs/NuStyle/SwordStyle/Gladiator_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Dari_Style")
        Finisher="/obj/Skills/Queue/Finisher/La_Rapiere_des_Sorel"
        verb/Fencing_Style()
            set hidden=1
            src.Trigger(usr)
    Ulfberht_Style
        StyleStr=1.3
        StyleEnd=0.85
        StyleSpd=1.15
        StyleActive="Ulfberht"
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Ittoryu_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Kunst_des_Fechtens")
        passives = list("Half-Sword" = 1)
        Finisher="/obj/Skills/Queue/Finisher/Skofnung"
        verb/Ulfberht_Style()
            set hidden=1
            src.Trigger(usr)
    Gladiator_Style
        StyleOff = 1.1
        StyleEnd = 1.1
        StyleDef = 1.1
        StyleActive="Gladiator"
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Fencing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Dari_Style",\
        "/obj/Skills/Buffs/NuStyle/FreeStyle/Ittoryu_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido")
        Finisher="/obj/Skills/Queue/Finisher/Challenge"
        verb/Gladiator_Style()
            set hidden=1
            src.Trigger(usr)
    Chain_Style
        passives = list()
        StyleStr=1.1
        StyleDef=1.1
        StyleOff=1.1
        StyleActive="Chain"
        passives = list("Extend" = 1)
        StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Ittoryu_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Fist_of_Khonshu")
        Finisher="/obj/Skills/Queue/Finisher/Grand_Cross"
        verb/Chain_Style()
            set hidden=1
            src.Trigger(usr)