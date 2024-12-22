/obj/Skills/Buffs/SpecialBuff/King_Of_Courage
	var/sagaInfo/sagaInfo = new/sagaInfo/courage

	passives = list("Deus Ex Machina" = 25, "Willpower" = 25) // dxm is how much u have, can be consumed from using abilities, willpwoer is the battery

	Cooldown = 0
	PowerGlows = rgb(17, 169, 62)
	ActiveMessage = "encases their body with their willpower!"
	OffMessage = "dismisses their willpower..."

	adjust(mob/p)
		var/piloting = p.Intelligence * p.passive_handler.Get("PilotingProwess") // 2 * 7.5 max
		var/sLevel = p.SagaLevel
		var/mult = clamp((0.05 * piloting) * sLevel, 0.05, 1)
		OffMult = 1 + mult
		DefMult = 1 + mult
		Intimidation = 1 + sLevel/6
		if(sagaInfo.choicesPath["1"] == "Endless Evolution" && sLevel>=2)
			switch(sagaInfo.choices)
				if("Overwhelming Force")

				if("Unstoppable Strength")

				if("Peerless Agility")

sagaInfo/courage
	choicesPaths = list("1" = list("Endless Evolution", "Bright Bravery", "Divine Destiny"), \
						"2" = list("Endless Evolution" = list("Overwhelming Force", "Unstoppable Strength", "Peerless Agility")))

	
	choicePassives = list("2" = list("Instinct", "TechniqueMastery"), "4"= list("Flow", "MovementMastery"))
	perLevelPassives = list("ShonenPower" = 0.15) // 0.15 per tier
	specificPassives = list("3" = list("ShonenPower" = 0.2, "LifeSteal" = 0.05), \
	"4" = list("LifeSteal" = 0.1), "5" = list("ShonenPower" = 0.2), \
	"6" = list("Lifesteal" = 0.15), "7" = list("ShonenPower" = 0.2), \
	"8" = list("ShonenPower" = 0.4, "LifeSteal" = 0.2)) // 2 total at tier 8
	skillsPerTier = list("1" = "/obj/Skills/AutoHit/Mathematical_Dash", "2" = "/obj/Skills/Queue/High_Five_Dude", "3" = "/obj/Skills/AutoHit/Bombastic_Dive")
