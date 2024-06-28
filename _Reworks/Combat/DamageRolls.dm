
var/global/new_damage_calc = 0

proc/randValue(min,max,divider=10)
	return rand(min*divider,max*divider)/divider



/mob/proc/GetDamageMod(lowerMod, upperMod)
	var/min = glob.min_damage_roll+lowerMod
	var/max = glob.upper_damage_roll+upperMod
	var/obj/Items/Sword/s = src.EquippedSword()
	var/list/swordValues = list("Wooden"=0.05,"Light"=0.1,"Medium"=0.15,"Heavy"=0.2)
	if(UsingZornhau())
		max += glob.min_damage_roll / 2
	var/val = randValue(min,max)
	if(UsingZornhau())
		if(!s)
			// this means they are in swordless
			val += 0.25 // let em eat
		else
			if(UsingKendo())
				val += (0.1) + 0.2
			else
				val += (0.1) + swordValues[s.Class]
	val += Judgment && !Oozaru ? (glob.min_damage_roll/2)*AscensionsAcquired : 0
	if(src.HasSteady())
		val += GetSteady()
	if(val >= glob.upper_damage_roll)
		val = glob.upper_damage_roll
	if(val <= min)
		val = min
	if(val > max)
		val = max
	return val