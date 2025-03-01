race
	namekian
		name = "Namekian"
		icon_neuter = list('Namek1.dmi')
		gender_options = list("Neuter")
		desc = "A race that once came from distant stars, now fully sublimated into Copenlagen. Though many have mutated into slug-like beings, they share many traits unique to plant-life and possess a unique affinity with nature."
		visual = 'Namek.png'

		power = 2
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1
		speed = 1
		anger = 1.5
		imagination = 2
		intellect = 1.5
		learning = 1.25
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Regeneration, /obj/Skills/Queue/Infestation)
		/* /obj/Skills/AutoHit/AntennaBeam */
		classes = list("Warrior", "Dragon", "Heretic")
		class_info = list("Soldiers that use their powers for direct combat.", "Supportive masters taht try to aid from the sidelines, and invent unique ways to approaching situations.",\
					"Exiles that forsake their race by participating in ritual cannibalism... or something derranged enough to get them exiled.")
		stats_per_class = list("Warrior" = list(1.5, 1.5, 1.25, 1.25, 1, 1), "Dragon" = list(1,1,2,1.25,0.75,1),\
						"Heretic" = list(2, 0.5, 1.25, 1.25, 1.25, 1.5),)
		onFinalization(mob/user)
			..()
			user.EnhancedHearing = 1
			for(var/obj/Skills/Buffs/SlotlessBuffs/Regeneration/r in user)
				r.RegenerateLimbs=1
					
