mob/var/list/ssj=list(\
"1multi"=1,
"2multi"=1,
"3multi"=1,
"4multi"=1,
"god"=0,
"active"=0,"unlocked"=0,"transing"=0)
mob/var/list/trans=list(\
"1multi"=1,
"2multi"=1,
"3multi"=1,
"4multi"=1,
"tension"=0,
"active"=0,"unlocked"=0,"transing"=0)
mob/var/list/masteries=list(\
"1mastery"=1,"2mastery"=1,"3mastery"=1,"4mastery"=1)


mob
	var
		BaseBase
		BaseBaseX
		BaseBaseY
		Form1Base
		Form1BaseX
		Form1BaseY
		Form2Base
		Form2BaseX
		Form2BaseY
		Form3Base
		Form3BaseX
		Form3BaseY
		Form4Base
		Form4BaseX
		Form4BaseY
		Form1Hair
		Form1HairX
		Form1HairY
		Form2Hair
		Form2HairX
		Form2HairY
		Form3Hair
		Form3HairX
		Form3HairY
		Form4Hair
		Form4HairX
		Form4HairY
		Form1Aura
		Form1AuraX
		Form1AuraY
		Form2Aura
		Form2AuraX
		Form2AuraY
		Form3Aura
		Form3AuraX
		Form3AuraY
		Form4Aura
		Form4AuraX
		Form4AuraY
		Form1Overlay
		Form1OverlayX
		Form1OverlayY
		Form2Overlay
		Form2OverlayX
		Form2OverlayY
		Form3Overlay
		Form3OverlayX
		Form3OverlayY
		Form4Overlay
		Form4OverlayX
		Form4OverlayY
		Form1TopOverlay
		Form1TopOverlayX
		Form1TopOverlayY
		Form2TopOverlay
		Form2TopOverlayX
		Form2TopOverlayY
		Form3TopOverlay
		Form3TopOverlayX
		Form3TopOverlayY
		Form4TopOverlay
		Form4TopOverlayX
		Form4TopOverlayY
		Form1ActiveText
		Form2ActiveText
		Form3ActiveText
		Form4ActiveText
		Form1RevertText
		Form2RevertText
		Form3RevertText
		Form4RevertText
		BaseProfile
		Form1Profile
		Form2Profile
		Form3Profile
		Form4Profile

		Form5Base//Basically only used by changeling and SSjG
		Form5BaseX
		Form5BaseY
		Form5Hair//For SSjG and SSjR
		Form5HairX
		Form5HairY
		Form5Profile
		Form5Aura
		Form5AuraX
		Form5AuraY



mob/proc/SetVars()

	if(src.Race=="Human")
		if(src.LegendaryPower)
			src.trans["1multi"]=1
		if(src.HellPower)
			src.trans["1multi"]=2

	if(src.Race=="Alien")
		src.trans["1multi"]=1.25

	if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
		src.ssj["1multi"]=2.5
		src.ssj["2multi"]=2
		src.ssj["3multi"]=2
		src.ssj["4multi"]=50

	else if(src.Race=="Changeling")
		src.trans["1multi"]=2
		src.trans["2multi"]=4
		src.trans["3multi"]=7.5
		src.trans["4multi"]=3

mob/Admin3/verb
	Flash(var/mob/m)
		DarknessFlash(m)

proc/DarknessFlash(var/mob/Z, var/SetTime=0)
	set background=1
	var/Time
	if(!SetTime)
		Time=60
	else
		Time=SetTime
	for(var/mob/Players/T in players)
		if(T.z==Z.z)
			animate(T.client, color=list(0.5,0,0, 0,0.5,0, 0,0,0.5, 0,0,0), time = Time*0.5)
			spawn(Time*1.5)
				animate(T.client, color=null, time = Time*0.5)

mob/proc/CanTransform()
	if(src.ssj["transing"]==1||src.trans["transing"]==1)
		return 0
	if(src.ssj["god"])
		return 0
	if(src.CyberCancel&&src.Race!="Android")
		return 0
	if(src.TotalFatigue>=90)
		src<<"You are too tired to transform!"
		return 0
	for(var/obj/Oozaru/O in src)
		if(O.icon)
			return 0
	if(src.ActiveBuff)
		if(src.ActiveBuff.NeedsSSJ)
			src<<"Your ascended super state uses too much power to enter another level!"
			return 0
		if(src.ActiveBuff.NeedsTrans)
			src<<"Your ascended transformation uses too much power to enter another level!"
			return 0
	if(src.SpecialBuff)
		if(src.SpecialBuff.NeedsSSJ)
			src<<"Your ascended super state uses too much power to enter another level!"
			return 0
		if(src.SpecialBuff.NeedsTrans)
			if(src.Race=="Changeling"&&src.TransUnlocked()<4)
				src<<"Your ascended transformation uses too much power to enter another level!"
				return 0
	for(var/b in SlotlessBuffs)
		var/obj/Skills/Buffs/sb = SlotlessBuffs[b]
		if(sb)
			if(sb.NeedsSSJ)
				src<<"Your ascended super state uses too much power to enter another level!"
				return 0
			if(sb.NeedsTrans)
				src<<"Your ascended transformation uses too much power to enter another level!"
				return 0
	return 1

mob/proc/CanRevert()
	if(src.ssj["transing"]==1||src.trans["transing"]==1)
		return 0
	if(src.CyberCancel&&src.Race!="Android")
		return 0
	if(src.HasNoRevert())
		return 0
	if(src.ActiveBuff)
		if(src.ActiveBuff.NeedsTrans||src.ActiveBuff.NeedsSSJ)
			src.ActiveBuff.Trigger(src)
	if(src.SpecialBuff)
		if(src.SpecialBuff.NeedsTrans||src.SpecialBuff.NeedsSSJ)
			src.SpecialBuff.Trigger(src)
	for(var/b in SlotlessBuffs)
		var/obj/Skills/Buffs/sb = SlotlessBuffs[b]
		if(sb)
			if(sb.NeedsTrans||sb.NeedsSSJ)
				sb.Trigger(src)
	return 1


//High Tension
mob/proc/HighTension(var/x)
	var/image/tensiona=image('HTAura.dmi',pixel_x=-16, pixel_y=-4)
	var/image/tension=image('HighTension.dmi',pixel_x=-32,pixel_y=-32)
	var/image/tensionh=image(src.Hair_HT, layer=FLOAT_LAYER-1)
	var/image/tensionhs=image(src.Hair_SHT, layer=FLOAT_LAYER-1)
	var/image/tensione=image('EyesHT.dmi', layer=FLOAT_LAYER-2)
	tensiona.blend_mode=BLEND_ADD
	tension.blend_mode=BLEND_ADD
	tensionh.blend_mode=BLEND_ADD
	tensionh.alpha=200
	tensionhs.blend_mode=BLEND_ADD
	tensionhs.alpha=130
	sleep()
	if(x >= 100) x = 100
	else if(x >= 50) x = 50
	else if(x >= 20) x = 20
	trans["tension"]=x
	src.Hairz("Remove")
	if(x==20)
		src.PowerBoost+=0.25
		src.EnergyExpenditure+=0.5//1.25
	if(x==50)
		src.PowerBoost+=0.5
		src.EnergyExpenditure+=1//1.5
	if(x>=100)
		src.PowerBoost+=1
		src.EnergyExpenditure+=2//2
	src.StrMultTotal+=0.25
	src.EndMultTotal+=0.25
	src.ForMultTotal+=0.25
	src.SpdMultTotal+=0.25
	OMsg(src, "<font color='#FF00FF'>[src] spikes their tension - [x]%!</font color>")
	if(x==100)
		OMsg(src, "<b><font color='#FF00FF'>[src] activated Super High Tension!!!</font color></b>")
	if(src.trans["tension"]==20)
		src.Hairz("Add")
		src.overlays+=tension
	if(src.trans["tension"]==50)
		src.overlays+=tensione
		src.Hairz("Add")
		src.overlays+=tensionh
		src.overlays+=tension
	if(src.trans["tension"]==100)
		src.overlays+=tensione
		src.Hairz("Add")
		src.overlays+=tensionhs
		src.overlays+=tension
	src.underlays+=tensiona
	spawn(50)
		if(!src.HasKiControl()&&!src.PoweringUp)
			src.Auraz("Remove")

