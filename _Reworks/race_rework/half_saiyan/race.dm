// NOTE: HALF SAIYANS INHERIT SAIYAN TRANSFORMATIONS
race
	half_saiyan
		name = "Half_Saiyan"
		desc = "A product of inter-breeding or genetic experiments, you could be a child unaware of his heritage living in Elysium, surviving among the Necromorphs on Vegeta, or a lab experiment in a vat. This race should not have been created, but it was."
		visual = 'Halfie.png'

		locked = TRUE
		power = 2
		strength = 1.25
		endurance = 1.25
		force = 1.25
		offense = 1
		defense = 1.5
		speed = 1
		anger = 1.5
		regeneration = 1.5
		imagination = 1
		intellect = 1
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Oozaru)
		passives = list("Tenacity" = 0.5, "Brutalize" = 0.25, "Adrenaline" = 0.5)

		onFinalization(mob/user)
			..()
			user.Tail(1)
			var/list/transpaths = subtypesof(text2path("/transformation/saiyan"))
			for(var/i in transpaths)
				transformations += new i