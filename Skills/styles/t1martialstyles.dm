/obj/Skills/Buffs/NuStyle/UnarmedStyle
	Red_Cyclone_Style
		SignatureTechnique=1
		Copyable=0
		StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Ubermensch_Style")
		StyleStr=1.15
		StyleEnd=1.3
		passives = list("Muscle Power" = 1, "Grippy" = 4, "Scoop" = 2, "Iron Grip" = 1)
		StyleActive="Red Cyclone"
		Finisher="/obj/Skills/Queue/Finisher/Leg_Grab"
	Wushu_Style
		SignatureTechnique=1
		Copyable=0
		StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Divine_Arts_of_The_Heavenly_Demon", \
		"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Iron_Fist_Style")
		StyleStr=1.15
		StyleEnd=1.15
		StyleDef=1.15
		passives = list("Hardening" = 2, "Deflection" = 0.5, "Momentum" = 2, "Pressure" = 1)
		StyleActive="Heavenly Dragon Stance"
		Finisher="/obj/Skills/Queue/Finisher/Heavenly_Dragons_Omniscient_Surge"
		verb/Wushu_Style()
			set hidden=1
			src.Trigger(usr)
	Black_Leg_Style
		SignatureTechnique=1
		Copyable=0
		StyleStr=1.15
		StyleSpd=1.3
		StyleActive="Black Leg"
		StyleComboUnlock=list()
		passives = list("Hardening" = 1, "BlurringStrikes" = 1, "Instinct" = 1, "Flow" = 1)
		Finisher="/obj/Skills/Queue/Finisher/Mouton_Shot"
		verb/Black_Leg_Style()
			set hidden=1
			src.Trigger(usr)
	Wing_Chun_Style
		SignatureTechnique=1
		Copyable=0
		StyleComboUnlock=list()
		StyleSpd=1.15
		StyleOff=1.15
		StyleDef=1.15
		passives = list("Fa Jin" = 1, "Momentum" = 1, "Fury" = 1, "Interception" = 1)
		StyleActive="Wing Chun"
		Finisher="/obj/Skills/Queue/Finisher/Dark_Dragon_Commandment"
	Tai_Chi_Style
		SignatureTechnique=1
		Copyable=0
		StyleComboUnlock=list()
		StyleStr=0.85
		StyleSpd=0.85
		StyleEnd=1.3
		StyleOff=1.15
		StyleDef=1.3
		passives = list("Fa Jin" = 1,"Acupuncture" = 1, "Flow" = 1, "Soft Style" = 1)
		StyleActive="Tai Chi"
		Finisher="/obj/Skills/Queue/Finisher/Dim_Mak"
	