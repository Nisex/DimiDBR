ascension
	saiyan
		one
			unlock_potential = 10
			choices = list("Pride" = /ascension/sub_ascension/saiyan/pride, "Honor" =  /ascension/sub_ascension/saiyan/honor, "Zeal" = /ascension/sub_ascension/saiyan/zeal)
			intimidation = 25
			passives = list("Brutalize" = 0.25)
			// GIVE MY NIGGAS SOMETHING TO EAT WITH
			strength = 0.25
			offense = 0.25
			endurance = 0.25
		two
			unlock_potential = 25
			anger = 0.25
			intimidation = 25
			passives = list("Brutalize" = 0.5)
			strength = 0.25
			defense = 0.25
			endurance = 0.25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/zeal)
					passives = list("Adaptation" = 0.5)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/honor)
					passives = list("AngerAdaptiveForce" = 0.2, "Adrenaline" = 1)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/pride)
					passives = list("Steady" = 1)
				..()
		three
			unlock_potential = 40
			intimidation = 25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/zeal)
					passives = list("Adaptation" = 0.5)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/honor)
					passives = list("AngerAdaptiveForce" = 0.2, "Adrenaline" = 1)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/pride)
					passives = list("Steady" = 1)
				..()
		four
			unlock_potential = 60
			intimidation = 25
			anger = 0.25
			passives = list("Brutalize" = 1)
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/zeal)
					passives = list("Adaptation" = 0.5)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/honor)
					passives = list("AngerAdaptiveForce" = 0.2, "Adrenaline" = 1)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/pride)
					passives = list("Steady" = 1)
				..()

ascension
	sub_ascension
		saiyan
			honor
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Saiyan_Grit)
				passives = list("Defiance" = 1)

			pride
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Saiyan_Dominance)
				passives = list("Pride" = 1)

			zeal
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Saiyan_Soul)
				passives = list("Adaptation" = 0.5)