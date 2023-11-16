proc
	LeaveImage(var/mob/Players/User=0, var/Image, var/PX=0, var/PY=0, var/PZ=0, var/Size=1, var/Under=0, var/Time, var/turf/AltLoc=0, var/Dir=SOUTH)
		var/image/i
		if(User&&!AltLoc)
			if(Under)
				i=image(loc=User, icon=Image, pixel_x=PX-User.pixel_x, pixel_y=PY-User.pixel_y, pixel_z=PZ, layer=User.layer-1, dir=User.dir)
			else
				i=image(loc=User, icon=Image, pixel_x=PX-User.pixel_x, pixel_y=PY-User.pixel_y, pixel_z=PZ, layer=EFFECTS_LAYER, dir=User.dir)
			if(User.Oozaru)
				i.transform*=3
		if(AltLoc&&!User)
			if(Under)
				i=image(loc=AltLoc, icon=Image, pixel_x=PX, pixel_y=PY, pixel_z=PZ, layer=MOB_LAYER-1, dir=Dir)
			else
				i=image(loc=AltLoc, icon=Image, pixel_x=PX, pixel_y=PY, pixel_z=PZ, layer=EFFECTS_LAYER, dir=Dir)
			i.appearance_flags=KEEP_APART | RESET_COLOR | RESET_ALPHA
		i.transform*=Size
		i.alpha=0
		world << i
		animate(i, alpha=255, time=2)
		sleep(Time)
		animate(i, alpha=0, time=2)
		sleep(2)
		del i
	LeaveDescendingImage(var/mob/Players/User=0, var/Image, var/PX=0, var/PY=0, var/PZ=0, var/Size=1, var/Under=0, var/Time, var/turf/AltLoc=0, var/Dir=SOUTH)
		var/image/i
		if(User&&!AltLoc)
			if(Under)
				i=image(loc=User, icon=Image, pixel_x=PX-User.pixel_x, pixel_y=PY-User.pixel_y, pixel_z=PZ, layer=User.layer-1, dir=User.dir)
			else
				i=image(loc=User, icon=Image, pixel_x=PX-User.pixel_x, pixel_y=PY-User.pixel_y, pixel_z=PZ, layer=EFFECTS_LAYER, dir=User.dir)
			if(User.Oozaru)
				i.transform*=3
		if(AltLoc&&!User)
			if(Under)
				i=image(loc=AltLoc, icon=Image, pixel_x=PX, pixel_y=PY, pixel_z=PZ, layer=MOB_LAYER-1, dir=Dir)
			else
				i=image(loc=AltLoc, icon=Image, pixel_x=PX, pixel_y=PY, pixel_z=PZ, layer=MOB_LAYER+1, dir=Dir)
			i.appearance_flags=KEEP_APART | RESET_COLOR | RESET_ALPHA
		i.transform*=Size
		i.alpha=0
		world << i

		animate(i, alpha=255, time=2)
		animate(i, pixel_z=0, time=Time)
		sleep(Time)
		animate(i, alpha=0, time=2)
		sleep(2)
		del i

	LeaveTrail(var/Trail, var/PX=0, var/PY=0, var/Dir, var/turf/Location, var/Time, var/Size, var/State)
		if(Trail=='Icons/Turfs/GalSpace.dmi') //ill add in a variable for randomization later
			State = "[rand(1,25)]"
		var/image/i=image(Trail, pixel_x=PX, pixel_y=PY, dir=Dir, icon_state=State)
		i.transform*=Size
		world << i
		i.loc=Location
		spawn(Time)
			animate(i, alpha=0, time=2)
			sleep(2)
			del i

	Jump(var/mob/User, var/UpTime=3, var/FloatTime=0, var/DownTime=2)
		animate(User,pixel_z=48,time=UpTime, easing=BACK_EASING, flags=ANIMATION_END_NOW | ANIMATION_RELATIVE)
		sleep(UpTime)
		if(FloatTime)
			sleep(FloatTime*10)
		animate(User,pixel_z=-48,time=DownTime, easing=QUAD_EASING, flags=ANIMATION_END_NOW | ANIMATION_RELATIVE)

	// LaunchEffect(var/mob/User, var/mob/Target, var/TimeMod=1, var/Delay=0) //LAUNCH BOOOOX
	// 	if(Target.ContinuousAttacking)
	// 		for(var/obj/Skills/Projectile/p in Target.contents)
	// 			if(p.ContinuousOn && !p.StormFall)
	// 				Target.UseProjectile(p)
	// 			continue
	// 	if(Delay)
	// 		sleep(Delay)
	// 		User.Frozen=0
	// 		User.NextAttack=0
	// 		flick("Attack",User)
	// 		KenShockwave(Target,Size=1)


	// 	if(Target.Grounded)
	// 		Target.Grounded--
	// 		if(Target.Grounded<0)
	// 			Target.Grounded=0
	// 		User.Frozen=0
	// 		Target.Frozen=0
	// 		User << "<b>[Target] stands their ground!</b>"
	// 		Target << "<b>You stands your ground!</b>"
	// 		return
	// 	// stand ground check

	// 	Target.Frozen=1
	// 	if(Target.Launched>0 && Target.startOfLaunch + MAX_LAUNCH_TIME < world.time)
	// 		Target.Launched+=max(2,2 * TimeMod/2)
	// 		if(Target.Launched >= 30) Target.Launched=30
	// 		return
	// 	else
	// 		Target.startOfLaunch = world.time
	// 		Target.Launched+=20 * TimeMod
	// 	var/NewZ=Target.pixel_z
	// 	Target.ForceCancelBeam()
	// 	Target.ForceCancelBuster()
	// 	while(Target.Launched>0)
	// 		if(Target.Launched>15)
	// 			animate(Target,pixel_z=min(NewZ+2,16),icon_state="KB", easing=SINE_EASING, time=1)
	// 			NewZ=Target.pixel_z
	// 			Target.Launched-=1
	// 		else
	// 			Target.Launched-=2
	// 		animate(Target,pixel_z=max(NewZ-2,0),icon_state="KB", easing=SINE_EASING, time=1)
	// 		NewZ=Target.pixel_z
	// 		sleep(1)
	// 	LaunchLand(Target)
	// LaunchLand(var/mob/Target)
	// 	Target.Frozen=0
	// 	Target.Launched=0
	// 	Target.Grounded++
	// 	if(Target.Juggernaut||Target.LegendaryPower > 0.25)
	// 		if(Target.Juggernaut>1)
	// 			Target.Grounded+=(Target.Juggernaut-1)
	// 		Target.Grounded++
	// 	animate(Target,pixel_z=0, time=3, easing=SINE_EASING, flags=ANIMATION_END_NOW)
	// 	if(!Target.KO&&!Target.Knockback)
	// 		Target.icon_state=""

	SuplexEffect(var/mob/User, var/mob/Target) //MATTHEEEEEEEEW
		User.Frozen=2
		Target.Frozen=2
		animate(Target, pixel_z=24, time=5, flags=ANIMATION_RELATIVE)
		sleep(5)
		animate(User, transform=turn(User.transform, -45), time=3)
		animate(Target, pixel_x=-32, pixel_z=-24, time=2, flags=ANIMATION_RELATIVE)
		animate(Target, transform=turn(Target.transform, -135), time=2, flags=ANIMATION_PARALLEL)
		spawn(2)
			KenShockwave(Target,Size=2)
		sleep(10)
		animate(User, transform= turn(User.transform, 45))
		animate(Target, pixel_x=32, flags=ANIMATION_RELATIVE | ANIMATION_PARALLEL)
		animate(Target, transform= turn(Target.transform, 135), flags=ANIMATION_PARALLEL)
		User.Frozen=0
		Target.Frozen=0

	RozanEffect(var/mob/User, var/mob/Target, var/TimeMod=1)
		set waitfor=0
		User.Frozen=2
		Target.Frozen=2
		var/obj/Effects/RozanEffect/SE=new
		SE.appearance_flags = KEEP_APART | RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
		SE.Target=Target
		Target.vis_contents += SE
		animate(SE,alpha=0)
		animate(SE,alpha=185,time=10)
		flick("Appear",SE)
		var/ShoryukenTime=4*TimeMod
		var/DelayTime=1
		var/NewZ=Target.pixel_z
		while(ShoryukenTime>0)
			animate(Target,pixel_z=NewZ+15,DelayTime)
			User.HitEffect(Target)
			sleep(DelayTime)
			NewZ=Target.pixel_z
			ShoryukenTime--
		if(SE)
			flick("Vanish",SE)
			animate(SE,alpha=0,time=3)
			spawn(3)
				SE.EffectFinish()
		animate(Target,pixel_z=NewZ+4,time=5)
		sleep(5)
		animate(Target,pixel_z=0,time=5)
		User.Frozen=0
		Target.Frozen=0
	ShoryukenEffect(var/mob/User, var/mob/Target, var/TimeMod=1)
		set waitfor=0
		User.Frozen=2
		Target.Frozen=2
		var/obj/Effects/ShoryukenEffect/SE=new
		SE.loc=User.loc
		animate(SE,alpha=0)
		animate(SE,alpha=185,time=10)
		flick("Appear",SE)
		var/ShoryukenTime=4*TimeMod
		var/DelayTime=1
		var/NewZ=Target.pixel_z
		spawn()
			Turn(User, ShoryukenTime)
		while(ShoryukenTime>0)
			animate(Target,pixel_z=NewZ+15,DelayTime)
			animate(User,pixel_z=NewZ+13,DelayTime)
			animate(SE,pixel_z=NewZ,DelayTime)
			if(TimeMod>2)
				User.HitEffect(Target)
			sleep(DelayTime)
			User.dir=turn(User.dir,90)
			NewZ=Target.pixel_z
			ShoryukenTime--
		if(SE)
			flick("Vanish",SE)
			animate(SE,alpha=0,time=3)
			spawn(3)
				SE.EffectFinish()
		animate(Target,pixel_z=NewZ+4,time=5)
		animate(User,pixel_z=NewZ+2,time=5)
		sleep(5)
		animate(Target,pixel_z=0,time=7)
		animate(User,pixel_z=0,time=5)
		User.Frozen=0
		Target.Frozen=0
	GoshoryukenEffect(var/mob/User, var/mob/Target, var/TimeMod=1)
		set waitfor=0
		User.Frozen=2
		Target.Frozen=2
		var/obj/Effects/GoshoryukenEffect/SE=new
		SE.loc=User.loc
		animate(SE,alpha=0)
		animate(SE,alpha=185,time=10)
		flick("Appear",SE)
		var/ShoryukenTime=4*TimeMod
		var/DelayTime=1
		var/NewZ=Target.pixel_z
		spawn()
			Turn(User, ShoryukenTime)
		while(ShoryukenTime>0)
			animate(Target,pixel_z=NewZ+15,DelayTime)
			animate(User,pixel_z=NewZ+13,DelayTime)
			animate(SE,pixel_z=NewZ,DelayTime)
			if(TimeMod>2)
				User.HitEffect(Target)
			sleep(DelayTime)
			User.dir=turn(User.dir,90)
			NewZ=Target.pixel_z
			ShoryukenTime--
		if(SE)
			flick("Vanish",SE)
			animate(SE,alpha=0,time=3)
			spawn(3)
				SE.EffectFinish()
		animate(Target,pixel_z=NewZ+4,time=5)
		animate(User,pixel_z=NewZ+2,time=5)
		sleep(5)
		animate(Target,pixel_z=0,time=7)
		animate(User,pixel_z=0,time=5)
		User.Frozen=0
		Target.Frozen=0

	LotusEffect(var/mob/User, var/mob/Target, var/TimeMod=1)
		User.loc=Target.loc
		User.Frozen=2
		Target.Frozen=2
		animate(Target,pixel_z=4*TimeMod*20,time=5)
		animate(User,pixel_z=4*TimeMod*20,time=5)
		sleep(5)
		animate(User, transform=turn(User.transform,90), time=5, flags=ANIMATION_LINEAR_TRANSFORM)
		animate(Target, transform=turn(Target.transform,90), time=5, flags=ANIMATION_LINEAR_TRANSFORM)
		animate(User, transform=turn(User.transform,90), time=5, flags=ANIMATION_LINEAR_TRANSFORM+ANIMATION_END_NOW)
		animate(Target, transform=turn(Target.transform,90), time=5, flags=ANIMATION_LINEAR_TRANSFORM+ANIMATION_END_NOW)
		sleep(5)
		var/ShoryukenTime=3*TimeMod
		animate(Target,pixel_z=0,time=ShoryukenTime,flags=ANIMATION_END_NOW)
		animate(User,pixel_z=0,time=ShoryukenTime,flags=ANIMATION_END_NOW)
		spawn()
			Turn(Target, ShoryukenTime)
		spawn()
			Turn(User, ShoryukenTime)
		sleep(ShoryukenTime)
		Dust(Target.loc,2)
		Dust(Target.loc,2)
		Dust(Target.loc,2)
		if(TimeMod>=3)
			spawn()Crater(Target,TimeMod/3)
		User.transform=turn(User.transform, -180)
		Target.transform=turn(Target.transform, -180)
		User.Frozen=0
		Target.Frozen=0

	Turn(var/mob/a, var/Time=1)
		while(Time>=0)
			animate(a,dir=turn(a.dir,90),time=1, flags=ANIMATION_PARALLEL)
			Time--
			sleep(1)

	WarpEffect(var/mob/Target, var/EffectType)
		if(EffectType==1)
			Target.Stasis=100
			animate(Target, alpha=0, time=30)
			spawn(30)
				var/z=11
				for(var/mob/m in view(10,Target))
					m<<"[Target] was cast out to another dimension!"
				Target.loc=locate(Target.x,Target.y,z)
				spawn(5)
					animate(Target, alpha=255, time=5)
					Target.Stasis=0
		else if(EffectType==2)
			Target.Stasis=100
			animate(Target, color = list(1,0,0, 0,1,0, 0,0,1, 1,1,1),time=2)
			spawn(3)
				animate(Target, color=null, time=1)
				Target.Stasis=0
				if(Target.z!=12)
					Target.PrevX=Target.x
					Target.PrevY=Target.y
					Target.PrevZ=Target.z
					Target.loc=locate(144,50,12)
					Target.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Punishment_of_Hell)
					sleep(10)
					Target.loc=locate(116,82,12)
					Target.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Punishment_of_Spectres)
					sleep(10)
					Target.loc=locate(144,82,12)
					Target.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Punishment_of_Beasts)
					sleep(10)
					Target.loc=locate(171,82,12)
					Target.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Punishment_of_Humans)
					sleep(10)
					Target.loc=locate(116,50,12)
					Target.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Punishment_of_Demons)
					sleep(10)
					Target.loc=locate(171,50,12)
					Target.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Punishment_of_Heaven)
					sleep(10)
					Target.loc=locate(Target.PrevX,Target.PrevY,Target.PrevZ)
		else if(EffectType==3)
			spawn()
				RecoverImage(Target)
			spawn(2)
				RecoverImage(Target)
			spawn(4)
				RecoverImage(Target)
			sleep(12)
			// Target.Leave_Body(ForceVoid=1.5)
		else if(EffectType==4)
			Target.Stasis=100
			sleep(30)
			animate(Target, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=3)
			sleep(3)
			animate(Target, alpha=0, time=2)
			var/z=pick(2,3,5,6,11,12)
			for(var/mob/m in view(10,Target))
				m<<"[Target] was cast out to another dimension!"
			Target.loc=locate(Target.x,Target.y,z)
			spawn(5)
				animate(Target, color=Target.MobColor, alpha=255)
				Target.Stasis=0


	FusionEffect(var/mob/User, var/mob/Target)
		User.Frozen=2
		Target.Frozen=2
		var/x=(User.x-Target.x)/2
		var/y=(User.y-Target.y)/2
		animate(User, pixel_x=x*(-32), pixel_y=y*(-32), color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=15)
		animate(Target, pixel_x=x*(32), pixel_y=y*(32), color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=15)
		sleep(20)
		if(User)
			User.Frozen=0
			animate(User, pixel_x=0, pixel_y=0, color=null)
		Target.Frozen=0
		animate(Target, pixel_x=0, pixel_y=0, color=null)

	TransformBeyond(var/mob/m) //Handles shiny transes
		m.Frozen=1
		sleep(1)
		if(m.TransformingBeyond)
			for(var/turf/t in Turf_Circle(m, 18))
				if(prob(5))
					spawn(rand(2,6))
						var/icon/i = icon('RisingRocks.dmi')
						t.overlays+=i
						spawn(rand(20, 60))
							t.overlays-=i
			spawn(10)
				TransformBeyond(m)
				KenShockwave2(m, icon='KenShockwaveGold.dmi', Size=10)
		m.Frozen=0

	PowerGathering(var/mob/m) //Handles shiny transes
		sleep(1)
		spawn(10)
			PowerGathering(m)
			KKTShockwave(m, icon='fevKiai.dmi', Size=0.5)

	TurfShift(var/Shift, var/turf/t, var/Time=30, var/mob/m, var/layer=MOB_LAYER-0.5, var/Spawn=10, var/Despawn=10,var/state)
		var/image/i=image(icon=Shift, layer=layer, loc=t)
		animate(i, alpha=0)
		world << i
		if(Shift=='Icons/Turfs/GalSpace.dmi')
			i.icon_state = "[rand(1,25)]"
		if(Shift=='StarPixel.dmi')
			i.icon_state="[rand(1,2500)]"
		else if(state)
			i.icon_state=state
		else if(Shift=='Mandala.dmi')
			if(i.loc==m.loc||(get_dist(m.loc,i.loc)==1&&(i.x==m.x||i.y==m.y)))
				i.icon_state="2"
			else if(get_dist(m.loc,i.loc)==1)
				i.icon_state="3"
			else
				i.icon_state="[pick(4,1)]"
		else if(Shift=='amaterasu.dmi')
			i.layer=MOB_LAYER
			i.icon_state="[rand(1,13)]"
		animate(i, alpha=255, time=Spawn)
		spawn(10+Time)
			animate(i, alpha=0, time=Despawn)
			sleep(10)
			del i

	Crater(atom/A, Size=1)
		set waitfor=0
		if(!locate(/obj/Effects/Crater) in A.loc)
			var/obj/Effects/Crater/C=new
			C.loc=A.loc
			animate(C, transform=matrix()*Size, time=3)
		else
			for(var/obj/Effects/Crater/B in A.loc)
				animate(B, transform=matrix()*Size, time=3)

	Dust(turf/A, var/Size=1, var/Layer=EFFECTS_LAYER)
		set waitfor=0
		var/obj/Effects/Dust/D=new
		D.loc=A
		D.layer=Layer
		animate(D, transform=matrix()*Size, time=2)
		spawn(2)
			animate(D, alpha = 0, transform=D.transform*2, time = rand(15, 25), pixel_x = rand(-16*Size, 16*Size), pixel_y = rand(-16*Size, 16*Size))

	Bang(turf/A, var/Size=1, var/Layer=EFFECTS_LAYER, var/Offset=1, var/Vanish=4, var/PX=0, var/PY=0, var/icon_override)
		set waitfor=0
		var/obj/Effects/Explosion/E=new
		E.loc=A
		if(icon_override) E.icon = icon_override
		E.layer=Layer
		E.pixel_x+=PX
		E.pixel_y+=PY
		animate(E, transform=matrix()*Size, time=2)
		spawn(2)
			animate(E, alpha = 0, transform=E.transform*2, time = Vanish, pixel_x = rand(-16*Offset*Size, 16*Offset*Size), pixel_y = rand(-16*Offset*Size, 16*Offset*Size))
			sleep(Vanish)
			E.EffectFinish()

