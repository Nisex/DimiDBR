obj/Skills/Buffs/SlotlessBuffs/Blessed_Guard
	passives = list("PureDamage"=-2)
	VaizardHealth = 2
	VaizardShatter = 1
	TimerLimit = 30
	Cooldown = 90
	adjust(mob/p)
		if(p.SpecialBuff&&p.SpecialBuff.name == "Heavenly Regalia: Blessed Blade")
			passives = list("PureDamage"=-2, "ManaSeal" = 1, "DebuffImmune" = 1)
		else
			passives = list("PureDamage"=-2)
	verb/Blessed_Guard()
		set category = "Skills"
		if(!usr.BuffOn(src))
			adjust(usr)
		Trigger(usr)