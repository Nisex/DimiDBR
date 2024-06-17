obj/Items/Yasakani_no_Magatama
	var/tmp/currentMagatama = 0
	var/tmp/list/magatamaBeads = list()
	var/tmp/manaStolen = 0
	proc/stealMana(value)
		manaStolen += value
		var/magatamaBeadAmount = 25
		if(ismob(loc))
			var/mob/m = loc
			magatamaBeadAmount = getMagatamaMana(m)
		while(manaStolen >= magatamaBeadAmount)
			gainMagatama()
			manaStolen -= magatamaBeadAmount

	proc/getMagatamaMana(mob/m)
		var/mana = 25
		if(m.SpecialBuff&&m.SpecialBuff.name == "Heavenly Regalia: The Three Treasures")
			mana = 15
		return mana
	proc/gainMagatama()
		var/obj/Magatama/magatama = new()
		magatamaBeads += magatama
		vis_contents += magatama

	proc/loseMagatama()
		if(magatamaBeads.len>0)
			for(var/obj/Magatama/magatama in magatamaBeads)
				magatamaBeads -= magatama
				vis_contents -= magatama
				return

	passives = list("YasakaniNoMagatama" = 1)

obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraint
	applyToTarget = new/obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraints
	ActiveMessage = "tosses a chain of beads forth!"
	EndYourself = 1
	ManaCost=15
	Cooldown=120
	AffectTarget = 1
	Range = 12
	adjust(mob/p)
		if(p.SpecialBuff&&p.SpecialBuff.name == "Heavenly Regalia: The Three Treasures")
			applyToTarget = new/obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Heavenly_Bead_Constraints
		else
			applyToTarget = new/obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraints
	verb/Bead_Constraint()
		set name = "Yasakani no Magatama: Bead Constraint"
		if(!usr.BuffOn(src))
			adjust(usr)
		Trigger(usr)

obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraints
	EnergyDrain = 1
	TimerLimit = 60
	passives = list("PureDamage" = -1)

obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Heavenly_Bead_Constraints
	EnergyDrain = 3
	TimerLimit = 60
	passives = list("PureDamage" = -1, "PureReduction" = -1)

mob/verb/testMagatama()
	var/obj/Magatama/magatama = new()
	usr.vis_contents += magatama
	sleep(10)
	magatama.StartOrbit()

obj/Magatama
	icon = 'Magatama.dmi'

	proc/StartOrbit()
		var/angle = 0
		while (TRUE)
			angle += 30
			if (angle >= 360)
				angle = 0

			var new_x = 48 + round(50 * cos(angle), 1)
			var new_y = 48 + round(50 * sin(angle), 1)

			animate(src, pixel_x =new_x, pixel_y = new_y, time = 5)
			spawn(5)
			animate(src, pixel_x = -new_x, pixel_y = -new_y, time = 5)

			sleep(10)