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

		New(_x,_y,_z)
			loc = locate(_x,_y,_z)
			ticking_generic += src
			for(var/mob/m in loc)
				tick_on |= m
			spawn(lifetime)
				if(src)
					ticking_generic -= src
					owner = null
					tick_on = null
					loc = null

		Cross(atom/movable/O)
			if(O==Owner&&!ismob(O)) return
			tick_on |= O
			..()

		Uncross(atom/movable/O)
			if(O==Owner&&!ismob(O)) return
			if(O in tick_on)
				tick_on -= O
			..()

		proc
			on_tick()
				for(var/mob/m in tick_on)
					m.AddPoison(2*strength, Owner)