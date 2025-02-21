/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura
    AlwaysOn = 1
    TimerLimit = 0
    NeedsPassword = 1
    var/skillToToss = null
    var/TossSkill = 1
    AuraLock = 'Terra Might.dmi'
    LockX=-16
    LockY=16
    AuraX=-8
    AuraY=-10
    Water
        IconLock = 'SpriteC.dmi'
        skillToToss = "/obj/Skills/Projectile/Bubblebeam"
    Fire
        IconLock = 'SpriteR.dmi'
        skillToToss = "/obj/Skills/Projectile/Fire_Blast"
    Earth
        IconLock = 'SpriteG.dmi'
        skillToToss = "/obj/Skills/AutoHit/Earthquake"
    Wind
        IconLock = 'SpriteY.dmi'
        skillToToss = "/obj/Skills/AutoHit/Hurricane"