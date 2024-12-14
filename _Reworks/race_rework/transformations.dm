#define TRANS_ONE_POTENTIAL 20
#define TRANS_TWO_POTENTIAL 40
#define TRANS_THREE_POTENTIAL 60
#define TRANS_FOUR_POTENTIAL 80
#define TRANS_FIVE_POTENTIAL 100

globalTracker
	var/lockTransAutomation = TRUE
	var/list/transLocked = list(/transformation/saiyan/super_saiyan, /transformation/saiyan/super_saiyan_2,/transformation/saiyan/super_saiyan_3)

mob/var/transActive = 0
mob/var/bypassTransAutomation = 0
mob/var/transUnlocked = 0

mob/proc/Transform(type)
	if(type)
		//old stuff; high chance its wonky. its mainly hotwired in here as a legacy from the old transform/revert
		switch(type)
			if("Tension")
				for(var/obj/Skills/Buffs/SpecialBuffs/High_Tension/T in src)
					src.HighTension(T.Tension)
					T.Tension=0

			if("Jagan")
				src.Jaganshi()

			if("Weapon")
				src.WeaponSoul()
		return
	race.transformations[transActive+1].transform(src)

mob/proc/Revert(type)
	if(type)
		//old stuff; high chance its wonky. its mainly hotwired in here as a legacy from the old transform/revert
		switch(type)
			if("Tension")
				src.RevertHT()
			if("Jagan")
				src.RevertJaganshi()
			if("Weapon")
				src.RevertWS()
		return

	race.transformations[transActive].revert(src)

