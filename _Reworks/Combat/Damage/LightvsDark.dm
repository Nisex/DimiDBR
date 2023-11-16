/mob/proc/getEleEffective(swordEle, atomicFist, demon)
    var/effective = 1.5
    if(swordEle)
        effective *= 0.75
    if(atomicFist)
        effective *= 2
    if(demon)
        effective += AscensionsAcquired
    return effective



// TESTED
/mob/proc/getLightDarkCalc(option, mob/d)
	. = 0
	var/direFist = UsingDireFist()
	var/darkSword = UsingDarkElementSword()
	var/atomicFist = UsingAtomicFist()
	var/demon = (Race == "Demon")
	var/tranqFist = UsingTranquilFist()
	var/lightSword = UsingLightElementSword()
	switch(option)
		if("Offense")
			var/hasDarkOff = (direFist || darkSword || ElementalOffense == "Dark" || demon)
			if(hasDarkOff)
				var/effective = getEleEffective(darkSword, atomicFist, demon)
				if(effective > 0 && Anger)
					. += effective
				if(demon && !Anger)
					. += (effective / 2)
			var/hasLightOff = (tranqFist || lightSword || ElementalOffense == "Light")
			if(!demon && hasLightOff)
				var/effective = getEleEffective(lightSword, atomicFist, demon)
				if(effective > 0 && (d.Anger || d.AngerCD))
					. += effective
		if("Defense")
			var/hasDarkDef = (direFist || darkSword || ElementalDefense == "Dark" || demon)
			if(hasDarkDef)
				var/effective = getEleEffective(darkSword, atomicFist, demon)
				if(effective > 0 && Anger)
					. -= effective
				if(demon && !Anger)
					. -= (effective / 2)
			var/hasLightDef = (tranqFist || lightSword || ElementalDefense == "Light")
			if(!demon && hasLightDef)
				var/effective = getEleEffective(lightSword, atomicFist, demon)
				if(effective > 0 && (Anger || AngerCD))
					. -= effective
