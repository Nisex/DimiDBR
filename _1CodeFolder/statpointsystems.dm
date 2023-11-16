mob/proc/Stats(var/blah)

//Civilized
	if(blah=="Human")
		SetStat("Power",1)
		SetStat("Strength",1)
		SetStat("Endurance",1)
		SetStat("Speed",1)
		SetStat("Force",1)
		SetStat("Offense",1)
		SetStat("Defense",1)
		SetStat("Regeneration",1)
		SetStat("Recovery",1)
		SetStat("Anger",1.2)
		SetStat("Learning",1.5)
		SetStat("Intellect",1)
		SetStat("Imagination",1)

	else if(blah=="Makyo")
		SetStat("Power",2)
		SetStat("Strength",1.5)
		SetStat("Endurance",1.5)
		SetStat("Speed",1)
		SetStat("Force",1.25)
		SetStat("Offense",1)
		SetStat("Defense",1)
		SetStat("Regeneration",1)
		SetStat("Recovery",1)
		SetStat("Anger",1.5)
		SetStat("Learning",1)
		SetStat("Intellect",1)
		SetStat("Imagination",2)

	else if(blah=="Namekian")
		if(src.Class=="Warrior")
			SetStat("Power",2)
			SetStat("Strength",1.5)
			SetStat("Endurance",0.75)
			SetStat("Speed",1.5)
			SetStat("Force",1.75)
			SetStat("Offense",1.25)
			SetStat("Defense",1.5)
			SetStat("Regeneration",2)
			SetStat("Recovery",2)
			SetStat("Anger",1.25)
			SetStat("Learning",1)
			SetStat("Intellect",1.5)
			SetStat("Imagination",1)

		else if(src.Class=="Dragon")
			SetStat("Power",1)
			SetStat("Strength",1)
			SetStat("Endurance",0.75)
			SetStat("Speed",1.25)
			SetStat("Force",1.5)
			SetStat("Offense",1)
			SetStat("Defense",1.25)
			SetStat("Regeneration",1.5)
			SetStat("Recovery",2)
			SetStat("Anger",1.25)
			SetStat("Learning",1)
			SetStat("Intellect",1.5)
			SetStat("Imagination",2.5)

	else if(blah=="Half Saiyan")
		SetStat("Power",2)
		SetStat("Strength",1)
		SetStat("Endurance",1)
		SetStat("Speed",1)
		SetStat("Force",1)
		SetStat("Offense",1)
		SetStat("Defense",1)
		SetStat("Recovery",1.25)
		SetStat("Anger",1.25)
		SetStat("Learning",1.25)
		SetStat("Intellect",1)
		SetStat("Imagination",1)



