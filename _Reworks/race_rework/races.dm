
/*
races are stored as text macros; this serves two purposes.
If a typo occurs, BYOND will throw errors.
This is also done so we can easily check types.
*/
#define HUMAN /race/human
#define SAIYAN /race/saiyan
#define NAMEKIAN /race/namekian

#define RACIAL_FEATURES_LAYER FLOAT_LAYER+0.01

var/list/races = list()

proc
	BuildRaceList()
		races = list()
		for(var/a in subtypesof(/race/))
			races += new a

	GetRaces()
		return races

	GetRaceTypes()
		. = list()
		for(var/race/race in GetRaces())
			. += race.type

	GetRaceInstanceFromType(_type)
		for(var/race/race in GetRaces())
			if(race.type == _type)
				return race

	GetRaceInstanceFromName(_name)
		for(var/race/race in races)
			if(race.name == _name)
				return race

world
	New()
		..()
		BuildRaceList()

mob
	var
		race/race

mob
	proc

		setRace(race/new_race)
			if(!new_race) throw EXCEPTION("setRace was not supplied a new_race argument!")

			if(race) overlays -= race.overlays

			race = new_race

			if(Gender == "Female")
				icon = race.icon_female
			else if(Gender == "Male")
				icon = race.icon_male
			else if(Gender == "Neuter")
				icon = race.icon_neuter

			icon_state = null
			overlays.Add(race.overlays)

			AngerPoint = race.anger_point
			AngerMessage = race.anger_message

		// use the text macros for this!!
		isRace(raceCheck)
			/*
				return:
					1 if match is found
					0 if not found
					throws a exception if no race is supplied for checking.
			*/
			if(!raceCheck) throw EXCEPTION("isRace was not supplied a raceCheck argument!")
			if(race.type == raceCheck) return 1
			return 0


race
	var
		// the formal name for the race
		name = ""

		gender_options = list("Male", "Female")
		//the icon used for male gender
		icon_male
		//the icon used for female gender.
		icon_female
		//icon used for neuter gender.
		icon_neuter

		locked = FALSE

		//a text description for the race; displayed to the user.
		desc
		visual

		health = 100
		energy = 100
		mana = 100

		power = 1

		//1 = 1 for these.
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1
		speed = 1

		anger_message = ""
		anger_point = 50
		anger = 1
		regeneration = 1
		recovery = 1

		learning = 1
		intellect = 1
		imagination = 1

		// a list of overlays; such as saiyan tails, or so on.
		list/overlays = new/list()

		// a list of skills that specific races may need to start with.
		list/skills = new/list()

		//a list of passives a race needs to start with.
		list/passives = new/list()

		//these will be listed in terms of intended accquistion; race_ascension[1] is first asc, and so on.
		//these have their requirements built in as unlock_potential.
		list/ascensions = new/list()
		list/transformations = new/list()

	New()
		ascensions = new subtypesof("/ascension/[lowertext(name)]")
		transformations = new subtypesof("/transformation/[lowertext(name)]")

	human
		name = "Human"
		icon_male = 'MaleLight.dmi'
		icon_female = 'FemaleLight.dmi'
		desc = "These are humans."
		visual = 'Humans.png'

		passives = list("Desperation" = 1, "Adrenaline" = 0.5, "TechniqueMastery" = 5)
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1
		speed = 1
		anger = 1.2
		learning = 1.5

	saiyan
		name = "Saiyan"
		icon_male = 'MaleLight.dmi'
		icon_female = 'FemaleLight.dmi'
		desc = "These are saiyans."
		visual = 'Saiyan.png'
		locked = TRUE

		strength = 2
		endurance = 2
		force = 1
		offense = 1
		defense = 1
		speed = 1
		anger = 1.2
		learning = 1.5

		New()
			..()
			var/obj/tail = new
			tail.layer = RACIAL_FEATURES_LAYER
			tail.icon = 'Tail.dmi'

			overlays.Add(tail)

	namekian
		name = "Namekian"
		icon_neuter = 'Namek1.dmi'
		gender_options = list("Neuter")
		desc = "These are namekians."
		visual = 'Namek.png'

		strength = 2
		endurance = 2
		force = 1
		offense = 1
		defense = 1
		speed = 1
		anger = 1.2
		learning = 1.5