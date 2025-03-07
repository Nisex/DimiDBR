/obj/Skills/Buffs/SlotlessBuffs/Racial/Human/Deus_Ex_Machina
    Cooldown = -1
    passives = list("You Thought" = 1, "Hopes and Dreams" = 1)

    Trigger(mob/User, Override)
        if(User.BuffOn(src))
            User.ShonenAnnounce=0
            User.ShonenCounter=0
        ..() 