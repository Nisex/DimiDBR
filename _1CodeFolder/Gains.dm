var/list/Gold=list("Aries Cloth", /* "Taurus Cloth" */, "Gemini Cloth", "Cancer Cloth", "Leo Cloth", "Virgo Cloth", "Libra Cloth", "Scorpio Cloth", "Sagittarius Cloth", "Capricorn Cloth", "Aquarius Cloth", "Pisces Cloth")
proc
	GoCrand(var/x, var/y)
	{
		x *= 1000;
		y *= 1000;
		var/z = rand(x, y);
		z /= 1000;
		return z;
	}

mob/proc/RemoveWaterOverlay()
	var/list/meh=list("1","2","3","4","5","6","7","8","9","10","11","12","13","waterfall","14","15", "Deluged")
	for(var/x in meh)
		src.overlays-=image('WaterOverlay.dmi',"[x]")
	src.overlays-=image('LavaTileOverlay.dmi')
	src.underlays-=image('The Ripple.dmi', pixel_x=-32, pixel_y=-32)

mob/var/calmcounter=5
mob/var/HotnCold
mob/var/tmp/last_gain_loop
var/global/update_loop/gain_loop/gain_loop = new()

update_loop/gain_loop

	Add(updater)
		var li, value = -1
		for(var/list/l in updaters)
			if(updater in l) return
			if(l.len <= value || value==-1)
				li = l
				value = l.len
		li += updater

	Remove(updater)
		for(var/list/l in updaters)
			l -= updater
	Loop()
		updaters = list()
		updaters.len = 10
		for(var/index = 1 to 10 step 1)
			updaters[index] = list()
		// for()
		// 	for(var/list/l in updaters)
		// 		for(var/mob/updater in l)
		// 			updater.GainLoop()
		// 		sleep(world.tick_lag)

var/game_loop/mainLoop = new(0, "newGainLoop")
//** TESTED AND WORKS!! **/
mob/var/seventhSenseTriggered = 0

