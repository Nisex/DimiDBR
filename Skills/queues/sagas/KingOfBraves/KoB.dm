obj/Skills/Queue/DrillKnee
	ActiveMessage="forms a drill around their knee!"
	HitMessage="drives the drill into their opponent!"
	SBuffNeeded="Broken Brave"
	DamageMult=12
	AccuracyMult = 1.175
	Instinct=1
	Duration=5
	KBMult=0.00001
	Cooldown=150
	Decider=1
	ShoryukenEffect=2
	Quaking=5
	PushOut=5
	PushOutWaves=3
	PushOutIcon='KenShockwaveLegend.dmi'
	verb/Drill_Knee()
		set category="Skills"
		if(usr.SpecialBuff)
			if(usr.SpecialBuff.BuffName!="Genesic Brave"&&src.SBuffNeeded!="Broken Brave")
				src.SBuffNeeded="Broken Brave"
			else if(usr.SpecialBuff.BuffName=="Genesic Brave")
				src.SBuffNeeded="Genesic Brave"
		usr.SetQueue(src)