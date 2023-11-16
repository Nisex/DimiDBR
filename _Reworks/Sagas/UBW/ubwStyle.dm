/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_Savant
    BuffName = "Sword Savant Style"
    Copyable = 0
    SagaSignature = 1
    StyleActive = "Sword Savant"
    passives = list("SwordPunching" = 1, "SwordDamage" = 1)
    NeedsSword = 0
    Mastery = 4
    StyleStr = 1.25
    StyleOff = 1.5
    StyleDef = 1.5
    StyleSpd = 1.25
    Finisher="/obj/Skills/Queue/Finisher/UBW_finisher"


/obj/Skills/Queue/Finisher/UBW_finisher
    InstantStrikes = 6
    DamageMult = 1
    FollowUp="/obj/Skills/AutoHit/UBW_FollowUP"
    BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Stunted"
    BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Sword_Flow"



/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Stunted
    IconLock='SweatDrop.dmi'
    IconApart=1
    StrMult=0.8
    OffMult=0.8
    SpdMult=0.8
    DefMult=0.8
    EndMult=0.8
    CrippleAffected = 2
    ActiveMessage="has been overwhelmed by the onslaught!"
    OffMessage="regains their composure!"


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Sword_Flow
    passives = list("ManaGeneration" = 20, "SwordDamage" = 1, "Flow" = 1, "Instinct" = 1, "Wraping" = 3)
    TimerLimit=30
    ActiveMessage="is in the flow of battle!"
    OffMessage="loses their focus!"

/obj/Skills/AutoHit/UBW_FollowUP
    Area="Target"
    NoLock=1
    NoAttackLock=1
    Distance=3
    Instinct=4
    DamageMult=2
    Rounds=3
    GuardBreak=1
    StrOffense=1
    ActiveMessage="sends a barrage of swords at their enemy!"
    HitSparkIcon='Slash - Zan.dmi'
    HitSparkX=-16
    HitSparkY=-16
    HitSparkSize=2
    HitSparkTurns=1
    HitSparkLife=10
    IconTime=10
    Cooldown=4