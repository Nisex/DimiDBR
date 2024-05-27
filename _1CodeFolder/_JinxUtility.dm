#define GLOBAL_LEAK_REDUCTION 1.2
#define isplayer(x) istype(x,/mob/Players)
#define DEBUFF_EFFECTIVENESS (0.004)

mob
	proc
		AscAvailable()
			src.potential_ascend(Silent=1)
			if(race.ascensions.len==0) return
			for(var/a in race.ascensions)
				var/ascension/asc = a
				if(!asc.applied&&!asc:checkAscensionUnlock(src,Potential)) continue
				asc.onAscension(src)

		DamageSelf(var/val, trueDmg)
			if(val < 0)
				val = 0.015
			if(src.Health-val<=src.AngerPoint*(1-src.HealthCut))
				if(!src.Anger&&!src.HasCalmAnger()&&!src.HasNoAnger()&&!src.AngerCD)
					src.Anger()
					val/=src.AngerMax
			if(src.VaizardHealth)
				src.VaizardHealth-=val
				if(src.VaizardHealth<=0)
					if(src.ActiveBuff)
						if(src.ActiveBuff.VaizardShatter)
							src.ActiveBuff.Trigger(src)
					if(src.SpecialBuff)
						if(src.SpecialBuff.VaizardShatter)
							src.SpecialBuff.Trigger(src)
					for(var/sb in SlotlessBuffs)
						var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
						if(b)
							if(b.VaizardShatter)
								b.Trigger(src)
					if(src.VaizardHealth<0)
						val=((-1)*src.VaizardHealth)
						src.VaizardHealth=0
					else
						val=0
				else
					val=0
			if(src.BioArmor)
				src.BioArmor-=val
				if(src.BioArmor<=0)
					val=(-1)*src.BioArmor
					src.BioArmor=0
				else
					val=0
			var/desp = passive_handler.Get("Desperation")
			if(prob(desp)*10&&!src.HasInjuryImmune())
				src.WoundSelf(val/desp)//Take all damage as wounds
				val=0//but no health damage.
			src.Health-=val
			if(src.CursedWounds())
				src.WoundSelf(val)
			if(src.Health<=0&&!src.KO)
				if(src.Burn&&src.Poison)
					src.Unconscious(null, "succumbing to terrible pain!")
				if(src.Burn&&!src.Poison)
					src.Unconscious(null, "getting burned out!")
				if(src.Poison&&!src.Burn)
					src.Unconscious(null, "succumbing to poison!")
				if(!src.Burn&&!src.Poison)
					src.Unconscious()

		DoDamage(var/mob/defender, var/val, var/UnarmedAttack=0, var/SwordAttack=0, var/SecondStrike, var/ThirdStrike, var/TrueMult=0, var/SpiritAttack=0, var/Destructive=0)
			#if DEBUG_DAMAGE
			log2text("Damage", "Start DoDamage", "damageDebugs.txt", src.ckey)
			log2text("Damage", val, "damageDebugs.txt", src.ckey)
			#endif
			val = newDoDamage(defender, val, UnarmedAttack, SwordAttack, SecondStrike, ThirdStrike, TrueMult, SpiritAttack, Destructive)
			if(src.HasPurity())//If damager is pure
				var/found=0//Assume you haven't found a proper target
				if(!src.HasBeyondPurity())//if you can say fuck off to purity...
					if(src.HasHolyMod())//Holy things
						if(defender.IsEvil())//Kill evil things
							found=1
					if(!found)//If you don't find what you're supposed to hunt
						return//Do not do damage

			fieldAndDefense(defender, UnarmedAttack, SwordAttack, SpiritAttack, val)

			// if(defender.UsingVoidDefense())
			// 	if(defender.TotalFatigue>0)
			// 		defender.HealFatigue(val/2)
			// 	else
			// 		defender.HealWounds(val/2)
			// 	defender.HealEnergy(val)
			// 	defender.HealMana(val)

			// if(defender.HasDeathField()&&(UnarmedAttack||SwordAttack))
			// 	src.WoundSelf(defender.GetDeathField()*0.01*min((1/val),1))
			// if(defender.HasVoidField()&&SpiritAttack)
			// 	src.GainFatigue(defender.GetVoidField()*0.01*min((1/val),1))

			if(src.HasSoftStyle())
				defender.GainFatigue(val*0.4*src.GetSoftStyle())
			if(src.HasHardStyle())
				if(!src.CursedWounds())
					src.DealWounds(defender, val*0.1*src.GetHardStyle())
			if(src.HasCyberStigma())
				if(defender.CyberCancel||defender.Mechanized)
					defender.LoseMana(val*max(defender.Mechanized,defender.CyberCancel)*src.GetCyberStigma())

			if(locate(/obj/Skills/Zanzoken, defender))
				if(defender.MovementCharges<3)
					defender.MovementChargeBuildUp(val)

			if(defender.VaizardHealth)
				defender.VaizardHealth-=val
				if(defender.VaizardHealth<=0)
					if(defender.ActiveBuff)
						if(defender.ActiveBuff.VaizardShatter)
							defender.ActiveBuff.Trigger(defender)
					if(defender.SpecialBuff)
						if(defender.SpecialBuff.VaizardShatter)
							defender.SpecialBuff.Trigger(defender)
					for(var/sb in defender.SlotlessBuffs)
						var/obj/Skills/Buffs/SlotlessBuffs/b = defender.SlotlessBuffs[sb]
						if(b)
							if(b.VaizardShatter)
								b.Trigger(defender)
					if(defender.VaizardHealth<0)
						val=((-1)*defender.VaizardHealth)
						defender.VaizardHealth=0
				else
					val=0

			if(defender.BioArmor)
				defender.BioArmor-=val
				if(defender.BioArmor<0)
					val=(-1)*defender.BioArmor
					defender.BioArmor=0
				else
					val=0

			if(defender.Health-val<=defender.AngerPoint*(1-defender.HealthCut))
				if(!defender.Anger&&!defender.HasCalmAnger()&&!defender.HasNoAnger()&&!defender.AngerCD)
					defender.Anger()
					val/=defender.AngerMax

			if(defender.Desperation&&!defender.HasInjuryImmune())
				if(FightingSeriously(src,defender))
					if(prob(5*defender.Desperation))
						defender.WoundSelf(val/sqrt(1+defender.Desperation))//Take all damage as wounds
						val=0//reduce damag ehard

			if(defender.KO&&!src.Lethal)
				val=0

			if(defender.CheckSpecial("Kamui Unite") && defender.GodKi < 1)
				val+=(1-defender.GodKi)
				if(defender.Health<=10)
					defender.TotalInjury=0
					defender.TotalFatigue=0
					defender.Health += (100 * (1 - defender.GodKi))
					defender.Energy += (100 * (1 - defender.GodKi))
					defender.BPPoison=1
					defender.GodKi+=0.25
					OMsg(defender, "<font color='red'><font size=+2>[defender] stitches themselves back together with life fibers!</font size></font color>")


			if(istype(defender, /mob/Player/AI))

				var/mob/Player/AI/aa = defender
				if(!istype(src, /mob/Player/AI))
					if(aa.ai_hostility >= 1)
						if(aa.inloop == FALSE && !(aa in ticking_ai)) // not even needed but i have a creeping suspicion that ai are getting added multiple times
							ticking_ai.Add(aa)
						aa.Target=src
						aa.ai_state = "Chase"
						aa.last_activity = world.time

			if(defender.CheckSlotless("Crystal Wall"))
				src.LoseHealth(val)
				return
			var/tmpval = val
/*
			if(defender.key=="Vuffa" && defender.findVuffa())
				if(defender.findVuffa().vuffaMoment)
					tmpval*=1000000
					if(defender.findVuffa().vuffaMessage)
						OMsg(defender, "<font color='[rgb(255, 0, 0)]'>[defender.findVuffa().vuffaMessage]</font color>")
					else
						OMsg(src, "<font color='[rgb(255, 0, 0)]'>[defender] takes a critical hit! They take [val] damage!</font color>")
*/
			defender.LoseHealth(max(0,tmpval))

			if(defender.Flying)
				var/obj/Items/check = defender.EquippedFlyingDevice()
				if(istype(check))
					check.ObjectUse(defender)
					defender << "You are knocked off your flying device!"

			if(UnarmedAttack || SwordAttack || SpiritAttack)

				if(src.StyleBuff)
					if(src.Tension<100 && !src.HasTensionLock())
						src.Tension+=(val) * glob.TENSION_MULTIPLIER

				if(defender.StyleBuff&&defender.StyleBuff)
					if(defender.Tension<100 && !defender.HasTensionLock())
						defender.Tension+=(val*0.75) * glob.TENSION_MULTIPLIER
			var/leakVal = val/GLOBAL_LEAK_REDUCTION


			if(src.HasEnergyLeak())
				src.LoseEnergy(src.GetEnergyLeak()*0.25*leakVal)
			if(defender.HasEnergyLeak())
				defender.LoseEnergy((defender.GetEnergyLeak()*0.25*leakVal)/4)

			if(src.HasFatigueLeak())
				src.GainFatigue(src.GetFatigueLeak()*0.25*leakVal)
			if(defender.HasFatigueLeak())
				defender.GainFatigue((src.GetFatigueLeak()*0.25*leakVal)/4)

			if(src.HasManaLeak())
				src.LoseMana(src.GetManaLeak()*0.25*leakVal, 1)
			if(defender.HasManaLeak())
				defender.LoseMana((defender.GetManaLeak()*0.25*leakVal)/4, 1)

			if(src.HasBleedHit())
				src.WoundSelf(src.GetBleedHit()*0.25*leakVal)

			var/mortalStrike = GetMortalStrike()
			if(mortalStrike > 0  && FightingSeriously(src, 0))
				if(val > clamp(6 / mortalStrike, 3, 20) && prob(25 * mortalStrike))
					if(!defender.MortallyWounded) // the last time, plus the timer
						defender.MortallyWounded += 1
						var/dmg = defender.Health * 0.15
						defender.LoseHealth(dmg)
						defender.WoundSelf(dmg)
						OMsg(defender, "<font color='red'><font size=+2><b>[src] mortally wounded [defender] with a devistating attack!</b></font size></font color>")
			if(src.HasMaimStrike()&&FightingSeriously(src, 0))
				if(val>(6*glob.WorldDamageMult/src.GetMaimStrike())&&defender.Maimed<4 && world.realtime > MaimCooldown+Day(0.75))
					defender.Maimed+=1
					OMsg(defender, "<font color='red'><font size=+2><b>[src] maimed [defender] with a brutal attack!</b></font size></font color>")
				else if(val>(3*glob.WorldDamageMult/src.GetMaimStrike())&&defender.Tail)
					defender.Tail=0
					OMsg(defender, "<font color='red'><font size=+2><b>[src] took off [defender]'s tail!</b></font size></font color>")
			if(passive_handler.Get("Gluttony") && FightingSeriously(src, 0))
				var/amount = val * (passive_handler.Get("Gluttony") * SpecialBuff:hungerMult)
				defender.LoseMana(amount/2)
				defender.LoseCapacity(amount/2)
				SpecialBuff:eatEnergies(amount * 10)
				defender.TotalFatigue+=amount/2
				Update_Stat_Labels()


			if(passive_handler.Get("SoulFire")&&FightingSeriously(src, 0))
				if(!(defender.CyberCancel || defender.Mechanized))
					defender.LoseMana(val*(passive_handler.Get("SoulFire")/4),1)
					defender.LoseCapacity(val*0.25*passive_handler.Get("SoulFire"))
				defender.TotalFatigue+=val*0.25*passive_handler.Get("SoulFire")

			if(defender.CheckSlotless("Protega"))
				src.LoseHealth(val/10)
			if(defender.MeltyBlood)
				if(defender.Health<50*(1-src.HealthCut))
					if(FightingSeriously(src,0))
						if(!defender.MeltyMessage)
							defender.MeltyMessage=1
							OMsg(defender, "<font color='red'>[defender]'s blood burns through all it comes in contact with!</font>")
						src.AddBurn(val, defender)
			if(defender.passive_handler.Get("VenomBlood"))
				if(defender.Health<50*(1-src.HealthCut))
					if(FightingSeriously(src,0))
						if(!defender.VenomMessage)
							defender.VenomMessage+=1
							OMsg(defender, "<font color='red'>[defender]'s toxic blood sprays out!</font>")
						src.AddPoison(val*0.5, defender)


			if(defender.Health<=defender.AngerPoint*(1-src.HealthCut)&&defender.passive_handler.Get("Defiance")&&!defender.Oozaru)
				if(defender.DefianceCounter<10)
					if(defender.Anger)
						if(val>=(1/defender.AscensionsAcquired)&&val<(2/defender.AscensionsAcquired))
							defender.DefianceCounter+=1
							defender.OMessage(10,"<font color=red>[defender]'s defiance sparks!","Defiance (1) passive.")
						else if(val>=(2/defender.AscensionsAcquired)&&val<(4/defender.AscensionsAcquired))
							defender.DefianceCounter+=2
							defender.OMessage(10,"<font color=red>[defender] grows more defiant!","Defiance (2) passive.")
						else if(val>=(4/defender.AscensionsAcquired))
							defender.DefianceCounter+=5
							defender.OMessage(10,"<font color=red>[defender] roars in complete defiance of odds!","Defiance (3) passive.")
						if(defender.DefianceCounter>10)
							defender.DefianceCounter=10

			if(defender.HasAdaptation()&&src==defender.Target||src.HasAdaptation()&&defender==src.Target)
				if(defender.HasAdaptation()&&!defender.Oozaru)
					defender.AdaptationTarget=src
					defender.AdaptationCounter+=(val*(defender.AscensionsAcquired/40))
					if(defender.AdaptationCounter>=1)
						defender.AdaptationCounter=1
						if(!defender.AdaptationAnnounce)
							defender << "<b>You've adapted to your target's style!</b>"
							defender.AdaptationAnnounce=1
				if(src.HasAdaptation()&&!src.Oozaru)
					src.AdaptationTarget=defender
					src.AdaptationCounter+=(val*(src.AscensionsAcquired/40))
					if(src.AdaptationCounter>=1)
						src.AdaptationCounter=1
						if(!src.AdaptationAnnounce)
							src << "<b>You've adapted to your target's style!</b>"
							src.AdaptationAnnounce=1
