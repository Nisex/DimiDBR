/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dominating
    PureDamage = -1
    Warping=2
    Steady=1
    HotHundred=1
    TimerLimit=2
    ClientTint=1
    Cooldown=20
    PhysicalHitsLimit = 0
    proc/adjust(mob/p)
        var/asc = p.HellRisen * 4
        TimerLimit = 2 + (asc/2)
        Cooldown = 20 - (asc*2)
        Shattering = 5 + (asc*2.5)
        Steady = clamp(asc/2, 1, 2)
        PureDamage = -1 + (asc/2)