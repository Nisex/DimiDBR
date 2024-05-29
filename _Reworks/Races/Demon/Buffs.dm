/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon
    passives = list("HellPower" = 0.15, "AngerAdaptiveForce" = 0.1, "Hellrisen" = 0.25, "FakePeace" = -1, "TechniqueMastery" = -20)
    Cooldown = -1
    TimerLimit = 0
    BuffName = "True Form"
    name = "True Form - Demon"
    ActiveMessage = "<i>has unleashed their true nature!</i>"
    verb/True_Form()
        set category = "Skills"

        src.Trigger(usr)