//Savage
	else if(blah=="Saiyan")
		SetStat("Power",2)
		SetStat("Strength",1.5)
		SetStat("Endurance",1.5)
		SetStat("Speed",1)
		SetStat("Force",1.25)
		SetStat("Offense",1)
		SetStat("Defense",0.75)
		SetStat("Regeneration",1.5)
		SetStat("Recovery",2)
		SetStat("Anger",1.5)
		SetStat("Learning",1)
		SetStat("Intellect",1)
		SetStat("Imagination",0.5)

	else if(blah=="Tuffle")
		SetStat("Power",1)
		SetStat("Strength",1.5)
		SetStat("Endurance",0.75)
		SetStat("Speed",1.25)
		SetStat("Force",1.5)
		SetStat("Offense",2)
		SetStat("Defense",1.5)
		SetStat("Regeneration",1)
		SetStat("Recovery",1.5)
		SetStat("Anger",1.25)
		SetStat("Learning",1)
		SetStat("Intellect",2)
		SetStat("Imagination",0.5)

	else if(blah=="Alien")
		SetStat("Power",1)
		SetStat("Strength",0.5)
		SetStat("Endurance",0.5)
		SetStat("Speed",0.5)
		SetStat("Force",0.5)
		SetStat("Offense",0.5)
		SetStat("Defense",0.5)
		SetStat("Regeneration",1.5)
		SetStat("Recovery",1.5)
		SetStat("Anger",1.5)
		SetStat("Learning",1)
		SetStat("Intellect",1)
		SetStat("Imagination",1)

	else if(blah=="Monster")//All have 2 bp
		SetStat("Power",2)
		if(Class=="Beastmen")
			SetStat("Strength",1.25)
			SetStat("Endurance",1.25)
			SetStat("Speed",1.25)
			SetStat("Force",1.25)
			SetStat("Offense",1.25)
			SetStat("Defense",1.25)
			SetStat("Regeneration",1.5)
			SetStat("Recovery",2)
			SetStat("Anger",1.5)
			SetStat("Learning",1)
			SetStat("Intellect",0.5)
			SetStat("Imagination",1)

		if(Class=="Yokai")
			SetStat("Strength",2)
			SetStat("Endurance",1.5)
			SetStat("Speed",1)
			SetStat("Force",0.5)
			SetStat("Offense",1.25)
			SetStat("Defense",1)
			SetStat("Regeneration",2)
			SetStat("Recovery",2)
			SetStat("Anger",1.5)
			SetStat("Learning",1)
			SetStat("Intellect",1)
			SetStat("Imagination",1.5)

		if(Class=="Eldritch")
			SetStat("Strength",1.5)
			SetStat("Endurance",2)
			SetStat("Speed",1)
			SetStat("Force",1)
			SetStat("Offense",2)
			SetStat("Defense",2)
			SetStat("Regeneration",2.5)
			SetStat("Recovery",1)
			SetStat("Anger",1)
			SetStat("Learning",1)
			SetStat("Intellect",1.5)
			SetStat("Imagination",(1/1.5))

	else if(blah=="Changeling")
		SetStat("Power",5)
		SetStat("Strength",0.75)
		SetStat("Endurance",2)
		SetStat("Speed",1.5)
		SetStat("Force",1.25)
		SetStat("Offense",1)
		SetStat("Defense",1.5)
		SetStat("Regeneration",2)
		SetStat("Recovery",2)
		SetStat("Anger",1)
		SetStat("Learning",1)
		SetStat("Intellect",1.5)
		SetStat("Imagination",0.5)

//OFFWORLD
	else if(blah=="Shinjin")
		SetStat("Power",1)
		if(Class=="South")
			SetStat("Strength",1.5)
			SetStat("Endurance",0.5)
			SetStat("Speed",1.5)
			SetStat("Force",1.5)
			SetStat("Offense",1.5)
			SetStat("Defense",1)
			SetStat("Regeneration",1)
			SetStat("Recovery",2)
			SetStat("Anger",1.5)
			SetStat("Learning",1)
			SetStat("Intellect",2)
			SetStat("Imagination",1)

		if(Class=="East")
			SetStat("Strength",1)
			SetStat("Endurance",1.5)
			SetStat("Speed",1.5)
			SetStat("Force",1)
			SetStat("Offense",1)
			SetStat("Defense",1.5)
			SetStat("Regeneration",1)
			SetStat("Recovery",2)
			SetStat("Anger",1.5)
			SetStat("Learning",1)
			SetStat("Intellect",2)
			SetStat("Imagination",1)

		if(Class=="North")
			SetStat("Strength",1.5)
			SetStat("Endurance",1.75)
			SetStat("Speed",1.5)
			SetStat("Force",1.25)
			SetStat("Offense",1)
			SetStat("Defense",0.5)
			SetStat("Regeneration",1)
			SetStat("Recovery",2)
			SetStat("Anger",1.5)
			SetStat("Learning",1)
			SetStat("Intellect",2)
			SetStat("Imagination",1)

		if(Class=="West")
			SetStat("Strength",0.5)
			SetStat("Endurance",1.5)
			SetStat("Speed",1.5)
			SetStat("Force",1.5)
			SetStat("Offense",1.25)
			SetStat("Defense",1.25)
			SetStat("Regeneration",1)
			SetStat("Recovery",2)
			SetStat("Anger",1.5)
			SetStat("Learning",1)
			SetStat("Intellect",2)
			SetStat("Imagination",1)


	else if(blah=="Demon")
		SetStat("Power",5)
		SetStat("Strength",1.5)
		SetStat("Endurance",1.5)
		SetStat("Speed",1.5)
		SetStat("Force",1.5)
		SetStat("Offense",2)
		SetStat("Defense",1.5)
		SetStat("Regeneration",3)
		SetStat("Recovery",1)
		SetStat("Anger",2)
		SetStat("Learning",1)
		SetStat("Intellect",1)
		SetStat("Imagination",2)

	else if(blah=="Dragon")
		SetStat("Power",5)
		SetStat("Strength",1)
		SetStat("Endurance",2)
		SetStat("Speed",2)
		SetStat("Force",1)
		SetStat("Offense",2)
		SetStat("Defense",2)
		SetStat("Regeneration",3)
		SetStat("Recovery",3)
		SetStat("Anger",2)
		SetStat("Learning",1)
		SetStat("Intellect",1.5)
		SetStat("Imagination",1)