mob/proc/RevertHT()
	var/image/tensiona=image('HTAura.dmi',pixel_x=-16, pixel_y=-4)
	var/image/tension=image('HighTension.dmi',pixel_x=-32,pixel_y=-32)
	var/image/tensionh=image(src.Hair_HT, layer=FLOAT_LAYER-1)
	var/image/tensionhs=image(src.Hair_SHT, layer=FLOAT_LAYER-1)
	var/image/tensione=image('EyesHT.dmi', layer=FLOAT_LAYER-2)
	tensiona.blend_mode=BLEND_ADD
	tension.blend_mode=BLEND_ADD
	tensionh.blend_mode=BLEND_ADD
	tensionh.alpha=200
	tensionhs.blend_mode=BLEND_ADD
	tensionhs.alpha=130
	src.overlays-=tension
	src.overlays-=tensionh
	src.overlays-=tensionhs
	src.overlays-=tensione
	src.underlays-=tensiona
	if(src.trans["tension"]==20)
		src.PowerBoost-=0.25
		src.EnergyExpenditure-=0.5
	if(src.trans["tension"]==50)
		src.PowerBoost-=0.5
		src.EnergyExpenditure-=1
	if(src.trans["tension"]==100)
		src.PowerBoost-=1
		src.EnergyExpenditure-=2
	src.StrMultTotal-=0.25
	src.EndMultTotal-=0.25
	src.ForMultTotal-=0.25
	src.SpdMultTotal-=0.25
	src.trans["tension"]=0
	src.Hairz("Add")
	src.Auraz("Remove")


mob/proc/ChangelingMorph(var/x)
	if(src.ActiveBuff)
		src << "You can't use [src.ActiveBuff] and transform at the same time!"
		return
	if(src.SpecialBuff && src.TransUnlocked()<4)
		if(!src.CheckSpecial("FifthForm") && !src.CheckSpecial("OneHundredPercentPower"))
			src << "You can't use [src.SpecialBuff] and transform at the same time!"
			return
	src.potential_trans=src.Potential+(3.5*x)
	trans["active"]=x
	if(src.AscensionsUnlocked)
		if(x==2)
			src.Intimidation*=1.25
		if(x==3)
			src.Intimidation*=4
	if(x==1)
		src.StrMultTotal+=0.5
	if(x==2)
		src.ForMultTotal+=0.5
	if(x==3)
		src.SpdMultTotal+=0.5
	if(trans["active"]==1)
		src.BioArmorMax=75
		if(src.BioArmor>75)
			src.BioArmor=75
	if(trans["active"]==2)
		src.BioArmorMax=50
		if(src.BioArmor>50)
			src.BioArmor=50
	if(trans["active"]==3)
		src.BioArmorMax=0
		if(src.BioArmor>0)
			src.BioArmor=0
	if(trans["active"]==4)
		src.Auraz("Add")
		var/icon/E=icon('Ripple Barrier.dmi')
		spawn()DarknessFlash(src, SetTime=45)
		sleep()
		spawn()Shockwave(E,1)
		var/image/GC=image('GCAuraEff.dmi',pixel_x=-49,pixel_y=-15, loc = src)
		GC.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA
		animate(GC, alpha=0)
		animate(GC, alpha=255, time=10)
		Quake(10)
		sleep(20)
		spawn()Shockwave(E,1.2)
		spawn()Shockwave(E,1)
		Quake(20)
		sleep(20)
		spawn()Shockwave(E,1.5)
		spawn()Shockwave(E,1.2)
		spawn()Shockwave(E,1)
		Quake(20)
		sleep(20)
		spawn()Shockwave(E,2)
		spawn()Shockwave(E,1.5)
		spawn()Shockwave(E,1.2)
		spawn()Shockwave(E,1)
		spawn()Crater(src)
		animate(GC, alpha=0, time=30)
		spawn(30)
			del GC
		if(!src.HasKiControl()&&!src.PoweringUp)
			spawn(50)
				src.Auraz("Remove")
	else
		src.Auraz("Add")
		var/icon/E=icon('PsychoPower.dmi')
		spawn()Quake(5)
		spawn()Shockwave(E,1.5)
		if(x>=2)
			spawn()Quake(10)
			spawn()Shockwave(E,1.2)
		if(x==3)
			spawn()Quake(10)
			spawn()Shockwave(E,1)
			spawn()Crater(src)
		spawn(50)
			if(!src.HasKiControl()&&!src.PoweringUp)
				src.Auraz("Remove")

	if(x==1&&src.Form1Base)
		if(!src.BaseBase)
			src.BaseBase=src.icon
		src.icon=src.Form1Base
	if(x==2&&src.Form2Base)src.icon=src.Form2Base
	if(x==3&&src.Form3Base)src.icon=src.Form3Base
	if(x==4&&src.Form5Base)src.icon=src.Form5Base

mob/proc/ChangelingMorphRevert()
	src.Auraz("Remove")
	if(src.AscensionsUnlocked)
		if(src.TransActive()==3)
			src.Intimidation/=4
		if(src.TransActive()==2)
			src.Intimidation/=1.25

	if(src.TransActive()==3)
		src.SpdMultTotal-=0.5
	if(src.TransActive()==2)
		src.ForMultTotal-=0.5
	if(src.TransActive()==1)
		src.StrMultTotal-=0.5

	src.trans["active"]--

	if(src.TransActive()==0)
		if(src.BaseBase)
			src.icon=src.BaseBase
			src.BaseBase=0
		src.BaseBase=0
		src.BioArmorMax=100
		src.potential_trans=0
	if(src.TransActive()==1)
		if(src.Form1Base)
			src.icon=src.Form1Base
		src.BioArmorMax=75
		src.potential_trans=src.Potential+2.5
	if(src.TransActive()==2)
		if(src.Form2Base)
			src.icon=Form2Base
		src.BioArmorMax=50

		src.potential_trans=src.Potential+5
	if(src.TransActive()==3)
		if(src.Form3Base)
			src.icon=src.Form3Base
		src.BioArmorMax=0
		src.potential_trans=src.Potential+7.5





mob/proc/GodMode(var/x)
	src.Auraz("Remove")
	if(src.AuraLocked)
		src.AuraLocked=0
	if(x)
		trans["active"]=1
		LightningStrike(src)
		trans["active"]=1
		src.Intimidation+=100 // 1 pure dmg XD
		src.GodKi+=0.5
	if(x==2)
		trans["active"]=2
		var/shift='StarPixel.dmi'
		for(var/mob/Players/T in view(18))
			spawn()T.Quake(50)
		for(var/Rounds=1, Rounds<=src.AscensionsAcquired+1, Rounds++)
			for(var/turf/T in Turf_Circle(src,Rounds))
				TurfShift(shift, T, 10)
			sleep(1)
		src.GodKi+=1
		src.Intimidation+=200
	src.Auraz("Add")
	spawn(50)
		if(!src.HasKiControl()&&!src.PoweringUp)
			src.Auraz("Remove")

mob/proc/GodModeRevert()
	while(trans["active"]>0)
		if(trans["active"]==2)
			src.Intimidation-=200
			src.GodKi-=1
		if(trans["active"]==1)
			src.Intimidation-=100
			src.GodKi-=0.5
		trans["active"]--


mob/proc/SNJ()
	trans["active"]=1
	if(src.Form1Base)
		src.BaseBase=src.icon
		src.BaseBaseX=src.pixel_x
		src.BaseBaseY=src.pixel_y
		src.icon=image(icon=src.Form1Base, pixel_x=src.Form1BaseX, pixel_y=src.Form1BaseY)
	if(src.Form1Overlay)
		src.overlays+=image(icon=src.Form1Overlay, pixel_x=src.Form1OverlayX, pixel_y=src.Form1OverlayY)
	src.TransformingBeyond+=1
	spawn()
		src.FlickeringGlow(src)


mob/proc/ChooseAlienClass()
	var/Choice
	var/Confirm
	while(Confirm!="Yes")
		Choice=input(src, "What class of alien do you want to be?", "Alien Class") in list ("Brutality", "Harmony", "Ferocity", "Tenacity", "Equanimity", "Sagacity")
		switch(Choice)
			if("Brutality")
				Confirm=alert(src, "Brute aliens gain increased strength and agility.  Do you want to transform into one?", "Alien Class", "Yes", "No")
			if("Harmony")
				Confirm=alert(src, "Harmony aliens gain increase spiritual strength and slight increase in speed.  Do you want to transform into one?", "Alien Class", "Yes", "No")
			if("Ferocity")
				Confirm=alert(src, "Ferocious aliens gain increased offensive power in strength, spirit and agility.  Do you want to transform into one?", "Alien Class", "Yes", "No")
			if("Tenacity")
				Confirm=alert(src, "Tenacious aliens gain increased endurance and slight increase in physical strength.  Do you want to transform into one?", "Alien Class", "Yes", "No")
			if("Equanimity")
				Confirm=alert(src, "Equanimous aliens gain increased endurance and slight increase in spiritual focus.  Do you want to transform into one?", "Alien Class", "Yes", "No")
			if("Sagacity")
				Confirm=alert(src, "Sagacious aliens gain increased offensive power in strength, spirit and extra endurance.  Do you want to transform into one?", "Alien Class", "Yes", "No")
	src.Class=Choice

