obj/Skills
	Grapple
		var
			removeAfter = FALSE


			DamageMult=1
			MultiHit=1//hit multiple times durr
			EnergyDamage=0//do damage to energy+fatigue and heal self mana

			StrRate=1
			ForRate=0
			EndRate=1

			UnarmedOnly=1
			SwordOnly=0//TODO REMOVE
			SpecialAttack=0//staves n shiet

			ObjectEnabled=0
			Reversal=0//allows you to throw the one you've grabbed
			//Stunner

			ThrowDir/*carries a direction so people dont end up going wonky*/
			ThrowAdd=0//adds value to kb
			ThrowMult=1//mult value to kb

			TriggerMessage
			Effect//"Shockwave"
			EffectMult=1
			OneAndDone=0//prevents multiple iterations from effectmult

			DrainBlood // for vampire
////BASIC
		Toss
			DamageMult=0
			UnarmedOnly=0
			ObjectEnabled=1
			CooldownStatic=1
			Cooldown=20
			ThrowMult=1.5
			ThrowAdd=1.5
			TriggerMessage="tosses"
			proc/resetValues()
				TriggerMessage = "tosses"
				Effect = initial(Effect)
				DamageMult = initial(DamageMult)
				StrRate = initial(StrRate)
			verb/Toss()
				set category="Skills"
				if(!usr.Grab && !src.Using)
					if(usr.Saga=="Unlimited Blade Works"&&usr.GetSlotless("GaeBolg"))
						for(var/obj/Skills/Buffs/SlotlessBuffs/GaeBolg/GB in usr)
							GB.Trigger(usr, Override = 1)
						for(var/obj/Skills/Projectile/Zone_Attacks/Gae_Bolg/GBT in usr)
							GBT.alter(usr)
							usr.UseProjectile(GBT)
					usr.SecretToss(src)
				else
					if(usr.Secret == "Vampire")
						// if(adjusted) return
						// activate the vampire toss skill
						ThrowMult=0.75
						ThrowAdd=2
						ObjectEnabled = 0
						TriggerMessage = "sinks [usr.possessivepronoun()] fangs into"
						Effect = "Strike"
						var/secretLevel = usr.getSecretLevel()
						DamageMult = (6 + secretLevel) * (1 + usr.secretDatum:getBloodPowerRatio())
						Cooldown = 20
						StrRate = 0.8 * (1 + usr.secretDatum:getBloodPowerRatio())
						var/boon = 0// check to see if in wassail or in rotschreck
						if(usr.CheckSlotless("Wassail"))
							boon = 1
						else if(usr.CheckSlotless("Rotschreck"))
							boon = 0.5
						DrainBlood = 1 + boon
					else
						resetValues()
					src.Activate(usr)
////AUTO TRIGGER
		Lotus_Drop
			DamageMult=5
			StrRate=1
			TriggerMessage="spins into a vicious lotus drop to crack the skull of"
			Effect="Lotus"
			EffectMult=3
			OneAndDone=1
			ThrowMult=0
			ThrowAdd=0
			//Set from other queues
		True_Lotus
			DamageMult=7.5
			StrRate=1
			TriggerMessage="embraces the full power of their youth to spiral into a lotus drop to crack the skull of"
			Effect="Lotus"
			EffectMult=4
			OneAndDone=1
			ThrowMult=0
			ThrowAdd=0
			//still set from other queues
////UNARMED
		Snake_Fang_Bites
			MultiHit=2
			DamageMult=2
			StrRate=1
			ForRate=1
			ThrowAdd=5
			TriggerMessage="drives two fang-hands into"
			Effect="Strike"
			EffectMult=1
		Hammer_Crush
			Stunner=3
			DamageMult=4
			StrRate=1
			ForRate=0
			ThrowAdd=1
			ThrowMult=0
			TriggerMessage="presses down fiercely on"
			Effect="Suplex"
		Imperial_Disgust
			Stunner=5
			DamageMult=10
			StrRate=1
			ForRate=1
			ThrowMult=0
			ThrowAdd=10
			TriggerMessage="casts all of their disgust upon"
			Effect="Bang"
			EffectMult=5
