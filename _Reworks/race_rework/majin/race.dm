race
	majin
		name = "Majin"
		desc = "Primordial ooze given shape from the overuse of magic, given life by Aether."
		visual = 'Majins.png'

		passives = list("StaticWalk" = 1, "Steady" = 1)
		skills = list(/obj/Skills/Absorb, /obj/Skills/Buffs/SlotlessBuffs/Regeneration)

		locked = TRUE
		intellect = 0.25
		imagination = 4
		anger = 1.5
		regeneration = 4
		strength = 1.5
		endurance = 1.25
		speed = 1.25
		force = 1.5
		offense = 1.25
		defense = 1.5

		onFinalization(mob/user)
			..()
			if(!user.majinPassive)
				user.majinPassive = new(user)
			if(!user.majinAbsorb)
				user.majinAbsorb = new()
				user.findAlteredVariables()