mob/proc/SuperAlienBase(var/x)
	switch(x)
		if(1)
			if(src.Form1Base)
				if(!src.BaseBase)
					src.BaseBase=src.icon
					src.BaseBaseX=src.pixel_x
					src.BaseBaseY=src.pixel_y
				src.icon=src.Form1Base
				src.pixel_x=src.Form1BaseX
				src.pixel_y=src.Form1BaseY


mob/proc/SuperAlien(var/x)
	if(!(src.Class in list("Brutality", "Harmony", "Ferocity", "Tenacity", "Equanimity", "Sagacity", "Potara", "Dance")))
		src.ChooseAlienClass()
	src.trans["active"]=x
	if(!src.HasMystic())
		src.SuperAlienBase(x)
	switch(x)
		if(1)
			OMsg(src, "[src.Form1ActiveText]")
	spawn()
		src.Quake(x*x*5)
	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 0.7,0.9,1), time=5)
	spawn(5)
		animate(src, color = MobColor, time=3)
	if(x>1)
		var/DustStacks=x
		spawn()Crater(src,x-1)
		while(DustStacks)
			Dust(src.loc,x+x)
			DustStacks--
	switch(x)
		if(1)
			src.overlays+=image(icon=src.Form1Overlay, pixel_x=src.Form1OverlayX, pixel_y=src.Form1OverlayY)
	src.Hairz("Add")
	src.Auraz("Add")
	if(!src.HasKiControl()&&!src.PoweringUp)
		spawn(50)
			src.Auraz("Remove")
	if(src.masteries["[x]mastery"]<20)
		src.masteries["[x]mastery"]=100
		switch(src.Class)
			if("Brutality")
				src.StrAscension+=0.5
				src.SpdAscension+=0.5
			if("Harmony")
				src.ForAscension+=0.5
				src.SpdAscension+=0.5
			if("Ferocity")
				src.StrAscension+=0.25
				src.ForAscension+=0.25
				src.SpdAscension+=0.5
			if("Tenacity")
				src.EndAscension+=0.5
				src.StrAscension+=0.5
			if("Equanimity")
				src.EndAscension+=0.5
				src.ForAscension+=0.5
			if("Sagacity")
				src.StrAscension+=0.25
				src.ForAscension+=0.25
				src.EndAscension+=0.5
	src.Intimidation*=2


/mob/var/oldAngerPoint = 50

mob/proc/PureSSj(var/x)

	oldAngerPoint = AngerPoint
	ssj["active"]=x
	var/halfieNerf = Race == "Half Saiyan" ? 0.9 : 1
	switch(src.ssj["active"])
		if(1)
			src.potential_trans=30
		if(2)
			src.potential_trans=50
		if(3)
			src.potential_trans=70
	potential_trans *= halfieNerf
	src.Auraz("Add")

	var/mastery=masteries["[x]mastery"]
	if(x==1)
		if(mastery>80)
			sleep()
		else if(mastery>50)
			sleep()
			Quake(10)
		else if(mastery>20)
			sleep()
			Quake(10)
			Quake(20)
		else if(mastery>1)
			sleep()
			Quake(10)
			sleep(20)
			Quake(20)
			sleep(30)
			Quake(30)
		else
			spawn()
				DarknessFlash(src)
			sleep()
			LightningStrike2(src, Offset=4)
			Quake(10)
			sleep(20)
			LightningStrike2(src, Offset=4)
			Quake(20)
			sleep(30)
			LightningStrike2(src, Offset=4)
			Quake(30)
			Quake(50)
			spawn(1)
				LightningStrike2(src, Offset=2)
			spawn(3)
				LightningStrike2(src, Offset=2)
			spawn(5)
				LightningStrike2(src, Offset=2)
		animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
		spawn(5)
			animate(src, color = null, time=5)
		sleep(2)

	if(x==2)
		if(mastery>=25)
			sleep()
			Quake(10)
		else if(mastery>=10)
			for(var/mob/Players/T in view(18))
				spawn()
					T.Quake(25)
			for(var/turf/T in Turf_Circle(src,3))
				if(prob(1))
					sleep(0.005)
				spawn(4)
					new/turf/Dirt1(locate(T.x,T.y,T.z))
				spawn(4)
					Destroy(T)
		else
			for(var/mob/Players/T in view(18))
				spawn()
					T.Quake(50)
			for(var/turf/T in Turf_Circle(src,6))
				if(prob(1))
					sleep(0.005)
				spawn(4)
					new/turf/Dirt1(locate(T.x,T.y,T.z))
				spawn(4)
					Destroy(T)
		animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
		spawn(5)
			animate(src, color = null, time=5)
		sleep(2)

	if(x==3)
		if(mastery<50)
			src.icon_state=""
			src.TransformingBeyond=1
			var/image/HF=image(icon=src.Hair_SSJ2, pixel_x=src.pixel_x, pixel_y=src.pixel_y, loc = src)
			HF.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
			HF.color=list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2)
			animate(HF, alpha=0)
			spawn()
				Quake(40)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			sleep(5)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			sleep(5)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			sleep(5)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			TransformBeyond(src)
			sleep(5)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(10,8,24,8,24,999)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(10,8,24,8,24,999)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(10,8,24,8,24,999)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(30,8,24,8,24,999)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(60,8,24,8,24,999)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			src.TransformingBeyond=0
			sleep(5)
			spawn()
				Earthquake(30,16,48,16,48,src.z)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			del HF
			var/ShockSize=5
			for(var/wav=5, wav>0, wav--)
				KenShockwave(src, icon='KenShockwaveGold.dmi', Size=ShockSize, Blend=2, Time=8)
				ShockSize/=2
			spawn(10)
				animate(src, color = src.MobColor, time=30)
		else if(mastery>=50&&src.icon_state=="Train")
			src.icon_state=""
			src.TransformingBeyond=1
			var/image/HF=image(icon=src.Hair_SSJ2, pixel_x=src.pixel_x, pixel_y=src.pixel_y, loc = src)
			HF.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
			HF.color=list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2)
			animate(HF, alpha=0)
			spawn()
				Quake(40)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			sleep(5)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			sleep(5)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			sleep(5)
			animate(HF, alpha=210, time=5)
			sleep(5)
			animate(HF, alpha=0, time=5)
			TransformBeyond(src)
			sleep(5)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(10,8,24,8,24,src.z)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(10,8,24,8,24,src.z)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(10,8,24,8,24,src.z)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(30,8,24,8,24,src.z)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			spawn()
				Earthquake(60,8,24,8,24,src.z)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			sleep(5)
			LightningStrike2(src, Offset=4)
			animate(HF, alpha=210, time=5)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			sleep(5)
			animate(HF, alpha=0, time=5)
			animate(src, color = src.MobColor, time=5)
			src.TransformingBeyond=0
			sleep(5)
			spawn()
				Earthquake(30,16,48,16,48,src.z)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			del HF
			var/ShockSize=5
			for(var/wav=5, wav>0, wav--)
				KenShockwave(src, icon='KenShockwaveGold.dmi', Size=ShockSize, Blend=2, Time=8)
				ShockSize/=2
			spawn(10)
				animate(src, color = src.MobColor, time=30)
		else
			sleep()
			Quake(40)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
			var/ShockSize=5
			for(var/wav=5, wav>0, wav--)
				KenShockwave(src, icon='KenShockwaveGold.dmi', Size=ShockSize, Blend=2, Time=8)
				ShockSize/=2
			spawn(10)
				animate(src, color = src.MobColor, time=30)
			sleep(2)

	if(x==1)
		AngerPoint = 75
	if(x==2)
		src.EndlessAnger+=1
		src.PUSpeedModifier*=1.5
	src.Hairz("Add")
	src.Auraz("Add")
	spawn(50)
		if(!src.HasKiControl()&&!src.PoweringUp)
			src.Auraz("Remove")


