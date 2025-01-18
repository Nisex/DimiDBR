/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher
    Heavenly_Dragon_Ascendant_Zenith
        passives = list("HardenedFrame" = 1, "Steady" = 1, "TensionLock" = 1)
        EndMult = 1.3
        StrMult = 1.2
        ActiveMessage="is grasping for their next breakthrough..!"
        OffMessage="has failed their tribulation..."
    Anger_Of_The_Beast
        StyleNeeded="Lucha Libre"
        StrMult=1.25
        EndMult=1.25
        passives = list("Iron Grip" = 1, "Scoop" = 1, "Muscle Power" = 2,"TensionLock" = 1)
        ActiveMessage = "awakens the Anger of The Beast!"
        OffMessage="'s inner beast calms down..."
    
    Shaolin_Step
        StyleNeeded="Shaolin"
        OffMult=1.1
        DefMult=1.1
        StrMult=1.1
        EndMult=1.1
        ForMult=1.1
        passives = list("BuffMastery" = 1, "StyleMastery" = 1, "DebuffResistance" = 1,"TensionLock" = 1)// not sure what 2 do w/ it
    
    Unlocked_Potential
        StyleNeeded="Turtle"

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

