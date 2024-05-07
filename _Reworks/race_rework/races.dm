
/*
races are stored as text macros; this serves two purposes.
If a typo occurs, BYOND will throw errors.
This is also done so we can easily check types.
*/

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

		setRace(race/new_race, statRedo = FALSE)
			if(!new_race) throw EXCEPTION("setRace was not supplied a new_race argument!")
			if(!passive_handler) passive_handler = new

			if(race)
				race.onDeselection(src)

			race = new new_race.type
			race.onSelection(src)

		// isRace will accept either a type or a name.
		isRace(raceCheck)
			if(!race)
				throw EXCEPTION("[src] has no race to check!")
				// prob usually impossible
				return 0
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

		economy = 1

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
		var/list/ascpaths = subtypesof(text2path(replacetext("/ascension/[lowertext(name)]"," ", "_")))
		var/list/transpaths = subtypesof(text2path(replacetext("/transformation/[lowertext(name)]"," ", "_")))

		for(var/i in ascpaths)
			ascensions += new i
		for(var/i in transpaths)
			transformations += new i

	proc
		onDeselection(mob/user)
			user.overlays -= overlays

		onSelection(mob/user, secondtime = FALSE)
			if(!user.passive_handler) user.passive_handler = new

			if(user.Gender == "Female")
				user.icon = icon_female
			else if(user.Gender == "Male")
				user.icon = icon_male
			else if(user.Gender == "Neuter")
				user.icon = icon_neuter

			user.icon_state = null
			user.overlays += overlays

			user.AngerPoint = anger_point
			user.AngerMessage = anger_message
			if(!secondtime)
				user.SetStatPoints(statPoints)
				user.SetStat("Power", power)
				user.SetStat("Strength", strength)
				user.SetStat("Endurance", endurance)
				user.SetStat("Speed", speed)
				user.SetStat("Force", force)
				user.SetStat("Offense", offense)
				user.SetStat("Defense", defense)
			user.SetStat("Regeneration", regeneration)
			user.SetStat("Recovery", recovery)
			user.SetStat("Anger", anger)
			user.SetStat("Learning", learning)
			user.SetStat("Intellect", intellect)
			user.SetStat("Imagination", imagination)

			user.EconomyMult = economy

		onFinalization(mob/user)
			user.passive_handler.increaseList(passives)
			for(var/s in skills)
				user.AddSkill(new s)

	human
		name = "Human"
		desc = "Humans are stubborn, steadfast survivors crafted from the God of Truth's dying breath."
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
		desc = "Otherworldly outsiders, hailing from an empire of Yasai."
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

		onFinalization(mob/user)
			user.Tail(1)
			user.contents+=new/obj/Oozaru
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
		desc = "Primordial ooze given shape from the overuse of magic, given life by Aether."
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
		desc = "Dragons represent aspects of the world, said to be born of animosity. Reborn nearing times of great tragedy, they only regain their past lives of protecting the world at age 20."
		visual = 'Dragon.png'

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

		onFinalization(mob/user)
			user.Class = input(user,"Pick an element to represent you.", "Dragon Element") in list("Fire","Metal", "Gold", "Wind")
			switch(user.Class)
				if("Fire")
					skills = list(/obj/Skills/AutoHit/Fire_Breath, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Heat_Of_Passion)
					passives["DemonicDurability"] = 1
					passives["SpiritHand"] = 1
				if("Metal")
					skills = list(/obj/Skills/Projectile/Shard_Storm, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Dragons_Tenacity)
					passives["Hardening"] = 1
				if("Wind")
					skills = list(/obj/Skills/Projectile/Beams/Static_Stream, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Wind_Supremacy)
					passives["Godspeed"] = 1
					passives["Flicker"] = 1
				if("Gold")
					skills = list(/obj/Skills/Projectile/A_Pound_of_Gold, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Hoarders_Riches)
					user.EconomyMult *= 2
					passives["CashCow"] = 1
					passives["Blubber"] = 0.25
			..()

	eldritch
		name = "Eldritch"
		desc = "A race of beings that latch onto others, corrupting them like a parasite; usually being the result of such a thing."
		visual = 'Monster.png'

		passives = list("DebuffImmune" = 0.25, "VenomResistance" = 0.5, "Void" = 1, "SoulFire" = 0.3, "DeathField" = 0.3, "VoidField" = 0.3)

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

		onFinalization(mob/user)
			..()
			user.Secret="Eldritch"
			user.giveSecret("Eldritch")

	beastman
		name = "Beastman"
		desc = "Humanoids with a variety of animalistic traits dependent on their environment; often split into tribes of Tiger Tribe, Canine Tribe, and Bear Tribe."
		visual = 'Monstrous.png'

		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk)
		strength = 1.25
		endurance = 1.25
		force = 1.25
		offense = 1.25
		defense = 1.25
		speed = 1.25
		regeneration = 1.5
		intellect = 0.5

		onFinalization(mob/user)
			user.EnhancedSmell=1
			user.EnhancedHearing=1
			..()
	yokai
		name = "Yokai"
		desc = "Spirits said to be the children of the God of Time. Enslaved beneath the elves, these Yokai sport powerful magic; they remain convinced they are part of the harmony of the world."
		visual = 'Makyo.png'

		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form)
		passives = list("ManaGeneration" = 2, "TechniqueMastery" = 2)
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
		desc = "These spiritual beings are said to have arosen from nowhere, often taking up place as guardians of graveyards, spirit gates and temples."
		visual = 'Demon.png'

		strength = 1.5
		endurance = 1.5
		speed = 1
		force = 1.25
		offense = 1
		defense = 1
		imagination = 2

	high_faoroan
		name = "High Faoroan"
		desc = "The first creation of the God of Truth, able to speak truth into the world with their words. Known as the royalty of Kyoku."
		visual = 'Elf.png'

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
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/The_Crown)


	demon
		name = "Demon"
		desc = "Aspects of the Demon King's essence, shattered and splintered into their own forms until evolving into their own being."
		visual = 'Eldritch.png'

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
		passives = list("HellPower" = 1, "StaticWalk" = 1, "SpaceWalk" = 1, "CursedWounds" = 1)
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm, /obj/Skills/Buffs/SlotlessBuffs/Regeneration)
		onFinalization(mob/user)
			..()
			user.TrueName=input(user, "As a demon, you have a True Name that can be used to summon you by anyone with the magic and knowledge of it. It should be kept secret. What is your True Name?", "Get True Name") as text
			user << "The name by which you can be conjured is <b>[user.TrueName]</b>."
			global.TrueNames.Add(user.TrueName)

	alien
		name = "Alien"
		desc = "A broad term for a variety of spacefaring species or beings of otherwise unusual origin; the universe is vast and endless! Those that can not be defined by traditonal definitions fall into this category."
		power = 1
		strength = 0.5
		endurance = 0.5
		speed = 0.5
		offense = 0.5
		defense = 0.5
		force = 0.5
		regeneration = 1.5
		statPoints = 20

		onFinalization(mob/user)
			user.Class = input(user,"What is your alien racial?", "Choose!")in list ("ESP", "Infusion", "Adrenaline", "Infernal", "Celestial", "Prodigy", "Warper", "Winged", "Multi-Limbed", "Morphic" )
			switch(user.Class)
				if("ESP")
					skills = list(/obj/Skills/Telekinesis)
					skills = list(/obj/Skills/Utility/Telepathy)
				if("Infusion")
					passives = list("Infusion" = 1)
				if("Adrenaline")
					passives = list("Adrenaline" = 1)
				if("Infernal")
					passives = list("HellPower" = 0.1)
				if("Celestial")
					passives = list("SpiritPower" = 0.1)
				if("Prodigy")
					passives =	list("LegendPower" = 0.1)
				if("Warper")
					passives = list("Flicker" = 2)
				if("Winged")
					skills = list (new/obj/Skills/Buffs/SlotlessBuffs/Soar)
					passives = list("SuperDash" = 1)
				if("Multi-Limbed")
					passives = list("DoubleStrike" = 1, "TripleStrike" = 0.25)
				if("Morphic")
					passives = list("SwordHand" = 1)
			..()

	namekian
		name = "Namekian"
		icon_neuter = 'Namek1.dmi'
		gender_options = list("Neuter")
		desc = "Outsiders from a realm named Gaia, refugees sent to prosper on Copenlagen. These often take on humanoid features with skin tones from green to blue."
		visual = 'Namek.png'

		power = 2
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
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Regeneration, /obj/Skills/Queue/Infestation)
		/* /obj/Skills/AutoHit/AntennaBeam */

		onFinalization(mob/user)
			user.EnhancedHearing = 1
			for(var/obj/Skills/Buffs/SlotlessBuffs/Regeneration/r in user)
				r.RegenerateLimbs=1

			user.Class = input("What clan do you hail from?", "Clan Selection")in list("Warrior", "Dragon", "Demon")
			switch(user.Class)
				if("Warrior")
					strength += 0.5
					user.StrMod += 0.5
					endurance += 0.25
					user.EndMod += 0.25
				if("Dragon")
					force += 0.5
					user.ForMod += 0.5
					defense += 0.25
					user.DefMod += 0.25
				if("Demon")
					speed += 0.5
					user.SpdMod += 0.5
					offense += 0.25
					user.OffMod += 0.5
			..()

	changeling
		locked = TRUE
		name = "Changeling"
		icon_neuter	=	"Chilled1.dmi"
		gender_options = list("Neuter")
		desc	=	"A strange and adaptive race from the far reaches of deep space, little is none of these mysterious beings other than they are new to the general galactic population!"
		visual	=	'Changeling.png'

		strength	=	1.75
		endurance	=	1
		force	=	1.75
		offense	=	1.5
		defense	=	1
		speed	=	1.75
		anger	=	1

		onFinalization(mob/user)
			passives=list("Xenobiology" = 1)


	gajalaka
		name="Gajalaka"
		icon_neuter='Gajalaka.dmi'
		desc = "Thrifty kobold-like beings, seemingly unimpressive in stature.."
		visual = 'Gajalaka.png'
		passives = list("CashCow" = 1, "Blubber" = 0.25)
		power = 0.75
		strength = 0.75
		endurance = 0.75
		speed = 0.75
		offense = 0.75
		defense = 0.75
		force = 0.75
		intellect = 1.5
		imagination = 1.5
		skills = list(/obj/Skills/Projectile/Goblin_Greed, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/The_Power_Of_Shiny)

		onFinalization(mob/user)
			user.EnhancedSmell=1
			user.EnhancedHearing = 1
			user.EconomyMult *= 2
			user.CyberizeMod = 0.5
			..()