// ADD HERE THE FUCKING FUTURE DIARY SHIT
			if(src.HasWeaponBreaker()||defender.Saga=="Unlimited Blade Works")
				if((defender.HasSword()||defender.HasStaff()||defender.HasArmor())&&(UnarmedAttack||SwordAttack))
					var/obj/Items/Sword/s=defender.EquippedSword()
					var/obj/Items/Enchantment/Staff/st=defender.EquippedStaff()
					var/obj/Items/Armor/ar=defender.EquippedArmor()
					// Equip
					var/shatterTier = defender.GetShatterTier(s) // isn't even used i think
					var/addWeaponBreaker = 0
					if(AttackQueue&&AttackQueue.WeaponBreaker)
						addWeaponBreaker += AttackQueue.WeaponBreaker
					var/breakTicks = (GetWeaponBreaker()+addWeaponBreaker) / 3 * glob.WEAPON_BREAKER_EFFECTIVENESS
					var/duraBoon = 2 // SWORD DURA VARS
					var/duraBase = 1 // SWORD DURA VARS
					// Breaker Vars
					var/SwordQuality
					var/StaffQuality
					var/ArmorQuality

					if(s)
						SwordQuality=min(s.Ascended+defender.GetSwordAscension(),6)
					if(st)
						StaffQuality=min(st.Ascended+defender.GetStaffAscension(),6)
					if(ar)
						ArmorQuality=min(ar.Ascended+defender.GetArmorAscension(),6)

					if(defender.UsingKendo()&&defender.HasSword())
						if(s.Class=="Wooden")
							SwordQuality+=1
						if(src.StyleActive=="Shinzan")
							SwordQuality+=3
						if(SwordQuality > 7)
							SwordQuality=7



					if(s)
						if(s.Destructable)
							s.startBreaking(val, breakTicks+shatterTier / (duraBoon * SwordQuality + duraBase), defender, src, "sword")
					if(st)
						if(st.Destructable)
							st.startBreaking(val, breakTicks / (duraBoon * StaffQuality + duraBase), defender, src, "staff")
					if(ar)
						if(ar.Destructable)
							ar.startBreaking(val, breakTicks / (duraBoon * ArmorQuality + duraBase), defender, src, "armor")

					if(defender.EquippedSecondSword())
						var/obj/Items/Sword/s2=defender.EquippedSecondSword()
						var/Sword2Quality=min(s2.Ascended+defender.GetSwordAscension(),6)
						if(s2&&s2.Destructable)
							s.startBreaking(val, breakTicks / (duraBoon * Sword2Quality + duraBase), defender, src, "sword")
					if(defender.EquippedThirdSword())
						var/obj/Items/Sword/s3=defender.EquippedThirdSword()
						var/Sword3Quality=min(s3.Ascended+defender.GetSwordAscension(),6)
						if(s3&&s3.Destructable)
							s.startBreaking(val, breakTicks / (duraBoon * Sword3Quality + duraBase), defender, src, "sword")

			// if(defender.HasWeaponBreaker())
			// 	if((src.HasSword()||src.HasStaff()||src.HasArmor())&&(UnarmedAttack||SwordAttack))
			// 		var/obj/Items/Sword/s=src.EquippedSword()
			// 		var/obj/Items/Enchantment/Staff/st=src.EquippedStaff()
			// 		var/obj/Items/Armor/ar=src.EquippedArmor()

			// 		var/SwordQuality
			// 		var/StaffQuality
			// 		var/ArmorQuality

			// 		if(s)
			// 			SwordQuality=min(s.Ascended+src.GetSwordAscension(),6)
			// 		if(st)
			// 			StaffQuality=min(st.Ascended+src.GetStaffAscension(),6)
			// 		if(ar)
			// 			ArmorQuality=min(ar.Ascended+src.GetArmorAscension(),6)

			// 		if(src.UsingKendo()&&src.HasSword())
			// 			if(s.Class=="Wooden")

			if(defender.HasLifeGeneration())
				defender.HealHealth(defender.GetLifeGeneration()/10 * val)
				if(defender.Health>=100-100*defender.HealthCut-defender.TotalInjury)
					defender.HealWounds(0.2*defender.GetLifeGeneration()/10 * val)
			if(src.HasEnergyGeneration())
				src.HealFatigue(0.2*src.GetEnergyGeneration()/10 * val)
				src.HealEnergy(src.GetEnergyGeneration()/10 * val)
			if(defender.HasEnergyGeneration() * val)
				defender.HealFatigue(0.2*defender.GetEnergyGeneration()/10 * val)
				defender.HealEnergy(defender.GetEnergyGeneration()/10 * val)
			if(src.HasManaGeneration())
				src.HealMana(src.GetManaGeneration()/10)
			if(defender.HasManaGeneration())
				defender.HealMana(defender.GetManaGeneration()/10)
			if(src.ActiveBuff&&src.CheckActive("Keyblade")&&!src.SpecialBuff)
				src.ManaAmount+=(0.25*src.SagaLevel)
			if(defender.ActiveBuff&&defender.CheckActive("Keyblade")&&!defender.SpecialBuff)
				defender.ManaAmount+=(0.25*defender.SagaLevel)

			if(src.HellPower&&!src.transActive())
				src.HealMana(1)
			if(defender.HellPower&&!src.transActive())
				defender.HealMana(1)

			if(src.SlotlessBuffs)
				if(src.CheckSlotless("Frost End"))
					if(SwordAttack&&defender.Stunned)
						defender.overlays+='IceCoffin.dmi'
						defender.StasisStun=1
				if(src.CheckSlotless("AntiForm"))
					src.ManaAmount-=1
					if(src.ManaAmount<0)
						ManaAmount=0
				if(defender.CheckSlotless("OverSoul")&&defender.BoundLegend=="Caledfwlch")
					if(!defender.Shielding)
						defender.Shielding=1
						spawn()
							defender.AvalonField()

			if(src.HasSoulSteal())
				var/Amt=val*src.GetSoulSteal()
				var/Cap=15*src.GetSoulSteal()
				src.VaizardHealth+=Amt
				if(src.VaizardHealth>Cap)
					src.VaizardHealth=Cap

			// WEREWOLF HUNGER MECHANIC
			if(src.Secret == "Werewolf" && CheckSlotless("New Moon Form"))
				var/SecretInfomation/Werewolf/s = src.secretDatum
				s.addHunger(val)
				Update_Stat_Labels()
			//END WEREWOLF HUNGER MECHANIC

			if(src.Secret == "Eldritch")
				var/SecretInfomation/Eldritch/s = src.secretDatum
				s.addMadness(val)
				Update_Stat_Labels()

			if(defender.Secret == "Eldritch")
				var/SecretInfomation/Eldritch/s = defender.secretDatum
				s.addMadness(val)
				defender.Update_Stat_Labels()

			if(src.HasLifeSteal())
				var/CursedBlood=0
				var/NoBlood=0
				NoBlood=defender.CyberCancel
				if(defender.Race=="Android"||defender.isRace(ELDRITCH)||defender.Secret=="Zombie"||defender.Dead)
					NoBlood=1
				var/Effectiveness=1
				if(NoBlood>0)
					Effectiveness-=(Effectiveness*NoBlood)
				if(defender.MeltyBlood)
					CursedBlood=1
					src.AddBurn(val*Effectiveness)
				if(defender.VenomBlood)
					CursedBlood=1
					src.AddPoison(val*Effectiveness,defender)
					src.AddBurn(val,defender)
				if(!CursedBlood)
					src.HealHealth(val*src.GetLifeSteal()*Effectiveness/100)
					if(src.Health>=(100-100*src.HealthCut-src.TotalInjury))
						src.HealWounds(0.2*val*src.GetLifeSteal()*Effectiveness/100)
			if(src.HasLifeStealTrue())
				defender.AddHealthCut(val/200)
				if(defender.HealthCut>=0.15)
					defender.HealthCut=0.15
				src.HealthCut-=(val/100)
				if(src.HealthCut<=0)
					src.HealthCut=0
			if(src.HasEnergySteal())
				var/Effectiveness=1
				if(defender.CyberCancel>0)
					Effectiveness-=(Effectiveness*defender.CyberCancel)
				src.HealEnergy(val*(src.GetEnergySteal()*Effectiveness/100))
				defender.LoseEnergy(val*(src.GetEnergySteal()*Effectiveness/100))
			if(HasManaSteal())
				var/value = val * (GetManaSteal() / 100)
				HealMana(value)
				defender.LoseMana(value)

			if(src.HasErosion())
				var/Erosion = src.GetErosion()
				var/MPow=defender.Power_Multiplier/8
				var/BPCap=MPow*Erosion
				var/MStr=defender.GetStrMult()
				var/StrCap=MStr*Erosion
				var/MEnd=defender.GetEndMult()
				var/EndCap=MEnd*Erosion
				var/MSpd=defender.GetSpdMult()
				var/SpdCap=MSpd*Erosion
				var/MFor=defender.GetForMult()
				var/ForCap=MFor*Erosion
				var/MOff=defender.GetOffMult()
				var/OffCap=MOff*Erosion
				var/MDef=defender.GetDefMult()
				var/DefCap=MDef*Erosion
				var/MRecov=defender.GetRecovMult()
				var/RecovCap=MRecov*Erosion
				if(MPow>0)
					defender.PowerEroded+=(BPCap/45)*val
					if(defender.PowerEroded>BPCap)
						defender.PowerEroded=BPCap
				if(MStr>1)
					defender.StrEroded+=(StrCap/45)*val
					if(defender.StrEroded>StrCap)
						defender.StrEroded=StrCap
				if(MEnd>1)
					defender.EndEroded+=(EndCap/45)*val
					if(defender.EndEroded>EndCap)
						defender.EndEroded=EndCap
				if(MSpd>1)
					defender.SpdEroded+=(SpdCap/45)*val
					if(defender.SpdEroded>SpdCap)
						defender.SpdEroded=SpdCap
				if(MFor>1)
					defender.ForEroded+=(ForCap/45)*val
					if(defender.ForEroded>ForCap)
						defender.ForEroded=ForCap
				if(MOff>1)
					defender.OffEroded+=(OffCap/45)*val
					if(defender.OffEroded>OffCap)
						defender.OffEroded=OffCap
				if(MDef>1)
					defender.DefEroded+=(DefCap/45)*val
					if(defender.DefEroded>DefCap)
						defender.DefEroded=DefCap
				if(MRecov>1)
					defender.RecovEroded+=(RecovCap/45)*val
					if(defender.RecovEroded>RecovCap)
						defender.RecovEroded=RecovCap


			if(passive_handler.Get("StealsStats")||src.ElementalOffense=="Void")
				var/Effective=1
				if(passive_handler.Get("StealsStats"))
					Effective*=passive_handler.Get("StealsStats")
				var/MStr=defender.GetStrMult()
				var/MEnd=defender.GetEndMult()
				var/MSpd=defender.GetSpdMult()
				var/MFor=defender.GetForMult()
				var/MOff=defender.GetOffMult()
				var/MDef=defender.GetDefMult()
				if(MStr>1)
					if(src.StrStolen<(MStr-1))
						src.StrStolen+=(((MStr-1)*0.025*Effective)*val)
						if(src.StrStolen>(MStr-1))
							src.StrStolen=(MStr-1)
				if(MEnd>1)
					if(src.EndStolen<(MEnd-1))
						src.EndStolen+=(((MEnd-1)*0.025*Effective)*val)
						if(src.EndStolen>(MEnd-1))
							src.EndStolen=(MEnd-1)
				if(MSpd>1)
					if(src.SpdStolen<(MSpd-1))
						src.SpdStolen+=(((MSpd-1)*0.025*Effective)*val)
						if(src.SpdStolen>(MSpd-1))
							src.SpdStolen=(MSpd-1)
				if(MFor>1)
					if(src.ForStolen<(MFor-1))
						src.ForStolen+=(((MFor-1)*0.025*Effective)*val)
						if(src.ForStolen>(MFor-1))
							src.ForStolen=(MFor-1)
				if(MOff>1)
					if(src.OffStolen<(MOff-1))
						src.OffStolen+=(((MOff-1)*0.025*Effective)*val)
						if(src.OffStolen>(MOff-1))
							src.OffStolen=(MOff-1)
				if(MDef>1)
					if(src.DefStolen<(MDef-1))
						src.DefStolen+=(((MDef-1)*0.025*Effective)*val)
						if(src.DefStolen>(MDef-1))
							src.DefStolen=(MDef-1)

			if(FightingSeriously(src,0))
				var/WoundsInflicted
				var/obj/Items/Sword/s=src.EquippedSword()
				var/obj/Items/Enchantment/Staff/st=src.EquippedStaff()
				if(src.CursedWounds())
					if(defender.UsingMuken())
						WoundsInflicted=val/defender.GetEnd()
					else
						WoundsInflicted=val
				else if(src.HasPurity()&&defender.IsEvil())
					WoundsInflicted=val
				else if(s||st)
					if(((s&&s.Element=="Silver")||(st&&st.Element=="Silver"))&&defender.IsEvil())
						WoundsInflicted=val
					else if(src.SwordWounds())
						WoundsInflicted=val/clamp(defender.GetRecov(1.75)/(GetSwordDamage(s)), 1.5, 5)
					else
						WoundsInflicted=val/max(defender.GetRecov(1.75), 1.5)
				else
					WoundsInflicted=val/max(defender.GetRecov(1.75), 1.5)
				if(WoundsInflicted<0)
					WoundsInflicted=0.001
				src.DealWounds(defender, WoundsInflicted)

			if(isplayer(defender))
				defender:move_speed = defender.MovementSpeed()
			if(isplayer(src))
				src:move_speed = MovementSpeed()

			if(defender.Health<=0&&Destructive>0)
				defender.Death(src, "being completely obliterated!", SuperDead=1, NoRemains=2)
				return


			if(defender.KO && istype(defender, /mob/Player/AI))
				var/mob/Player/AI/a = defender
				if(!a.ai_owner)
					a.Death(src, null)
					if(src.Frozen)
						src.Frozen=0
					return
			if(defender.Health<=0&&!defender.KO)
				defender.Unconscious(src)
			else if(defender.Health<=0&&defender.KO&&src.Lethal)
				if(istype(EquippedSword(), /obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Ruin))
					if(defender.client)
						var/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Ruin/bor=EquippedSword()
						bor.onKill(src, defender)
				defender.Death(src, null)


		DealWounds(var/mob/defender, var/val, var/FromSelf=0)
			if(defender.CyberCancel)
				val*=(1-defender.CyberCancel)
			if(defender.BioArmor)
				return
			// if(src.isRace(MAJIN))
			// 	val*=0.25
			if(defender.HasCeramicPlating()||defender.HasPlatedWeights())
				if(defender.HasPlatedWeights())
					if(!defender.HasInjuryImmune())
						defender.TotalInjury+=val/2
				else
					var/obj/Items/Plating/P=defender.EquippedPlating()
					if(P.PlatedHealth>0)
						P.PlatedHealth-=val
						if(P.PlatedHealth<0)
							if(!defender.HasInjuryImmune())
								defender.TotalInjury+=(P.PlatedHealth*(-1))
							P.PlatedHealth=0
						if(P.PlatedHealth<=0)
							defender << "<font size=+1>Your ceramic plating has been shattered!</font size>"
						P.suffix="*Broken*"
						del P
			else
				if(!defender.HasInjuryImmune())
					defender.TotalInjury+=val
			if(defender.TotalInjury>=99)
				defender.TotalInjury=99
			defender.MaxHealth()
		WoundSelf(var/val)
			if(src.BioArmor)
				src.DamageSelf(val)
				return
			// if(src.isRace(MAJIN))
			// 	val*=0.25
			if(!src.HasInjuryImmune())
				src.TotalInjury+=val
			if(src.TotalInjury>=99)
				src.TotalInjury=99
			if(src.TotalInjury==50)
				src << "<font size=+1>You are extremly wounded!</font size>"
			if(src.TotalInjury< 0)
				TotalInjury = 0
			src.MaxHealth()
		LoseHealth(var/val)
			src.Health-=val
			src.MaxHealth()
			if(Race == "Majin")
				if(majinPassive != null)
					majinPassive.tryDropBlob(src)
		LoseEnergy(var/val)
			if(src.FusionPowered)
				return
			val/=1+src.GetKiControlMastery()
			val*=src.Power_Multiplier
			if(src.GetPowerUpRatio()>1)
				var/PowerUpPercent=GetPowerUpRatio()-1
				if(src.HasMovementMastery())
					PowerUpPercent/=1+(src.GetMovementMastery()/8)
				val*=(1+(PowerUpPercent/src.PUDrainReduction))
			if(src.Kaioken)
				if(src.Anger)
					val*=src.Anger
			if(src.PotionCD)
				val*=1.25
			src.Energy-=val
			if(src.Energy<0)
				src.Energy=0
			if(src.Energy<=10 && src.HasHealthPU() && src.PowerControl>100)
				src.PowerControl=100
				src << "You lose your gathered power..."
				src.Auraz("Remove")
				src<<"You are too tired to power up."
				src.PoweringUp=0
			src.GainFatigue(val/30)
		GainFatigue(var/val)
			if(src.FusionPowered)
				return
			val/=1+src.GetKiControlMastery()
			val*=src.EnergyExpenditure*src.Power_Multiplier
			if(src.GetPowerUpRatio()>1 && !src.GatesActive)
				var/PowerUpPercent=GetPowerUpRatio()-1
				if(src.HasMovementMastery())
					PowerUpPercent/=1+(src.GetMovementMastery()/8)
				val*=(1+(PowerUpPercent/src.PUDrainReduction))
			if(src.Kaioken)
				if(src.Anger)
					val*=src.Anger
			if(src.PotionCD)
				val*=1.25
			// if(src.isRace(MAJIN))
			// 	val*=0.25
			if(!src.HasFatigueImmune())
				src.TotalFatigue+=val
			if(src.TotalFatigue>99)
				src.TotalFatigue=99
			src.MaxEnergy()
		LoseMana(var/val, var/Override=0)
			val*=src.EnergyExpenditure*src.Power_Multiplier
			if(src.HasDrainlessMana()&&!Override)
				return//Nope.
			if(src.PotionCD)
				val*=1.25
			src.ManaAmount-=val
			if(src.ManaAmount<=0)
				src.ManaAmount=0
		LoseCapacity(var/val)
			val/=src.GetManaCapMult()
			if(src.PotionCD)
				val*=1.25
			src.TotalCapacity+=val
			if(src.TotalCapacity>=100)
				src.TotalCapacity=100
		HealHealth(var/val)
			if(src.Sheared)
				if(src.HasHellPower())
					src.Sheared-=val/(2/src.HasHellPower())
					if(src.Sheared<0)
						val+=(-1)*src.Sheared
						src.Sheared=0
					else
						val=val/(2/src.HasHellPower())
				else
					src.Sheared-=val
					if(src.Sheared<0)
						val=(-1)*src.Sheared
						src.Sheared=0
					else
						val=val/3
			if(src.PotionCD)
				val/=1.25
			if(icon_state == "Meditate")
				src.Tension=max(0, Tension-(val*1.5))
			else if(Tension != 100)
				src.Tension=max(0, Tension-(val*0.75))
			src.Health+=val
			src.MaxHealth()
		HealEnergy(var/val, var/StableHeal=0)
			if(!src.FusionPowered&&!StableHeal)
				val/=src.GetPowerUpRatio()
				val/=src.EnergyExpenditure*src.Power_Multiplier
			if(src.PotionCD)
				val/=1.25
			src.Energy+=val
			src.MaxEnergy()
		HealMana(var/val, var/StableHeal=0)
			if(!src.FusionPowered&&!StableHeal)
				val/=src.GetPowerUpRatio()
				val/=src.EnergyExpenditure*src.Power_Multiplier
			if(src.PotionCD)
				val/=1.25
			if(is_arcane_beast)
				val *= max(1,ManaCapMult)
			src.ManaAmount+=val
			src.MaxMana()
		HealWounds(var/val, var/StableHeal=0)
			if(src.Sheared)
				src.Sheared-=val
				if(src.Sheared<0)
					val=(-1)*src.Sheared
					src.Sheared=0
				else
					val=0
			if(src.PotionCD)
				val/=1.25
			src.TotalInjury-=val
			if(src.TotalInjury < 0)
				src.TotalInjury=0
			src.MaxHealth()
		HealFatigue(var/val, var/StableHeal=0)
			if(!src.FusionPowered&&!StableHeal)
				val*=1/src.GetPowerUpRatio()
			if(src.PotionCD)
				val/=1.25
			src.TotalFatigue-=val
			if(src.TotalFatigue < 0)
				src.TotalFatigue=0
			src.MaxEnergy()
		HealCapacity(var/val, var/StableHeal=0)
			if(src.PotionCD)
				val/=1.25
			src.TotalCapacity-=val
			if(src.TotalCapacity<=0)
				src.TotalCapacity=0
			src.MaxMana()
		MaxHealth()
			var/HasWounds=1
			if(src.HasUnstoppable()||src.Secret=="Zombie")
				HasWounds=0
			var/KeyHealth=100-(src.TotalInjury*HasWounds)
			var/Sub
			var/Cut
			if(src.HealthCut)
				Sub=KeyHealth*src.HealthCut
				Cut=KeyHealth-Sub
				if(src.Health > Cut)
					src.Health=Cut
			if(src.Health > KeyHealth)
				src.Health=KeyHealth
		MaxEnergy()
			var/HasFatigue=1
			if(src.HasUnstoppable()||src.Secret=="Zombie")
				HasFatigue=0
			if(src.Anaerobic)
				HasFatigue=0.7/(src.Anaerobic)
			var/KeyEnergy=100-(src.TotalFatigue*HasFatigue)
			var/Sub
			var/Cut
			if(src.EnergyCut)
				Sub=KeyEnergy*src.EnergyCut
				Cut=KeyEnergy-Sub
				if(src.Energy > Cut)
					src.Energy=Cut
			if(src.Energy > KeyEnergy)
				src.Energy=KeyEnergy
		MaxMana()
			if(diedFromSenjutsuOverload())
				return
			if(Secret == "Senjutsu" && SlotlessBuffs["Senjutsu Focus"])
				ManaMax =  100 + (25 * (secretDatum.currentTier))
				ManaMax *= MANAOVERLOADMULT
				// at current tier 5, mana max is 225

			var/KeyMana=src.ManaMax
			if(src.TotalCapacity&&!src.HasMechanized())
				KeyMana-=src.TotalCapacity
			if(src.HasManaCapMult())
				KeyMana*=src.GetManaCapMult()
			var/Sub
			var/Cut
			if(src.ManaCut)
				Sub=KeyMana*src.ManaCut
				Cut=KeyMana-Sub
				if(src.ManaAmount > Cut)
					src.ManaAmount=Cut
			if(Secret == "Senjutsu" && SlotlessBuffs["Senjutsu Focus"])
				KeyMana += secretDatum.currentTier * 25
			if(src.ManaAmount > KeyMana)
				src.ManaAmount=KeyMana
		MaxOxygen()
			var/KeyOxygen=src.OxygenMax
			if(SenseRobbed>=2)
				KeyOxygen/=src.SenseRobbed
			if(src.Oxygen>KeyOxygen)
				src.Oxygen-=1
		Calm(var/Pacified=0)
			if(passive_handler.Get("EndlessAnger"))
				return
			if(!Pacified)src.OMessage(10,"<font color=white><i>[src] becomes calm.","<font color=silver>[src]([src.key]) becomes calm.")
			src.DefianceCounter=0
			src.Anger=0
			src.AngerCD=30
		AddHealthCut(var/Val)
			src.HealthCut+=Val
			if(src.HealthCut>=1)
				src.Death(null, "exhausting their life force!", SuperDead=1, NoRemains=1)
		AddEnergyCut(var/Val)
			src.EnergyCut+=Val
			if(src.EnergyCut>=1)
				src.Death(null, "exhausting their life force!", SuperDead=1, NoRemains=1)
		AddManaCut(var/Val)
			src.ManaCut+=Val
			if(src.ManaCut>=1)
				src.ManaCut=1
		AddStrTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.StrTax>=src.GetTaxThreshold())
					src.StrTax=src.GetTaxThreshold()
					src.AddStrCut(0.1*Val)
					return
			src.StrTax+=Val
			if(src.StrTax>=1)
				src.StrTax=1
		SubStrTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=1.5
			src.StrTax-=Val
			if(src.StrTax<=0)
				src.StrTax=0
		AddStrCut(var/Val)
			src.StrCut+=Val
			if(src.StrCut>=1)
				src.StrCut=1
		AddEndTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.EndTax>=src.GetTaxThreshold())
					src.EndTax=src.GetTaxThreshold()
					src.AddEndCut(0.1*Val)
					return
			src.EndTax+=Val
			if(src.EndTax>=1)
				src.EndTax=1
		SubEndTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=4
			src.EndTax-=Val
			if(src.EndTax<=0)
				src.EndTax=0
		AddEndCut(var/Val)
			src.EndCut+=Val
			if(src.EndCut>=1)
				src.EndCut=1
		AddSpdTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.SpdTax>=src.GetTaxThreshold())
					src.SpdTax=src.GetTaxThreshold()
					src.AddSpdCut(0.1*Val)
					return
			src.SpdTax+=Val
			if(src.SpdTax>=1)
				src.SpdTax=1
		SubSpdTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=4
			src.SpdTax-=Val
			if(src.SpdTax<=0)
				src.SpdTax=0
		AddSpdCut(var/Val)
			src.SpdCut+=Val
			if(src.SpdCut>=1)
				src.SpdCut=1
		AddForTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.ForTax>=src.GetTaxThreshold())
					src.ForTax=src.GetTaxThreshold()
					src.AddForCut(0.1*Val)
					return
			src.ForTax+=Val
			if(src.ForTax>=1)
				src.ForTax=1
		SubForTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=4
			src.ForTax-=Val
			if(src.ForTax<=0)
				src.ForTax=0
		AddForCut(var/Val)
			src.ForCut+=Val
			if(src.ForCut>=1)
				src.ForCut=1
		AddOffTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.OffTax>=src.GetTaxThreshold())
					src.OffTax=src.GetTaxThreshold()
					src.AddOffCut(0.1*Val)
					return
			src.OffTax+=Val
			if(src.OffTax>=1)
				src.OffTax=1
		SubOffTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=4
			src.OffTax-=Val
			if(src.OffTax<=0)
				src.OffTax=0
		AddOffCut(var/Val)
			src.OffCut+=Val
			if(src.OffCut>=1)
				src.OffCut=1
		AddDefTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.DefTax>=src.GetTaxThreshold())
					src.DefTax=src.GetTaxThreshold()
					src.AddDefCut(0.1*Val)
					return
			src.DefTax+=Val
			if(src.DefTax>=1)
				src.DefTax=1
		SubDefTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=4
			src.DefTax-=Val
			if(src.DefTax<=0)
				src.DefTax=0
		AddDefCut(var/Val)
			src.DefCut+=Val
			if(src.DefCut>=1)
				src.DefCut=1
		AddRecovTax(var/Val)
			if(src.HasTaxThreshold())
				if(src.RecovTax>=src.GetTaxThreshold())
					src.RecovTax=src.GetTaxThreshold()
					src.AddRecovCut(0.1*Val)
					return
			src.RecovTax+=Val
			if(src.RecovTax>=1)
				src.RecovTax=1
		SubRecovTax(var/Val, var/Forced=0)
			if(src.Satiated&&!Drunk||Forced)
				Val*=4
			src.RecovTax-=Val
			if(src.RecovTax<=0)
				src.RecovTax=0
		AddRecovCut(var/Val)
			src.RecovCut+=Val
			if(src.RecovCut>=1)
				src.RecovCut=1
		BaseStr()
			return (src.StrMod+src.StrAscension+(src.EnhancedStrength*0.2))*StrChaos
		BaseFor()
			return (src.ForMod+src.ForAscension+(src.EnhancedForce*0.2))*ForChaos
		BaseEnd()
			return (src.EndMod+src.EndAscension+(src.EnhancedEndurance*0.2))*EndChaos
		BaseSpd()
			return (src.SpdMod+src.SpdAscension+(src.EnhancedSpeed*0.2))*SpdChaos
		BaseOff()
			return (src.OffMod+src.OffAscension+(src.EnhancedAggression*0.2))*OffChaos
		BaseDef()
			return (src.DefMod+src.DefAscension+(src.EnhancedReflexes*0.2))*DefChaos
		BaseRecov()
			return (src.RecovMod+src.RecovAscension)*RecovChaos

		GetStrMult()
			return src.StrMultTotal
		GetForMult()
			return src.ForMultTotal
		GetEndMult()
			return src.EndMultTotal
		GetSpdMult()
			return src.SpdMultTotal
		GetOffMult()
			return src.OffMultTotal
		GetDefMult()
			return src.DefMultTotal
		GetRecovMult()
			return src.RecovMultTotal

		GetMAStr()
			var/MA=0
			if(src.StyleBuff)
				MA=(src.StyleBuff.StyleStr-1)
				// if(src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus"))
				// 	MA+=0.3
				if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Armament")
					MA+=0.1 * src.secretDatum.currentTier
				if(src.Secret=="Werewolf"&&!(src.CheckSlotless("Half Moon Form")))
					MA+=0.1
				if(src.Secret=="Zombie")
					MA+=0.1
			return MA
		GetMAEnd()
			var/MA=0
			if(src.StyleBuff)
				MA=(src.StyleBuff.StyleEnd-1)
				if(src.Secret=="Haki")
					MA+=0.05 * src.secretDatum.currentTier

			return MA
		GetMAFor()
			var/MA=0
			if(src.StyleBuff)
				MA=(src.StyleBuff.StyleFor-1)
				if(src.Secret=="Zombie")
					MA+=0.1
				if(src.Secret=="Haki")
					MA+=0.05 * src.secretDatum.currentTier

			return MA
		GetMASpd()
			var/MA=0
			if(src.StyleBuff)
				MA=(src.StyleBuff.StyleSpd-1)
				if(src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus"))
					MA+=0.2
			return MA
		GetMAOff()
			var/MA=0
			if(src.StyleBuff)
				MA=(src.StyleBuff.StyleOff-1)
				if(src.Secret=="Werewolf"&&(!src.CheckSlotless("Half Moon Form")))
					MA+=0.2
				if(src.Secret=="Zombie")
					MA+=0.1
				if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Armament")
					MA+=0.1 * src.secretDatum.currentTier
				if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Observation")
					MA+=0.05 * src.secretDatum.currentTier
				if(src.Secret=="Ripple")
					MA+=0.1

			return MA
		GetMADef()
			var/MA=0
			if(src.StyleBuff)
				MA=(src.StyleBuff.StyleDef-1)
				if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Observation")
					MA+=0.1 * src.secretDatum.currentTier
				if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Armament")
					MA+=0.05 * src.secretDatum.currentTier
				if(src.Secret=="Ripple")
					MA+=0.2
				if(src.Secret=="Zombie")
					MA+=0.1

			return MA


		GetStr(var/Mult=1)
			var/Str=src.StrMod
			//mecha suits replace base stats with their level up to max value of 3, which is a cutoff line for many races
			Str+=src.StrAscension
			//stat ascensions gained through racial or saga improvements
			Str+=src.EnhancedStrength ? src.EnhancedStrength * 0.2 : 0
			//cyber stats boosters.
			//gain double value when Overdive is active, unless the user is Android (then only +50%)
			Str*=src.StrChaos
			//tarot shit
			if(passive_handler.Get("Piloting"))
				Str = getMechStat(findMecha(), Str)
			if(src.StrReplace)
				Str=StrReplace
			//when you want to ignore all of the above for some reason
			Str+=StrAdded
			if(src.HasManaStats())
				Str += getManaStatsBoon()
			if(HasShonenPower())
				var/spPower = GetShonenPower() > 0 ? GetShonenPower() : 0
				Str += (0.1*spPower) * Str
			var/hellPower = src.HasHellPower()
			if(hellPower>=0.5)
				Str += (0.1*hellPower) * Str
			// get 25% bonus to strength for each hell power
			var/Mod=1
			var/strMult = StrMultTotal
			if(passive_handler.Get("KillerInstinct") && Health <= 50)
				strMult += GetKillerInstinct()
			Mod+=(strMult-1)
			if(src.KamuiBuffLock)
				Mod+=1
			if(src.Saga=="Eight Gates")
				Mod+=0.05*GatesActive
			// if(src.isRace(HUMAN))
			// 	if(src.AscensionsAcquired)
			// 		Mod+=(src.AscensionsAcquired/20)
			if(src.Race=="Android" && src.EnhancedStrength)
				Mod+=(src.AscensionsAcquired/10)*src.EnhancedStrength
			if(src.CheckSlotless("What Must Be Done"))
				if(SlotlessBuffs["What Must Be Done"])
					if(SlotlessBuffs["What Must Be Done"].Password)
						Mod+=min(0.5, SlotlessBuffs["What Must Be Done"].Mastery/10)
			if(src.InfinityModule)
				Mod+=0.25
			if(isRace(SAIYAN)&&transActive&&!src.SpecialBuff)
				if(src.race.transformations[transActive].mastery==100)
					Mod+=0.1
			if(src.CheckSlotless("Devil Arm")&&!src.SpecialBuff)
				Mod+=0.3
			if(src.StrStolen)
				Mod+=src.StrStolen*0.5
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=25)
						Mod+=0.75*src.BurningShot
					else if(src.Burn>25&&src.Burn<=75)
						Mod+=0.5*src.BurningShot
					else
						Mod+=0.25*src.BurningShot
			if(src.SpecialBuff&&(src.SpecialBuff.BuffName=="Genesic Brave"||src.SpecialBuff.BuffName=="Broken Brave"))
				if(src.Health<=25*(1-src.HealthCut))
					Mod+=min(10/src.Health,1)
			if(src.StrEroded)
				Mod-=src.StrEroded

			if(Secret == "Werewolf" && CheckSlotless("Full Moon Form"))
				Mod += 1 * (secretDatum?:getHungerBoon())
			var/adaptive = passive_handler.Get("AngerAdaptiveForce")
			if(adaptive)
				if(BaseStr() > BaseFor())
					Mod += clamp(adaptive,0.1,1)
				if(BaseStr() == BaseFor())
					// lol
					Mod += clamp(adaptive/2,0.05, 0.5)

			Str*=Mod
			Str*=Mult
			if(src.HasMirrorStats())
				if(src.Target&&src.Target!=src&&!src.Target.HasMirrorStats()&&istype(src.Target, /mob/Players))
					Str=src.Target.GetStr()
			var/TotalTax
			if(src.StrTax)
				TotalTax+=src.StrTax
			if(src.StrCut)
				TotalTax+=src.StrCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=Str*TotalTax
			Str-=Sub
			if(src.UnhingedForm)
				var/perRange = UnhingedForm/30
				var/def = round((1 - BaseDef()) / 0.1, 1)
				// for each 0.1 def add perRange speed
				var/end = round((1 - BaseEnd()) / 0.1, 1)
				// for each 0.1 end add perRange speed
				var/total = (def + end) * perRange
				if(total > UnhingedForm)
					Str += UnhingedForm
				else
					Str += total
			Str+=src.GetMAStr()


			if(src.UsingYinYang()&&src.Target&&src.Target!=src&&!src.Target.UsingYinYang()&&istype(src.Target, /mob/Players))
				Str+=src.Target.GetMAEnd()*0.5
			else
				if(src.HasAdaptation())
					if(src.AdaptationCounter!=0&&!src.Oozaru)
						if(src.Target&&src.AdaptationTarget==src.Target)
							Str+=(src.Target.GetMAEnd()*0.5*src.AdaptationCounter)
			if(Str<0.1)
				Str=0.1
			return Str

		GetFor(var/Mult=1)
			var/For=src.ForMod
			For+=src.ForAscension
			For+=(EnhancedForce ? src.EnhancedForce*0.2 : 0)
			For*=src.ForChaos
			if(src.ForReplace)
				For=ForReplace
			For+=ForAdded
			if(HasShonenPower())
				var/spPower = GetShonenPower() > 0 ? GetShonenPower() : 0
				For += (0.1*spPower) * For
			var/hellPower = src.HasHellPower()
			if(hellPower>=0.5)
				For += (0.1*hellPower) * For
			if(passive_handler.Get("Piloting"))
				For = getMechStat(findMecha(), For)
			if(src.HasManaStats())
				For += getManaStatsBoon()


			var/Mod=1
			var/forMult = ForMultTotal
			if(passive_handler.Get("KillerInstinct") && Health <= 75)
				forMult += GetKillerInstinct()
			Mod+=(forMult-1)
			// if(src.isRace(HUMAN))
			// 	if(src.AscensionsAcquired)
			// 		Mod+=(src.AscensionsAcquired/20)
			if(src.Race=="Android" && src.EnhancedForce)
				Mod+=(src.AscensionsAcquired/10)*src.EnhancedForce
			if(src.CheckSlotless("What Must Be Done"))
				if(SlotlessBuffs["What Must Be Done"])
					if(SlotlessBuffs["What Must Be Done"].Password)
						Mod+=min(0.5, SlotlessBuffs["What Must Be Done"].Mastery/10)
			if(src.InfinityModule)
				Mod+=0.25
			if(isRace(SAIYAN)&&transActive&&!src.SpecialBuff)
				if(src.race.transformations[transActive].mastery==100)
					Mod+=0.1
			if(src.CheckSlotless("Devil Arm")&&!src.SpecialBuff)
				Mod+=0.3
			if(src.ForStolen)
				Mod+=src.ForStolen*0.5
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=25)
						Mod+=0.75*src.BurningShot
					else if(src.Burn>25&&src.Burn<=75)
						Mod+=0.5*src.BurningShot
					else
						Mod+=0.25*src.BurningShot
			if(src.SpecialBuff&&(src.SpecialBuff.BuffName=="Genesic Brave"||src.SpecialBuff.BuffName=="Broken Brave"))
				if(src.Health<=25*(1-src.HealthCut))
					Mod+=min(10/src.Health,1)
			if(src.ForEroded)
				Mod-=src.ForEroded
			var/adaptive = passive_handler.Get("AngerAdaptiveForce")
			if(adaptive)
				if(BaseFor() > BaseStr())
					Mod += clamp(adaptive,0.1,1)
				if(BaseFor() == BaseStr())
					// lol
					Mod += clamp(adaptive/2,0.05, 0.5)


			For*=Mod
			For*=Mult
			if(src.HasMirrorStats())
				if(src.Target&&src.Target!=src&&!src.Target.HasMirrorStats()&&istype(src.Target, /mob/Players))
					For=src.Target.GetFor()
			var/TotalTax
			if(src.ForTax)
				TotalTax+=src.ForTax
			if(src.ForCut)
				TotalTax+=src.ForCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=For*TotalTax
			For-=Sub
			For+=src.GetMAFor()
			if(src.UnhingedForm)
				var/perRange = UnhingedForm/30
				var/def = round((1 - BaseDef()) / 0.1, 1)
				// for each 0.1 def add perRange speed
				var/end = round((1 - BaseEnd()) / 0.1, 1)
				// for each 0.1 end add perRange speed
				var/total = (def + end) * perRange
				if(total > UnhingedForm)
					For += UnhingedForm
				else
					For += total
			if(src.UsingYinYang()&&src.Target&&src.Target!=src&&!src.Target.UsingYinYang()&&istype(src.Target, /mob/Players))
				For+=src.Target.GetMAEnd()*0.5
			else
				if(src.HasAdaptation())
					if(src.AdaptationCounter!=0&&!src.Oozaru)
						if(src.Target&&src.AdaptationTarget==src.Target)
							For+=(src.Target.GetMAEnd()*0.5*src.AdaptationCounter)
			if(For<0.1)
				For=0.1
			return For

		GetEnd(var/Mult=1)
			var/End=src.EndMod
			End+=src.EndAscension
			End+=EnhancedEndurance ? src.EnhancedEndurance*0.2 : 0
			End*=src.EndChaos
			if(src.EndReplace)
				End=EndReplace
			if(passive_handler.Get("Piloting"))
				End = getMechStat(findMecha(), End)

			if(passive_handler.Get("DemonicDurability") && (Anger||HasCalmAnger()))
				if(!passive_handler.Get("CancelDemonicDura"))
					End += End * (glob.DEMONIC_DURA_BASE * passive_handler.Get("DemonicDurability"))
			End+=EndAdded
			if(src.HasManaStats())
				End += getManaStatsBoon()
			var/Mod=1
			Mod+=(src.EndMultTotal-1)
			if(src.KamuiBuffLock)
				Mod+=1
			// if(src.isRace(HUMAN))
			// 	if(src.AscensionsAcquired)
			// 		Mod+=(src.AscensionsAcquired/20)
			if(src.Race=="Android" && src.EnhancedEndurance)
				Mod+=(src.AscensionsAcquired/10)*src.EnhancedEndurance
			if(src.CheckSlotless("What Must Be Done"))
				if(SlotlessBuffs["What Must Be Done"])
					if(SlotlessBuffs["What Must Be Done"].Password)
						Mod+=min(0.5, SlotlessBuffs["What Must Be Done"].Mastery/10)
			if(src.InfinityModule)
				Mod+=0.25
			if(isRace(SAIYAN)&&transActive&&!src.SpecialBuff)
				if(src.race.transformations[transActive].mastery==100)
					Mod+=0.1
			if(src.CheckSlotless("Devil Arm")&&!src.SpecialBuff)
				Mod+=0.2
			if(src.EndStolen)
				Mod+=src.EndStolen*0.5
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=50)
						Mod-=0.5*src.BurningShot
					else if(src.Burn>50&&src.Burn<=75)
						Mod-=0.75*src.BurningShot
					else
						Mod-=1*src.BurningShot
			if(src.SpecialBuff&&(src.SpecialBuff.BuffName=="Genesic Brave"||src.SpecialBuff.BuffName=="Protect Brave"))
				if(src.Health<=25*(1-src.HealthCut))
					Mod+=min(10/src.Health,1)
			if(src.Harden)
				if(Harden>=glob.MAX_HARDEN)
					Harden = glob.MAX_HARDEN
				Mod*= 1 + (src.Harden * (0.006 * clamp(src.Hardening, 0.1, glob.MAX_HARDENING)))
			if(src.Shatter)
				if(!src.HasDebuffImmune())
					if(src.HasDebuffReversal())
						Mod*=1 + Shatter * DEBUFF_EFFECTIVENESS
					else
						Mod*=1 - Shatter * DEBUFF_EFFECTIVENESS
			if(src.EndEroded)
				Mod-=src.EndEroded

			End*=Mod
			End*=Mult
			if(src.HasMirrorStats())
				if(src.Target&&src.Target!=src&&!src.Target.HasMirrorStats()&&istype(src.Target, /mob/Players))
					End=src.Target.GetEnd()
			var/TotalTax
			if(src.EndTax)
				TotalTax+=src.EndTax
			if(src.EndCut)
				TotalTax+=src.EndCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=End*TotalTax
			End-=Sub
			End+=src.GetMAEnd()
			if(src.UsingYinYang()&&src.Target&&src.Target!=src&&!src.Target.UsingYinYang()&&istype(src.Target, /mob/Players))
				End+=(src.Target.GetMAStr()+src.Target.GetMAFor())*0.5
			else
				if(src.HasAdaptation())
					if(src.AdaptationCounter!=0&&!src.Oozaru)
						if(src.Target&&src.AdaptationTarget==src.Target)
							End+=((src.Target.GetMAStr()+src.Target.GetMAFor())*0.5*src.AdaptationCounter)
			if(End<0.1)
				End=0.1
			return End

		GetSpd(var/Mult=1)
			var/Spd=src.SpdMod
			Spd+=src.SpdAscension
			Spd+=EnhancedSpeed ? src.EnhancedSpeed*0.2 : 0
			Spd*=src.SpdChaos

			if(src.SpdReplace)
				Spd=SpdReplace
			if(passive_handler.Get("Piloting"))
				Spd = getMechStat(findMecha(), Spd)
			Spd+=SpdAdded
			if(src.HasManaStats())
				Spd += getManaStatsBoon()
			var/Mod=1
			Mod+=(src.SpdMultTotal-1)
			if(src.KamuiBuffLock)
				Mod+=1
			if(Saga&&src.Saga=="Eight Gates")
				Mod+=0.05*GatesActive

			if(src.CheckSlotless("What Must Be Done"))
				if(SlotlessBuffs["What Must Be Done"].Password)
					Mod+=min(0.5, SlotlessBuffs["What Must Be Done"].Mastery/10)
			if(src.InfinityModule)
				Mod+=0.25
			if(isRace(SAIYAN)&&transActive&&!src.SpecialBuff)
				if(src.race.transformations[transActive].mastery==100)
					Mod+=0.1
			if(src.CheckSlotless("Devil Arm")&&!src.SpecialBuff)
				Mod+=0.2
			if(src.SpdStolen)
				Mod+=src.SpdStolen*0.5
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=25)
						Mod+=0.75*src.BurningShot
					else if(src.Burn>25&&src.Burn<=75)
						Mod+=0.5*src.BurningShot
					else
						Mod+=0.25*src.BurningShot
			if(src.Slow)
				if(!src.HasDebuffImmune())
					if(src.HasDebuffReversal())
						Mod*=1 + (Slow * DEBUFF_EFFECTIVENESS)
					else
						Mod*= 1 - (Slow * DEBUFF_EFFECTIVENESS)
			if(src.SpdEroded)
				Mod-=src.SpdEroded

			if(Secret && Secret == "Werewolf" && CheckSlotless("Full Moon Form"))
				Mod += 1 * (secretDatum?:getHungerBoon())


			Spd*=Mod
			Spd*=Mult
			if(src.HasMirrorStats())
				if(src.Target&&src.Target!=src&&!src.Target.HasMirrorStats()&&istype(src.Target, /mob/Players))
					Spd=src.Target.GetSpd()
			var/TotalTax
			if(src.SpdTax)
				TotalTax+=src.SpdTax
			if(src.SpdCut)
				TotalTax+=src.SpdCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=Spd*TotalTax
			Spd-=Sub
			if(src.UnhingedForm)
				var/perRange = UnhingedForm/20
				var/def = round((1 - BaseDef()) / 0.1, 1)
				// for each 0.1 def add perRange speed
				var/end = round((1 - BaseEnd()) / 0.1, 1)
				// for each 0.1 end add perRange speed
				var/total = (def + end) * perRange
				if(total > UnhingedForm)
					Spd += UnhingedForm
				else
					Spd += total
			Spd+=src.GetMASpd()
			if(src.UsingYinYang()&&src.Target&&src.Target!=src&&!src.Target.UsingYinYang()&&istype(src.Target, /mob/Players))
				Spd+=src.Target.GetMASpd()*0.5
			else
				if(src.HasAdaptation())
					if(src.AdaptationCounter!=0&&!src.Oozaru)
						if(src.Target&&src.AdaptationTarget==src.Target)
							Spd+=(src.Target.GetMASpd()*0.5*src.AdaptationCounter)
			if(Spd<0.1)
				Spd=0.1
			return Spd

		GetOff(var/Mult=1)
			var/Off=src.OffMod
			Off+=src.OffAscension
			Off+=EnhancedAggression ? src.EnhancedAggression*0.2 : 0
			Off*=src.OffChaos
			if(passive_handler.Get("Piloting"))
				Off = getMechStat(findMecha(), Off)
			Off+=OffAdded
			var/Mod=1
			Mod+=(src.OffMultTotal-1)
			// if(src.isRace(HUMAN))
			// 	if(src.AscensionsAcquired)
			// 		Mod+=(src.AscensionsAcquired/20)
			if(src.Race=="Android" && src.EnhancedAggression)
				Mod+=(src.AscensionsAcquired/10)*src.EnhancedAggression
			if(src.OffStolen)
				Mod+=src.OffStolen*0.5
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=25)
						Mod+=0.75*src.BurningShot
					else if(src.Burn>25&&src.Burn<=75)
						Mod+=0.5*src.BurningShot
					else
						Mod+=0.25*src.BurningShot
			if(src.Shock)
				if(!src.HasDebuffImmune())
					if(src.HasDebuffReversal())
						Mod*=1 + (Shock * DEBUFF_EFFECTIVENESS)
					else
						Mod*= 1 - (Shock * DEBUFF_EFFECTIVENESS)
			if(src.OffEroded)
				Mod-=src.OffEroded
			Off*=Mod
			Off*=Mult
			if(src.HasMirrorStats())
				if(src.Target&&src.Target!=src&&!src.Target.HasMirrorStats()&&istype(src.Target, /mob/Players))
					Off=src.Target.GetOff()
			var/TotalTax
			if(src.OffTax)
				TotalTax+=src.OffTax
			if(src.OffCut)
				TotalTax+=src.OffCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=Off*TotalTax
			Off-=Sub
			if(src.UnhingedForm)
				var/perRange = UnhingedForm/20
				var/def = round((1 - BaseDef()) / 0.1, 1)
				// for each 0.1 def add perRange speed
				var/end = round((1 - BaseEnd()) / 0.1, 1)
				// for each 0.1 end add perRange speed
				var/total = (def + end) * perRange
				if(total > UnhingedForm)
					Off += UnhingedForm
				else
					Off += total
			Off+=src.GetMAOff()
			if(src.UsingYinYang()&&src.Target&&src.Target!=src&&!src.Target.UsingYinYang()&&istype(src.Target, /mob/Players))
				Off+=src.Target.GetMADef()*0.5
			else
				if(src.HasAdaptation())
					if(src.AdaptationCounter!=0&&!src.Oozaru)
						if(src.Target&&src.AdaptationTarget==src.Target)
							Off+=(src.Target.GetMADef()*0.5*src.AdaptationCounter)
			if(Off<0.1)
				Off=0.1
			return Off

		GetDef(var/Mult=1)
			var/Def=src.DefMod

			Def+=src.DefAscension
			Def+=EnhancedReflexes ? src.EnhancedReflexes*0.2 : 0
			Def*=src.DefChaos
			if(passive_handler.Get("Piloting"))
				Def = getMechStat(findMecha(), Def)
			Def+=DefAdded
			var/Mod=1
			Mod+=(src.DefMultTotal-1)
			// if(src.isRace(HUMAN))
			// 	if(src.AscensionsAcquired)
			// 		Mod+=(src.AscensionsAcquired/20)
			if(src.Race=="Android" && src.EnhancedReflexes)
				Mod+=(src.AscensionsAcquired/10)*src.EnhancedReflexes
			if(src.DefStolen)
				Mod+=src.DefStolen*0.5
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=25)
						Mod+=0.75*src.BurningShot
					else if(src.Burn>25&&src.Burn<=75)
						Mod+=0.5*src.BurningShot
					else
						Mod+=0.25*src.BurningShot
			if(src.Shock)
				if(!src.HasDebuffImmune())
					if(src.HasDebuffReversal())
						Mod*=1 + (Shock * DEBUFF_EFFECTIVENESS)
					else
						Mod*=1 - (Shock * DEBUFF_EFFECTIVENESS)
			if(src.DefEroded)
				Mod-=src.DefEroded

			Def*=Mod
			Def*=Mult
			if(src.HasMirrorStats())
				if(src.Target&&src.Target!=src&&!src.Target.HasMirrorStats()&&istype(src.Target, /mob/Players))
					Def=src.Target.GetDef()
			var/TotalTax
			if(src.DefTax)
				TotalTax+=src.DefTax
			if(src.DefCut)
				TotalTax+=src.DefCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=Def*TotalTax
			Def-=Sub
			Def+=src.GetMADef()
			if(src.UsingYinYang()&&src.Target&&src.Target!=src&&!src.Target.UsingYinYang()&&istype(src.Target, /mob/Players))
				Def+=src.Target.GetMAOff()*0.5
			else
				if(src.HasAdaptation())
					if(src.AdaptationCounter!=0&&!src.Oozaru)
						if(src.Target&&src.AdaptationTarget==src.Target)
							Def+=(src.Target.GetMAOff()*0.5*src.AdaptationCounter)
			if(Def<0.1)
				Def=0.1
			return Def

		GetRecov(var/Mult=1)
			var/Recov=src.RecovMod
			Recov+=src.RecovAscension
			if(src.RecovReplace)
				Recov=src.RecovReplace
			if(src.HasHellPower()||(src.Secret=="Werewolf"&&(!src.CheckSlotless("Half Moon Form"))))
				if(Recov<2)
					Recov=2
			if(src.isRace(MAJIN))
				Recov=2

			var/Mod=1
			if(src.HasManaStats())
				var/manaStatPerc = GetManaStats() // 0.1 per tick
				var/maxStatBoon = 1
				var/baseBoon = 0.25
				var/manaMissing = (ManaAmount / ManaMax)
				var/bonus = baseBoon * manaMissing * manaStatPerc >= maxStatBoon ? maxStatBoon : baseBoon * manaMissing * manaStatPerc
				Mod += bonus

			Mod+=(src.RecovMultTotal-1)
			var/BM=src.HasBuffMastery()
			if(BM)
				if(Mod<=glob.BUFF_MASTERY_LOWTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_LOWMULT))
				else if(Mod>=glob.BUFF_MASTER_HIGHTHRESHOLD)
					Mod*=(1+(BM*glob.BUFF_MASTERY_HIGHMULT))
			if(src.BurningShot)
				if(src.Burn)
					if(src.Burn>0&&src.Burn<=50)
						Mod-=0.5*src.BurningShot
					else if(src.Burn>50&&src.Burn<=75)
						Mod-=0.75*src.BurningShot
					else
						Mod-=1*src.BurningShot
			if(src.SpecialBuff&&(src.SpecialBuff.BuffName=="Genesic Brave"||src.SpecialBuff.BuffName=="Protect Brave"))
				if(src.Health<=25*(1-src.HealthCut))
					var/thisVar = 10/Health < 0 ? 0.1 : 10/Health
					Mod+=thisVar
			if(src.RecovEroded)
				Mod-=src.RecovEroded

			Recov*=Mod
			Recov*=Mult
			Recov*=src.RecovChaos
			if(src.isRace(NAMEKIAN)&&src.transActive())
				if(Recov<2)
					Recov=2
			if(src.HasRipple())
				Recov*=max(min(src.Oxygen/src.OxygenMax,1.5),0.5)
			var/TotalTax
			if(src.RecovTax)
				TotalTax+=src.RecovTax
			if(src.RecovCut)
				TotalTax+=src.RecovCut
			if(TotalTax>=1)
				TotalTax=0.9
			var/Sub=Recov*TotalTax
			Recov-=Sub
			if(Recov<0.1)
				Recov=0.1
			return Recov


		NewAnger(var/num, var/Override=0)
			if(!Override)
				if(src.AngerMax < num)
					src.AngerMax = num
			else
				src.AngerMax=num
		AngerMult(var/num)
			src.AngerMax=1+((src.AngerMax-1)*num)
		AngerDiv(var/num)
			src.AngerMax=1+((src.AngerMax-1)/num)
		AllMult(var/num)
			src.StrMult(num)
			src.EndMult(num)
			src.SpdMult(num)
			src.ForMult(num)
			src.OffMult(num)
			src.DefMult(num)
		StrAdd(var/num)
			src.StrMod+=num
			src.StrOriginal+=num
		StrMult(var/num)
			src.StrMod*=num
			src.StrOriginal*=num
		StrDiv(var/num)
			src.StrMod/=num
			src.StrOriginal/=num
		EndMult(var/num)
			src.EndMod*=num
			src.EndOriginal*=num
		EndDiv(var/num)
			src.EndMod/=num
			src.EndOriginal/=num
		SpdMult(var/num)
			src.SpdMod*=num
			src.SpdOriginal*=num
		SpdDiv(var/num)
			src.SpdMod/=num
			src.SpdOriginal/=num
		ForAdd(var/num)
			src.ForMod+=num
			src.ForOriginal+=num
		ForMult(var/num)
			src.ForMod*=num
			src.ForOriginal*=num
		ForDiv(var/num)
			src.ForMod/=num
			src.ForOriginal/=num
		OffMult(var/num)
			src.OffMod*=num
			src.OffOriginal*=num
		OffDiv(var/num)
			src.OffMod/=num
			src.OffOriginal/=num
		DefMult(var/num)
			src.DefMod*=num
			src.DefOriginal*=num
		DefDiv(var/num)
			src.DefMod/=num
			src.DefOriginal/=num
		RecovMult(var/num)
			src.RecovMod*=num
			src.RecovOriginal*=num
		RecovDiv(var/num)
			src.RecovMod/=num
			src.RecovOriginal/=num
		GetBPM()
			return (src.potential_power_mult)
		BPMult(var/num)
			src.Base*=num
		BPDiv(var/num)
			src.Base/=num
		TransMastery(var/num)
			return race.transformations[num].mastery
		transActive()
			return transActive
		TransAuraFound()
			if(src.transActive())
				if(src.transActive()==1)
					if(src.Form1Aura)
						return 1
				if(src.transActive()==2)
					if(src.Form2Aura)
						return 1
				if(src.transActive()==3)
					if(src.Form3Aura)
						return 1
				if(src.transActive()==4)
					if(src.Form4Aura)
						return 1
			return 0
		transActiveDown()
			transActive--
		MakeSword(var/obj/Items/Sword/s, var/damage, var/acc, var/icon/i=null, var/px=0, var/py=0)
			s.DamageEffectiveness=damage
			s.AccuracyEffectiveness=acc
			s.AlignEquip(src)
			if(i)
				s.icon=i
				s.pixel_x=px
				s.pixel_y=py
			s.AlignEquip(src)
		ArmorShatter()
			var/obj/Items/Armor/ar=src.EquippedArmor()
			OMsg(src, "[src]'s armor has shattered!!")
			if(src.StyleBuff)
				if(src.StyleBuff.NeedsArmor||src.StyleBuff.MakesArmor)
					src.StyleBuff.Trigger(src, Override=1)
					if(src.StyleBuff.MakesArmor)
						del(ar)
			if(src.ActiveBuff)
				if(src.ActiveBuff.NeedsArmor||src.ActiveBuff.MakesArmor)
					src.ActiveBuff.Trigger(src, Override=1)
					if(src.ActiveBuff.MakesArmor)
						del(ar)
			if(src.SpecialBuff)
				if(src.SpecialBuff.NeedsArmor||src.SpecialBuff.MakesArmor)
					src.SpecialBuff.Trigger(src, Override=1)
					if(src.SpecialBuff.MakesArmor)
						del(ar)
			for(var/b in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/sb = SlotlessBuffs[b]
				if(sb)
					if(sb.NeedsArmor||sb.MakesArmor)
						sb.Trigger(src, Override=1)
						if(sb.MakesArmor)
							del(ar)
			if(ar)
				ar.ObjectUse(User=src)
				spawn(10)
					ar.suffix="*Broken*"
					ar.Broken=1
		StaffShatter()
			var/obj/Items/Enchantment/Staff/st=src.EquippedStaff()
			OMsg(src, "[src]'s staff has shattered!!")
			if(src.StyleBuff)
				if(src.StyleBuff.NeedsStaff||src.StyleBuff.MakesStaff)
					src.StyleBuff.Trigger(src, Override=1)
					if(src.StyleBuff.MakesStaff)
						del(st)
			if(src.ActiveBuff)
				if(src.ActiveBuff.NeedsStaff||src.ActiveBuff.MakesStaff)
					src.ActiveBuff.Trigger(src, Override=1)
					if(src.ActiveBuff.MakesStaff)
						del(st)
			if(src.SpecialBuff)
				if(src.SpecialBuff.NeedsStaff||src.SpecialBuff.MakesStaff)
					src.SpecialBuff.Trigger(src, Override=1)
					if(src.SpecialBuff.MakesStaff)
						del(st)
			for(var/b in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/sb = SlotlessBuffs[b]
				if(sb)
					if(sb.NeedsStaff||sb.MakesStaff)
						sb.Trigger(src, Override=1)
						if(sb.MakesStaff)
							del(st)
			if(st)
				st.ObjectUse(User=src)
				spawn(10)
					st.suffix="*Broken*"
					st.Broken=1
		SwordShatter(var/obj/Items/Sword/PassedSword=null)
			var/obj/Items/Sword/s
			if(PassedSword)
				s=PassedSword
			else
				s=src.EquippedSword()
			src.OMessage(10, "[src]'s sword has shattered!!", "[src]([src.key]) got their sword broken.")
			if(src.StyleBuff)
				if(src.StyleBuff.NeedsSword||src.StyleBuff.MakesSword)
					src.StyleBuff.Trigger(src, Override=1)
					if(src.StyleBuff.MakesSword)
						del(s)
			if(src.ActiveBuff)
				if(src.ActiveBuff.NeedsSword||src.ActiveBuff.MakesSword)
					src.ActiveBuff.Trigger(src, Override=1)
					if(src.ActiveBuff.MakesSword)
						del(s)
			if(src.SpecialBuff)
				if(src.SpecialBuff.NeedsSword||src.SpecialBuff.MakesSword)
					src.SpecialBuff.Trigger(src, Override=1)
					if(src.SpecialBuff.MakesSword)
						del(s)
			for(var/b in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/sb = SlotlessBuffs[b]
				if(sb)
					if(sb.NeedsSword||sb.MakesSword)
						sb.Trigger(src, Override=1)
						if(sb.MakesSword)
							del(s)
			if(s)
				if(s.suffix=="*Equipped*")
					s.ObjectUse(User=src)
				else//this is in case the sword was dual / triple wielded
					var/obj/Items/Sword/ActualSword=src.EquippedSword()
					ActualSword.ObjectUse(User=src)
				spawn(10)
					s.suffix="*Broken*"//unequip that bitch
					s.Broken=1//can't be worn (for nyow)
					if(s.Glass)
						OMsg(src, "[src]'s glass weaponry shatters into a million pieces!")
						del s
					if(s.Conjured)
						OMsg(src, "[src]'s conjured weapontry shatters into arcane mist!")
						del s

		IsGrabbed()
			for(var/mob/Players/M in players)
				if(M.Grab==src)
					return M
			return 0

		StandardBiology()
			if(src.XenoBiology())
				return 0
			else
				return 1
			return 0
		XenoBiology()//might be useful for some anti-monster/anti-inhuman style later
			if(passive_handler.Get("Xenobiology"))
				return 1
			return 0

		IsGood()
			var/list/EvilRaces=list("Demon")
			var/list/EvilSecrets=list("Vampire", "Werewolf", "Zombie")
			//these are all bad.
			if(src.HasMaki())
				return 0
			if(src.Race=="Android")
				return 0
			if(src.Race in EvilRaces && !src.HasHolyMod())
				return 0
			if(src.Secret in EvilSecrets && !src.HasHolyMod())
				return 0
			if(src.ShinjinAscension=="Makai")
				return 0
			if(src.HasHellPower())
				return 0
			if(src.HasAbyssMod() && !src.HasHolyMod())
				return 0
			if(istype(src, /mob/Player/AI) && !src.SpiritPower)
				return 0
			//these are all good.
			if(src.ShinjinAscension=="Kai")
				return 1
			if(src.HasHolyMod() && !src.HasAbyssMod())
				return 1
			if(src.Secret=="Ripple")
				return 1
			if(src.HasSpiritPower()>=1)
				return 1
			return 0
		IsEvil()
			var/list/EvilRaces=list("Demon")
			var/list/EvilSecrets=list("Vampire", "Werewolf", "Zombie")
			//these are all good.
			if(src.Race=="Android")
				return 0
			if(src.ShinjinAscension=="Kai")
				return 0
			if(src.HasHolyMod())
				return 0
			if(src.HasSpiritPower()>=1)
				return 0
			//these are all bad.
			if(src.HasMaki())
				return 1
			if(src.Race in EvilRaces)
				return 1
			if(src.Secret in EvilSecrets)
				return 1
			if(src.ShinjinAscension=="Makai")
				return 1
			if(src.HasHellPower())
				return 1
			if(src.HasAbyssMod())
				return 1
			if(istype(src, /mob/Player/AI) && !src.SpiritPower)
				return 1
			if(src.NoDeath && src.Class!="Eldritch")
				return 1
			return 0

		HolyDamage(var/mob/P, var/Forced=0)//Stick this in the DoDamage proc.
			//To get to this proc, you have to already have holy damage
			if(P.UsingMuken())
				if(!Forced)
					return (-1)*src.GetHolyMod()
				else
					return (-1)*Forced
			else if(P.IsEvil())
				if(!Forced)
					return src.GetHolyMod()
				else
					return Forced
			else if(src.HasSpiritPower()>=0.25)
				if(!Forced)
					var/spiritPower = (HasSpiritPower() / 2)
					return clamp(src.GetHolyMod()*spiritPower, 1, 10)
				else
					return Forced
			else
				return 1
		AbyssDamage(mob/P, Forced=0)//Stick this in the DoDamage proc.
			//yadda yadda gotta have abyss
			if(P.UsingMuken())
				if(!Forced)
					return (-1)*src.GetAbyssMod()
				else
					return (-1)*Forced
			else if(P.IsGood())
				if(!Forced)
					return GetAbyssMod()
				else
					return Forced
			else if(HasSpiritPower()>=0.25)
				var/spiritPower = (HasSpiritPower() / 2)
				return clamp(src.GetAbyssMod()*spiritPower, 0.001, 10)
		SlayerDamage(mob/P, Forced=0)
			if(P.UsingMuken())
				return (-1)*src.GetSlayerMod()
			var/ignore = P.passive_handler.Get("Xenobiology")
			if(src.Saga in list("Hiten Mitsurugi-Ryuu", "Ansatsuken"))
				if(src.SagaLevel>=1)
					if(!Forced)
						return max(0,(src.GetSlayerMod() * 1.5) - ignore)
					else
						return max(0,Forced - ignore)
			if(!Forced)
				return max(0,src.GetSlayerMod() - ignore)
			else
				return max(0,Forced - ignore)
			return 1

		SpiritShift()
			var/SFStr=src.BaseFor()+(0.2*src.AscensionsAcquired*(src.BaseStr()-src.BaseFor()))
			var/SFFor=src.BaseStr()
			src.StrReplace=SFStr
			src.ForReplace=SFFor
		SpiritShiftBack()
			src.StrReplace=0
			src.ForReplace=0

		Flux()
			var/list/Chaos=list(0.6, 0.7, 0.7, 0.8, 0.8, 0.8, 0.9, 0.9, 0.9, 0.9, 1, 1, 1, 1, 1, 1.1, 1.1, 1.1, 1.1, 1.2, 1.2, 1.2, 1.3, 1.3, 1.4)
			src.StrChaos*=pick(Chaos)
			src.EndChaos*=pick(Chaos)
			src.SpdChaos*=pick(Chaos)
			src.ForChaos*=pick(Chaos)
			src.OffChaos*=pick(Chaos)
			src.DefChaos*=pick(Chaos)
			src.RecovChaos*=pick(Chaos)
			src.RecovChaos*=pick(Chaos)
		UnFlux()
			src.StrChaos=1
			src.EndChaos=1
			src.SpdChaos=1
			src.ForChaos=1
			src.OffChaos=1
			src.DefChaos=1
			src.RecovChaos=1
			src.RecovChaos=1

		SetHitSpark(var/icon, var/x1=0, var/y1=0, var/turn=0, var/size=1)
			src.BuffHitSparkIcon=icon
			src.BuffHitSparkX=x1
			src.BuffHitSparkY=y1
			src.BuffHitSparkTurns=turn
			src.BuffHitSparkSize=size
		ClearHitSpark()
			src.BuffHitSparkIcon=null
			src.BuffHitSparkX=0
			src.BuffHitSparkY=0
			src.BuffHitSparkTurns=0
			src.BuffHitSparkSize=1

		TakeMoney(var/Value)
			for(var/obj/Money/defender in src)
				defender.Level-=Value
				defender.name="[Commas(round(defender.Level))] [glob.progress.MoneyName]"
		GiveMoney(var/Value)
			for(var/obj/Money/defender in src)
				defender.Level+=Value
				defender.name="[Commas(round(defender.Level))] [glob.progress.MoneyName]"
			src << "You've gained [Commas(round(Value))] [glob.progress.MoneyName]."
		TakeManaCapacity(var/Value)
			var/Remaining=Value
			for(var/obj/Magic_Circle/MC in range(3, src))
				if(!MC.Locked)
					Remaining*=0.9
				else
					if(MC.Creator==src.ckey)
						Remaining*=0.75
				break
			for(var/obj/Items/Enchantment/PhilosopherStone/PS in src)
				if(!PS.ToggleUse) continue
				if(Remaining==PS.CurrentCapacity)
					Remaining=0
					PS.CurrentCapacity=0
				else if(Remaining>PS.CurrentCapacity)
					Remaining-=PS.CurrentCapacity
					PS.CurrentCapacity=0
				else if(PS.CurrentCapacity>Remaining)
					PS.CurrentCapacity-=Remaining
					Remaining=0
				if(0>=PS.CurrentCapacity) if(istype(PS, /obj/Items/Enchantment/PhilosopherStone/Magicite))
					src << "You burn out the mana in one of your magicite stones, causing it to crumble."
					contents-=PS
					PS.loc = null //garbage collection
					for(var/atom/a in PS.contents) PS.contents-=a //incase they sealed it i guess
				PS.desc="A philosopher's stone is the result of a sapient being transmuted into pure mana.  They regenerate capacity.<br>Your [PS] has [PS.CurrentCapacity] / [PS.MaxCapacity] capacity generated."
				if(Remaining==0)
					break
			if(Remaining>0)
				src.LoseCapacity(Remaining)
				//This proc only gets called if it has already been checked that someone has enough to pay...So nothing else should be necessary.
		DropMoney(var/Value)
			var/obj/Money/defender=new
			defender.Level=Value
			defender.name="[Commas(round(defender.Level))] [glob.progress.MoneyName]"
			defender.loc=get_step(src, src.dir)
			defender.MoneyCreator=src.key
			for(var/obj/Money/m2 in src)
				defender.icon=m2.icon
			src.TakeMoney(defender.Level)
		GetRadarRange()
			var/Highest=0
			for(var/obj/Items/Tech/Radar/r in src)
				if(r.Range>Highest)
					Highest=r.Range
			return Highest

		TriggerBinding()
			if(src.z!=src.Binding)
				OMsg(src, "[src]'s binding pulls their body back to their sealed dimension!")
				src.loc=locate(150, 150, src.Binding)
				OMsg(src, "[src] suddenly appears as a result of their binding!")
			src.BindingTimer=RawMinutes(1, 60)//refresh timer regardless

		SetStasis(var/StasisTime)
			if(src.HasDebuffImmune())
				StasisTime/=2
			src.Stasis=StasisTime
			if(!src.StasisFrozen)
				src.StasisEffect("Form")
		RemoveStasis()
			src.Stasis=0
			if(src.StasisFrozen)
				src.StasisEffect("Thaw")
			if(src.StasisSpace)
				src.density=1
				src.Grabbable=1
				src.Incorporeal=0
				src.invisibility=0
				src.StasisSpace=0
				animate(src.client, color = null, time = 5)

		GatesMessage(var/NewGate)
			if(NewGate==1)
				if(src.GatesActive<1)
					OMsg(src, "[src] opens the First Gate: Gate of Opening!")
					return
			if(NewGate==2)
				if(src.GatesActive<2)
					OMsg(src, "[src] opens the Second Gate: Gate of Healing!")
					return
			if(NewGate==3)
				if(src.GatesActive<3)
					OMsg(src, "[src] opens the Third Gate: Gate of Life!")
					src.Quake(5)
					return
			if(NewGate==4)
				if(src.GatesActive<4)
					OMsg(src, "[src] opens the Fourth Gate: Gate of Pain!")
					src.Quake(5)
					return
			if(NewGate==5)
				if(src.GatesActive<5)
					OMsg(src, "[src] opens the Fifth Gate: Gate of Limit!")
					src.Quake(5)
					return
			if(NewGate==6)
				if(src.GatesActive<6)
					OMsg(src, "[src] opens the Sixth Gate: Gate of View!")
					src.Quake(10)
					return
			if(NewGate==7)
				if(src.GatesActive<7)
					OMsg(src, "[src] opens the Seventh Gate: Gate of Wonder!")
					src.Quake(10)
					return
			if(NewGate==8)
				if(src.GatesActive<8 && !Gate8Used)
					OMsg(src, "[src] opens the Eighth Gate: Gate of Death!")
					src.Quake(20)
					Gate8Used=1
					return

		AlienRacials()
			var/list/Racials=list()
			var/Choice
			var/Confirm
			while(Confirm!="Yes")
				//Racials.Add("Prodigy")
				Racials.Add("Juggernaut")
				if(!src.Attunement || src.Attunement=="Fire")
					Racials.Add("Pyrokinetic")
				if(!src.Attunement || src.Attunement=="Water")
					Racials.Add("Cryogenic")
				if(!src.Attunement || src.Attunement=="Earth")
					Racials.Add("Breaker")
				if(!src.Attunement || src.Attunement=="Wind")
					Racials.Add("Shocker")
				Racials.Add("Hustle")
				Racials.Add("Infusion")
				Racials.Add("Flicker")
				Racials.Add("Adrenaline")
				if(!locate(/obj/Skills/Buffs/SlotlessBuffs/Camouflage, src) && !locate(/obj/Skills/Clairvoyance, src))
					Racials.Add("Hunter")
				if(!locate(/obj/Skills/Telekinesis, src) && !locate(/obj/Skills/Utility/Observe, src))
					Racials.Add("ESP")
				Racials.Add("Fishman")
				Racials.Add("Venomblood")
				Racials.Add("Xenobiology")
				if(!usr.AscensionsAcquired)
					//Racials.Add("Longevity") trap pick for this wipe
					Racials.Add("Genius")//doesnt allow stacking of spiritual and genius
					//Racials.Add("Symbiotic") foolish samurai warrior
					Racials.Add("Spiritual")
				Choice=input("Pick an alien racial.") in Racials
				switch(Choice)
					if("Juggernaut")
						Confirm=alert(usr, "Juggernauts cannot knocked back and recover faster when stunned.  Is this your trait?", "Racial Trait", "Yes", "No")
					if("Pyrokinetic")
						Confirm=alert(usr, "You utilize Fire element innately and you can burn people more intensely, but you really hate the cold. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Cryogenic")
						Confirm=alert(usr, "You utilize Water element innately and you can slow people easier, but shatter effects really hurt you. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Breaker")
						Confirm=alert(usr, "You utilize Earth element innately and can shatter people harder, but you are more vulnerable to electricity. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Shocker")
						Confirm=alert(usr, "You utilize Wind element innately and can shock people twice as easily, but you dislike fire. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Hustle")
						Confirm=alert(usr, "Hustle users move more recklessly and in constant rush. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Anaerobic")
						Confirm=alert(usr, "Anaerobic aliens grow more efficient with the buildup of fatigue in their muscles. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Infusion")
						Confirm=alert(usr, "Infusion users can bend the elements used against them to their advantage. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Flicker")
						Confirm=alert(usr, "Flicker fighters are masters of moving faster than the eye can see. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Adrenaline")
						Confirm=alert(usr, "Adrenaline fighters go faster as their health goes lower. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Hunter")
						Confirm=alert(usr, "Hunters possess both the cunning to meld with their environment and improved sensory prowess. Is this your trait?", "Racial Trait", "Yes", "No")
					if("ESP")
						Confirm=alert(usr, "Espers possess telekinetic and telepathic abilities. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Genius")
						Confirm=alert(usr, "Geniuses possess naturally higher intellect making developing new branches of knowledge easier. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Fishman")
						Confirm=alert(usr, "Fishmen have adjusted to the aquatic life - they do not tire from swimming, heal faster in water and constantly secrete mucus, making them tricky to grapple. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Venomblood")
						Confirm=alert(usr, "Venombloods are aliens evolved in highly noxious environments. They are highly resistant to various forms of poison and their blood is mildly toxic as well. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Xenobiology")
						Confirm=alert(usr, "Your anatomy is different enough to make you immune to typical ways of landing critical damage. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Longevity")
						Confirm=alert(usr, "Compared to other races, your lifespan is notably extensive. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Symbiotic")
						Confirm=alert(usr, "Compared to other races, your lifeforce is shared with another being - a mysterious symbiotic organism, ready to protect its host at all cost. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Spiritual")
						Confirm=alert(usr, "You have innate ties to the spirit realm and are more adept at magic. Is this your trait?", "Racial Trait", "Yes", "No")
					if("Prodigy")
						Confirm=alert(usr, "Compared to others, you quickly advance your potential as a fighter. Is this your trait?", "Racial Trait", "Yes", "No")
			switch(Choice)
				if("Juggernaut")
					if(src.Juggernaut<1)
						usr.Juggernaut+=1
					else
						usr.Juggernaut+=0.5
						src.EndAscension+=0.5
				if("Pyrokinetic")
					if(usr.Attunement=="Fire")
						src.DarknessFlame=1
						src.StrAscension+=0.25
						src.ForAscension+=0.25
					else
						usr.Attunement="Fire"
						usr.AddSkill(new/obj/Skills/Queue/Blaze_Burst)
						usr.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Elemental_Infusion)
				if("Cryogenic")
					if(src.Attunement=="Water")
						src.AbsoluteZero=1
						src.SpdAscension+=0.25
						src.DefAscension+=0.25
					else
						usr.Attunement="Water"
						usr.AddSkill(new/obj/Skills/Queue/Winter_Shock)
						usr.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Elemental_Infusion)
				if("Breaker")
					if(src.Attunement=="Earth")
						src.Hardening=3
						src.EndAscension+=0.25
						src.OffAscension+=0.25
					else
						usr.Attunement="Earth"
						usr.AddSkill(new/obj/Skills/Queue/Terra_Crack)
						usr.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Elemental_Infusion)
				if("Shocker")
					if(src.Attunement=="Wind")
						src.StunningStrike=1
						src.SpdAscension+=0.25
						src.EndAscension+=0.25
					else
						usr.Attunement="Wind"
						usr.AddSkill(new/obj/Skills/Queue/Aero_Slash)
						usr.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Elemental_Infusion)
				if("Hustle")
					if(usr.Hustle<1)
						usr.Hustle+=1
					else
						usr.Hustle+=0.25
						usr.SuperDash+=1
				if("Anaerobic")
					if(!usr.Anaerobic)
						usr.Anaerobic+=1
					else
						usr.Anaerobic+=0.5
						usr.MovementMastery+=2.5
				if("Infusion")
					if(!usr.Infusion)
						usr.Infusion+=1
					else
						src.DebuffImmune+=0.5
				if("Flicker")
					if(usr.Flicker<1)
						usr.Flicker+=1
						if(!locate(/obj/Skills/Zanzoken, src))
							usr.AddSkill(new/obj/Skills/Zanzoken)
					else
						usr.Pursuer+=1
				if("Adrenaline")
					if(!usr.Adrenaline)
						usr.Adrenaline+=1
					else
						usr.Desperation+=1
				if("Hunter")
					if(!usr.EnhancedSmell)
						usr.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Camouflage)
						usr.EnhancedSmell=1
						usr.EnhancedHearing=1
						usr.see_invisible=71
					else
						usr.AddSkill(new/obj/Skills/Clairvoyance)
				if("ESP")
					if(!locate(/obj/Skills/Telekinesis, src))
						usr.AddSkill(new/obj/Skills/Telekinesis)
						usr.AddSkill(new/obj/Skills/Utility/Telepathy)
					else
						usr.AddSkill(new/obj/Skills/Utility/Observe)
				if("Genius")
					usr.Intelligence+=0.5
				if("Fishman")
					if(!usr.Fishman)
						usr.Fishman+=1
					else
						usr.SpdAscension+=1
				if("Venomblood")
					if(!usr.VenomBlood)
						usr.VenomResistance+=1
						usr.VenomBlood+=1
					else
						usr.AngerMax+=0.125
				if("Xenobiology")
					if(!usr.Xenobiology)
						usr.Xenobiology+=1
					else
						usr.RecovAscension+=0.5
				if("Longevity")
					usr.Longlived=1
					usr.ModifyEarly+=1
					usr.ModifyPrime+=2
					usr.ModifyLate+=1
				/*if("Symbiotic")
					usr.RPPower*=0.8
					usr.Symbiote=1
					usr.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Symbiote_Infection)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Symbiote_Infection/S in usr)
						S.NameFake=input(usr, "What will be the name of your symbiote?", "Symbiote") as text|null
						if(S.NameFake==""||S.NameFake==null)
							S.NameFake="Symbiote"*/
				if("Spiritual")
					usr.Spiritual=1
					usr.Imagination+=1
				if("Prodigy")
					usr.PotentialRate+=2
					if(usr.PotentialRate>5)
						usr.PotentialRate=5
		AlienStatAscensions(var/x)
			src.AlienEvolutionStats+=x
			var/list/Choices=list("Strength", "Endurance", "Force", "Speed")
			while(x>0)
				x--
				var/Choice=input(src, "What aspect of your biology evolves?", "Alien Ascension") in Choices
				switch(Choice)
					if("Strength")
						src.StrAscension+=0.25
					if("Endurance")
						src.EndAscension+=0.25
					if("Force")
						src.ForAscension+=0.25
					if("Speed")
						src.SpdAscension+=0.25

		AddCyberCancel(var/val)
			src.CyberCancel+=val
			if(src.Race!="Android")
				if(src.CyberCancel>0.75)
					src.CyberCancel=0.75
		RemoveCyberCancel(var/val)
			src.CyberCancel-=val
			if(src.CyberCancel<0)
				src.CyberCancel=0
			if(src.Race=="Android")
				src.AddCyberCancel(1)
		SetCyberCancel()
			src.CyberCancel=0
			src.SetEnhanceChipCancel()
			src.SetMilitaryFrameCancel()
			src.SetConversionModuleCancel()
			if(src.CyberizeMod)
				if(src.CyberizeMod>=1)
					src.CyberCancel=0
				else if(src.CyberizeMod<1&&src.CyberizeMod>0)
					src.CyberCancel=src.CyberCancel-(src.CyberCancel*src.CyberizeMod)//remove portion of nerfs
			if(src.CyberCancel>0)
				src.Mechanized=1
			if(src.Race=="Tuffle")
				src.CyberCancel=0
				src.Mechanized=0
			if(src.Race=="Android")
				src.CyberCancel=1
				src.Mechanized=1
		SetEnhanceChipCancel()
			if(src.EnhanceChips)
				var/ChipCancel=0
				var/Percent=src.EnhanceChips/4
				ChipCancel=(0.25*Percent)
				if(ChipCancel>0.25)//idk how this would happen...
					ChipCancel=0.25
				src.AddCyberCancel(ChipCancel)
		SetMilitaryFrameCancel()
			if(src.HasMilitaryFrame())
				src.AddCyberCancel(0.25)
		SetConversionModuleCancel()
			var/Conversions=src.HasConversionModules()
			if(Conversions)
				var/Percent=Conversions/10
				var/ConversionCancel=(0.25*Percent)
				if(ConversionCancel>0.25)
					ConversionCancel=0.25
				src.AddCyberCancel(ConversionCancel)
		GetAndroidIntegrated()
			var/Count=0
			for(var/obj/Skills/S in usr)
				if(istype(S, /obj/Skills/Buffs/SlotlessBuffs/Gear/Integrated))
					Count++
					continue
				if(istype(S, /obj/Skills/Queue/Gear/Integrated))
					Count++
					continue
				if(istype(S, /obj/Skills/Projectile/Gear/Integrated))
					Count++
					continue
				if(istype(S, /obj/Skills/AutoHit/Gear/Integrated))
					Count++
					continue
			if(Count>=2+usr.AscensionsAcquired)
				src << "You already have the full number of integrated gears possible!"
				return 2+usr.AscensionsAcquired
			return Count

		ForceCancelBeam()
			if(Beaming)
				for(var/obj/Skills/Projectile/p in src)
					if(p.Charging)
						BeamStop(p)
						if(p.ChargeIcon)
							src.Chargez("Remove", image(icon=p.ChargeIcon, pixel_x=p.ChargeIconX, pixel_y=p.ChargeIconY))
						else
							src.Chargez("Remove")
					p.Charging=0
					src.Beaming=0
					src.BeamCharging=0
		ForceCancelBuster()
			if(BusterTech)
				if(BusterTech.Charging)
					BusterTech.Charging=0
					if(BusterTech.ChargeIcon)
						src.Chargez("Remove", image(icon=BusterTech.ChargeIcon, pixel_x=BusterTech.ChargeIconX, pixel_y=BusterTech.ChargeIconY))
					else
						src.Chargez("Remove")
					src.BusterCharging=0
					src.BusterTech=0
		ReturnProfile(var/FormNum)
			var/Return
			var/ProfileValue=src.vars["Form[FormNum]Profile"]
			if(ProfileValue)//if they have a profile set to the form
				Return=ProfileValue
			else
				Return=src.Profile
			return Return
		AddSkill(var/obj/Skills/S, var/AlreadyHere=0)
			if(S.type in typesof(/obj/Skills/Queue))
				src.Queues.Add(S)
			else if(S.type in typesof(/obj/Skills/AutoHit))
				src.AutoHits.Add(S)
			else if(S.type in typesof(/obj/Skills/Projectile))
				src.Projectiles.Add(S)
			else if(S.type in typesof(/obj/Skills/Buffs))
				src.Buffs.Add(S)
			src.Skills.Add(S)
			if(!AlreadyHere)
				src.contents.Add(S)
		DeleteSkill(var/obj/Skills/s, trueDel = TRUE)
			if(s in src.Queues)
				src.Queues.Remove(s)
			if(s in src.AutoHits)
				src.AutoHits.Remove(s)
			if(s in src.Projectiles)
				src.Projectiles.Remove(s)
			if(s in src.Buffs)
				src.Buffs.Remove(s)
			if(s in src.Skills)
				src.Skills.Remove(s)
			if(s in src.contents)
				src.contents.Remove(s)
			if(trueDel)
				del s
		AddItem(var/obj/Items/I, var/AlreadyHere=0)
			src.Items.Add(I)
			if(!AlreadyHere)
				src.contents+=I
		AddUnlockedTechnology(var/x)
			if(x in list("Weapons", "Armor", "Weighted Clothing", "Smelting", "Locksmithing"))
				src.ForgingUnlocked++
				if(ForgingUnlocked>=5)
					src.ForgingUnlocked=5
			if(x in list("Molecular Technology", "Light Alloys", "Shock Absorbers", "Advanced Plating", "Modular Weaponry"))
				src.RepairAndConversionUnlocked++
				if(RepairAndConversionUnlocked>=5)
					src.RepairAndConversionUnlocked=5
			if(x in list("Medkits", "Fast Acting Medicine", "Enhancers", "Anesthetics", "Automated Dispensers"))
				src.MedicineUnlocked++
				if(MedicineUnlocked>=5)
					src.MedicineUnlocked=5
			if(x in list("Regenerator Tanks", "Prosthetic Limbs", "Genetic Manipulation", "Regenerative Medicine", "Revival Protocol"))
				src.ImprovedMedicalTechnologyUnlocked++
				if(ImprovedMedicalTechnologyUnlocked>=5)
					src.ImprovedMedicalTechnologyUnlocked=5
			if(x in list("Wide Area Transmissions", "Espionage Equipment", "Surveilance", "Drones", "Local Range Devices"))
				src.TelecommunicationsUnlocked++
				if(TelecommunicationsUnlocked>=5)
					src.TelecommunicationsUnlocked=5
			if(x in list("Scouters", "Obfuscation Equipment", "Satellite Surveilance", "Combat Scanning", "EM Wave Projectors"))
				src.AdvancedTransmissionTechnologyUnlocked++
				if(AdvancedTransmissionTechnologyUnlocked>=5)
					src.AdvancedTransmissionTechnologyUnlocked=5
			if(x in list("Hazard Suits", "Force Shielding", "Jet Propulsion", "Power Generators"))
				src.EngineeringUnlocked++
				if(EngineeringUnlocked>=5)
					src.EngineeringUnlocked=5
			if(x in list("Android Creation", "Conversion Modules", "Enhancement Chips", "Involuntary Implantation"))
				src.CyberEngineeringUnlocked++
				if(CyberEngineeringUnlocked>=5)
					src.CyberEngineeringUnlocked=5
			if(x in list("Assault Weaponry", "Missile Weaponry", "Melee Weaponry", "Thermal Weaponry", "Blast Shielding"))
				src.MilitaryTechnologyUnlocked++
				if(MilitaryTechnologyUnlocked>=5)
					src.MilitaryTechnologyUnlocked=5
			if(x in list("Powered Armor Specialization", "Armorpiercing Weaponry", "Impact Weaponry", "Hydraulic Weaponry"))
				src.MilitaryEngineeringUnlocked++
				if(MilitaryEngineeringUnlocked>=5)
					src.MilitaryEngineeringUnlocked=5

			if(x in list("Healing Herbs", "Refreshment Herbs", "Magic Herbs", "Toxic Herbs", "Philter Herbs"))
				src.AlchemyUnlocked++
			if(x in list("Stimulant Herbs", "Relaxant Herbs", "Numbing Herbs", "Distillation Process", "Mutagenic Herbs"))
				src.ImprovedAlchemyUnlocked++
			if(x in list("Spell Focii", "Artifact Manufacturing", "Magical Communication", "Magical Vehicles", "Warding Glyphs"))
				src.ToolEnchantmentUnlocked++
			if(x in list("Tome Cleansing", "Tome Security", "Tome Translation", "Tome Binding", "Tome Excerpts"))
				src.TomeCreationUnlocked++
			if(x in list("Turf Sealing", "Object Sealing", "Power Sealing", "Mobility Sealing", "Command Sealing"))
				src.SealingMagicUnlocked++
			if(x in list("Teleportation", "Retrieval", "Bilocation", "Dimensional Manipulation", "Dimensional Restriction"))
				src.SpaceMagicUnlocked++
			if(x in list("Transmigration", "Lifespan Extension", "Temporal Displacement", "Temporal Acceleration", "Temporal Rewinding"))
				src.TimeMagicUnlocked++

			src.knowledgeTracker.learnedKnowledge.Add(x)
		LoseLifespan(var/val)
			var/Remaining=val
			if(Remaining>0)
				if(src.ModifyFinal>(-1))
					if(src.ModifyFinal-Remaining<(-1))//if there's not enough life left in this stage
						Remaining=abs(-1)-abs(src.ModifyFinal)
						src.ModifyFinal=-1
					else//if there is enough life left
						src.ModifyFinal-=Remaining
						Remaining=0
			if(Remaining>0)
				if(src.ModifyLate>(-1))
					if(src.ModifyLate-Remaining<(-1))//if there's not enough life left in this stage
						Remaining=abs(-1)-abs(src.ModifyLate)
						src.ModifyLate=-1
					else//if there is enough life left
						src.ModifyLate-=Remaining
						Remaining=0
			if(Remaining>0)
				if(src.ModifyPrime>(-2))
					if(src.ModifyPrime-Remaining<(-2))//if there's not enough life left in this stage
						Remaining=abs(-2)-abs(src.ModifyPrime)
						src.ModifyPrime=-2
					else//if there is enough life left
						src.ModifyPrime-=Remaining
						Remaining=0
			if(Remaining>0)
				if(src.ModifyEarly>(-1))
					if(src.ModifyEarly-Remaining<(-1))//if there's not enough life left in this stage
						Remaining=abs(-1)-abs(src.ModifyEarly)
						src.ModifyEarly=-1
					else//if there is enough life left
						src.ModifyEarly-=Remaining
						Remaining=0
			if(Remaining>0)
				src.EraDeathTrigger=1
				src.Death(null, "exhausting their remaining lifespan!", SuperDead=10)
		MakeWarper(var/_x, var/_y, var/_z)
			var/obj/Special/Teleporter2/q=new(src.loc)
			var/obj/Special/Teleporter2/q2=new(locate(_x, _y, _z))
			q.Savable=1
			q.Destructable=0
			q.gotoX=_x
			q.gotoY=_y
			q.gotoZ=_z
			q.AssociatedWarper=q2
			q2.Savable=1
			q2.Destructable=0
			q2.gotoX=q.x
			q2.gotoY=q.y
			q2.gotoZ=q.z
			q2.AssociatedWarper=q
			global.Turfs+=q
			global.Turfs+=q2
			Log("Admin","[ExtractInfo(usr)] made a warper at [usr.x],[usr.y],[usr.z] to warp to [_x],[_y],[_z]!")
		DashTo(mob/Trg, MaxDistance=24, Delay=0.75, Clashable=0)
			var/DelayRelease=0
			src.Frozen=1
			src.icon_state="Flight"
			MaxDistance*=world.tick_lag
			while(MaxDistance>0)
				var/travel_angle = GetAngle(src, Trg)
				if(length(src.filters) < 1)
					AppearanceOn()
				animate(src.filters[filters.len], x=sin(travel_angle)*(6/Delay), y=cos(travel_angle)*(6/Delay), time=Delay)
				step_towards(src,Trg)
				if(Trg in oview(1, src))
					MaxDistance=0
					Delay=0
					src.dir=get_dir(src,Trg)
					if(Trg.Knockbacked)
						src.NextAttack=0
						Trg.StopKB()
						if(Clashable)
							for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Clash_Defensive/DC in Trg)
								if(!Trg.BuffOn(DC))
									DC.Trigger(Trg)
							for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Clash/DC in src)
								if(!src.BuffOn(DC))
									DC.Trigger(src)
					break
				else
					MaxDistance-=world.tick_lag
					DelayRelease+=Delay*world.tick_lag
					if(DelayRelease>=1)
						DelayRelease--
						sleep(1*world.tick_lag)
			src.Frozen=0
			if(src.is_dashing>0)
				src.is_dashing--
			if(src.is_dashing<0)
				src.is_dashing=0
			src.icon_state=""
			animate(src.filters[filters.len], x=0, y=0)
			src.dir=get_dir(src,Trg)
		Reincarnate()
			src.Savable=0
			if(istype(src, /mob/Players))
				fdel("Saves/Players/[src.ckey]")
			src.RPPCurrent=src.RPPSpent+src.RPPSpendable
			src.RPPTotal+=src.RPPCurrent
			global.RPPTotal["[src.ckey]"]=(src.RPPTotal/src.GetRPPMult())
			OMsg(src, "[src] fades away slowly, ready to begin a new life...", "[src] reincarnated.")
			animate(src,alpha=0,time=600)
			spawn(600)
				del(src)

		CountStyles(var/Tier=0)
			var/Count=0
			if(!Tier)
				Log("Admin", "[ExtractInfo(src)] tried to count signatures without specifying a tier.")
				return
			for(var/obj/Skills/Buffs/NuStyle/s in src.Skills)
				if(s.SignatureTechnique==Tier)
					Count++
					continue
			return Count
		CountSigs(var/Tier=0)
			var/Count=0
			var/list/combo_check=list()
			if(!Tier)
				Log("Admin", "[ExtractInfo(src)] tried to count signatures without specifying a tier.")
				return
			for(var/obj/Skills/s in src.Skills)
				if(istype(s, /obj/Skills/Buffs/NuStyle))
					continue
				if(s.SignatureTechnique==Tier)
					if("[s.type]" in combo_check)
						continue
					for(var/list/l in SigCombos)
						if("[s.type]" in l)
							combo_check += l
							break

					Count++
					continue
			return Count

		SagaAscend(var/mod, var/val)
			src.SagaAscension["[mod]"]+=val
			src.vars["[mod]Ascension"]+=val
		SagaStat(var/mod)
			return src.SagaAscension["[mod]"]
		SagaThreshold(var/mod, var/threshold)
			var/current=src.SagaStat(mod)
			if(current < threshold)
				src.SagaAscend(mod, threshold-current)
		req_pot(var/val)
			if(src.Potential>=val)
				return 1
			return 0
		req_rpp(var/val)
			if(src.RPPSpendable+src.RPPSpent>=val)
				return 1
			return 0
		req_styles(var/val, var/tier)
			if(src.CountStyles(tier)<=val)
				return 1
			return 0
		req_sigs(var/val, var/tier)
			if(src.CountSigs(tier)<=val)
				return 1
			return 0
		styles_available(var/tier)
			for(var/obj/Skills/Buffs/NuStyle/s in src)
				StyleUnlock(s)
			var/list/styles_available=list()
			styles_available.Add(src.SignatureStyles)
			styles_available.Remove(src.SignatureSelected)
			if(styles_available.len>0)
				for(var/x in styles_available)
					var/path=styles_available[x]
					var/obj/Skills/s=new path
					if(s.SignatureTechnique==tier)
						return 1
					else
						del s
						continue
			else
				return 0
		// THIS IS WHERE POTENTIAL CHECKING IS!!
		//TODO: ALTER FOR WHAT TACO/GAL WANT
		PotentialSkillCheck()
			if(!locate(/obj/Skills/Zanzoken, src))
				if(src.req_pot(1))
					src << "You develop the ability to move faster than the eye can see due to your experience fighting!"
					src.AddSkill(new/obj/Skills/Zanzoken)
			if(!locate(/obj/Skills/Power_Control, src))
				if(src.req_pot(1))
					src << "You develop the ability to fluctuate your power due to your experience fighting!"
					src.AddSkill(new/obj/Skills/Power_Control)
					if(!locate(/obj/Skills/Buffs/ActiveBuffs/Ki_Control, src))
						src.PoweredFormSetup()
			if(!locate(/obj/Skills/Utility/Sense, src))
				if(src.req_pot(1))
					src << "You develop the ability to sense power due to your experience fighting!"
					src.AddSkill(new/obj/Skills/Utility/Sense)
			// if(!locate(/obj/Skills/Buffs/SlotlessBuffs/Ki_Blade, src) && !locate(/obj/Skills/Buffs/SlotlessBuffs/Ki_Shield, src))
			// 	if(src.req_pot(10/max(0.05,src.Imagination)))
			// 		var/Confirm
			// 		var/Choice
			// 		while(Confirm!="Yes")
			// 			Choice=alert(src, "You have developed enough of your fighting spirit to be able to mold it to a particular form. Which would you like to use?", "Ki Forge", "Ki Blade", "Ki Shield")
			// 			switch(Choice)
			// 				if("Ki Blade")
			// 					Confirm=alert(src, "Ki Blade allows you to use armed and unarmed techniques in sync, at the cost of energy expenditure. Damage is calculated based on both force and strength. Do you want to forge this?", "Ki Blade", "No", "Yes")
			// 				if("Ki Shield")
			// 					Confirm=alert(src, "Ki Shield allows you to deflect some energy attacks at the cost of energy expenditure. It also allows you to breathe in hostile environments. Do you want to forge this?", "Ki Shield", "No", "Yes")
			// 		switch(Choice)
			// 			if("Ki Blade")
			// 				src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Ki_Blade)
			// 			if("Ki Shield")
			// 				src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Ki_Shield)

			if(!src.SignatureCheck)
				return
			if(src.Saga)
				if(src.Potential<15 && SagaLevel>=1)
					return
				if(src.Potential<30 && src.SagaLevel>=2)
					return
				if(src.Potential<45&&src.SagaLevel>=3)
					return
				if(src.Potential<65&&src.SagaLevel>=4)
					return
				if(src.SagaLevel>=5&&!src.SagaAdminPermission)
					return
				src.saga_up_self()
				return

			if(styles_available(1) && src.Potential>=5 && src.req_styles(0, 1))
				DevelopSignature(src, 1, "Style")
			if(styles_available(1) && src.Potential>=30 && src.req_styles(1, 1))
				DevelopSignature(src, 1, "Style")
			if(styles_available(2) && src.Potential>=45 && src.req_styles(0, 2))
				DevelopSignature(src, 2, "Style")
			if(styles_available(2) && src.Potential>=65 && src.req_styles(1, 2))
				DevelopSignature(src, 2, "Style")

			if(src.req_pot(5) && src.req_sigs(0, 1))
				DevelopSignature(src, 1, "Signature")
			if(src.req_pot(10) && src.req_sigs(1, 1))
				DevelopSignature(src, 1, "Signature")

			if(src.req_pot(15) && src.req_sigs(2, 1))
				DevelopSignature(src, 1, "Signature")

			if(src.req_pot(30) && src.req_sigs(0, 2))
				DevelopSignature(src, 2, "Signature")
			if(src.req_pot(30) && src.req_sigs(3, 1))
				DevelopSignature(src, 1, "Signature")

			if(src.req_pot(45) && src.req_sigs(1, 2))
				DevelopSignature(src, 2, "Signature")

			if(src.req_pot(65) && src.req_sigs(0, 3))
				if(!src.InfinityModule && src.ShinjinAscension!="Kai" && src.Race!="Changeling")
					DevelopSignature(src, 3, "Signature")

			if(src.req_pot(65) && src.req_sigs(2, 2))
				DevelopSignature(src, 2, "Signature")


		YeetSignatures()
			for(var/obj/Skills/s in src.Skills)
				if(s.SignatureTechnique)
					if(!s.SagaSignature)
						src << "[s] has been removed as it is not one of your saga signatures."
						del s

		MovementChargeBuildUp(var/Mult=1)
			//this ticks per second
			//partial charges are not able to be used
			//30 seconds will result in full charges
			Mult *= clamp(glob.ZANZO_SPEED_LOWEST_CLAMP, GetSpd()**glob.ZANZO_SPEED_EXPONENT, glob.ZANZO_SPEED_HIGHEST_CLAMP)
			var/flick=src.HasFlicker()
			if(flick)
				Mult*=clamp(glob.ZANZO_FLICKER_LOWEST_CLAMP,1+(flick/glob.ZANZO_FLICKER_DIVISOR), glob.ZANZO_FLICKER_HIGHEST_CLAMP)
			if(src.AfterImageStrike)
				return
			src.MovementCharges+=(0.2-(max(0.01,MovementCharges)/3)/10)*Mult
			if(src.MovementCharges>3)
				src.MovementCharges=3
		GetRPPMult()
			var/Return=src.RPPMult
			Return*=src.ConditionRPPMult()
			if(src.TarotFate=="The Hermit")
				Return*=1.5
			return Return
		ConditionRPPMult()
			var/Return=1
			if(src.ParasiteCrest())
				Return*=2
			return Return
		Base()
			var/base = src.Base * BASE_MOD
			return base

		get_potential()
			var/Return=src.Potential

			if(src.HasPowerReplacement())
				var/Replace=src.GetPowerReplacement()
				if(Replace>Return)
					Return=Replace

			if(src.potential_trans)
				if(src.potential_trans > Return)
					Return=src.potential_trans

			if(passive_handler.Get("Transformation Power")) // add straight potential
				Return+=src.GetPassive("Transformation Power")

			if(src.Race=="Shinjin")//one determines the other
				if(src.ShinjinAscension=="Kai")
					var/NoFite=2
					if(src.AscensionsAcquired>0)
						NoFite=1
					src.passive_handler.Set("GodKi", src.Potential/(100*NoFite))
				if(src.ShinjinAscension=="Makai")
					src.passive_handler.Set("GodKi", src.Potential/100)
			//TODO: ALTER SHINJIN GODKI POTENTIAL THING

			return Return


		transcend(var/val)
			if(!locate(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Transcendant, src))
				var/obj/Skills/Buffs/b=new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Transcendant
				b.GodKi=val
				src.AddSkill(b)
		SecretToss(var/obj/Skills/Grapple/Toss/Z)
			if(src.HasRipple())
				src.UseBuff(new/obj/Skills/Buffs/SlotlessBuffs/Ripple/Life_Magnetism_Overdrive)
				src.Oxygen+=(src.OxygenMax)*0.25
				if(src.Oxygen>=(src.OxygenMax)*2)
					src.Oxygen=(src.OxygenMax)*2
				Z.Cooldown(3)
				return
			if(src.Secret=="Vampire")
				// if(!src.PoseEnhancement)
				// 	src.Activate(new/obj/Skills/AutoHit/Shadow_Tendril_Strike)
				// else
				// 	src.Activate(new/obj/Skills/AutoHit/Shadow_Tendril_Wave)
				// Z.Cooldown()
				return
			if(src.Secret=="Werewolf")
				src.Activate(new/obj/Skills/AutoHit/Howl)
				Z.Cooldown(3)
				return
			if(src.Secret=="Eldritch" && CheckSlotless("True Form"))
				src.Activate(new/obj/Skills/AutoHit/Shadow_Tendril_Strike)
				Z.Cooldown()
				return
			if(src.Secret=="Haki")
				src.AddHaki("Armament")
				if(!src.CheckSlotless("Haki Armament"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Armament/H in src)
						H.Trigger(src)
				if(src.CheckSlotless("Haki Observation"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Observation/H in src)
						H.Trigger(src)
				Z.Cooldown(3)
				if(!src.CheckSlotless("Haki Shield")&&!src.CheckSlotless("Haki Shield Lite"))
					if(src.secretDatum.secretVariable["HakiSpecialization"]=="Armament")
						for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Shield/H in src)
							H.Trigger(src)
					else
						for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Shield_Lite/H in src)
							H.Trigger(src)

