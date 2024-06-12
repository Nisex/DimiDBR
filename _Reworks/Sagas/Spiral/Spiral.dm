mob/proc
	GetTopStats()
		var/list/stats = list("Strength"=src.GetStr(), "Endurance"=src.GetEnd(), "Force"=src.GetFor(), "Speed"=src.GetSpd(), "Offense"=src.GetOff(), "Defense"=src.GetDef())
		var/i,j
		for(i=1; i<=stats.len; i++)
			for(j=1; j<=stats.len; j++)
				if(stats[stats[j]] < stats[stats[i]])
					stats.Swap(i, j)

		return stats
	GetStatMult(var/string, var/obj/Skills/Buffs/SpecialBuff/obj, var/value)
		switch(string)
			if("Strength")
				obj.StrMult = value
			if("Endurance")
				obj.EndMult = value
			if("Force")
				obj.ForMult = value
			if("Speed")
				obj.SpdMult = value
			if("Offense")
				obj.OffMult = value
			if("Defense")
				obj.DefMult = value
		return obj

obj/proc
	GetSpiralIncreasePassive(var/mob/Players/M)
		var/passiveList = list()
		switch(M.race.type)
			if(HUMAN)
				passiveList = list("Desperation"=0.5 * M.SagaLevel)
			if(MAJIN)
				passiveList = list("BuffMastery"=0.5 * M.SagaLevel)
			if(SAIYAN)
				passiveList = list("Brutalize"=0.5 * M.SagaLevel)
			if(BEASTMAN)
				passiveList = list("AngerMult"=0.25 * M.SagaLevel)
			if(YOKAI)
				passiveList = list("ManaStats"=0.25 * M.SagaLevel)
			if(ELDRITCH)
				passiveList = list("DeathField"=0.25 * M.SagaLevel, "VoidField"=0.25 * M.SagaLevel)
			if(NAMEKIAN)
				passiveList = list("LifeGeneration" = 0.25 * M.SagaLevel * 10)
			if(MAKYO)
				passiveList = list("DemonicDurability"=0.25 * M.SagaLevel, "HeavyHitter"=0.25 * M.SagaLevel)
			if(DRAGON)
				passiveList = list("DebuffImmune"=0.15 * M.SagaLevel, "BuffMastery"=0.25 * M.SagaLevel)
			if(GAJALAKA)
				passiveList = list("DemonicDurability"=0.25 * M.SagaLevel, "CashCow"=0.25 * M.SagaLevel)
		return passiveList


sagaTierUpMessages/Spiral
	messages = list("You gained the ability to let out the power of your evolution!", \
	"You feel like you have evolved as a being!", \
	"Your celestial guardian blesses you with revelations of more advanced techniques!", \
	"In a severe pinch, you can cry out for assistance to your Zodiac guardian and hope for their protection!", \
	"You are experiencing the first glimmers of Seventh Sense when in a pinch!", \
	"Through attaining the Seventh Sense you can invoke the techniques of your Zodiac guardian, if only for a moment!", \
	"You reach the level of a Golden Saint, standing at the summit as a champion of Gods!"
	)

var/sagaTierUpMessages/spiralSagaMessages = list("Spiral" = new /sagaTierUpMessages/Spiral())


mob
	var
		tier4SpiralOption
		tier4SpiralOption2
		tier5SpiralOption

	proc
		pickTier4Option()
			var/list/Choices=list("Your instincts to survive.", "Your will to endure.", "Your desire to fight")
			var/option = input("What path will you choose") in Choices
			var/selectedOption
			switch(option)
				if("Your instincts to survive.")
					selectedOption = "Survival"
				if("Your will to endure.")
					selectedOption = "Endure"
				if("Your desire to fight")
					selectedOption = "Combat"
			return selectedOption

mob/tierUpSaga(path)
	..()
	if(path == "Spiral")
		src<<spiralSagaMessages[path].messages[SagaLevel]
		switch(SagaLevel)
			if(2)
				if(!locate(/obj/Skills/Queue/Spiral_Defiance, src))
					src.AddSkill(new/obj/Skills/Queue/Spiral_Defiance)
			if(3)
				if(!locate(/obj/Skills/AutoHit/Giga_Drill_Breaker, src))
					src.AddSkill(new/obj/Skills/AutoHit/Giga_Drill_Breaker)
			if(4)
				src.tier4SpiralOption = src.pickTier4Option()
			if(5)
				var/list/Choices=list("Evolve others.", "Hoard for yourself.")
				var/option = input("Will you help others evolve and ascend..or hoard the power of evolution for yourself?") in Choices
				switch(option)
					if("Evolve others.")
						src.tier5SpiralOption = "EvolveOthers"
						src.tier4SpiralOption2 = src.pickTier4Option()
					if("Hoard for yourself.")
						src.tier5SpiralOption = "Hoard"
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/The_King_Above_All)

/**
 *
 * TODO: Alien - Adapation 0.25 * SagaLevel
 *
 */

/obj/Skills/Buffs/SlotlessBuffs/The_King_Above_All
	ActiveMessage="erupts with a crushing presence; standing as The King Above All!"
	OffMessage="discards their oppressive mantle; ceasing the oppression.."
	BuffName="The King Above All"
	passives= list("DeathField"=10,"VoidField"=10, "MaimStrike"=1, "DoubleStrike"=1)
	ElementalOffense="Void"
	ElementalDefense="Ultima"
	verb/The_King_Above_All()
		set category="Skills"
		src.Trigger(usr)


