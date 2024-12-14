
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
			var/list/male_icons = list()
			var/list/female_icons = list()
			var/list/neuter_icons = list()
			for(var/male_icon in races[races.len]:icon_male)
				var/obj/race_grid_visual/visual = new(male_icon)
				male_icons += visual
			for(var/female_icon in races[races.len]:icon_female)
				var/obj/race_grid_visual/visual = new(female_icon)
				female_icons += visual
			for(var/neuter_icon in races[races.len]:icon_neuter)
				var/obj/race_grid_visual/visual = new(neuter_icon)
				neuter_icons += visual
			races[races.len]:icon_male = male_icons.Copy()
			races[races.len]:icon_female = female_icons.Copy()
			races[races.len]:icon_neuter = neuter_icons.Copy()
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


/mob/Admin4/verb/forceCuckRace(mob/Players/P in players)
	P.race = new()




world
	New()
		..()
		BuildRaceList()

obj
	race_grid_visual
		New(icon/i)
			icon = i
			name = " "

		Click()
			..()
			usr.icon = icon
			if(istype(usr, /mob/Creation))
				usr<<output(usr, "IconUpdate:1,[usr]")
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
		list/icon_male = list('frisky-male_black_brown.dmi', 'frisky-male_dark_brown.dmi', 'frisky-male_pale_brown.dmi', 'frisky-male_tan_brown.dmi', 'frisky-male_white_brown.dmi')
		//the icon used for female gender.
		list/icon_female = list('frisky-femmale_black_brown.dmi', 'frisky-femmale_dark_brown.dmi', 'frisky-femmale_pale_brown.dmi', 'frisky-femmale_tan_brown.dmi', 'frisky-femmale_white_brown.dmi')
		//icon used for neuter gender.
		list/icon_neuter = list()

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

		onSelection(mob/user, secondtime = FALSE, force_icon = FALSE)
			if(!user.passive_handler) user.passive_handler = new


			if(force_icon||!user.icon)
				if(user.Gender == "Female")
					var/chosen = rand(1,icon_female.len)
					user.icon = icon_female[chosen]
				else if(user.Gender == "Male")
					var/chosen = rand(1,icon_male.len)
					user.icon = icon_male[chosen]
				else if(user.Gender == "Neuter")
					var/chosen = rand(1,icon_neuter.len)
					user.icon = icon_neuter[chosen]

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

		onAnger(mob/user)

		onCalm(mob/user)
	human
		name = "Human"
		desc = "Enhanced during cryo sleep, your DNA is the most pure. There were no downsides to your enhancement. You can do things that movie characters could, but retain your shape completely."
		visual = 'Humans.png'

		passives = list("Desperation" = 1, "Adrenaline" = 0.5, "TechniqueMastery" = 2,"Innovation" = 1)
		power = 1
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1.25
		speed = 1
		anger = 1.5
		learning = 1


	half_saiyan
		name = "Half_Saiyan"
		desc = "A product of inter-breeding or genetic experiments, you could be a child unaware of his heritage living in Elysium, surviving among the Necromorphs on Vegeta, or a lab experiment in a vat. This race should not have been created, but it was."
		visual = 'Halfie.png'

		locked = TRUE
		power = 2
		strength = 1.25
		endurance = 1.25
		force = 1.25
		offense = 1
		defense = 1.5
		speed = 1
		anger = 1.5
		regeneration = 1.5
		imagination = 1
		intellect = 1
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Oozaru)
		passives = list("Desperation" = 0.5, "TechniqueMastery" = 1, "Brutalize" = 0.25, "Adrenaline" = 0.25)

		onFinalization(mob/user)
			..()
			user.Tail(1)
			var/list/transpaths = subtypesof(text2path("/transformation/saiyan"))
			for(var/i in transpaths)
				transformations += new i




	saiyan
		name = "Saiyan"
		desc = "They are the victims of the cosmic horror, their entire race has been destroyed. While the \[REDACTED\] wished to \[REDACTED\], it did not foresee that they would be far too gifted at destruction to \[REDACTED\] \n\[REDACTED\] grasped their most empowering legend of the Super Saiyan, and used it to its advantage, practically ending the Saiyan race and besmirching its legacy forever."
		visual = 'Saiyan.png'

		locked = TRUE

		strength = 1.5
		endurance = 1.5
		force = 1.5
		offense = 1
		defense = 1
		speed = 1
		anger = 1.5
		regeneration = 1.5
		imagination = 0.5
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Oozaru)
		passives = list("Brutalize" = 0.25)

		onFinalization(mob/user)
			..()
			user.Tail(1)
