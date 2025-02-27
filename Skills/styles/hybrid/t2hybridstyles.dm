/obj/Skills/Buffs/NuStyle/UnarmedStyle
	Divine_Arts_of_The_Heavenly_Demon // unarmed+armed
		SignatureTechnique=2
		Copyable=0
		passives = list("HybridStyle" = "SwordStyle", "Hardening" = 2, "Deflection" = 1, "Momentum" = 2, "Pressure" = 2, "SwordPunching" = 1,\
					"NeedsSword" = 0, "NoSword" = 1)
		NeedsSword=0
		NoSword=1
		SwordPunching=1
		StyleStr=1.3
		StyleEnd=1.3
		StyleActive="Divine Arts of The Heavenly Demon"
		Finisher="/obj/Skills/Queue/Finisher/Divine_Finisher"
		verb/Divine_Arts_of_The_Heavenly_Demon_Style()
			set hidden=1
			src.Trigger(usr)

	Ifrit_Jambe // mystic+unarmed
		SignatureTechnique=2
		Copyable=0
		StyleStr=1.15
		StyleFor=1.15
		StyleEnd=1.15
		StyleActive="Ifrit Jambe"
		StyleComboUnlock=list()
		passives = list("HybridStyle" = "MysticStyle","Fury" = 2, "Momentum" = 2,  "Hardening" = 2, "SpiritHand" = 2, "Instinct" = 2, \
						"Flow" = 2, "SpiritFlow" = 2, "Combustion" = 40, "Scorching" = 5, "Shattering" = 5)
		Finisher="/obj/Skills/Queue/Finisher/Bauf_Burst"
		verb/Ifrit_Jambe()
			set hidden=1
			src.Trigger(usr)

	Psycho_Boxing // mystic+unarmed (anti cyborg)
		SignatureTechnique=2
		passives = list("HybridStyle" = "MysticStyle", "Rusting" = 2, "SoulTug" = 1, "SpiritHand" = 1, "SpiritFlow" = 1, "CyberStigma" = 4, \
			"Toxic" = 4, "Instinct" = 1, "Flow" = 1, "Hardening" = 1)
		
		Finisher="/obj/Skills/Queue/Finisher/Psycho_Barrage"
		verb/Psycho_Boxing()
			set hidden=1
			Trigger(usr)

	Phoenix_Eye_Fist // unarmed + armed
		SignatureTechnique=2
		passives = list("HybridStyle" = "SwordStyle","Backstabber" = 1, "Backshot" = 1, "Fa Jin" = 2, "Momentum" = 2, "BlurringStrikes" = 0.5, "Interception" = 1.5, \
				"Extend" = 1, "Gum Gum" = 1, "Tossing" = 1.5, "Secret Knives" = "Knives", "NeedsSword" = 0, "NoSword" = 1)
		NeedsSword=0
		NoSword=1
		SwordPunching=1
		StyleStr = 1.15
		StyleOff = 1.15
		StyleSpd = 1.15
		StyleDef = 1.15
		Finisher="/obj/Skills/Queue/Finisher/Icy_Glare"
		StyleActive = "Pheonix_Eye_Fist"
		verb/Phoenix_Eye_Fist()
			set hidden=1
			Trigger(usr)

/obj/Skills/Buffs/NuStyle/SwordStyle/Art_of_Order// mystic+armed
	SignatureTechnique=2
	passives = list("HybridStyle" = "MysticStyle","Wuju" = 1, "CriticalChance" = 33, "CriticalDamage"= 0.05, "SpiritSword" = 2, "ThunderHerald" = 1, \
					"Instinct" = 2, "Flicker" = 2, "Fury" = 2.5, "Iaijutsu" = 2, "BlurringStrikes" = 0.5, "Rain" = 5)
	// crits deal an extra amount based on the enemy's max health
	StyleSpd = 1.3
	StyleOff = 1.15
	StyleActive="Art of Order"
	Finisher="/obj/Skills/Queue/Finisher/Alpha_Strike"
	verb/Art_of_Order()
		set hidden=1
		Trigger(usr)



// glob.WUJU_STYLE_BASE_DAMAGE 0.0005 * 100 = 99.95