mob/proc/GoSSJ4()
	if(!src.Tail)
		return
	else
		src.potential_trans=90
		ssj["active"]=4
		if(masteries["[ssj["active"]]mastery"]!=100)
			masteries["[ssj["active"]]mastery"]=1
		src.PUSpeedModifier*=1.5
		src.EndlessAnger+=1
		src.Transformed=1
		src.Anger=src.AngerMax
		src.Auraz("Add")

		sleep()
		Quake(40)
		src.TransformingBeyond=1
		TransformBeyond(src)
		animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=20)
		sleep(20)
		src.AppearanceOff()
		src.overlays+=FurSSJ4
		src.overlays+=ClothingSSJ4
		src.overlays+=TailSSJ4
		src.Hairz("Add")
		src.Auraz("Add")
		var/ShockSize=5
		for(var/wav=5, wav>0, wav--)
			KenShockwave(src, icon='KenShockwaveGold.dmi', Size=ShockSize, Blend=2, Time=10)
			ShockSize/=2
		spawn(10)
			animate(src, color = src.MobColor, time=20)
		spawn(50)
			if(!src.HasKiControl()&&!src.PoweringUp)
				src.Auraz("Remove")
		src.TransformingBeyond=0

mob/proc/RevertSSJ4()
	src.potential_trans=0
	ssj["active"]=0
	src.PUSpeedModifier/=1.5
	src.EndlessAnger-=1
	src.Transformed=0
	src.Anger=0

	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=5)
	spawn(5)
		animate(src, color = null, time=5)
	src.overlays-=FurSSJ4
	src.overlays-=ClothingSSJ4
	src.overlays-=TailSSJ4
	src.AppearanceOn()

mob/proc/SSJGod()
	if(src.masteries["4mastery"]<75)
		sleep(10)
//		src.Transforming=1
		src.Frozen=2

		src.BPPoison=1
		src.BPPoisonTimer=0
		src.TotalInjury=0
		src.TotalFatigue=0
		src.Health=100
		src.Energy=EnergyMax
		src.StrTax=0
		src.EndTax=0
		src.SpdTax=0
		src.ForTax=0
		src.OffTax=0
		src.DefTax=0
		src.RecovTax=0

		src.OMessage(15,"[src] is fully revitalized, as their entire body is surrounded by a gentle aura.","<font color=red>[src]([src.key]) unlocked Super Saiyan Divinity.")
		var/image/GG=image('GodGlow.dmi',pixel_x=-32,pixel_y=-32, loc = src, layer=MOB_LAYER-0.5)
		GG.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
		GG.color=list(1,0,0, 0,1,0, 0,0,1, 0.2,0.2,0.4)
		GG.filters+=filter(type = "drop_shadow", x=0, y=0, color=list(1,0,0,1, 0,1,0,1, 0,0,1,1, 0.7,0.7,1,1), size = 5)
		animate(GG, alpha=0, transform=matrix()*0.7)
		world << GG
		animate(GG, alpha=255, time=30, transform=matrix()*1)
		animate(src, color = list(0.45,0.6,0.75, 0.64,0.88,1, 0.16,0.21,0.27, 0,0,0), pixel_y=32, time=30)
		sleep(40)

		var/image/GO=image('GodOrb.dmi',pixel_x=-16,pixel_y=-16, loc = src, layer=EFFECTS_LAYER+0.5)
		GO.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
		GO.filters+=filter(type = "drop_shadow", x=0, y=0, color=list(1,0,0, 0,1,0, 0,0,1, 0.85,0.85,0.9), size = 3)
		animate(GO, alpha=0)
		world << GO
		animate(GO, alpha=255, time=40)
		for(var/mob/Players/T in view(31, src))
			animate(T.client, color=list(0.5,0,0, 0,0.5,0, 0,0,0.5, 0,0,0.1), time = 40)
			spawn(40)
				animate(T.client, color=null, time = 40)
		spawn(10)
			KenShockwave(src, icon='KenShockwaveDivine.dmi', PixelY=24, Size=5, Blend=2)
			animate(GO, color=list(1,0,0, 0,1,0, 0,0,1, 0.8,0.8,0.8), time=30)
		spawn(20)
			KenShockwave(src, icon='KenShockwaveDivine.dmi', PixelY=24, Size=5, Blend=2)
		spawn(30)
			KenShockwave(src, icon='KenShockwaveDivine.dmi', PixelY=24, Size=5, Blend=2)
		spawn(40)
			KenShockwave(src, icon='KenShockwaveDivine.dmi', PixelY=24, Size=5, Blend=2)
		spawn(50)
			KenShockwave(src, icon='KenShockwaveDivine.dmi', PixelY=24, Size=5, Blend=2)
		sleep(50)
		animate(src, color = null)
		sleep(30)

		src.ssj["god"]=1
		src.Hairz("Add")
		GG.filters-=filter(type = "drop_shadow", x=0, y=0, color=list(1,0,0,1, 0,1,0,1, 0,0,1,1, 0.7,0.7,1,1), size = 5)
		GG.filters+=filter(type = "drop_shadow", x=0, y=0, color=list(1,0,0, 0,1,0, 0,0,1, 0.7,0.7,1), size = 1)

		animate(GO, alpha=0, time=10)
		sleep(10)
		animate(src, pixel_y=0, time=30)
		animate(GG, alpha=0, time=50)
		spawn(50)
			GO.filters=null
			del GO
			GG.filters=null
			del GG

		src.Frozen=0
//		src.Transforming=0
		if(src.masteries["4mastery"]<75)
			src.masteries["4mastery"]+=40
	else
		src.ssj["god"]=1
		KenShockwave(src, icon='SparkleOrange.dmi', Size=3, PixelX=105, PixelY=100, Blend=2)
		animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1.5,0.9,0.1), time=5)
		spawn(5)
			src.Hairz("Add")
			src.Auraz("Add")
			spawn(50)
				if(!src.HasKiControl()&&!src.PoweringUp)
					src.Auraz("Remove")
			animate(src, color = null, time=5)

	passive_handler.Increase("GodKi", 1)
	src.GodKi+=1
	src.Anger=src.AngerMax
	src.EndlessAnger+=1

mob/proc/SSJRage()
//	src.Transforming=1
	if(src.masteries["4mastery"]<75)
		sleep(10)

		src.BPPoison=1
		src.BPPoisonTimer=0
		src.TotalInjury=0
		src.TotalFatigue=0
		src.Health=100
		src.Energy=EnergyMax
		src.StrTax=0
		src.EndTax=0
		src.SpdTax=0
		src.ForTax=0
		src.OffTax=0
		src.DefTax=0
		src.RecovTax=0

		src.OMessage(15,"[src] is fully revitalized, as their entire body is surrounded by a raging aura.","<font color=red>[src]([src.key]) unlocked Super Saiyan Divinity.")
		src.masteries["4mastery"]=100

	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
	src.ssj["active"]=1
	src.Hairz("Add")
	src.Auraz("Add")
	sleep(5)

	src.ssj["active"]=0
	src.ssj["god"]=1
	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 0.5,0.45,0.1), time=5)
	spawn(3)
	src.Auraz("Add")
	spawn(5)
		animate(src, color = null, time=5)

	src.TransformingBeyond=1
	var/image/HF=image(icon=src.Hair_SSJGod, pixel_x=src.pixel_x, pixel_y=src.pixel_y, loc = src)
	HF.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
	HF.color=list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2)
	animate(HF, alpha=0)
	spawn()Quake(30)
	world << HF
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	TransformBeyond(src)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	spawn()Quake(10)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	spawn()Quake(10)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(HF, alpha=0, time=5)
	sleep(5)
	animate(HF, alpha=210, time=5)
	sleep(5)
	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 0.5,0.45,0.1), time=5)
	src.Hairz("Add")
	spawn(10)
		del HF
		animate(src, color = null, time=5)
	src.TransformingBeyond=0

	passive_handler.Increase("GodKi", 0.5)
	src.GodKi+=0.5
	src.potential_trans=90
	src.PUSpeedModifier*=1.5

//	src.Transforming=0
	spawn(50)
		if(!src.HasKiControl()&&!src.PoweringUp)
			src.Auraz("Remove")

mob/proc/RevertSSJG()

	src.ssj["god"]=0

	if(src.Race=="Saiyan")
		passive_handler.Decrease("GodKi", 1)
		src.GodKi-=1
		src.EndlessAnger-=1

	else if(src.Race=="Half Saiyan")
		passive_handler.Decrease("GodKi", 0.5)
		src.PUSpeedModifier/=1.5
		src.GodKi-=0.5
		src.potential_trans=0

	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=5)
	spawn(5)
		animate(src, color = null, time=5)
	src.Auraz("Remove")
	src.Hairz("Add")


