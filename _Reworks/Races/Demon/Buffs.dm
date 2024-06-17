/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon
    passives = list("HellPower" = 0.1, "AngerAdaptiveForce" = 0.1, "Hellrisen" = 0.25, "FakePeace" = -1)
    Cooldown = -1
    TimerLimit = 0
    BuffName = "True Form"
    name = "True Form - Demon"
    IconLock='DarkInstinct.dmi'
    IconLockBlend=BLEND_MULTIPLY
    LockX=-32
    LockY=-32
    ActiveMessage = "<i>has unleashed their true nature!</i>"
    verb/True_Form()
        set category = "Skills"
        src.Trigger(usr)