//			user.contents+=new/obj/Oozaru

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

		passives = list("StaticWalk" = 1, "Steady" = 1)
		skills = list(/obj/Skills/Absorb, /obj/Skills/Buffs/SlotlessBuffs/Regeneration)

		locked = TRUE
		intellect = 0.25
		imagination = 4
		anger = 1.5
		regeneration = 3
		strength = 1.25
		endurance = 1
		speed = 1
		force = 1.25
		offense = 1.25
		defense = 1.25

		onFinalization(mob/user)
			..()
			if(!user.majinPassive)
				user.majinPassive = new(user)
			if(!user.majinAbsorb)
				user.majinAbsorb = new()
				user.findAlteredVariables()


	dragon
		name = "Dragon"
		desc = "Dragons represent aspects of the world, said to be born of animosity. Reborn nearing times of great tragedy, they only regain their past lives of protecting the world at age 20."
		visual = 'Dragon.png'

		locked = TRUE

		power = 5
		strength = 1.75
		endurance = 1.75
		speed = 1
		force = 1.75
		offense = 1.25
		defense = 1.25
		regeneration = 2
		recovery = 2
		imagination = 2

		onFinalization(mob/user)
			user.Class = input(user,"Pick an element to represent you.", "Dragon Element") in list("Fire","Metal", "Gold", "Wind", "Poison", "Water")
			switch(user.Class)
				if("Fire")
					skills = list(/obj/Skills/AutoHit/Dragon_Roar, /obj/Skills/AutoHit/Fire_Breath, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Heat_Of_Passion)
					passives["DemonicDurability"] = 1
					passives["SpiritHand"] = 1
				if("Metal")
					skills = list(/obj/Skills/AutoHit/Dragon_Roar, /obj/Skills/Projectile/Shard_Storm, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Dragons_Tenacity)
					passives["Hardening"] = 1
				if("Wind")
					skills = list(/obj/Skills/AutoHit/Dragon_Roar, /obj/Skills/Projectile/Beams/Static_Stream, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Wind_Supremacy)
					passives["Godspeed"] = 1
					passives["Flicker"] = 1
				if("Water")
					skills = list(/obj/Skills/AutoHit/Dragon_Roar, /obj/Skills/AutoHit/Oceanic_Wrath, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Slithereen_Crush)
					passives["SoftStyle"] = 1
					passives["Fishman"] = 1
					passives["FluidForm"] = 1
				if("Gold")
					skills = list(/obj/Skills/AutoHit/Dragon_Roar, /obj/Skills/Projectile/A_Pound_of_Gold, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Hoarders_Riches)
					user.EconomyMult *= 2
					passives["CashCow"] = 1
					passives["Blubber"] = 0.25
				if("Poison")
					skills = list(/obj/Skills/AutoHit/Dragon_Roar, /obj/Skills/AutoHit/Poison_Gas, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Melt_Down)
			..()

	eldritch
		name = "Eldritch"
		desc = " Beings that were near the impact site when the meteor destroyed Mexico. They were infected with whatever infected the other organisms on Earth and have gained potent abilities as a result, at the cost of \[REDACTED\]."
		visual = 'Monster.png'

		passives = list("VenomResistance" = 0.25, "Void" = 1, "SoulFire" = 0.25, "DeathField" = 0.5, "VoidField" = 0.5)
		locked = TRUE
		strength = 1.5
		endurance = 2
		speed = 1
		force = 1.5
		offense = 1.5
		defense = 1.5
		regeneration = 2.5
		anger = 1
		intellect = 1.5
		imagination = 0.67

		onFinalization(mob/user)
			..()
			user.Secret="Eldritch"
			user.giveSecret("Eldritch")
			user.secretDatum.nextTierUp = 999

	beastman
		name = "Beastman"
		desc = "Oops. You remember being human. So why do you have some beastlike features?"
		visual = 'Monstrous.png'

		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk,/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Ticking_Bomb)
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
		desc = "Spirits forcefully taken from Earth. You had a glorious, immortal form before. You could enjoy the pleasures of the cosmos, and adopt a physical form briefly to enjoy the pleasures of the flesh. \nNow? You are human, only capable of accessing your former spiritual glory for brief instants."
		visual = 'Makyo.png'

		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form)
		passives = list("ManaGeneration" = 2)
		strength = 1.5
		endurance = 1
		speed = 1
		force = 0.75
		offense = 1.75
		defense = 1
		regeneration = 2
		imagination = 1.5

	makyo
		name = "Makyo"
		desc = "These spiritual beings are said to have arosen from nowhere, often taking up place as guardians of graveyards, spirit gates and temples."
		visual = 'Demon.png'

		locked = TRUE
		strength = 2
		endurance = 2
		speed = 0.75
		force = 1
		offense = 1.25
		defense = 0.5
		imagination = 2

	high_faoroan
		name = "High Faoroan"
		desc = "elfs lol"
		visual = 'Elf.png'

		icon_male = list('MaleElf1.dmi', 'MaleElf2.dmi', 'MaleElf3.dmi', 'MaleElf4.dmi', 'MaleElf5.dmi')
		icon_female = list('FemElf1.dmi', 'FemElf2.dmi', 'FemElf3.dmi', 'FemElf4.dmi', 'FemElf5.dmi')
		locked = TRUE

		power = 5
		strength = 1.5
		endurance = 1.5
		speed = 1.5
		offense = 1
		defense = 2
		force = 1.5
		regeneration = 3
		imagination = 2
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/The_Crown)
		passives = list("Adrenaline" = 1, "Innovation" = 1)


	demon
		name = "Demon"
		desc = "Aspects of the Demon King's essence, shattered and splintered into their own forms until evolving into their own being."
		visual = 'Eldritch.png'
		locked = TRUE
		power = 5
		strength = 2
		endurance = 1.5
		speed = 1.5
		offense = 1.5
		defense = 1
		force = 2
		regeneration = 3
		imagination = 2

		passives = list("AbyssMod" = 0.5, "Corruption" = 1, "StaticWalk" = 1, "SpaceWalk" = 1, "CursedWounds" = 1, "FakePeace" = 1, "MartialMagic" = 1)
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2,/obj/Skills/Utility/Imitate,  /obj/Skills/Buffs/SlotlessBuffs/Regeneration, /obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon, \
						/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/DarkMagic, /obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire, /obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Corruption)
		var/devil_arm_upgrades = 1
		var/sub_devil_arm_upgrades = 0

		proc/findTrueForm(mob/p)
			var/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon/d = new()
			d = locate() in p
			if(!d)
				world.log << "There was an error finding [p]'s ture form, please fix as their ascension is likely bugged"
				p << "Please report to the admin or discord that your true form is bugged on asc"
			return d


		proc/checkReward(mob/p)
			var/max = round(p.Potential / 5) + 1
			if(p.Potential % 5 == 0 || devil_arm_upgrades < max)
				var/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2/da = p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2)
				if(devil_arm_upgrades + 1 > max) // not even possible
					return
				devil_arm_upgrades = max
				p << "Your devil arm evolves, toggle it on and off to use it"
				if(da.secondDevilArmPick)
					if(sub_devil_arm_upgrades < round((p.Potential - ASCENSION_TWO_POTENTIAL) / 10) + 1)
						if(p.Potential - ASCENSION_TWO_POTENTIAL % 10 == 0)
							sub_devil_arm_upgrades = round((p.Potential - ASCENSION_TWO_POTENTIAL) / 10) + 1
							p << "Your secondary devil arm evolves, toggle it on and off to use it"



		onFinalization(mob/user)
			..()
			user.EnhancedSmell = 1
			user.EnhancedHearing = 1
			user.TrueName=input(user, "As a demon, you have a True Name. It should be kept secret. What is your True Name?", "Get True Name") as text
			user << "The name by which you can be conjured is <b>[user.TrueName]</b>."
			user << "Please set macros for (Dark Magic), (Hell Fire) and (Corruption), your 3 demon magics."
			global.TrueNames.Add(user.TrueName)
			user.client.updateCorruption()
			user.demon.selectPassive(user, "CORRUPTION_PASSIVES", "Buff", TRUE)
			user.demon.selectPassive(user, "CORRUPTION_DEBUFFS", "Debuff")

	alien
		name = "Alien"
		desc = "A broad term for a variety of spacefaring species or beings of otherwise unusual origin; the universe is vast and endless! Those that can not be defined by traditonal definitions fall into this category."
		
		locked = TRUE
		power = 1
		strength = 0.5
		endurance = 0.5
		speed = 0.5
		offense = 0.5
		defense = 0.5
		force = 0.5
		regeneration = 1.5
		statPoints = 20

		locked = 1

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
		icon_neuter = list('Namek1.dmi')
		gender_options = list("Neuter")
		desc = "You remember being human. Why have you mutated like this? You are so much more in tune with nature. Though you are still made of flesh and bone, you have mutated to be akin to a druid from celtic myth. "
		visual = 'Namek.png'

		power = 2
		strength = 1.5
		endurance = 0.75
		force = 1.5
		offense = 1.25
		defense = 1.25
		speed = 1.25
		anger = 1.5
		imagination = 2
		intellect = 1.5
		learning = 1
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Regeneration, /obj/Skills/Queue/Infestation)
		/* /obj/Skills/AutoHit/AntennaBeam */

		onFinalization(mob/user)
			..()
			user.EnhancedHearing = 1 // ???????????????
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

	changeling
		locked = TRUE
		name = "Changeling"
		icon_neuter	=	list('Chilled1.dmi')
		gender_options = list("Neuter")
		desc	=	"A strange and adaptive race from the far reaches of deep space, little is none of these mysterious beings other than they are new to the general galactic population!"
		visual	=	'Changeling.png'

		passives = list("Xenobiology" = 1, "CriticalBlock" = 0.25, "BlockChance" = 0.25, "PureReduction" = 3, "PureDamage" = -5, "AllOutAttack" = 1, "MovementMastery" = -8)
		statPoints = 4
		strength	=	0.25
		endurance	=	2
		force	=	0.25
		offense	=	1.5
		defense	=	1
		speed	=	1.75
		anger	=	1
		anger_point = 25
		anger_message = "will not stand for this mockery!!"

		onFinalization(mob/user)
			. = ..()
			user.transUnlocked = 3
			user.Intimidation = 50
			user.BioArmorMax = 250
			user.BioArmor = user.BioArmorMax

		onAnger(mob/user)
			. = ..()
			user.GetAndUseSkill(/obj/Skills/AutoHit/Imperial_Wrath, user.AutoHits, TRUE)
			StunClear(user)
			user.passive_handler.Increase("TeamHater", 1)
			if(user.Launched)
				LaunchEnd(user)
		
		onCalm(mob/user)
			user.passive_handler.Decrease("TeamHater", 1)

	gajalaka
		name="Gajalaka"
		icon_neuter= list('Gajalaka.dmi', 'Gaja EX.dmi', 'Gaja EX Maim.dmi')
		desc = "Thrifty kobold-like beings, seemingly unimpressive in stature.."
		visual = 'Gajalaka.png'
		passives = list("CashCow" = 1, "Blubber" = 0.25)
		locked = TRUE
		power = 0.75
		strength = 0.75
		endurance = 0.75
		speed = 0.75
		offense = 0.75
		defense = 0.75
		force = 0.75
		intellect = 0.75
		imagination = 1.5
		skills = list(/obj/Skills/Projectile/Goblin_Greed, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/The_Power_Of_Shiny)

		onFinalization(mob/user)
			user.EnhancedSmell=1
			user.CyberizeMod = 0.5
			user.contents += new/obj/Items/Wearables/Icon_67
			user.contents += new/obj/Items/Wearables/Icon_68
			user.contents += new/obj/Items/Wearables/Icon_69
			user.contents += new/obj/Items/Wearables/Icon_70
			..()

	android
		name = "Android"
		desc = "They are programmed with the directive to protect human-kind. \nMost of them look like toasters, and most of them are mere service models that act like a certain golden android from a popular franchise. While there are rumors of more humanoid Androids, they are typically spread by nutjobs who fear being replaced."
		visual = 'Demon.png'

		locked = TRUE
		strength = 0.5
		endurance = 0.5
		speed = 0.5
		offense = 0.5
		defense = 0.5
		force = 0.5
		regeneration = 1.5
		statPoints = 25
		anger = 1
		imagination = 0.05
		anger_message = "calculates the ideal path to victory."
		passives = list("TechniqueMastery" = 3, "MovementMastery" = 2, "PureDamage" = 1, "PureReduction" = 1, "Flicker" = 2)
		skills = (/obj/Skills/Utility/Android_Integration)

	shinjin
		name = "Shinjin"
		desc = "shinjin things man lol"
		visual = 'Humans.png'

		locked = 1

		power = 1
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1.25
		speed = 1
		anger = 1.5
		learning = 1
		onFinalization(mob/user)
			user.AddSkill(new/obj/Skills/Utility/Telepathy)
			user.AddSkill(new/obj/Skills/Utility/Sense)
			user.AddSkill(new/obj/Skills/Telekinesis)
			user.AddSkill(new/obj/Skills/Utility/Observe)
			user.AddSkill(new/obj/Skills/Utility/Keep_Body)
			user.AddSkill(new/obj/Skills/Reincarnation)
			user.AddSkill(new/obj/Skills/Utility/Teachz)
			user.Timeless = 1
			var/Choice
			var/Confirm
			while(Confirm!="Yes")
				Choice=input(user, "Which realm do you swear your loyalty to?", "Shinjin Ascension") in list("Kai", "Makai")
				switch(Choice)
					if("Kai")
						Confirm=alert(user, "Do you pledge your allegiance to the continuity and propserity of the Living Realm?", "Shinjin Ascension", "Yes", "No")
					if("Makai")
						Confirm=alert(user, "Do you pledge your allegiance to the expansion and domination of the Demon Realm?", "Shinjin Ascension", "Yes", "No")
			if(Choice=="Kai")
				user.passive_handler.Increase("SpiritPower", 1)
				user.passive_handler.Increase("CalmAnger", 1)
			if(Choice=="Makai")
				user.passive_handler.Increase("HellPower", 1)
				user.passive_handler.Increase("StaticWalk", 1)
				anger = 2
				user.NewAnger(2)
				user.Intimidation=10
				user.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Majin)
			user.ShinjinAscension = Choice
			var/pickedPath = input(user, "Pick a Kaio Direction.") in list("North", "East", "South", "West")
			user.Class = pickedPath
			switch(pickedPath)
				if("North")
					user.Restoration=1
					user.Attunement="Earth"
					user.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Kaioken)
					user.AddSkill(new/obj/Skills/Projectile/Genki_Dama)
					var/obj/Skills/Buffs/NuStyle/UnarmedStyle/North_Star_Style/nss=new/obj/Skills/Buffs/NuStyle/UnarmedStyle/North_Star_Style
					user.AddSkill(nss)
				if("East")
					user.OxygenMax*=4
					user.passive_handler.Increase("SpaceWalk", 1)
					user.Attunement = "Wind"
					user.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Toppuken)
					user.AddSkill(new/obj/Skills/AutoHit/Gwych_Dymestl)
					var/obj/Skills/Buffs/NuStyle/UnarmedStyle/East_Star_Style/ess=new/obj/Skills/Buffs/NuStyle/UnarmedStyle/East_Star_Style
					user.AddSkill(ess)
				if("South")
					user.Attunement="Fire"
					user.passive_handler.Increase("WalkThroughHell", 1)
					user.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Rekkaken)
					user.AddSkill(new/obj/Skills/Projectile/Zone_Attacks/Global_Devastation)
					var/obj/Skills/Buffs/NuStyle/SwordStyle/South_Star_Style/sss=new/obj/Skills/Buffs/NuStyle/SwordStyle/South_Star_Style
					user.AddSkill(sss)
				if("West")
					user.Attunement = "Water"
					user.passive_handler.Increase("WaterWalk", 1)
					user.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Kyoukaken)
					user.AddSkill(new/obj/Skills/AutoHit/Great_Deluge)
					var/obj/Skills/Buffs/NuStyle/FreeStyle/West_Star_Style/wss=new/obj/Skills/Buffs/NuStyle/FreeStyle/West_Star_Style
					user.AddSkill(wss)
			..()