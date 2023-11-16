var/list/SkillTreeList=list("BlastT1"=list(),"BlastT2"=list(),"BlastT3"=list(),"BlastT4"=list(),"SwordT1"=list(),"SwordT2"=list(),"SwordT3"=list(),"SwordT4"=list(),"BeamT1"=list(),"BeamT2"=list(),"BeamT3"=list(),"BeamT4"=list(),"MagicT1"=list(),"MagicT2"=list(),"MagicT3"=list(),"MagicT4"=list(),"UnarmedT1"=list(),"UnarmedT2"=list(),"UnarmedT3"=list(),"UnarmedT4"=list(),"UnarmedStyles"=list(),"ElementalStyles"=list(),"SpiritStyles"=list(),"SwordStyles"=list())
proc/MakeSkillTreeList()
	for(var/x in SkillTree)
		for(var/z in SkillTree[x])
			var/obj/SkillTreeObj/s = new
			var/namez=z
			if(copytext("[z]",1,2)=="/")
				var/pos = 1
				while(findtextEx(namez, "/"))
					namez=copytext(namez, pos+1)
			s.path=z
			s.cost=SkillTree[x][z]
			s.name="[namez] ([s.cost])"
			SkillTreeList[x]+=s

var/list/SkillTree=list(

"UnarmedT1"=list(
			"/obj/Skills/Queue/Uppercut"=40,
			"/obj/Skills/Queue/Ikkotsu"=40,
			"/obj/Skills/Queue/Showstopper"=40,
			"/obj/Skills/Queue/Dempsey_Roll"=40,
			"/obj/Skills/Queue/Corkscrew_Blow"=40,

			"/obj/Skills/Queue/Axe_Kick"=40,
			"/obj/Skills/Queue/Kinshasa"=40,
			"/obj/Skills/Queue/Piston_Kick"=40,
			"/obj/Skills/Queue/Pin"=40,
			"/obj/Skills/Queue/Cripple"=40
),

"UnarmedT2"=list(
			"/obj/Skills/AutoHit/Focus_Punch"=80,
			"/obj/Skills/AutoHit/Force_Palm"=80,
			"/obj/Skills/AutoHit/Force_Stomp"=80,
			"/obj/Skills/AutoHit/Phantom_Strike"=80,
			"/obj/Skills/AutoHit/Dragon_Rush"=80,

			"/obj/Skills/AutoHit/Roundhouse_Kick"=80,
			"/obj/Skills/AutoHit/Sweeping_Kick"=80,
			"/obj/Skills/AutoHit/Lightning_Kicks"=80,
			"/obj/Skills/AutoHit/Flying_Kick"=80,
			"/obj/Skills/AutoHit/Helicopter_Kick"=80
),

"UnarmedT3"=list(
			"/obj/Skills/Grapple/Throw"=120,
			"/obj/Skills/Grapple/Judo_Throw"=120,
			"/obj/Skills/Grapple/Izuna_Drop"=120,
			"/obj/Skills/Grapple/Suplex"=120,
			"/obj/Skills/Grapple/Burning_Finger"=120
),

"UnarmedT4"=list(
			"/obj/Skills/Queue/GET_DUNKED"=160,
			"/obj/Skills/Queue/Curbstomp"=160,
			"/obj/Skills/Queue/Soukotsu"=160,
			"/obj/Skills/Queue/Six_Grand_Openings"=160,
			"/obj/Skills/Queue/Skullcrusher"=160,


			"/obj/Skills/AutoHit/Clothesline"=160,
			"/obj/Skills/AutoHit/Bullrush"=160,
			"/obj/Skills/AutoHit/Spinning_Clothesline"=160,
			"/obj/Skills/AutoHit/Hyper_Crash"=160,
			"/obj/Skills/AutoHit/Dropkick_Surprise"=160
),

"BlastT1"=list(
			"/obj/Skills/Projectile/Blast"=40,
			"/obj/Skills/Projectile/Rapid_Barrage"=40,
			"/obj/Skills/Projectile/Straight_Siege"=40,
			"/obj/Skills/Projectile/Flare_Wave"=40,
			"/obj/Skills/Projectile/Death_Beam"=40,

			"/obj/Skills/Projectile/Charge"=40,
			"/obj/Skills/Projectile/Spirit_Ball"=40,
			"/obj/Skills/Projectile/Crash_Burst"=40,
			"/obj/Skills/Projectile/Dragon_Nova"=40,
			"/obj/Skills/Projectile/Kienzan"=40
),

"BlastT2"=list(
			"/obj/Skills/Queue/Dancing_Lights"=80,
			"/obj/Skills/Queue/Light_Rush"=80,
			"/obj/Skills/Queue/Burst_Combination"=80,
			"/obj/Skills/Projectile/Sudden_Storm"=80,
			"/obj/Skills/Projectile/Warp_Strike"=80,

			"/obj/Skills/Projectile/Energy_Bomb"=80,
			"/obj/Skills/Projectile/Energy_Minefield"=80,
			"/obj/Skills/Projectile/Tracking_Bomb"=80,
			"/obj/Skills/Projectile/Stealth_Bomb"=80,
			"/obj/Skills/Projectile/Pillar_Bomb"=80
),

"BlastT3"=list(
			"/obj/Skills/Projectile/Beams/Ray"=120,
			"/obj/Skills/Projectile/Beams/Eraser_Gun"=120,
			"/obj/Skills/Projectile/Beams/Shine_Ray"=120,
			"/obj/Skills/Projectile/Beams/Gamma_Ray"=120,
			"/obj/Skills/Projectile/Beams/Piercer_Ray"=120
),

"BlastT4"=list(
			"/obj/Skills/AutoHit/Destruction_Wave"=160,
			"/obj/Skills/AutoHit/Breaker_Wave"=160,
			"/obj/Skills/AutoHit/Blazing_Storm"=160,
			"/obj/Skills/AutoHit/Ghost_Wave"=160,
			"/obj/Skills/AutoHit/Power_Pillar"=160,

			"/obj/Skills/Projectile/Power_Buster"=160,
			"/obj/Skills/Projectile/Burst_Buster"=160,
			"/obj/Skills/Projectile/Warp_Buster"=160,
			"/obj/Skills/Projectile/Scatter_Burst"=160,
			"/obj/Skills/Projectile/Counter_Buster"=160
),

"MagicT1"=list(
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Reinforce_Object"=40,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Broken_Phantasm"=40,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Reinforce_Self"=40,

			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Magic_Trick"=40,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Magic_Act"=40,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Magic_Show"=40,

			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Water_Walk"=40,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Swift_Walk"=40,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Wind_Walk"=40
),

"MagicT2"=list(
			"/obj/Skills/Projectile/Magic/Fire"=80,
			"/obj/Skills/Projectile/Magic/Fira"=80,
			"/obj/Skills/Projectile/Magic/Firaga"=80,

			"/obj/Skills/AutoHit/Magic/Blizzard"=80,
			"/obj/Skills/AutoHit/Magic/Blizzara"=80,
			"/obj/Skills/AutoHit/Magic/Blizzaga"=80,

			"/obj/Skills/AutoHit/Magic/Thunder"=80,
			"/obj/Skills/AutoHit/Magic/Thundara"=80,
			"/obj/Skills/AutoHit/Magic/Thundaga"=80
),

"MagicT3"=list(
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Stone_Skin"=120,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/True_Effort"=120,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Heroic_Will"=120,

			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Mage_Armor"=120,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Perfect_Warrior"=120,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Golem_Form"=120,

			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Binding"=120,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Infect"=120,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Curse"=120
),

"MagicT4"=list(
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Shell"=160,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Barrier"=160,
			"/obj/Skills/Buffs/SlotlessBuffs/Magic/Protect"=160,

			"/obj/Skills/AutoHit/Magic/Magnet"=160,
			"/obj/Skills/AutoHit/Magic/Gravity"=160,
			"/obj/Skills/AutoHit/Magic/Stop"=160,

			"/obj/Skills/Projectile/Magic/Disintegrate"=160,
			"/obj/Skills/Projectile/Magic/Meteor"=160,
			"/obj/Skills/AutoHit/Magic/Flare"=160
),

"SwordT1"=list(
			"/obj/Skills/AutoHit/Tipper"=40,
			"/obj/Skills/AutoHit/Stinger"=40,
			"/obj/Skills/AutoHit/Sword_Pressure"=40,
			"/obj/Skills/AutoHit/Light_Step"=40,
			"/obj/Skills/AutoHit/Overhead_Divide"=40,

			"/obj/Skills/AutoHit/Arc_Slash"=40,
			"/obj/Skills/AutoHit/Hack_n_Slash"=40,
			"/obj/Skills/AutoHit/Vacuum_Render"=40,
			"/obj/Skills/AutoHit/Hamstring"=40,
			"/obj/Skills/AutoHit/Cross_Slash"=40
),

"SwordT2"=list(
			"/obj/Skills/AutoHit/Hero_Spin"=80,
			"/obj/Skills/AutoHit/Drill_Spin"=80,
			"/obj/Skills/AutoHit/Rising_Spire"=80,
			"/obj/Skills/AutoHit/Ark_Brave"=80,
			"/obj/Skills/AutoHit/Judgment"=80,

			"/obj/Skills/Queue/Swallow_Reversal"=80,
			"/obj/Skills/Queue/Larch_Dance"=80,
			"/obj/Skills/Queue/Willow_Dance"=80,
			"/obj/Skills/Queue/Zero_Reversal"=80,
			"/obj/Skills/Queue/Infinity_Trap"=80
),

"SwordT3"=list(
			"/obj/Skills/Grapple/Sword/Impale"=120,
			"/obj/Skills/Grapple/Sword/Eviscerate"=120,
			"/obj/Skills/Queue/Run_Through"=120,
			"/obj/Skills/Grapple/Sword/Hacksaw"=120,
			"/obj/Skills/Grapple/Sword/Form_Ataru"=120
),

"SwordT4"=list(
			"/obj/Skills/Projectile/Sword/Scathing_Breeze"=160,
			"/obj/Skills/Projectile/Sword/Backlash_Wave"=160,
			"/obj/Skills/Projectile/Sword/Wind_Scar"=160,
			"/obj/Skills/Projectile/Sword/Air_Carve"=160,
			"/obj/Skills/Projectile/Sword/Phantom_Howl"=160,

			"/obj/Skills/AutoHit/Flash_Cut"=160,
			"/obj/Skills/AutoHit/Crowd_Cutter"=160,
			"/obj/Skills/AutoHit/Jet_Slice"=160,
			"/obj/Skills/AutoHit/Holy_Justice"=160,
			"/obj/Skills/AutoHit/Doom_of_Damocles"=160
),

"UnarmedStyles"=list(
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"=20,
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Crane_Style"=20,
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Snake_Style"=20,
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Cat_Style"=20
),

"SpiritStyles"=list(
			"/obj/Skills/Buffs/NuStyle/FreeStyle/Feral_Style"=20,
			"/obj/Skills/Buffs/NuStyle/FreeStyle/Flow_Style"=20,
			"/obj/Skills/Buffs/NuStyle/FreeStyle/Breaker_Style"=20,
			"/obj/Skills/Buffs/NuStyle/FreeStyle/Blitz_Style"=20
),

"ElementalStyles"=list(
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Earth_Style"=20,
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wind_Style"=20,
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Fire_Style"=20,
			"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Water_Style"=20
),

"SwordStyles"=list(
			"/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido_Style"=20,
			"/obj/Skills/Buffs/NuStyle/SwordStyle/Fencing_Style"=20,
			"/obj/Skills/Buffs/NuStyle/SwordStyle/Zornhau_Style"=20,
			"/obj/Skills/Buffs/NuStyle/SwordStyle/Swordless_Style"=20
),

)