mob/proc
	ForceField()
		var/image/FF=image('Force Field.dmi',pixel_x=0,pixel_y=0, loc = src)
		FF.blend_mode=2
		world << FF
		animate(FF, alpha=0, time=0)
		animate(FF, alpha=175, time=5)
		sleep(10)
		animate(FF, alpha=0, time=5)
		sleep(5)
		del FF
		src.Shielding=0
	AvalonField()
		var/image/FF=image('AvalonMode.dmi',pixel_x=0,pixel_y=0, loc = src)
		FF.blend_mode=2
		world << FF
		animate(FF, alpha=0, time=0)
		animate(FF, alpha=175, time=5)
		sleep(10)
		animate(FF, alpha=0, time=5)
		sleep(5)
		del FF
		src.Shielding=0

	FlickeringGlow(var/mob/m, var/list/Glow=list(1,0.8,0.8, 0,1,0, 0.8,0.8,1, 0,0,0)) //Handles shiny transes
		if(m.FlickeringGlow) return
		m.FlickeringGlow=1
		while(m.TransformingBeyond)
			animate(m, color=Glow, time=10, flags=ANIMATION_RELATIVE || ANIMATION_PARALLEL)
			sleep(10)
			animate(m, color=src.MobColor, time=10, flags=ANIMATION_RELATIVE || ANIMATION_PARALLEL)
			sleep(10)
		animate(m, color=src.MobColor, time=10, flags=ANIMATION_RELATIVE || ANIMATION_PARALLEL)
		m.FlickeringGlow=0
		return

	WindupGlow(var/mob/m) //Handles shiny transes
		if(m.WindingUp<1) return
		for(var/x in 1 to m.WindingUp+1)
			animate(m, color=list(1,0,0, 0.5,0.5,0, 0.5,0,0.5, 0,0,0), time=2, flags=ANIMATION_RELATIVE || ANIMATION_PARALLEL)
			sleep(2)
			animate(m, color=src.MobColor, time=2, flags=ANIMATION_RELATIVE || ANIMATION_PARALLEL)
			sleep(2)
		animate(m, color=src.MobColor, time=2, flags=ANIMATION_RELATIVE || ANIMATION_PARALLEL)
		return

	Kyoukaken(var/Z)
		var/image/MI
		var/mob/User=src
		var/mob/Target=src.Target
		if(Z=="On")
			Kyoukaken("Off")
			MI=image(Target.appearance, pixel_x=Target.pixel_x, pixel_y=Target.pixel_x)
			MI.alpha=100
			MI.transform*=1.6
			User.MirrorIcon=MI
			User.underlays+=User.MirrorIcon
		if(Z=="Off")
			User.underlays-=User.MirrorIcon
			User.MirrorIcon=null

	StasisEffect(var/Z)
		var/image/i=image('ice aura.dmi', pixel_x=-8, pixel_y=-2, layer=EFFECTS_LAYER, loc=src)
		var/image/i2=image('ice aura.dmi', pixel_x=-8, pixel_y=-2, layer=EFFECTS_LAYER, loc=src)
		i.appearance_flags=KEEP_APART | RESET_ALPHA | RESET_COLOR
		i.icon_state="Form"
		i2.appearance_flags=KEEP_APART | RESET_ALPHA | RESET_COLOR
		i2.icon_state=""
		world << i
		animate(i, alpha=0)
		if(Z=="Form")
			src.overlays-=i2
			src.StasisFrozen=1
			animate(i, alpha=255)
			spawn(9)
				src.overlays+=i2
				del i
		if(Z=="Thaw")
			src.overlays-=i2
			animate(i, alpha=255)
			i.icon_state="Thaw"
			spawn(6)
				del i
				src.StasisFrozen=0

	Blind(var/duration=1000)
		animate(src.client, color = list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=5)
		sleep(5)
		animate(src.client, color = null, time=duration)