// SPIRIT STRIKE - USE FORCE AS BASE


// HYBRID STRIKE - USE STR AS BASE AND DO FORCE (TICK%) EXTRA DAMAGE (MULTIPLICATIVE)
// SPIRIT HAND - USE STR AS BASE AND ADD TICK% FOR DAMAGE (ADDITIVE)
// SPIRIT SWORD - USE STR AS BASE AND ADD TICK% FOR DAMAGE (ADDITIVE)


/mob/Admin3/verb/tryExperminetalAccuracy()
	var/accuracy = input(src, "On/Off") in list("On", "Off")
	switch(accuracy)
		if("On")
			EXPERIMENTAL_ACCURACY = TRUE
			world<< "[SYSTEM] Experimental Accuracy is now [accuracy][SYSTEMTEXTEND]]"
		if("Off")
			EXPERIMENTAL_ACCURACY = FALSE
			world<< "[SYSTEM] Experimental Accuracy is now [accuracy][SYSTEMTEXTEND]]"


/mob/Admin3/verb/changeEffectiveness()
	switch(input(src, "What one?") in list("Strength", "Force", "Endurance", "Strength Overcap", "Strength Threshold", "str2", "end2", "power2", "Melee", "Projectile", "Grapple", "Autohit"))
		if("Strength")
			glob.STRENGTH_EFFECTIVENESS = input(src, "What value?") as num
			world<< "[SYSTEM] Strength Effectiveness set to [glob.STRENGTH_EFFECTIVENESS][SYSTEMTEXTEND]]"
		if("Force")
			glob.FORCE_EFFECTIVENESS = input(src, "What value?") as num
			world<< "[SYSTEM] Force Effectiveness set to [glob.FORCE_EFFECTIVENESS][SYSTEMTEXTEND]]"
		if("Endurance")
			glob.END_EFFECTIVENESS = input(src, "What value?") as num
			world<< "[SYSTEM] Endurance Effectiveness set to [glob.END_EFFECTIVENESS][SYSTEMTEXTEND]]"
		if("str2")
			glob.DMG_STR_EXPONENT = input(src, "What value?") as num
			world<< "[SYSTEM] DMG2 Strength effectiveness set to [glob.DMG_STR_EXPONENT][SYSTEMTEXTEND]]"
		if("end2")
			glob.DMG_END_EXPONENT = input(src, "What value?") as num
			world<< "[SYSTEM] DMG2 End effectiveness set to [glob.DMG_END_EXPONENT][SYSTEMTEXTEND]]"
		if("power2")
			glob.DMG_POWER_EXPONENT = input(src, "What value?") as num
			world<< "[SYSTEM] DMG2 Power effectiveness set to [glob.DMG_POWER_EXPONENT][SYSTEMTEXTEND]]"
		if("Melee")
			glob.MELEE_EFFECTIVENESS = input(src, "What value?") as num
			world<< "[SYSTEM] Melee effectiveness set to [glob.MELEE_EFFECTIVENESS][SYSTEMTEXTEND]]"
		if("Projectile")
			glob.PROJECTILE_EFFECTIVNESS = input(src, "What value?") as num
			world<< "[SYSTEM] Projectile effectiveness set to [glob.PROJECTILE_EFFECTIVNESS][SYSTEMTEXTEND]]"
		if("Grapple")
			glob.GRAPPLE_EFFECTIVNESS = input(src, "What value?") as num
			world<< "[SYSTEM] Grapple effectiveness set to [glob.GRAPPLE_EFFECTIVNESS][SYSTEMTEXTEND]]"
		if("Autohit")
			glob.AUTOHIT_EFFECTIVNESS = input(src, "What value?") as num
			world<< "[SYSTEM] Autohit effectiveness set to [glob.AUTOHIT_EFFECTIVNESS][SYSTEMTEXTEND]]"




/mob/proc/getStatDmg2(damage, unarmed, sword, sunlight, spirithand)
	// ABILITY and DAMAGE roll should be first
	// so a queue should happen here vs later
	if(!unarmed&&!sword)
		if(EquippedSword())
			sword = 1
		else
			unarmed = 1
	var/statDamage
	if(passive_handler.Get("HardenedFrame"))
		statDamage = GetEnd(glob.END_EFFECTIVENESS)
	else if(HasSpiritStrike())
		statDamage = GetFor(glob.FORCE_EFFECTIVENESS)
	else
		statDamage = GetStr(glob.STRENGTH_EFFECTIVENESS)
	var/endExtra = passive_handler.Get("CallousedHands")
	if(endExtra>0)
		statDamage += GetEnd(endExtra) // will be intervals of 0.15
	if(HasSpiritHand()&&unarmed)
		statDamage += GetFor(GetSpiritHand()/4) // this always returns 1
		//TODO make spirit hand scale
	if(HasSpiritSword()&&sword)
		statDamage += GetFor(GetSpiritSword())
	if(HasHybridStrike())
		statDamage *=  1 + (GetFor(GetHybridStrike())/10)
	return statDamage


/mob/proc/getEndStat(n)
	return GetEnd(n)





/mob/Admin4/verb/WhosAscended()
	for(var/mob/x in players)
		if(x.AscensionsUnlocked>0)
			src<<"[x] has [x.AscensionsUnlocked] Ascensions Unlocked!"

/*



if(src.UsingSunlight()||src.HasSpiritHand()&&(UnarmedAttack||SwordAttack))
		var/forModifier = 1
		if(src.StyleActive!="Sunlight"&&src.StyleActive!="Moonlight"&&src.StyleActive!="Atomic Karate"&&!src.CheckSpecial("Prana Burst"))
			forModifier = GetFor()**(1/2)
			Damage *= 1 + ((src.GetStr()*forModifier)/10)
		else
			forModifier = clamp(src.GetFor(0.5), 1.25, 2)
			Damage*= 1 + ((src.GetStr()*forModifier)/10)
	else if(SwordAttack&&src.HasSpiritSword())
		var/str = src.GetStr(src.GetSpiritSword())
		var/force = src.GetFor(src.GetSpiritSword())
		Damage*= 1 + ((str+force) / 10 )
	else if(src.HasHybridStrike())
		var/str = src.GetStr()
		var/force = src.GetFor(src.GetHybridStrike())
		Damage*= 1 + ((str+force) / 10)
	else if(src.HasSpiritStrike())
		Damage*= 1 + (src.GetFor() /10 )
	else
		Damage*= 1 + (src.GetStr() / 10)


*/