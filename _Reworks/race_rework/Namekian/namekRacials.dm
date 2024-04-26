/obj/Skills/Queue/Infestation
	DamageMult = 1.5
	AccuracyMult = 5
	Cooldown = 120
	proc/adjust(mob/p)
		// make it scale per ascen, alter how it works between warrior / dragon
		DamageMult = 1.5 + (p.AscensionsAcquired * 0.5)
		Cooldown = 120 - (15 * p.AscensionsAcquired)
		switch(p.Class)
			if("Dragon")
				ManaGain = p.AscensionsAcquired * 2 // surely this will be no issue
				SpiritHand = 0.5 * p.AscensionsAcquired
				Paralyzing = 2.5 * p.AscensionsAcquired
				if(p.counterpart && inParty(p.counterpart))
					Cooldown = clamp(120 - (20 * p.AscensionsAcquired), 30, 120)
					ManaGain = 2 + (p.AscensionsAcquired * 2)
					Paralyzing = 5 * p.AscensionsAcquired
					var/mob/Player/cp = findPlayer(p.counterpart)
					if(cp && cp.Class == "Warrior")
						// apply warrior boons here
						Crippling = 2.5 * p.AscensionsAcquired
						Toxic = 2.5 * p.AscensionsAcquired
						Combo = 1 + p.AscensionsAcquired
						DamageMult = (1 + (p.AscensionsAcquired)) / Combo // i think these are low per niezan's changes (?)
						if(p.AscensionsAcquired >= 4)
							PridefulRage = 1
					else
						ManaGain = 5 + (p.AscensionsAcquired * 3)
						SpiritHand = 1 * p.AscensionsAcquired
						Paralyzing = 10 * p.AscensionsAcquired
			if("Warrior")
				Crippling = 2.5 * p.AscensionsAcquired
				Toxic = 2.5 * p.AscensionsAcquired
				Combo = 1 + p.AscensionsAcquired
				DamageMult = (1 + (p.AscensionsAcquired)) / Combo
				if(p.counterpart && inParty(p.counterpart))
					Cooldown = clamp(120 - (20 * p.AscensionsAcquired), 30, 120)
					Toxic = 5 * p.AscensionsAcquired
					Combo = 2 * p.AscensionsAcquired
					DamageMult = (2 + p.AscensionsAcquired) / Combo
					var/mob/Player/cp = findPlayer(p.counterpart)
					if(cp && cp.Class == "Warrior")
						Toxic = 10 * p.AscensionsAcquired
						Combo = 2 * p.AscensionsAcquired
						DamageMult = (p.AscensionsAcquired + 3) / Combo
						if(p.AscensionsAcquired >= 3)
							Cooldown = clamp(120 - (5 * p.AscensionsAcquired), 30, 120)
							PridefulRage = p.AscensionsAcquired - 2 // 1 at 3, 2 at 4&5
					else
						ManaGain = p.AscensionsAcquired * 2 
						SpiritHand = 0.5 * p.AscensionsAcquired
						Paralyzing = 2.5 * p.AscensionsAcquired
						if(p.AscensionsAcquired >= 4)
							PridefulRage = 1


//TODO: add inParty & findPlayer
	