var
		strength = 0
		endurance = 0
		force = 0
		offense = 0
		defense = 0
		speed = 0
		recovery = 0
		learning = 0
		intelligenceAdd = 0
		imaginationAdd = 0
		anger = 0
		unlock_potential = 1
		intimidation = 0
		intimidationMult = 1
		pilotingProwess = 0
		cyberizeModAdd = 0
		enhanceChips = 0
		rppAdd = 0
		ecoAdd = 0

ascension/proc/AlienStatIncrease()
    switch(input(usr, "Your body begins to mutate in novel ways...", "Each step...") in list("Strength", "Endurance", "Speed", "Offense", "Defense", "Force"))
        if("Strength")
            strength += 0.25
        if("Endurance")
            endurance += 0.25
        if("Speed")
            speed += 0.25
        if("Offense")
            offense += 0.25
        if("Defense")
            defense += 0.25
        if("Force")
            force += 0.25
    switch(input(usr, "Your body begins to mutate in novel ways?", "Brings you closer...") in list("Strength", "Endurance", "Speed", "Offense", "Defense", "Force"))
        if("Strength")
            strength += 0.25
        if("Endurance")
            endurance += 0.25
        if("Speed")
            speed += 0.25
        if("Offense")
            offense += 0.25
        if("Defense")
            defense += 0.25
        if("Force")
            force += 0.25
    switch(input(usr, "Your body begins to mutate in novel ways!?", "..To your perfect form!")in list("Strength", "Endurance", "Speed", "Offense", "Defense", "Force"))
        if("Strength")
            strength += 0.25
        if("Endurance")
            endurance += 0.25
        if("Speed")
            speed += 0.25
        if("Offense")
            offense += 0.25
        if("Defense")
            defense +=0.25
        if("Force")
            force += 0.25                