var/global/celestialObjectTicks = Hour(12)/10
var
	MoonMessage="The lone local moon shines brightly!"
	MakyoMessage="A cursed star shines in the sky"
	MoonSetMessage="The lone local moon sets!"
	MakyoSetMessage="A cursed star disappears from the sky"

proc/CelestialBodiesLoop()
	set waitfor = 0
	while(1)
		celestialObjectTicks--
		if(celestialObjectTicks==0)
			CallMoon()
			CallStar()
			celestialObjectTicks = Hour(12)/10
		sleep(10)

proc/MoonSetLoop()
	while(1)
		if(global.MoonOut)
			sleep(Hour(1))
			for(var/mob/Players/P in players)
				if(P.z in global.MoonOut)
					P.MoonSetTrigger()
			global.MoonOut=list()
proc/MakyoSetLoop()
	while(1)
		if(global.MakyoOut)
			sleep(Day(1))
			for(var/mob/Players/P in players)
				if(P.z in global.MakyoOut)
					P.MakyoSetTrigger()
			global.MakyoOut=list()
mob
	proc
		MoonWarning()
			if(src.Secret=="Werewolf")
				src << "You feel the moon begin to rise... "
			if(src.Tail&&(src.Race=="Saiyan"||src.Race=="Half Saiyan"))
				src << "You feel the moon begin to rise... "
			if(src.AdvancedTransmissionTechnologyUnlocked>0)
				src << "Your observation devices are warning you about full moon... "
		MoonTrigger()
			for(var/obj/Oozaru/O in src)
				if(O.Looking)
					break
					// src.Oozaru(1)
			if(locate(/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form, src))
				if(!src.CheckSlotless("FullMoonForm"))
					if(src.SpecialBuff)
						src.SpecialBuff.Trigger(src)
					if(src.SlotlessBuffs.len>0)
						for(var/obj/Skills/Buffs/b in src.SlotlessBuffs)
							b.Trigger(src)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form/F in src)
						F.Trigger(src)
			src<<"<font color=yellow>[global.MoonMessage]</font color>"
		MoonSetTrigger()
			for(var/obj/Oozaru/O in src)
				if(O.icon)
					src.Oozaru(0)
			if(locate(/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form, src))
				if(src.CheckSlotless("FullMoonForm"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form/F in src)
						F.Trigger(src)
			src<<"<font color=yellow>[global.MoonSetMessage]</font color>"
		MakyoWarning()
			if(src.Race=="Makyo")
				src << "You feel your blood boiling in anticipation... "
			if(src.AdvancedTransmissionTechnologyUnlocked>0)
				src << "Your observation devices are warning you about an unusual celestial object... "
		MakyoTrigger()
			if(src.Race=="Makyo")
				if(src.PotentialRate<2)
					src.PotentialRate+=0.25
					if(src.PotentialRate>2)
						src.PotentialRate=2
				src.StarPowered=1
				for(var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/KC in src)
					if(!src.BuffOn(KC))
						src.PowerControl=150
						src.PoweringUp=0
						src.Auraz("Remove")
						src.UseBuff(KC)
			src<<"<font color=red>[global.MakyoMessage]</font color>"
		MakyoSetTrigger()
			if(src.Race=="Makyo")
				for(var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/KC in src)
					if(src.BuffOn(KC))
						src.UseBuff(KC)
			src<<"<font color=red>[global.MakyoSetMessage]</font color>"

proc/CallMoon(var/OnlyZ=null)
	set waitfor=0
	set background=1
	for(var/mob/Players/P in players)
		if(OnlyZ)
			if(P.z==OnlyZ)
				P.MoonWarning()
		else
			P.MoonWarning()
	sleep(Minute(2))
	for(var/mob/Players/P in players)
		if(OnlyZ)
			if(P.z==OnlyZ)
				P.MoonTrigger()
		else
			P.MoonTrigger()


proc/CallStar(var/OnlyZ=null)
	set waitfor=0
	set background=1
	for(var/mob/Players/P in players)
		if(OnlyZ)
			if(P.z==OnlyZ)
				P.MakyoWarning()
		else
			P.MakyoWarning()
	sleep(Minute(2))
	for(var/mob/Players/P in players)
		if(OnlyZ)
			if(P.z==OnlyZ)
				P.MakyoTrigger()
		else
			P.MakyoTrigger()