ascension
	beastman
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			angerPoint = 5
			strength = 0.25
			defense = 0.25
			endurance = 0.25
			choices = list("Ferocious" = /ascension/sub_ascension/beastman/ferocious, "Nimble" = /ascension/sub_ascension/beastman/nimble, "Niche" = /ascension/sub_ascension/beastman/niche)
			passives = list("PureReduction" = 1, "Godspeed" = 1)
			postAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 15
					b.TooMuchHealth = 20
					b.AngerMult = 1.3
					b.passives = list("AngerAdaptiveForce" = 0.1, "Brutalize" = 1)
					b.VaizardHealth = 0.5
				..()
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			angerPoint = 5
			strength = 0.25
			speed = 0.25
			endurance = 0.25
			passives = list("PureDamage" = 1, "Flicker" = 1)
			postAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 20
					b.TooMuchHealth = 25
					b.AngerMult = 1.35
					b.passives = list("AngerAdaptiveForce" = 0.2 , "Brutalize" = 1.5)
					b.VaizardHealth = 1
				..()
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			angerPoint = 5
			speed = 0.25
			defense = 0.25
			endurance = 0.25
			passives = list("Pursuer" = 1, "Flicker" = 1)
			postAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 25
					b.TooMuchHealth = 30
					b.AngerMult = 1.4
					b.passives = list("AngerAdaptiveForce" = 0.3, "Void" = 1, "Brutalize" = 2)
					b.VaizardHealth = 1.5
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			angerPoint = 5
			endurance = 0.5
			passives = list("Godspeed" = 1, "PureReduction" = 1)
			postAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 25
					b.TooMuchHealth = 35
					b.AngerMult = 1.45
					b.passives = list("AngerAdaptiveForce" = 0.4, "Void" = 1, "Brutalize" = 2.5)
					b.VaizardHealth = 1.5
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			angerPoint = 5
			strength = 0.5
			endurance = 0.5
			postAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 30
					b.TooMuchHealth = 50
					b.AngerMult = 1.5
					b.passives = list("AngerAdaptiveForce" = 0.5, "Void" = 1, "Brutalize" = 3)
					b.VaizardHealth = 2.0
				..()


/ascension/sub_ascension/beastman/ferocious

/ascension/sub_ascension/beastman/nimble

/ascension/sub_ascension/beastman/niche