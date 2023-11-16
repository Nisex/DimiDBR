/mob/proc/desperationCheck()
	var/bonus = 1
	if(Desperation && !HasInjuryImmune())
		// they are able to get the bonus
		bonus += Saga == "King of Braves" ? 0.25 : 0
		bonus += Race == "Human" ? 0.25 : 0
		return bonus
	return FALSE

/mob/proc/GetDesperationBonus(mob/defender)
	var/bonusRatio = desperationCheck()
	var/defBonusRatio = defender ? defender.desperationCheck() : 0
	var/atkVal = 0.1
	var/defVal = 0.05
	var/injuries = TotalInjury/100
	var/defInjuries = defender ? defender.TotalInjury/100 : 0
	. = 0
	if(bonusRatio)
		. +=  round(((atkVal * bonusRatio) * Desperation) * injuries, 0.01) * 10
	if(defBonusRatio)
		. -=  round(((defVal * defBonusRatio) * defender.Desperation) * defInjuries, 0.01) * 10
