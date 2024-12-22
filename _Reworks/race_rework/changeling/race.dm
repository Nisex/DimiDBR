#warn NERF CHANGELINGS TO SCALE BIOARMOR BETTER WITH ASCENSIONS & POTENTIAL

race
	changeling
		locked = TRUE
		name = "Changeling"
		icon_neuter	=	list('Chilled1.dmi')
		gender_options = list("Neuter")
		desc	=	"Twisted and changed by Mortis’ influence, these poor souls have been splintered into entities that mutate and evolve to match the harshest of conditions. Their body is often covered in a thick hide to be shed."
		visual	=	'Changeling.png'

		passives = list("Xenobiology" = 1, "Juggernaut" = 1, "CriticalBlock" = 0.25, "BlockChance" = 0.25, "PureReduction" = 3, "PureDamage" = -5, "AllOutAttack" = 1, "MovementMastery" = -8)
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