/mob/Admin4/verb/ChangeWipeStartHour(n as num)
	adjustWipeStartTime(n)

#define SECONDS * 10
#define MINUTES * 600
#define HOURS   * 36000
#define MAX_WIPE_DAYS 500
#define ANIT_LAG_NUM 100


proc
	adjustWipeStartTime(n as num)
		// n = hour to start
		var/wipeStartHour = time2text(glob.progress.WipeStart, "hh", "EST")
		wipeStartHour = text2num(wipeStartHour)
		var/zeroHour = glob.progress.WipeStart - (wipeStartHour HOURS)
		var/newWipeStart = zeroHour + (n HOURS)
		glob.progress.WipeStart = newWipeStart

	DaysOfWipe()
		if(!glob)
			// no glob?
			world.log << "No glob found in DaysOfWipe()!"
			return
		if(!glob.progress)
			// no progress?
			world.log << "No progress found in DaysOfWipe()!"
			return
		var/day = 24 HOURS
		var/days = floor((world.realtime / day) - (glob.progress.WipeStart / day))
		if(days>glob.progress.DaysOfWipe)
			glob.progress.DaysOfWipe=round(days)
			glob.progress.incrementTotal()
		// glob.RPPStarting=(glob.RPPDaily)*glob.progress.DaysOfWipe
		if(glob.progress.DaysOfWipe>MAX_WIPE_DAYS || glob.progress.DaysOfWipe > ANIT_LAG_NUM)
			glob.progress.DaysOfWipe = MAX_WIPE_DAYS
		return glob.progress.DaysOfWipe
	Today()
		return world.realtime-world.timeofday
	Yesterday()
		return Today() - Day(1)