transformation
	var
		list/passives
		strength = 1
		endurance = 1
		force = 1
		offense = 1
		defense = 1
		speed = 1
		regeneration
		anger
		unlock_potential = -1
		intimidation

		BioArmor
		BioArmorMax

		transformation_message
		detrans_message

		stored_profile
		form_profile

		stored_base
		stored_base_x
		stored_base_y
		icon/form_base
		form_base_x
		form_base_y

		image/form_hair
		form_hair_icon
		form_hair_x
		form_hair_y

		image/form_aura
		form_aura_icon
		form_aura_icon_state
		form_aura_x
		form_aura_y

		image/form_aura_underlay
		form_aura_underlay_icon
		form_aura_underlay_icon_state
		form_aura_underlay_x
		form_aura_underlay_y
		TransClass

		image/form_icon_1
		form_icon_1_icon
		form_icon_1_icon_state
		form_icon_1_x
		form_icon_1_y

		image/form_icon_2
		form_icon_2_icon
		form_icon_2_icon_state
		form_icon_2_x
		form_icon_2_y

		image/form_glow
		form_glow_icon
		form_glow_icon_state
		form_glow_x
		form_glow_y

		pot_trans = 0

		priorAngerPoint
		angerPoint
		autoAnger = FALSE

		PUSpeedModifier = 1

		mastery = 0

		is_active = FALSE

		first_time = TRUE

	proc
		adjust_transformation_visuals(mob/user)
			form_glow = image(icon=form_glow_icon,icon_state = form_glow_icon_state,pixel_x = form_glow_x, pixel_y = form_glow_y)
			form_aura = image(icon = form_aura_icon, icon_state = form_aura_icon_state, pixel_x = form_aura_x, pixel_y = form_aura_y)
			form_aura_underlay = image(icon = form_aura_underlay_icon, icon_state = form_aura_underlay_icon_state, pixel_x = form_aura_underlay_x, pixel_y = form_aura_underlay_y)
			form_hair = image(icon = form_hair_icon, pixel_x = form_hair_x, pixel_y = form_hair_y, layer = FLOAT_LAYER-2)
			form_icon_1 = image(icon = form_icon_1_icon, icon_state = form_icon_1_icon_state, pixel_x = form_icon_1_x, pixel_y = form_icon_1_y)
			form_icon_2 = image(icon = form_icon_2_icon, icon_state = form_icon_2_icon_state,pixel_x = form_icon_2_x, pixel_y = form_icon_2_y)

		transform_animation(mob/user)

		revert_animation(mob/user)

		mastery_boons(mob/user)

		apply_visuals(mob/user, aura = 1, hair = 1, extra = 1)
			adjust_transformation_visuals(user)
			if(extra)
				user.overlays += form_icon_1
				user.overlays += form_icon_2
				user.overlays += form_glow
			if(aura)
				user.overlays += form_aura
				user.underlays += form_aura_underlay
			if(hair)
				user.Hair = form_hair

		remove_visuals(mob/user, aura = 1, hair = 1, extra = 1)
			if(hair)
				user.Hair = user.Hair_Base
			if(extra)
				user.overlays -= form_icon_1
				user.overlays -= form_icon_2
				user.overlays -= form_glow
			if(aura)
				user.overlays -= form_aura
				user.underlays -= form_aura_underlay

		transform(mob/user)
			if(is_active || !user.CanTransform()) return

			if(user.transUnlocked < user.transActive+1)
				if(!(user.bypassTransAutomation >= user.transActive+1) && glob.lockTransAutomation && (type in glob.transLocked)) return.
				if(unlock_potential >= user.Potential) return

			mastery_boons(user)

			adjust_transformation_visuals(user)

			user.transActive++
			user.passive_handler.increaseList(passives)

			user.StrMultTotal *= strength
			user.EndMultTotal *= endurance
			user.ForMultTotal *= force
			user.SpdMultTotal *= speed
			user.OffMultTotal *= offense
			user.DefMultTotal *= defense

			user.BioArmorMax += BioArmorMax
			if(user.BioArmor > user.BioArmorMax)
				user.BioArmor = user.BioArmorMax

			user.potential_trans = user.Potential+pot_trans
			if(form_base)
				stored_base = user.icon
				stored_base_x = user.pixel_x
				stored_base_y = user.pixel_y
				user.icon = form_base
				user.pixel_x = form_base_x
				user.pixel_y = form_base_y

			if(form_profile)
				stored_profile = user.Profile
				user.Profile = form_profile
			priorAngerPoint = user.AngerPoint
			user.AngerPoint = angerPoint

			user.PUSpeedModifier *= PUSpeedModifier

			if(autoAnger)
				user.passive_handler.Increase("EndlessAnger")

			is_active = TRUE

			transform_animation(user)

			if(first_time)
				first_time = FALSE

			user.Hairz("Add")
			user.Auraz("Add")

			if(transformation_message)
				user << transformation_message

		revert(mob/user)
			if(!is_active || !user.CanRevert()) return

			user.transActive--
			user.passive_handler.decreaseList(passives)

			user.StrMultTotal /= strength
			user.EndMultTotal /= endurance
			user.ForMultTotal /= force
			user.SpdMultTotal /= speed
			user.OffMultTotal /= offense
			user.DefMultTotal /= defense

			user.BioArmorMax -= BioArmorMax
			if(user.BioArmor > user.BioArmorMax)
				user.BioArmor = user.BioArmorMax

			if(stored_base)
				user.icon = stored_base
				user.pixel_x = stored_base_x
				user.pixel_y = stored_base_y
				stored_base = null

			user.potential_trans = 0

			user.AngerPoint = priorAngerPoint
			priorAngerPoint = null

			user.PUSpeedModifier /= PUSpeedModifier

			if(autoAnger)
				user.passive_handler.Decrease("EndlessAnger")

			if(stored_profile)
				user.Profile = stored_profile
				stored_profile = null

			is_active = FALSE

			revert_animation(user)

			user.Hairz("Add")

			if((user.HasKiControl()||user.PoweringUp)&&!user.KO)
				user.Auraz("Add")
			else
				user.Auraz("Remove")

			user.AppearanceOff()
			user.AppearanceOn()
			if(detrans_message)
				user << detrans_message


	saiyan
		super_saiyan
			form_aura_icon = 'AurasBig.dmi'
			form_aura_icon_state = "SSJ"
			form_aura_x = -32
			form_icon_1_icon = 'SS2Sparks.dmi'
			form_glow_icon = 'Ripple Radiance.dmi'
			form_glow_x = -32
			form_glow_y = -32
			unlock_potential = 40
			passives = list("Instinct" = 1, "Flow" = 1, "Flicker" = 1, "Pursuer" = 2,  "BuffMastery" = 3, "PureDamage" = 1, "PureReduction" = 1)
			angerPoint = 75

			adjust_transformation_visuals(mob/user)
				if(!form_hair_icon&&user.Hair_Base)
					var/icon/x=new(user.Hair_Base)
					if(x)
						x.MapColors(0.2,0.2,0.2, 0.39,0.39,0.39, 0.07,0.07,0.07, 0.69,0.42,0)
					form_hair_icon = x
					form_icon_2_icon = x
				..()
				form_glow.blend_mode=BLEND_ADD
				form_glow.alpha=40
				form_glow.color=list(1,0,0, 0,0.8,0, 0,0,0, 0.2,0.2,0.2)
				form_icon_2.blend_mode=BLEND_MULTIPLY
				form_icon_2.alpha=125
				form_icon_2.color=list(1,0,0, 0,0.82,0, 0,0,0, -0.26,-0.26,-0.26)

			transform_animation(mob/user)
				if(first_time)
					DarknessFlash(user)
					sleep()
					LightningStrike2(user, Offset=4)
					user.Quake(10)
					sleep(20)
					LightningStrike2(user, Offset=4)
					user.Quake(20)
					sleep(30)
					LightningStrike2(user, Offset=4)
					user.Quake(30)
					user.Quake(50)
					spawn(1)
						LightningStrike2(user, Offset=2)
					spawn(3)
						LightningStrike2(user, Offset=2)
					spawn(5)
						LightningStrike2(user, Offset=2)
				else
					switch(mastery)
						if(50 to 99)
							user.Quake(10)

						if(25 to 49)
							sleep()
							user.Quake(10)
							user.Quake(20)

						if(0 to 24)
							sleep()
							user.Quake(10)
							sleep(20)
							user.Quake(20)
							sleep(30)
							user.Quake(30)

				animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
				spawn(5)
					animate(user, color = null, time=5)
				sleep(2)

		super_saiyan_2
			form_aura_icon = 'AurasBig.dmi'
			form_aura_icon_state = "SSJ2"
			form_aura_x = -32
			form_icon_2_icon = 'SS2Sparks.dmi'
			unlock_potential = 55
			autoAnger = TRUE
			passives = list("Instinct" = 1, "Flow" = 1, "Flicker" = 1, "Pursuer" = 2, "BuffMastery" = 1, "PureDamage" = 1, "PureReduction" = 1)
			PUSpeedModifier = 1.5
			adjust_transformation_visuals(mob/user)
				if(user.Hair_Base && !form_hair_icon)
					var/icon/x=new(user.Hair_Base)
					if(x)
						x.Blend(rgb(160,130,0),ICON_ADD)
					form_hair_icon=x
				..()
				if(!form_icon_1)
					form_icon_1 = image(user.Hair_SSJ2)
					form_icon_1.blend_mode=BLEND_MULTIPLY
					form_icon_1.alpha=125
					form_icon_1.color=list(1,0,0, 0,0.82,0, 0,0,0, -0.26,-0.26,-0.26)

			transform_animation(mob/user)
				switch(mastery)
					if(25 to 99)
						user.Quake(10)
					if(10 to 24)
						for(var/mob/Players/T in view(18,user))
							spawn()
								T.Quake(25)
					/*	for(var/turf/T in Turf_Circle(user,3))
							spawn(4)
								new/turf/Dirt1(locate(T.x,T.y,T.z))
							spawn(4)
								Destroy(T)*/
					if(0 to 9)
						for(var/mob/Players/T in view(18,user))
							spawn()
								T.Quake(50)
					/*	for(var/turf/T in Turf_Circle(user,6))
							if(prob(1))
								sleep(0.005)
							spawn(4)
								new/turf/Dirt1(locate(T.x,T.y,T.z))
							spawn(4)
								Destroy(T)*/
				animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
				spawn(5)
					animate(user, color = null, time=5)
				sleep(2)

		super_saiyan_3
			form_aura_icon = 'AurasBig.dmi'
			form_aura_icon_state = "SSJ2"
			form_aura_x = -32
			form_icon_2_icon = 'SS3Sparks.dmi'
			form_hair_icon = 'Hair_SSj3.dmi'
			form_icon_1_icon = 'Hair_SSj3.dmi'
			passives = list("Flicker" = 1, "Pursuer" = 1, "BuffMastery" = 2, "PureDamage" = 1, "PureReduction" = 1)
			unlock_potential = 75

			adjust_transformation_visuals(mob/user)
				..()
				form_icon_1 = image(user.Hair_SSJ3)
				form_icon_1.blend_mode=BLEND_MULTIPLY
				form_icon_1.alpha=125
				form_icon_1.color=list(1,0,0, 0,0.82,0, 0,0,0, -0.26,-0.26,-0.26)

			transform_animation(mob/user)
				if(mastery < 50)
					user.icon_state=""
					var/image/HF=image(icon=user.race.transformations[2].form_hair, pixel_x=user.race.transformations[2].form_hair_x, pixel_y=user.race.transformations[2].form_hair_y, loc = user)
					HF.appearance_flags=KEEP_APART | NO_CLIENT_COLOR | RESET_ALPHA | RESET_COLOR
					HF.color=list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2)
					animate(HF, alpha=0)
					spawn()
						user.Quake(40)
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
					TransformBeyond(user)
					sleep(5)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(user, Offset=4)
					spawn()
						user.Earthquake(10,8,24,8,24,999)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(user, Offset=4)
					spawn()
						user.Earthquake(10,8,24,8,24,999)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(user, Offset=4)
					spawn()
						user.Earthquake(10,8,24,8,24,999)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(src, Offset=4)
					spawn()
						user.Earthquake(30,8,24,8,24,999)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(user, Offset=4)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(user, Offset=4)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(user, Offset=4)
					spawn()
						user.Earthquake(60,8,24,8,24,999)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					LightningStrike2(src, Offset=4)
					animate(HF, alpha=210, time=5)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					sleep(5)
					animate(HF, alpha=0, time=5)
					animate(user, color = user.MobColor, time=5)
					sleep(5)
					spawn()
						user.Earthquake(30,16,48,16,48,user.z)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					del HF
					var/ShockSize=5
					for(var/wav=5, wav>0, wav--)
						KenShockwave(src, icon='KenShockwaveGold.dmi', Size=ShockSize, Blend=2, Time=8)
						ShockSize/=2
					spawn(10)
						animate(user, color = user.MobColor, time=30)
				else
					sleep()
					user.Quake(40)
					animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=10)
					var/ShockSize=5
					for(var/wav=5, wav>0, wav--)
						KenShockwave(user, icon='KenShockwaveGold.dmi', Size=ShockSize, Blend=2, Time=8)
						ShockSize/=2
					spawn(10)
						animate(user, color = user.MobColor, time=30)
					sleep(2)


	alien
		super_alien
			transform(mob/user)
				if(!TransClass)
					TransClass = input(user, "Which form of Super Alien do you unleash?", "Super Alien Form")in list("Brutality" , "Harmony" , "Tenacity" , "Sagcity")
					//you can set this var to the input so you have the choice and then you can use a switch on it
					//you can do it as just the switch statement as well
					// switch(input(src, "Which form of Super Alien do you unleash?", "Super Alien Form")in list("Brutality" , "Harmony" , "Tenacity" , "Sagacity")) // the return of the input poc will be one of the four
					switch(TransClass)
						if("Tenacity")
							strength = 0.25
							speed = 0.25
							passives=list("Desperation" = 1)
						if("Brutality")
							strength = 0.25
							endurance = 0.25
							intimidation = 20
						if("Harmony")
							force = 0.25
							defense = 0.25
							passives=list("Desperation" = 1)
						if("Sagacity")
							force = 0.25
							speed = 0.25
							intimidation = 20
						// the switch statement will handle the return, there is no need for a while, in fact u just shouldn't use them if you are inexperienced.






				// var/Choice
				// var/Confirm < - confirm is made but not set, it is like saying ok i have this piece of paper but never saying its a dollar bill
				// while(Confirm!="Yes") /// <--- why doesn't this work?! // this will just throw an error or always be false; there is no end to the while loop as well so all that happens is an inf loop, stagnated by an input
				// 	Choice=input(src, "Which form of Super Alien do you unleash?", "Super Alien Form")in list("Brutality" , "Harmony" , "Tenacity" , "Sagacity")
				// correct code
				// 	if(Choice)
					// then set Confirm = "Yes"
				// all of the above isnt needed anyway
				// switch(Choice)
				// 	if("Tenacity")
				// 		strength = 5
				// 		speed = 5
				// 	if("Brutality")
				// 		strength = 5
				// 		speed = 5
				// 	if("Harmony")
				// 		force = 5
				// 	if("Sagacity")
				// 		endurance = 5
				// src.TransClass=Choice
				/// ive tried writing this like 100 times, but the idea should just be that aliens can pick their class of super alien and gain different boons!!!!111 will need to figure this out...
				/// duplicate definitions, probably just retarded but i cant figure out why
				..()

	namekian
		super_namekian
			passives=list("Life Generation" = 0.5)
			PUSpeedModifier = 1.5
			anger = 0.3
			intimidation = 12
			regeneration = 0.75
			form_aura_icon = "Amazing Super Namekian Aura.dmi"
			form_aura_x = -32

		orange_namekian
			passives=list("GodKi" = 1, "Life Generation" = 3)
			PUSpeedModifier = 2
			anger = 1
			autoAnger = TRUE
			intimidation = 100
			regeneration = 1
			form_base = "Orange Namek.dmi"
			form_aura_icon ="FlameGlowZeus.dmi"
			form_aura_x = -16

	changeling
		second_form
			PUSpeedModifier = 1.5
			intimidation = 3
			pot_trans = 1
			BioArmorMax = -25
			endurance = 0.8
			defense = 0.8
			offense = 1.25
			force = 1.5
			strength = 1.5
			passives = list("PureDamage" = 2, "Instinct" = 1, "Flicker" = 1, "Godspeed" = 1, "PureReduction" = -3, "MovementMastery" = 2)
			form_base = 'Chilled2.dmi'
			transformation_message = "cracks their tail, entering their Second Form in a burst of power!"



		third_form //higher we go
			PUSpeedModifier = 1.5
			intimidation = 3
			pot_trans = 1
			BioArmorMax = -50
			endurance = 0.8
			defense = 0.8
			offense = 1.25
			force = 1.5
			strength = 1.5
			passives = list("PureDamage" = 3, "Instinct" = 1, "Flicker" = 1, "Godspeed" = 1, "PureReduction" = -3, "MovementMastery" = 2)
			form_base = 'Chilled3.dmi'
			transformation_message = "cracks their tail, entering their Third Form in a burst of power!"

		final_form //intended to probably be their default for most of wipe, or atleast post-ssj scaling
			PUSpeedModifier = 1.5
			intimidation = 3
			pot_trans = 3
			BioArmorMax = -75
			endurance = 0.8
			defense = 0.8
			offense = 1.25
			force = 1.5
			strength = 1.5
			passives = list("PureDamage" = 3, "Instinct" = 1, "Flicker" = 1, "Godspeed" = 1, "PureReduction" = -3,  "CriticalBlock" = -0.25, "BlockChance" = -0.25, "CriticalChance" = 0.25, "CriticalDamage" = 0.25, "MovementMastery" = 2)
			form_base = 'Chilled4.dmi'
			transformation_message = "cracks their tail, entering their Final Form in a burst of power!"

		fifth_form // at asc 3 they can choose to gain another form, it does more of the same and jug. There is another option coming for asc 3 later that instead is for cyber changelings
			PUSpeedModifier = 1.5
			intimidation = 10
			endurance = 0.8
			defense = 0.8
			offense = 1.25
			force = 1.5
			strength = 1.5
			passives = list("PureDamage" = 3, "Instinct" = 2, "Flicker" = 1, "Godspeed" = 2, "PureReduction" = -3, "Juggernaut" = 1, "MovementMastery" = 2)
			pot_trans = 5
			BioArmorMax = -100
			transformation_message = "cracks their tail, entering their Fifth Form in a burst of destructive power!"


