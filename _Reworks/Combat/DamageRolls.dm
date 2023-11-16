var/global/min_damage_roll=0.3
var/global/upper_damage_roll=0.9
var/global/new_damage_calc = 0
/mob/Admin3/verb/Alter_Damage_Rolls()
	set category = "Admin Debug"
	var/newMin = input("Enter new minimum damage roll: ") as num
	if(newMin < 0.1)
		newMin = 0.1
	var/newMax = input("Enter new maximum damage roll: ") as num
	if(newMax < newMin)
		src<< "Maximum damage roll must be greater than minimum damage roll."
		return
	min_damage_roll = newMin
	upper_damage_roll = newMax
	src<< "Minimum damage roll set to [min_damage_roll] and maximum damage roll set to [upper_damage_roll]."


/mob/Admin3/verb/experimental_dmg()
	set category = "Admin Debug"
	var/input = input("Do you wanna turn on or off experimental dmg?") in list ("Yes", "No")
	switch(input)
		if("No")
			glob.DMG_CALC_2 = FALSE
			world<< "[SYSTEM]'s new DAMAGE FORMULA set to OFF[SYSTEMTEXTEND]"
		else
			glob.DMG_CALC_2 = TRUE
			world<< "[SYSTEM]'s new DAMAGE FORMULA set to ON[SYSTEMTEXTEND]"


proc/randValue(min,max,divider=10)
	return rand(min*divider,max*divider)/divider



/mob/proc/GetDamageMod(lowerMod, upperMod)
	var/min = min_damage_roll+lowerMod
	var/max = upper_damage_roll+upperMod
	var/obj/Items/Sword/s = src.EquippedSword()
	var/list/swordValues = list("Wooden"=0.05,"Light"=0.1,"Medium"=0.15,"Heavy"=0.2)
	if(UsingZornhau() || Saga=="Weapon Soul"&&SagaLevel>=1 && s)
		max += min_damage_roll / 2
	var/val = randValue(min,max)
	if(UsingZornhau() || Saga=="Weapon Soul"&&SagaLevel>=1 && s)
		if(!s)
			// this means they are in swordless
			val += 0.25 // let em eat
		else
			val += (0.1) + swordValues[s.Class]
	if(UsingKendo() && s.Class=="Wooden")
		val += 0.2
	val += Judgment && !Oozaru ? (min_damage_roll/2)*AscensionsAcquired : 0
	if(src.HasSteady())
		val += GetSteady()
	if(val >= upper_damage_roll)
		val = upper_damage_roll
	if(val <= min)
		val = min
	if(val > max)
		val = max
	return val