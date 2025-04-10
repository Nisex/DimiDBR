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
	var/martialStyle = usingStyle("UnarmedStyle")
	var/defenderMartialStyle = defender.usingStyle("UnarmedStyle")
	if(martialStyle)
		critChance += 5 + (2.5 * StyleBuff.SignatureTechnique)
		critDMG += 0.05 + (0.05 * StyleBuff.SignatureTechnique)
		if(Saga && SagaLevel)
			critChance += 5 + (2.5 * SagaLevel)
			critDMG += 0.1 + (0.05 * SagaLevel)
	if(defender)
		if(defenderMartialStyle)
			blockChance += 5 + (5 * defender.StyleBuff.SignatureTechnique)
			critBlock += 0.05 + (0.05 * defender.StyleBuff.SignatureTechnique)
			if(Saga && SagaLevel)
				blockChance += 5 + (2.5 * defender.SagaLevel)
				critBlock += 0.1 + (0.05 * defender.SagaLevel)
	if(prob(critChance)) 
		if(!AttackQueue)
			if(passive_handler["ThunderHerald"])
				var/obj/Skills/s = findOrAddSkill(/obj/Skills/AutoHit/Thunder_Bolt)
				s.adjust(src)
				Activate(s)
			if(passive_handler["IceHerald"])
				var/obj/Skills/s = findOrAddSkill(/obj/Skills/AutoHit/Icy_Wind)
				s.adjust(src)
				Activate(s)
			if(passive_handler["DemonicInfusion"])
				var/obj/Skills/s = findOrAddSkill(/obj/Skills/AutoHit/HellfireRain)
				s.adjust(src)
				Activate(s)
		damage *= 1+critDMG
	if(prob(blockChance))
		damage /= 1+critBlock
	return damage