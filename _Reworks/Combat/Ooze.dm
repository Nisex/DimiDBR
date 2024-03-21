obj
	Ooze
		icon='Ichor Turf.dmi'
		icon_state="ground"
		density = 0
		Grabbable = 0
		var/tmp/mob/owner
		var/tmp/list/tick_on = list()
		var/strength = 3
		var/lifetime = 30 SECONDS

		New(loc)
			..()
			spawn(lifetime)
				if(src)
					del src

		Crossed(atom/movable/O)
			..()
			if(O==Owner) return
			tick_on |= O

		Uncrossed(atom/movable/O)
			..()
			if(O==Owner) return
			if(O in tick_on)
				tick_on -= O

		proc
			on_tick()
				for(var/mob/m in tick_on)
					m.AddPoison(2*strength, Owner)