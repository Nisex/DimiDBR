obj
	Skills
		Buffs
			SlotlessBuffs
				Heavenly_Reversal
					adjust(mob/p)
						if(p.Secret != "Heavenly Restriction") del src
						if(!p.secretDatum?:hasImprovement("Reverse Dash")) del src
						var/boon = p.secretDatum?:getBoon(p,"Reverse Dash")
						passives = list("Godspeed" = boon, "Juggernaut" = boon)
						TimerLimit = boon
					Trigger(mob/p, Override = 0)
						if(!p.BuffOn(src))
							adjust(p)
						..()