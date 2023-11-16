var/list/Gold=list("Aries Cloth", /* "Taurus Cloth" */, "Gemini Cloth", "Cancer Cloth", "Leo Cloth", "Virgo Cloth", "Libra Cloth", "Scorpio Cloth", /*"Sagittarius Cloth"*/, "Capricorn Cloth", "Aquarius Cloth", "Pisces Cloth")
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
		for()
			for(var/list/l in updaters)
				for(var/mob/updater in l)
					updater.GainLoop()
				sleep(world.tick_lag)

var/game_loop/mainLoop = new(0, "newGainLoop")
//** TESTED AND WORKS!! **/
/mob/proc/checkHealthAlert()
	//50% injury check
	var/exhaustedMessage = SpecialBuff ? SpecialBuff.ExhaustedMessage : FALSE
	var/desperateMessage = SpecialBuff ? SpecialBuff.DesperateMessage : FALSE
	if(TotalInjury > 50 && !src.InjuryAnnounce && Secret!="Zombie")
		OMessage(10, "[src] looks beaten half to death!")
		InjuryAnnounce = 1

	// Nanite Check
	if(NanoBoost && Health<=25*(1-HealthCut)&&!NanoAnnounce)
		OMsg(src, "<font color='green'>[src]'s nanites respond to their physical trauma, bolstering their cybernetic power!</font color>")
		NanoAnnounce = 1
	// 25% health check
	if(Health < 25*(1-HealthCut) && !HealthAnnounce25)
		if(exhaustedMessage)
			OMessage(10, "<font color=#00FF55>[src] [exhaustedMessage]", "[src]([src.key]) has 25% health left.</font>")
		else
			if(Secret != "Zombie")
				if(!ExhaustedColor)
					OMessage(10, "<font color=#F07E1F>[src] [ExhaustedMessage ? "[ExhaustedMessage]" : " looks exhausted!"]!", "[src]([src.key]) has 25% health left.</font>")
				else
					OMessage(10,"font color='[ExhaustedColor]'> [src] [ExhaustedMessage ? "[ExhaustedMessage]" : " looks exhausted!"]!", "[src]([src.key]) has 25% health left.</font>")
				HealthAnnounce25 = 1

	// 10% health check
	if(Health < 10*(1-HealthCut) && !HealthAnnounce10)
		if(desperateMessage)
			OMessage(10, "<font color=#00FF55>[src] [desperateMessage]", "[src]([src.key]) has 10% health left.</font>")
		else
			if(Secret !="Zombie")
				if(!BarelyStandingColor)
					OMessage(10, "<font color=#F07E1F>[src] [BarelyStandingMessage ? "[BarelyStandingMessage]" : " is barely standing!"]!", "[src]([src.key]) has 10% health left.</font>")
				else
					OMessage(10,"font color='[BarelyStandingColor]'>[src] [BarelyStandingMessage ? "[BarelyStandingMessage]" : " is barely standing!"]!", "[src]([src.key]) has 10% health left.</font>")
			HealthAnnounce10 = 1
//**TESTED AND WORKS */
/mob/proc/meditationChecks()
	if(icon_state == "Meditate")
		MeditateTime++
		if(Health>=75*(1-HealthCut) && Anger!=0)
			calmcounter--
		else
			calmcounter=5
		if(calmcounter<=0)
			calmcounter=5
			if(Anger)
				Calm()
		if(MeditateTime == 15)
			usr << "If any skills reset on Meditate, they've been reset."
		if(CheckSpecial("Jinchuuriki") || CheckSpecial("Vaizard Mask"))
			if(SpecialBuff.Mastery <= 1)
				SpecialBuff.Trigger(src, Override=1)
	else
		MeditateTime=0
//**TESTED AND WORKS **/
/mob/proc/drainTransformations(ssj, ssjMastery, trans, transMastery)
	// TRANS / TRANSMASTERY FOR CHANGIE 4TH FORM
	var/drain
	if(ssj >=1 && ssj < 4 && ssjMastery >= 5 && ssjMastery <= 75)
		drain = round(30 - ((ssjMastery - 5) * 30) / (75 - 5), 1)
		if(drain < 0)
			drain = 0
		if(Energy < drain && !HasNoRevert() && !Dead && !HasMystic())

			Revert()
			LoseEnergy(drain)
			src<<"The strain of Super Saiyan forced you to revert."

	if(trans==4 && transMastery < 100 && Race == "Changeling")
		drain = round(30 - (40 * log(1 + transMastery / 100)), 1)
		if(drain < 0)
			drain = 1
		if(Energy < drain && !HasNoRevert())
			GainFatigue(drain)
			Revert()
			src<<"The strain of Golden Form forced you to revert!"

/mob/proc/doLoopTimers()
	if(Lethal-- <= 0 && Lethal)
		Lethal = 0
		OMsg(src, "font color='grey'>[src] will no longer deal lethal damage.</font color>")
	// Move this to a different loop, most likely

	if(TsukiyomiTime-- <= 0 && TsukiyomiTime)
		TsukiyomiTime = 0
		animate(client, color=null, time=1)
		OMsg(src, "font color='grey'>[src] is no longer trapped in Tsukiyomi.</font color>")

	if(TimeStop)
		var/obj/Skills/Buffs/SlotlessBuffs/Grimoire/Time_Stop/book = new
		book = locate() in src
		LoseHealth(5/book.Mastery)
		book:TimeStopped++
		if(book:TimeStopped>book.Mastery+1)
			SkillX("Time Stop",x)
	var/obj/Skills/Devils_Deal/dd = findDevilsDeal(src)
	if(dd)
		if(CurrentlySummoned)
			dd.incrementSummonReturnTime(1)
			if(dd.getSummonReturnTime() >= dd.getHomeTime())
				dd.returnToOrg(src)
				OMsg(src, "font color='grey'>[src] is no longer being summoned.</font color>")


/mob/proc/newGainLoop()
	set waitfor = 0
	// Local Variables
	var/active_ssj = ssj["active"]
	var/ssj_mastery = masteries["[active_ssj]mastery"]
	var/active_trans = trans["active"]
	var/trans_mastery = masteries["4mastery"]
	// var/mob/players/M = null
	// var/val = 0




	if(!client)
		mainLoop -= src
		return
	if(src.KO&&src.icon_state!="KO")
		src.icon_state="KO"
	if(src.PureRPMode)
		if(!src.Stasis)
			src.Stasis=1
		return // Don't do anything else if in Pure RP mode.
	checkHealthAlert()

	meditationChecks()

	drainTransformations(active_ssj, ssj_mastery, active_trans, trans_mastery)

	if(Grab) Grab_Update()
	EnergyMax = 100

	doLoopTimers()
	// Tick based activity / Timers


	if(MovementCharges < GetMaxMovementCharges())
		MovementChargeBuildUp()





	Update_Stat_Labels()


mob/var/seventhSenseTriggered = 0