/obj/Skills/Buffs/SpecialBuff/Spiral
	PowerGlows=list(1,0.8,0.8, 0,1,0, 0.8,0.8,1, 0,0,0)
	SpecialSlot=1
	TextColor="green"
	ActiveMessage="begins to evolve; becoming greater than they were a moment before!...."
	OffMessage="relaxes their evolution..."
	BuffName="Spiral"
	verb/Spiral()
		set category="Skills"
		if(!usr.BuffOn(src))
			var/stats = usr.GetTopStats()
			src.passives = src.GetSpiralIncreasePassive(usr)
			switch(usr.SagaLevel)
				if(1)
					src = usr.GetStatMult(stats[1], src, 1.3)
					src = usr.GetStatMult(stats[2], src, 1.3)
				if(2)
					src = usr.GetStatMult(stats[1], src, 1.3)
					src = usr.GetStatMult(stats[2], src, 1.3)
					src = usr.GetStatMult(stats[3], src, 1.1)
				if(3)
					src = usr.GetStatMult(stats[1], src, 1.3)
					src = usr.GetStatMult(stats[2], src, 1.3)
					src = usr.GetStatMult(stats[3], src, 1.3)
					src.passives += list("MovementMastery" = 6)
				if(4)
					src = usr.GetStatMult(stats[1], src, 1.5)
					src = usr.GetStatMult(stats[2], src, 1.5)
					src = usr.GetStatMult(stats[3], src, 1.5)
					src = usr.GetStatMult(stats[4], src, 1.3)
					src = usr.GetStatMult(stats[5], src, 1.3)
					src = usr.GetStatMult(stats[6], src, 1.3)
					src.passives += list("MovementMastery" = 8)
					switch(usr.tier4SpiralOption)
						if("Survival")
							src.passives += list("Instinct" = 2, "Flow" = 2)
						if("Endure")
							src.passives += list("Juggernaut" = 1, "Hardening " = 2)
						if("Combat")
							src.passives += list("SpiritHand" = 2, "SpiritFlow" = 1)
				if(5)
					src = usr.GetStatMult(stats[1], src, 1.5)
					src = usr.GetStatMult(stats[2], src, 1.5)
					src = usr.GetStatMult(stats[3], src, 1.5)
					src = usr.GetStatMult(stats[4], src, 1.5)
					src = usr.GetStatMult(stats[5], src, 1.5)
					src = usr.GetStatMult(stats[6], src, 1.5)
					switch(usr.tier4SpiralOption)
						if("Survival")
							src.passives += list("Instinct" = 2, "Flow" = 2)
						if("Endure")
							src.passives += list("Juggernaut" = 1, "Hardening " = 2)
						if("Combat")
							src.passives += list("SpiritHand" = 2, "SpiritFlow" = 1)
					switch(usr.tier4SpiralOption2)
						if("Survival")
							src.passives += list("Instinct" = 2, "Flow" = 2)
						if("Endure")
							src.passives += list("Juggernaut" = 1, "Hardening " = 2)
						if("Combat")
							src.passives += list("SpiritHand" = 2, "SpiritFlow" = 1)
					switch(usr.tier5SpiralOption)
						if("EvolveOthers")
							src.passives += list("MovementMastery" = 12, "PilotingProwess" = 0.25)
						if("Hoard")
							src = usr.GetStatMult(stats[1], src, 1.75)
							src = usr.GetStatMult(stats[2], src, 1.75)
							src.passives += list("MovementMastery" = 16, "TechniqueMastery"=10, "SlayerMod"= usr.SagaLevel * 0.5, "KillerInstinct" = clamp(usr.SagaLevel/6, 0.1, 1), "MaimStrike" = usr.SagaLevel * 0.25)
							src.Intimidation *= 10

		else
			switch(usr.SagaLevel)
				if(5)
					if("Hoard")
						src.Intimidation /= 10

		src.Trigger(usr)



/obj/Skills/Queue/Spiral_Defiance
	TextColor="green"
	HitMessage="yells: Let me see you grit those teeth!!"
	DamageMult=8
	AccuracyMult=3
	Instinct=1
	Duration=5
	KBMult=2
	Cooldown=120
	Determinator=1
	Counter=1
	UnarmedOnly=1
	EnergyCost=5
	name="Grit those teeth"
	verb/Grit_Those_Teeth()
		set category="Skills"
		if(usr.CheckSpecial("Spiral"))
			usr.SetQueue(src)
		else
			usr << "<font color='green'><b>You must resort to your evolution to use this skill!</b></font>"

/obj/Skills/AutoHit/Giga_Drill_Breaker
	Area="Circle"
	StrOffense=1
	ForOffense=1
	DamageMult=1.1
	Rounds=10
	ComboMaster=1
	ChargeTech=1
	ChargeTime=0.5
	Cooldown=180
	Size=1
	EnergyCost=10
	GuardBreak=1
	SpecialAttack=1
	Rush=5
	ControlledRush=1
	Instinct=1
	TurfStrike=1
	TurfShift='Dirt1.dmi'
	TurfShiftDuration=1
	Icon='Glowing Electricity.dmi'
	ActiveMessage="yells: GIGA DRILL BREAKEEEEEERRRRR!!!!"
	verb/Giga_Drill_Breaker()
		set category="Skills"
		usr.Activate(src)
