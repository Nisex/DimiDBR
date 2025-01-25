/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Death_Mark
    passives = list("Dim Mak" = 1)
    TimerLimit = 30
    Level = 1
    IconLock='death_mark.dmi'
    ActiveMessage = "has been marked for death!"
    OffMessage = "takes internal damage from the Death Mark!"
    adjust(timer, lvl)
        TimerLimit = timer
        Level = lvl
    Trigger(mob/User, Override)
        if(User.BuffOn(src))
            // we r calling an end to it
            var/damage2do = User.passive_handler["Dim Mak"]
            User.passive_handler.Set("Dim Mak", 1)
            world<< "DEBUG: DEATH MARK TRACKED ([damage2do]) TOTAL DAMAGE"
            damage2do *= clamp((15*Level)/100, 0.1, 1)// applier's style tier
            world<< "DEBUG: DEATH MARK DID ([damage2do]) DAMAGE"
            User.LoseHealth(damage2do)
        ..()

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher
    Wing_Chun_Essence
        StyleNeeded = "Wing Chun"
        SpdMult = 1.3
        OffMult = 1.2
        passives = list("Relentlessness" = 1, "Fury" = 4, "BuffMastery" = 2, "StyleMastery" = 2, "DebuffResistance" = 2, "TensionLock" = 1)
        ActiveMessage = "showcases the essence of Wing Chun!"
    Contempt_for_the_Weak
        StyleNeeded = "Tai Chi"
        DefMult=0.8
        EndMult=0.8
        StrMult=1.3 // 0.3 so far
        OffMult=1.3 // freebie
        SpdMult=1.3 // other .2
        // flip flop the stats
        passives = list("BuffMastery" = 1, "StyleMastery" = 2, "Brutalize" = 1, "TensionLock" = 1)
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
        passives = list("TensionLock" = 1, "SpiritHand" = 1, "CallousedHands" = 0.1, "Pursuer" = 2, "Instinct" = 2)
        ActiveMessage="ignites their legs!"
        OffMessage="burns out..."
    Heavenly_Dragons_Transient_Enlightenment
        StyleNeeded="Heavenly Dragon Stance"
        StrMult=1.25
        EndMult=1.25
        passives = list("TensionLock" = 1, "Deflection" = 0.5, "Disorienting" = 2,"Momentum" = 2, "CallousedHands" = 0.1, "MovementMastery" = 3)
        ActiveMessage="achieves the peak of their breakthrough..."
        OffMessage="comes back down to mortal level..."
    

    Nito_Ichi
        StyleSpd=1.25
        StyleStr=1.25
        passives = list("TensionLock" = 1, "Momentum" = 1, "DoubleStrike" = 1,\
                        "Steady" = 2, "Instinct" = 2)
        
    Iai
        StyleSpd = 1.5
        StyleStr = 0.75
        StyleOff = 1.25
        passives = list("TensionLock" = 1, "Speed Force" = 1, "Iaijutsu" = 1, "Relentlessness" = 1, "Fury" = 3)
    

    Crescent_Blessing
        passives = list("Tossing" = 1.5, ) // not sure 
    

    Fimbulwinter
        passives = list("PureReduction" = -0.5)
        CrippleAffected = 2
        SlowAffected = 2

    Zwercopter
        passives = list("Half-Sword" = 0.5, "Zornhau" = 0.5, "Momentum" = 2, "HeavyHitter" = 1, "CheapShot" = 1,\
                     "HardStyle" = 1)
        StrMult=1.3
        OffMult=1.2
        DefMult=1.2
        SpdMult=0.8