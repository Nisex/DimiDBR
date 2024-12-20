ascension
	human
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			anger = 0.1
			passives = list("Desperation" = 1.5, "Adrenaline" = 1, "TechniqueMastery" = -1, "Underdog" = 1)
			new_anger_message = "grows desperate!"
			on_ascension_message = "You learn the meaning of desperation..."
			choices = list("Technology" = /ascension/sub_ascension/human/technology, "Fighting" = /ascension/sub_ascension/human/fighting)

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("Desperation" = 1, "Adrenaline" = 1, "TechniqueMastery" = -1)
			anger = 0.1
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			new_anger_message = "grows determined!"
			on_ascension_message = "You learn the meaning of responsibility..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["DemonicDurability"] = 1
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 1
					cyberizeModAdd = 0.2
					pilotingProwess = 1.5
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list("Desperation" = 1.5, "Underdog" = 1)
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			anger = 0.1
			new_anger_message="grows confident!"
			on_ascension_message = "You learn the meaning of confidence..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["DemonicDurability"] = 0.5
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 1
					cyberizeModAdd = 0.1
					pilotingProwess = 1.5
				..()

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list("Desperation" = 1.5, "Underdog" = 1)
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			anger = 0.1
			new_anger_message = "gains absolute clarity!"
			on_ascension_message = "You learn the meaning of competence..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["DemonicDurability"] = 0.5
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 1
					cyberizeModAdd = 0.1
					pilotingProwess = 1.5
				..()

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list("Desperation" = 1.5, "TechniqueMastery" = -1.5)
			strength = 1
			endurance = 1
			force = 1
			offense = 1
			defense = 1
			speed = 1
			anger = 0.2
			new_anger_message = "becomes angry!"
			on_ascension_message = "You learn the meaning of humanity..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 2
					cyberizeModAdd = 0.1
					pilotingProwess = 1.5
				..()

ascension
	sub_ascension
		human
			technology
				rppAdd = 0.5
				ecoAdd = 0.5
				intelligenceAdd = 1
				cyberizeModAdd = 0.5
				imaginationAdd = 0.25
				pilotingProwess = 1.5
				enhanceChips = 1
			fighting
				passives = list("DemonicDurability" = 1, "StableBP" = 0.25)