proc
	IsList(var/val)
		if(istype(val, /list))
			return 1
		return 0
proc
	StaticDamage(var/Val, var/Stat1, var/Stat2)
		return ((Val/Stat1)/(Val/Stat2))

/var/global/GLOBAL_EXPONENT_MULT = 1/3
/var/global/GRAPPLE_MELEE_BOON = 1.5
var/global/AUTOHIT_GRAB_NERF = 0.5
var/global/PARTY_DAMAGE_NERF = 0.33

/mob/Admin3/verb/Grab_Auto_Nerf(n as num)
	glob.AUTOHIT_GRAB_NERF = n
	usr << "AUTOHIT_GRAB_NERF set to [n]"

/mob/Admin3/verb/GrappleMeleeBoon(n as num)
	glob.GRAPPLE_MELEE_BOON = n
	usr << "Global grapple melee set to [n]"

/mob/Admin3/verb/GlobalExponentMult(n as num)
	glob.GLOBAL_EXPONENT_MULT = n
	src << "Global exponenty mult set to [n]"

/mob/Admin3/verb/GlobalPartyDamage(n as num)
	glob.PARTY_DAMAGE_NERF = n
	src << "Party Damage mult set to [n]"

proc
	TrueDamage(Damage)
		if(Damage>10)
			return Damage*5
		else if(Damage>5)
			return Damage*10
		else if(Damage<1)
			return Damage*12
		else
			return Damage**3
	ProjectileDamage(Damage) // This is Power * Damage Mult
		return Damage*PROJ_DAMAGE_MULT
	CounterDamage(Damage)
		return clamp(Damage,0.25,1)
