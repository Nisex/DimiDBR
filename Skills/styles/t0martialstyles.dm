/obj/Skills/Buffs/NuStyle/UnarmedStyle
	Lucha_Libre_Style
		Copyable = 0
		StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Red_Cyclone_Style")
		StyleStr=1.15
		StyleEnd=1.15
		passives = list("Muscle Power" = 1, "Grippy" = 2, "Scoop" = 1)
		StyleActive="Lucha Libre"
		Finisher="/obj/Skills/Queue/Finisher/Hold"
		verb/Lucha_Libre_Style()
			set hidden=1
			src.Trigger(usr)
	Murim_Style
		StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Shield_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wushu_Style")
		StyleStr=1.1
		StyleEnd=1.1
		StyleSpd=1.1
		passives = list("Hardening" = 1)
		StyleActive="Heavenly"
		Finisher="/obj/Skills/Queue/Finisher/Heavenly_Storm_Dragon_Emergence"
		verb/Murim_Style()
			set hidden=1
			src.Trigger(usr)
	Shaolin_Style
		StyleComboUnlock=list()
		StyleStr=1.05
		StyleFor=1.05
		StyleEnd=1.05
		StyleSpd=1.05
		StyleOff=1.05
		StyleDef=1.05
		passives = list("Fa Jin" = 1)
		StyleActive="Shaolin"
		Finisher="/obj/Skills/Queue/Finisher/Merciful_Thousand_Leaves_Hand"
		verb/Shaolin_Style()
			set hidden=1
			src.Trigger(usr)



	Turtle_Style
		StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Crane_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Gentle_Fist_Style",\
		"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Cat_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style")
		StyleStr=1.1
		StyleEnd=1.1
		StyleFor=1.1
		StyleActive="Turtle"
		Finisher="/obj/Skills/Queue/Finisher/Iron_Fortress"
		verb/Turtle_Style()
			set hidden=1
			src.Trigger(usr)
	Crane_Style
		StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Gentle_Fist_Style",\
		"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Snake_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Lightning_Kickboxing_Style")
		StyleEnd=1.1
		StyleFor=1.1
		StyleSpd=1.1
		StyleActive="Crane"
		Finisher="/obj/Skills/Queue/Finisher/Fire_Dancer"
		verb/Crane_Style()
			set hidden=1
			src.Trigger(usr)