mob
	verb
		Saga_Invest()
			set hidden=1
			if(!usr.Saga)
				usr << "You do not possess a saga to invest in."
				return
			if(usr.SagaLevel>=6)
				usr << "You have trained your saga to the highest known level."
				return
			var/Req=usr.SagaEXPReq()-usr.SagaEXP
			if(Req<=0)//if you have the next level ready, reject
				usr << "You have invested enough for your next saga level already, but you must advance your fighting potential further."
				return
			var/Invest=input(usr, "How much RPP do you want to invest into your saga progression?", "Saga Invest (1-[Req])") as num|null
			if(!Invest || Invest==null || Invest <= 0)
				usr << "Invalid invest amount."
				return
			if(Invest > usr.GetRPPSpendable())
				Invest=usr.GetRPPSpendable()
			if(Invest > Req)
				Invest=Req
			switch(alert(usr, "Are you sure you want to invest [Invest] RPP into your saga development?", "Saga Invest ([Invest])", "No", "Yes"))
				if("No")
					usr << "You have not invested in your saga."
					return
				if("Yes")
					if(usr.SpendRPP(Invest, "Saga Investment", Training=1))
						usr.SagaEXP+=Invest
						usr << "You invest [Invest] RPP into your saga development!"

		Buy_Stances()
			set hidden=1
			

