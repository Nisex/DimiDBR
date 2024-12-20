ascension
	changeling
		one
			unlock_potential	=	ASCENSION_ONE_POTENTIAL
			intimidation = 3
			endurance = 0.25
			passives = list("PureReduction" = 2)
			on_ascension_message = "Your prowess grows!"

		two
			unlock_potential	=	ASCENSION_TWO_POTENTIAL
			intimidation = 3
			endurance = 0.25
			passives = list("PureReduction" = 2)
			choices = list("100% Power" = /ascension/sub_ascension/changeling/hundred_percent, "Fifth Form" = /ascension/sub_ascension/changeling/fifth_form)
			on_ascension_message = "Your prowess grows!"
		three
			unlock_potential	=	ASCENSION_THREE_POTENTIAL
			intimidation = 3
			endurance = 0.25
			passives = list("PureReduction" = 2)
			on_ascension_message = "Your prowess grows!"

		four
			unlock_potential	=	ASCENSION_FOUR_POTENTIAL
			intimidation = 3
			endurance = 0.25
			passives = list("PureReduction" = 2)
			on_ascension_message = "Your prowess grows!"

		five
			unlock_potential	=	ASCENSION_FIVE_POTENTIAL
			intimidation = 3
			endurance = 0.25
			passives = list("PureReduction" = 2)
			on_ascension_message = "Your prowess grows!"

ascension
	sub_ascension
		changeling
			hundred_percent
				skills = list(/obj/Skills/Buffs/SpecialBuffs/OneHundredPercentPower)
			fifth_form
				onAscension(mob/owner)
					. = ..()
					owner.transUnlocked = 4