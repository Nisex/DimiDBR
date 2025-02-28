/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher
    Cruel_Shadow
        OffMult=1.3
        SpdMult=1.3
        EndMult=0.8
        StrMult=1.3
        DefMult=0.8
        passives = list("Brutalize" = 1.5, "StyleMastery" = 2, "BuffMastery" = 2,\
                        "Relentlessness" = 1, "Fury" = 6, "DebuffResistance" = 2, "TensionLock" = 1)
    
    Potemkin_Buster
        StyleNeeded = "Ubermensch"
        VaizardHealth = 0.2
        DefMult = 0.75
        SpdMult = 0.75
        StrMult = 1.5
        EndMult = 1.5
        passives = list("Muscle Power" = 2, "TechniqueMastery" = 3, "DeathField" = 7, "Juggernaut"= 5, "KBRes"= 5, "TensionLock" = 1)
    Emergent_Demon_Breakthrough
        StyleNeeded="Divine Arts of The Heavenly Demon"
        passives = list("Hardening" = 1.5, "Deflection" = 2, "UnarmedDamage" = 2, "Momentum" = 2, "Unnerve" = 2,\
                        ) //TODO come back 2 this perhaps
        StrMult=1.3
        SpdMult=1.2
        ActiveMessage="presses on the cusp of the Ultimate Heavenly Demon Realm!"
        OffMessage="fails their tribulation..."

    Feng_Shui_Engine
        SpdMult=1.3
        DefMult=1.3
        StrMult=1.3
        EndMult=0.6
        passives = list("ComboMaster" = 1, "Gum Gum" = 1, "Relentlessness" = 1, "Momentum" = 1.5, "Flow" = 2,\
                        "BuffMastery" = 3, "Brutalize" = 1.5, "MovementMastery" = 3, "TensionLock" = 1)
    


    Cooled_Down
        EndMult = 1.5
        SpdMult = 0.75
        ForMult = 1.25
        passives = list("CallousedHands" = 0.15, "Freezing" = 10, "Juggernaut" = 2.5, "KBRes" = 2.5, \
                        "Shattering" = 10, "Steady" = 4, "Hardening" = 2, "TensionLock" = 1)
    Heated_Up
        ForMult = 1.5
        EndMult = 0.75
        SpdMult = 1.25
        passives = list("SpiritHand" = 1, "Scorching" = 10, "BlurringStrikes" = 0.5, "Godspeed" = 2, \
                        "Shattering" = 10, "Flicker" = 2, "Pursuer" = 2, "Momentum" = 2, "TensionLock" = 1)

    X_Buster
        passives = list("Hit Scan" = 2, "SpiritStrike" = 1, "EnergyGeneration" = 2.5, "MovingCharge" = 1, "QuickCast" = 1, \
                        "SpiritFlow" = 1, "Paralyzing" = 10, "Shattering" = 10, "SuperCharge" = 1, "TensionLock" = 1)
        HitScanIcon = 'Plasma1.dmi'
        HitScanHitSpark = 'Trail - Plasma.dmi'
        ForMult = 1.3
        SpdMult = 1.2


    Plasma_Burned
        passives = list("PureReduction" = -1, "Flow" = -2, "Godspeed" = -1)
        


    In_the_Details
        passives = list("KillerInstinct" = 0.1, "HellPower" = 0.5, "Godspeed" = 2, "DebuffResistance" = 0.25, \
                        "Steady" = 2, "Scorching" = 15, "Toxic" = 10, "CursedWounds" = 1, "TensionLock" = 1)
        HealthDrain = 0.033
        DefMult = 0.75
        EndMult = 0.75
        StrMult = 1.5
        ForMult = 1.5
        TimerLimit = 30

    Frozen_Summit
        passives = list("CriticalChance" = 25, "BlockChance" = 25, "CriticalBlock" = 0.25, "GiantForm" = 1, \
                        "MovingCharge" = 1, "QuickCast" = 1, "Freezing" = 10, "Shattering" = 10, "LifeGeneration" = 1.5, \
                        "LikeWater" = 4, "TensionLock" = 1)
        EndMult=1.2
        ForMult=1.2
        DefMult=1.2