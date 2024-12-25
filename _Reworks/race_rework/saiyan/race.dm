race
	saiyan
		name = "Saiyan"
		desc = "Myths speak of a floating island anchored to the earth by a magical relic populated by a tribe of powerful monks bearing monkey tails. These pious monks travel the world in search of challenge and act with purpose, be it with pride, resilient will, or adaptive spirit."
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