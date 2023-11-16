mob/proc/Oozaru(Go_Oozaru=1,var/revert)
	for(var/obj/Oozaru/O in src)
		var/image/Body=image(icon='Oozonew.dmi')
		var/image/GBody=image(icon='GOozonew.dmi', loc=src)
		var/image/GGlow=image(icon='GOozonewGlow.dmi', loc=src)
		if(Go_Oozaru)
			if(!src.Tail)return
			if(src.SSJ4Unlocked)return
			if(src.Dead)return
			if(src.ssj["Active"]>0)return

			if(src.ActiveBuff)
				if(src.CheckActive("Eight Gates"))
					src.ActiveBuff:Stop_Cultivation()
				else
					src.ActiveBuff.Trigger(src)
			if(src.SpecialBuff)
				src.SpecialBuff.Trigger(src)
			if(src.SlotlessBuffs.len>0)
				for(var/sb in SlotlessBuffs)
					var/obj/Skills/Buffs/b = SlotlessBuffs[sb]
					if(b)
						b.Trigger(src)

			Oozaru(0)
			src.Oozaru=1
			animate(src, transform = matrix()*0.5)
			O.icon=icon
			icon=Body
			pixel_x=-32
			pixel_y=-32
			AppearanceOff()
			animate(src, transform = matrix(), time = 10)
			if(src.ssj["unlocked"]>3)
				src.Golden=1
				spawn(20)
					world << GBody
					world << GGlow
					animate(GBody, alpha=0)
					animate(GGlow, alpha=0)
					animate(GBody, alpha=255, time=10)
					animate(GGlow, alpha=255, time=15)
					spawn(10)
						src.overlays+=image(icon='GOozonew.dmi')
						del GBody
						animate(GGlow, alpha=0, time=5)
						spawn(5)
							del GGlow

			src.PoweringUp=0
			src.PoweringDown=0
			src.PowerControl=100

			src.NoDodge+=1
			src.GiantForm+=1
			src.EndlessAnger+=1
			src.AuraLocked=1
			src.AuraLock='BLANK.dmi'
			src.Anger=2

			if(!src.Golden)
				src.potential_trans=10//5 bp :3
			else
				src.potential_trans=75//still 250

			if(revert)
				spawn(revert)Oozaru(0)
			else
				src.OozaruTimer=900
			spawn(rand(0,10)) for(var/mob/P in view(20,src)) P<<sound('Roar.wav', repeat = 0, wait = 0, channel = 0, volume = 50)


		else if(O.icon)
			if(!src.Golden)
				src.NoDodge-=1
				src.EndlessAnger-=1
				src.GiantForm-=1
				src.AuraLocked=0
				src.AuraLock=null
				src.Anger=0
				potential_trans=10
				src.Oozaru=0

				animate(src, transform = matrix()*2)
				icon=O.icon
				O.icon=null
				pixel_x=0
				pixel_y=0
				AppearanceOn()
				animate(src, transform = matrix(), time = 10)
			else
				src.masteries["4mastery"]=1
				src.NoDodge-=1
				src.PUSpeedModifier*=1.5
				src.PureDamage+=3
				src.PureReduction+=3
				src.BuffMastery+=2
				src.Flicker+=2
				src.Pursuer+=2
				src.SuperDash+=1
				src.Instinct+=1
				src.AuraLocked=0
				src.AuraLock=null

				src.Oozaru=0
				src.Transformed=1
				src.SSJ4Unlocked=1

				if(src.KO)
					src.MortallyWounded=0
					src.TsukiyomiTime=1
					src.KOTimer=0
					src.KO=0
					src.icon_state=""

				src.Sheared=0
				src.TotalInjury=0
				src.TotalFatigue=0
				src.BPPoison=1
				src.BPPoisonTimer=0
				src.HealHealth(100)
				src.HealEnergy(100)
				src.HealMana(100)

				animate(src, transform = matrix()*2, color = list(1,0,0, 0,1,0, 0,0,1, 1,1,1))
				icon=O.icon
				O.icon=null
				overlays=null
				pixel_x=0
				pixel_y=0
				src.overlays+=FurSSJ4
				src.overlays+=ClothingSSJ4
				src.overlays+=TailSSJ4
				ssj["active"]=4
				Hairz("Add")
				Auraz("Add")
				animate(src, transform = matrix(), color = null, time = 10)
obj/Oozaru
	var/Looking=1
	verb/Oozaru()
		set category="Other"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		Looking=!Looking
		if(usr.Oozaru&&usr.EraBody=="Child")
			usr<<"You cannot will yourself out of the transformed state!"
			return
		if(Looking)
			usr<<"You will look at the moon"
			if(usr.Tail)
				usr.Tail(0)
				usr.Tail(1)
		else
			usr<<"You will not look at the moon"
			usr.Oozaru(0)
			if(usr.Tail)
				usr.Tail(0)
				usr.Tail=1

mob/proc/Tail(Add_Tail=1)
	if(Add_Tail) Tail(0)
	var/image/T=image(src.TailIcon)
	var/image/T3
	if(src.TailIconUnderlay)
		T3=image(src.TailIconUnderlay)
	var/image/T2=image(src.TailIconWrapped)
	if(Add_Tail)
		overlays-=T
		overlays-=T2
		underlays-=T3
		Tail=1
		overlays+=T
		underlays+=T3
	else
		Tail=0
		overlays-=T
		overlays-=T2
		underlays-=T3
		Oozaru(0)
		overlays+=T2

obj/ProjectionMoon
	icon='MoonP.dmi'
	layer=EFFECTS_LAYER
	New()
		spawn() src.Project()
	proc/Project()
		spawn(100)if(src)del(src)
		src.icon_state="Other On"
		animate(src,pixel_z=80,flags=ANIMATION_RELATIVE,time=20)
		sleep(20)
		src.icon_state="On"
		sleep(10)
		view(10,src)<<"<font color=red><small>The moon emits an odd glow.."
		if(src)
			for(var/mob/Players/P in view(10))
				P.Oozaru(1)
				if(locate(/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form, P))
					if(!P.CheckSlotless("FullMoonForm"))
						if(P.SpecialBuff)
							P.SpecialBuff.Trigger(P)
						if(P.SlotlessBuffs.len>0)
							for(var/sb in P.SlotlessBuffs)
								var/obj/Skills/Buffs/b = P.SlotlessBuffs[sb]
								if(b)
									b.Trigger(P)
						for(var/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form/F)
							F.Trigger(P)



