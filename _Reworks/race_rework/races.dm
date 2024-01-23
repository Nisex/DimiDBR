
/*
races are stored as text macros; this serves two purposes.
If a typo occurs, BYOND will throw errors.
This is also done so we can easily check types.
*/
#define HUMAN /race/human
#define SAIYAN /race/saiyan
#define NAMEKIAN /race/namekian

var/list/races = list()

proc
	//this adds a copy of all races to a global list called races.
	BuildRaceList()
		for(var/a in subtypesof(/race/))
			races += new a

	//this will return a list of all race types.
	GetRaceTypes()
		for(var/race/race in races)
			. += race.type

	// if you want to get a global race from a type path, use this.
	//it will return the race instance from the global list; or null if not found.
	GetRaceInstanceFromType(_type)
		for(var/race/race in races)
			if(race.type == _type)
				return race
		return null

	//if you want to get the global race from it's name, use this.
	// this will return a matching race if found, or null if not found.
	GetRaceInstanceFromName(_name)
		for(var/race/race in races)
			if(race.name == _name)
				return race
		return null

world
	New()
		..()
		BuildRaceList()

mob
	var
		race/race

mob
	proc

		setRace(race/new_race, creationFinalized = FALSE, statRedo = FALSE)
			if(!new_race) throw EXCEPTION("setRace was not supplied a new_race argument!")
			if(!passive_handler) passive_handler = new

			if(!statRedo)
				if(race)
					overlays -= race.overlays
					passive_handler.decreaseList(race.passives)
					for(var/obj/Skills/s in race.skills)
						DeleteSkill(s)

				race = new new_race.type

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

			if(!creationFinalized)
				SetStatPoints(race.statPoints)
				SetStat("Power", race.power)
				SetStat("Strength", race.strength)
				SetStat("Endurance", race.endurance)
				SetStat("Speed", race.speed)
				SetStat("Force", race.force)
				SetStat("Offense", race.offense)
				SetStat("Defense", race.defense)
				SetStat("Regeneration", race.regeneration)
				SetStat("Recovery", race.recovery)
				SetStat("Anger", race.anger)
				SetStat("Learning", race.learning)
				SetStat("Intellect", race.intellect)
				SetStat("Imagination", race.imagination)

			else if(!statRedo)
				passive_handler.increaseList(race.passives)
				for(var/obj/Skills/s in race.skills)
					AddSkill(s)

		// isRace will accept either a type or a name.
		isRace(raceCheck)
			/*
				return:
					1 if match is found
					0 if not found
					throws a exception if no race is supplied for checking.
			*/
			if(!raceCheck) throw EXCEPTION("isRace was not supplied a raceCheck argument!")
			if(race.type == raceCheck || race.name == raceCheck) return 1
			return 0