mob/proc/SSGSSj(var/x)
	src.appearance_flags+=16

	src.potential_trans=90
	ssj["active"]=x
	ssj["god"]=1

	animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 0.9,1,1), time=5)
	src.icon_state=""
	var/image/GG=image('SSBGlow.dmi',pixel_x=-32, pixel_y=-32)
	GG.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
	GG.blend_mode=BLEND_ADD
	GG.color=list(1,0,0, 0,1,0, 0,0,1, 0,0,0)
	GG.alpha=110
	sleep(5)
	src.Auraz("Remove")
	src.filters+=filter(type = "blur", size = 0)
	animate(src, color=list(-1.2,-1.2,-1, 1,1,1, -1.4,-1.4,-1.2,  1,1,1), time=3, flags=ANIMATION_END_NOW)
	animate(src.filters[filters.len], size = 0.35, time = 3)
	src.Hairz("Add")
	src.overlays+=GG
	spawn()DarknessFlash(src, SetTime=60)
	sleep()
	var/image/GO=image('GodOrb.dmi',pixel_x=-16,pixel_y=-16, loc = src, layer=MOB_LAYER-0.5)
	GO.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
	GO.filters+=filter(type = "drop_shadow", x=0, y=0, color=list(1,0,0, 0,1,0, 0,0,1, 0.85,0.85,0.9), size = 3)
	animate(GO, alpha=0, transform=matrix(), color=list(1,0,0, 0,1,0, 0,0,1, 0.85,0.85,0.9))
	world << GO
	animate(GO, alpha=210, time=1)
	sleep(1)
	animate(GO, transform=matrix()*3, time=60, easing=BOUNCE_EASING | EASE_IN | EASE_OUT, flags=ANIMATION_END_NOW)
	Quake(20)
	sleep(20)
	Quake(40)
	sleep(20)
	Quake(60)
	sleep(20)

	src.passive_handler.Increase("GodKi", 1)
	src.passive_handler.Increase("CalmAnger")

	sleep(10)
	src.filters-=filter(type = "blur", ,size = 0.35)
	animate(src, color=list(0,0,0, 0,0,0, 0,0,0, 0.5,0.95,1), time=5, easing=QUAD_EASING)
	sleep(5)
	src.Hairz("Add")
	sleep(10)
	animate(src, color=null, time=20, easing=CUBIC_EASING)
	sleep(20)
	animate(GO, alpha=0, time=5)
	spawn(5)
		src.overlays-=GG
		GO.filters=null
		del GO
		src.Auraz("Add")
		spawn(50)
			if(!src.HasKiControl()&&!src.PoweringUp)
				src.Auraz("Remove")
		src.appearance_flags-=16