mob
	proc/GainLoop()
		set waitfor=0 //Wanna avoid staggering global gains loop on one person.
		if(!src.client)
			gain_loop.Remove(src)
			return

		if(src.PureRPMode&&!Stasis)
			src.Stasis=1

		StunCheck(src)
		StunImmuneCheck(src)

		if(src.Health <= 15*(1-src.HealthCut))
			if(Saga == "Cosmo" && SpecialBuff && seventhSenseTriggered == FALSE) // saint
				if(SagaLevel == 5)
					var/obj/Skills/Buffs/SlotlessBuffs/SeventhSense/SS = new()
					SS = locate() in src
					if(!SS)
						SS = new
						AddSkill(SS)
					SS.Trigger(src, TRUE)
					seventhSenseTriggered = TRUE

		if(src.Health <= 25*(1-src.HealthCut) && !src.HealthAnnounce25)
			if(Saga == "Cosmo" && SpecialBuff && seventhSenseTriggered == FALSE) // saint
				if(SagaLevel >= 6)
					var/obj/Skills/Buffs/SlotlessBuffs/SeventhSense/SS = new()
					SS = locate() in src
					if(!SS)
						SS = new
						AddSkill(SS)
					SS.Trigger(src, TRUE)
					SS.passives = list("GodKi" = 0.25, "SpiritPower" = 0.25)
					seventhSenseTriggered = TRUE


			var/shonenMoment = ShonenPowerCheck(src)
			if(shonenMoment)
				VaizardHealth += triggerPlotArmor(shonenMoment, HasUnstoppable())
				src.OMessage(10, "<font color=#c3b329>[src]'s will to be a HERO gives [lowertext(objectpronoun())] a second wind!</font>", "[src]([src.key]) has triggered plot armor.")


			if(src.SpecialBuff&&src.SpecialBuff.BuffName=="Broken Brave")
				src.OMessage(10, "<font color=#00FF55>[src] begins fighting fiercely like a lion!", "[src]([src.key]) has 25% health left.</font>")
			else if(src.SpecialBuff&&src.SpecialBuff.BuffName=="Protect Brave")
				src.OMessage(10, "<font color=#00FF55>[src] begins fighting tenaciously like a machine!", "[src]([src.key]) has 25% health left.</font>")
			else if(src.SpecialBuff&&src.SpecialBuff.BuffName=="Genesic Brave")
				src.OMessage(10, "<font color=#00FF55>[src] begins fighting fiercely and tenaciously with the power of Courage!", "[src]([src.key]) has 25% health left.</font>")
			else
				if(src.Secret!="Zombie")
					if(!src.ExhaustedMessage)
						if(!src.ExhaustedColor)
							src.OMessage(10, "[src] looks exhausted!", "[src]([src.key]) has 25% health left.")
						else
							src.OMessage(10, "<font color='[src.ExhaustedColor]'>[src] looks exhausted!</font color>", "[src]([src.key]) has 25% health left.")
					else
						if(!src.ExhaustedColor)
							src.OMessage(10, "[src] [src.ExhaustedMessage]", "[src]([src.key]) has 25% health left.")
						else
							src.OMessage(10, "<font color='[src.ExhaustedColor]'>[src] [src.ExhaustedMessage]</font color>", "[src]([src.key]) has 25% health left.")
			if(src.NanoBoost)
				OMsg(src, "<font color='green'>[src]'s nanites respond to their physical trauma, bolstering their cybernetic power!</font color>")
			src.HealthAnnounce25=1

		if(src.Health <= 10*(1-src.HealthCut)&& !src.HealthAnnounce10)


			if(src.SpecialBuff&&src.SpecialBuff.BuffName=="Broken Brave")
				src.OMessage(10, "<b><font color=#00FF55>[src] calls upon the power of Destruction for one final push!", "[src]([src.key]) has 10% health left.</font></b>")
			else if(src.SpecialBuff&&src.SpecialBuff.BuffName=="Protect Brave")
				src.OMessage(10, "<b><font color=#00FF55>[src] calls upon the power of Protection for one final push!", "[src]([src.key]) has 10% health left.</font></b>")
				src.VaizardHealth+=5*src.SagaLevel
			else if(src.SpecialBuff&&src.SpecialBuff.BuffName=="Genesic Brave")
				src.OMessage(10, "<b><font color=#00FF55>[src] unites the powers of Destruction and Protection to defy the odds!", "[src]([src.key]) has 10% health left.</font></b>")
				src.VaizardHealth+=2.5*src.SagaLevel
			else
				if(src.Secret!="Zombie")
					if(!src.BarelyStandingMessage)
						if(!src.BarelyStandingColor)
							src.OMessage(10, "[src] is barely standing up!", "[src]([src.key]) has 10% health left.")
						else
							src.OMessage(10, "<font color='[src.BarelyStandingColor]'>[src] is barely standing up!</font color>", "[src]([src.key]) has 10% health left.")
					else
						if(!src.BarelyStandingColor)
							src.OMessage(10, "[src] [src.BarelyStandingMessage]", "[src]([src.key]) has 10% health left.")
						else
							src.OMessage(10, "<font color='[src.BarelyStandingColor]'>[src] [src.BarelyStandingMessage]</font color>", "[src]([src.key]) has 10% health left.")
			src.HealthAnnounce10=1

		if(src.TotalInjury > 50 && !src.InjuryAnnounce && src.Secret!="Zombie")
			src.OMessage(10, "[src] looks beaten half to death!", "[src]([src.key]) has 50% injury.")
			src.InjuryAnnounce=1

		if(src.Grab) src.Grab_Update()

		Update_Stat_Labels()

		if(!src.PureRPMode)

			if(calmcounter<=0)
				calmcounter=5
				if(Anger)
					src.Calm()

			if(icon_state == "Meditate")
				MeditateTime++

				if(src.Health>=75*(1-src.HealthCut)&&src.Anger!=0)
					calmcounter--
				else
					calmcounter=5

				if(Secret == "Vampire" && MeditateTime == 10)
					var/obj/Skills/Buffs/SlotlessBuffs/R = GetSlotless("Rotshreck")
					if(R && R.NeedsHealth == 0)
						R.NeedsHealth = 25
						R.TooMuchHealth = 50
						R:adjust(src)
						src<<"You no longer fear for your life..."
				if(MeditateTime == 15)
					if(Race=="Majin")
						majinPassive.resetVariables(src)
					for(var/obj/Skills/s in Skills) if(s.Cooldown<0 && s.Using)
						src << "One or more of your skills will be made available to you again when you stop meditating."
						break
					if(CheckSpecial("Jinchuuriki"))
						for(var/obj/Skills/Buffs/SpecialBuffs/Cursed/Jinchuuriki/J in Buffs)
							if(J.Mastery > 1)
								break
							else
								J.Trigger(src,Override=1)
								break
					if(CheckSpecial("Vaizard Mask"))
						for(var/obj/Skills/Buffs/SpecialBuffs/Cursed/Vaizard_Mask/V in Buffs)
							if(V.Mastery > 1)
								break
							else
								V.Trigger(src,Override=1)
								break
				if(MeditateTime == 40)
					if(SpecialBuff)
						if(SpecialBuff.BuffName == "Ripper Mode")
							SpecialBuff?:sandevistanUsages = 0
							src << "Your Sandevistan Usages has been reset."
					// dmn i dont want to search for the buff if it is inactive
					// cant let it reset on trigger

			else
				MeditateTime=0

			if(src.Lethal)
				src.Lethal--
				if(src.Lethal<=0)
					src.Lethal=0
					OMsg(src, "<font color='grey'>[src] will no longer deal lethal damage.</font color>")


			if(src.MovementCharges<src.GetMaxMovementCharges())
				src.MovementChargeBuildUp()
			if(src.MovementCharges>src.GetMaxMovementCharges())
				src.MovementCharges=src.GetMaxMovementCharges()

			if(src.TsukiyomiTime)
				src.TsukiyomiTime--
				if(src.TsukiyomiTime<=0)
					src.TsukiyomiTime=0
					animate(src.client, color=null, time=1)

			if(src.TimeStop)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Grimoire/Time_Stop/x in src)
					src.LoseHealth(5/x.Mastery)
					x:TimeStopped++
					if(x:TimeStopped>x.Mastery+1)
						src.SkillX("Time Stop",x)

			if(scrollTicker)
				scrollTicker--
				if(scrollTicker<=0)
					scrollTicker=0

			if(src.ssj["active"]>0&&src.ssj["active"]<4)
				if((src.ssj["active"]>=1))
					var/Drain
					if(src.masteries["[src.ssj["active"]]mastery"]>5&&src.masteries["[src.ssj["active"]]mastery"]<75||(src.HasGodKi()&&masteries["4mastery"]!=100))
						Drain=30
					else
						Drain=0
					if(Drain>0)
						if(src.Energy<Drain&&!src.HasNoRevert()&&!src.Dead&&!src.HasMystic())
							src.Revert()
							src.LoseEnergy(30)
							src<<"The strain of Super Saiyan forced you to revert!"
