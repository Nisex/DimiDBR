obj/Skills/Buffs/SlotlessBuffs/Symbiotic_Edge
	passives = list("Unstoppable" = 1, "PureDamage" = 2, "Instinct" = 2, "Curse" = 1)
	EnergyDrain = 0.15
	WoundCost = 20
	TimerLimit = 60
	Cooldown = 160
	ActiveMessage = "is overtaken by the power of Soul Edge as flesh wriggles across their sword arm!"
	OffMessage = "is released from the whims of Soul Edge..."

	verb/Symbiotic_Edge()
		set category = "Skills"
		Trigger(usr)