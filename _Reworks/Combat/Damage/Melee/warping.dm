/mob/proc/getWarpingStrike()
	. = 0
	if(AttackQueue && !AttackQueue.NoWarp)
		if(AttackQueue.Warp)
			if(!AttackQueue.InstantStrikes)
				. = AttackQueue.Warp
			else
				. = AttackQueue.Warp
				if(AttackQueue.InstantStrikesDelay<2)
					AttackQueue.NoWarp=1