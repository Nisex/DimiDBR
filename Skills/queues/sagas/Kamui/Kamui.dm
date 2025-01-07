obj
	Skills
		Queue
			Senjin_Shredder
				DamageMult=5
				AccuracyMult=1
				Cooldown=60
				Grapple=1
				KBMult=0.001
				PrecisionStrike=5
				Duration=25
				IconLock='PowerClawDeployed.dmi'
				ActiveMessage="'s skirt sprouts a spike!"
				HitMessage="'s skirt hooks their opponent close to them before shredding with countless blades!"
				verb/Senjin_Shredder()
					set category="Skills"
					usr.SetQueue(src)