/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher
    Heavenly_Dragon_Ascendant_Zenith
        IconLock='SweatDrop.dmi'
        IconApart=1
        passives = list("HardenedFrame" = 1, "Steady" = 1, "TensionLock" = 1)
        EndMult = 1.3
        StrMult = 1.2
        ActiveMessage="is grasping for their next breakthrough..!"
        OffMessage="has failed their tribulation..."
    Anger_Of_The_Beast
        IconLock='SweatDrop.dmi'
        IconApart=1
        StyleNeeded="Lucha Libre"
        StrMult=1.25
        EndMult=1.25
        passives = list("Iron Grip" = 1, "Scoop" = 1, "Muscle Power" = 2,"TensionLock" = 1)
        ActiveMessage = "awakens the Anger of The Beast!"
        OffMessage="'s inner beast calms down..."
    
    Shaolin_Step
        IconLock='SweatDrop.dmi'
        IconApart=1
        StyleNeeded="Shaolin"
        OffMult=1.1
        DefMult=1.1
        StrMult=1.1
        EndMult=1.1
        ForMult=1.1
        passives = list("BuffMastery" = 1, "StyleMastery" = 1, "DebuffResistance" = 1,"TensionLock" = 1)// not sure what 2 do w/ it
    
    Unlocked_Potential
        StyleNeeded="Turtle"
        IconLock='SweatDrop.dmi'
        IconApart=1
        adjust(mob/p)
            // this is goofy, sigh
            var/ascension/nextasc = p.race.ascensions[p.AscensionsAcquired+1]
            passives = nextasc.passives
            passives["MovementMastery"] = 3
            StrMult = 1+nextasc.strength // problematic late game but i doubt ppl will go base turtle for it, this will however b swole for saga users
            OffMult = 1+nextasc.offense
            DefMult = 1+nextasc.defense
            EndMult = 1+nextasc.endurance
            ForMult = 1+nextasc.force
            SpdMult = 1+nextasc.speed
    Kiri_Otoshi // cutting down
        IconLock='SweatDrop.dmi'
        IconApart=1
        name = "Cutting Down"
        OffMult=1.15
        StrMult=1.25
        DefMult=1.1
        passives = list("Steady" = 1, "Instinct" = 1)
    
    // the debuff 
    Shredded
        IconLock='Stun.dmi'
        IconApart=1
        EndMult=0.9
        DefMult=0.8
        ActiveMessage="has been ripped apart!"
        OffMessage="shakes off their damage."
    

    Tyrfing
        IconLock='SweatDrop.dmi'
        IconApart=1
        name = "Finger of the War God"
        passives = list("HeavyHitter" = 0.5, "CheapShot" = 0.5, "HardStyle" = 1) //TODo: COME BACK TO THIS
        StrMult=1.3
        OffMult=1.2
        DefMult=1.2
        SpdMult=0.8
    
    Ragnarok
        IconLock='Stun.dmi'
        IconApart=1
        name = "Final Destiny of the Gods"
        passives = list("ArmorAscension" = -1)
        EndMult = 0.7
        // total tank death
    

    Champion_Pride
        IconLock='SweatDrop.dmi'
        IconApart=1
        passives = list("NoDodge" = 1, "Duelist" = 1)
        OffMult = 1.2
        StrMult = 1.3
        ActiveMessage="is filled with a champion's pride!"
        OffMessage="loses his fighting high."
    
    Marked
        IconLock='Stun.dmi'
        IconApart=1
        passives = list("NoDodge" = 1, "Duelist" = 1)
        EndMult = 0.8
        SpdMult = 0.9
        StrMult = 0.9

    Emperor_Time
        IconLock='SweatDrop.dmi'
        IconApart=1
        passives = list("Flow" = 1, "Instinct" = 1, "SweepingStrikes" = 1)
        SpdMult = 1.15
        OffMult = 1.15
    Judgment_Chain
        IconLock='Stun.dmi'
        IconApart=1
        CrippleAffected = 2
        SpdMult = 0.8
        DefMult = 0.9



