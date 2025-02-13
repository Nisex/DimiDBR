/obj/Skills/Buffs/NuStyle/UnarmedStyle
    Move_Duplication
        BuffName = "Copy Wheel"
        Copyable = 0
        SagaSignature = 1
        passives = list("SwordPunching" = 1)
        NeedsSword = 0
        verb/Move_Duplication()
			set hidden=1
			src.Trigger(usr)