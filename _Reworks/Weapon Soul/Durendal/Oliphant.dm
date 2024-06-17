obj/Skills/AutoHit/Blow_The_Horn
	Area="Circle"
	Distance=15
	AdaptRate = 1
	GuardBreak=1
	DamageMult=10
	Knockback=20
	Cooldown=150
	Shockwaves=3
	Shockwave=6
	SpecialAttack=1
	Stunner=3
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	ActiveMessage="brings the Oilphant up to their lips to blow into it!"
	EnergyCost=5
	verb/Blow_the_Horn()
		set category="Skills"
		usr.Activate(src)

obj/Skills/Companion/PlayerCompanion/Squad/Oilphant
	squad = list("oliphant spirit")