proc
	MSay(var/mob/defender, var/msg, var/type="says:")
		for(var/mob/E in hearers(12,defender))
			E<<"<font color=[defender.Text_Color]>[defender] [type] [msg]"
	OMsg(var/mob/defender, var/msg)
		defender.OMessage(10, "[msg]", "[defender]([defender.key]) used ([msg]).")

var/list/general_magic_database = list()
var/list/general_weaponry_database = list()
proc
	BuildGeneralMagicDatabase() // This is a list of generally obtainable magics. For now, it's just used for Crimson grimoire.
		general_magic_database = SkillTree["MagicT1"] + SkillTree["MagicT2"] + SkillTree["MagicT3"] + SkillTree["MagicT4"]
		general_magic_database = general_magic_database.Copy() //Makes it so we don't reference vars in the SkillTree variable.

		for(var/index in general_magic_database) //remove all spell cost references for now.
			general_magic_database[index] = null

		//Now a layer of confirmation for the abilities in here.
		var/obj/Skills/s
		for(var/index in general_magic_database)
			s = text2path(index)
			s = new s
			if(s && istype(s))
				if(!s.MagicNeeded)
					general_magic_database -= index

	BuildGeneralWeaponryDatabase()
		var/list/weaponry_queues=list(
		"/obj/Skills/Queue/Gear/Integrated/Integrated_Pile_Bunker",
		"/obj/Skills/Queue/Gear/Integrated/Integrated_Power_Fist",
		"/obj/Skills/Queue/Gear/Integrated/Integrated_Power_Claw",
		"/obj/Skills/Queue/Gear/Integrated/Integrated_Hook_Grip_Claw",
		"/obj/Skills/Queue/Cyberize/Taser_Strike"
		)
		var/list/weaponry_autohits=list(
		"/obj/Skills/AutoHit/Gear/Integrated/Integrated_Incinerator",
		"/obj/Skills/AutoHit/Cyberize/Machine_Gun_Flurry"
		)
		var/list/weaponry_projectiles=list(
		"/obj/Skills/Projectile/Machine_Gun_Burst",
		"/obj/Skills/Projectile/Homing_Ray_Missiles",
		"/obj/Skills/Projectile/Plasma_Cannon",
		"/obj/Skills/Projectile/Gear/Integrated/Integrated_Missile_Launcher",
		"/obj/Skills/Projectile/Gear/Integrated/Integrated_Chemical_Mortar",
		"/obj/Skills/Projectile/Cyberize/Rocket_Punch"
		)

		general_weaponry_database = weaponry_queues + weaponry_autohits + weaponry_projectiles
		general_weaponry_database = general_weaponry_database.Copy()