obj/SkillTreeObj
	var/path
	var/cost
	var/tier
	icon='skilltree.dmi'
	layer=9999
	Click()
		if(copytext("[src.path]",1,2)!="/")
			if(src.path=="Sense")
				if(!locate(/obj/Skills/Utility/Sense,usr))
					if(usr.SpendRPP(src.cost, "Sense", Training=1))
						usr.AddSkill(new/obj/Skills/Utility/Sense)
						return
				else
					usr << "You already know how to sense energy!"
					return



		else
			var/path=text2path("[src.path]")
			var/obj/Skills/s=new path
			var/obj/s2
			var/obj/s3

			if(locate(s,usr.contents))
				usr<< "You already know this skill!"
				del(s)
				return

			var/SwordSkill
			if(s.NeedsSword)
				SwordSkill=1

			if(s.type in usr.SkillsLocked)
				if(usr.Saga=="Weapon Soul"&&SwordSkill)
					goto Bypass1
				usr << "You cannot buy [s] because it is a prerequisite to a skill that you've already upgraded!"
				del s
				return
			Bypass1

			var/Confirm=alert(usr, "Are you sure you wish to buy [src] for [src.cost] RPP?!", "ARE YOU REALLY SURE", "No", "Yes")
			if(Confirm=="No")
				del(s)
				return

			if(locate(s,usr.contents))
				usr << "You've already learned [s]."
				del(s)
				return

			if(s.type in usr.SkillsLocked)
				if(usr.Saga=="Weapon Soul"&&SwordSkill)
					goto Bypass2
				usr << "You cannot buy [s] because it is a prerequisite to a skill that you've already upgraded!"
				del s
				return
			Bypass2

			if(istype(s, /obj/Skills))
				if(s:LockOut.len>0)
					for(var/x=1,x<=s:LockOut.len,x++)
						var/found=0
						var/path3=text2path("[s:LockOut[x]]")
						s3=new path3
						if(locate(s3, usr))
							found=1
						if(found)
							if(usr.Saga=="Weapon Soul"&&SwordSkill)
								goto Bypass3
							usr << "You cannot buy [s] when you already possess [s3]!"
							del s3
							return
				Bypass3
				if(s:PreRequisite.len>0)
					for(var/x=1,x<=s:PreRequisite.len,x++)
						var/found=0
						var/path2=text2path("[s:PreRequisite[x]]")
						s2=new path2
						if(locate(s2, usr))
							found=1
						if(!found)
							usr << "You need to buy [s2] before [s]!"
							del s2
							return


			if(usr.SpendRPP(src.cost, "[s]", Training=1))
				usr.AddSkill(s)
				if(s.type==/obj/Skills/Power_Control)
					if(!locate(/obj/Skills/Buffs/ActiveBuffs/Ki_Control, usr))
						usr.PoweredFormSetup()
				// if(s.type in typesof(/obj/Skills/Buffs/NuStyle))
				// 	var/obj/Skills/Buffs/NuStyle/ns=s

				if(s:PreRequisite.len>0)
					usr.PrerequisiteRemove(s)
		..()