mob/proc/WeaponSoul() // OverSoul Mechanic
	var/obj/Items/Sword/s=src.EquippedSword()
	var/placement=FLOAT_LAYER-3
	if(s.LayerPriority)
		placement-=s.LayerPriority
	if(src.SagaLevel<7)
		return
	else
		src.PowerBoost*=2
		switch(src.BoundLegend)
			if("Green Dragon Crescent Blade")
				Attunement = "Fire"
				InfusionElement = "Water"
				ElementalDefense = "Void"
				passive_handler.Increase("CounterMaster", 10)
				CounterMaster += 10
				passive_handler.Increase("Extend")
				Extend += 1
				passive_handler.Increase("TechniqueMastery", 5)
				TechniqueMastery += 5
				passive_handler.Increase("MovementMastery", 5)
				MovementMastery += 5
				passive_handler.Increase("LegendaryPower")
				LegendaryPower += 1
				src.OMessage(10, "<b><font color=red><center>The very air shakes, as [src.name] shakes the world with their yell of potent, overwhelming power!!</center></font></b>")
				Quake(10)
				KenShockwave(src,icon='fevKiai.dmi',Size=4)
				KenShockwave(src,icon='fevKiai.dmi',Size=3)
				KenShockwave(src,icon='fevKiai.dmi',Size=2)
				KenShockwave(src,icon='fevKiai.dmi',Size=1)
				spawn(10)
					src.OMessage(10, "<b><font color=red><center>The tides of War may try to be oppressed by others, but they'll crush all opposition under a relentless spear with the power to kill the very Heavens.</center></font></b>")

			if("Ruyi Jingu Bang")
				Attunement = "Wind"
				InfusionElement = "Earth"
				passive_handler.Increase("CalmAnger")
				CalmAnger+=1
				passive_handler.Increase("SweepingStrike")
				SweepingStrike+=1
				passive_handler.Increase("TripleStrike")
				TripleStrike+=1
				passive_handler.Increase("MonkeyKing",2)
				MonkeyKing+=2 // This passive spawns a clone of the user that attacks the same target as the user, but only deals 50% damage.
				src.OMessage(10, "<b><font color=yellow><center>The seal on the golden headband has been broken!</center></font></b>")
				var/image/i=image(icon='AvalonLight.dmi', pixel_x=-67, pixel_y=-3, loc=src)
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				i.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
				i.blend_mode=BLEND_ADD
				world << i
				world << w
				animate(i, alpha=0)
				animate(w, alpha=0, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,0.2))
				animate(w, alpha=255, time=10)
				sleep(10)
				animate(i, alpha=255, time=20)
				sleep(10)
				KenShockwave(src,icon='KenShockwaveGold.dmi',Size=0.5, Blend=2, Time=3)
				del w
				sleep(10)
				animate(i, alpha=0, time=30)
				src.OMessage(10, "<b><font color=yellow><center>The Monkey King has been released!</center></font></b>")
				spawn(30)
					del i
			if("Caledfwlch")
				src.ElementalDefense="Ultima"
				passive_handler.Increase("InjuryImmune")
				src.InjuryImmune+=1
				passive_handler.Increase("FatigueImmune")
				src.FatigueImmune+=1
				passive_handler.Increase("Siphon")
				src.Sheared=0
				src.HealWounds(50)
				src.HealHealth(50)
				src.HealFatigue(50)
				src.HealEnergy(50)
				src.HealMana(50)
				var/image/i=image(icon='AvalonLight.dmi', pixel_x=-67, pixel_y=-3, loc=src)
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				i.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
				i.blend_mode=BLEND_ADD
				world << i
				world << w
				animate(i, alpha=0)
				animate(w, alpha=0, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,0.2))
				animate(w, alpha=255, time=10)
				sleep(10)
				src.OMessage(10,"<b>The sun, breaking through all darkness, illuminates [src]...</b>")
				animate(i, alpha=255, time=20)
				sleep(10)
				src.OMessage(10,"<b>Calling upon the name 'AVALON!', they summon forth a legendary lost sheath!!!</b>","<font color=red>[src]([src.key]) used Avalon Mode.")
				KenShockwave(src,icon='KenShockwaveGold.dmi',Size=0.5, Blend=2, Time=3)
				del w
				sleep(10)
				src.OMessage(10,"<b>[src] becomes infused with innate healing; though they falter, they cannot be stopped!</b>")
				animate(i, alpha=0, time=30)
				spawn(30)
					del i
			if("Kusanagi")
				src.ElementalOffense="Wind"
				passive_handler.Increase("Godspeed", 2)
				passive_handler.Increase("Flicker", 2)
				passive_handler.Increase("Pursuer", 2)
				passive_handler.Increase("FluidForm")
				passive_handler.Increase("SweepingStrike")
				passive_handler.Increase("DoubleStrike")
				passive_handler.Increase("TripleStrike")
				src.Godspeed+=2
				src.Flicker+=2
				src.Pursuer+=2
				src.FluidForm+=1
				src.SweepingStrike+=1
				src.DoubleStrike+=1
				src.TripleStrike+=1
				var/i='Dark.dmi'
				var/j='Rain.dmi'
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				animate(w, alpha=0, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1))
				var/image/w2=image(icon='MurakumoMode.dmi', pixel_x=-16, pixel_y=-16, loc=src, layer=EFFECTS_LAYER)
				animate(w2, alpha=0, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1))
				world << w
				animate(w, alpha=255, time=10)
				sleep(10)
				for(var/turf/t in Turf_Circle(src, 15))
					sleep(-1)
					TurfShift(i, t, 190, src, MOB_LAYER+1)
				sleep(10)
				src.OMessage(10,"<b>Clouds converge upon [src], darkening the skies...</b>")
				spawn(3)
					for(var/turf/t in Turf_Circle(src, 15))
						sleep(-1)
						TurfShift(j, t, 180, src, MOB_LAYER+0.5)
				src.overlays+=image(icon='MurakumoMode.dmi', pixel_x=-16, pixel_y=-16)
				world << w2
				animate(w2, alpha=255, time=5)
				sleep(5)
				src.overlays-=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				del w
				sleep(10)
				src.OMessage(10,"<b>Calling upon the name 'Ame no Murakumo no Tsurugi', they invoke a mighty rainstorm...</b>","<font color=red>[src]([src.key]) used Murakumo Mode.")
				KenShockwave(src,icon='KenShockwaveGod.dmi',Size=0.5, Blend=2, Time=3)
				del w2
				src.Hairz("Add")
				src.overlays+=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.OMessage(10,"<b>[src] becomes swift as the wind; their strikes become countless like falling raindrops!</b>")
			if("Masamune")
				src.ElementalOffense="Light"
				src.ElementalDefense="Light"
				passive_handler.Increase("HolyMod", 5)
				passive_handler.Increase("BeyondPurity")
				passive_handler.Increase("CalmAnger")
				passive_handler.Increase("SpiritPower")
				src.HolyMod+=5//kill demons
				src.BeyondPurity+=1//cancel purity effects
				src.CalmAnger+=1
				src.SpiritPower+=1
				var/i='brightday2.dmi'
				sleep(10)
				for(var/turf/t in Turf_Circle(src, 10))
					sleep(-1)
					TurfShift(i, t, 190, src, MOB_LAYER+1)
				src.OMessage(10,"<b>[src] commits their heart fully to the duty that must be performed...</b>","<font color=red>[src]([src.key]) used Misogi Mode.")
				sleep(10)
				src.OMessage(10,"<b>Calling upon the absolute ideal of purity, they fill the area with overpowering brightness...</b>","<font color=red>[src]([src.key]) used Misogi Mode.")
				sleep(10)
				src.overlays-=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.overlays-=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.Hairz("Add")
				src.overlays+=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.overlays+=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.OMessage(10,"<b>[src] stands as a righteous warden against all that plagues humanity!</b>")
			if("Durendal")
				src.ElementalOffense="Earth"
				passive_handler.Increase("Juggernaut")
				passive_handler.Increase("GiantForm")
				passive_handler.Increase("SpecialStrike")
				passive_handler.Increase("Desperation", 3)
				src.Juggernaut+=1
				src.GiantForm+=1
				src.SpecialStrike+=1
				src.Desperation+=3
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				animate(w, alpha=0, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1))
				sleep(10)
				Quake(15)
				src.OMessage(10,"<b>[src] stands firmly, lifting the heavy blade in their hand...</b>")
				world << w
				animate(w, alpha=255, time=10)
				sleep(10)
				Quake(35)
				src.OMessage(10,"<b>Calling upon the name 'Durendal the Endurer', they cause the earth to tremble...</b>","<font color=red>[src]([src.key]) used Paladin Mode.")
				KenShockwave(src,icon='KenShockwaveDivine.dmi',Size=0.5, Blend=2, Time=2)
				del w
				animate(src, transform=src.transform*=1.5, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1), time=10)
				sleep(10)
				src.overlays-=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.overlays-=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.overlays+='PaladinMode.dmi'
				src.Hairz("Add")
				src.overlays+=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.overlays+=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				Quake(75)
				animate(src, color=null, time=1)
				src.OMessage(10,"<b>[src] becomes clad in regal armor, a symbol of unbreakable hope!</b>")
			//UNHOLYS
			if("Soul Calibur")
				src.ElementalOffense="Water"
				src.ElementalDefense="Void"
				passive_handler.Increase("PureReduction", 6)
				passive_handler.Increase("Unstoppable")
				passive_handler.Increase("NoWhiff")
				passive_handler.Increase("AbsoluteZero")
				passive_handler.Increase("Erosion", 0.5)
				src.PureReduction+=6
				src.Unstoppable+=1
				src.NoWhiff+=1
				src.AbsoluteZero+=1
				src.Erosion+=0.5
				var/i='IceGround.dmi'
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				animate(w, alpha=0, color=list(1,0,0, 0,1,0, 0,0,1, 1,1,1))
				for(var/turf/t in Turf_Circle(src, 10))
					sleep(-1)
					TurfShift(i, t, 190, src)
				sleep(10)
				src.OMessage(10,"<b>[src] calls upon the power of order...</b>")
				world << w
				animate(w, alpha=255, time=10)
				sleep(10)
				src.OMessage(10,"<b>Taking up the name 'Elysium the Virtuous', they invoke absolute stillness...</b>","<font color=red>[src]([src.key]) used Elysium Mode.")
				KenShockwave(src,icon='KenShockwaveGod.dmi',Size=0.5, Blend=2, Time=3)
				del w
				src.overlays-=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.overlays+=image(icon='ElysiumMode.dmi')
				src.Hairz("Add")
				src.overlays+=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				sleep(5)
				src.OMessage(10,"<b>[src] embodies the ideals of their blade, commiting their soul to law!</b>")
			if("Soul Edge")
				src.ElementalOffense="Void"//eat stats
				passive_handler.Increase("TechniqueMastery",5)
				passive_handler.Increase("MovementMastery",5)
				passive_handler.Increase("Flicker",2)
				passive_handler.Increase("HellPower")
				src.TechniqueMastery+=5
				src.MovementMastery+=5
				src.Flicker+=2
				src.HellPower+=1
				var/i='LavaTile.dmi'
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				animate(w, alpha=0, color=list(0,0,0, 0,0,0, 0,0,0, 0,0,0))
				for(var/turf/t in Turf_Circle(src, 10))
					sleep(-1)
					TurfShift(i, t, 190, src)
				sleep(10)
				src.OMessage(10,"<b>[src] entwines their life force with that of their cursed blade...</b>")
				world << w
				animate(w, alpha=255, time=10)
				sleep(10)
				src.OMessage(10,"<b>Taking up the name 'Inferno the Night Terror', they invoke a hellish landscape...</b>","<font color=red>[src]([src.key]) used Inferno Mode.")
				KenShockwave(src,icon='DarkKiai.dmi',Size=1)
				KenShockwave(src,icon='DarkKiai.dmi',Size=3)
				KenShockwave(src,icon='DarkKiai.dmi',Size=5)
				del w
				src.overlays-=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.Hairz("Add")
				sleep(5)
				src.overlays+=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				src.OMessage(10,"<b>[src] invokes the spirit of chaos through their own body!</b>")
			if("Muramasa")
				src.ElementalOffense="Fire"
				passive_handler.Increase("LifeSteal", 100)
				passive_handler.Increase("EnergySteal", 60)
				passive_handler.Increase("WeaponBreaker")
				passive_handler.Increase("CursedWounds")
				passive_handler.Increase("DarknessFlame")
				passive_handler.Increase("AbyssMod",2)
				src.LifeSteal+=100
				src.EnergySteal+=60
				src.AngerThreshold+=2
				src.EndlessAnger+=1
				src.WeaponBreaker+=1
				src.CursedWounds+=1
				src.DarknessFlame+=1
				src.AbyssMod+=2
				var/i='amaterasu.dmi'
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				animate(w, alpha=0, color=list(0,0,0, 0,0,0, 0,0,0, 0,0,0))
				for(var/turf/t in Turf_Circle(src, 5))
					sleep(-1)
					TurfShift(i, t, 190, src)
				sleep(10)
				src.OMessage(10,"<b>[src] cuts out what remaining restraint they have with their cursed sword...</b>")
				world << w
				animate(w, alpha=255, time=10)
				sleep(10)
				src.OMessage(10,"<b>Calling upon their insatiable bloodlust, they fill the air with miasma of death...</b>","<font color=red>[src]([src.key]) used Deathbringer Mode.")
				KenShockwave(src,icon='KenShockwavePurple.dmi',Size=0.5, Blend=2, Time=3)
				del w
				src.overlays-=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.overlays+=image(icon='DeathbringerMode.dmi')
				src.Hairz("Add")
				src.overlays+=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.overlays+=image(icon='DarknessGlow.dmi', pixel_x=-32, pixel_y=-32)
				sleep(5)
				src.OMessage(10,"<b>[src] invokes the spirit of destruction through their blade!</b>")
			if("Dainsleif")
				src.ElementalOffense="Poison"//This already has cursed wounds, so it will become hyper murder poison.
				passive_handler.Increase("MortalStrike")
				passive_handler.Increase("HardStyle", 2)
				passive_handler.Increase("DeathField", 2)
				passive_handler.Increase("SoulSteal")
				src.MaimStrike+=1
				src.HardStyle+=2//UNTZ UNTZ UNTZ
				src.DeathField+=2
				src.SoulSteal+=1
				var/i='Dark.dmi'
				var/j='BloodRain.dmi'
				var/image/w=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, loc=src, layer=EFFECTS_LAYER)
				animate(w, alpha=0, color=list(0,0,0, 0,0,0, 0,0,0, 0,0,0))
				var/image/w2=image(icon='NibelungMode.dmi', pixel_x=-32, pixel_y=-32, loc=src, layer=EFFECTS_LAYER)
				animate(w2, alpha=0, color=list(0,0,0, 0,0,0, 0,0,0, 0,0,0))
				world << w
				animate(w, alpha=255, time=10)
				sleep(10)
				for(var/turf/t in Turf_Circle(src, 15))
					sleep(-1)
					TurfShift(i, t, 190, src, MOB_LAYER+1)
				sleep(10)
				src.OMessage(10,"<b>The skies weep bloody tears as [src] takes upon the ultimate oath...</b>")
				spawn(3)
					for(var/turf/t in Turf_Circle(src, 15))
						sleep(-1)
						TurfShift(j, t, 180, src, MOB_LAYER+0.5)
				src.overlays+=image(icon='NibelungMode.dmi', pixel_x=-32, pixel_y=-32)
				world << w2
				animate(w2, alpha=255, time=5)
				sleep(5)
				src.overlays-=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
				del w
				sleep(10)
				src.OMessage(10,"<b>Calling upon the names of their ancestors, they vow a bloody vengance against the world...</b>","<font color=red>[src]([src.key]) used Nibelung Mode.")
				KenShockwave(src,icon='KenShockwaveBloodlust.dmi',Size=0.5, Blend=2, Time=3)
				del w2
				src.Hairz("Add")
				src.overlays+=image(icon=src.ActiveBuff.IconLock, pixel_x=src.ActiveBuff.LockX, pixel_y=src.ActiveBuff.LockY)
				src.OMessage(10,"<b>[src] becomes the incarnate of ruin, ready to slay all who oppose!</b>")
		src.Auraz("Add")
		spawn(50)
			if(!src.HasKiControl()&&!src.PoweringUp)
				src.Auraz("Remove")
		src.Stasis=0


