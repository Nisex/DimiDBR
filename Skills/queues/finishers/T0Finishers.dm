/obj/Skills/Queue/Finisher/
    Hold
        Instinct=2
        Grapple=1
        KBMult=0.001
        SweepStrike=1
        DamageMult = 1
        UnarmedOnly=1
        GrabTrigger="/obj/Skills/Grapple/Muscle_Buster"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Anger_Of_The_Beast"
        HitMessage="grabs hold of their enemy!"
    Heavenly_Storm_Dragon_Emergence
        Warp = 10
        Bolt = 1
        Shining = 1
        Explosive = 1
        Shocking = 3
        Shattering = 3
        Instinct = 1
        PushOut=2
        PushOutWaves=3
        Decider = 2
        DamageMult=0.15
        InstantStrikes=10
        FollowUp="/obj/Skills/Queue/Finisher/Heavenly_Dragon_Raging_Tempest"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Heavenly_Dragon_Ascendant_Zenith"
        HitMessage="taps into their ancestral arts! With a roar that echoes through the realms, the force quakes the earth and tears through the skies! The tempest of its fury is a celestial ballet, weaving destruction and honor into the fabric of existence. The path of the Heavenly Dragon has descended upon the mortal realms from the quasi-god realm! Their very presence shakes and alters the fragile reality they reside in! A maelstrom of everlasting power continues to surge, ascending higher and higher! Until the peak of Murim Martial Arts conquers all! That is the Zenith... A god among man!"
    Heavenly_Dragon_Raging_Tempest
        Warp = 3
        Combo=10
        DamageMult = 0.15
        Bolt = 1
        Shining = 1
        Explosive = 1
        KBAdd = 0.001
        PushOut=1
        PushOutWaves=1
        BuffSelf=0
    
    Merciful_Thousand_Leaves_Hand
        FollowUp="/obj/Skills/AutoHit/Arhats_Palm"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Shaolin_Step"
        Warp = 5
        Combo = 3
        DamageMult = 5
        KBAdd = 3
        PushOut=1
        PushOutWaves=1
        HitMessage="channels the force of Arhat!"
    
    Four_Virtues
        FollowUp="/obj/Skills/Queue/Finisher/Tranquility"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Unlocked_Potential"
        Warp = 3
        DamageMult = 1.5
        Launcher = 5
        PushOut=1
        PushOutWaves=1
        HitMessage="starts that there combo!"

    Tranquility
        FollowUp="/obj/Skills/Queue/Finisher/Ultimate_Fist"
        Warp = 3
        DamageMult = 1.5
        Dunker = 1
        PushOut=1
        PushOutWaves=1
        HitMessage="leads into it"
    
    Ultimate_Fist
        DamageMult = 1.5
        KBAdd = 3
        Projectile="/obj/Skills/Projectile/Beams/Kamehameha"
        ProjectileBeam=1