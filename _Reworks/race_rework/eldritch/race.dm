race
	eldritch
		name = "Eldritch"
		desc = " Beings that were near the impact site when the meteor destroyed Mexico. They were infected with whatever infected the other organisms on Earth and have gained potent abilities as a result, at the cost of \[REDACTED\]."
		visual = 'Monster.png'

		passives = list("VenomResistance" = 0.25, "Void" = 1, "SoulFire" = 0.25, "DeathField" = 0.5, "VoidField" = 0.5)
		locked = TRUE
		strength = 1.5
		endurance = 2
		speed = 1
		force = 1.5
		offense = 1.5
		defense = 1.5
		regeneration = 2.5
		anger = 1
		intellect = 1.5
		imagination = 0.67

		onFinalization(mob/user)
			..()
			user.Secret="Eldritch"
			user.giveSecret("Eldritch")
			user.secretDatum.nextTierUp = 999