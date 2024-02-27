#define TRANS_ONE_POTENTIAL 20
#define TRANS_TWO_POTENTIAL 40
#define TRANS_THREE_POTENTIAL 60
#define TRANS_FOUR_POTENTIAL 80
#define TRANS_FIVE_POTENTIAL 100

mob/var/transActive = 0

mob/proc/Transform()
	race.transformations[transActive+1].transform(src)

mob/proc/Revert()
	race.transformations[transActive].revert(src)

transformation
	var
		list/passives
		strength
		endurance
		force
		offense
		defense
		speed
		regeneration
		anger
		unlock_potential

		form_profile

		stored_base
		stored_base_x
		stored_base_y
		icon/form_base
		form_base_x
		form_base_y

		icon/form_hair
		form_hair_x
		form_hair_y

		form_aura
		form_aura_x
		form_aura_y
		form_aura_underlay
		form_aura_underlay_x
		form_aura_underlay_y

		pot_trans = 0

		priorAngerPoint
		angerPoint
		autoAnger = FALSE

		PUSpeedModifier = 1

		mastery = 0

		is_active = FALSE

	proc
		transform_animation(mob/user)

		revert_animation(mob/user)

		mastery_boons(mob/user)

		transform(mob/user)
			if(is_active || !user.CanTransform()) return

			mastery_boons(user)

			user.transActive++
			user.passive_handler.increaseList(passives)

			user.StrMultTotal += strength
			user.EndMultTotal += endurance
			user.ForMultTotal += force
			user.SpdMultTotal += speed
			user.OffMultTotal += offense
			user.DefMultTotal += defense

			user.potential_trans = user.Potential+pot_trans
			if(form_base)
				stored_base = user.icon
				stored_base_x = user.pixel_x
				stored_base_y = user.pixel_y
				user.icon = form_base
				user.pixel_x = form_base_x
				user.pixel_y = form_base_y

			priorAngerPoint = user.AngerPoint
			user.AngerPoint = angerPoint

			user.PUSpeedModifier *= PUSpeedModifier

			if(autoAnger)
				user.EndlessAnger++

			is_active = TRUE

			transform_animation(user)

			if(form_hair)
				user.Hairz("Add")
			if(form_aura || form_aura_underlay)
				user.Auraz("Add")

		revert(mob/user)
			if(!is_active || !user.CanRevert()) return

			user.transActive--
			user.passive_handler.decreaseList(passives)

			user.StrMultTotal -= strength
			user.EndMultTotal -= endurance
			user.ForMultTotal -= force
			user.SpdMultTotal -= speed
			user.OffMultTotal -= offense
			user.DefMultTotal -= defense

			user.potential_trans = 0

			user.AngerPoint = priorAngerPoint
			priorAngerPoint = null

			user.PUSpeedModifier /= PUSpeedModifier

			if(autoAnger)
				user.EndlessAnger--

			is_active = FALSE

			revert_animation(user)

			if(form_hair)
				user.Hairz("Add")

			if((user.HasKiControl()||user.PoweringUp)&&!user.KO)
				user.Auraz("Add")
			else
				user.Auraz("Remove")

	saiyan
		super_saiyan
			angerPoint = 75

			transform_animation(mob/user)
				switch(mastery)
					if(50 to 99)
						user.Quake(10)

					if(25 to 49)
						sleep()
						user.Quake(10)
						user.Quake(20)

					if(1 to 24)
						sleep()
						user.Quake(10)
						sleep(20)
						user.Quake(20)
						sleep(30)
						user.Quake(30)

					if(0)
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

				animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
				spawn(5)
					animate(user, color = null, time=5)
				sleep(2)

		super_saiyan_2
			autoAnger = TRUE
			PUSpeedModifier = 1.5

			transform_animation(mob/user)
				switch(mastery)
					if(25 to 99)
						user.Quake(10)
					if(10 to 24)
						for(var/mob/Players/T in view(18,user))
							spawn()
								T.Quake(25)
						for(var/turf/T in Turf_Circle(user,3))
							spawn(4)
								new/turf/Dirt1(locate(T.x,T.y,T.z))
							spawn(4)
								Destroy(T)
					if(0 to 9)
						for(var/mob/Players/T in view(18,user))
							spawn()
								T.Quake(50)
						for(var/turf/T in Turf_Circle(user,6))
							if(prob(1))
								sleep(0.005)
							spawn(4)
								new/turf/Dirt1(locate(T.x,T.y,T.z))
							spawn(4)
								Destroy(T)
				animate(user, color = list(1,0,0, 0,1,0, 0,0,1, 1,0.9,0.2), time=5)
				spawn(5)
					animate(user, color = null, time=5)
				sleep(2)

		super_saiyan_3

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