//CREATED
	else if(blah=="Android")
		SetStat("Power",3)
		SetStat("Strength",0.5)
		SetStat("Endurance",0.5)
		SetStat("Speed",0.5)
		SetStat("Force",0.5)
		SetStat("Offense",0.5)
		SetStat("Defense",0.5)
		SetStat("Regeneration",1)
		SetStat("Recovery",2)
		SetStat("Anger",1)
		SetStat("Learning",1)
		SetStat("Intellect",2)
		SetStat("Imagination",0)

	else if(blah=="Majin")
		SetStat("Power", 2)
		switch(Class)
			if("Innocent")
				SetStat("Strength", 1.25)
				SetStat("Endurance", 1.5)
				SetStat("Speed", 0.75)
				SetStat("Force", 1)
				SetStat("Offense", 1)
				SetStat("Defense", 1.25)
				SetStat("Regeneration", 3)
				SetStat("Recovery", 2)
				SetStat("Anger", 1.3)
				SetStat("Learning", 1)
				SetStat("Intellect", 0.25)
				SetStat("Imagination", 4)
			if("Super")
				SetStat("Strength", 1.25)
				SetStat("Endurance", 1)
				SetStat("Speed", 1)
				SetStat("Force", 1.25)
				SetStat("Offense", 1.25)
				SetStat("Defense", 1.25)
				SetStat("Regeneration", 3)
				SetStat("Recovery", 2)
				SetStat("Anger", 1.3)
				SetStat("Learning", 1)
				SetStat("Intellect", 0.25)
				SetStat("Imagination", 4)
			if("Unhinged")
				SetStat("Strength", 1.25)
				SetStat("Endurance", 0.75)
				SetStat("Speed", 1.25)
				SetStat("Force", 1)
				SetStat("Offense", 1.25)
				SetStat("Defense", 0.75)
				SetStat("Regeneration", 3)
				SetStat("Recovery", 2)
				SetStat("Anger", 1.3)
				SetStat("Learning", 1)
				SetStat("Intellect", 0.25)
				SetStat("Imagination", 4)


mob/proc/RacialStats()
	for(var/obj/SavedStats/Z in src)
		del(Z)
	src.ResetStats()
	src.contents+=new/obj/SavedStats
	Stats("[usr.Race]")
	SetStatPoints(10)
	src.GetIncrements()


