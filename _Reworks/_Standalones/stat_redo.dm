mob/var/stat_redoing = FALSE

mob/proc/stat_redo()
	stat_redoing = TRUE

	winshow(src,"Finalize_Screen",1)
	race.strength = race::strength
	race.endurance = race::endurance
	race.speed = race::speed
	race.force = race::force
	race.offense = race::offense
	race.defense = race::defense
	SetStatPoints(race.statPoints)
	SetStat("Power", race.power)
	SetStat("Strength", race.getStat("strength"))
	SetStat("Endurance", race.getStat("endurance"))
	SetStat("Speed", race.getStat("speed"))
	SetStat("Force", race.getStat("force"))
	SetStat("Offense", race.getStat("offense"))
	SetStat("Defense", race.getStat("defense"))
	src.UpdateBio()
	src.GetIncrements()
	race_selecting = FALSE

mob/Admin3/verb/Assign_Stat_Redo(mob/m in players)
	if(!m) return
	m << "You've been assigned a stat redo!"
	usr << "You've assigned [m] a stat redo!"
	m.stat_redo()