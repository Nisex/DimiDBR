
/obj/Skills/Queue/Goetic_Special
	name = "PlaceHolder"
	ActiveMessage = "PlaceHolder"
	DamageMult = 1.25
	AccuracyMult = 10
	KBMult = 0.00001
	KBAdd = 1
	Combo = 16
	Warp=3
	Duration=5
	Cooldown=-1
	Decider=1
	CursedWounds = 1 // this won't work, it'd have to attach to a passive
	// NeedsSword=1
	EnergyCost=5
	HitSparkIcon='Slash - Power.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1.1
	HitStep=/obj/Skills/Queue/Goetic_Special2
	verb/Goetic_Special()
		set category="Skills"
		usr.SetQueue(src)
/obj/Skills/Queue/Goetic_Special2
	name = "PlaceHolder"
	ActiveMessage = "PlaceHolder"
	DamageMult = 13
	AccuracyMult = 10
	KBMult = 5
	Warp = 6
	Duration = 6
	Decider = 1
	Instinct = 4
	EnergyCost = 13
	IconLock = 'UltraInstinctSpark.dmi'
	HitSparkIcon = 'Slash - Power.dmi'
	HitSparkX = -32
	HitSparkY = -32
	HitSparkTurns = 0
	HitSparkSize = 2
	verb/Goetic_Special()
		set category="Skills"
		usr.SetQueue(src)