mob/Players/verb
	Acquire_Skills()
		set category="Other"
		set hidden=1
		if(!(world.time > verb_delay)) return
		verb_delay=world.time+1
		winshow(usr,"skilltree",1)
	skilltreez(var/z as text)
		set hidden=1//interface verb doesnt needa be found out
		if(!(world.time > verb_delay)) return
		verb_delay=world.time+1
		winset(usr,"skilltreegrid","cells=0x0")//clears grid
		usr<<output("RPP: [round(usr.GetRPPSpendable())]","STRewardPoints")
		sleep(1)
		var/p=1//used as a positioning locator for rows/columns
		for(var/obj/SkillTreeObj/x in SkillTreeList[z])
			//p++
			usr<<output(x,"skilltreegrid:[1],[p]")
			p++

mob/proc
	PoweredFormSetup()
		src << "Powering up to a certain level will activate your Powered Form which will provide a sharp increase in your fighting prowess!"
		var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/KC=new
		var/list/Passives=list("Flicker", "Godspeed", "Pursuer")
		var/passive = input(src, "Pick a focus") in Passives
		KC.selectedPassive=passive
		KC.init(src)
		if(src.Race=="Makyo")
			KC.icon=src.ExpandBase
			KC.IconReplace=1
		src.AddSkill(KC)
		resetPU = FALSE
		resetPU1 = FALSE