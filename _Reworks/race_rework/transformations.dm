#define TRANS_ONE_POTENTIAL 20
#define TRANS_TWO_POTENTIAL 40
#define TRANS_THREE_POTENTIAL 60
#define TRANS_FOUR_POTENTIAL 80
#define TRANS_FIVE_POTENTIAL 100

mob/var/transActive = 0

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
		is_active = FALSE

	proc
		transform_animation(mob/user)

		revert_animation(mob/user)

		transform(mob/user)
			if(is_active || !user.CanTransform()) return

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

			is_active = FALSE
			revert_animation(user)

			if(form_hair)
				user.Hairz("Add")

			if((user.HasKiControl()||user.PoweringUp)&&!user.KO)
				user.Auraz("Add")
			else
				user.Auraz("Remove")

mob/proc/Transform()
	race.transformations[transActive+1].transform(src)

mob/proc/Revert()
	race.transformations[transActive].revert(src)