/mob/proc/getInfactuation(mob/defender)
	for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/buff in src)
		if(buff.Infatuated&&buff.Password==defender)
			return 1+buff.Infatuated
	return 1
/mob/proc/getCritAndBlock(mob/defender, damage)
	var/critChance = passive_handler.Get("CriticalChance")
	var/blockChance = defender.passive_handler.Get("CriticalBlock")
	var/critDMG = passive_handler.Get("CriticalDamage")
	var/critBlock = passive_handler.Get("CriticalBlock")
	if(UsingMartialStyle())
		critChance += 5
		critDMG += 0.1
	if(defender.UsingMartialStyle())
		blockChance += 5
		critBlock += 0.1
	if(UsingMasteredMartialStyle())
		critChance += 5
		critDMG += 0.1
	if(defender.UsingMasteredMartialStyle())
		blockChance += 5
		critBlock += 0.1
	if(prob(critChance)) 
		damage *= 1+critDMG
	if(prob(blockChance))
		damage /= 1+critBlock
	return damage