/mob/proc/getInfactuation(mob/defender)
	for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/buff in src)
		if(buff.Infatuated&&buff.Password==defender)
			return 1+buff.Infatuated
	return 1
/mob/proc/getCritAndBlock(mob/defender, damage)
	if(prob(CriticalChance)&&CriticalDamage&&StandardBiology())
		damage *= 1+passive_handler.Get("CriticalDamage")
	if(prob(defender.BlockChance)&&defender.CriticalBlock)
		damage /= 1+defender.passive_handler.Get("CriticalBlock")
	return damage