obj/Items/Yasakani_no_Magatama
	passives = list("YasakaniNoMagatama" = 1)

obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraint
	applyToTarget = new/obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraints
	EndYourself = 1
	ManaCost=15
	Cooldown=120
	AffectTarget = 1
	Range = 12

obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraints
	EnergyDrain = 1
	TimerLimit = 60
	passives = list("PureDamage" = -1)

mob/verb/testMagatama()
	var/obj/Magatama/magatama = new()
	usr.vis_contents += magatama
	sleep(10)
	magatama.StartOrbit(30, 10)

obj/Magatama
	icon = 'Magatama.dmi'

	proc/StartOrbit(radius, duration)
		var/angle = 0

		while (TRUE)
			angle += 1
			if (angle >= 360)
				angle = 0

			var new_x = round(radius * cos(angle), 1)
			var new_y = round(radius * sin(angle), 1)

			animate(src, pixel_x = new_x, pixel_y = new_y, time = duration/2)
			animate(src, pixel_x = -new_x, pixel_y = -new_y, time = duration/2)

			sleep(duration)
