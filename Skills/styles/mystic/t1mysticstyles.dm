/obj/Skills/Buffs/NuStyle/MysticStyle

    Magma
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = "Earth", "Magmic" = 1, "Burning" = 2.5, "Shattering" = 2.5, \
                        "Combustion" = 30, "Harden" = 1)
        StyleActive = "Magma"
        StyleFor = 1.2
        StyleEnd = 1.2
        Finisher = "/obj/Skills/Queue/Finisher/"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Earth"
    Ice
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = "Water", "IceAge" = 50, "Chilling" = 4, "Shattering" = 1, \
                        "Harden" = 1, "WaveDancer" = 1.5)
        StyleActive = "Ice"
        StyleOff = 1.15
        StyleEnd = 1.15
        StyleFor = 1.15
        Finisher = "/obj/Skills/Queue/Finisher/"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Water"
    Storm
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = "Wind", "ThunderHerald" = 1, "CriticalChance" = 15, "CriticalDamage" = 1.1, \
                        "Shocking" = 2.5, "Chilling" = 2.5, "GodSpeed" = 1, "AirBend"= 1.5)
        StyleActive = "Storm"
        StyleSpd = 1.15
        StyleOff = 1.15
        StyleFor = 1.15
        Finisher = "/obj/Skills/Queue/Finisher/"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Wind"
    Inferno
        SignatureTechnique = 1
        passives = list("SpiritFlow" = 2, "Familiar" = "Fire", "Combustion" = 45, "Heavy Strike" = "Inferno",\
                         "Shocking" = 2, "Burning" = 3)
        StyleActive = "Inferno"
        StyleFor = 1.3
        StyleSpd = 1.15
        Finisher="/obj/Skills/Queue/Finisher/"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Fire"