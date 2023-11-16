/mob/Admin3/verb/ADMINSetallRoofsToDense()
	for(var/turf/CustomTurf/T in world)
		if(T.Roof)
			T.FlyOverAble = FALSE
		else
			T.FlyOverAble = TRUE

/mob/Mapper/verb/SetallRoofsToDense()
	for(var/turf/CustomTurf/T in world)
		if(T.Builder == src.ckey)
			if(T.Roof)
				T.FlyOverAble = FALSE
			else
				T.FlyOverAble = TRUE

mob
	var
		tmp/Mapper=0
		MapperSight//Flagged by mapper sight duh
		MapperWalk
		BuildOverwrite=0
		WarperOverwrite=0
		Bino=0
	Mapper
		verb/Make_All_Objs_Ungrabable()
			for(var/obj/Turfs/CustomObj1/cObj in world)
				if(cObj.Builder == src.ckey)
					cObj.Grabbable = 0
			src<<"All your CUSTOM objects are now ungrabable."
		verb/Mapper_Binoculars()
			set category="Mapper"
			if(Bino==0)
				usr.client.view="69x69"
				usr.Bino=1
			else
				usr.client.view="17x17"
				usr.Bino=0
		verb/Mapper_Delete(var/obj/o in view(10, usr))
			set category="Mapper"
			set name="Mapper Delete"
			if(!istype(o, /obj/Turfs) && !istype(o, /obj/KatieObj))
				return
			if(istype(o, /obj/Items/Tech/Door))
				if(o.Builder!=usr.ckey)
					return
			Log("Admin", "[ExtractInfo(usr)] deleted [o] ([o.type]).")
			del o
		verb/Build_Overwrite_Toggle()
			set category="Mapper"
			if(usr.BuildOverwrite)
				usr.BuildOverwrite=0
				usr << "You will <font color='red'>NOT</font color> delete objects by placing turfs on them."
			else
				usr.BuildOverwrite=1
				usr << "You <font color='green'>WILL</font color> delete objects by placing turfs on them."
		verb/Warper_Overwrite_Toggle()
			set category="Mapper"
			if(usr.WarperOverwrite)
				usr.WarperOverwrite=0
				usr << "You will <font color='red'>NOT</font color> delete warpers by placing turfs on them."
			else
				usr.WarperOverwrite=1
				usr << "You <font color='green'>WILL</font color> delete warpers by placing turfs on them."
		verb/Mapper_Edit(atom/A in world)
			set name="Mapper Edit"
			set category="Mapper"
			if(istype(A, /mob)||istype(A, /area))
				src << "Nah."
				return
			var/Edit="<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
			var/list/B=new
			Edit+="[A]<br>[A.type]"
			Edit+="<table width=10%>"
			B.Add("mouse_opacity","pixel_x", "pixel_y", "layer", "density", "alpha", "icon", "icon_state", "invisibility", "opacity")
			if(isobj(A))
				B.Add("Grabbable")
			if(A.type==/obj/Special/Teleporter2)
				B.Add("gotoX", "gotoY", "gotoZ")
			for(var/C in B)
				Edit+="<td><a href=byond://?src=\ref[A];action=edit;var=[C]>"
				Edit+=C
				Edit+="<td>[Value(A.vars[C])]</td></tr>"
			usr<<browse(Edit,"window=[A];size=450x600")
		verb/XYZ_Teleport()
			set category="Mapper"
			var/x=input("x","[src]") as num
			var/y=input("y","[src]") as num
			var/z=input("z","[src]") as num
			usr.loc=locate(x,y,z)
			Log("Admin","[ExtractInfo(src)] teleported to [x],[y],[z].")
		verb/Make_Warper()
			set category="Mapper"
			var/_x=input("Where does this lead? x", "Make Warper") as num
			var/_y=input("Where does this lead? y", "Make Warper") as num
			var/_z=input("Where does this lead? z", "Make Warper") as num
			usr.MakeWarper(_x,_y,_z)
		verb/Mapper_Sight()
			set category="Mapper"
			if(!src.MapperSight)
				usr.sight |= SEE_THRU
				usr.MapperSight=1
				usr << "You turn on your Mapper Sight."
			else
				usr.sight=null
				usr.MapperSight=0
				usr << "You turn off your Mapper Sight."
		verb/Mapper_Walk()
			set category="Mapper"
			if(!src.MapperWalk)
				usr.MapperWalk=1
				usr << "You turn on your Mapper Walk."
			else
				usr.MapperWalk=0
				usr << "You turn off your Mapper Walk."
		verb/Toggle_Turf_Indestructable()
			set category="Mapper"
			if(!usr.TurfInvincible)
				usr.TurfInvincible=1
				usr << "You turn your indestructable turfs <font color='green'>ON</font color>."
			else
				usr.TurfInvincible=0
				usr << "You turn your indestructable turfs <font color='red'>OFF</font color>."
		verb/ToggleUngrabbable()
			set category="Mapper"
			if(src.MakeUngrabbable)
				src << "You will now <font color='red'>NOT</font color> make objects ungrabbable by default."
				src.MakeUngrabbable=0
			else
				src << "You will now <font color='green'>MAKE</font color> objects ungrabbable by default."
				src.MakeUngrabbable=1
		verb/Toggle_Fly_Over()
			set category="Mapper"
			if(!usr.IgnoreFlyOver)
				usr.IgnoreFlyOver=1
				usr << "You turn your fly through <font color='green'>ON</font color>."
			else
				usr.IgnoreFlyOver=0
				usr << "You turn your fly through <font color='red'>OFF</font color>."
		verb/Toggle_Waterwalk()
			set category="Mapper"
			if(!usr.WaterWalk)
				usr.passive_handler.Increase("WaterWalk")
				WaterWalk=1
				usr << "You turn your water walking <font color='green'>ON</font color>."
			else
				usr.passive_handler.Decrease("WaterWalk")
				usr.WaterWalk=0
				usr << "You turn your water walking <font color='red'>OFF</font color>."
		verb/Toggle_Godspeed()
			set category="Mapper"
			if(!usr.Godspeed)
				usr.Godspeed=1
				usr << "You turn your godspeed <font color='green'>ON</font color>."
			else
				usr.Godspeed=0
				usr << "You turn your godspeed <font color='red'>OFF</font color>."
		verb/Invisible_Toggle()
			set category="Mapper"
			if(usr.AdminInviso)
				usr<<"<font color='red'>You are no longer invisible.</font color>"
				usr.AdminInviso=0
				usr.invisibility=0
				usr.see_invisible=0
				animate(usr, alpha=255, time=10)
			else
				usr<<"<font color=green>You are now invisible.</font color>"
				usr.AdminInviso=1
				usr.invisibility=100
				usr.see_invisible=101
				animate(usr, alpha=50, time=10)
		verb/ToggleUnFlyable()
			set category="Mapper"
			if(src.UnFlyable)
				src.UnFlyable=0
				src << "You will now <font color='green'>NOT</font color> make turfs unflyable by default."
			else
				src.UnFlyable=1
				src << "You will now <font color='red'>MAKE</font color> turfs unflyable by default."
