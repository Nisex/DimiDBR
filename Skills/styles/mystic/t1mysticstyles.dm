/obj/Skills/Buffs/NuStyle/MysticStyle

    Magma
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = 1, "Magmic" = 1, "Burning" = 2.5, "Shattering" = 2.5, \
                        "Combustion" = 30, "Harden" = 1)
        StyleActive = "Magma"
        StyleFor = 1.2
        StyleEnd = 1.2
        Finisher = "/obj/Skills/Queue/Finisher/Major_Eruption"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Earth"
        StyleComboUnlock = list("/obj/Skills/Buffs/NuStyle/MysticStyle/Storm"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Plasma",\
                                "/obj/Skills/Buffs/NuStyle/MysticStyle/Inferno"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Hellfire")
    Ice
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = 1, "IceAge" = 50, "Chilling" = 4, "Shattering" = 1, \
                        "Harden" = 1, "WaveDancer" = 1.5)
        StyleActive = "Ice"
        StyleOff = 1.15
        StyleEnd = 1.15
        StyleFor = 1.15
        Finisher = "/obj/Skills/Queue/Finisher/Ice_Time"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Water"
        StyleComboUnlock = list("/obj/Skills/Buffs/NuStyle/MysticStyle/Storm"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Blizzard",\
                                "/obj/Skills/Buffs/NuStyle/MysticStyle/Inferno"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Hot_n_Cold")
    Storm
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = 1, "ThunderHerald" = 1, "CriticalChance" = 15, "CriticalDamage" = 0.1, \
                        "Shocking" = 2.5, "Chilling" = 2.5, "GodSpeed" = 1, "AirBend"= 1.5)
        StyleActive = "Storm"
        StyleSpd = 1.15
        StyleOff = 1.15
        StyleFor = 1.15
        Finisher = "/obj/Skills/Queue/Finisher/Stormweaver"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Wind"
        StyleComboUnlock = list("/obj/Skills/Buffs/NuStyle/MysticStyle/Magma"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Plasma",\
                                "/obj/Skills/Buffs/NuStyle/MysticStyle/Ice"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Blizzard")
    Inferno
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = 1, "Combustion" = 45, "Heavy Strike" = "Inferno",\
                         "Shocking" = 2, "Burning" = 3)
        StyleActive = "Inferno"
        StyleFor = 1.3
        StyleSpd = 1.15
        Finisher="/obj/Skills/Queue/Finisher/Sunshine_Flame"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Fire"
        StyleComboUnlock = list("/obj/Skills/Buffs/NuStyle/MysticStyle/Magma"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Hellfire",\
                                "/obj/Skills/Buffs/NuStyle/MysticStyle/Ice"= "/obj/Skills/Buffs/NuStyle/MysticStyle/Hot_n_Cold")