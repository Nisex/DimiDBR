race
	saiyan
		name = "Saiyan"
		desc = "They are the victims of the cosmic horror, their entire race has been destroyed. While the \[REDACTED\] wished to \[REDACTED\], it did not foresee that they would be far too gifted at destruction to \[REDACTED\] \n\[REDACTED\] grasped their most empowering legend of the Super Saiyan, and used it to its advantage, practically ending the Saiyan race and besmirching its legacy forever."
		visual = 'Saiyan.png'

		locked = TRUE

		strength = 1.5
		endurance = 1.5
		force = 1.5
		offense = 1
		defense = 1
		speed = 1
		anger = 1.5
		regeneration = 1.5
		imagination = 0.5
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Oozaru)
		passives = list("Brutalize" = 0.25)

		onFinalization(mob/user)
			..()
			user.Tail(1)
//			user.contents+=new/obj/Oozaru

	/*
		TODO: think of a better way to handle racial features.
		New()
			..()
			var/obj/tail = new
			tail.layer = RACIAL_FEATURES_LAYER
			tail.icon = 'Tail.dmi'

			overlays.Add(tail)
	*/