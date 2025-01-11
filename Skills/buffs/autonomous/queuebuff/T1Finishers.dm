/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Death_Mark
    passives = list("Dim Mak" = 0.01)
    TimerLimit = 30
    Level = 1
    IconLock='RosePetals.dmi'
    ActiveMessage = "has been marked for death!"
    OffMessage = "takes internal damage from the Death Mark!"
    adjust(timer, lvl)
        TimerLimit = timer
        Level = lvl
    Trigger(mob/User, Override)
        if(User.BuffOn(src))
            // we r calling an end to it
            var/damage2do = User.passive_handler["Dim Mak"]
            User.passive_handler.Set("Dim Mak", 0.01)
            damage2do /= min(1,100-15 * Level)// applier's style tier
            world<< "DEBUG: DEATH MARK DID [damage2do] DAMAGE"
            User.LoseHealth(damage2do)
        . = ..()

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
        StrMult=1.5 // 0.3 so far
        OffMult=1.2 // freebie
        SpdMult=1.2 // other .2
        // flip flop the stats
        passives = list("BuffMastery" = 2, "StyleMastery" = 2, "Brutalize" = 1, "TensionLock" = 1)
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