#define Swordsmanship list("Hiten Mitsurugi-Ryuu", "Weapon Soul")


mob
	proc
		HasPassive(var/Passive, var/BuffsOnly=0, var/SwordBuff=0, var/StaffBuff=0, var/NoMobVar=0, var/NoAttackQueue=0)
			if(src.StanceBuff)
				if(src.StanceBuff.vars["[Passive]"])
					return 1
			if(src.StyleBuff)
				if(src.StyleBuff.vars["[Passive]"])
					return 1
			if(src.ActiveBuff)
				if(src.ActiveBuff.vars["[Passive]"])
					return 1
			if(src.SpecialBuff)
				if(src.SpecialBuff.vars["[Passive]"])
					return 1
			for(var/sb in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
				if(b)
					if(b.vars["[Passive]"])
						return 1
			if(!BuffsOnly && !NoAttackQueue)
				if(src.AttackQueue)
					if(src.AttackQueue.vars["[Passive]"])
						return 1
			if(SwordBuff||StaffBuff)
				var/obj/Items/Sword/s=src.EquippedSword()
				var/obj/Items/Enchantment/Staff/st=src.EquippedStaff()
				if(SwordBuff)
					if(s)
						if(s.vars["[Passive]"])
							return 1
				if(StaffBuff)
					if(st)
						if(st.vars["[Passive]"])
							return 1
			else
				if(!NoMobVar)
					if(src.vars["[Passive]"])
						return 1
			return 0
		GetPassive(var/Passive, var/BuffsOnly=0, var/SwordBuff=0, var/StaffBuff=0, var/NoMobVar=0, var/NoAttackQueue=0)
			var/Return=0

			if(SwordBuff)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(s)
					if(s.vars["[Passive]"])
						Return+=s.vars["[Passive]"]
			if(StaffBuff)
				var/obj/Items/Sword/st=src.EquippedStaff()
				if(st)
					if(st.vars["[Passive]"])
						Return+=st.vars["[Passive]"]
			if(!NoMobVar)
				if(src.vars["[Passive]"])
					Return+=src.vars["[Passive]"]
			if(src.StanceBuff)
				if(src.StanceBuff.vars["[Passive]"])
					Return+=src.StanceBuff.vars["[Passive]"]
			if(src.StyleBuff)
				if(src.StyleBuff.vars["[Passive]"])
					Return+=src.StyleBuff.vars["[Passive]"]
			if(src.ActiveBuff)
				if(src.ActiveBuff.vars["[Passive]"])
					Return+=src.ActiveBuff.vars["[Passive]"]
			if(src.SpecialBuff)
				if(src.SpecialBuff.vars["[Passive]"])
					Return+=src.SpecialBuff.vars["[Passive]"]
			for(var/sb in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
				if(b)
					if(b.vars["[Passive]"])
						Return+=b.vars["[Passive]"]
			if(!BuffsOnly)
				if(src.AttackQueue && !NoAttackQueue)
					if(src.AttackQueue.vars["[Passive]"])
						Return+=src.AttackQueue.vars["[Passive]"]
			return Return
		GetPassiveCount(var/Passive, var/BuffsOnly=0, var/SwordBuff=0, var/StaffBuff=0, var/NoMobVar=0)
			var/Sources=0
			if(SwordBuff)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(s)
					if(s.vars["[Passive]"])
						Sources+=s.vars["[Passive]"]
			else
				if(!NoMobVar)
					if(src.vars["[Passive]"])
						Sources+=src.vars["[Passive]"]
			if(src.StanceBuff)
				if(src.StanceBuff.vars["[Passive]"])
					Sources+=src.StanceBuff.vars["[Passive]"]
			if(src.StyleBuff)
				if(src.StyleBuff.vars["[Passive]"])
					Sources+=src.StyleBuff.vars["[Passive]"]
			if(src.ActiveBuff)
				if(src.ActiveBuff.vars["[Passive]"])
					Sources+=src.ActiveBuff.vars["[Passive]"]
			if(src.SpecialBuff)
				if(src.SpecialBuff.vars["[Passive]"])
					Sources+=src.SpecialBuff.vars["[Passive]"]
			for(var/sb in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
				if(b)
					if(b.vars["[Passive]"])
						Sources+=b.vars["[Passive]"]
			if(!BuffsOnly)
				if(src.AttackQueue)
					if(src.AttackQueue.vars["[Passive]"])
						Sources+=src.AttackQueue.vars["[Passive]"]
			return Sources
		AveragePassive(var/Passive, var/BuffsOnly=0, var/SwordBuff=0, var/StaffBuff=0, var/NoMobVar=0)
			var/Return=0
			var/Sources=0
			if(SwordBuff)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(s)
					if(s.vars["[Passive]"])
						Return+=s.vars["[Passive]"]
						Sources++
			else
				if(!NoMobVar)
					if(src.vars["[Passive]"])
						Return+=src.vars["[Passive]"]
						Sources++
			if(src.StanceBuff)
				if(src.StanceBuff.vars["[Passive]"])
					Return+=src.StanceBuff.vars["[Passive]"]
					Sources++
			if(src.StyleBuff)
				if(src.StyleBuff.vars["[Passive]"])
					Return+=src.StyleBuff.vars["[Passive]"]
					Sources++
			if(src.ActiveBuff)
				if(src.ActiveBuff.vars["[Passive]"])
					Return+=src.ActiveBuff.vars["[Passive]"]
					Sources++
			if(src.SpecialBuff)
				if(src.SpecialBuff.vars["[Passive]"])
					Return+=src.SpecialBuff.vars["[Passive]"]
					Sources++
			for(var/sb in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
				if(b)
					if(b.vars["[Passive]"])
						Return+=b.vars["[Passive]"]
						Sources++
			if(!BuffsOnly)
				if(src.AttackQueue)
					if(src.AttackQueue.vars["[Passive]"])
						Return+=src.AttackQueue.vars["[Passive]"]
						Sources++
			Return/=Sources
			Return=round(Return, 0.25)
			return Return
		GetSwordDamage(var/obj/Items/Sword/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.DamageEffectiveness
				Ascensions=s.Ascended
				if(src.HasSwordAscension())
					Ascensions+=src.GetSwordAscension()
				if(Ascensions>6)
					Ascensions=6
				if(src.Saga)
					if(src.Saga in Swordsmanship)
						switch(Saga)
							if("Weapon Soul")
								if(src.SagaLevel>=2)
									Ascensions += SagaLevel/3
							if("Hiten Mitsurugi-Ryuu")
								if(src.SagaLevel>=3)
									Ascensions += SagaLevel/3
					if(Ascensions>6)
						Ascensions=6
				if(s.Glass)
					Ascensions+=1
				if(s.Conversions=="Sharp")
					Ascensions += (0.1) * s.ShatterTier
			else if(src.CheckSlotless("Excalibur"))
				Total=2
				if(src.HasSwordAscension())
					Ascensions+=src.GetSwordAscension()
					if(Ascensions>6)
						Ascensions=6
			if(src.UsingKendo())
				Ascensions++
			if(src.HasSwordDamageBuff())
				Ascensions+=src.GetSwordDamageBuff()
			Total*=1+(Ascensions*glob.SwordAscDamage)
			return Total
		GetSwordDelay(var/obj/Items/Sword/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.SpeedEffectiveness
				Ascensions=s.Ascended
				if(src.HasSwordAscension())
					Ascensions+=src.GetSwordAscension()
					if(Ascensions>6)
						Ascensions=6
				if(src.Saga)
					if(src.Saga in Swordsmanship)
						switch(Saga)
							if("Weapon Soul")
								if(src.SagaLevel>=2)
									Ascensions += SagaLevel/3
							if("Hiten Mitsurugi-Ryuu")
								if(src.SagaLevel>=3)
									Ascensions += SagaLevel/3
					if(Ascensions>6)
						Ascensions=6
				if(s.Glass)
					Ascensions+=1
				if(s.Conversions=="Light")
					Ascensions+=1
			else if(src.CheckSlotless("Excalibur"))
				Total=0.95
				if(src.HasSwordAscension())
					Ascensions+=src.GetSwordAscension()
					if(Ascensions>6)
						Ascensions=6
			if(src.UsingKendo())
				Ascensions++
			if(src.HasSwordDelayBuff())
				Ascensions+=src.GetSwordDelayBuff()
			Total*=1+(Ascensions*glob.SwordAscDelay)
			return Total
		GetSwordAccuracy(var/obj/Items/Sword/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.AccuracyEffectiveness
				Ascensions=s.Ascended
				if(src.HasSwordAscension())
					Ascensions+=src.GetSwordAscension()
					if(Ascensions>6)
						Ascensions=6
				if(src.Saga)
					if(src.Saga in Swordsmanship)
						switch(Saga)
							if("Weapon Soul")
								if(src.SagaLevel>=2)
									Ascensions += SagaLevel/3
							if("Hiten Mitsurugi-Ryuu")
								if(src.SagaLevel>=3)
									Ascensions += SagaLevel/3
					if(Ascensions>6)
						Ascensions=6
				if(s.Glass)
					Ascensions+=1
				if(s.Conversions=="Hardened")
					Ascensions-=1
			else if(src.CheckSlotless("Excalibur"))
				Total=0.9
				if(src.HasSwordAscension())
					Ascensions+=src.GetSwordAscension()
					if(Ascensions>6)
						Ascensions=6
			if(src.UsingKendo())
				Ascensions++
			if(src.HasSwordAccuracyBuff())
				Ascensions+=src.GetSwordAccuracyBuff()
			Total*=1+(Ascensions*glob.SwordAscAcc)
			return Total
		HasSwordAscension()
			if(passive_handler.Get("SwordAscension"))
				return 1
			return 0
		GetSwordAscension()
			return passive_handler.Get("SwordAscension")
		HasSwordDamageBuff()
			if(passive_handler.Get("SwordDamage"))
				return 1
			return 0
		GetSwordDamageBuff()
			return passive_handler.Get("SwordDamage")
		HasSwordDelayBuff()
			if(passive_handler.Get("SwordDelay"))
				return 1
			return 0
		GetSwordDelayBuff()
			return passive_handler.Get("SwordDelay")
		HasSwordAccuracyBuff()
			if(passive_handler.Get("SwordAccuracy"))
				return 1
			return 0
		GetSwordAccuracyBuff()
			return passive_handler.Get("SwordAccuracy")
		GetStaffDamage(var/obj/Items/Enchantment/Staff/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.DamageEffectiveness
				Ascensions=s.Ascended
				if(src.HasStaffAscension())
					Ascensions+=src.GetStaffAscension()
					if(Ascensions>6)
						Ascensions=6
			Total*=1+(Ascensions*glob.StaffAscDamage)
			return Total
		GetStaffDrain(var/obj/Items/Enchantment/Staff/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.SpeedEffectiveness
				Ascensions=s.Ascended
				if(src.HasStaffAscension())
					Ascensions+=src.GetStaffAscension()
					if(Ascensions>4)
						Ascensions=4
			Total*=1+(Ascensions*glob.StaffAscDelay)
			return Total
		GetStaffAccuracy(var/obj/Items/Enchantment/Staff/s)
			var/Total=1
			if(s)
				Total=s.AccuracyEffectiveness
				var/Ascensions=s.Ascended
				if(src.HasStaffAscension())
					Ascensions+=src.GetStaffAscension()
					if(Ascensions>4)
						Ascensions=4
				if(s.Conversions=="Hardened")
					Ascensions-=1
				Total*=1+(Ascensions*glob.StaffAscAcc)
			return Total
		HasStaffAscension()
			if(passive_handler.Get("StaffAscension"))
				return 1
			return 0
		GetStaffAscension()
			return passive_handler.Get("StaffAscension")
		GetArmorDamage(var/obj/Items/Armor/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.DamageEffectiveness
				Ascensions=s.Ascended
				if(src.HasArmorAscension())
					Ascensions+=src.GetArmorAscension()
					if(Ascensions>4)
						Ascensions=4
				if(src.HasArmorDamageBuff())
					Ascensions+=src.GetArmorDamageBuff()
			Total*=1+(Ascensions*glob.ArmorAscDamage)
			return Total
		GetArmorDelay(var/obj/Items/Armor/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.SpeedEffectiveness
				Ascensions=s.Ascended
				if(src.HasArmorAscension())
					Ascensions+=src.GetArmorAscension()
					if(Ascensions>4)
						Ascensions=4
				if(src.HasArmorDelayBuff())
					Ascensions+=src.GetArmorDelayBuff()
			Total*=1+(Ascensions*glob.ArmorAscDelay)
			return Total
		GetArmorAccuracy(var/obj/Items/Armor/s)
			var/Total=1
			var/Ascensions=0
			if(s)
				Total=s.AccuracyEffectiveness
				Ascensions=s.Ascended
				if(src.HasArmorAscension())
					Ascensions+=src.GetArmorAscension()
					if(Ascensions>4)
						Ascensions=4
				if(s.Conversions=="Hardened")
					Ascensions-=1
				if(src.HasArmorAccuracyBuff())
					Ascensions+=src.GetArmorAccuracyBuff()
			Total*=1+(Ascensions*glob.ArmorAscAcc)
			return Total
		HasArmorAscension()
			if(passive_handler.Get("ArmorAscension"))
				return 1
			return 0
		GetArmorAscension()
			return passive_handler.Get("ArmorAscension")
		HasArmorDamageBuff()
			if(passive_handler.Get("ArmorDamage"))
				return 1
			return 0
		GetArmorDamageBuff()
			return passive_handler.Get("ArmorDamage")
		HasArmorDelayBuff()
			if(passive_handler.Get("ArmorDelay"))
				return 1
			return 0
		GetArmorDelayBuff()
			return passive_handler.Get("ArmorDelay")
		HasArmorAccuracyBuff()
			if(passive_handler.Get("ArmorAccuracy"))
				return 1
			return 0
		GetArmorAccuracyBuff()
			return passive_handler.Get("ArmorAccuracy")
		HasShatterTier(var/obj/Items/Equip)//this is so fucking stupid, everything should just work off shatter tier
			if(!Equip.Destructable)
				return 0
			if(Equip.ShatterTier)
				return 1
			if(istype(Equip, /obj/Items/Armor))
				return 1
			return 0
		GetShatterTier(var/obj/Items/Equip)//as above
			if(!Equip) return 0
			if(!Equip.Destructable)
				return 0
			var/Total=0
			if(Equip.ShatterTier)
				Total+=Equip.ShatterTier
			if(istype(Equip, /obj/Items/Armor))
				Total+=4-min(Equip.Ascended+src.GetArmorAscension(),4)
			if(Total>4)
				Total=4
			return Total
		MovementSealed()
			for(var/obj/Seal/s in src)
				if(s.ZPlaneBind)
					return 1
			return 0
		HasTensionLock()
			if(passive_handler.Get("TensionDrain"))
				return 1
			return 0
		HasEmptyGrimoire()
			if(locate(/obj/Skills/Teleport/Traverse_Void, src))
				return 1
			return 0
		HasMafuba()
			if(locate(/obj/Skills/Buffs/SlotlessBuffs/Grimoire/Mafuba, src))
				return 1
			return 0
		HasElementalDefense(var/ele)
			if(src.ElementalDefense==ele)
				return 1
			if(src.HasArmor())
				var/obj/Items/Armor/a=src.EquippedArmor()
				if(a.Element==ele)
					return 1
			return 0
		HasFakePeace()
			if(passive_handler.Get("FakePeace"))
				return 1
			return 0
		HasDashMaster()
			if(passive_handler.Get("DashMaster"))
				return 1
			return 0
		HasDashCount()
			if(passive_handler.Get("DashCountLimit"))
				return 1
			return 0
		GetDashCount()
			return passive_handler.Get("DashCount")
		IncDashCount()
			if(src.ActiveBuff)
				if(src.ActiveBuff.DashCountLimit)
					src.ActiveBuff.DashCount++
					if(src.ActiveBuff.DashCount>=src.ActiveBuff.DashCountLimit)
						src.ActiveBuff.Trigger()
			if(src.SpecialBuff)
				if(src.SpecialBuff.DashCountLimit)
					src.SpecialBuff.DashCount++
					if(src.SpecialBuff.DashCount>=src.SpecialBuff.DashCountLimit)
						src.SpecialBuff.Trigger()
			for(var/b in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/sb = SlotlessBuffs[b]
				if(sb)
					if(sb.DashCountLimit)
						sb.DashCount++
						if(sb.DashCount>=sb.DashCountLimit)
							sb.Trigger(src)
			if(!src.HasDashMaster())
				for(var/obj/Skills/Dragon_Dash/dd in src)
					dd.Cooldown=30
				for(var/obj/Skills/Reverse_Dash/rd in src)
					rd.Cooldown=30

		HasAdrenalBoost()
			if(passive_handler.Get("AdrenalBoost"))
				return 1
			return 0
		HasBetterAim()
			if(passive_handler.Get("BetterAim"))
				return 1
			return 0
		GetBetterAim()
			return passive_handler.Get("BetterAim")
		HasMechanized()
			if(src.Race=="Android")
				return 1
			if(passive_handler.Get("Mechanized"))
				return 1
			if(src.CyberCancel)
				return 1
			return 0
		HasPiloting()
			if(passive_handler.Get("Piloting"))
				return 1
			return 0
		HasPossessive()
			if(passive_handler.Get("Possessive"))
				return 1
			return 0
		HasImitate()
			if(passive_handler.Get("Imitate"))
				return 1
			return 0
		TomeSpell(var/obj/Skills/Z)
			if(!Z) return 0
			var/Streamline=0
			var/obj/Items/Enchantment/Tome/T=src.EquippedTome()
			var/obj/Items/Enchantment/Magic_Crest/MC=src.EquippedCrest()
			if(T)
				for(var/obj/Skills/S in T.Spells)
					if(Z.type==S.type)
						Streamline+=1
			if(is_arcane_beast || CheckSpecial("Wisdom Form") || CheckSpecial("Master Form") || CheckSpecial("Final Form"))
				Streamline+=1
			if(src.UsingMasteredMagicStyle())
				if(Z.ElementalClass)
					if(StyleBuff)
						if(islist(src.StyleBuff.ElementalClass))
							if(Z.ElementalClass in src.StyleBuff.ElementalClass)
								Streamline+=1
						else
							if(src.StyleBuff.ElementalClass==Z.ElementalClass)
								Streamline+=1
				else
					Streamline+=1
			else if(MC)
				for(var/obj/Skills/S in MC.Spells)
					if(Z.type==S.type)
						Streamline+=1
			return Streamline

		CrestSpell(var/obj/Skills/Z)
			var/obj/Items/Enchantment/Magic_Crest/MC=src.EquippedCrest()
			if(MC)
				for(var/obj/Skills/S in MC.Spells)
					if(Z.type==S.type)
						return 1
			return 0

		EquippedTome()
			var/obj/Items/Enchantment/Tome/T
			for(var/obj/Items/Enchantment/Tome/Tomes in src)
				if(Tomes.suffix=="*Equipped*")
					T=Tomes
					return T
			return 0
		EquippedFlyingDevice()
			var/obj/Items/Enchantment/Flying_Device/FD
			for(var/obj/Items/Enchantment/Flying_Device/Fly in src)
				if(Fly.suffix=="*Equipped*")
					FD=Fly
					return FD
			return 0
		EquippedSurfingDevice()
			var/obj/Items/Enchantment/Surfing_Device/SD
			for(var/obj/Items/Enchantment/Surfing_Device/Surf in src)
				if(Surf.suffix=="*Equipped*")
					SD=Surf
					return SD
			return 0
		EquippedCrest()
			var/obj/Items/Enchantment/Magic_Crest/MC
			for(var/obj/Items/Enchantment/Magic_Crest/Crest in src)
				if(Crest.suffix=="*Equipped*")
					MC=Crest
					return MC
			return 0
		ParasiteCrest()
			for(var/obj/Items/Enchantment/Magic_Crest/Crest in src)
				if(Crest==src.EquippedCrest())
					if(Crest.Parasite&&!src.Timeless)
						return 1
			return 0
		HasPlatedWeights()
			var/obj/Items/WeightedClothing/WC=src.EquippedWeights()
			if(WC)
				if(WC.Plated)
					return 1
			return 0
		HasCeramicPlating()
			var/obj/Items/Plating/P=src.EquippedPlating()
			if(istype(P, /obj/Items/Plating/Ceramic_Plating))
				if(P.suffix=="*Broken")
					return 0
				return 1
			return 0
		HasRefractivePlating()
			var/obj/Items/Plating/P=src.EquippedPlating()
			if(istype(P, /obj/Items/Plating/Refractive_Plating))
				return 1
			return 0
		HasBlastShielding()
			var/obj/Items/BlastShielding/B=src.EquippedShielding()
			if(B)
				return 1
			return 0
		EquippedPlating()
			var/obj/Items/Plating/P
			for(var/obj/Items/Plating/Platez in src)
				if(Platez.suffix=="*Equipped*")
					P=Platez
					break
			if(P)
				return P
			return 0
		EquippedShielding()
			var/obj/Items/BlastShielding/B
			for(var/obj/Items/BlastShielding/Shieldz in src)
				if(Shieldz.suffix=="*Equipped*")
					B=Shieldz
					break
			if(B)
				return B
			return 0
		GetProsthetics()
			return equippedProsthetics
/*			for(var/obj/Items/Gear/Prosthetic_Limb/PL in src)
				if(PL.suffix=="*Equipped*")
					Return++
			if(Return > 4)
				Return=4
			return Return*/
		HasJagan()
			if(locate(/obj/Skills/Buffs/SpecialBuffs/Cursed/Jagan_Eye, src))
				return 1
			return 0
		HasScouter()
			for(var/obj/Items/Tech/Scouter/Scoutz in src)
				if(Scoutz.suffix=="*Equipped*")
					return 1
			if(src.InternalScouter)
				return 1
			return 0
		HasIntuition()
			if(locate(/obj/Skills/Buffs/SpecialBuffs/Cursed/Jagan_Eye, src))
				return 1
			if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Observation")
				return 1
			if(src.SenseUnlocked>5&&src.SenseUnlocked>src.SenseRobbed)
				return 1
			if(src.GetGodKi()>=0.25)
				return 1
		HasClarity()
			if(passive_handler.Get("Omnipotent")) // so admins can fucking see
				return 1
			if(knowledgeTracker)
				if("Combat Scanning" in src.knowledgeTracker.learnedKnowledge)
					return 1
			if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Observation")
				return 1
			if(src.GetGodKi()>=0.25)
				return 1
			return 0
		HasEnlightenment()
			if(src.Dead)
				if(src.HasGodKi())
					return 1
				if(src.Saga=="Sharingan"&&src.SagaLevel==8)
					return 1
				if(src.Saga=="Cosmo"&&src.SagaLevel>=7)
					return 1
				if(src.HasSpiritPower()>=1)
					return 1
			return 0
		HasTransMimic()
			return passive_handler.Get("TransMimic")
		HasBuffMastery()
			var/Return=0
			Return+=passive_handler.Get("BuffMastery")
			if(Secret=="Haki")
				Return+=secretDatum.currentTier
			var/stp=src.SaiyanTransPower()
			if(stp)
				Return+=stp
			return Return
		HasPursuer()
			var/Return=0
			Return+=passive_handler.Get("Pursuer")
			if(Target)
				if(isDominating(Target) && HellRisen)
					Return += HellRisen * 2
			if(src.Saga=="Eight Gates")
				Return+=2
			if(src.Race=="Alien" && src.AscensionsAcquired>=5)
				Return+=2
			if(src.KamuiBuffLock)
				Return+=3
			var/stp=src.SaiyanTransPower()
			if(stp)
				Return+=stp
			return Return
		HasGodspeed()
			var/Return=0
			var/gk=src.GetGodKi()
			if(gk>=0.25)
				Return+=round(gk/0.25)
			Return+=passive_handler.Get("Godspeed")
			var/t=src.HighestTrans()
			if(t)
				Return+=t/2
			if(src.InfinityModule)
				Return+=1
			if(src.KamuiBuffLock)
				Return++
				Return++
			Return=round(Return)
			Return=min(8,Return)
			return Return
		HasFlicker()
			var/Return=0
			var/gk=src.GetGodKi()
			if(gk>=0.5)
				Return+=round(gk/0.5)
			if(src.Secret=="Haki")
				Return += clamp(secretDatum.currentTier/2, 1, 2)
			Return+=passive_handler.Get("Flicker")
/*			if(src.HasWalking())
				Return++
			if(src.HasShunkanIdo())
				Return++*/
			var/stp=src.SaiyanTransPower()
			if(stp)
				Return+=stp
			if(src.InfinityModule)
				Return++
			if(src.KamuiBuffLock)
				Return++
				Return++
			if(Target)
				if(isDominating(Target) && HellRisen)
					Return += clamp((HellRisen*2), 1, 2)
			return Return
		HasDeathField()
			if(passive_handler.Get("DeathField"))
				return 1
			if(src.KamuiBuffLock)
				return 1
			return 0
		GetDeathField()
			return passive_handler.Get("DeathField")+(src.KamuiBuffLock*10)
		HasVoidField()
			if(passive_handler.Get("VoidField"))
				return 1
			if(src.CheckSlotless("Drunken Mastery") && src.Drunk)
				return 1
			return 0
		GetVoidField()
			var/Extra=0
			if(src.CheckSlotless("Drunken Mastery") && src.Drunk)
				Extra+=2
			return passive_handler.Get("VoidField")+Extra
		HasMaimStrike()
			return 0
			if(passive_handler.Get("MaimStrike"))
				return 1
		GetMortalStrike()
			. = 0
			. += passive_handler.Get("MortalStrike")
			if(Target)
				if(isDominating(Target) && HellRisen >= 0.75)
					. += HellRisen/4
			if(isHalfDemon())
				. += 0.15 * src.AscensionsAcquired
			return .
		GetMaimStrike()
			return 0
			var/Return=0
			Return += passive_handler.Get("MaimStrike")
			Return += MaimStrike
			// if(src.DemonicPower())
			// 	Return+=0.05 * src.AscensionsAcquired
			if(src.Saga=="Ansatsuken"&&src.AnsatsukenAscension=="Chikara")
				Return-=(Return * (0.25*(src.SagaLevel-4)))
			if(Return<0.001)
				Return=0.001
			return Return
		HasNoMiss()
			if(passive_handler.Get("NoMiss"))
				return 1
			return 0
		HasNoDodge()
			if(passive_handler.Get("NoDodge"))
				return 1
			return 0
		HasVoid()
			if(passive_handler.Get("Void"))
				return 1
			return 0
		HasBleedHit()
			if(passive_handler.Get("BleedHit"))
				return 1
			if(src.GatesActive && src.GatesActive>=3 && src.GatesActive<8)
				return 1
			if(src.CheckSpecial("Kaioken"))
				return 1
			if(src.HasHealthPU())
				if(src.PowerControl>100)
					return 1
			return 0
		GetBleedHit()
			var/Return=0
			var/kkmast=0
			Return+=passive_handler.Get("BleedHit")
			if(src.Kaioken)
				for(var/obj/Skills/Buffs/SpecialBuffs/Kaioken/kk in src.Buffs)
					kkmast=kk.Mastery
				Return+=src.Kaioken
			if(src.HasHealthPU())
				if(src.PowerControl>100)
					Return*=(src.PowerControl/100)
			if(src.Saga=="Kamui")
				Return -= (Return / 8) * src.SagaLevel
			if(src.GatesActive && src.GatesActive >=3 && src.GatesActive<8)
				Return+=(1/src.SagaLevel)
			if(src.Kaioken)
				if(kkmast>src.Kaioken)
					Return=src.Kaioken/2
			return Return
		HasEnergyLeak()
			if(passive_handler.Get("EnergyLeak"))
				return 1
			if(src.TransActive()&&!src.HasMystic())
				if(src.masteries["[src.TransActive()]mastery"]>10&&src.masteries["[src.TransActive()]mastery"]<75||(src.Race=="Saiyan"&&src.HasGodKi()&&masteries["4mastery"]!=100))
					if(src.Race!="Changeling")
						return 1
					else
						if(src.TransActive()>3)
							return 1
			return 0
		GetEnergyLeak()
			var/Total=0
			Total+=passive_handler.Get("EnergyLeak")
			if(src.TransActive()&&!src.HasMystic())
				if(src.masteries["[src.TransActive()]mastery"]>10&&src.masteries["[src.TransActive()]mastery"]<75)
					if(src.Race!="Changeling")
						Total+=src.TransActive()*0.25
					else
						if(src.TransActive()>3)
							Total+=0.5
			return Total
		HasFatigueLeak()
			if(passive_handler.Get("FatigueLeak"))
				return 1
			if(src.TransActive()&&src.Race=="Saiyan"&&src.HasGodKi()&&masteries["4mastery"]!=100)
				return 1
			if(src.GatesActive && src.GatesActive < 8)
				return 1
			return 0
		GetFatigueLeak()
			var/Total=0
			Total+=passive_handler.Get("FatigueLeak")
			if(src.TransActive()&&src.Race=="Saiyan"&&src.HasGodKi()&&masteries["4mastery"]!=100)
				Total+=1
			return  Total
		HasSoftStyle()
			if(passive_handler.Get("SoftStyle"))
				return 1
			return 0
		GetSoftStyle()
			return passive_handler.Get("SoftStyle")
		HasHardStyle()
			if(passive_handler.Get("HardStyle"))
				return 1
			if(src.KamuiBuffLock)
				return 1
			return 0
		GetHardStyle()
			return passive_handler.Get("HardStyle")+(src.KamuiBuffLock*3)
		GetDebuffCrash()
			var/list/Debuffs=list()
			for(var/sb in SlotlessBuffs)
				var/obj/Skills/Buffs/SlotlessBuffs/b = SlotlessBuffs[sb]
				if(b)
					if(b.DebuffCrash)
						Debuffs.Add(b.DebuffCrash)
			if(Debuffs.len > 0)
				return Debuffs
			return 0
		HasCyberStigma()
			if(passive_handler.Get("CyberStigma"))
				return 1
			return 0
		GetCyberStigma()
			return passive_handler.Get("CyberStigma")
		HasKiControl()
			if(passive_handler.Get("KiControl"))
				return 1
			return 0
		HasKiControlMastery()
			if(src.GetGodKi()>=0.25 && src.Race!="Shinjin")
				return 1
			if(src.AdaptationCounter&&src.AdaptationTarget)
				return 1
			if(passive_handler.Get("KiControlMastery"))
				return 1
			if(src.Race=="Namekian"&&src.TransActive())
				return 1
			if(src.Race=="Shinjin"&&src.Potential>=25)
				return 1
			if(src.Race in list("Demon", "Dragon"))
				return 1
			if(src.Race in list("Human", "Half Saiyan", "Changeling", "Makyo")&&src.AscensionsAcquired)
				return 1
			return 0
		GetKiControlMastery()
			var/Total=passive_handler.Get("KiControlMastery")
			if(src.AdaptationCounter&&src.AdaptationTarget)
				Total+=src.AdaptationCounter
			if(src.HasGodKi() && src.Race!="Shinjin")
				Total+=round(src.GetGodKi()/0.25)
			if(src.Race=="Namekian"&&src.TransActive())
				Total+=3
			if(src.Race=="Makyo"&&src.AscensionsAcquired)
				Total+=src.AscensionsAcquired
			if(src.Race=="Shinjin")
				Total+=round(src.Potential/25)
			if(src.Race in list("Dragon", "Demon"))
				Total+=1
			if(src.Race in list("Human", "Changeling")&&src.AscensionsAcquired)
				Total+=(0.5*src.AscensionsAcquired)
			// if(src.Race=="Half Saiyan"&&src.AscensionsAcquired)
			// 	Total+=(0.25*src.AscensionsAcquired)
			return min(Total,4)
		HasPULimited()
			if(passive_handler.Get("AllowedPower"))
				return 1
			return 0
		GetPULimited()
			return passive_handler.Get("AllowedPower")
		HasPULock()
			if(passive_handler.Get("PULock"))
				return 1
			return 0
		HasPUSpike()
			if(passive_handler.Get("PUSpike"))
				return 1
			return 0
		GetPUSpike()
			return passive_handler.Get("PUSpike")
		HasUnstoppable()
			if(passive_handler.Get("Unstoppable"))
				return 1
			return 0
		SaiyanTransPower()
			var/t
			var/m
			if(src.HasTransMimic() && src.Race in list("Saiyan", "Half Saiyan"))
				t=src.HasTransMimic()
			if(src.TransActive() && src.Race in list("Saiyan", "Half Saiyan"))
				m=src.TransActive()
			if(t || m)
				if(t>m)
					return t
				else
					return m
			else
				return 0
		DrunkPower()
			if(src.CheckSlotless("Drunken Mastery") && src.Drunk)
				return 1
		HasPureDamage()
			var/Return=0
			Return+=passive_handler.Get("PureDamage")
			var/stp=src.SaiyanTransPower()
			if(stp)
				Return+=stp
			if(src.DrunkPower())
				Return+=3
			var/mm=src.HasMaimMastery()
			if(src.Maimed&&mm)
				Return+=(src.Maimed*mm)*0.5
			if(src.TarotFate=="The Hanged Man")
				Return+=5
			if(src.TarotFate=="Justice")
				Return-=5
			if(Target)
				if(isDominating(Target) && HellRisen)
					Return += HellRisen / 5
			if(Race=="Majin")
				Return += Potential * getMajinRates("Damage")
			return Return
		HasPureReduction()
			var/Return=0
			Return+=passive_handler.Get("PureReduction")
			var/stp=src.SaiyanTransPower()
			if(stp)
				Return+=stp
			var/mm=src.HasMaimMastery()
			if(src.Maimed&&mm)
				Return+=(src.Maimed*mm)*0.5
			if(src.Race=="Majin")
				Return += Potential * getMajinRates("Reduction")
			if(src.TarotFate=="The Hanged Man")
				Return-=5
			if(src.TarotFate=="Justice")
				Return+=5
			return Return
		HasWalking()
			if(locate(/obj/Skills/Walking, src))
				return 1
			return 0
		HasShunkanIdo()
			if(locate(/obj/Skills/Teleport/Instant_Transmission, src))
				return 1
			return 0
		HasVaizard()
			if(locate(/obj/Skills/Buffs/SpecialBuffs/Cursed/Vaizard_Mask, src))
				for(var/obj/Skills/Buffs/SpecialBuffs/Cursed/Vaizard_Mask/vm in src.Buffs)
					if(vm.Mastery==1)
						return 2
				return 1
			return 0
		HasJinchuuriki()
			if(locate(/obj/Skills/Buffs/SpecialBuffs/Cursed/Jinchuuriki, src))
				return 1
			return 0
		HasSweepingStrike()
			if(passive_handler.Get("SweepingStrike"))
				return 1
			if(src.CheckSlotless("Sage Mode")&&src.StyleActive)
				return 1
			return 0
		HasTechniqueMastery()
			if(passive_handler.Get("TechniqueMastery"))
				return 1
			if(src.TarotFate=="The World")
				return 1
			if(Target)
				if(isDominating(Target) && HellRisen)
					return 1
			return 0
		GetTechniqueMastery()
			var/Return=0
			Return+=passive_handler.Get("TechniqueMastery")
			if(Target)
				if(isDominating(Target) && HellRisen >= 0.75)
					Return += AscensionsAcquired-2
			if(src.TarotFate=="The World")
				Return+=5
			return Return
		HasUnarmedDamage()
			if(passive_handler.Get("UnarmedDamage"))
				return 1
			return 0
		GetUnarmedDamage()
			return passive_handler.Get("UnarmedDamage")
		HasSpiritualDamage()
			if(passive_handler.Get("SpiritualDamage"))
				return 1
			return 0
		GetSpiritualDamage()
			return passive_handler.Get("SpiritualDamage")
		HasDuelist()
			if(passive_handler.Get("Duelist"))
				return 1
			return 0
		GetDuelist()
			return passive_handler.Get("Duelist")
		HasVanish()
			if(passive_handler.Get("Vanishing"))
				return 1
			return 0
		GetVanish()
			return passive_handler.Get("Vanishing")
		HasMovementMastery()
			if(passive_handler.Get("MovementMastery"))
				return 1
			return 0
		GetMovementMastery()
			var/Total=0
			Total+=passive_handler.Get("MovementMastery")
			if(src.DrunkPower())
				Total+=2
			return Total
		HasPhysicalHitsLimit()
			if(passive_handler.Get("PhysicalHitsLimit"))
				return 1
			return 0
		HasSwordHitsLimit()
			if(passive_handler.Get("SwordHitsLimit"))
				return 1
			return 0
		HasUnarmedHitsLimit()
			if(passive_handler.Get("UnarmedHitsLimit"))
				return 1
			return 0
		HasSpiritHitsLimit()
			if(passive_handler.Get("SpiritHitsLimit"))
				return 1
			return 0
		HasAutoReversal()
			if(passive_handler.Get("Reversal"))
				return 1
			return 0
		GetAutoReversal()
			return passive_handler.Get("Reversal") / 10
		HasAttracting()
			if(passive_handler.Get("Attracting"))
				return 1
			return 0
		GetAttracting()
			return passive_handler.Get("Attracting")
		HasTerrifying()
			if(passive_handler.Get("Terrifying"))
				return 1
			return 0
		GetTerrifying()
			return passive_handler.Get("Terrifying")
		HasNoRevert()
			if(passive_handler.Get("NoRevert"))
				return 1
			return 0
		HasCounterMaster()
			return passive_handler.Get("CounterMaster")
		GetCounterMaster()
			return passive_handler.Get("CounterMaster")
		HasActiveBuffLock()
			if(passive_handler.Get("ActiveBuffLock"))
				return 1
			return 0
		HasSpecialBuffLock()
			if(passive_handler.Get("SpecialBuffLock"))
				return 1
			if(src.InfinityModule)
				return 1
			return 0
		HasInjuryImmune()
			if(passive_handler.Get("InjuryImmune"))
				return 1
			return 0
		GetInjuryImmune()
			return passive_handler.Get("InjuryImmune")
		HasFatigueImmune()
			if(passive_handler.Get("FatigueImmune"))
				return 1
			return 0
		GetFatigueImmune()
			return passive_handler.Get("FatigueImmune")
		HasDebuffImmune()
			if(passive_handler.Get("DebuffImmune"))
				return 1
			return 0
		GetDebuffImmune()
			return passive_handler.Get("DebuffImmune")
		HasVenomImmune()
			if(passive_handler.Get("VenomImmune"))
				return 1
			return 0
		HasWalkThroughHell()
			if(passive_handler.Get("WalkThroughHell"))
				return 1
			return 0
		HasWaterWalk()
			if(passive_handler.Get("WaterWalk"))
				return 1
			return 0
		HasSuperDash()
			var/Return=0
			Return=passive_handler.Get("SuperDash")
			if(src.SenseUnlocked>5&&src.SenseUnlocked>src.SenseRobbed)
				Return+=1
			var/ta=src.TransActive()
			var/tm=src.HasTransMimic()
			if(ta || tm)
				if(tm > ta)
					Return+=round(tm/4)
				else
					Return+=round(ta/4)
			Return=round(Return)
			return Return
		GetSuperDash()
			var/Total=0
			Total+=passive_handler.Get("SuperDash")
			if(src.SenseUnlocked>5&&src.SenseUnlocked>src.SenseRobbed)
				Total+=1
				if(src.SenseUnlocked>=7)
					Total+=1
			Total=round(Total)
			return min(Total,2)
		HasDeflection()
			if(passive_handler.Get("Deflection"))
				return 1
			return 0
		GetDeflection()
			return passive_handler.Get("Deflection")
		HasBulletKill()
			if(passive_handler.Get("BulletKill"))
				return 1
			return 0
		HasMovingCharge()
			if(passive_handler.Get("MovingCharge"))
				return 1
			if(src.UBWPath=="Feeble"&&SagaLevel>=4)
				return 1
			return 0
		HasQuickCast()
			if(passive_handler.Get("QuickCast"))
				return 1
			return 0
		GetQuickCast()
			return passive_handler.Get("QuickCast")
		HasDualCast()
			if(passive_handler.Get("DualCast"))
				return 1
			return 0
		HasHealthPU()
			if(passive_handler.Get("HealthPU"))
				return 1
			return 0
		HasShear()
			if(passive_handler.Get("Shearing"))
				return 1
			return 0
		GetShear()
			var/Total=0
			Total+=passive_handler.Get("Shearing")
			return Total
		HasCripple()
			if(passive_handler.Get("Crippling"))
				return 1
			if(src.StyleActive=="Butcher" || src.StyleActive=="Five Rings")
				if(src.AttackQueue||src.AutoHitting)
					return 1
			return 0
		GetCripple()
			var/Total=0
			Total+=passive_handler.Get("Crippling")
			if(src.StyleActive=="Butcher" || src.StyleActive=="Five Rings")
				if(src.AttackQueue||src.AutoHitting)
					Total+=1
			return Total
		HasNoSword()
			if(passive_handler.Get("NoSword"))
				return 1
			return 0
		HasNoStaff()
			if(passive_handler.Get("NoStaff"))
				return 1
			return 0
		HasNeedsStaff()
			if(passive_handler.Get("NeedStaff"))
				return 1
			return 0
		HasNeedsSword()
			if(passive_handler.Get("NeedsSword"))
				return 1
			return 0
		HasRipple()
			if(passive_handler.Get("Ripple"))
				return 1
			if(secretDatum && Secret == "Ripple")
				return 1
			return 0
		GetRipple()
			var/RippleEffectivness=1
			if(src.Slow)
				RippleEffectivness*=0.75
			if(src.Shock)
				RippleEffectivness*=0.75
			if(src.CyberCancel)
				RippleEffectivness*=0.75
			if(src.Swim)
				RippleEffectivness*=1.5
			var/ticks = passive_handler.Get("Ripple")
			if(secretDatum && Secret == "Ripple")
				ticks += secretDatum.secretVariable["Ripple"]
			return (passive_handler.Get("Ripple")*RippleEffectivness)
		HasNoForcedWhiff()
			if(passive_handler.Get("NoForcedWhiff"))
				return 1
			return 0
		HasSpecialStrike()
			if(passive_handler.Get("SpecialStrike"))
				return 1
			return 0
		HasGodKiBuff()
			if(locate(/obj/Skills/Buffs/SlotlessBuffs/God_Ki, src) || CheckSpecial("Sacred Energy") ||CheckSpecial("Final Getsuga Tenshou") || CheckSpecial("Ultra Instinct") || SenseUnlocked >= 7)
				return 1
			return 0
		HasTelepathy()
			if(locate(/obj/Skills/Utility/Telepathy, src))
				return 1
			return 0
		HasFlow()
			if(src.KO)
				return 0
			if(passive_handler.Get("Flow"))
				return 1
			if(src.Secret=="Ripple"&&src.StyleActive)
				return 1
			// if(src.Secret=="Vampire"&&src.StyleActive)
			// 	return 1
			if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Observation"&&src.StyleActive)
				return 1
			if(src.CombatCPU)
				return 1

			if(passive_handler.Get("LikeWater"))
				if(Target.passive_handler.Get("Instinct") >= GetFlow())
					return 1
			return 0
		GetFlow()
			var/Extra=0
			var/Base = passive_handler.Get("Flow")
			if(src.Secret=="Ripple"&&src.StyleActive)
				Extra+=1
			// if(src.Secret=="Vampire"&&src.StyleActive)
			// 	Extra+=1
			if(src.Secret=="Haki")
				Extra++
			if(src.CombatCPU)
				Extra+=1
			if(src.DrunkPower())
				Extra+=2
			if(Target.passive_handler.Get("Instinct") >= Base+Extra)
				Extra += (passive_handler.Get("LikeWater")) / 2
			return (Base+Extra)
		HasInstinct()
			var/Return=BaseOff()/4
			Return+=passive_handler.Get("Instinct")
			if(Target)
				if(isDominating(Target) && HellRisen)
					Return += HellRisen * 2
			var/t=src.HighestTrans()
			if(round(t/4))
				Return+=1
			if(Target.passive_handler.Get("Flow") >= Return)
				Return+=passive_handler.Get("LikeWater") / 2
			return Return
		HasSoulSteal()
			if(passive_handler.Get("SoulSteal"))
				return 1
			return 0
		GetSoulSteal()
			return passive_handler.Get("SoulSteal")
		HasLifeSteal()
			if(passive_handler.Get("LifeSteal"))
				return 1
			if(Race == "Majin" && Class == "Unhinged")
				return 1
			return 0
		GetLifeSteal()
			var/extra = 0
			if(Race == "Majin" && Class == "Unhinged")
				extra += 5 * AscensionsAcquired
			return passive_handler.Get("LifeSteal") + extra
		HasEnergySteal()
			if(passive_handler.Get("EnergySteal"))
				return 1
			return 0
		GetEnergySteal()
			return passive_handler.Get("EnergySteal")

		HasManaSteal()
			if(passive_handler.Get("ManaSteal"))
				return 1
			return 0

		GetManaSteal()
			return passive_handler.Get("ManaSteal")

		HasLifeStealTrue()
			if(passive_handler.Get("LifeStealTrue"))
				return 1
			return 0
		HasLifeGeneration()
			if(passive_handler.Get("LifeGeneration"))
				return 1
			return 0
		GetLifeGeneration()
			return passive_handler.Get("LifeGeneration")
		HasEnergyGeneration()
			if(passive_handler.Get("EnergyGeneration"))
				return 1
			return 0
		GetEnergyGeneration()
			return passive_handler.Get("EnergyGeneration")
		HasManaGeneration()
			if(passive_handler.Get("ManaGeneration"))
				return 1
			return 0
		GetManaGeneration()
			return passive_handler.Get("ManaGeneration")
		HasMystic()
			if(src.Mystic)
				return 1
			return 0
		HasMaki()
			if(passive_handler.Get("Maki"))
				return 1
			return 0
		HasTaxThreshold()
			if(passive_handler.Get("TaxThreshold"))
				return 1
			return 0
		GetTaxThreshold()
			return passive_handler.Get("TaxThreshold")
		DemonicPower() //Fake Demon.
			if(src.Saga=="Ansatsuken"&&src.SagaLevel>=8&&src.AnsatsukenAscension)
				return 1
			if(src.Race=="Demon")
				return 1
			if(src.CheckSlotless("Majin"))
				return 1
			if(src.Race=="Human"&&src.HellPower>=2&&src.AscensionsAcquired>=4)
				return 1
			return 0
		HasSpiritPower()
			var/Extra=0
			if(src.TarotFate=="Judgment")
				Extra=1
			if(passive_handler.Get("SpiritPower"))
				return min(1+Extra, passive_handler.Get("SpiritPower")+Extra)
			if(src.HasMafuba())
				return 1+Extra
			return 0
		HasLegendaryPower()
			var/Extra=0
			if(src.TarotFate=="Judgment")
				Extra=1
			if(passive_handler.Get("LegendaryPower"))
				return min(1+Extra, passive_handler.Get("LegendaryPower")+Extra)
			return 0
		HasHellPower()
			var/Extra=0
			if(src.TarotFate=="Judgment")
				Extra=1
			if(CheckSlotless("Satsui no Hado") && SagaLevel>=8)
				return 1+Extra
			if(passive_handler.Get("HellPower"))
				return min(2+Extra, passive_handler.Get("HellPower")+Extra)
			return 0
		HasPowerReplacement()
			if(src.passive_handler.Get("PowerReplacement"))
				return 1
			return 0
		GetPowerReplacement()
			return src.passive_handler.Get("PowerReplacement")
		HasDesperation()
			if(passive_handler.Get("Desperation"))
				return 1
			if(src.TarotFate=="The Tower")
				return 1
			return 0
		GetDesperation()
			var/Extra=0
			if(src.TarotFate=="The Tower")
				Extra=2
			return (passive_handler.Get("Desperation")+Extra)

		GetIntimidationIgnore(var/mob/m)
			var/Return=0
			if(src.Race in list("Human"))
				Return+=100
			if(src.Race == "Namekian")
				Return+=(10*src.AscensionsAcquired)
			if(src.Race=="Tuffle")
				Return+=(20*(src.Intelligence+src.Imagination))

			if(m)
				if(m.Race in list("Human"))
					Return-=100
				if(m.Race=="Tuffle")
					Return-=(20*(m.Intelligence+m.Imagination))
				if(m.Race=="Makyo")
					Return-=(5*m.AscensionsAcquired)
				if(m.HasGodKi())
					if(src.HasLegendaryPower())
						Return-=(m.GetGodKi())*(100-(src.HasLegendaryPower()*100))
					else
						Return-=m.GetGodKi()*100
			if(src.HasGodKi())
				Return+=src.GetGodKi()*100

			if(src.Saga=="Ansatsuken")
				if(src.AnsatsukenAscension=="Chikara")
					Return+=((src.SagaLevel-4)*25)
			if(m.Saga=="Ansatsuken")
				if(m.AnsatsukenAscension=="Chikara")
					Return-=((m.SagaLevel-4)*25)
			if(src.Race=="Android")
				Return=100

			if(m)
				if(m.CyberCancel)
					Return-=m.CyberCancel*100
				if(m.Mechanized && m.Race!="Tuffle")
					Return-=100
				if(m.Race=="Android")
					Return=0
			if(Return>100)
				Return=100
			if(Return<0)
				Return=0
			Return/=100
			return Return
		HasIntimidation()
			var/Effective=src.Intimidation
			if(src.ShinjinAscension=="Makai")
				Effective+=1
			if(src.Race=="Demon"||src.Race=="Majin")
				Effective+=1
			if(src.Race=="Makyo"&&src.ActiveBuff&&src.AscensionsAcquired&&!src.CyberCancel)
				Effective+=1
			var/stp=src.SaiyanTransPower()
			if(stp)
				Effective+=1
			if(src.CheckActive("Mobile Suit")||src.CheckSlotless("Battosai")||src.CheckSlotless("Susanoo"))
				Effective+=1
			if(src.Health<(1-src.HealthCut)&&src.HealthAnnounce10&&src.Saga=="King of Braves"&&src.SpecialBuff)
				if(src.SpecialBuff.BuffName=="Broken Brave")
					Effective*=3
				else if(src.SpecialBuff.BuffName=="Genesic Brave")
					Effective*=2
			if(src.HasHellPower())
				Effective+=1
			if(src.KaiokenBP>1)
				Effective+=1
			if(Effective>1)
				return 1
			return 0

		GetHellScaling()
			var/Return=1
			var/Mult=src.HasHellPower() / 2
			Mult+=round(src.Potential/100, 0.05)
			Return=1+(0.35 * (abs(src.Health-100)/100) * Mult)
			// if(Return>1+(0.35*Mult))
			// 	Return=1+(0.35*Mult)
			return Return

		HasGodKi()
			if(passive_handler.Get("GodKi"))
				return 1
			if(src.SenseUnlocked>6&&(src.SenseUnlocked>src.SenseRobbed))
				return 1
			if(src.CheckSlotless("Saiyan Soul")&&src.HasGodKiBuff()&&!src.ssj["god"])
				if(!src.Target.CheckSlotless("Saiyan Soul")&&src.Target.HasGodKi())
					return 1
			if(src.HasSpiritPower()>=1 && FightingSeriously(src, 0))
				if(src.Health<=max(15, (30+src.TotalInjury)*src.HasSpiritPower()) || src.InjuryAnnounce)
					return 1
			if(src.KamuiBuffLock)
				return 1
			return 0
		GetGodKi()
			var/Total=passive_handler.Get("GodKi")
			if(src.HasSpiritPower()>=1 && FightingSeriously(src, 0))
				if(src.Health<=(30+src.TotalInjury)*src.HasSpiritPower())
					if(src.SenseUnlocked<7)//saintz
						Total+=0.25*src.HasSpiritPower()
					else
						Total+=(0.25*src.HasSpiritPower()*0.5)//halved rate for god ki saints
			if(src.SenseUnlocked>6&&(src.SenseUnlocked>src.SenseRobbed))
				if(src.SenseUnlocked>=7)
					if(src.SagaLevel<7)
						if(src.Health<=25 || src.InjuryAnnounce)
							Total+=0.25
					else
						Total+=0.25
				if(src.SenseUnlocked>=8)
					Total+=1
			if(src.CheckSlotless("Saiyan Soul")&&src.HasGodKiBuff()&&!src.ssj["god"])
				if(!src.Target.CheckSlotless("Saiyan Soul")&&src.Target.HasGodKi())
					Total+=src.Target.GetGodKi()/2
			if(src.KamuiBuffLock)
				Total+=0.25
			if(src.Race=="Dragon")
				if(src.AscensionsAcquired==6 && Total<0.5)
					Total=0.5//fully ascended dragon
			return Total
		HasFluidForm()
			if(passive_handler.Get("FluidForm"))
				return 1
			if(src.HasLegendaryPower()>=1)
				return 1
			if(src.HasEmptyGrimoire())
				return 1
			return 0
		HasStunningStrike()
			if(passive_handler.Get("StunningStrike"))
				return 1
			if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Armament"&&src.StyleActive)
				return 1
			return 0
		GetStunningStrike()
			var/Extra=0
			if(src.Secret=="Haki"&&src.secretDatum.secretVariable["HakiSpecialization"]=="Armament"&&src.StyleActive)
				Extra+= clamp(secretDatum.currentTier, 1, 5)
			return (passive_handler.Get("StunningStrike")+Extra)
		HasDrainlessMana()
			if(passive_handler.Get("DrainlessMana"))
				return 1
			return 0
		HasLimitlessMagic()
			if(passive_handler.Get("LimitlessMagic"))
				return 1
			if(passive_handler.Get("MartialMagic"))
				return 2
			if(src.Saga=="Unlimited Blade Works")
				return 1
			return 0
		HasManaCapMult()
			if(passive_handler.Get("ManaCapMult"))
				return 1
			return 0
		HasManaLeak()
			if(passive_handler.Get("ManaLeak"))
				return 1
			if(src.Race=="Monster"&&src.Class=="Yokai"&&src.AscensionsAcquired&&src.ActiveBuff&&!src.Mechanized)
				return 1
			return 0
		GetManaLeak()
			var/Return=0
			Return+=passive_handler.Get("ManaLeak")
			if(src.Race=="Monster"&&src.Class=="Yokai"&&src.AscensionsAcquired&&src.ActiveBuff&&!src.Mechanized)
				Return += clamp(4 - (src.AscensionsAcquired), 1,4)
			return Return
		GetManaCapMult()
			return 1 + passive_handler.Get("ManaCapMult")
		HasManaStats()
			if(passive_handler.Get("ManaStats"))
				return 1
			if(src.Race=="Monster"&&src.Class=="Yokai"&&src.AscensionsAcquired&&src.ActiveBuff&&!src.Mechanized)
				return 1
			return 0
		GetManaStats()
			var/Return=0
			Return+=passive_handler.Get("ManaStats")
			if(src.Race=="Monster"&&src.Class=="Yokai"&&src.AscensionsAcquired&&src.ActiveBuff&&!src.Mechanized)
				var/RaceBoon = 1 + (src.AscensionsAcquired*0.25)
				if(RaceBoon > 1)
					RaceBoon = 1
				if(Return <= 0)
					Return = 0.1
				Return+=RaceBoon
			return Return
		HasBurning()
			if(passive_handler.Get("Burning"))
				return 1
			if(src.Attunement=="Fire")
				return 1
			if(src.InfusionElement=="Fire")
				return 1
			return 0
		GetBurning()
			return passive_handler.Get("Burning")
		HasScorching()
			if(passive_handler.Get("Scorching"))
				return 1
			return 0
		GetScorching()
			return passive_handler.Get("Scorching")
		HasChilling()
			if(passive_handler.Get("Chilling"))
				return 1
			if(src.Attunement=="Water")
				return 1
			if(src.InfusionElement=="Water")
				return 1
			return 0
		GetChilling()
			return passive_handler.Get("Chilling")
		HasFreezing()
			if(passive_handler.Get("Freezing"))
				return 1
			return 0
		GetFreezing()
			return passive_handler.Get("Freezing")
		HasHardening()
			if(passive_handler.Get("Hardening"))
				return 1
			return 0
		GetHardening()
			return passive_handler.Get("Hardening")
		HasCrushing()
			if(passive_handler.Get("Crushing"))
				return 1
			if(src.Attunement=="Earth")
				return 1
			if(src.InfusionElement=="Earth")
				return 1
			return 0
		GetCrushing()
			return passive_handler.Get("Crushing")
		HasShattering()
			if(passive_handler.Get("Shattering"))
				return 1
			return 0
		GetShattering()
			return passive_handler.Get("Shattering")
		HasShocking()
			if(passive_handler.Get("Shocking"))
				return 1
			if(src.Attunement=="Wind")
				return 1
			if(src.InfusionElement=="Wind")
				return 1
			return 0
		GetShocking()
			return passive_handler.Get("Shocking")
		HasParalyzing()
			if(passive_handler.Get("Paralyzing"))
				return 1
			return 0
		GetParalyzing()
			return passive_handler.Get("Paralyzing")
		HasPoisoning()
			if(passive_handler.Get("Poisoning"))
				return 1
			return 0
		GetPoisoning()
			return passive_handler.Get("Poisoning")
		HasToxic()
			if(passive_handler.Get("Toxic"))
				return 1
			return 0
		GetToxic()
			return passive_handler.Get("Toxic")
		HasPacifying()
			if(passive_handler.Get("Pacifying"))
				return 1
			return 0
		GetPacifying()
			return passive_handler.Get("Pacifying")
		HasEnraging()
			if(passive_handler.Get("Enraging"))
				return 1
			return 0
		GetEnraging()
			return passive_handler.Get("Enraging")
		HasDoubleStrike()
			if(passive_handler.Get("DoubleStrike"))
				return 1
			if(passive_handler.Get("TripleStrike"))
				return 1
			return 0
		GetDoubleStrike()
			return passive_handler.Get("DoubleStrike")
		HasTripleStrike()
			if(passive_handler.Get("TripleStrike"))
				return 1
			return 0
		GetTripleStrike()
			return passive_handler.Get("TripleStrike")
		HasDebuffReversal()
			if(passive_handler.Get("DebuffReversal"))
				return 1
			return 0
		HasDisorienting()
			if(passive_handler.Get("Disorienting"))
				return 1
			return 0
		GetDisorienting()
			return passive_handler.Get("Disorienting")
		HasConfusing()
			if(passive_handler.Get("Confusing"))
				return 1
			return 0
		GetConfusing()
			return passive_handler.Get("Confusing")
		HasHolyMod()
			if(passive_handler.Get("HolyMod"))
				return 1
			if(src.TarotFate=="The Lovers")
				return 1
			if(src.TarotFate=="The Hierophant")
				return 1
			return 0
		GetHolyMod()
			var/Reduce=0
			var/Extra=0
			if(src.TarotFate=="The Lovers")
				Extra=2.5
			if(src.TarotFate=="The Hierophant")
				Extra=5
			return (passive_handler.Get("HolyMod")+Extra-Reduce)
		HasAbyssMod()
			if(passive_handler.Get("AbyssMod"))
				return 1
			if(src.TarotFate=="The Devil")
				return 1
			if(src.TarotFate=="The Lovers")
				return 1
			return 0
		GetAbyssMod()
			var/Reduce=0
			var/Extra=0
			if(src.TarotFate=="The Devil")
				Extra=5
			if(src.TarotFate=="The Lovers")
				Extra=2.5
			return (passive_handler.Get("AbyssMod")+Extra-Reduce)
		HasSlayerMod()
			if(passive_handler.Get("SlayerMod"))
				return 1
			return 0
		GetSlayerMod()
			var/Reduce=0
			return (passive_handler.Get("SlayerMod")-Reduce)
		HasBeyondPurity()
			if(passive_handler.Get("BeyondPurity"))
				return 1
			if(src.PoseEnhancement&&src.HasRipple())//Ripple Pure shenanigans
				return 1
			return 0
		HasPurity()
			if(passive_handler.Get("Purity"))
				return 1
			if(src.PoseEnhancement&&src.HasRipple())//Ripple Pure shenanigans
				return 1
			return 0
		HasNoAnger()
			if(passive_handler.Get("NoAnger"))
				return 1
			return 0
		HasAngerThreshold()
			if(passive_handler.Get("AngerThreshold"))
				return 1
			return 0
		GetAngerThreshold()
			return passive_handler.Get("AngerThreshold")
		HasWeaponBreaker()
			if(passive_handler.Get("WeaponBreaker"))
				return 1
			if(src.HasAdaptation()&&src.AdaptationTarget&&istype(src.AdaptationTarget, /mob/Players)&&src.AdaptationTarget.HasSword())
				return 1
			return 0
		GetWeaponBreaker()
			var/Extra=0
			if(src.HasAdaptation()&&src.AdaptationTarget&&istype(src.AdaptationTarget, /mob/Players)&&src.AdaptationTarget.HasSword())
				Extra=1*src.AdaptationCounter
			return passive_handler.Get("WeaponBreaker")+Extra
		HasGiantForm()
			if(passive_handler.Get("GiantForm"))
				return 1
			if(src.HasLegendaryPower()>=1)
				return 1
			var/t=src.HighestTrans()
			if(round(t/4))//only do it for ssj4
				return 1
			return 0
		HighestTrans()
			var/tm=src.HasTransMimic()
			var/ta=src.TransActive()
			if(tm || ta)
				if(tm > ta)
					return tm
				else
					return ta
			else
				return 0
		HasSteady()
			if(passive_handler.Get("Steady"))
				return 1
			return 0
		GetSteady()
			var/total = passive_handler.Get("Steady") * (0.1)
			return total
		HasErosion()
			if(passive_handler.Get("Erosion"))
				return 1
			return 0
		GetErosion()
			return passive_handler.Get("Erosion")
		HasMirrorStats()
			if(passive_handler.Get("MirrorStats"))
				return 1
			return 0
		HasManaPU()
			if(passive_handler.Get("ManaPU"))
				return 1
			return 0
		HasCalmAnger()
			if(passive_handler.Get("CalmAnger"))
				return 1
			if(src.Race=="Shinjin" && src.ShinjinAscension=="Makai")
				return 1
			if(src.Race=="Namekian" && src.TransActive())
				return 1
			if(src.TarotFate=="Temperance")
				return 1
			return 0
		HasExtend()
			if(passive_handler.Get("Extend"))
				return 1
			return 0
		GetExtend()
			return passive_handler.Get("Extend")
		HasWarp()
			if(passive_handler.Get("Warp"))
				return 1
			return 0
		HasPridefulRage()
			if(passive_handler.Get("PridefulRage"))
				return 1
			return 0
		HasSpiritHand()//Str*(For**1/2)
			if(passive_handler.Get("SpiritHand"))
				return 1
			if(src.TarotFate=="The Empress")
				return 1
			return 0
		GetSpiritHand()//Str*(For**1/2)
			return passive_handler.Get("SpiritHand")


		HasSpiritFlow()//For*(Str**1/2)
			if(passive_handler.Get("SpiritFlow"))
				return 1
			if(src.TarotFate=="The Emperor")
				return 1
			return 0
		HasSpiritSword()//Str(0.75)+For(0.75)
			if(passive_handler.Get("SpiritSword"))
				return 1
			return 0
		GetSpiritSword()//Str(0.75)+For(0.75)
			return passive_handler.Get("SpiritSword")
		HasHybridStrike()//Str(0.75)+For(0.75)
			if(passive_handler.Get("HybridStrike"))
				return 1
			return 0
		GetHybridStrike()//Str(0.75)+For(0.75)
			return passive_handler.Get("HybridStrike")/2
		HasSpiritStrike()//For v.s. End
			if(passive_handler.Get("SpiritStrike"))
				return 1
			return 0
		CheckActive(var/Name)
			if(src.ActiveBuff&&src.ActiveBuff.BuffName=="[Name]")
				return 1
			return 0
		CheckSpecial(var/Name)
			if(src.SpecialBuff&&src.SpecialBuff.BuffName=="[Name]")
				return 1
			return 0
		CheckSlotless(var/Name)
			if(src.SlotlessBuffs.len!=0)
				return SlotlessBuffs["[Name]"]
				/*for(var/obj/Skills/Buffs/SlotlessBuffs/s in src.SlotlessBuffs)
					if(s.BuffName=="[Name]")
						return s*/
			return 0
		GetSlotless(n)
			if(src.SlotlessBuffs.len!=0)
				if(SlotlessBuffs[n])
					return SlotlessBuffs[n]
		HasMaimMastery()
			var/Return=0
			// if(src.Saga=="Ansatsuken" && src.AnsatsukenAscension=="Chikara")
			// 	Return+=(src.SagaLevel-4)*0.25
			if(passive_handler.Get("MaimMastery"))
				Return+=passive_handler.Get("MaimMastery")
			return Return
		CheckKeybladeStyle(var/Style)
			if(src.StyleActive=="[Style]"&&src.CheckActive("Keyblade"))
				return 1
			return 0
		UsingKeybladeStyle()
			if(src.UsingSpeedRave())
				return 1
			if(src.UsingCriticalImpact() && src.StyleActive!="Momentum Shift")
				return 1
			if(src.UsingSpellWeaver())
				return 1
			if(src.UsingFirestorm())
				return 1
			if(src.UsingDiamondDust())
				return 1
			if(src.UsingThunderbolt())
				return 1
			if(src.UsingWingblade())
				return 1
			if(src.UsingCyclone())
				return 1
			if(src.UsingRockBreaker())
				return 1
			if(src.UsingDarkImpulse())
				return 1
			if(src.UsingGhostDrive())
				return 1
			if(src.UsingBladeCharge())
				return 1
			return 0
		UsingSpeedRave()
			if(src.CheckKeybladeStyle("Speed Rave"))
				return 1
			return 0
		UsingCriticalImpact()
			if(src.CheckKeybladeStyle("Critical Impact"))
				return 1
			if(src.StyleActive=="Momentum Shift")
				return 1
			return 0
		UsingSpellWeaver()
			if(src.CheckKeybladeStyle("Spell Weaver"))
				return 1
			return 0
		UsingFirestorm()
			if(src.CheckKeybladeStyle("Firestorm"))
				return 1
			return 0
		UsingDiamondDust()
			if(src.CheckKeybladeStyle("Diamond Dust"))
				return 1
			return 0
		UsingThunderbolt()
			if(src.CheckKeybladeStyle("Thunderbolt"))
				return 1
			return 0
		UsingWingblade()
			if(src.CheckKeybladeStyle("Wing Blade"))
				return 1
			return 0
		UsingCyclone()
			if(src.CheckKeybladeStyle("Cyclone"))
				return 1
			return 0
		UsingRockBreaker()
			if(src.CheckKeybladeStyle("Rock Breaker"))
				return 1
			return 0
		UsingDarkImpulse()
			if(src.CheckKeybladeStyle("Dark Impulse"))
				return 1
			return 0
		UsingGhostDrive()
			if(src.CheckKeybladeStyle("Ghost Drive"))
				return 1
			return 0
		UsingBladeCharge()
			if(src.CheckKeybladeStyle("Blade Charge"))
				return 1
			return 0
		UsingPridefulRage()
			if(src.HasPridefulRage())
				return 1
			return 0
		UsingSpiritHand()
			if(src.HasSpiritHand())
				return 1
			return 0
/*		UsingHybridStrike()
			if(src.HasSpiritSword())
				return 1
			if(src.HasHybridStrike())
				return 1
			return 0*/
		UsingSpiritStrike()
			if(src.HasSpiritStrike())
				return 1
			return 0
		ElementalAttunement()
			if(src.Attunement)
				return 1
			return 0
		HasMilitaryFrame()
			if(locate(/obj/Skills/Buffs/SpecialBuffs/MilitaryFrames/Ripper_Mode, src.contents))
				return 1
			if(locate(/obj/Skills/Buffs/SpecialBuffs/MilitaryFrames/Armstrong_Augmentation, src.contents))
				return 1
			if(locate(/obj/Skills/Buffs/SpecialBuffs/MilitaryFrames/Ray_Gear, src.contents))
				return 1
			if(locate(/obj/Skills/Buffs/SpecialBuffs/MilitaryFrames/Overdrive,src.contents))
				return 1
			if(src.InfinityModule)
				return 1
			return 0
		HasConversionModules()
			var/Total=0
			if(src.FusionPowered)
				Total+=2
			if(src.NanoBoost)
				Total+=2
			if(src.CombatCPU)
				Total+=2
			if(src.BladeMode)
				Total+=2
			if(locate(/obj/Skills/Queue/Cyberize/Taser_Strike, src))
				Total+=1
			if(locate(/obj/Skills/AutoHit/Cyberize/Machine_Gun_Flurry, src))
				Total+=1
			if(locate(/obj/Skills/Projectile/Cyberize/Rocket_Punch, src))
				Total+=1
			if(locate(/obj/Skills/Utility/Internal_Communicator, src))
				Total+=1
			if(src.StabilizeModule)
				Total+=1
			if(src.MeditateModule)
				Total+=1
			return Total
		HasEnhancementChips()
			var/Total=0
			if(src.EnhancedStrength)
				Total+=src.EnhancedStrength
			if(src.EnhancedForce)
				Total+=src.EnhancedForce
			if(src.EnhancedEndurance)
				Total+=src.EnhancedEndurance
			if(src.EnhancedAggression)
				Total+=src.EnhancedAggression
			if(src.EnhancedReflexes)
				Total+=src.EnhancedReflexes
			if(src.EnhancedSpeed)
				Total+=src.EnhancedSpeed
			return Total


		CursedWounds()
			if(passive_handler.Get("FakePeace"))
				return 0
			if(passive_handler.Get("CursedWounds"))
				return 1
			if(passive_handler.Get("Curse"))
				return 1
			return 0
		SwordWounds()
			for(var/obj/Items/Sword/s in src)
				if(findtext(s.suffix, "Equipped"))
					if((s.Class != "Wooden") && GetSwordDamage(s)>1)
						return 1
			return 0
			/*if(src.HasSword())
				var/obj/Items/Sword/S=src.EquippedSword()
				if(S.Class=="Wooden")
					return 0
				if(GetSwordDamage(S)>1)
					return 1
			return 0*/

		NeedsSecondSword()
			if(src.HasPassive("NeedsSecondSword", BuffsOnly=1, NoMobVar=1))
				return 1
			if(src.HasPassive("MakesSecondSword", BuffsOnly=1, NoMobVar=1))
				return 1
			else return NeedsThirdSword()
		NeedsThirdSword()
			if(src.HasPassive("NeedsThirdSword", BuffsOnly=1, NoMobVar=1))
				return 1
			if(src.HasPassive("MakesThirdSword", BuffsOnly=1, NoMobVar=1))
				return 1
			return 0
		HasArmor()
			var/obj/Items/Armor/ar=src.EquippedArmor()
			if(ar)
				return 1
			return 0
		HasSword()
			var/s=src.EquippedSword()
			if(s)
				return 1
			return 0
		HasStaff()
			var/s=src.EquippedStaff()
			if(s)
				return 1
			else
				var/obj/Items/Sword/s2=src.EquippedSword()
				if(s2)
					if(s2.MagicSword)
						return 1
			return 0
		NotUsingMagicSword()
			if(src.HasSword())
				var/obj/Items/Sword/s=src.EquippedSword()
				if(s.MagicSword)
					return 0
			return 1
		HasLightSword()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(s)
				if(s.Class=="Light")
					return 1
			return 0

		HasMediumSword()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(s)
				if(s.Class=="Medium")
					return 1
			return 0
		NoMediumSword()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(s)
				if(s.Class=="Medium")
					return 0
			return 1
		HasHeavySword()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(s)
				if(s.Class=="Heavy")
					return 1
			return 0
		HasWeights()
			if(src.EquippedWeights())
				return 1
			return 0
		EquippedWeights()
			if(equippedWeights)
				return equippedWeights
			return 0

		EquippedArmor()
			if(equippedArmor)
				return equippedArmor
			return 0

		EquippedSword()
			if(equippedSword)
				return equippedSword
			return 0

		EquippedSecondSword()
			var/obj/Items/Sword/sord
			for(var/obj/Items/Sword/s in src)
				if(s.suffix=="*Equipped (Second)*")
					sord=s
					break
			if(sord)
				return sord
			return 0
		EquippedThirdSword()
			var/obj/Items/Sword/sord
			for(var/obj/Items/Sword/s in src)
				if(s.suffix=="*Equipped (Third)*")
					sord=s
					break
			if(sord)
				return sord
			return 0
		UsingDarkElementSword()
			var/obj/Items/Sword/s=src.EquippedSword()
			var/obj/Items/Sword/s2=src.EquippedSecondSword()
			var/obj/Items/Sword/s3=src.EquippedThirdSword()
			if(s)
				if(s.Element=="Dark")
					return 1
			if(s2)
				if(s2.Element=="Dark")
					return 1
			if(s3)
				if(s3.Element=="Dark")
					return 1
			return 0
		UsingLightElementSword()
			var/obj/Items/Sword/s=src.EquippedSword()
			var/obj/Items/Sword/s2=src.EquippedSecondSword()
			var/obj/Items/Sword/s3=src.EquippedThirdSword()
			if(s)
				if(s.Element=="Light")
					return 1
			if(s2)
				if(s2.Element=="Light")
					return 1
			if(s3)
				if(s3.Element=="Light")
					return 1
			return 0
		EquippedStaff()
			var/obj/Items/Enchantment/Staff/staf
			for(var/obj/Items/Enchantment/Staff/s in src)
				if(s.suffix=="*Equipped*")
					staf=s
					break
			if(src.Race=="Android"||src.HasMechanized())
				return 0
			else if(staf)
				return staf
			else
				return 0
		CanLoseVitalBP()
			if(src.Race=="Android")
				return 0
			if(src.HasMechanized())
				return 0
			if(src.Anger)
				return 0
			if(src.StableBP>=1)
				return 0
			if(src.Kaioken)
				return 0
			if(src.HasCalmAnger())
				return 0
			if(src.AngerMax==1)
				if(src.Race!="Changeling")
					return 0
			if(src.SenseUnlocked>5&&src.SenseUnlocked>src.SenseRobbed)
				return 0
			return 1
		CanBeSlowed()
			if(src.HasLegendaryPower() > 0.75)
				return 0
			if(src.HasGodspeed()>=4)
				return 0
			if(src.Race=="Android"/* || Race=="Majin"  */)
				return 0
			if(src.LastBreath)
				return 0
			if(src.CheckSlotless("Berserk"))
				return 0
			if(src.SenseUnlocked>5&&src.SenseUnlocked>src.SenseRobbed)
				return 0
			return 1
		SteadyRace()
			if(src.Race in list("Human", "Half Saiyan", "Majin", "Makyo", "Namekian", "Tuffle", "Monster",  "Demon", "Alien", "Android", "Dragon"))
				return 1
			return 0
		TransRace()
			if(src.Race in list("Saiyan", "Half Saiyan", "Changeling", "Alien"))
				return 1
			return 0
		OtherRace()
			if(src.Race in list("Shinjin"))
				return 1
			return 0
		SureHit()
			if(src.SureHit)
				return 1
			return 0
		NoWhiff()
			if(src.NoWhiff)
				return 1
			if(src.passive_handler.Get("NoWhiff"))
				return 1
			return 0
		Afterimages()
			if(src.Afterimages)
				return 1
			return 0

		KBFreeze()
			if(src.EdgeOfMap())
				return 1
			if(src.AerialRecovery==1)
				src.AerialRecovery=0
				return 1
			if(src.AerialRecovery==2)
				src.AerialRecovery=1
				return 1
			return 0
		EdgeOfMap()
			var/turf/t=get_step(src, src.Knockbacked)
			if(!t)
				return 1
			if(t.density>=1)
				return 1
			return 0
		HasSpellFocus(var/obj/Skills/Z)
			var/obj/Items/Enchantment/Staff/st=src.EquippedStaff()
			var/obj/Items/Sword/sord=src.EquippedSword()
			var/Pass=0
			if(src.Saga=="Persona"||src.Saga=="Magic Knight")
				Pass=1
			if(src.is_arcane_beast)
				Pass=1
			if(istype(Z, /obj/Skills/Buffs))
				if(Z:MagicFocus)
					Pass=1
			if(Z.ElementalClass)
				if(src.StyleBuff)
					if(src.StyleBuff.ElementalClass==Z.ElementalClass)
						Pass=1
					else if(istype(src.StyleBuff.ElementalClass, /list))
						if(Z.ElementalClass in src.StyleBuff.ElementalClass)
							Pass=1
			if(src.UsingMasteredMagicStyle())
				Pass=1
			if(src.CrestSpell(Z))
				Pass=1
			if(sord)
				if(sord.MagicSword)
					Pass=1
			if(st)
				Pass=1
			if(src.HasLimitlessMagic())
				Pass=1
			if(src.HasMagicFocus())
				Pass=1
			return Pass

		HasMagicFocus()
			if(passive_handler.Get("MagicFocus"))
				return 1
			return 0
		UsingYinYang()
			if(src.StyleActive=="Balance")
				return 1
			if(src.CheckSpecial("Libra Cloth"))
				return 1
			if(src.CheckSpecial("Ultra Instinct"))
				return 1
			if(src.Race=="Dragon"&&src.AscensionsAcquired>=2)
				return 1
			return 0
		UsingSpiritStyle()
			var/Return=0
			if(src.UsingMartialStyle())
				Return++
			if(src.UsingMasteredMartialStyle())
				Return++
			if(src.Race=="Dragon")
				Return++
			return Return
		HasAdaptation()
			if(src.Adaptation)
				return 1
			if(src.StyleActive in list("Balance", "Metta Sutra", "West Star", "Shaolin"))
				return 1
			if(src.Race=="Dragon"&&src.AscensionsAcquired>=1)
				return 1
			return 0
		UsingMartialStyle()
			if(src.UsingMasteredMartialStyle())
				return 1
			if(src.StyleActive in list("Turtle", "Crane", "Snake", "Cat","Black Leg", "Strong Fist", "Gentle Fist", "Lightning Kickboxing", "Kendo", "Battle Mage"))
				return 1
			if(src.StyleActive in list("Ansatsuken", "Hiten Mitsurugi"))
				return 1
			if(src.Saga=="Weapon Soul" && src.SagaLevel>=2 && src.StyleActive in list("Iaido", "Zornhau", "Fencing"))
				return 1
			return 0
		UsingMasteredMartialStyle()
			if(src.Saga=="Eight Gates")
				if(src.StyleActive in list("Strong Fist", "Black Leg", "Lightning Kickboxing"))
					return 1
			if(src.Saga=="Ansatsuken" || src.Saga=="Hiten Mitsurugi")
				if(src.SagaLevel>=6)
					return 1
			if(src.Saga=="Weapon Soul" && src.SagaLevel>=6 && src.StyleActive in list("Iaido", "Zornhau", "Fencing"))
				return 1
			if(src.StyleActive in list("Drunken Fist", "Golden Kirin", "Drunken Fist", "Dire Wolf", "Devil Leg", "Flow Reversal", "Phage", "North Star", "Imperial Devil", "South Star"))
				return 1
			return 0
		UsingMasteredMagicStyle()
			if(src.Saga=="Keyblade")
				if(src.SagaLevel>=6)
					return 1
			if(src.StyleActive in list("Moonlight", "Entropy", "Imperial Devil", "Atomic Karate", "East Star"))
				return 1
			if(src.Race=="Dragon"&&src.AscensionsAcquired>=3)
				return 1
			if(src.Race=="Majin")
				return 1
			return 0
		UsingZornhau()
			var/Found=0
			var/obj/Items/Sword/S=src.EquippedSword()
			if(src.StyleActive=="Sword Savant")
				Found+=0.5
			if(src.StyleActive=="Zornhau")
				Found=1
			if(src.StyleActive=="Kendo")
				Found=1
			if(src.StyleActive=="Champloo")
				Found=1
			if(src.StyleActive=="Butcher")
				Found=1
			if(src.StyleActive=="Five Rings")
				Found=1
			if(S)
				if(S.ExtraClass&&S.Class=="Heavy")
					Found+=1
			return Found
		UsingFencing()
			var/Found=0
			var/obj/Items/Sword/S=src.EquippedSword()
			if(src.StyleActive=="Hiten Mitsurugi")
				Found+=1
			if(src.StyleActive=="Sword Savant")
				Found+=0.5
			if(src.StyleActive=="Fencing")
				Found+=1
			if(src.StyleActive=="Dual Wield")
				Found=1
			if(src.StyleActive=="Kendo")
				Found+=1
			if(src.StyleActive=="Arcane Bladework")
				Found+=1
			if(src.StyleActive=="Battle Mage")
				Found += 1
			if(src.StyleActive=="Trinity")
				Found=1
			if(src.StyleActive=="Five Rings")
				Found=1
			if(S)
				if(S.ExtraClass&&S.Class=="Medium")
					Found+=1
			if(Found>0&&Saga == "Weapon Soul"&&SagaLevel>=2)
				Found+=1
			return Found
		UsingIaido()
			var/Found=0
			var/obj/Items/Sword/S=src.EquippedSword()
			if(src.StyleActive=="Sword Savant")
				Found+=0.5
			if(src.StyleActive=="Iaido")
				Found=1
			if(src.StyleActive=="Dual Wield")
				Found=1
			if(src.StyleActive=="Secret Knife")
				Found=1
			if(src.StyleActive=="Arcane Bladework")
				Found=1
			if(src.StyleActive=="Trinity")
				Found=1
			if(src.StyleActive=="Blade Singing")
				Found=1
			if(src.StyleActive=="Rhythm of War")
				Found=1
			if(src.StyleActive=="Five Rings")
				Found=1
			if(S)
				if(S.ExtraClass&&S.Class=="Light")
					Found+=1
			return Found


		InDevaPath()
			// i hate this
			if(CheckSlotless("Rinnegan"))
				if(findRinne().activePath == "Deva")
					return 1
			return 0


		isHalfDemon()
			//TODO come back to this later
			if(Race == "Human" && HellPower >= 2)
				return 1


		HasSwordPunching()
			if(passive_handler.Get("SwordPunching"))
				return 1
			if(Saga == "Kamui")
				return 1
			if(Race == "Demon" || (CheckSlotless("Satsui no Hado") && SagaLevel>=8))
				return 1
			if(Race == "Human" && isHalfDemon())
				return 1
			if(ClothBronze == "Andromeda" && Saga == "Cosmo")
				return 1
			if(src.CheckSpecial("Libra Cloth"))
				return 0
			if(src.CheckSlotless("Libra Armory"))
				return 0
			return 0




		NotUsingLiving()
			if(src.StyleActive=="Living Weapon")
				return 0
			if(src.StyleActive=="Champloo")
				return 0
			if(src.StyleActive=="Secret Knife")
				return 0
			if(src.StyleActive=="Blade Singing")
				return 0
			if(src.StyleActive=="Shaolin")
				return 0
			if(src.StyleActive=="Rhythm of War")
				return 0
			if(src.StyleActive=="West Star")
				return 0
			if(src.KiBlade)
				return 0
			if(src.Saga == "Kamui")
				return 0
			if(src.Race=="Demon" || (CheckSlotless("Satsui no Hado") && SagaLevel>=8))
				return 0
			if(src.Saga == "Cosmo" && src.ClothBronze=="Andromeda")
				return 0
			return 1
		UsingDualWield()
			if(src.StyleActive=="Dual Wield")
				return 1
			if(src.StyleActive=="Trinity Style")
				return 1
			if(src.StyleActive=="Five Rings")
				return 1
			return 0
		UsingTrinityStyle()
			if(src.StyleActive=="Trinity Style")
				return 1
			if(src.StyleActive=="Five Rings")
				return 1
			return 0
		UsingKendo()
			if(src.StyleActive=="Kendo")
				return 1
			return 0
		NotUsingChamploo()
			if(src.StyleActive=="Secret Knife")
				return 0
			if(src.StyleActive=="Champloo")
				return 0
			if(src.StyleActive=="Blade Singing")
				return 0
			if(src.StyleActive=="Butcher")
				return 0
			if(src.StyleActive=="Shaolin")
				return 0
			if(src.StyleActive=="Rhythm of War")
				return 0
			if(src.StyleActive=="Five Rings")
				return 0
			if(src.StyleActive=="West Star")
				return 0
			if(src.CheckSpecial("Libra Cloth"))
				return 0
			if(src.CheckSlotless("Libra Armory"))
				return 0
			if(src.Saga == "Cosmo" && src.ClothBronze=="Andromeda")
				return 0
			if(src.Saga == "Kamui")
				return 0
			if(src.Race=="Demon" || (CheckSlotless("Satsui no Hado") && SagaLevel>=8))
				return 0
			return 1
		NotUsingBattleMage()
			if(src.StyleActive=="Battle Mage")
				return 0
			return 1
		UsingAnsatsuken()
			if(src.StyleActive=="Ansatsuken")
				return 1
			return 0
		UsingIronFist()
			if(src.StyleActive=="Iron Skin")
				return 1
			return 0
		UsingThunderFist()
			if(src.StyleActive=="Spark Impulse")
				return 1
			return 0
		UsingSunlight()
			if(src.StyleActive=="Sunlight")
				return 1
			if(src.StyleActive=="Moonlight")
				return 1
			if(src.StyleActive=="Atomic Karate")
				return 1
			if(src.StyleActive=="Imperial Devil")
				return 1
			if(src.StyleActive=="Devil Leg")
				return 1
			return 0
		UsingMoonlight()
			if(src.StyleActive=="Moonlight")
				return 1
			if(src.StyleActive=="Atomic Karate")
				return 1
			if(src.StyleActive&&src.Secret=="Werewolf"&&(!src.CheckSlotless("Half Moon Form")))
				return 1
			return 0
		UsingVoidDefense()
			if(src.ElementalDefense=="Void")
				return 1
			return 0
		HasDarknessFlame()
			if(passive_handler.Get("DarknessFlame"))
				return 1
			return 0
		HasAbsoluteZero()
			if(passive_handler.Get("AbsoluteZero"))
				return 1
			return 0
		UsingVortex()
			if(src.StyleActive=="Tide Trap")
				return 1
			return 0
		UsingUltima()
			if(src.StyleActive=="Atomic Karate")
				return 1
			if(src.ElementalDefense=="Ultima")
				return 1
			return 0
		UsingDireFist()
			if(src.StyleActive=="Dire Wolf")
				return 1
			if(src.StyleActive=="Imperial Devil")
				return 1
			return 0
		UsingTranquilFist()
			if(src.StyleActive=="Tranquil Dove")
				return 1
			if(src.StyleActive=="Dire Wolf")
				return 1
			if(src.StyleActive=="Imperial Devil")
				return 1
			if(src.StyleActive=="Moonlight")
				return 1
			return 0
		UsingAtomicFist()
			if(src.StyleActive=="Atomic Karate")
				return 1
			return 0
		UsingBattleMage()
			if(src.StyleActive=="Battle Mage")
				return 1
			return 0
		UsingMuken()
			if(src.StyleActive=="Ansatsuken"&&src.AnsatsukenAscension=="Chikara"&&src.SagaLevel==8)
				return 1
			return 0
		HasLowWeaponSoul()
			if(src.WeaponSoulType=="Holy Blade"||src.WeaponSoulType=="Corrupt Edge"||src.WeaponSoulType=="Weapon Soul")
				return 1
			return 0
		HasUnmasteredWeaponSoul()
			if(src.HasLowWeaponSoul())
				return 1
			return 0
		WSCaledfwlch()
			if(src.WeaponSoulType=="Caledfwlch")
				return 1
			return 0
		WSKusanagi()
			if(src.WeaponSoulType=="Kusanagi")
				return 1
			return 0
		WSDurendal()
			if(src.WeaponSoulType=="Durendal")
				return 1
			return 0
		WSMasamune()
			if(src.WeaponSoulType=="Masamune")
				return 1
			return 0
		WSSoulCalibur()
			if(src.WeaponSoulType=="Soul Calibur")
				return 1
			return 0
		WSSoulEdge()
			if(src.WeaponSoulType=="Soul Edge")
				return 1
			return 0
		WSMuramasa()
			if(src.WeaponSoulType=="Muramasa")
				return 1
			return 0
		WSDainsleif()
			if(src.WeaponSoulType=="Dainsleif")
				return 1
			return 0
		WSGuanYu()
			if(src.WeaponSoulType=="Green Dragon Crescent Blade")
				return 1
			return 0
		GetWeaponSoulType()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(!s) return 0
			if(s.type==/obj/Items/Sword/Light/Legendary/WeaponSoul/Bane_of_Blades)
				return "Muramasa"
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Ruin)
				return "Dainsleif"
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Order)
				return "Soul Calibur"
			if(s.type==/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Blade_of_Chaos)
				return "Soul Edge"
			if(s.type==/obj/Items/Sword/Light/Legendary/WeaponSoul/Sword_of_Purity)
				return "Masamune"
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Glory)
				return "Caledfwlch"
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Faith)
				return "Kusanagi"
			if(s.type==/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Sword_of_Hope)
				return "Durendal"
			if(s.type == /obj/Items/Sword/Wooden/Legendary/WeaponSoul/RyuiJinguBang)
				return "Ruyi Jingu Bang"
			if(s.type == /obj/Items/Sword/Heavy/Legendary/WeaponSoul/Spear_of_War)
				return "Green Dragon Crescent Blade"
			return 0
		WSCorrupt()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(s.type==/obj/Items/Sword/Light/Legendary/WeaponSoul/Bane_of_Blades)
				return 1
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Ruin)
				return 1
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Order)
				return 1
			if(s.type==/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Blade_of_Chaos)
				return 1
			return 0
		WSHoly()
			var/obj/Items/Sword/s=src.EquippedSword()
			if(s.type==/obj/Items/Sword/Light/Legendary/WeaponSoul/Sword_of_Purity)
				return 1
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Glory)
				return 1
			if(s.type==/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Faith)
				return 1
			if(s.type==/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Sword_of_Hope)
				return 1
			return 0
		HasSSjVars()
			if(src.Race in list("Saiyan", "Half Saiyan"))
				return 1
			return 0

		CanAttack(ModifyAttack=0)
			if(ModifyAttack >= 0 && (NextAttack-ModifyAttack > world.time))
				return 0
			if(src.BusterCharging)
				return 0
			if(src.Beaming)
				return 0
			if(src.icon_state=="Meditate")
				return 0
			if(src.icon_state=="Train")
				return 0
			if(src.KO)
				return 0
			if(src.Frozen)
				return 0
			if(src.Stunned)
				return 0
			if(src.Stasis)
				return 0
			if(src.WindingUp)
				return 0
			if(src.AutoHitting)
				return 0
			if(src.TimeFrozen)
				return 0
			if(src.PoweringUp)
				return 0
			if(src.EquippedFlyingDevice())
				return 0
			if(istype(src.loc,/mob))
				return 0
			return 1
		HasMana(var/Value)
			if(src.ManaAmount>=Value)
				return 1
			if(src.HasDrainlessMana())
				return 1
			return 0
		GetMoney()
			for(var/obj/Money/m in src)
				return m.Level
		HasMoney(var/Value=null)
			var/Money=src.GetMoney()
			if(Money>=Value)
				return 1
			return 0
		HasRadar()
			for(var/obj/Items/Tech/Radar/r in src)
				return 1
			return 0
		HasManaCapacity(var/Value)
			var/Total=0
			if(usr.Race!="Android"&&!usr.HasMechanized())
				Total+=(100-src.TotalCapacity)*src.GetManaCapMult()//Personal reserves
			for(var/obj/Items/Enchantment/PhilosopherStone/PS in src)
				if(!PS.ToggleUse) continue
				Total+=PS.CurrentCapacity
			for(var/obj/Magic_Circle/MC in range(3, src))
				if(!MC.Locked)
					Total/=0.9
				else
					if(MC.Creator==src.ckey)
						Total/=0.75
				break
			if(Total>=Value)
				return 1
			return 0

		NeedSpellFocii(var/obj/Skills/b)
			if(!b) return
			if(StyleActive=="Ansatsuken")	return
			if(b.ManaCost)
				if(b.Copyable>0 && b.Copyable < 3) return 0
				else if(HasLimitlessMagic()) return 0
				else if(CrestSpell(b)) return 0
				else return 1
			return 0

		InMagitekRestrictedRegion()
			if(usr.z in ArcaneRealmZ) return 3 //Will eventually use a list to make specific restrictions.
			return 0
atom
	proc
		NoTPZone(var/dead_use=0, var/arc_use=0)
			var/SP=0
			if(istype(src, /mob/Players))
				if(src:HasSpiritPower())
					SP=1
			if(src.z == global.MajinZoneZ)
				return 1
			if(src.z == glob.DEATH_LOCATION[3] && !dead_use && !SP)
				return 1
			else if(src.z == global.PhilosopherZ)
				return 1
			else if(src.z == global.NearDeadZ && !dead_use && !SP)
				return 1
			else if(src.z == global.ArcaneRealmZ && !arc_use)
				return 1
			return 0

proc
	FightingSeriously(var/mob/Offender=0, var/mob/Defender=0)
		if(Offender)
			if(Offender.Lethal)
				return 1
			if(Offender.WoundIntent)
				return 1
			if(Offender.CursedWounds())
				return 1
			if(Offender.SwordWounds())
				return 1
			if(Offender.HasPurity())
				if(Defender&&Defender.IsEvil())
					return 1
		if(Defender)
			if(Defender.Lethal)
				return 1
			if(Defender.WoundIntent)
				return 1
			if(Defender.CursedWounds())
				return 1
			if(Defender.SwordWounds())
				return 1
			if(Defender.HasPurity())
				if(Offender&&Offender.IsEvil())
					return 1
		return 0

obj
	Skills
		var/Copied = FALSE
		var/Sealed = FALSE
		var/Temporary = FALSE
		Projectile
			proc
				EdgeOfMapProjectile()
					var/turf/t=get_step(src, src.dir)
					if(!t)
						return 1
					if(t.x==0||t.y==0||t.z==0)
						return 1
					if(t)
						if(istype(t, /turf/Special/Blank))
							return 1
					return 0
