/obj/Skills/Queue/Finisher
    Command_Grab
        Instinct=2
        Grapple=1
        KBMult=0.001
        SweepStrike=2
        Crushing = 20
        DamageMult = 4
        UnarmedOnly=1
        GrabTrigger="/obj/Skills/Grapple/Heavenly_Potemkin_Buster"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Potemkin_Buster"
        HitMessage="grabs hold of their enemy!"


    // same style

    Zetsuei // defensive
		// make animation that makes a clone rapidly strike at from angles, not 2 hard
        InstantStrikes = 13
        InstantStrikesDelay = 0.5
        DamageMult = 1.5 // by the time 13 hits this will b 20% dmg
        MortalBlow = 0.5
        FollowUp="/obj/Skills/AutoHit/Shitenketsu"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Cruel_Shadow"
        BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Death_Mark"
    Teiga // damage
        InstantStrikes = 11
        InstantStrikesDelay = 1
        DamageMult = 1.25
        MortalBlow = 1
        Grapple=1
        GrabTrigger="/obj/Skills/Grapple/Ryukoha"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Cruel_Shadow"
        BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Death_Mark"
    // same style 

    Jarret_Jarret
        SweepStrike=4
        SpeedStrike=2
        Bolt=1
        Quaking=5
        PushOut=1
        PushOutWaves=2
        DamageMult=2
        KBAdd=0.001
        FollowUp="/obj/Skills/AutoHit/Jarret_Jarret"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Feng_Shui_Engine"

    // end unarmed

    Divine_Finisher
        name = "Heavenly Demon's Radiant Divine Palm that Shatters the Nine Heavens and Illuminates the Eternal Night"
        Warp = 10
        Bolt = 1
        Shining = 1
        Explosive = 1
        Instinct = 2
        PushOut=1
        PushOutWaves=4
        SweepStrike=2
        Decider=4
        DamageMult=3
        KBAdd = 0.01
        FollowUp="/obj/Skills/AutoHit/The_Heavenly_Demons_Fist_That_Cleaves_Through_Heaven_And_Divides_The_Sea"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Emergent_Demon_Breakthrough"

    Bauf_Burst // ifrit

    Icy_Glare

    Alpha_Strike


    Psycho_Barrage

    // end hybird?

    Deal_with_the_Devil
        FollowUp = "/obj/Skills/AutoHit/Dantes_Inferno"
        BuffSelf = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/In_the_Details"

    Mega_Arm
        FollowUp = "/obj/Skills/Projectile/Super_Mega_Buster"
        BuffSelf = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/X_Buster"
        BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Plasma_Burned" // pure red 
    Frostfist
        Freezing = 255
        DamageMult = 2
        FollowUp = "/obj/Skills/AutoHit/Ice_Ply"
        BuffSelf = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Frozen_Summit"
    Phosphor
        FollowUp = "/obj/Skills/Projectile/Coldflame_Pale_Blade"
        BuffSelf = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Cooled_Down" 
    Jet_Kindling
        FollowUp = "/obj/Skills/AutoHit/Flashfire_Fist"
        BuffSelf = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Heated_Up" 