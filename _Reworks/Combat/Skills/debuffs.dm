/obj/Skills/Buffs/var/IconState = ""
/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff
	NeedsPassword = 1
	TimerLimit = 1
	Cooldown = 4
	AlwaysOn = 1
	LockX=0
	LockY=0
	var/max_stacks = 1
	var/total_stacks = 0
	Trigger(mob/User, Override)
		. = ..()
		if(User.BuffOn(src))
			// this fades off
			total_stacks = 0
	proc/do_effect()
	proc/add_stack(mob/p, mob/dealer)
		if(total_stacks + 1 < max_stacks)
			total_stacks++
			if(p.BuffOn(src))
				Trigger(p, TRUE)
			Trigger(p, TRUE)
		else
			// max stacks
			TimerLimit = 1
			do_effect(p, dealer)
			total_stacks = 0


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Snare
	AlwaysOn = 0
	NeedsPassword = 0
	passives = list("Snared" = 1)
	New(limit, icon)
		. = ..()
		TimerLimit = limit
		IconLock = icon
/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Soul_Drained
	TimerLimit = 30
	AlwaysOn = 0
	NeedsPassword = 0
	IconLock='drained.dmi'
	max_stacks = 4
	do_effect(mob/defender, mob/attacker)
		attacker.HealHealth(total_stacks * glob.racials.SOULDRAINHEAL)
		defender.LoseHealth((total_stacks * glob.racials.SOULDRAINHEAL)/2)
		OMsg(defender, "[attacker] drains [defender]'s life force.")

	adjust(mob/attacker)
		IconState = "[total_stacks]"
		TimerLimit = 25 + (5 * attacker.AscensionsAcquired)
		max_stacks = glob.racials.SOULDRAINMAX + attacker.AscensionsAcquired
		passives = list("Drained" = glob.racials.SOULDRAINPER * total_stacks)
	
/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Marked_Prey
	HealthDrain = 0.005
	TimerLimit = 30
	AlwaysOn = 0
	NeedsPassword = 0
	IconLock='marked.dmi'
	IconState = "1"
	max_stacks = 4

	do_effect(mob/defender, mob/attacker)
		var/obj/Skills/s = attacker.findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Beastman/Thrill_of_the_Hunt)
		s.adjust(attacker)
		s.Password = attacker.name
		OMsg(defender, "[attacker] starts to hunt [defender].")
		
	adjust(mob/attacker)
		IconState = num2text(total_stacks)
		TimerLimit = 25 + (5 * attacker.AscensionsAcquired)
		max_stacks = glob.racials.MARKEDPREYBASESTACKS + attacker.AscensionsAcquired
		endAdd = -glob.racials.MARKEDPREYENDREDUC * total_stacks
		passives = list("PureReduction" = -glob.racials.MARKEDPREYPURERED * total_stacks)



/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Rupture
	HealthDrain = 0.01
	TimerLimit = 25
	IconLock='Bleed.dmi'
	max_stacks = 3
	do_effect(mob/defender, mob/attacker)
		defender.LoseHealth(attacker.passive_handler["Rupture"] * glob.RUPTURE_BASE_DAMAGE)
		OMsg(defender, "[defender]'s wound fully ruptures, causing massive damage!")
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
		Stun(defender, 8, 1)
		defender.Shatter = glob.OVERHWELMING_SHATTER_APPLY
		OMsg(defender, "[defender] completely shuts down, becoming defenseless.")
	adjust(mob/p, mob/attacker)
		max_stacks = attacker.passive_handler["Overwhelming"]
		if(total_stacks > 2)
			IconState = 2
		else
			IconState = "[total_stacks]"
		passives = list("PureReduction" = -glob.OVERHWELMING_BASE_PR_NERF * total_stacks, "Flow" = -glob.OVERHWELMING_BASE_FLOW * total_stacks)
		endAdd = -glob.OVERHWELMING_BASE_END_NERF * total_stacks
		