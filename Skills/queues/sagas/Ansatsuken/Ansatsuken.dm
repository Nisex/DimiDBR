obj
	Skills
		Queue
			Shoryuken
				StyleNeeded="Ansatsuken"
				AccuracyMult = 1.25
				Launcher=3
				Duration=5
				Shattering = 2
				Cooldown=40
				proc/resetVars()
					Launcher=initial(Launcher)
					Duration=initial(Duration)
					Cooldown=initial(Cooldown)
					ManaCost=initial(ManaCost)
					ShoryukenEffect=initial(ShoryukenEffect)
				proc/activate(mob/player)
					ManaCost = 0
					Launcher=1
					var/sagaLevel = player.SagaLevel
					var/damage = clamp(1.5 + 1*(sagaLevel), 2, 12)
					var/path = player.AnsatsukenPath == "Shoryuken" ? 1 : 0
					var/manaCost = 35 // how much u need for ex
					var/cooldown = 40
					var/hitMessage = "strikes their opponent into the air with a fearsome uppercut!!"
					ShoryukenEffect=1
					Shattering = 3 * sagaLevel
					if(path)
						manaCost -= 10
						cooldown -= 10
						damage =  clamp(1.5 + 2*(sagaLevel), 2, 13)
						hitMessage = "strikes their opponent into the air with a fearsome uppercut!!"
					if(player.AnsatsukenAscension=="Satsui")
						Shattering *= 1.25
						GoshoryukenEffect=1
					if(player.ManaAmount>=manaCost && sagaLevel >= 2)
						ManaCost = manaCost
						ShoryukenEffect=1.5
						Launcher=3
						hitMessage = "unleashes the power of the Dragon with an overpowering uppercut!"
						if(path)
							damage =  clamp(5 + 2*(sagaLevel), 4, 18)
						else
							damage = clamp(3 + 2*(sagaLevel), 3, 15)

					DamageMult = damage
					HitMessage = hitMessage
					Cooldown = cooldown
				verb/Shoryuken()
					set category="Skills"
					resetVars()
					activate(usr)
					usr.SetQueue(src)

			Shin_Shoryuken
				StyleNeeded="Ansatsuken"
				HitMessage="shouts '<b>SHIN...</b>' as they strike their opponent with a rising blow!!!"
				DamageMult=16
				AccuracyMult = 1.25
				KBMult=0.00001
				Duration=5
				Cooldown=180
				PushOut=3
				AllOutAttack=1
				ManaCost=100
				Instinct=4
				Stunner=3
				Rapid=1
				HitStep=/obj/Skills/Queue/Shin_Shoryuken2
				verb/Shin_Shoryuken()
					set category="Skills"
					set name="Shin-Shoryuken"
					if(usr.AnsatsukenAscension=="Satsui")
						src.HitMessage="shouts '<b>METSU...</b>' as they strike their opponent with a rising blow!!!"
						src.HitStep=/obj/Skills/Queue/Metsu_Shoryuken2
					usr.SetQueue(src)
			Shin_Shoryuken2
				StyleNeeded="Ansatsuken"
				HitMessage="shouts '<b>SHORYUKEN!</b>' as they spike their opponent into the heavens with a divine uppercut!!!"
				DamageMult=5
				AccuracyMult = 1.25
				KBMult=0.00001
				Duration=5
				Warp=5
				Instinct=4
				ShoryukenEffect=2
			Metsu_Shoryuken2
				StyleNeeded="Ansatsuken"
				HitMessage="shouts '<b>SHORYUKEN!</b>' as they spike their opponent into the heavens with a divine uppercut!!!"
				DamageMult=5
				AccuracyMult = 1.25
				KBMult=0.00001
				Duration=5
				Warp=5
				Instinct=4
				GoshoryukenEffect=2

			Messatsu_Goshoryu
				GoshoryukenEffect=0.75
				Duration=5
				Warp=5
				Instinct=4
				DamageMult=7.5
				AccuracyMult = 1.25
				KBMult=0.00001
				KBAdd=1
				ManaCost=50
				Stunner=4
				Counter=1
				Rapid=1
				IconLock='BijuuInitial.dmi'
				IconLockUnder=1
				LockX=-32
				LockY=-32
				HitStep=/obj/Skills/Queue/Messatsu_Goshoryu2
				verb/Messatsu_Goshoryu()
					set category="Skills"
					usr.SetQueue(src)
			Messatsu_Goshoryu2
				GoshoryukenEffect=1
				Duration=5
				Warp=5
				Instinct=4
				DamageMult=3
				AccuracyMult = 1.25
				KBMult=0.00001
				KBAdd=1
				Rapid=1
				HitStep=/obj/Skills/Queue/Messatsu_Goshoryu3
			Messatsu_Goshoryu3
				DamageMult=7.5
				GoshoryukenEffect=2
				Duration=5
				Warp=5
				Instinct=4
				DamageMult=7.5
				AccuracyMult = 1.25
				KBMult=0.00001