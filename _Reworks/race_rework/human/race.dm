race
	human
		name = "Human"
		desc = "Humans remain to be the most common race in the world. They are considered to be the most adaptive and the most resolute of all. Ancient creation stories suggest they were born as the final creation of the god Koyroyal."
		visual = 'Humans.png'
		passives = list("Underdog" = 1, "Adrenaline" = 0.5, "TechniqueMastery" = 2,"Innovation" = 1)
		// choices = list("Hero" = /ascension/sub_ascension/human/hero, "Innovative" = /ascension/sub_ascension/human/innovative)
		power = 1
		strength = 0.75
		endurance = 1
		force = 1.25
		offense = 1
		defense = 1
		speed = 1
		anger = 1.5
		learning = 1.25


/ascension/sub_ascension/human/hero
	passives = list("Tenacity" = 1, "Persistence" = 1)
	offense = 0.5
	strength = 0.25
	force = 0.25

/ascension/sub_ascension/human/innovative
	passives = list("Adaptation" = 1)
	defense = 0.5
	endurance = 0.5