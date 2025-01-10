/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher
    Wing_Chun_Essence
        StyleNeeded = "Wing Chun"
        SpdMult = 1.3
        OffMult = 1.2
        passives = list("Relentlessness" = 1, "Fury" = 3, "BuffMastery" = 2, "StyleMastery" = 2, "DebuffResistance" = 2, "TensionLock" = 1)
        ActiveMessage = "showcases the essence of Wing Chun!"
    Contempt_for_the_Weak
        StyleNeeded = "Tai Chi"
        DefMult=0.8
        EndMult=0.8
        StrMult=1.5 // 0.3 so far
        OffMult=1.2 // freebie
        SpdMult=1.2 // other .2
        // flip flop the stats
        passives = list("BuffMastery" = 2, "StyleMastery" = 2, "Brutalize" = 0.15, "TensionLock" = 1)
    Iron_Muscle
        StyleNeeded = "Red Cyclone"
        VaizardHealth = 0.3
        DefMult = 0.3
        SpdMult = 0.5
        StrMult = 1.5
        EndMult = 1.5
        passives = list("Muscle Power" = 2, "TechniqueMastery" = 3, "Juggernaut"= 2, "KBRes"= 2, "TensionLock" = 1)
    Diable_Jambe
        StyleNeeded="Black Leg"
        StrMult=1.25
        ForMult=1.25
        passives = list("TensionLock" = 1, "SpiritHand" = 1, "CallousedHands" = 0.1, "Persuerer" = 2, "Instinct" = 2)
        ActiveMessage="ignites their chivalrous spirit!"
        OffMessage="burns out their manly spirit..."
    Heavenly_Dragons_Transient_Enlightenment
        StyleNeeded="Heavenly Dragon Stance"
        StrMult=1.25
        EndMult=1.25
        passives = list("TensionLock" = 1, "Deflection" = 0.5, "Disorienting" = 2,"Momentum" = 2, "CallousedHands" = 0.1, "MovementMastery" = 3)
        ActiveMessage="achieves the peak of their breakthrough..."
        OffMessage="comes back down to mortal level..."