//T1 is in Queues.
//T2 is in Autohits.
//T3 has damage mult 3 - 5.
		Throw
			SkillCost=120
			Copyable=3
			DamageMult=8
			StrRate=1
			ThrowAdd=5
			ThrowMult=1.5
			TriggerMessage="violently throws"
			Effect="Shockwave"
			Cooldown=90
			verb/Throw()
				set category="Skills"
				src.Activate(usr)
		Judo_Throw
			SkillCost=120
			Copyable=4
			PreRequisite=list("/obj/Skills/Grapple/Throw")
			LockOut=list("/obj/Skills/Grapple/Izuna_Drop", "/obj/Skills/Grapple/Suplex", "/obj/Skills/Grapple/Burning_Finger")
			DamageMult=12
			Reversal=1
			Stunner=2
			StrRate=1
			ThrowAdd=1
			ThrowMult=0
			TriggerMessage="performs a judo throw on"
			Effect="Shockwave"
			Cooldown=90
			verb/Judo_Throw()
				set category="Skills"
				src.Activate(usr)
		Izuna_Drop
			SkillCost=120
			Copyable=4
			PreRequisite=list("/obj/Skills/Grapple/Throw")
			LockOut=list("/obj/Skills/Grapple/Judo_Throw", "/obj/Skills/Grapple/Suplex", "/obj/Skills/Grapple/Burning_Finger")
			DamageMult=12
			StrRate=1
			ThrowAdd=0
			ThrowMult=0
			TriggerMessage="goes on a short flight with"
			Effect="Lotus"
			EffectMult=2
			OneAndDone=1
			Cooldown=90
			verb/Izuna_Drop()
				set category="Skills"
				src.Activate(usr)
		Suplex
			SkillCost=120
			Copyable=4
			PreRequisite=list("/obj/Skills/Grapple/Throw")
			LockOut=list("/obj/Skills/Grapple/Judo_Throw", "/obj/Skills/Grapple/Izuna_Drop", "/obj/Skills/Grapple/Burning_Finger")
			DamageMult=12
			Stunner=4
			StrRate=1
			ThrowAdd=1
			ThrowMult=0
			TriggerMessage="suplexes"
			Effect="Suplex"
			EffectMult=1
			Cooldown=90
			verb/Suplex()
				set category="Skills"
				src.Activate(usr)
		Burning_Finger
			SkillCost=120
			Copyable=4
			PreRequisite=list("/obj/Skills/Grapple/Throw")
			LockOut=list("/obj/Skills/Grapple/Judo_Throw", "/obj/Skills/Grapple/Izuna_Drop", "/obj/Skills/Grapple/Suplex")
			DamageMult=12
			StrRate=0.5
			ForRate=0.5
			TriggerMessage="shoves their burning red hand through"
			Effect="Bang"
			EffectMult=2
			ThrowMult=0
			ThrowAdd=5
			Cooldown=90
			verb/Burning_Finger()
				set category="Skills"
				src.Activate(usr)
