mob/var/stat_redoing = FALSE

mob/proc/stat_redo()
	stat_redoing = TRUE

	winshow(src,"Finalize_Screen",1)
	SetStatPoints(race.statPoints)
	SetStat("Power", race.power)
	SetStat("Strength", race.strength)
	SetStat("Endurance", race.endurance)
	SetStat("Speed", race.speed)
	SetStat("Force", race.force)
	SetStat("Offense", race.offense)
	SetStat("Defense", race.defense)
	src.UpdateBio()
	for(var/obj/SavedStats/Z in src)
		del(Z)
	src.contents+=new/obj/SavedStats
	src.GetIncrements()
	race_selecting = FALSE

mob/Admin3/verb/Assign_Stat_Redo(mob/m in players)
	if(!m) return
	m << "You've been assigned a stat redo!"
	usr << "You've assigned [m] a stat redo!"
	m.stat_redo()