

//I'm gonna remove the plane graphics, and make it a large animated gif later

/mob/Admin4/verb/ExpandZPlanes(n as num)
	src<<"Max Zplanes: [world.maxz]"
	world.maxz+=n
	src<<"Max Zplanes: [world.maxz]"
	sleep(200)
	loc = locate(1,1,world.maxz)



proc/GenerateWorldInstances() //This has to occur before load items and player loading. We'll move this to an appropriate savefile later.
	world.maxz++
	vessel_instance_z = world.maxz //This will exclude it from world saves.

	for(var/y = 1 to world.maxx)
		var/state = "west_[1+(y % 4)]"
		for(var/turf/t in block(locate(1,y,vessel_instance_z), locate(world.maxx, y,vessel_instance_z)))
			t.icon='Icons/Turfs/space.dmi'
			t.icon_state=state
			t.Destructable = 0
			t.density=1
			t.opacity=0

var/global/vessel_instance_z = null


mob/var/tmp/obj/Items/Tech/Vessel/in_vessel

mob/proc/InVessel()
	return in_vessel

obj/Items/Tech/Vessel
	Cost=30
	Destructable=0
	Grabbable=0
	Pickable=0
	density=1
	UpdatesDescription=1
	var

		unlocked = 0
		maximum_occupants = 1
		list/occupants = list()

		launch = 0
		list/destination = list() //x, y, z
		move_speed = 5
		tmp
			image/override_image // used to hide the players. Probalby unnessary but oh well
			mob/pilot
			last_launch_tick
			list/occupant_refs = list()
			next_move
			init_px

			last_travel_effect
	Read(savefile/f)
		..()
		if(0 > launch)
			launch = 0
		else if(launch > 0 && vessel_instance_z)
			src.z = vessel_instance_z
			spawn(10)
				travel_loop.Add(src)
		else if(!vessel_instance_z)
			loc = locate(100,100,1) //something went wrong. This is just to prevent them from being wiped.

	proc/Update_Description()
		desc = "This is a [src]."
		if(occupants.len)
			desc += " It is currently occupied by: "
			for(var/mob/m in occupant_refs)
				desc += "[m]"
				if(occupant_refs.Find(m) != occupant_refs.len)
					desc += ", "

	proc/AddOccupant(mob/m, override=0)
		if(!override && (occupants.len >= maximum_occupants || m in occupant_refs)) return
		occupants |= "[m.ckey] [m.EnergySignature]"
		occupant_refs += m
		m.in_vessel = src
		m.loc = src
		travel_loop.Add(src)

	proc/RemoveOccupant(mob/m, eject=0)
		occupants -= "[m.ckey] [m.EnergySignature]"
		occupant_refs -= m
		if(pilot == m)
			pilot = 0
			m.Control=null
		m.in_vessel = null
		m.overlays -= override_image
		m.loc = src.loc
		if(!occupants.len && !launch)
			travel_loop.Remove(src)
		if(eject)
			m.BeginKB(pick(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTHWEST,WEST,NORTHWEST), rand(3,10))

	proc/AnimateTakeOff()
		var/prev_py = pixel_y
		animate(src, pixel_y = pixel_y + 500, alpha = 0, time=20, easing=QUAD_EASING)
		spawn for(var/x = 1 to 5)
			last_travel_effect = world.time + rand(1,3)
			var/obj/Effects/e = new(CustomIcon='Icons/Effects/Smoke.dmi',CustomX=pixel_x*(1/3),CustomY=pixel_y*(1/3)+(100 * (x-1)),Life=10)
			animate(e, pixel_y = e.pixel_x - 128, time=10, flags=ANIMATION_PARALLEL)
			e.loc = locate(src.x,src.y,src.z)
			e.layer = layer-0.01
			sleep(4)
		sleep(20)
		pixel_y = prev_py

		return 1 //Already return
	proc/GotoLaunchPlane()
		loc = locate(rand(35, world.maxx-35), rand(35, world.maxy-35), vessel_instance_z)
		alpha = 255

	proc/LandAtDestination()
		launch = 0
		if(destination.len == 3)
			alpha = 0
			var prev_py = pixel_y
			pixel_y = prev_py+400
			loc = locate(destination["x"],destination["y"],destination["z"])
			animate(src, pixel_y = prev_py, alpha=255, time=20)
			for(var/mob/Players/p in players)
				if(p.z==src.z)
					p << output("<font size=2><font color=red><b>A vessel is seen coming down from the skies about, landing at regional coordinates [x],[y].", "output")
					p << output("<font size=2><font color=red><b>A vessel is seen coming down from the skies about, landing at regional coordinates [x],[y].", "icchat")
					p << output("<font size=2><font color=red><b>A vessel is seen coming down from the skies about, landing at regional coordinates [x],[y].", "oocchat")
			sleep(20)
			destination = list()
			var force_eject = prob(25 + (occupants.len * 10)) //hehe
			for(var/mob/m in occupant_refs)
				m << "[src] has arrived at its destination."
				if(force_eject)
					RemoveOccupant(m, eject=1)

			if(force_eject)
				occupants = list()
				pilot=0
				viewers(10) << "[src] ejects all of its passengers."

	Update()
		if(!override_image)
			override_image = image('Icons/BLANK.dmi')
			override_image.override=1
		for(var/atom/movable/a in occupant_refs)
			a.overlays -= override_image
			a.overlays += override_image //just to make sure they hidden while here
			a.loc = src

		if(!istext(launch))
			if(launch > 0)
				launch -= world.time - last_launch_tick
				last_launch_tick = world.time
				if(world.time> last_travel_effect + 5)
					last_travel_effect = world.time + rand(1,3)
					var/obj/Effects/e = new(CustomIcon='Icons/Effects/Smoke.dmi',CustomX=pixel_x*(1/3),CustomY=pixel_y*(1/3),Life=20)
					animate(e, pixel_x = pixel_x - 192, time=20, flags=ANIMATION_PARALLEL)
					e.loc = locate(src.x,src.y,src.z)
					e.layer = layer-0.01
				if(0>=launch)
					LandAtDestination()


			else if(0 > launch) //The vessel is launching.
				launch += world.time - last_launch_tick
				last_launch_tick = world.time

				if(world.time> last_travel_effect + 1)
					last_travel_effect = world.time
					animate(src, pixel_x = init_px + ((-1*launch)%2 == 0 ? 1 : -1), time=1, flags=ANIMATION_PARALLEL)
				for(var/mob/m in src) if(!(m in occupant_refs))
					RemoveOccupant(m, eject=1) //Fuck outtah ere
				if(launch >= 0)

					launch = "launching"
					spawn
						if(AnimateTakeOff())
							if(destination.len != 3)
								for(var/mob/m in occupant_refs) m << "The launch has failed as a result of the destination being an unknown location."
								destination = list()
								launch=0
								return
							for(var/mob/m in occupant_refs) m << "The launch has been completed."
							var/distance = abs(src.z - destination["z"])
							launch = 1000 * max(1,distance)
							GotoLaunchPlane()


	verb/EnterVessel()
		set src in view(1)
		set name = "Enter"
		set category = "Other"
		if((usr in occupant_refs)) return
		usr.Grab_Release()
		for(var/mob/m in src) if(!(m in occupant_refs))
			RemoveOccupant(m, eject=1) //Fuck outtah ere

		if(Password && !unlocked)
			var/Pass=input(usr, "This vessel is protected by a password; you have to provide it before entering.", "Remove Safety") as text
			if(Password!=Pass)
				usr << "That is not the correct password."
				src.Using=0
				return

		if(occupants.len >= maximum_occupants)
			switch(input("There are too many occupants in this vessel. Would you like to boot one out?") in list("Yes","No"))
				if("No")
					return
				if("Yes")
					var/mob/occupant = pick(occupants)
					RemoveOccupant(occupant, eject=1)

		AddOccupant(usr)

	verb/ExitVessel()
		set src in view(0)
		set name = "Exit"
		set category = "Other"
		if(!(usr in occupant_refs)) return
		if(launch > 0)
			usr << "You cannot exit the [src] while it is launched."
			return
		RemoveOccupant(usr, eject = prob(10))

	verb/UnlockVessel()
		set src in view(0)
		set name = "Unlock"
		set category = "Other"
		if(!(usr in occupant_refs)) return
		if(Password && !unlocked)
			var/Pass=input(usr, "This vessel is protected by a password; you have to provide it before entering.", "Remove Safety") as text
			if(Password!=Pass)
				usr << "That is not the correct password."
				src.Using=0
				return

		unlocked = !unlocked
		if(unlocked)
			usr << "You've <font color='green'>unlocked</font color> the [src]."
			viewers(3, src) << "The [src]'s door clicks; its lock blinks with a <font color='green'>green</font color> light."
		else
			usr << "You've <font color='red'>locked</font color> the [src]."
			viewers(3, src) << "The [src]'s door clicks; its lock blinks with a <font color='red'>red</font color> light."




	verb/Pilot()
		set src in view(0)
		set name = "Pilot"
		set category = "Other"
		if(!(usr in occupant_refs)) return
		if(pilot==usr)
			pilot=0
			usr.Control=null
			usr << "You stop piloting the vessel."
			return
		if(pilot && pilot in occupant_refs)
			usr << "[pilot] is already piloting this vessel."
			return
		pilot = usr
		usr.Control=src
		for(var/mob/m in occupant_refs) m << "[usr] begins piloting the vessel!"

	verb/Launch()
		set src in view(0)
		set name = "Launch"
		set category = "Other"
		if(!(usr==pilot))
			usr << "Only the pilot may launch the vessel."
			return
		if(launch)
			if(launch < 0)
				launch = 0
				for(var/mob/m in occupant_refs)
					m << "The [src]'s launch sequence has been canceled!"

				destination = list()
			else if(launch > 0)
				usr << "The [src] is already launched."
			return

		var/list/landing_locations = list()
		for(var/obj/Items/Tech/Beacon/B in world)
			if(B.z==1) continue
			if(B.z in ArcaneRealmZ) continue
			if(B.z == glob.DEATH_LOCATION[3]) continue
			if(B.z == NearDeadZ) continue
			if(B.z == PhilosopherZ) continue
			if(B.z == MajinZoneZ) continue
			if(B.loc == null) continue
			if(B.BeaconState != "On") continue
			if(B.Password && B.Password != src.Password) continue
			landing_locations["([B.name ? B.name : "Beacon"]) [B.x], [B.y], [B.z]"] = B
		landing_locations += "Cancel"
		var/obj/o = input("What landing location would you like to launch toward?") in landing_locations as text|null
		if(!o || o == "Cancel") return
		o = landing_locations[o]
		destination = list("x"=o.x,"y"=o.y,"z"=o.z)
		launch = -300
		last_launch_tick = world.time
		init_px=pixel_x
		for(var/mob/Players/p in players)
			if(p.z==src.z)
				p << output("<font size=2><font color=red><b>A vessel is beginning their launch sequence at regional coordinates [src.x],[src.y].", "output")
				p << output("<font size=2><font color=red><b>A vessel is beginning their launch sequence at regional coordinates [src.x],[src.y].", "icchat")
				p << output("<font size=2><font color=red><b>A vessel is beginning their launch sequence at regional coordinates [src.x],[src.y].", "oocchat")
		for(var/mob/m in occupant_refs) m << "The vessel will launch to coordinates [o.x], [o.y], [o.z] in 30 seconds!"



	verb/SetPassword()
		set src in view(0)
		if(!(usr in occupant_refs)) return


	Pod
		icon = 'Icons/Technology/Vessels/Spacepod.dmi'
		maximum_occupants=2
	Ship
		icon = 'Icons/Technology/Vessels/Shipz.dmi'
		pixel_x = -48
		pixel_y = -48
		maximum_occupants = 10
