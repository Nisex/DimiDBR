obj/Skills/Queue/Blazing_Slash
	ActiveMessage="channels the might of ancient saints into a slash worthy of a pyre!"
	DamageMult=4
	AccuracyMult=3
	KBMult=3
	SweepStrike=1
	Burning = 25
	Duration = 5
	Cooldown=30
	NeedsSword=1
	EnergyCost=5
	HitSparkIcon='Fire Slash.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkSize=1.5
	verb/Blazing_Slash()
		set category="Skills"
		usr.SetQueue(src)