mob/verb/Skill_Points(type as text,skill as text)
	set name=".Skill_Points"
	set hidden=1
	if(!(world.time > verb_delay)) return
	verb_delay=world.time+1
	if(race_selecting) return
	var/Increase=1
	if(!(skill in list("Strength","Endurance","Force","Offense","Defense","Speed")))return
	if(type=="-")
		if(Points==Max_Points) return
		Increase=-1
	if(type=="+")
		Increase=1
		if(Points==0) return

	if(locate(/obj/SavedStats) in usr)
		for(var/obj/SavedStats/Z in src.contents)
			if(Z.BaseStatsSet == 0)
				Z.StrengthBaseStat = Z.StrengthModGain*10
				Z.EnduranceBaseStat = Z.EnduranceModGain*10
				Z.SpeedBaseStat = Z.SpeedModGain*10
				Z.ForceBaseStat = Z.ForceModGain*10
				Z.OffenseBaseStat = Z.OffenseModGain*10
				Z.DefenseBaseStat = Z.DefenseModGain*10
				Z.BaseStatsSet = 1
			var/StrengthMin=Z.StrengthModGain*10
			var/EnduranceMin=Z.EnduranceModGain*10
			var/SpeedMin=Z.SpeedModGain*10
			var/ForceMin=Z.ForceModGain*10
			var/OffenseMin=Z.OffenseModGain*10
			var/DefenseMin=Z.DefenseModGain*10
			var/PowerValue=0.25
			if(src.Race=="Alien"||src.Race=="Android"/* || "Majin"*/)
				PowerValue=0.75
			switch(skill)
				if("Strength")
					if(type=="-") if(StrMod<=StrengthMin)return
					Z.StrengthModPoints += Increase
					if(Z.StrengthModPoints == 0)
						StrMod = Z.StrengthBaseStat
					else
						StrMod =  round(Z.StrengthBaseStat + ( Z.StrengthModPoints * PowerValue ), 0.01)
					winset(src,"[skill]","text=[StrMod]")
				if("Endurance")
					if(type=="-") if(EndMod<=EnduranceMin)return
					Z.EnduranceModPoints += Increase
					if(Z.EnduranceModPoints == 0)
						EndMod = Z.EnduranceBaseStat
					else
						EndMod =  round(Z.EnduranceBaseStat + ( Z.EnduranceModPoints * PowerValue ), 0.01)
					winset(src,"[skill]","text=[EndMod]")
				if("Speed")
					if(type=="-") if(SpdMod<=SpeedMin)return
					Z.SpeedModPoints += Increase
					if(Z.SpeedModPoints == 0)
						SpdMod = Z.SpeedBaseStat
					else
						SpdMod =  round(Z.SpeedBaseStat + ( Z.SpeedModPoints * PowerValue ), 0.01)
					winset(src,"[skill]","text=[SpdMod]")
				if("Force")
					if(type=="-") if(ForMod<=ForceMin)return
					Z.ForceModPoints += Increase
					if(Z.ForceModPoints == 0)
						ForMod = Z.ForceBaseStat
					else
						ForMod =  round(Z.ForceBaseStat + ( Z.ForceModPoints * PowerValue ), 0.01)
					winset(src,"[skill]","text=[ForMod]")
				if("Offense")
					if(type=="-") if(OffMod<=OffenseMin)return
					Z.OffenseModPoints += Increase
					if(Z.OffenseModPoints == 0)
						OffMod = Z.OffenseBaseStat
					else
						OffMod =  round(Z.OffenseBaseStat + ( Z.OffenseModPoints * PowerValue ), 0.01)
					winset(src,"[skill]","text=[OffMod]")
				if("Defense")
					if(type=="-") if(DefMod<=DefenseMin)return
					Z.DefenseModPoints += Increase
					if(Z.DefenseModPoints == 0)
						DefMod = Z.DefenseBaseStat
					else
						DefMod =  round(Z.DefenseBaseStat + ( Z.DefenseModPoints * PowerValue ), 0.01)
					winset(src,"[skill]","text=[DefMod]")
				if("Energy")
					return
				if("Regeneration")
					return
				if("Recovery")
					return
				if("Anger")
					return
			Points-=Increase
			winset(src,"Points Remaining","text=[Points]")

obj/Redo_Stats
	var LoginUse
	proc/RedoStats(mob/m)
		m.Redo_Stats()
		del src
	verb/Redo_Stats()
		set category="Other"
		RedoStats(usr)


proc/Define_Average(var/i=1)
	if(i<1)
		return "Low"
	else if(i>=1&&i<1.5)
		return "Average"
	else if(i>=1.5&&i<2)
		return "High"
	else if(i>=2&&i<2.5)
		return "Genius"
	else if(i>=2.5)
		return "Absurd"

