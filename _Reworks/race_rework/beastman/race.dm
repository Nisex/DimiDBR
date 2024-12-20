race
	beastman
		name = "Beastman"
		desc = "Oops. You remember being human. So why do you have some beastlike features?"
		visual = 'Monstrous.png'

		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk,/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Ticking_Bomb)
		strength = 1.25
		endurance = 1.25
		force = 1.25
		offense = 1.25
		defense = 1.25
		speed = 1.25
		regeneration = 1.5
		intellect = 0.5

		onFinalization(mob/user)
			user.EnhancedSmell=1
			user.EnhancedHearing=1
			..()