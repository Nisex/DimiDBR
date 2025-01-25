
var/global/new_damage_calc = 0

proc/randValue(min,max,divider=10)
	return rand(min*divider,max*divider)/divider



/mob/proc/GetDamageMod(lowerMod, upperMod)
	var/min = glob.min_damage_roll+lowerMod
	var/max = glob.upper_damage_roll+upperMod
	var/obj/Items/Sword/s = src.EquippedSword()
	var/list/swordValues = list("Wooden"=0.05,"Light"=0.075,"Medium"=0.125,"Heavy"=0.15)
	if(UsingZornhau())
		var/zorn = UsingZornhau()
		min += (glob.min_damage_roll/4) * zorn 
	var/val = randValue(min,max)
	if(UsingZornhau())
		if(!s)
			// this means they are in swordless
			val += 0.2 // let em eat
		else
			if(UsingKendo())
				val += (0.05) + 0.15
			else
				val += (0.05) + swordValues[s.Class]
	val += Judgment && !Oozaru ? (glob.min_damage_roll/2)*AscensionsAcquired : 0
	if(src.HasSteady())
		val += GetSteady()
		if(passive_handler["Zornhau"] && Target)
			var/zorn = 0 
			if(Target.equippedArmor)
				zorn = (passive_handler["Zornhau"] * 2)
			else
				zorn = passive_handler["Zornhau"]
			zorn *= glob.STEADY_MODIFIER
	var/negate = 0
	if(src.Target)
		negate = GetUnnvere() * (glob.STEADY_MODIFIER)
	val-=negate
	if(val >= glob.upper_damage_roll)
		val = glob.upper_damage_roll
	if(val <= min)
		val = min
	if(val > max)
		val = max
	return val

/mob/proc/GetUnnvere()
	var/total = passive_handler.Get("Unnerve")
	if(HasLegendaryPower())
		total+=HasLegendaryPower()*2
	return total