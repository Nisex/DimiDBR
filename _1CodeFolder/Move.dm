mob/var/Frozen
mob/var/tmp/Moving
mob/var/Decimals=0

proc
	TeleporterBump(var/A,var/Q)
		if(istype(A,/obj/Special/Teleporter2)||!(istype(A, /obj/Special/Teleporter2/SpecialTele)))
			var/obj/Special/Teleporter2/_tp=A
			if(istype(Q,/obj/Items/Tech/SpaceTravel))
				Q:loc=locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ)
		if(istype(A,/obj/Special/Teleporter2/SpecialTele))
			var/obj/Special/Teleporter2/tele=A
			var/newz
			if(tele.type==/obj/Special/Teleporter2/SpecialTele/GoAbove)
				newz=tele.z+1
			if(tele.type==/obj/Special/Teleporter2/SpecialTele/GoBelow)
				newz=tele.z-1
			if(tele.type==/obj/Special/Teleporter2/SpecialTele/GoDeep)
				newz=tele.z-2
			if(tele.type==/obj/Special/Teleporter2/SpecialTele/GoHigh)
				newz=tele.z+2
			if(istype(Q,/obj/Items/Tech/SpaceTravel))
				Q:loc=locate(tele.x,tele.y,newz)


	PlanetEnterBump(var/A,var/Q)
		if(istype(A,/obj/Planets))
			if(istype(A,/obj/Planets/Sanctuary))
				Q:loc=locate(rand(1,500),rand(1,500),18)
			else
				var/obj/Planets/LOL=A
				var/Wtf=LOL.Zz
				if(Wtf==3)
					Q:loc=locate(rand(140,160),rand(480,490),Wtf)
				else if(Wtf==4)
					Q:loc=locate(rand(152,172),65,Wtf)
				else if(Wtf==5)
					Q:loc=locate(rand(140,160),122,Wtf)
				else
					Q:loc=locate(rand(1,240),rand(1,240),Wtf)


		if(istype(A,/obj/Items/Tech/Door))
			var/obj/Items/Tech/Door/B=A
			var/mob/M=Q
			if(B.Password)
				if(B.GodDoor)
					if(M.Spawn==B.Password || M.AntiGodDoor)
						B.Open()
				else
					if(B.Password&&!B.AutoOpen)
						var/happened
						for(var/obj/Items/Tech/SpaceTravel/L)
							if(L==Q)
								happened=1
								if(L.DoorPass==B.Password)
									B.Open()
								else if(L.DoorPass2==B.Password)
									B.Open()
								else if(L.DoorPass3==B.Password)
									B.Open()
								else
									var/Guess=input(L.who,"Manually transmit password to door.") as text
									if(Guess==B.Password)
										B.Open()
						if(!happened)
							var/eee
							for(var/obj/Items/Tech/Door_Pass/L in Q)
								if(L.Password==B.Password)
									B.Open()
									if(istype(B,/obj/Items/Tech/Door/LazerDoor))
										if(B.DoorID)
											for(var/obj/Items/Tech/Door/LazerDoor/X in world)
												if(X.DoorID==B.DoorID)
													X.Open()
									eee=1
							for(var/obj/Items/Tech/Digital_Key/C in Q)
								if(C.Password==B.Password||C.Password2==B.Password||C.Password3==B.Password)
									B.Open()
									if(istype(B,/obj/Items/Tech/Door/LazerDoor))
										if(B.DoorID)
											for(var/obj/Items/Tech/Door/LazerDoor/X in world)
												if(X.DoorID==B.DoorID)
													X.Open()
									eee=1
							if(!eee&&!Q:Knockbacked)
								var/Guess=input(Q,"You must know the password to enter here") as text
								if(Guess==B.Password)
									B.Open()
									if(istype(B,/obj/Items/Tech/Door/LazerDoor))
										if(B.DoorID)
											for(var/obj/Items/Tech/Door/LazerDoor/X in world)
												if(X.DoorID==B.DoorID)
													X.Open()
								else
									if(istype(B,/obj/Items/Tech/Door/LazerDoor))
										Q << "The lazer door burns your hand!"
										Q:AddBurn(1)
					else
						B.Open()
			else
				B.Open()
/datum/globalTracker/var/SPEED_DELAY = 4
/datum/globalTracker/var/GOD_SPEED_MULT = 0.25
/datum/globalTracker/var/TOTAL_SPEED_BONUS = 1

