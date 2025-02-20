ascension
	beastman
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			passives = list()
			onAscension(mob/owner)
				var/choice = owner.race?:Racial
				switch(choice)
					if("Heart of The Beastman")
						owner.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/The_Grit)
						owner.passive_handler.Set("Grit", 1)
						endurance = 0.4
						strength = 0.35
					if("Monkey King")
						owner.passive_handler.Increase("Nimbus", 1)
						endurance = 0.15
						strength = 0.15
						offense = 0.15
						defense = 0.15
						speed = 0.15
						force = 0.15
					if("Unseen Predator")
						world<<"burp"
					if("Undying Rage")
						world<<"burp"
					if("Feather Cloak")
						world<<"burp"
					
					if("Feather Knife")
						world<<"burp"
					

					if("Spirit Walker")
						world<<"burp"
					if("Shapeshifter")
						world<<"burp"
					
					if("Trickster")
						world<<"burp"
					
					if("Fox Fire")
						world<<"burp"
				..()
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			angerPoint = 5
			strength = 0.25
			speed = 0.25
			endurance = 0.25
			passives = list("PureDamage" = 1, "Flicker" = 1)
			postAscension(mob/owner)
				..()
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			angerPoint = 5
			speed = 0.25
			defense = 0.25
			endurance = 0.25
			passives = list("Pursuer" = 1, "Flicker" = 1)
			postAscension(mob/owner)
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			angerPoint = 5
			endurance = 0.5
			passives = list("Godspeed" = 1, "PureReduction" = 1)
			postAscension(mob/owner)
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			angerPoint = 5
			strength = 0.5
			endurance = 0.5
			postAscension(mob/owner)
				..()


/ascension/sub_ascension/beastman/ferocious

/ascension/sub_ascension/beastman/nimble

/ascension/sub_ascension/beastman/niche