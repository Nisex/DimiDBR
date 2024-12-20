race
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