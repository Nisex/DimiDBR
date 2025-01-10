/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Death_Mark
    passives = list("Dim Mak" = 0.01)
    TimerLimit = 30
    Level = 1
    IconLock='RosePetals.dmi'
    adjust(timer, lvl)
        TimerLimit = timer
        Level = lvl
    Trigger(mob/User, Override)
        if(User.BuffOn(src))
            // we r calling an end to it
            var/damage2do = User.passive_handler["Dim Mak"]
            User.passive_handler.Set("Dim Mak", 0.01)
            damage2do /= min(1,100-15 * Level)// applier's style tier
        . = ..()
        
/obj/Skills/AutoHit/One_Inch_Finisher
    UnarmedOnly=1
    FlickAttack=1
    Area="Strike"
    StrOffense=2
    DamageMult=3
    Stunner=3
    Rush=3
    RushDelay=0.1
    ControlledRush=1
    Knockback=0
    Quaking=4
    PreShockwave=1
    PreShockwaveDelay=1
    PostShockwave=0
    Shockwaves=2
    Shockwave=0.5
    ShockIcon='KenShockwaveFocus.dmi'
    ShockBlend=2
    ShockDiminish=1.15
    ShockTime=4
    ActiveMessage="curls up their fingers into a fist and delivers a crushing blow!!!"

/obj/Skills/Queue/Finisher
    Dark_Dragon_Commandment
        Combo=5
        DamageMult=0.5
        Instinct=2
        FollowUp="/obj/Skills/Autohit/One_Inch_Finisher"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Wing_Chun_Essence"

    Dim_Mak
        BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Death_Mark"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Contempt_for_the_Weak"

    Leg_Grab
        Instinct=2
        Grapple=1
        KBMult=0.001
        SweepStrike=1
        Crushing = 5
        DamageMult = 2.5
        UnarmedOnly=1
        GrabTrigger="/obj/Skills/Grapple/Giant_Swing"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Iron_Muscle"
        HitMessage="grabs hold of their enemy!"
    Mouton_Shot
        KBMult=0.001
        Crippling=100
        DamageMult=3
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Diable_Jambe"
        HitMessage="springs into a handstand, launching a destructive kick from below!"
        FollowUp="/obj/Skills/AutoHit/Flamberge_Shot"
    Heavenly_Dragons_Omniscient_Surge
        Warp = 10
        Bolt = 1
        Shining = 1
        Explosive = 1
        Shocking = 4
        Shattering = 4
        Instinct = 2
        PushOut=2
        PushOutWaves=2
        Decider = 4
        DamageMult=0.33
        KBAdd = 3
        InstantStrikes=10
        FollowUp="/obj/Skills/AutoHit/Heavenly_Dragon_Violet_Ponds_Annihilation_of_the_Nine_Realms"
        BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Heavenly_Dragons_Transient_Enlightenment"
        HitMessage="Summons the boundless might of their martial arts, entering into a breakthrough by pure technique alone. Roars that turn into unstoppable torrent of energy erupt from their body while it soars through the battlefield, unleashing a symphony of cataclysmic destruction paired with ethereal grace. They have unlocked the ultimate testament to the Heavenly Dragon Stance, a dance of power and honor that surpasses the mortal plane, from the divine heights of the quasi-god realm, they descend as the Heavenly Dragon. Harnessing the boundless force of the Nine converging Realms, they unleash a relentless storm of peerless strength, devastating the battle field."