mob/proc/MovementSpeed()
	var/Spd=max(0.1,round(sqrt(src.GetSpd(glob.TOTAL_SPEED_BONUS)),0.1))
	var/SpdMult=max(0.1,glob.GOD_SPEED_MULT*sqrt(src.HasGodspeed()))
	var/Delay=glob.SPEED_DELAY/(Spd*(1+SpdMult))
	if(src.Flying)
		Delay=0.25
		if(src.Attracted)
			Delay*=4
		return Delay
	else if(passive_handler.Get("Skimming") + is_dashing)
		Delay=0.75/sqrt(passive_handler.Get("Skimming") + is_dashing)
		if(src.Attracted)
			Delay*=4
		return Delay
	if(src.HasBlastShielding())
		Delay*=3
	if(src.CanBeSlowed())
		var/CombatSlow=10/max(src.Health,1)
		if(CombatSlow>1)
			if(src.Adrenaline)
				if(CombatSlow<2)
					Delay/=CombatSlow
				else
					Delay/=2
			else
				Delay*=CombatSlow
		if(Delay>49)
			Delay=50
	if(src.Afterimages())
		if(prob(40))
			FlashImage(src)
	if(Swim)
		if(passive_handler.Get("Fishman"))
			Delay/=2
		else
			Delay*=4
	if(src.Crippled)
		Delay*=2
	if(src.Attracted)
		Delay*=4
	if(src.SenseRobbed>=1&&(src.SenseUnlocked<=src.SenseRobbed&&src.SenseUnlocked>5))
		Delay*=(2*src.SenseRobbed)
	return Delay
mob/Move()
	if((!istype(src, /mob/Player/AI) &&!client)&&!Knockback&&!Move_Requirements())
		return
	var/turf/Former_Location=loc
	..()
	if(src.Incorporeal)
		src.density=0
	if(!Knockback&&Target&&istype(Target,/obj/Others/Build)&&MapperWalk) Build_Lay(Target,src, 0, 0, 0)
	if(AFKTimer==0)
		overlays-=AFKIcon
	AFKTimer=AFKTimeLimit

	if(!src.Incorporeal)
		for(var/mob/A in loc) if(A!=src&&A.Flying&&Flying)
			loc=Former_Location
			break
	if(!src.Incorporeal)
		for(var/obj/Items/Tech/Door/A in loc) if(A.density)
			loc=Former_Location
			Bump(A)
			break
	if(!src.Incorporeal)
		for(var/obj/Items/Tech/Reinforced_Door/A in loc) if(A.density)
			loc=Former_Location
			break
	if(!src.Incorporeal)
		for(var/obj/Effects/Barrier/A in loc) if(A.density)
			loc=Former_Location
			break
	if(!src.Incorporeal)
		for(var/obj/Effects/ForceField/A in loc) if(A.density)
			loc=Former_Location
			break

	for(var/obj/Seal/S in loc)
		if(S.Creator!=src.ckey)
			loc=Former_Location
			break

	for(var/obj/Effects/PocketPortal/A in loc) if(A.density)
		loc=Former_Location
		Bump(A)
		break
	for(var/obj/Effects/PocketExit/A in loc) if(A.density)
		loc=Former_Location
		Bump(A)
		break
	for(var/obj/Special/Teleporter2/A in loc) if(A.density&&Flying)
		Bump(A)
		break
	if(!src.Incorporeal)
		for(var/obj/Turfs/RoofGlass/A in loc) if(A.density&&Flying)
			loc=Former_Location
			Bump(A)
			break
	if(!Flying)
		var/turf/T=get_step(Former_Location,dir)
		if(T&&!T.Enter(src)) return
		if(!src.Incorporeal&&!src.passive_handler.Get("Skimming")&&!src.is_dashing&&!istype(src,/mob/Player/AI))
			for(var/obj/Turfs/Edges/A in loc)
				if(!(A.dir in list(dir,turn(dir,90),turn(dir,-90),turn(dir,45),turn(dir,-45))))
					if(!src.Knockback)
						loc=Former_Location
						break
		if(!src.Incorporeal&&!passive_handler.Get("Skimming")&&!src.is_dashing&&!istype(src,/mob/Player/AI))
			for(var/obj/Turfs/Edges/A in Former_Location) if(A.dir in list(dir,turn(dir,45),turn(dir,-45)))
				if(!src.Knockback)
					loc=Former_Location
					break
		for(var/obj/Special/Teleporter2/A in loc)
			if(A.density)
				Bump(A)
				TeleporterBump(A)
				break
	if(src.Grab)
		src.Grab_Update()
	if(loc != Former_Location)
		for(var/obj/Skills/Projectile/_Projectile/a in active_projectiles)
			if(a.Owner != src || !a.loc)
				active_projectiles -= a
			else if(Beaming == 0.5 && a.Cooldown>=0) //Cooldown is set to -1 when Life() is called.
				a.loc = locate(x,y,z)