//T4 is in Queues and Autohits.
//T5 (Sig 1) is damage mult 5, usually.
		Erupting_Burning_Finger
			UnarmedOnly=0
			NeedsSword=0
			SignatureTechnique=1
			DamageMult=16
			StrRate=0.75
			ForRate=0.75
			TriggerMessage="shoves their grossly incandescent hand through"
			Effect="Bang"
			EffectMult=5
			ThrowMult=0
			ThrowAdd=15
			Cooldown=150
			verb/Erupting_Burning_Finger()
				set category="Skills"
				src.Activate(usr)
			Removeable
				removeAfter = 1
		Lightning_Stake
			UnarmedOnly=0
			NeedsSword=0
			SignatureTechnique=1
			DamageMult=16
			ForRate=1
			StrRate=0.5
			TriggerMessage="fills their grasp with lightning and takes hold of"
			Effect="Lightning"
			EffectMult=5
			ThrowMult=0
			ThrowAdd=15
			Cooldown=150
			verb/Lightning_Stake()
				set category="Skills"
				src.Activate(usr)




		Energy_Drain
			DamageMult=0.75
			EnergyDamage=2
			ForRate=0.75
			StrRate=0.25
			TriggerMessage="drains energy from"
			Effect="Drain"
			EffectMult=1
			OneAndDone=1
			Cooldown=30
			verb/Energy_Drain()
				set category="Skills"
				src.Activate(usr)

		Sword
			NeedsSword=1
			UnarmedOnly=0

			Butterfly_Souffle
				DamageMult=1
				MultiHit=5
				StrRate=1
				ThrowMult=0
				ThrowAdd=1
				TriggerMessage="rips and tears into"
				Effect="Strike"
				EffectMult=5

			Impale
				Copyable=3
				SkillCost=120
				DamageMult=9
				StrRate=0.5
				ForRate=0.5
				TriggerMessage="impales"
				Effect="Strike"
				EffectMult=2
				ThrowMult=1.5
				Cooldown=90
				verb/Impale()
					set category="Skills"
					src.Activate(usr)
			Blade_Drive//run through pt 2
				DamageMult=8.5
				StrRate=0.8
				ThrowMult=2
				TriggerMessage="drives their weapon through the guts of"
				Effect="Shockwave"
				EffectMult=3
				//set from other queues
			Eviscerate
				PreRequisite=list("/obj/Skills/Grapple/Sword/Impale")
				LockOut=list("/obj/Skills/Queue/Run_Through", "/obj/Skills/Grapple/Sword/Hacksaw", "/obj/Skills/Grapple/Sword/Form_Ataru")
				Copyable=4
				SkillCost=120
				DamageMult=0.75
				MultiHit=5
				StrRate=1
				ThrowMult=0
				ThrowAdd=0
				TriggerMessage="eviscerates"
				Effect="Strike"
				EffectMult=5
				Cooldown=90
				verb/Eviscerate()
					set category="Skills"
					src.Activate(usr)
			Hacksaw
				PreRequisite=list("/obj/Skills/Grapple/Sword/Impale")
				LockOut=list("/obj/Skills/Queue/Run_Through", "/obj/Skills/Grapple/Sword/Eviscerate", "/obj/Skills/Grapple/Sword/Form_Ataru")
				Copyable=4
				SkillCost=120
				DamageMult=10
				StrRate=1
				ThrowMult=0
				ThrowAdd=0
				TriggerMessage="hacks their weapon cruelly into"
				Effect="Strike"
				EffectMult=3
				MaimStrike=1
				Cooldown=90
				verb/Hacksaw()
					set category="Skills"
					src.Activate(usr)
				Cancer_Snap
					NeedsSword=0
					TriggerMessage="uses their legs to crush"
					Cooldown=0
					//set from Acubens
			Form_Ataru
				PreRequisite=list("/obj/Skills/Grapple/Sword/Impale")
				LockOut=list("/obj/Skills/Queue/Run_Through", "/obj/Skills/Grapple/Sword/Hacksaw", "/obj/Skills/Grapple/Sword/Eviscerate")
				Copyable=4
				SkillCost=120
				DamageMult=10
				Reversal=1
				StrRate=0.5
				ForRate=0.5
				ThrowMult=0
				ThrowAdd=1
				TriggerMessage="does a slashing flip to break free of"
				Effect="Strike"
				EffectMult=2
				Cooldown=90
				verb/Form_Ataru()
					set category="Skills"
					set name="Form: Ataru"
					src.Activate(usr)



		proc
			Activate(var/mob/User)
				src.ThrowDir=User.dir
				if(src.Using)
					return
				if(User.GrabMove)
					return//do not allow for grab moves to be mashed
				if(!User.Grab)
					if(src.Reversal)
						var/mob/Grabber=User.IsGrabbed()
						if(Grabber)
							Grabber.Grab=null
							User.Grab=Grabber
						else
							return
					else
						return
				if(src.UnarmedOnly)
					if(User.EquippedSword() && !User.HasSwordPunching())
						User << "You cannot use a sword and use [src]!"
						return
					if(User.EquippedStaff() && User.UsingBattleMage())
						User << "You cannot use Battle Mage style and use [src]!"
						return
				if(src.NeedsSword)
					if(!User.EquippedSword() && !User.HasSwordPunching() && !(User.EquippedStaff() && User.UsingBattleMage()))
						User << "You have to have a sword to use [src]!"
						return

				if(!src.ObjectEnabled)
					if(isobj(User.Grab))
						User << "You cannot use [src] on an object!"
						return
				else//object grapples
					if(isobj(User.Grab))
						if(istype(src, /obj/Skills/Grapple/Toss))
							var/obj/Q=User.Grab
							User.Grab=null
							for(var/x=5, x>0, x--)
								Q.transform=turn(Q.transform, 225)
								step(Q, src.ThrowDir)
								sleep(1)
							Q.transform=matrix()
							return//dont trigger cd for object interacts

				if(ismob(User.Grab))
					User.GrabMove=1
					var/mob/Trg=User.Grab
					User.Grab=null
					var/dmgRoll = User.GetDamageMod()
					User.log2text("Grapple dmg roll ", dmgRoll, "damageDebugs.txt", User.ckey)
					// get their damage roll, they don't get to ignore it cause its a grapple
					var/userPower = User.Power / Trg.Power
					var/statPower = 1
					User.log2text("Grapple User Power", userPower, "damageDebugs.txt", User.ckey)
					var/itemDmg = 1
					if(src.StrRate)
						statPower = User.getStatDmg2() * StrRate
					if(src.ForRate)
						statPower += User.GetFor(src.ForRate) * glob.FORCE_EFFECTIVENESS
					User.log2text("Grapple Stat Power", statPower, "damageDebugs.txt", User.ckey)
					if(src.NeedsSword)
						itemDmg = (User.GetSwordDamage(User.EquippedSword()))
						if(src.SpecialAttack)
							var/obj/Items/Enchantment/Staff/st=User.EquippedStaff()
							var/obj/Items/Sword/sw=User.EquippedSword()
							if(sw?.MagicSword)
								itemDmg = ( User.GetSwordDamage(sw))
							else if(st)
								itemDmg = ( User.GetStaffDamage(st))
						itemDmg *= GLOBAL_ITEM_DAMAGE_MULT
					var/unarmedBoon = !NeedsSword ? GRAPPLE_MELEE_BOON : 1
					User.log2text("Grapple Item Damage", itemDmg, "damageDebugs.txt", User.ckey)
					var/endFactor = Trg.getEndStat(glob.END_EFFECTIVENESS)
					if(User.HasPridefulRage())
						if(User.passive_handler.Get("PridefulRage") >= 2)
							endFactor = 1
						else
							endFactor = clamp(Trg.getEndStat(glob.END_EFFECTIVENESS)/2, 1, Trg.getEndStat(glob.END_EFFECTIVENESS))
					User.log2text("Grapple End Factor", endFactor, "damageDebugs.txt", User.ckey)
					var/Damage=1
					// userPower += User.getIntimDMGReduction(Trg)
					User.log2text("Grapple User Power", userPower, "damageDebugs.txt", User.ckey)
					if(glob.DMG_CALC_2)
						Damage = (userPower**glob.DMG_POWER_EXPONENT) * (glob.CONSTANT_DAMAGE_EXPONENT+glob.GRAPPLE_EFFECTIVNESS) ** -(endFactor**glob.DMG_END_EXPONENT / statPower**glob.DMG_STR_EXPONENT)
					else
						Damage = (statPower * userPower) * 2 ** -(endFactor/statPower)
					User.log2text("Grapple Damage", Damage, "damageDebugs.txt", User.ckey)
					Damage *= dmgRoll
					Damage *= src.DamageMult + unarmedBoon
					User.log2text("Grapple Damage dmgroll", Damage, "damageDebugs.txt", User.ckey)
					Damage *= itemDmg
					User.log2text("Grapple Damage item dmg", Damage, "damageDebugs.txt", User.ckey)



					var/Hits=src.MultiHit
					if(src.MaimStrike)
						User.MaimStrike+=src.MaimStrike
					while(Hits)
						if(!src.EnergyDamage)
							User.log2text("Before do damage Grapple Damage", Damage, "damageDebugs.txt", User.ckey)
							User.DoDamage(Trg, Damage, src.UnarmedOnly, src.NeedsSword, SpiritAttack=src.SpecialAttack)
							if(DrainBlood)
								User.secretDatum:gainBloodPower(Damage*src.DrainBlood)
								User.vampireBlood.fillGauge(clamp(User.secretDatum.secretVariable["BloodPower"]/4, 0, 1), 10)
						else
							Trg.LoseEnergy(Damage*src.EnergyDamage)
							Trg.GainFatigue(Damage*src.EnergyDamage)
							User.HealMana(Damage*src.EnergyDamage)
						Hits--
					if(src.MaimStrike)
						User.MaimStrike-=src.MaimStrike
					OMsg(User, "[User] [src.TriggerMessage] [Trg]!")
					User.Knockback((dmgRoll*src.ThrowMult)+src.ThrowAdd, Trg, Direction=src.ThrowDir, Forced=1)
					if(src.Stunner)
						Stun(Trg, src.Stunner)
					if(src.Effect in list("Suplex", "Drain", "Lotus"))
						src.OneAndDone=1
					var/Times=src.EffectMult
					spawn()
						if(src.OneAndDone)
							Times=1
						while(Times)
							switch(src.Effect)
								if("Shockwave")
									KenShockwave(Trg)
								if("Bang")
									Bang(Trg.loc, 1.3, Offset=0.75)
								if("Lightning")
									LightningStrike2(Trg, Offset=GoCrand(0.5,0.1*src.EffectMult))
								if("Lotus")
									LotusEffect(User, Trg, src.EffectMult)
								if("Suplex")
									SuplexEffect(User, Trg)
								if("Strike")
									User.HitEffect(Trg)
								if("Drain")
									animate(Trg, color=list(1,1,1, 0,1,0, 1,1,1, 0,0,0), time=10, flags=ANIMATION_RELATIVE)
									sleep(10)
									animate(Trg, color=Trg.MobColor, time=10, flags=ANIMATION_RELATIVE)
									sleep(10)
							sleep(2)
							Times--
						sleep(5)//final effects
						switch(src.Effect)
							if("Bang")//biggest boom
								Bang(Trg.loc, src.EffectMult, Offset=0)
								KenShockwave(Trg, src.EffectMult/2)
							if("Lightning")
								KenShockwave(Trg, src.EffectMult/2)
							if("Strike")
								KenShockwave(Trg, src.EffectMult)

					User.GrabMove=0
					src.Cooldown()
					if(removeAfter)
						User -= src
						del src
				else
					Log("Admin", "[ExtractInfo(User)] currently has [User.Grab.type] grabbed and attempted to grapple them with [src].")