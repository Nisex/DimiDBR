spaceMaker
	var
		toDeath
		range
		configuration = "" /* Fill, Random */
		amount // if enabled only do this amount and back out after
		turfs = list() // the list of turfs that are altered
		stored_dmg_value = 1

	New(time2Death, area, config, num)
		toDeath = time2Death
		range = area
		configuration = config

	proc/getDmg(mob/p, obj/Skills/s)
		var/asc = p.AscensionsAcquired ? p.AscensionsAcquired : 1
		if("Adapt" in s?:scalingValues)
			if(p.GetStr(1) > p.GetFor(1))
				return p.GetStr(s?:scalingValues["Adapt"][asc])
			else
				return p.GetFor(s?:scalingValues["Adapt"][asc])
		else if("Force" in s?:scalingValues)
			return p.GetFor(s?:scalingValues["Force"][asc])
		else if("Strength" in s?:scalingValues)
			return p.GetFor(s?:scalingValues["Strength"][asc])
		world.log << "[p] messed up dmg calc on [src]"
		return 1

// init this, makes it flexible
	proc/makeSpace(mob/p, effect2Apply)
		turfs = list()
		world.log << "Making space at [p.x], [p.y], [p.z] with [effect2Apply]"
		var/correctLowerX = clamp(p.x - range,0 , world.maxx)
		var/correctLowerY = clamp(p.y - range,0 , world.maxy)
		var/correctUpperX = clamp(p.x + range,0 , world.maxx)
		var/correctUpperY = clamp(p.y + range,0 , world.maxy)
		var/list/openTurfs = list()
		for(var/turf/Turf in block(locate(correctLowerX, correctLowerY, p.z), locate(correctUpperX, correctUpperY, p.z)))
			openTurfs += Turf
		switch(configuration)
			if("Fill")
				var/totalApplied = 0
				for(var/turf/T in openTurfs)
					if(T in turfs)
						continue
					if(amount && totalApplied + 1 > amount)
						break
					turfs += T
					T.applyEffect(effect2Apply, toDeath, p)
					totalApplied++
			if("Random")
				// random would imply its limited
				world.log << "Randomly picking [amount] turfs"
				for(var/i = 0; i < amount; i++)
					var/turf/T = pick(openTurfs)
					//world<< "Picked [T] ([T.x], [T.y])  from [openTurfs]"
					if(T in turfs)
						continue
					turfs += T
					T.applyEffect(effect2Apply, toDeath, p)
// below we will commit crimes

	Constellation
		toDeath = 1200// 2 mins
		range = 6
		configuration = "Random"
		amount = 21
		New(toDeath, range, configuration, amount)
			src.toDeath = 1200
			src.range = 6
			src.configuration = "Random"
			src.amount = 18

	Demon
		configuration = "Fill"

	HellFire
		configuration = "Fill"




// turf proc

/turf/var/effectApplied
/turf/var/timeToDeath = 0
/turf/var/tmp/mob/ownerOfEffect
/turf/proc/applyEffect(option, timer, mob/p)
	timeToDeath = timer
	effectApplied = option // the "[]" is not needed, but maybe u passed a number who knows
	ticking_turfs += src
	ownerOfEffect = p
	if(isdatum(option))
		var/direction = pick("ew","ns")
		var/num = rand(1,15)
		var/image/i
		if(!option?:icon_to_use)
			i = image(icon = 'GalSpace.dmi', icon_state = "speedspace_[direction]_[num]")
		else
			i = image(icon = option?:icon_to_use)
		overlays+=i
		i.alpha = 0
		animate(i, alpha = 255, time = 10)
	else
		switch(option)
			if("Stellar")
				var/direction = pick("ew","ns")
				var/num = rand(1,15)
				var/image/i = image(icon = 'GalSpace.dmi', icon_state = "speedspace_[direction]_[num]")
				overlays+=i
				i.alpha = 0
				animate(i, alpha = 255, time = 10)



/turf/proc/removeEffect()
	effectApplied = 0
	timeToDeath = 0
	ticking_turfs -= src
	overlays = list()
	ownerOfEffect = null

/turf/Update()
	if(effectApplied) // the latter is assumed, for there's no way to get here unless it is in there, but just in case
		//world<<"[src] ticking [effectApplied] for [timeToDeath] ticks"
		timeToDeath--
		if(timeToDeath <= 0)
			removeEffect()
	else if(src in ticking_turfs && timeToDeath <= 0)
		removeEffect()