mob
	proc/GainLoop()
		set waitfor=0 //Wanna avoid staggering global gains loop on one person.
	//	if(!src.client)
	//		gain_loop.Remove(src)
	//		return
		if(src.PureRPMode&&!Stasis)
			src.Stasis=1
		if(client && client.getPref("autoAttacking"))
			var/mob/Players/p = src
			if(world.time - lastHit < 3 MINUTES)
				p.Attack()
			else
				p.Auto_Attack()
		StunCheck(src)
		StunImmuneCheck(src)
		if(glob.BREAK_TARGET && !src.Admin && Target && ismob(Target))
			var/distance = get_dist(Target, src)
			if((glob.BREAK_TARGET_ON_Z_CHANGE && Target.z != src.z) || (glob.BREAK_TARGET_ON_DIST && distance >= glob.BREAK_TARGET_ON_DIST))
				Target = null
		checkHealthAlert()

		if(src.Grab) src.Grab_Update()

		Update_Stat_Labels()

		if(!src.PureRPMode)
			meditationChecks()
			if(MovementCharges < GetMaxMovementCharges())
				MovementChargeBuildUp()
			if(ticker % 10 == 0)
				if(transActive)
					drainTransformations(transActive, race.transformations[transActive].mastery)

				EnergyMax = 100

				doLoopTimers()
				var/grit_value = passive_handler["Grit"]
				if (grit_value >= 1 && Health <= clamp(AscensionsAcquired * 15, 15, 75))
					HealHealth(grit_value / glob.racials.GRITDIVISOR)
			// Tick based activity / Timers
				if (passive_handler["Fa Jin"])
					if (canFaJin() && !fa_jin_effect)
						generate_fa_jin()
					if (fa_jin_effect && fa_jin_effect.alpha == 0)
						fa_jin_effect()
						src << "Your Fa Jin is ready!"
				else if (fa_jin_effect)
					vis_contents -= fa_jin_effect
					fa_jin_effect.loc = null
					del fa_jin_effect

				var/mystic = UsingMysticStyle()
				if(length(mystic)&&mystic[1] == TRUE)
					if(mystic[2] >= 0)
						if(hudIsLive("MysticT0", /obj/hud/mystic))
							client.hud_ids["MysticT0"]?:Update()
					if(mystic[2] >= 1)
						// we must find the aura buff
						var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/aura
						for(var/a in SlotlessBuffs)
							a = SlotlessBuffs[a]
							if(istype(a, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura ))
								aura = a
						if(aura)
							if(hudIsLive("MysticT1", /obj/hud/mystic, src, "last_aura_toss"))
								client.hud_ids["MysticT1"]?:Update()
				else
					if(client&&client.hud_ids["MysticT0"])
						client.remove_hud("MysticT0")
					if(client&&client.hud_ids["MysticT1"])
						client.remove_hud("MysticT1")
				if(passive_handler["SuperCharge"])
					if(hudIsLive("SuperCharge", /obj/hud/mystic, StyleBuff, "last_super_charge" ))
						client.hud_ids["SuperCharge"].Update()
				else
					if(client&&client.hud_ids["SuperCharge"])
						client.remove_hud("SuperCharge")




				if(passive_handler["Flying Thunder God"])
					if(client&&hudIsLive("FTG", /obj/hud/ftg))
						client.hud_ids["FTG"]?:Update()
				else
					if(client&&client.hud_ids["FTG"])
						client.remove_hud("FTG")

				if(scrollTicker)
					scrollTicker--
					if(scrollTicker<=0)
						scrollTicker=0
				if(passive_handler["Grit"])
					AdjustGrit("sub", glob.racials.GRITSUBTRACT)

				if(transActive)
					var/transformation/trans = race.transformations[transActive]
					trans.applyDrain(src)


				if(src.Transfering)
					var/mob/Players/M=src.Transfering
					var/val
					if(!src.KO)
						if(get_dist(M, src)<=15)
							if(src.ManaAmount>0)
								val=0.1
								src.LoseEnergy(val)
								src.LoseMana(val)
								M.HealEnergy(val*src.Imagination)
								M.HealWounds(val*src.Imagination)
								M.HealFatigue(val*src.Imagination)
								M.HealMana(val*src.Imagination)
								missile('SE.dmi', src, M)
							else
								src.Transfering=null
					else
						Transfering = null

			/* not used
				if(void_timer < world.realtime && voiding)
					// send to spawn
					loc = locate(100,100,3)
					voiding = 0*/

				if(passive_handler.Get("ContinuallyStun"))
					if(prob(passive_handler.Get("ContinuallyStun")/10))
						Stun(src, rand(1,2))

				if(movementSealed)
					for(var/obj/Seal/S in src)
						if(S.ZPlaneBind)
							if(src.z!=S.ZPlaneBind || abs(src.x - S.XBind) > 10 || abs(src.y - S.YBind) > 10)
								OMsg(src, "[src] has triggered their location binding!")
								src.loc=locate(S.XBind, S.YBind, S.ZPlaneBind)

				/*var/obj/Skills/Devils_Deal/dd = findDevilsDeal(src)
				if(dd)
					if(CurrentlySummoned)
						dd.incrementSummonReturnTime(0.1)
						if(dd.getSummonReturnTime() >= dd.getHomeTime())
							if(src.Grab)
								src.Grab_Release()
							for(var/mob/Grabee in range(1,src))
								if(Grabee.Grab==src)
									Grabee.Grab_Release()
							dd.returnToOrg(src)*/

				if(src.ManaSealed)
					if(!src.HasMechanized())
						if(src.TotalCapacity<=99)
							src.TotalCapacity=99
					else
						if(src.TotalCapacity>0)
							src.TotalCapacity=0

				if(Secret)
					if(Secret=="Vampire")
						var/obj/Skills/Buffs/SlotlessBuffs/Vampire/Vampire/vampireBuff
						for(var/obj/Skills/Buffs/SlotlessBuffs/Vampire/Vampire/v in src)
							vampireBuff = v
						if(!BuffOn(vampireBuff))
							vampireBuff.Trigger(src, Override=1)
						if(BuffOn(vampireBuff))
							vampireBuff.adjust(src)
						var/obj/Skills/Buffs/SlotlessBuffs/Vampire/Wassail/Wassail
						for(var/obj/Skills/Buffs/SlotlessBuffs/Vampire/Wassail/W in src)
							Wassail = W
						if(!BuffOn(Wassail) && Health <= 75*(1-HealthCut))
							if(!CheckSlotless("Rotschreck"))
								Wassail.adjust(src)
								Wassail.Trigger(src, Override=1)
						if(BuffOn(Wassail))
							Wassail.adjust(src)
						var/obj/Skills/Buffs/SlotlessBuffs/R
						if(CheckSlotless("Rotschreck"))
							R = GetSlotless("Rotschreck")
							R:adjust(src)
						var/SecretInfomation/Vampire/vampire = secretDatum
						if(vampire.secretVariable["LastBloodGain"] + 450 < world.time && vampire.secretVariable["BloodPower"] > 0)
							if(!PureRPMode)
								vampire.drainBlood()
								vampireBlood.fillGauge(clamp(secretDatum.secretVariable["BloodPower"]/4, 0, 1), 10)
						if(src.icon_state=="Train"&&!src.PoseEnhancement)
							src.PoseTime += 0.1
							if(src.PoseTime==5)
								src << "The restraints of your bloodlust crumble away as you dissolve into a living shadow!!"

					if(Secret=="Werewolf")
						if(secretDatum.secretVariable["Hunger Active"] == 1)
							var/SecretInfomation/Werewolf/s = secretDatum
							if(!PureRPMode)
								s.releaseHunger()
								if(secretDatum.secretVariable["Hunger Satiation"] <=0 && CheckSlotless("Full Moon Form"))
									src << "You have exhausted all the flesh you consumed and have reverted from your war form."
									for(var/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form/fmf in src)
										fmf.Trigger(src, Override=1)

					if(Secret=="Eldritch")
						if(secretDatum.secretVariable["Madness Active"] == 1)
							var/SecretInfomation/Eldritch/s = secretDatum
							if(!PureRPMode)
								s.releaseMadness(src)
								if(secretDatum.secretVariable["Madness"] <=0 && CheckSlotless("True Form"))
									src << "You have exhausted all the madness and have reverted to your sane form."
									for(var/obj/Skills/Buffs/SlotlessBuffs/Eldritch/True_Form/fmf in src)
										fmf.Trigger(src, Override=1)


					if(src.ManaDeath)
						src.WoundSelf(0.02*(src.ManaAmount/ManaMax))
						ManaAmount-=0.15*(src.ManaAmount/ManaMax)
						if(src.ManaAmount<=ManaMax && src.ManaDeath)
							src.ManaDeath=0
							ManaAmount = ManaMax
							senjutsuOverloadAlert=FALSE
							src << "You exhaust your natural energy, avoiding death by overexposure."

					if(src.HasRipple()||(!src.CheckSlotless("Half Moon Form")&&!src.CheckSlotless("Full Moon Form"))||src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus")||Secret=="Eldritch"&&!CheckSlotless("True Form"))
						if(src.icon_state=="Train"&&!src.PoseEnhancement)
							if(src.Secret=="Werewolf"&&!src.PoseTime)
								src << "You focus your instincts perfectly on the chosen target, ready to leap any second!"
							src.PoseTime += 1
							if(src.PoseTime>=glob.POSE_TIME_NEEDED)
								if(Secret=="Eldritch")
									icon_state = ""
									PoseTime = 0
									for(var/obj/Skills/Buffs/SlotlessBuffs/Eldritch/True_Form/fmf in src)
										fmf.Trigger(src)
								if(src.HasRipple())
									if(src.Swim==1)
										src.RemoveWaterOverlay()
										src.underlays+=image('The Ripple.dmi', pixel_x=-32, pixel_y=-32)
								if(src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus"))
									src << "You managed to mold some natural energy!"

				if(src.Stasis||src.StasisFrozen)
					src.Stasis-=world.tick_lag
					if(src.Stasis<=0)
						src.Stasis=0
						src.RemoveStasis()

				if(src.AttackQueue&&src.AttackQueue.Delayer)
					src.AttackQueue.DelayerTime += 1
					if(src.AttackQueue.DelayerTime==src.AttackQueue.Duration-2)
						src << "Your <b>[src.AttackQueue]</b> is fully charged!! Attack before you lose the power!!"

				if(src.PowerControl>100)
					if(!src.HasKiControl()&&!src.PoweringUp)
						src.PowerControl=100

				if(src.KOTimer)
					src.KOTimer -= 1
					if(src.KOTimer<=0)
						src.Conscious()

				if(src.BusterTech && src.BusterCharging<100)

					src.BusterCharging+=(100/RawSeconds(5)) * src.BusterTech.Buster * src.GetRecov() / 10

					if(src.BusterCharging>100)
						src.BusterCharging=100
						src << "Your buster technique is fully charged!"


				if(src.Beaming)
					for(var/obj/Skills/Projectile/Beams/Z in Skills)
						if(Z.Charging&&Z.ChargeRate)
							if(src.BeamCharging>=0.5&&src.BeamCharging<=Z.ChargeRate)
								src.BeamCharging+=src.GetRecov(0.2)
								if(src.BeamCharging>Z.ChargeRate)
									src.BeamCharging=Z.ChargeRate

								//aesthetics
								if(src.BeamCharging>=(0.5*Z.ChargeRate))
									if(Z.name=="Aurora Execution")
										if(src.BeamCharging<Z.ChargeRate)
											var/image/i=image('Aurora.dmi',icon_state="[rand(1,3)]", layer=EFFECTS_LAYER, loc=src)
											i.blend_mode=BLEND_ADD
											animate(i, alpha=0)
											world << i
											i.transform*=30
											animate(i, alpha=200, time=5)
											src.BeamCharging=Z.ChargeRate
											spawn(150)
												animate(i, alpha=0, time=5)
												sleep(5)
												del i
									else
										for(var/turf/t in Turf_Circle(src, 10))
											if(prob(5))
												spawn(rand(2,6))
													var/icon/i = icon('RisingRocks.dmi')
													t.overlays+=i
													spawn(rand(10, 30))
														t.overlays-=i
										if(src.BeamCharging==Z.ChargeRate)
											src.Quake((14+2*Z.DamageMult))

				src.Debuffs()
				if(UsingHotnCold())
					var/val = StyleBuff?:hotCold
					HotnCold = round(val,1)
					if(client&&hudIsLive("HotnCold", /obj/bar))
						client.hud_ids["HotnCold"]?:Update()
					if(val < 0)
						AddSlow(abs(val)/glob.HOTNCOLD_DEBUFF_DIVISOR)
						AddCrippling(abs(val)/(glob.HOTNCOLD_DEBUFF_DIVISOR*4))
					else
						AddBurn(abs(val)/(glob.HOTNCOLD_DEBUFF_DIVISOR))
				else
					if(client&&client.hud_ids["HotnCold"])
						client.remove_hud("HotnCold")
				if(passive_handler["Grit"])
					if(client&&hudIsLive("Grit", /obj/bar))
						client.hud_ids["Grit"]?:Update()
				if(src.Harden)
					src.Harden = max(0, src.Harden - glob.BASE_STACK_REDUCTION)
					if(client&&hudIsLive("Harden", /obj/bar))
						client.hud_ids["Harden"]?:Update()
				if(Momentum)
					if(passive_handler["Relentlessness"])
						Momentum = round(Momentum - (glob.BASE_STACK_REDUCTION + Momentum/40))
					else
						Momentum -= glob.BASE_STACK_REDUCTION
					if(client&&hudIsLive("Momentum", /obj/bar))
						client.hud_ids["Momentum"]?:Update()
					if(Momentum <0)
						Momentum=0
				if(Fury)
					if(passive_handler["Relentlessness"])
						Fury = round(Fury - (glob.BASE_STACK_REDUCTION + Fury/50))
					else
						Fury -= glob.BASE_STACK_REDUCTION
					if(client&&hudIsLive("Fury", /obj/bar))
						client.hud_ids["Fury"]?:Update()
					if(Fury<0)
						Fury=0


				if(src.SureHitTimerLimit)
					if(!src.SureHit)
						src.SureHitTimer -= 1
						if(src.SureHitTimer<=0)
							src.SureHit=1
							src.SureHitTimer=src.SureHitTimerLimit
				if(src.SureDodgeTimerLimit)
					if(!src.SureDodge)
						src.SureDodgeTimer -= 1
						if(src.SureDodgeTimer<=0)
							src.SureDodge=1
							src << "<b><i>You have a sure dodge stack!</b></i>"
							src.SureDodgeTimer=src.SureDodgeTimerLimit
	/*
				if(InDevaPath())
					devaCounter += 0.1*/

				if(passive_handler["Flying Thunder God"])
					src.IaidoCounter += 1
				if(UsingGladiator())
					GladiatorCounter += 1

				if(src.BPPoisonTimer)
					src.BPPoisonTimer -= 1
					if(src.Satiated&&!Drunk)
						src.BPPoisonTimer -= 1
					if(src.BPPoisonTimer<=0)
						if(src.BPPoison==0.5)
							src.BPPoisonTimer=RawHours(3)
							src.BPPoison=0.7
						else if(src.BPPoison==0.7)
							src.BPPoisonTimer=RawHours(1)
							src.BPPoison=0.9
						else
							src.BPPoison=1
							src.BPPoisonTimer=0
				if(src.OverClockNerf)
					src.OverClockTime -= 1
					if(src.Satiated&&!Drunk)
						src.OverClockTime -= 1
					if(src.OverClockTime<=0)
						src.OverClockTime=0
						src.OverClockNerf=0
						if(!isRace(ANDROID))
							src << "You've recovered from using your powerful ability!"
						else
							src << "Your systems have rebooted!"
				if(src.GatesNerfPerc)
					if(src.GatesNerf>0)
						src.GatesNerf -= 1
						if(src.Satiated&&!Drunk)
							src.GatesNerf -= 1
						if(src.GatesNerf<=0)
							src.GatesNerfPerc=0
							src.GatesNerf=0
							src << "You've recovered from the strain of your ability!"
							GatesActive = 0

				if(src.StrTax)
					src.SubStrTax(0.5/(2 DAYS))
				if(src.EndTax)
					src.SubEndTax(0.5/(2 DAYS))
				if(src.SpdTax)
					src.SubSpdTax(0.5/(2 DAYS))
				if(src.ForTax)
					src.SubForTax(0.5/(2 DAYS))
				if(src.OffTax)
					src.SubOffTax(0.5/(2 DAYS))
				if(src.DefTax)
					src.SubDefTax(0.5/(2 DAYS))
				if(src.RecovTax)
					src.SubRecovTax(0.5/(2 DAYS))

				if(src.AngerCD)
					src.AngerCD=max(src.AngerCD-1,0)
				if(src.PotionCD)
					src.PotionCD=max(src.PotionCD-1,0)

				if(src.CounterMasterTimer)
					src.CounterMasterTimer = max(0, CounterMasterTimer-1)

				if(src.BindingTimer)
					src.BindingTimer -= 1
					if(src.BindingTimer<=0)
						src.BindingTimer=0
					if(src.Binding&&Binding.len>0)
						src.TriggerBinding()

				if(src.GimmickTimer)
					src.GimmickTimer -= 1
					if(src.GimmickTimer<=0)
						src.GimmickTimer=0
						src.GimmickDesc=""

				if(src.Satiated)
					src.Satiated -= 1
					if(src.Satiated<=0)
						src.Satiated=0
						if(src.Drunk)
							src.Drunk=0
							src << "You recover from your drunkenness."
						src << "You feel less full."

				if(src.Doped)
					src.Doped -= 1
					if(src.Doped<=0)
						src.Doped=0
						src << "Your painkillers wear off."
				if(src.Antivenomed)
					src.Antivenomed -= 1
					if(src.Antivenomed<=0)
						src.Antivenomed=0
						src << "Your antivenom wears off."
				if(src.Cooled)
					src.Cooled -= 1
					if(src.Cooled<=0)
						src.Cooled=0
						src<<"Your cooling spray wears off."
				if(src.Sprayed)
					src.Sprayed -= 1
					if(src.Sprayed<=0)
						src.Sprayed=0
						src<<"Your sealing spray wears off."
				if(src.Stabilized)
					src.Stabilized -= 1
					if(src.Stabilized<=0)
						src.Stabilized=0
						src<<"Your focus stabilizer wears off."
				if(src.Roided)
					src.Roided -= 1
					if(src.Roided<=0)
						src.Roided=0
						src<<"Your steroids wear off, leaving you feeling worn out and sore!"
						src.OverClockNerf+=0.25
						src.OverClockTime+=RawHours(6)


				if(cursedSheathValue)
					cursedSheathValue -= 0.5/SagaLevel //TODO: ADD A HUD
					cursedSheathValue = clamp(0, cursedSheathValue, SagaLevel*50)

			if(ActiveBuff)
				ActiveBuff.GainLoop(src)
			
			if(SpecialBuff)
				SpecialBuff.GainLoop(src)

			if(length(SlotlessBuffs))
				for(var/h in src.SlotlessBuffs)
					var/obj/Skills/Buffs/b = SlotlessBuffs[h]
					if(b)
						b.GainLoop(src)
						if(b.Afterimages || b.passives["AfterImages"])
							if(prob((b.Afterimages + b.passives["AfterImages"]) *25))
								FlashImage(src)
						if(b.DrainAll)
							var/drainedOut = 0
							if(ManaAmount>0)
								LoseMana(b.DrainAll)
							else if(TotalCapacity<=99)
								LoseCapacity(b.DrainAll)
							else
								if(Energy>=1)
									LoseEnergy(b.DrainAll*1.75, TRUE)
								else if(TotalFatigue<98)
									GainFatigue(b.DrainAll*2)
								else
									drainedOut = 1

							if(drainedOut)
								b.Trigger(src, TRUE)
								src << "You can't keep up with the cost...!"

						if(b.Connector)
							missile(b.Connector,src,src.Target)

						if(b.Engrain)
							src.Stasis = 1

			for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/A in src.Buffs)
				//Activations
				if(!A.SlotlessOn)
					if(A.NeedsPassword)
						if(!A.Password)
							continue
					if(A.SlotlessBuffNeeded)
						if(!(A.SlotlessBuffNeeded in SlotlessBuffs))
							continue
					if(A.ABuffNeeded)
						if(!src.ActiveBuff)
							continue
						if(!(src.ActiveBuff.BuffName in A.ABuffNeeded))
							continue
					if(A.SBuffNeeded)
						if(!src.SpecialBuff)
							continue
						if(src.SpecialBuff.BuffName!=A.SBuffNeeded)
							continue
					if(A.StyleNeeded)
						if(!src.StyleActive)
							continue
						if(src.StyleActive!=A.StyleNeeded)
							continue
					if(A.WoundIntentRequired)
						if(!src.WoundIntent)
							continue
					if(A.NeedsHealth&&!A.Using&&!src.KO)
						if(src.Health<=A.NeedsHealth*(1-src.HealthCut))
							A.Trigger(src,Override=1)
							if(A.NeedsVary)
								A.NeedsHealth=rand(10,A.TooMuchHealth-5)
					if(A.ManaThreshold&&!A.Using&&!src.KO)//TODO: Align the requirements and variables more sensibly in this area
						if(src.ManaAmount>=A.ManaThreshold)
							A.Trigger(src,Override=1)
					if(A.NeedsAnger&&!A.Using&&!src.KO)
						if(src.Anger)
							A.Trigger(src,Override=1)
					if(A.NeedsAlignment)
						if(A.NeedsAlignment=="Evil")
							if(src.IsEvil())
								A.Trigger(src,Override=1)
						else if(A.NeedsAlignment=="Good")
							if(src.IsGood())
								A.Trigger(src,Override=1)
				if(A.AlwaysOn)
					if(!A.Using&&!A.SlotlessOn)
						A.Trigger(src,Override=1)
					if(A.Triggers)
						A.Triggers.checkTrigger(src, A)

				//Deactivations
				if(A.SlotlessOn)
					if(A.ABuffNeeded)
						if(A.ABuffNeeded.len>0)
							if(!src.ActiveBuff)
								A.Trigger(src,Override=1)
								continue
							if(!(src.ActiveBuff.BuffName in A.ABuffNeeded))
								A.Trigger(src,Override=1)
								continue
					if(A.SBuffNeeded)
						if(!src.SpecialBuff)
							A.Trigger(src,Override=1)
							continue
						if(src.SpecialBuff.BuffName!=A.SBuffNeeded)
							A.Trigger(src,Override=1)
							continue
					if(A.StyleNeeded)
						if(!src.StyleActive)
							A.Trigger(src,Override=1)
							continue
						if(src.StyleActive!=A.StyleNeeded)
							A.Trigger(src,Override=1)
							continue
					if(A.TimerLimit)
						if(A.Timer>=A.TimerLimit)
							A.Trigger(src,Override=1)
							continue
					if(A.NeedsAnger)
						if(!src.Anger)
							A.Trigger(src,Override=1)
							continue
					if(A.NeedsAlignment)
						if(A.NeedsAlignment=="Evil")
							if(!src.IsEvil())
								A.Trigger(src,Override=1)
								continue
						else if(A.NeedsAlignment=="Good")
							if(!src.IsGood())
								A.Trigger(src,Override=1)
								continue
					if(src.KO)
						if(A.SlotlessOn)
							A.Trigger(src,Override=1)
							continue
					if(A.TooMuchHealth)
						if(src.Health>=A.TooMuchHealth)
							if(A.SlotlessOn)
								A.Trigger(src,Override=1)
								continue
					if(A.TooLittleMana)
						if(src.ManaAmount<=A.TooLittleMana)
							if(A.SlotlessOn)
								A.Trigger(src,Override=1)
								continue

				if(A.AlwaysOn) //This only gets run if it has been deactivated
					if(A.Using)
						if(!A.doNotDelete)
							del A

		if(src.Energy<=0)
			src.Energy=1
		src.MaxHealth()
		src.MaxEnergy()
		src.MaxMana()
		src.MaxOxygen()

		if(ticker % 10 == 0)

			if(client&&src.MortallyWounded)
				if(!src.client.color)
					animate(src.client, color=list(1,0,0, 0.25,0.75,0, 0.25,0,0.75, 0,0,0), time=3)
				if(src.KO||src.MortallyWounded>3)
					if(prob(10*src.MortallyWounded/src.GetRecov()))
						src.Health-=10/max(src.Health,10)
						if(src.Health<=-300)
							if(prob(90/GetRecov())&&!src.StabilizeModule)
								src.Death(null,"internal injuries!")
							else
								src << "You've entered a stable condition."
								src.MortallyWounded=0

			if(isturf(loc))
				var/turf/T = loc
				T.GainLoop(src)

			if(src.AFKTimer>0)
				src.AFKTimer -= 1
				if(src.AFKTimer==0)
					src.overlays+=src.AFKIcon
					for(var/mob/E in hearers(12,src))
						if(E.Timestamp)
							E<<"<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=#D344E3>[src] has gone AFK!"
							Log(E.ChatLog(),"<font color=green>[src]([src.key]) has gone AFK!")
						else
							E<<"<font color=#D344E3>[src] has gone AFK!"
							Log(E.ChatLog(),"<font color=green>[src]([src.key]) has gone AFK!")

			if(client&&prob(0.1))
				src.client.SaveChar()
			if(AFKTimer)
				Available_Power()


/mob/verb/HardSave()
	client.SaveChar()