mob/proc/Redo_Stats()
	set category="Other"
	Redoing_Stats=1
	ResetStats()
	RacialStats()
	UpdateBio()
	var/mob/Creation/C = new
	C.NextStep2(src)
	del C


mob/proc/ResetStats()
	StrMod=1
	EndMod=1
	ForMod=1
	SpdMod=1
	OffMod=1
	DefMod=1

mob/proc/PerkDisplay()
	winset(src,"Points Remaining","text=[Points]")
	winset(src,"RaceBP","text=\"[Define_Average(PotentialRate)] Power Rate\"")
	winset(src,"Race RPP","text=\"[Define_Average(RPPMult)] Learning Rate\"")
	winset(src,"Race Intellect", "text=\"[Define_Average(Intelligence)] Intellect\"")
	winset(src,"Race Imagination", "text=\"[Define_Average(Intelligence*Imagination)] Enchanting\"")
	winset(src,"Strength","text=[StrMod]")
	winset(src,"Endurance","text=[EndMod]")
	winset(src,"Speed","text=[SpdMod]")
	winset(src,"Force","text=[ForMod]")
	winset(src,"Offense","text=[OffMod]")
	winset(src,"Defense","text=[DefMod]")
	winset(src,"Recovery","text=[RecovMod]")
	winset(src,"Anger","text=[AngerMax*100]%")

mob/proc/SetStatPoints(Amount=0)
	src.Points=Amount
	src.Max_Points=Amount


mob/proc/GetIncrements()
	for(var/obj/SavedStats/Z in src.contents)
		Z.StrengthModGain=StrMod/10
		Z.EnduranceModGain=EndMod/10
		Z.ForceModGain=ForMod/10
		Z.SpeedModGain=SpdMod/10
		Z.OffenseModGain=OffMod/10
		Z.DefenseModGain=DefMod/10


mob/var/tmp/Redoing_Stats
mob/var/tmp/Points=0
mob/var/tmp/Max_Points=10

obj/SavedStats
	var
		BaseStatsSet = 0
		StrengthBaseStat = 0
		EnduranceBaseStat = 0
		SpeedBaseStat = 0
		ForceBaseStat = 0
		OffenseBaseStat = 0
		DefenseBaseStat = 0

		StrengthModPoints = 0
		EnduranceModPoints = 0
		SpeedModPoints = 0
		ForceModPoints = 0
		ResistanceModPoints = 0
		OffenseModPoints = 0
		DefenseModPoints = 0

		StrengthModGain=1
		EnduranceModGain=1
		SpeedModGain=1
		ForceModGain=1
		ResistanceModGain=1
		OffenseModGain=1
		DefenseModGain=1


mob/proc/SetStat(Stat,Amount=1)
	if(Stat=="Power")
		PotentialRate=Amount
	if(Stat=="Speed")
		SpdMod=Amount
	if(Stat=="Strength")
		StrMod=Amount
	if(Stat=="Endurance")
		EndMod=Amount
	if(Stat=="Force")
		ForMod=Amount
	if(Stat=="Offense")
		OffMod=Amount
	if(Stat=="Defense")
		DefMod=Amount
	if(Stat=="Recovery")
		RecovMod=Amount
	if(Stat=="Anger")
		AngerMax=Amount
	if(Stat=="Learning")
		RPPMult=Amount
	if(Stat=="Intellect")
		Intelligence=Amount
	if(Stat=="Imagination")
		Imagination=Amount

mob/verb/Skill_Points_Done()
	set name=".Skill_Points_Done"
	set hidden=1
	if(!(world.time > verb_delay)) return
	verb_delay=world.time+1
	if(race_selecting) return
	if(Points) src<<"You still have points!"
	else
		if(assigningStats)
			assigningStats=0
		if(src.Redoing_Stats)
			src.Redoing_Stats=0
		winshow(src,"Finalize_Screen",0)
		for(var/obj/SavedStats/Z in usr.contents)
			del(Z)
		if(!usr.Savable)
			usr.NewMob()