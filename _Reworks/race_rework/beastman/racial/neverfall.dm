

/datum/BuffTrigger
    NeverFall
        trigger = "/obj/Skills/AutoHit/MonkeyKingWhirlwind"
        trigger_when = "EqualOrMore"
        trigger_at = 50
        trigger_ref = "AbsorbingDamage"
        set_to = 1
        reference_this_var = "passive_handler"

        init(mob/p, obj/Skills/Buffs/SlotlessBuffs/b)
            parent_buff = b
            owner = p
            trigger_at = 50 - (p.AscensionsAcquired * 5)
            reference_this = p // likely good to make this a .vars otherwise or some sort of list to refernce vars



/obj/Skills/AutoHit/MonkeyKingWhirlwind
    ActiveMessage = "swings around AWOOOOO!!"
    DamageMult = 1
    AdaptRate = 1
    Area = "Circle"
    Size=4
    Icon='SweepingKick.dmi'
    IconX=-32
    IconY=-32
    FlickSpin=1
    adjust(mob/p)
        DamageMult = (50 - (p.AscensionsAcquired * 5)) / 100
        Rounds = 2 + (p.AscensionsAcquired)


/obj/Skills/Buffs/SlotlessBuffs/Autonomous
    var/datum/BuffTrigger/Triggers = null

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Beastman
    Never_Fall
        AlwaysOn = 1
        passives = list("AbsorbingDamage" = 1)
        Trigger(mob/User, Override)
            . = ..()
            Triggers = new/datum/BuffTrigger/NeverFall(User, src)