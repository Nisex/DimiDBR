race
	namekian
		name = "Namekian"
		icon_neuter = list('Namek1.dmi')
		gender_options = list("Neuter")
		desc = "A race that once came from distant stars, now fully sublimated into Copenlagen. Though many have mutated into slug-like beings, they share many traits unique to plant-life and possess a unique affinity with nature."		visual = 'Namek.png'

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
