/obj/Skills/Buffs/var/IconState
/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff
	NeedsPassword = 1
	TimerLimit = 1
	Cooldown = 4
	AlwaysOn = 1
	var/max_stacks = 1
	var/total_stacks = 0
	proc/do_effect()
	proc/add_stack(mob/p, mob/dealer)
		if(total_stacks + 1 < max_stacks)
			total_stacks++
			Trigger(p, TRUE)
			adjust(p)
			Trigger(p, TRUE)
		else
			// max stacks
			TimerLimit = 1
			do_effect(p, dealer)
			total_stacks = 0


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Snare
	AlwaysOn = 0
	NeedsPassword = 0
	New(limit, icon)
		. = ..()
		TimerLimit = limit
		IconLock = icon
	
	


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Rupture
	HealthDrain = 0.01
	TimerLimit = 25
	IconLock='Bleed.dmi'
	max_stacks = 3
	do_effect(mob/defender, mob/attacker)
		defender.LoseHealth(attacker.passive_handler["Rupture"] * glob.RUPTURE_BASE_DAMAGE)
	adjust(mob/p)
		switch(total_stacks)
			if(1)
				IconState = "1"
				HealthDrain = 0.025
				ShearAffected = 1
			if(2)
				IconState = "2"
				HealthDrain = 0.05
				ShearAffected = 2
				CrippleAffected = 2

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Cornered
	passives = list("PureReduction" = 0.05, "Flow" = -0.1)
	TimerLimit = 10
	IconLock='Cornered.dmi'
	do_effect(mob/defender, mob/attacker)
		Stun(defender, 8)
		defender.Shatter = glob.OVERHWELMING_SHATTER_APPLY
	adjust(mob/p, mob/attacker)
		max_stacks = attacker.passive_handler["Overwhelming"]
		if(total_stacks > 2)
			IconState = 2
		else
			IconState = "[total_stacks]"
		passives = list("PureReduction" = -glob.OVERHWELMING_BASE_PR_NERF * total_stacks, "Flow" = -glob.OVERHWELMING_BASE_FLOW * total_stacks)
		endAdd = -glob.OVERHWELMING_BASE_END_NERF * total_stacks
		