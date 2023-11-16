/mob/proc/getInfactuation(mob/defender)
	for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/buff in src)
		if(buff.Infatuated&&buff.Password==defender)
			return 1+buff.Infatuated
	return 1
/mob/proc/getCritAndBlock(mob/defender, damage)
	if(prob(CriticalChance)&&CriticalDamage&&StandardBiology())
		damage *= CriticalDamage
	if(prob(defender.BlockChance)&&defender.CriticalBlock)
		damage /= defender.CriticalBlock
	return damage