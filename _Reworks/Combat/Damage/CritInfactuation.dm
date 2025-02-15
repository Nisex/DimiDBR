/mob/proc/getInfactuation(mob/defender)
	for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/buff in src)
		if(buff.passives["Infatuated"]&&buff.Password == defender?:UniqueID)
			return 1+buff.passives["Infatuated"]
	return 1
/mob/proc/getCritAndBlock(mob/defender, damage)
	var/critChance = passive_handler.Get("CriticalChance")
	var/critDMG = passive_handler.Get("CriticalDamage")
	var/blockChance = 0
	var/critBlock = 0
	if(defender)
		blockChance = defender.passive_handler.Get("BlockChance")
		critBlock = defender.passive_handler.Get("CriticalBlock")
	if(UsingMartialStyle())
		critChance += 5
		critDMG += 0.1
	if(defender)
		if(defender.UsingMartialStyle())
			blockChance += 5
			critBlock += 0.1
		if(defender.UsingMasteredMartialStyle())
			blockChance += 5
			critBlock += 0.1
	if(UsingMasteredMartialStyle())
		critChance += 5
		critDMG += 0.1
	if(prob(critChance)) 
		if(passive_handler["ThunderHerald"])
			world<<"DEBUG: thunder herald proc"
			var/obj/Skills/s = findOrAddSkill(/obj/Skills/AutoHit/Thunder_Bolt)
			s.adjust(src)
			Activate(s)
		if(passive_handler["IceHerald"])
			world<<"DEBUG: ice herald proc"
			var/obj/Skills/s = findOrAddSkill(/obj/Skills/AutoHit/Icy_Wind)
			s.adjust(src)
			Activate(s)
		damage *= 1+critDMG
	if(prob(blockChance))
		damage /= 1+critBlock
	return damage