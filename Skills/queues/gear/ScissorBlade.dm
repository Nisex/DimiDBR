obj/Skills/Queue/Sen_I_Soshitsu
	ActiveMessage="cuts forth with their scissor blade, nicking the edge of their opponent's clothes and weapon to pull them apart!"
	DamageMult= 7
	AccuracyMult = 5
	WeaponBreaker = 5
	KBMult=0.00001
	PushOutIcon='SparkleRed.dmi'
	Cooldown=150
	Instinct = 1
	NeedsSword=1
	verb/Sen_I_Soshitsu()
		set name="Sen-I-Soshitsu"
		set category="Skills"
		usr.SetQueue(src)