/*
			if(src.trans["active"]>3 && src.masteries["4mastery"]<100 && src.Race=="Changeling")
				if(src.Energy<30&&!src.HasNoRevert())
					src.GainFatigue(30)
					src.Revert()
					src<<"The strain of Golden Form forced you to revert!"
*/

			if(src.Transfering)
				var/mob/Players/M=src.Transfering
				var/val
				if(!src.KO)
					if(get_dist(M, src)<=15)
						if(src.ManaAmount>0)
							val=1
							src.LoseEnergy(val)
							src.LoseMana(1)
							M.HealEnergy(val*src.Imagination)
							M.HealWounds(1*src.Imagination)
							M.HealFatigue(1*src.Imagination)
							M.HealMana(1*src.Imagination)
							missile('SE.dmi', src, M)
						else
							src.Transfering=null

			if(void_timer < world.realtime && voiding)
				// send to spawn
				loc = locate(100,100,3)
				voiding = 0


/*
			if(src.Phylactery&&!src.Dead)
				spawn()
					var/found=0
					for(var/obj/Items/Enchantment/Phylactery/Phy in world)
						if(Phy.Signature==src.ckey)
							found=1
							break
					if(!found)
						src.Phylactery=0
						src.NoDeath=0
						src.Death(null, "their phylactery being destroyed!", SuperDead=1, NoRemains=1)
*/


			if(src.MovementSealed())
				for(var/obj/Seal/S in src)
					if(S.ZPlaneBind)
						if(src.z!=S.ZPlaneBind || abs(src.x - S.XBind) > 10 || abs(src.y - S.YBind) > 10)
							OMsg(src, "[src] has triggered their location binding!")
							src.loc=locate(S.XBind, S.YBind, S.ZPlaneBind)

			var/obj/Skills/Devils_Deal/dd = findDevilsDeal(src)
			if(dd)
				if(CurrentlySummoned)
					dd.incrementSummonReturnTime(1)
					if(dd.getSummonReturnTime() >= dd.getHomeTime())
						if(src.Grab)
							src.Grab_Release()
						for(var/mob/Grabee in range(1,src))
							if(Grabee.Grab==src)
								Grabee.Grab_Release()
						dd.returnToOrg(src)

			if(src.ManaSealed)
				if(!src.HasMechanized())
					if(src.TotalCapacity<=99)
						src.TotalCapacity=99
				else
					if(src.TotalCapacity>0)
						src.TotalCapacity=0

			if(Secret == "Vampire")
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
				var/datum/SecretInfomation/Vampire/vampire = secretDatum
				if(vampire.secretVariable["LastBloodGain"] + 450 < world.time && vampire.secretVariable["BloodPower"] > 0)
					if(!PureRPMode)
						vampire.drainBlood()
						vampireBlood.fillGauge(clamp(secretDatum.secretVariable["BloodPower"]/4, 0, 1), 10)
				if(src.icon_state=="Train"&&!src.PoseEnhancement)
					src.PoseTime++
					if(src.PoseTime==5)
						src << "The restraints of your bloodlust crumble away as you dissolve into a living shadow!!"
			if(src.Secret == "Werewolf")
				if(secretDatum.secretVariable["Hunger Active"] == 1)
					var/datum/SecretInfomation/Werewolf/s = secretDatum
					if(!PureRPMode)
						s.releaseHunger()
						if(secretDatum.secretVariable["Hunger Satiation"] <=0 && CheckSlotless("Full Moon Form"))
							src << "You have exhausted all the flesh you consumed and have reverted from your war form."
							for(var/obj/Skills/Buffs/SlotlessBuffs/Werewolf/Full_Moon_Form/fmf in src)
								fmf.Trigger(src, Override=1)


			if(src.ManaDeath)
				src.WoundSelf(0.2*(src.ManaAmount/ManaMax))
				ManaAmount-=1.5*(src.ManaAmount/ManaMax)
				if(src.ManaAmount<=ManaMax && src.ManaDeath)
					src.ManaDeath=0
					ManaAmount = ManaMax
					senjutsuOverloadAlert=FALSE
					src << "You exhaust your natural energy, avoiding death by overexposure."

			if(src.HasRipple()||(!src.CheckSlotless("Half Moon Form")&&!src.CheckSlotless("Full Moon Form"))||src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus"))
				if(src.icon_state=="Train"&&!src.PoseEnhancement)
					if(src.Secret=="Werewolf"&&!src.PoseTime)
						src << "You focus your instincts perfectly on the chosen target, ready to leap any second!"
					src.PoseTime++
					if(src.PoseTime==5)
						if(src.HasRipple())
							src << "The Ripple flows through your body perfectly!  You have gained full control over your breathing!!"
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
				src.AttackQueue.DelayerTime++
				if(src.AttackQueue.DelayerTime==src.AttackQueue.Duration-2)
					src << "Your <b>[src.AttackQueue]</b> is fully charged!! Attack before you lose the power!!"

			if(src.PowerControl>100)
				if(!src.HasKiControl()&&!src.PoweringUp)
					src.PowerControl=100

/*
			if(src.EraDeathClock&&!src.EraDeathTrigger)
				if(src.Dead)
					src.EraDeathClock=0
				if(src.Timeless)
					src.EraDeathClock=0
				if(src.Immortal)
					src.EraDeathClock=0
				if(src.EraDeathClock)
					if(world.realtime>src.EraDeathClock)
						src.EraDeathTrigger=1
						src << "<font size=+1 color=#ff0000><b>You will die shortly. Please think of your last words.</b></font>"
						sleep(600)
						if(src.ParasiteCrest())
							src.Death(null, "living a short and painful life!", SuperDead=10)
						else
							src.Death(null, "living a long and satisfying life!", SuperDead=10)
*/

			if(src.Dead)
				if(src.DeadTime&&src.Savable&&!src.KeepBody)
					if((src.DeadTime<global.Era))
						if(src.HasEnlightenment())
							src.KeepBody=1
						if(src.KeepBody)
							return
						else
							src.Reincarnate()
			else
				if(src.DeadTime)
					src.DeadTime=null

			if(src.KOTimer)
				src.KOTimer--
				if(src.KOTimer<=0)
					src.Conscious()

			if(src.BusterTech && src.BusterCharging<100)

				src.BusterCharging+=(100/RawSeconds(5)) * src.BusterTech.Buster * src.GetRecov()

				if(src.BusterCharging>100)
					src.BusterCharging=100
					src << "Your buster technique is fully charged!"


			if(src.Beaming==1)
				for(var/obj/Skills/Projectile/Beams/Z in src)
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
												if(Z.name=="Excalibur")
													if(locate(/obj/Skills/Queue/Holy_Blade, src))
														i='SparkleGold.dmi'
													else
														i='DarkShockD.dmi'
												t.overlays+=i
												spawn(rand(10, 30))
													t.overlays-=i
									if(src.BeamCharging==Z.ChargeRate)
										src.Quake((14+2*Z.DamageMult))

			src.Debuffs()

			if(src.Harden)
				src.Harden--
				if(src.Harden<=0)
					src.Harden=0

			if(src.SureHitTimerLimit)
				if(!src.SureHit)
					src.SureHitTimer--
					if(src.SureHitTimer<=0)
						src.SureHit=1
						src.SureHitTimer=src.SureHitTimerLimit
			if(src.SureDodgeTimerLimit)
				if(!src.SureDodge)
					src.SureDodgeTimer--
					if(src.SureDodgeTimer<=0)
						src.SureDodge=1
						src.SureDodgeTimer=src.SureDodgeTimerLimit



			if(InDevaPath())
				devaCounter++

			if(src.UsingIaido())
				src.IaidoCounter++
			if(src.UsingKendo())
				src.IaidoCounter++
			if(src.UsingSpeedRave())
				src.IaidoCounter++

			if(src.BPPoisonTimer)
				src.BPPoisonTimer--
				if(src.Satiated&&!Drunk)
					src.BPPoisonTimer--
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
				src.OverClockTime--
				if(src.Satiated&&!Drunk)
					src.OverClockTime--
				if(src.OverClockTime<=0)
					src.OverClockTime=0
					src.OverClockNerf=0
					if(src.Race!="Android")
						src << "You've recovered from using your powerful ability!"
					else
						src << "Your systems have rebooted!"
			if(src.GatesNerfPerc)
				if(src.GatesNerf>0)
					src.GatesNerf--
					if(src.Satiated&&!Drunk)
						src.GatesNerf--
					if(src.GatesNerf<=0)
						src.GatesNerfPerc=0
						src.GatesNerf=0
						src << "You've recovered from the strain of your ability!"
						GatesActive = 0

			if(src.StrTax)
				src.SubStrTax(0.25/RawDays(1))
			if(src.EndTax)
				src.SubEndTax(0.25/RawDays(1))
			if(src.SpdTax)
				src.SubSpdTax(0.25/RawDays(1))
			if(src.ForTax)
				src.SubForTax(0.25/RawDays(1))
			if(src.OffTax)
				src.SubOffTax(0.25/RawDays(1))
			if(src.DefTax)
				src.SubDefTax(0.25/RawDays(1))
			if(src.RecovTax)
				src.SubRecovTax(0.25/RawDays(1))

			if(src.AngerCD!=0)
				src.AngerCD=max(src.AngerCD-1,0)
			if(src.PotionCD!=0)
				src.PotionCD=max(src.PotionCD-1,0)

			if(src.CounterMasterTimer)
				src.CounterMasterTimer = max(0, CounterMasterTimer-1)

			if(src.BindingTimer>=1)
				src.BindingTimer--
				if(src.BindingTimer<=0)
					src.BindingTimer=0
					if(src.Binding>=1)
						src.TriggerBinding()
			if(src.Oozaru)
				src.OozaruTimer--
				if(src.OozaruTimer<=0)
					src.Oozaru(0)

/*
			if(src.FusionTimer>0)
				src.FusionTimer--
				if(src.KO)
					src.FusionTimer=0
				if(src.FusionTimer<=0)
					if(src.Class in list("Dance","Potara"))
						global.fusion_locs["[ckey] and [Fusee]"] = list("x"=x,"y"=y,"z"=z)
						for(var/mob/Players/M in players)
							if(M!=src)
								if(M.ckey==src.FusionCKey2)
									M.client.eye=M
									M.client.perspective=MOB_PERSPECTIVE
									M.client.LoadChar()
									break
						src.client.LoadChar()
					else
						src.RPPower=1*/
			if(src.GimmickTimer)
				src.GimmickTimer--
				if(src.GimmickTimer<=0)
					src.GimmickTimer=0
					src.GimmickDesc=""

			if(src.Satiated)
				src.Satiated--
				if(src.Satiated<=0)
					src.Satiated=0
					if(src.Drunk)
						src.Drunk=0
						src << "You recover from your drunkenness."
					src << "You feel less full."
			/*
			if(src.Aged)
				src.Aged--
				if(src.Aged<=0)
					src.Aged=0
					src << "You return to your younger form!"*/
			if(src.Doped)
				src.Doped--
				if(src.Doped<=0)
					src.Doped=0
					src << "Your painkillers wear off."
			if(src.Antivenomed)
				src.Antivenomed--
				if(src.Antivenomed<=0)
					src.Antivenomed=0
					src << "Your antivenom wears off."
			if(src.Cooled)
				src.Cooled--
				if(src.Cooled<=0)
					src.Cooled=0
					src<<"Your cooling spray wears off."
			if(src.Sprayed)
				src.Sprayed--
				if(src.Sprayed<=0)
					src.Sprayed=0
					src<<"Your sealing spray wears off."
			if(src.Stabilized)
				src.Stabilized--
				if(src.Stabilized<=0)
					src.Stabilized=0
					src<<"Your focus stabilizer wears off."
			if(src.Roided)
				src.Roided--
				if(src.Roided<=0)
					src.Roided=0
					src<<"Your steroids wear off, leaving you feeling worn out and sore!"
					src.OverClockNerf+=0.25
					src.OverClockTime+=RawHours(6)

			var/safety=0
			while(src.ActiveBuff)
				if(safety!=0) break
				safety++
				if(src.ActiveBuff.HealthDrain)
					src.DoDamage(src, TrueDamage(src.ActiveBuff.HealthDrain))
				if(src.ActiveBuff.HealthThreshold&&!src.ActiveBuff.AllOutAttack)
					if(src.Health<src.ActiveBuff.HealthThreshold*(1-src.HealthCut)||src.KO)
						if(src.CheckActive("Eight Gates"))
							src.ActiveBuff:Stop_Cultivation()
							GatesActive=0
						else
							src.ActiveBuff.Trigger(src,Override=1)
						GatesActive=0
						break

				if(src.ActiveBuff.WoundDrain)
					src.WoundSelf(src.ActiveBuff.WoundDrain)
				if(src.ActiveBuff.WoundThreshold&&!src.ActiveBuff.AllOutAttack)
					if(src.TotalInjury>=src.ActiveBuff.WoundThreshold)
						src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.EnergyDrain)
					src.LoseEnergy(src.ActiveBuff.EnergyDrain)
				if(src.ActiveBuff.EnergyThreshold&&!src.ActiveBuff.AllOutAttack)
					if(src.Energy<src.ActiveBuff.EnergyThreshold*(1-src.EnergyCut))
						src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.FatigueDrain)
					src.GainFatigue(src.ActiveBuff.FatigueDrain)
				if(src.ActiveBuff.FatigueThreshold&&!src.ActiveBuff.AllOutAttack)
					if(src.TotalFatigue>=src.ActiveBuff.FatigueThreshold)
						if(src.CheckActive("Eight Gates"))
							src.ActiveBuff:Stop_Cultivation()
							GatesActive=0
						else
							src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.CapacityDrain)
					src.LoseCapacity(src.ActiveBuff.CapacityDrain)
				if(src.ActiveBuff.CapacityThreshold&&!src.ActiveBuff.AllOutAttack)
					if(src.TotalCapacity>=src.ActiveBuff.CapacityThreshold)
						src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.ManaDrain)
					src.LoseMana(src.ActiveBuff.ManaDrain,1)
				if(src.ActiveBuff.ManaThreshold&&!src.ActiveBuff.AllOutAttack)
					if(src.ManaAmount<src.ActiveBuff.ManaThreshold)
						src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.VaizardShatter)
					if(src.VaizardHealth<=0)
						src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.TimerLimit)
					if(!isnum(src.ActiveBuff.Timer))//If the timer isn't a number...
						src.ActiveBuff.Timer=0//Make it 0.
					src.ActiveBuff.Timer+=world.tick_lag
					if(src.ActiveBuff.Timer>=src.ActiveBuff.TimerLimit)//If the timer has filled up entirely...
						if(src.CheckActive("Eight Gates"))
							src.ActiveBuff:Stop_Cultivation()
							GatesActive=0
						else
							src.ActiveBuff.Trigger(src,Override=1)//toggle it off.
						break

				if(src.ActiveBuff.TooMuchHealth)
					if(src.Health>=src.ActiveBuff.TooMuchHealth)
						src.ActiveBuff.Trigger(src,Override=1)
						break

				if(src.ActiveBuff.WaveringAngerLimit)
					if(src.ActiveBuff.WaveringAnger<src.ActiveBuff.WaveringAngerLimit)
						src.ActiveBuff.WaveringAnger++
						if(src.ActiveBuff.WaveringAnger>=src.ActiveBuff.WaveringAngerLimit)
							if(prob(33))
								src.SetNoAnger(src.ActiveBuff, 1)
							else
								src.SetNoAnger(src.ActiveBuff, 0)
							src.ActiveBuff.WaveringAnger=0

				if(src.ActiveBuff.WoundHeal)
					if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
						src.HealWounds(src.GetRecov(src.ActiveBuff.WoundHeal))
				if(src.ActiveBuff.FatigueHeal)
					if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
						if(src.ActiveBuff.StableHeal)
							src.HealFatigue(src.ActiveBuff.FatigueHeal,1)
						else
							src.HealFatigue(src.GetRecov(src.ActiveBuff.FatigueHeal))
				if(src.ActiveBuff.CapacityHeal)
					if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
						src.HealCapacity(src.ActiveBuff.CapacityHeal)
				if(src.ActiveBuff.HealthHeal)
					if((src.Health+src.TotalInjury)>=100||(src.TotalInjury&&src.icon_state=="Meditate"))
						if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
							src.HealWounds(src.GetRecov(src.ActiveBuff.HealthHeal))
					else
						if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
							src.HealHealth(src.GetRecov(src.ActiveBuff.HealthHeal))
				if(src.ActiveBuff.EnergyHeal)
					if((src.Energy+src.TotalFatigue)>=100||(src.TotalFatigue&&src.icon_state=="Meditate"))
						if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
							if(src.ActiveBuff.StableHeal)
								src.HealFatigue(src.ActiveBuff.EnergyHeal,1)
							else
								src.HealFatigue(src.GetRecov(src.ActiveBuff.EnergyHeal))
					else
						if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
							if(src.ActiveBuff.StableHeal)
								src.HealEnergy(src.ActiveBuff.EnergyHeal,1)
							else
								src.HealEnergy(src.GetRecov(src.ActiveBuff.EnergyHeal))
				if(src.ActiveBuff.ManaHeal)
					if((src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)||!src.ActiveBuff.InstantAffect)
						src.HealMana(src.ActiveBuff.ManaHeal)
				if(src.ActiveBuff.InstantAffect&&!src.ActiveBuff.InstantAffected)
					src.ActiveBuff.InstantAffected=1

				if(src.ActiveBuff.BurnAffected)
					src.AddBurn(src.ActiveBuff.BurnAffected,src)
				if(src.ActiveBuff.SlowAffected)
					src.AddSlow(src.ActiveBuff.SlowAffected,src)
				if(src.ActiveBuff.ShockAffected)
					src.AddShock(src.ActiveBuff.ShockAffected,src)
				if(src.ActiveBuff.ShatterAffected)
					src.AddShatter(src.ActiveBuff.ShatterAffected,src)
				if(src.ActiveBuff.PoisonAffected)
					src.AddPoison(src.ActiveBuff.PoisonAffected,src)

				if(src.ActiveBuff.StrTaxDrain)
					src.AddStrTax(src.ActiveBuff.StrTaxDrain)
				if(src.ActiveBuff.StrCutDrain)
					src.AddStrCut(src.ActiveBuff.StrCutDrain)
				if(src.ActiveBuff.EndTaxDrain)
					src.AddEndTax(src.ActiveBuff.EndTaxDrain)
				if(src.ActiveBuff.EndCutDrain)
					src.AddEndCut(src.ActiveBuff.EndCutDrain)
				if(src.ActiveBuff.SpdTaxDrain)
					src.AddSpdTax(src.ActiveBuff.SpdTaxDrain)
				if(src.ActiveBuff.SpdCutDrain)
					src.AddSpdCut(src.ActiveBuff.SpdCutDrain)
				if(src.ActiveBuff.ForTaxDrain)
					src.AddForTax(src.ActiveBuff.ForTaxDrain)
				if(src.ActiveBuff.ForCutDrain)
					src.AddForCut(src.ActiveBuff.ForCutDrain)
				if(src.ActiveBuff.OffTaxDrain)
					src.AddOffTax(src.ActiveBuff.OffTaxDrain)
				if(src.ActiveBuff.OffCutDrain)
					src.AddOffCut(src.ActiveBuff.OffCutDrain)
				if(src.ActiveBuff.DefTaxDrain)
					src.AddDefTax(src.ActiveBuff.DefTaxDrain)
				if(src.ActiveBuff.DefCutDrain)
					src.AddDefCut(src.ActiveBuff.DefCutDrain)
				if(src.ActiveBuff.RecovTaxDrain)
					src.AddRecovTax(src.ActiveBuff.RecovTaxDrain)
				if(src.ActiveBuff.RecovCutDrain)
					src.AddRecovCut(src.ActiveBuff.RecovCutDrain)
				break
			safety=0
			while(src.SpecialBuff)
				if(safety!=0) break
				safety++
				if(src.SpecialBuff.HealthDrain)
					src.DoDamage(src, TrueDamage(src.SpecialBuff.HealthDrain))
				if(src.SpecialBuff.HealthThreshold&&!src.SpecialBuff.AllOutAttack)
					if(src.Health<src.SpecialBuff.HealthThreshold*(1-src.HealthCut)||src.KO)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.WoundDrain)
					src.WoundSelf(src.SpecialBuff.WoundDrain)
				if(src.SpecialBuff.WoundThreshold&&!src.SpecialBuff.AllOutAttack)
					if(src.TotalInjury>=src.SpecialBuff.WoundThreshold)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.EnergyDrain)
					src.LoseEnergy(src.SpecialBuff.EnergyDrain)
				if(src.SpecialBuff.EnergyThreshold&&!src.SpecialBuff.AllOutAttack)
					if(src.Energy<src.SpecialBuff.EnergyThreshold*(1-src.EnergyCut))
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.FatigueDrain)
					src.GainFatigue(src.SpecialBuff.FatigueDrain)
				if(src.SpecialBuff.FatigueThreshold&&!src.SpecialBuff.AllOutAttack)
					if(src.TotalFatigue>=src.SpecialBuff.FatigueThreshold)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.CapacityDrain)
					src.LoseCapacity(src.SpecialBuff.CapacityDrain)
				if(src.SpecialBuff.CapacityThreshold&&!src.SpecialBuff.AllOutAttack)
					if(src.TotalCapacity>=src.SpecialBuff.CapacityThreshold)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.ManaDrain)
					src.LoseMana(src.SpecialBuff.ManaDrain,1)
				if(src.SpecialBuff.ManaThreshold&&!src.SpecialBuff.AllOutAttack)
					if(src.ManaAmount<src.SpecialBuff.ManaThreshold)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.VaizardShatter)
					if(src.VaizardHealth<=0)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.TimerLimit)
					if(!isnum(src.SpecialBuff.Timer))
						src.SpecialBuff.Timer=0
					src.SpecialBuff.Timer+=world.tick_lag
					if(src.SpecialBuff.Timer>=src.SpecialBuff.TimerLimit)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.TooMuchHealth)
					if(src.Health>=src.SpecialBuff.TooMuchHealth)
						src.SpecialBuff.Trigger(src,Override=1)
						break

				if(src.SpecialBuff.WaveringAngerLimit)
					if(src.SpecialBuff.WaveringAnger<src.SpecialBuff.WaveringAngerLimit)
						src.SpecialBuff.WaveringAnger++
						if(src.SpecialBuff.WaveringAnger>=src.SpecialBuff.WaveringAngerLimit)
							if(prob(33))
								src.SetNoAnger(src.SpecialBuff, 1)
							else
								src.SetNoAnger(src.SpecialBuff, 0)
							src.SpecialBuff.WaveringAnger=0

				if(src.SpecialBuff.WoundHeal)
					src.HealWounds(src.GetRecov(src.SpecialBuff.WoundHeal))
				if(src.SpecialBuff.FatigueHeal)
					src.HealFatigue(src.GetRecov(src.SpecialBuff.FatigueHeal))
				if(src.SpecialBuff.CapacityHeal)
					src.HealCapacity(src.SpecialBuff.CapacityHeal)
				if(src.SpecialBuff.HealthHeal)
					if((src.Health+src.TotalInjury)>=100||(src.TotalInjury&&src.icon_state=="Meditate"))
						if(src.SpecialBuff.StableHeal)
							src.HealWounds(src.SpecialBuff.HealthHeal)
						else
							src.HealWounds(src.GetRecov(src.SpecialBuff.HealthHeal))
					else
						if(src.SpecialBuff.StableHeal)
							src.HealHealth(src.SpecialBuff.HealthHeal)
						else
							src.HealHealth(src.GetRecov(src.SpecialBuff.HealthHeal))
				if(src.SpecialBuff.EnergyHeal)
					if((src.Energy+src.TotalFatigue)>=100||(src.TotalFatigue&&src.icon_state=="Meditate"))
						if(src.SpecialBuff.StableHeal)
							src.HealFatigue(src.SpecialBuff.EnergyHeal,1)
						else
							src.HealFatigue(src.GetRecov(src.SpecialBuff.EnergyHeal))
					else
						if(src.SpecialBuff.StableHeal)
							src.HealEnergy(src.SpecialBuff.EnergyHeal,1)
						else
							src.HealEnergy(src.GetRecov(src.SpecialBuff.EnergyHeal))
				if(src.SpecialBuff.ManaHeal)
					src.HealMana(src.SpecialBuff.ManaHeal)

				if(src.SpecialBuff.BurnAffected)
					src.AddBurn(src.SpecialBuff.BurnAffected,src)
				if(src.SpecialBuff.SlowAffected)
					src.AddSlow(src.SpecialBuff.SlowAffected,src)
				if(src.SpecialBuff.ShockAffected)
					src.AddShock(src.SpecialBuff.ShockAffected,src)
				if(src.SpecialBuff.ShatterAffected)
					src.AddShatter(src.SpecialBuff.ShatterAffected,src)
				if(src.SpecialBuff.PoisonAffected)
					src.AddPoison(src.SpecialBuff.PoisonAffected,src)

				if(src.SpecialBuff.StrTaxDrain)
					src.AddStrTax(src.SpecialBuff.StrTaxDrain)
				if(src.SpecialBuff.StrCutDrain)
					src.AddStrCut(src.SpecialBuff.StrCutDrain)
				if(src.SpecialBuff.EndTaxDrain)
					src.AddEndTax(src.SpecialBuff.EndTaxDrain)
				if(src.SpecialBuff.EndCutDrain)
					src.AddEndCut(src.SpecialBuff.EndCutDrain)
				if(src.SpecialBuff.SpdTaxDrain)
					src.AddSpdTax(src.SpecialBuff.SpdTaxDrain)
				if(src.SpecialBuff.SpdCutDrain)
					src.AddSpdCut(src.SpecialBuff.SpdCutDrain)
				if(src.SpecialBuff.ForTaxDrain)
					src.AddForTax(src.SpecialBuff.ForTaxDrain)
				if(src.SpecialBuff.ForCutDrain)
					src.AddForCut(src.SpecialBuff.ForCutDrain)
				if(src.SpecialBuff.OffTaxDrain)
					src.AddOffTax(src.SpecialBuff.OffTaxDrain)
				if(src.SpecialBuff.OffCutDrain)
					src.AddOffCut(src.SpecialBuff.OffCutDrain)
				if(src.SpecialBuff.DefTaxDrain)
					src.AddDefTax(src.SpecialBuff.DefTaxDrain)
				if(src.SpecialBuff.DefCutDrain)
					src.AddDefCut(src.SpecialBuff.DefCutDrain)
				if(src.SpecialBuff.RecovTaxDrain)
					src.AddRecovTax(src.SpecialBuff.RecovTaxDrain)
				if(src.SpecialBuff.RecovCutDrain)
					src.AddRecovCut(src.SpecialBuff.RecovCutDrain)

				if(src.SpecialBuff.BuffName in Gold)
					SpecialBuff?:checkForEnd(src)
					// if(src.SagaLevel<7||src.Saga!="Cosmo")
					// 	if(prob(0.5**max(src.SenseUnlocked-5,0)))
					// 		src.SpecialBuff.Trigger(src, Override=1)
					// 		break
				break

			if(src.SlotlessBuffs.len>0)
				for(var/h in src.SlotlessBuffs)
					var/obj/Skills/Buffs/b = SlotlessBuffs[h]
					if(b)
						// if(b.coolerAfterImages)
						// 	coolerFlashImage(src, b.coolerAfterImages)

						if(b.Afterimages)
							if(prob(b.Afterimages*25))
								FlashImage(src)
						if(b.HealthDrain)
							src.DoDamage(src, TrueDamage(b.HealthDrain))
						if(b.HealthThreshold&&!b.AllOutAttack)
							if(src.Health<b.HealthThreshold*(1-src.HealthCut)||src.KO)
								b.Trigger(src,Override=1)
								continue
						if(b.WoundDrain)
							src.WoundSelf(b.WoundDrain)
						if(b.WoundThreshold&&!b.AllOutAttack)
							if(src.TotalInjury>=b.WoundThreshold)
								b.Trigger(src,Override=1)
								continue
						if(b.EnergyDrain)
							src.LoseEnergy(b.EnergyDrain)
						if(b.EnergyThreshold&&!b.AllOutAttack)
							if(src.Energy<b.EnergyThreshold*(1-src.EnergyCut))
								b.Trigger(src,Override=1)
								continue
						if(b.FatigueDrain)
							src.GainFatigue(b.FatigueDrain)
						if(b.FatigueThreshold&&!b.AllOutAttack)
							if(src.TotalFatigue>=b.FatigueThreshold)
								b.Trigger(src,Override=1)
								continue
						if(b.CapacityDrain)
							src.LoseCapacity(b.CapacityDrain)
						if(b.CapacityThreshold&&!b.AllOutAttack)
							if(src.TotalCapacity>=b.CapacityThreshold)
								b.Trigger(src,Override=1)
								continue
						if(b.ManaDrain)
							src.LoseMana(b.ManaDrain,1)
						if(b.ManaThreshold&&!b.AllOutAttack)
							if(src.ManaAmount<b.ManaThreshold)
								b.Trigger(src,Override=1)
								continue
						if(b.VaizardShatter)
							if(src.VaizardHealth<=0)
								b.Trigger(src,Override=1)
								continue
						if(b.TooMuchHealth)
							if(src.Health>=b.TooMuchHealth)
								b.Trigger(src,Override=1)
								continue
						if(b.Connector)
							missile(b.Connector,src,src.Target)

						if(b.WaveringAngerLimit)
							if(b.WaveringAnger<b.WaveringAngerLimit)
								b.WaveringAnger++
								if(b.WaveringAnger>=b.WaveringAngerLimit)
									if(prob(33))
										src.SetNoAnger(b, 1)
									else
										src.SetNoAnger(b, 0)
									b.WaveringAnger=0

						if(!b.AffectTarget)
							if(b.WoundHeal)
								if(!b.StableHeal)
									if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
										src.HealWounds(src.GetRecov(b.WoundHeal))
								else
									if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
										src.HealWounds(b.WoundHeal)
							if(b.FatigueHeal)
								if(!b.StableHeal)
									if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
										src.HealFatigue(src.GetRecov(b.FatigueHeal))
								else
									if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
										src.HealFatigue(b.FatigueHeal,1)
							if(b.CapacityHeal)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.HealCapacity(b.CapacityHeal)
							if(b.HealthHeal)
								if(!b.StableHeal)
									if((src.Health+src.TotalInjury)>=100||(src.TotalInjury&&src.icon_state=="Meditate"))
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealWounds(src.GetRecov(b.HealthHeal))
									else
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealHealth(src.GetRecov(b.HealthHeal))
								else
									if((src.Health+src.TotalInjury)>=100||(src.TotalInjury&&src.icon_state=="Meditate"))
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealWounds(b.HealthHeal)
									else
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealHealth(b.HealthHeal)
							if(b.EnergyHeal)
								if(!b.StableHeal)
									if((src.Energy+src.TotalFatigue)>=100||(src.TotalFatigue&&src.icon_state=="Meditate"))
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealFatigue(src.GetRecov(b.EnergyHeal))
									else
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealEnergy(src.GetRecov(b.EnergyHeal))
								else
									if((src.Health+src.TotalInjury)>=100||(src.TotalInjury&&src.icon_state=="Meditate"))
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealFatigue(b.EnergyHeal,1)
									else
										if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
											src.HealFatigue(b.EnergyHeal,1)
							if(b.ManaHeal)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.HealMana(b.ManaHeal)


							if(b.BurnAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddBurn(b.BurnAffected,src)
							if(b.SlowAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddSlow(b.SlowAffected,src)
							if(b.ShockAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddShock(b.ShockAffected,src)
							if(b.ShatterAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddShatter(b.ShatterAffected,src)
							if(b.PoisonAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddPoison(b.PoisonAffected,src)
							if(b.CrippleAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddCrippling(b.CrippleAffected,src)
							if(b.ShearAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									src.AddShearing(b.ShearAffected,src)
							if(b.StunAffected)
								if((b.InstantAffect&&!b.InstantAffected)||!b.InstantAffect)
									Stun(src, b.StunAffected)
							if(b.InstantAffect)
								b.InstantAffected=1//don't do that again

							if(b.StrTaxDrain)
								src.AddStrTax(b.StrTaxDrain)
							if(b.StrCutDrain)
								src.AddStrCut(b.StrCutDrain)
							if(b.EndTaxDrain)
								src.AddEndTax(b.EndTaxDrain)
							if(b.EndCutDrain)
								src.AddEndCut(b.EndCutDrain)
							if(b.SpdTaxDrain)
								src.AddSpdTax(b.SpdTaxDrain)
							if(b.SpdCutDrain)
								src.AddSpdCut(b.SpdCutDrain)
							if(b.ForTaxDrain)
								src.AddForTax(b.ForTaxDrain)
							if(b.ForCutDrain)
								src.AddForCut(b.ForCutDrain)
							if(b.OffTaxDrain)
								src.AddOffTax(b.OffTaxDrain)
							if(b.OffCutDrain)
								src.AddOffCut(b.OffCutDrain)
							if(b.DefTaxDrain)
								src.AddDefTax(b.DefTaxDrain)
							if(b.DefCutDrain)
								src.AddDefCut(b.DefCutDrain)
							if(b.RecovTaxDrain)
								src.AddRecovTax(b.RecovTaxDrain)
							if(b.RecovCutDrain)
								src.AddRecovCut(b.RecovCutDrain)
						else
							if(src.Target&&get_dist(src,src.Target) > b.Range)
								b.Trigger(src, Override=1)
								continue
							if(src.Target&&istype(src.Target, /mob/Players))
								if(b.HealthHeal&&!src.Target.HasMechanized())
									if(!b.StableHeal)
										if((src.Target.Health+src.Target.TotalInjury)>=100||(src.Target.TotalInjury&&src.Target.icon_state=="Meditate"))
											src.Target.HealWounds(src.Target.GetRecov(b.HealthHeal))
										else
											src.Target.HealHealth(src.Target.GetRecov(b.HealthHeal))
									else
										if((src.Target.Health+src.Target.TotalInjury)>=100||(src.Target.TotalInjury&&src.Target.icon_state=="Meditate"))
											src.Target.HealWounds(b.HealthHeal)
										else
											src.Target.HealHealth(b.HealthHeal)
								if(b.EnergyHeal&&!src.Target.HasMechanized())
									if(!b.StableHeal)
										if((src.Target.Energy+src.Target.TotalFatigue)>=100||(src.Target.TotalFatigue&&src.Target.icon_state=="Meditate"))
											src.Target.HealFatigue(src.Target.GetRecov(b.EnergyHeal))
										else
											src.Target.HealEnergy(src.GetRecov(b.EnergyHeal))
									else
										if((src.Target.Energy+src.Target.TotalFatigue)>=100||(src.Target.TotalFatigue&&src.Target.icon_state=="Meditate"))
											src.Target.HealFatigue(b.EnergyHeal,1)
										else
											src.Target.HealEnergy(b.EnergyHeal,1)
								if(b.ManaHeal&&!src.Target.HasMechanized())
									src.Target.HealMana(b.ManaHeal)
								if(b.WoundHeal)
									if(!b.StableHeal)
										src.Target.HealWounds(src.Target.GetRecov(b.WoundHeal))
									else
										src.Target.HealWounds(b.WoundHeal)
								if(b.FatigueHeal)
									if(!b.StableHeal)
										src.Target.HealFatigue(src.Target.GetRecov(b.FatigueHeal))
									else
										src.Target.HealFatigue(b.FatigueHeal,1)
								if(b.CapacityHeal&&!src.Target.HasMechanized())
									src.Target.HealCapacity(b.CapacityHeal)

								if(b.BurnAffected)
									src.Target.AddBurn(b.BurnAffected,src)
								if(b.SlowAffected)
									src.Target.AddSlow(b.SlowAffected,src)
								if(b.ShockAffected)
									src.Target.AddShock(b.ShockAffected,src)
								if(b.ShatterAffected)
									src.Target.AddShatter(b.ShatterAffected,src)
								if(b.PoisonAffected)
									src.Target.AddPoison(b.PoisonAffected,src)
								if(b.CrippleAffected)
									src.Target.AddCrippling(b.CrippleAffected,src)
								if(b.ShearAffected)
									src.Target.AddShearing(b.ShearAffected,src)
								if(b.StunAffected)
									Stun(src.Target, b.StunAffected)

								if(b.StrTaxDrain)
									src.Target.AddStrTax(b.StrTaxDrain)
								if(b.StrCutDrain)
									src.Target.AddStrCut(b.StrCutDrain)
								if(b.EndTaxDrain)
									src.Target.AddEndTax(b.EndTaxDrain)
								if(b.EndCutDrain)
									src.Target.AddEndCut(b.EndCutDrain)
								if(b.SpdTaxDrain)
									src.Target.AddSpdTax(b.SpdTaxDrain)
								if(b.SpdCutDrain)
									src.Target.AddSpdCut(b.SpdCutDrain)
								if(b.ForTaxDrain)
									src.Target.AddForTax(b.ForTaxDrain)
								if(b.ForCutDrain)
									src.Target.AddForCut(b.ForCutDrain)
								if(b.OffTaxDrain)
									src.Target.AddOffTax(b.OffTaxDrain)
								if(b.OffCutDrain)
									src.Target.AddOffCut(b.OffCutDrain)
								if(b.DefTaxDrain)
									src.Target.AddDefTax(b.DefTaxDrain)
								if(b.DefCutDrain)
									src.Target.AddDefCut(b.DefCutDrain)
								if(b.RecovCutDrain)
									src.Target.AddRecovCut(b.RecovCutDrain)
						if(b.Engrain)
							src.Stasis = 1
						if(b.TimerLimit)
							if(!isnum(b.Timer))
								b.Timer=0
							b.Timer+=world.tick_lag
							if(b.Timer>=b.TimerLimit)
								b.Trigger(src, Override=1) // BUFF END //
								continue

			for(var/obj/Skills/Buffs/SlotlessBuffs/Implants/Internal_Explosive/B in src.Buffs)
				if(B.Using)
					del B

			for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/A in src.Buffs)
				//Activations
				if(!A.SlotlessOn)
					if(A.NeedsPassword)
						if(!A.Password)
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

				if(A.AlwaysOn)//This only gets run if it has been deactivated
					if(A.Using)
						del A

		if(src.Energy<=0)
			src.Energy=1
		src.MaxHealth()
		src.MaxEnergy()
		src.MaxMana()
		src.MaxOxygen()

		if(src.MortallyWounded)
			if(!src.client.color)
				animate(src.client, color=list(1,0,0, 0.25,0.75,0, 0.25,0,0.75, 0,0,0), time=3)
			if(src.KO||src.MortallyWounded>3)
				if(prob(10*src.MortallyWounded/src.RecovOriginal))
					src.Health-=10/max(src.Health,10)
					if(src.Health<=-300)
						if(prob(90/src.RecovOriginal)&&!src.StabilizeModule)
							src.Death(null,"internal injuries!")
						else
							src << "You've entered a stable condition."
							src.MortallyWounded=0



	//Okay, stuff past here may be sources of lag. This is just a comment to note this.
		var/BreathingMaskOn=0
		if(isturf(loc))
			if(!passive_handler.Get("StaticWalk")&&!src.Dead)
				if(istype(loc,/turf/Special/Static))
					src.Health-=0.05
				if(istype(loc,/turf/Dirt99))
					src.Health-=0.05
			if(istype(loc,/turf/Special/Stars)||istype(loc,/turf/Special/EventStars))
				for(var/obj/Items/Tech/SpaceMask/SM in src)
					if(SM.suffix)
						BreathingMaskOn=1
				if(BreathingMaskOn==0)
					if(!passive_handler.Get("SpaceWalk")&&src.Race!="Changeling"&&src.Race!="Android"&&src.Race!="Dragon"&&src.Race!="Majin")
						src.Oxygen-=rand(2,4)
						if(src.Oxygen<0)
							src.Oxygen=0
					if(src.Oxygen<10)
						src.LoseEnergy(20)
						if(src.TotalFatigue>=95)
							src.DamageSelf(TrueDamage(1))
							if(src.Health<-300)
								if(prob(20)&&!src.StabilizeModule)
									src.Death(null,"oxygen deprivation!")
				else if(BreathingMaskOn==1)
					if(src.Oxygen<(src.OxygenMax/max(src.SenseRobbed,1)))
						src.Oxygen+=rand(1,3)
					if(src.icon_state=="Train"&&src.Secret=="Ripple")
						src.Oxygen+=(src.OxygenMax/max(src.SenseRobbed,1))*0.2
						if(src.Oxygen>=(src.OxygenMax/max(src.SenseRobbed,1))*2)
							src.Oxygen=(src.OxygenMax/max(src.SenseRobbed,1))*2
					if(src.Oxygen<10)
						src.LoseEnergy(20)
						if(src.TotalFatigue>=95)
							src.DamageSelf(TrueDamage(1))
							if(src.Health<-300)
								if(prob(20)&&!src.StabilizeModule)
									src.Death(null,"oxygen deprivation!")
			else if(loc:Deluged||istype(loc,/turf/Waters)||istype(loc,/turf/Special/Ichor_Water)||istype(loc,/turf/Special/Midgar_Ichor))
				var/IgnoresWater=0
				if(passive_handler.Get("Fishman")||passive_handler.Get("SpaceWalk")||src.Race in list("Changeling", "Android", "Dragon", "Majin"))
					BreathingMaskOn=1
				for(var/obj/Items/Tech/SpaceMask/SM in src)
					if(SM.suffix)
						BreathingMaskOn=1
				for(var/mob/P in range(1,src))
					if(P.Grab==src)
						IgnoresWater=1
				if((passive_handler.Get("Skimming")+is_dashing) || src.Flying || src.HasWaterWalk() || src.HasGodspeed()>=2)
					IgnoresWater=1
					if(src.Swim)
						src.Swim=0
						src.RemoveWaterOverlay()
						if(isplayer(src))
							src:move_speed = MovementSpeed()
						//do easiest conditions first
						if((src.PoseEnhancement&&src.Secret=="Ripple"&&!(src.Flying&&!passive_handler.Get("Skimming"))+is_dashing))
							src.underlays+=image('The Ripple.dmi', pixel_x=-32, pixel_y=-32)
					else if(src.Secret=="Ripple")
						src.RemoveWaterOverlay()
						if((src.PoseEnhancement&&!src.Flying&&!(passive_handler.Get("Skimming"))+is_dashing))
							src.underlays+=image('The Ripple.dmi', pixel_x=-32, pixel_y=-32)
				if(!IgnoresWater)
					if(istype(loc,/turf/Waters/Water7))
						if(!src.HasWalkThroughHell())
							if(src.Race!="Demon"&&!src.HasHellPower())
								src.AddBurn(10)
					else
						if(src.Burn)
							src.Burn-=(src.Burn/20)
							if(src.Burn<0)
								src.Burn=0
					if(istype(loc,/turf/Special/Ichor_Water) && !src.HasVenomImmune())
						src.AddPoison(2)
					if(istype(loc,/turf/Waters/WaterD) && !src.HasVenomImmune())
						src.AddPoison(2)
					if(istype(loc,/turf/Special/Midgar_Ichor) && !src.HasVenomImmune())
						src.AddPoison(1)
					if(istype(loc,/turf/Special/Midgar_IchorWall) && !src.HasVenomImmune())
						src.AddPoison(1)
					if(istype(loc,/turf/Special/MidgarIchorW) && !src.HasVenomImmune())
						src.AddPoison(1)
					if(istype(loc,/turf/Special/MidgarIchorE) && !src.HasVenomImmune())
						src.AddPoison(1)
					if(istype(loc,/turf/Special/MidgarIchorN) && !src.HasVenomImmune())
						src.AddPoison(1)
					if(istype(loc,/turf/Special/MidgarIchorS) && !src.HasVenomImmune())
						src.AddPoison(1)
					if(Swim==0)
						src.RemoveWaterOverlay()
						spawn()
							if(loc:Deluged)
								src.overlays+=image('WaterOverlay.dmi',"Deluged")
							else if(src.PoseEnhancement&&src.Secret=="Ripple")
								src.underlays+=image('The Ripple.dmi', pixel_x=-32, pixel_y=-32)
							else if(loc.type==/turf/Waters/Water7/LavaTile)
								src.overlays+=image('LavaTileOverlay.dmi')
							else
								src.overlays+=image('WaterOverlay.dmi',"[loc.icon_state]")
					if(!Swim)
						Swim=1
						if(isplayer(src))
							src:move_speed = MovementSpeed()
					if(!src.KO)
						var/amounttaken=2
						if(loc:Shallow==1)
							amounttaken=0
						if(src.PoseEnhancement&&src.Secret=="Ripple")
							amounttaken=0
						if(BreathingMaskOn)
							amounttaken=0
						if(loc:Deluged==1)
							amounttaken=4
						if(Race in list("Dragon","Changeling"))
							amounttaken=0
						if(passive_handler.Get("Fishman")||passive_handler.Get("SpaceWalk"))
							amounttaken=0
						if(src.FusionPowered)
							amounttaken=0
						src.Oxygen-=amounttaken
						if(src.Oxygen<0)
							src.Oxygen=0
						if(src.Oxygen<10)
							src.LoseEnergy(5)
							if(src.TotalFatigue>=95)
								src.Unconscious(null,"fatigue due to swimming! They will drown if not rescued!")
					else
						if(!(src.Race in list("Android","Changeling","Dragon")))
							if(BreathingMaskOn==0)
								src.Oxygen=0
								src.DamageSelf(TrueDamage(1))
								if(src.Health<-300)
									if(prob(20)&&!src.StabilizeModule)
										src.Death(null,"oxygen deprivation!")
							else
								if(src.Oxygen<(src.OxygenMax/max(src.SenseRobbed,1)))
									src.Oxygen=min(src.Oxygen+(rand(1,3)),(src.OxygenMax/max(src.SenseRobbed,1)))
								if(src.Oxygen<10)
									src.LoseEnergy(20)
									if(src.TotalFatigue>=95)
										src.DamageSelf(TrueDamage(1))
										if(src.Health<-300)
											if(prob(20)&&!src.StabilizeModule)
												src.Death(null,"oxygen deprivation!")
			else
				if(Swim==1)
					src.RemoveWaterOverlay()
					Swim=0
					if(isplayer(src))
						src:move_speed = MovementSpeed()
				if(src.Oxygen<(src.OxygenMax/max(src.SenseRobbed,1)))
					src.Oxygen=min(src.Oxygen+(rand(1,3)),(src.OxygenMax/max(src.SenseRobbed,1)))
				if(src.icon_state=="Train"&&src.Secret=="Ripple")
					src.Oxygen+=(src.OxygenMax/max(src.SenseRobbed,1))*0.2
					if(src.Oxygen>=(src.OxygenMax/max(src.SenseRobbed,1))*2)
						src.Oxygen=(src.OxygenMax/max(src.SenseRobbed,1))*2
				if(src.Oxygen<10)
					src.LoseEnergy(20)
					if(src.TotalFatigue>=95)
						src.DamageSelf(TrueDamage(1))
						if(src.Health<-300)
							if(prob(20)&&!src.StabilizeModule)
								src.Death(null,"oxygen deprivation!")

		if(src.AFKTimer>0)
			src.AFKTimer-=1
			if(src.AFKTimer==0)
				src.overlays+=src.AFKIcon
				for(var/mob/E in hearers(12,src))
					if(E.Timestamp)
						E<<"<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=#D344E3>[src] has gone AFK!"
						Log(E.ChatLog(),"<font color=green>[src]([src.key]) has gone AFK!")
					else
						E<<"<font color=#D344E3>[src] has gone AFK!"
						Log(E.ChatLog(),"<font color=green>[src]([src.key]) has gone AFK!")

		if(prob(0.1))
			src.client.SaveChar()
		if(AFKTimer)
			Available_Power()