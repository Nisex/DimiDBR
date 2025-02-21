/ascension/sub_ascension/human/hero
	passives = list("UnderDog" = 1)
	offense = 0.25
	strength = 0.25
	force = 0.25

/ascension/sub_ascension/human/innovative
	passives = list("Persistence" = 1)
	defense = 0.25
	endurance = 0.5


ascension
	human
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			choices = list("Hero" = /ascension/sub_ascension/human/hero, "Innovative" = /ascension/sub_ascension/human/innovative)
			passives = list("Adrenaline" = 0.5, "TechniqueMastery" = 0.5, "DemonicDurability" = 1)
			new_anger_message = "grows desperate!"
			on_ascension_message = "You learn the meaning of desperation..."
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("Adrenaline" = 1, "TechniqueMastery" = 0.5, "DemonicDurability" = 1)
			new_anger_message = "grows determined!"
			on_ascension_message = "You learn the meaning of responsibility..."
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/hero)
					passives["UnderDog"] = 1
					offense = 0.25
					strength = 0.25
					force = 0.25
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/innovative)
					passives["Persistence"] = 1
					defense = 0.5
					endurance = 0.25
				..()
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list( "Underdog" = 1, "TechniqueMastery" = 1, "DemonicDurability" = 0.5)
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			new_anger_message="grows confident!"
			on_ascension_message = "You learn the meaning of confidence..."

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list( "Underdog" = 1, "TechniqueMastery" = 1, "DemonicDurability" = 0.5)
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			new_anger_message = "gains absolute clarity!"
			on_ascension_message = "You learn the meaning of competence..."

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list( "TechniqueMastery" = -1, "DemonicDurability" = 0.5)
			strength = 1
			endurance = 1
			force = 1
			offense = 1
			defense = 1
			speed = 1
			new_anger_message = "becomes angry!"
			on_ascension_message = "You learn the meaning of humanity..."