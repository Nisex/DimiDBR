/obj/Skills/AutoHit/Masterful_Death
	NeedsSword=1
	Area="Arc"
	Distance=7
	StrOffense=1
	DamageMult=1
	RoundMovement=0
	ComboMaster=1
	Rounds=10
	Cooldown=120
	DarknessFlame = 1
	Toxic = 20
	Burning = 20
	EnergyCost=2
	Icon='MasterSlash.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	HitSparkIcon='Slash - Zero.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	EnergyCost=1
	Instinct=1
	ActiveMessage="strikes everything with an wave of inevitable, masterful death."
	verb/Masterful_Death()
		set category="Skills"
		usr.Activate(src)