mob/proc/RevertWS()
	var/obj/Items/Sword/s=src.EquippedSword()
	var/placement=FLOAT_LAYER-3
	if(s.LayerPriority)
		placement-=s.LayerPriority
	src.PowerBoost/=2
	switch(src.BoundLegend)
		if("Ruyi Jingu Bang")
			Attunement = null
			InfusionElement = null
			passive_handler.Decrease("CalmAnger")
			CalmAnger-=1
			passive_handler.Decrease("SweepingStrike")
			SweepingStrike-=1
			passive_handler.Decrease("TripleStrike")
			TripleStrike-=1
			passive_handler.Decrease("MonkeyKing",2)
			MonkeyKing-=2 // This passive spawns a clone of the user that attacks the same target as the user, but only deals 50% damage.
		if("Green Dragon Crescent Blade")
			Attunement = null
			InfusionElement = null
			ElementalDefense = null
			passive_handler.Decrease("CounterMaster",10)
			CounterMaster -= 10
			passive_handler.Decrease("Extend")
			Extend -= 1
			passive_handler.Decrease("TechniqueMastery", 5)
			TechniqueMastery -= 5
			passive_handler.Decrease("MovementMastery", 5)
			MovementMastery -= 5
			passive_handler.Decrease("LegendaryPower")
			LegendaryPower -= 1
		if("Caledfwlch")
			src.ElementalDefense=null
			passive_handler.Decrease("InjuryImmune")
			src.InjuryImmune-=1
			passive_handler.Decrease("FatigueImmune")
			src.FatigueImmune-=1
			passive_handler.Decrease("Siphon")
		if("Kusanagi")
			src.ElementalOffense=null
			passive_handler.Decrease("Godspeed",2)
			passive_handler.Decrease("Flicker", 2)
			passive_handler.Decrease("Pursuer", 2)
			passive_handler.Decrease("FluidForm")
			passive_handler.Decrease("SweepingStrike")
			passive_handler.Decrease("DoubleStrike")
			passive_handler.Decrease("TripleStrike")
			src.Godspeed-=2
			src.Flicker-=2
			src.Pursuer-=2
			src.FluidForm-=1
			src.SweepingStrike-=1
			src.DoubleStrike-=1
			src.TripleStrike-=1
			src.overlays-=image(icon='MurakumoMode.dmi', pixel_x=-16, pixel_y=-16)
			src.overlays+=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)
		if("Masamune")
			src.ElementalOffense=null
			src.ElementalDefense=null
			passive_handler.Decrease("HolyMod", 5)
			passive_handler.Decrease("BeyondPurity")
			passive_handler.Decrease("CalmAnger")
			passive_handler.Decrease("SpiritPower")
			src.HolyMod-=5//kill demons
			src.BeyondPurity-=1//cancel purity effects
			src.CalmAnger-=1
			src.SpiritPower-=1
		if("Durendal")
			src.ElementalOffense=null
			passive_handler.Decrease("Juggernaut")
			passive_handler.Decrease("GiantForm")
			passive_handler.Decrease("SpecialStrike")
			passive_handler.Decrease("Desperation", 3)
			src.Juggernaut-=1
			src.GiantForm-=1
			src.SpecialStrike-=1
			src.Desperation-=3
			src.overlays-='PaladinMode.dmi'
			src.transform/=1.5
		if("Soul Calibur")
			src.ElementalOffense=null
			src.ElementalDefense=null
			passive_handler.Decrease("PureReduction", 6)
			passive_handler.Decrease("Unstoppable", 1)
			passive_handler.Decrease("NoWhiff")
			passive_handler.Decrease("AbsoluteZero")
			passive_handler.Decrease("Erosion", 0.5)
			src.PureReduction-=6
			src.Unstoppable-=1
			src.NoWhiff-=1
			src.AbsoluteZero-=1
			src.Erosion-=0.5
			src.overlays-=image(icon='ElysiumMode.dmi')
		if("Soul Edge")
			src.ElementalOffense=null
			src.ElementalDefense=null
			passive_handler.Decrease("TechniqueMastery", 5)
			passive_handler.Decrease("MovementMastery", 5)
			passive_handler.Decrease("Flicker", 2)
			passive_handler.Decrease("HellPower")
			src.TechniqueMastery-=5
			src.MovementMastery-=5
			src.Flicker-=2
			src.HellPower-=1
		if("Muramasa")
			src.ElementalOffense=null
			passive_handler.Decrease("LifeSteal", 100)
			passive_handler.Decrease("EnergySteal", 60)
			passive_handler.Decrease("WeaponBreaker", 1)
			passive_handler.Decrease("CursedWounds", 1)
			passive_handler.Decrease("AbyssMod", 2)
			src.LifeSteal-=100
			src.EnergySteal-=60
			src.AngerThreshold-=2
			src.EndlessAnger-=1
			src.WeaponBreaker-=1
			src.CursedWounds-=1
			src.DarknessFlame-=1
			src.AbyssMod-=2
			src.overlays-=image(icon='DarknessGlow.dmi', pixel_x=-32, pixel_y=-32)
			src.overlays-=image(icon='DeathbringerMode.dmi')
		if("Dainsleif")
			src.ElementalOffense=null
			passive_handler.Decrease("MortalStrike")
			passive_handler.Decrease("HardStyle")
			passive_handler.Decrease("DeathField",2)
			passive_handler.Decrease("SoulSteal")
			src.MaimStrike-=1
			src.HardStyle-=2
			src.DeathField-=2
			src.SoulSteal-=1
			src.overlays-=image(icon='NibelungMode.dmi', pixel_x=-32, pixel_y=-32)
			src.overlays+=image(icon=s.icon, pixel_x=s.pixel_x, pixel_y=s.pixel_y, layer=placement)


mob/proc/Jaganshi()
	src.JaganBase=src.JaganPowerNerf
	src.JaganPowerNerf=round(1.5**src.JaganPowerNerf,0.1)

mob/proc/RevertJaganshi()
	src.JaganPowerNerf=src.JaganBase