race
	var
		// the formal name for the race
		name = ""

		//gender options. so far implemented ones are Male, Female & Neuter. Neuter is for namekians or so on.
		gender_options = list("Male", "Female")
		//the icon used for male gender
		icon_male = 'MaleLight.dmi'
		//the icon used for female gender.
		icon_female = 'FemaleLight.dmi'
		//icon used for neuter gender.
		icon_neuter

		//this determines if the race is a 'rare' and is only unlocked via someone's key being in the LockedRaces list.
		locked = FALSE

		//a text description for the race; displayed to the user.
		desc
		//a picture used for the racial menu.
		visual

		//default health/energy/mana
		health = 100
		energy = 100
		mana = 100

		power = 2

		statPoints = 10

		//1 = 1 for these.
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1
		speed = 1

		anger_message = "becomes angry!"
		anger_point = 50

		//anger. 1 = 100%, 2 = 200%
		anger = 1.5
		regeneration = 1
		recovery = 2

		learning = 1
		intellect = 1
		imagination = 1

		// a list of overlays; such as saiyan tails, or so on.
		//TODO: Implement better.
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
		/*
			ensure the race's name variable is the same as the ascensions/transformation type.
			if it isn't, you have to manually add them.
			this is so it's very easy and automatic to throw ascensions in and out.
		*/
		ascensions = subtypesof(text2path("/ascension/[lowertext(name)]"))
		transformations = subtypesof(text2path("/transformation/[lowertext(name)]"))
		for(var/i in ascensions)
			ascensions[i] = new i
		for(var/i in transformations)
			transformations[i] = new i

	human
		name = "Human"
		desc = "These are humans."
		visual = 'Humans.png'

		passives = list("Desperation" = 1, "Adrenaline" = 0.5, "TechniqueMastery" = 5)
		power = 1
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
		desc = "These are saiyans."
		visual = 'Saiyan.png'
		locked = TRUE

		strength = 1.5
		endurance = 1.5
		force = 1.25
		offense = 1
		defense = 0.75
		speed = 1
		anger = 1.5
		regeneration = 1.5
		imagination = 0.5

	/*
		TODO: think of a better way to handle racial features.
		New()
			..()
			var/obj/tail = new
			tail.layer = RACIAL_FEATURES_LAYER
			tail.icon = 'Tail.dmi'

			overlays.Add(tail)
	*/

	majin
		name = "Majin"
		desc = "These are majins."
		visual = 'Majins.png'
		locked = TRUE
		passives = list("StaticWalk" = 1, "Steady" = 1)
		skills = list(/obj/Skills/Absorb, /obj/Skills/Buffs/SlotlessBuffs/Regeneration)


		intellect = 0.25
		imagination = 4
		anger = 1.3
		regeneration = 3
		strength = 1.25
		endurance = 1
		speed = 1
		force = 1.25
		offense = 1.25
		defense = 1.25

	dragon
		name = "Dragon"
		desc = "These are dragons."
		locked = TRUE

		power = 5
		strength = 1.5
		endurance = 1.5
		speed = 1.5
		force = 1.5
		offense = 2
		defense = 1.5
		regeneration = 3
		recovery = 3
		anger = 2
		imagination = 2

	eldritch
		name = "Eldritch"
		desc = "These are eldritches."
		strength = 1.5
		endurance = 2
		speed = 1
		force = 1
		offense = 2
		defense = 2
		regeneration = 2.5
		anger = 1
		intellect = 1.5
		imagination = 0.67

	beastman
		name = "Beastman"
		desc = "These are Beastmen."

		strength = 1.25
		endurance = 1.25
		force = 1.25
		offense = 1.25
		defense = 1.25
		speed = 1.25
		regeneration = 1.5
		intellect = 0.5

	yokai
		name = "Yokai"
		desc = "These are Yokai."

		strength = 2
		endurance = 1.5
		speed = 1
		force = 0.5
		offense = 1.25
		defense = 1
		regeneration = 2
		imagination = 1.5

	makyo
		name = "Makyo"
		desc = "These are Makyo."
		strength = 1.5
		endurance = 1.5
		speed = 1
		force = 1.25
		offense = 1
		defense = 1
		imagination = 2

	high_faoroan
		name = "High Faoroan"
		desc = "These are Elves."
		locked = TRUE

		power = 5
		strength = 1.5
		endurance = 1.5
		speed = 1.5
		offense = 1
		defense = 2
		force = 1.5
		anger = 2
		regeneration = 3
		imagination = 2

	demon
		name = "Demon"
		desc = "These are Demons."
		locked = TRUE

		power = 5
		strength = 1.5
		endurance = 1.5
		speed = 1.5
		offense = 2
		defense = 1.5
		force = 1.5
		anger = 2
		regeneration = 3
		imagination = 2

	alien
		name = "Alien"
		desc = "These are Aliens."
		power = 1
		strength = 0.5
		endurance = 0.5
		speed = 0.5
		offense = 0.5
		defense = 0.5
		force = 0.5
		regeneration = 1.5

	namekian
		name = "Namekian"
		icon_neuter = 'Namek1.dmi'
		gender_options = list("Neuter")
		desc = "These are namekians."
		visual = 'Namek.png'

		strength = 1.5
		endurance = 0.75
		force = 1.5
		offense = 1.25
		defense = 1.5
		speed = 1.5
		anger = 1.25
		imagination = 2
		intellect = 1.5
		learning = 1.5