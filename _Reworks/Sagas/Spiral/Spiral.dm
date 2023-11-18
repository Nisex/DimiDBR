mob/proc
	GetTopStats()
		var/list/stats = list("Strength"=src.GetStr(), "Endurance"=src.GetEnd(), "Force"=src.GetFor(), "Speed"=src.GetSpd(), "Offense"=src.GetOff(), "Defense"=src.GetDef())
		var/i,j
		for(i=1; i<=stats.len; i++)
			for(j=1; j<=stats.len; j++)
				if(stats[stats[j]] < stats[stats[i]])
					stats.Swap(i, j)

		return stats
	GetStatMult(var/string, var/obj/Skills/Buffs/SpecialBuff/obj)
		switch(string)
			if("Strength")
				obj.StrMult = 1.2 + (0.1 * src.SagaLevel)
			if("Endurance")
				obj.EndMult = 1.2 + (0.1 * src.SagaLevel)
			if("Force")
				obj.ForMult = 1.2 + (0.1 * src.SagaLevel)
			if("Speed")
				obj.SpdMult = 1.2 + (0.1 * src.SagaLevel)
			if("Offense")
				obj.OffMult = 1.2 + (0.1 * src.SagaLevel)
			if("Defense")
				obj.DefMult = 1.2 + (0.1 * src.SagaLevel)
		return obj
obj/proc
	GetSpiralIncreasePassive(var/mob/Players/M)
		var/passiveList = list()
		M << M.Race
		switch(M.Race)
			if("Human")
				passiveList = list("Desperation"=0.5 * M.SagaLevel)
			if("Majin")
				passiveList = list("BuffMastery"=0.5 * M.SagaLevel)
			if("Saiyan")
				passiveList = list("Brutalize"=0.5 * M.SagaLevel)
			if("Half Saiyan")
				passiveList = list("Desperation"=0.25 * M.SagaLevel)
				passiveList += list("BuffMastery"=0.25 * M.SagaLevel)
			if("Monster")
				switch(M.Class)
					if("Beastmen")
						passiveList = list("AngerMult"=0.25 * M.SagaLevel)
					if("Yokai")
						passiveList = list("ManaStats"=0.25 * M.SagaLevel)
					if("Eldritch")
						passiveList = list("DeathField"=0.25 * M.SagaLevel)
						passiveList += list("VoidField"=0.25 * M.SagaLevel)
			if("Namekian")
				passiveList = list("LifeGeneration" = 0.25 * M.SagaLevel * 10)
			if("Makyo")
				passiveList = list("DemonicDurability"=0.25 * M.SagaLevel)
				passiveList += list("HeavyHitter"=0.25 * M.SagaLevel)
		return passiveList

/**
 * 
 * TODO: Alien - Adapation 0.25 * SagaLevel
 * 
 */


/obj/Skills/Buffs/SpecialBuff/Spiral
	SpecialSlot=1
	TextColor="green"
	ActiveMessage="begins to evolve; becoming greater than they were a moment before!...."
	OffMessage="relaxes their evolution..."
	verb/Spiral()
		set category="Skills"
		if(!usr.BuffOn(src))
			var/stats = usr.GetTopStats()
			src = usr.GetStatMult(stats[1], src)
			src = usr.GetStatMult(stats[2], src)
			src = usr.GetStatMult(stats[3], src)			
			src.passives = src.GetSpiralIncreasePassive(usr)

		src.Trigger(usr)

		