mob/proc/Transform(var/Type)
	var/FirstTimeHeal=0
	if(!src.CanTransform())
		return
	if(src.ssj["active"]==0&&src.trans["active"]==0)
		src.SetVars()

	if(!Type)
		if(src.Race=="Alien")
			FirstTimeHeal=1
			if(src.TransActive()<1)
				if(src.TransUnlocked()>=1)
					src.trans["transing"]=1
					src.SuperAlien(1)
					src.trans["transing"]=0

		if(src.Race=="Saiyan")
			FirstTimeHeal=2
			for(var/obj/Oozaru/O in src)
				if(O.Looking)
					if(src.SSJ4Unlocked &&src.ssj["active"]!=4)
						ssj["transing"]=1
						src.GoSSJ4()
						if(src.FusionTimer)
							src.FusionTimer*=0.25
						ssj["transing"]=0
						return
			if(src.ssj["active"]==4)
				return
			if(ssj["active"]==0||ssj["active"]==null)
				if(ssj["unlocked"]>0)
					if(src.HasGodKiBuff()&&src.icon_state=="Train")
						ssj["transing"]=1
						src.SSGSSj(1)
						if(src.FusionTimer)
							src.FusionTimer*=0.25
						ssj["transing"]=0
					else
						ssj["transing"]=1
						src.PureSSj(1)
						ssj["transing"]=0
			else if(ssj["active"]==1&&!src.HasGodKi())
				if(masteries["1mastery"]<75)
					return
				if(ssj["unlocked"]>=2)
					ssj["transing"]=1
					src.PureSSj(2)
					ssj["transing"]=0
			else if(ssj["active"]==2&&!src.HasGodKi())
				if(masteries["2mastery"]<75)
					return
				if(ssj["unlocked"]>2)
					ssj["transing"]=1
					src.PureSSj(3)
					ssj["transing"]=0

		if(src.Race=="Half Saiyan")
			FirstTimeHeal=3
			for(var/obj/Oozaru/O in src)
				if(O.Looking)
					if(src.SSJ4Unlocked &&src.ssj["active"]!=4)
						ssj["transing"]=1
						src.GoSSJ4()
						if(src.FusionTimer)
							src.FusionTimer*=0.25
						ssj["transing"]=0
						return
			if(src.ssj["active"]==4)
				return
			if(ssj["active"]==0||ssj["active"]==null)
				if(ssj["unlocked"]>0)
					ssj["transing"]=1
					src.PureSSj(1)
					ssj["transing"]=0
			else if(ssj["active"]==1)
				if(masteries["1mastery"]<75)
					return
				if(ssj["unlocked"]>=2)
					ssj["transing"]=1
					src.PureSSj(2)
					ssj["transing"]=0
			else if(ssj["active"]==2)
				if(masteries["2mastery"]<75)
					return
				if(ssj["unlocked"]>2)
					ssj["transing"]=1
					src.PureSSj(3)
					ssj["transing"]=0

		if(src.Race=="Namekian")
			FirstTimeHeal=1
			if(trans["active"]==0||trans["active"]==null)
				if(trans["unlocked"]>0)
					trans["transing"]=1
					src.SNJ()
					trans["transing"]=0

		if(src.Race=="Changeling")
			FirstTimeHeal=0
			if(trans["transing"]) return
			if(trans["active"]==0||trans["active"]==null)
				if(trans["unlocked"]>0)
					trans["transing"]=1
					src.ChangelingMorph(1)
					trans["transing"]=0
			else if(trans["active"]==1)
				if(trans["unlocked"]>1)
					trans["transing"]=1
					src.ChangelingMorph(2)
					trans["transing"]=0
			else if(trans["active"]==2)
				if(trans["unlocked"]>2)
					trans["transing"]=1
					src.ChangelingMorph(3)
					trans["transing"]=0
			else if(trans["active"]==3)
				if(trans["unlocked"]>3)
					trans["transing"]=1
					src.ChangelingMorph(4)
					trans["transing"]=0

	else
		switch(Type)
			if("God")
				if(src.Race=="Saiyan")
					src.SSJGod()
				else if(src.Race=="Half Saiyan")
					src.SSJRage()
					if(src.FusionTimer)
						src.FusionTimer*=0.5
				else if(src.Race=="Human"&&src.LegendaryPower)
					if(!src.trans["transing"])
						src.GodMode(1)
						if(src.AscensionsAcquired==5)
							src.GodMode(2)


			if("Tension")
				for(var/obj/Skills/Buffs/SpecialBuffs/High_Tension/T in src)
					src.HighTension(T.Tension)
					T.Tension=0

			if("Jagan")
				src.Jaganshi()

			if("Weapon")
				src.WeaponSoul()

	switch(FirstTimeHeal)
		if(1)
			if(masteries["[src.trans["active"]]mastery"]<50)
				src.Sheared=0
				src.TotalInjury=0
				src.TotalFatigue=0
				src.HealHealth(100)
				src.HealEnergy(100)
				src.HealMana(100)
		if(2)
			if(masteries["[src.ssj["active"]]mastery"]<50)
				src.Sheared=0
				src.TotalInjury=0
				src.TotalFatigue=0
				src.HealHealth(100)
				src.HealEnergy(100)
				src.HealMana(100)
		if(3)
			if(masteries["[src.ssj["active"]]mastery"]<50)
				src.Sheared=0
				src.TotalInjury=0
				src.TotalFatigue=0
				src.HealHealth(100)
				src.HealEnergy(100)
				src.HealMana(100)


	if(src.FusionTimer)
		src.FusionTimer*=0.5


mob/proc/Revert(var/Type, var/Controlled=0)
	if(!src.CanRevert())
		return
	src.potential_trans=0

	if(!Type)
		if(src.trans["active"]==0 && src.ssj["active"]==0)
			return

		if(src.Race=="Alien")
			if(src.TransActive())
				OMsg(src, "[src.Form1RevertText]")
				src.overlays-=image(icon=src.Form1Overlay, pixel_x=src.Form1OverlayX, pixel_y=src.Form1OverlayY)
				src.overlays-=image(icon=src.Form1TopOverlay, pixel_x=src.Form1TopOverlayX, pixel_y=src.Form1TopOverlayY)
				src.Hairz("Remove")
				src.Intimidation/=2
				src.trans["active"]--
				src.Hairz("Add")
				if(!src.HasMystic())
					if(src.BaseBase)
						src.icon=src.BaseBase
						src.pixel_x=src.BaseBaseX
						src.pixel_y=src.BaseBaseY
						src.BaseBase=0
						src.BaseBaseX=0
						src.BaseBaseY=0

		if((src.Race=="Saiyan"||src.Race=="Half Saiyan")&&src.ssj["active"]==4)
			src.RevertSSJ4()
		else if((src.Race=="Saiyan"||src.Race=="Half Saiyan")&&src.ssj["active"]>=1)
			animate(src, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=3)
			spawn(3)
				animate(src, color = null, time=3)
			while(src.ssj["active"]>0)
				if(ssj["active"]==1)
					AngerPoint = oldAngerPoint
					if(ssj["god"])
						passive_handler.Decrease("GodKi")
						passive_handler.Decrease("CalmAnger")
						src.ssj["god"]=0
				if(ssj["active"]==2)
					src.EndlessAnger-=1
					src.PUSpeedModifier/=1.5
				if(masteries["[src.ssj["active"]]mastery"]<50)
					src.masteries["[src.ssj["active"]]mastery"]=50
				src.ssj["active"]--
				if(Controlled&&(src.ssj["active"]==0||src.ssj["active"]&&src.masteries["[src.ssj["active"]]mastery"]==100))
					break
			if(!src.ssj["active"])
				src.Anger=0
			src.Hairz("Add")

		if(src.Race=="Namekian")
			while(trans["active"]>0)
				if(src.masteries["1mastery"]!=100)
					src.masteries["1mastery"]=100
				src.TransformingBeyond-=1
				trans["active"]--

		if(src.Race=="Changeling")
			src.ChangelingMorphRevert()

	else
		switch(Type)
			if("God")
				if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
					src.RevertSSJG()
				else
					src.GodModeRevert()
			if("Tension")
				src.RevertHT()
			if("Jagan")
				src.RevertJaganshi()
			if("Weapon")
				src.RevertWS()


	if((src.HasKiControl()||src.PoweringUp)&&!src.KO)
		src.Auraz("Add")
	else
		src.Auraz("Remove")

mob/proc/Shockwave(var/icon/E,var/Q=1, var/x1=0, var/y1=0)
	set waitfor=0
	set background=1
	spawn()new/shockwave(\
	locate(src.x-x1,src.y-y1,src.z),
	E,
	Ticks=10*sqrt(Q),
	Speed=20*Q,
	Amount=20*Q,
	StopAtObj=0,
	Source=src)