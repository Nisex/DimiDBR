/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon
    passives = list("Hellpower" = 0.15, "AngerAdaptiveForce" = 0.1, "Hellrisen" = 0.25, "FakePeace" = -1, "TechniqueMastery" = -20)
    Cooldown = -1
    ActiveMessage = "<i>has unleashed their true nature!</i>"
    verb/True_Form()
        set category = "Skills"

        src.Trigger(usr)