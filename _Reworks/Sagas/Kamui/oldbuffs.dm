/obj/Skills/Buffs/ActiveBuffs
	Kamui
		KiControl=1
		HealthPU=1
		passives = list ("KiControl" = 1, "HealthPU" = 1, "BleedHit" = 0.5)
		StripEquip=1
		FlashChange=1
		HairLock=1
		IconLayer=3
		KenWave=1
		KenWaveIcon='SparkleRed.dmi'
		KenWaveSize=5
		KenWaveTime=30
		KenWaveX=105
		KenWaveY=105
		KamuiSenketsu
			HealthThreshold=25
			PowerMult=1
			StrMult=1.25
			EndMult=1.25
			SpdMult=1.5
			Cooldown=60
			// IconLock='senketsu_activated.dmi'
			// TopOverlayLock='senketsu_activated_headpiece.dmi'
			TopOverlayX=0
			TopOverlayY=0
			ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
			OffMessage="runs out of blood to feed their Kamui, releasing the transformed state..."
			BuffName="Life Fiber Synchronize"
			proc/adjust(mob/p)
				if(altered) return
				var/level = p.SagaLevel
				PowerMult = 1
				SpdMult = 1.2
				StrMult = 1.2
				EndMult = 1.2
				HealthCost = clamp(15 - (5 * level), 0, 15)
				WoundCost = clamp(15 - (5 * level), 0, 15)
				VaizardHealth = clamp(1.5 - (0.5 * level), 0, 1.5)
				HealthThreshold = clamp(25 - (5 * level), 5, 25)



			verb/Life_Fiber_Synchronize()
				set category="Skills"
				if(!usr.BuffOn(src))
					adjust(usr)
					if(usr.SagaLevel<1||usr.Saga!="Kamui")
						src.PowerMult=1.15
						src.StrMult=1.25
						src.EndMult=1.25
						src.SpdMult=0.1
						src.RegenMult=0.1
						src.ActiveMessage="attempts to wear a Kamui which they have no connection to!"
						src.OffMessage="has their strepower stolen from them..."
					if(usr.Saga=="Kamui")
						src.ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
						src.OffMessage="runs out of blood to feed their Kamui, releasing the transformed state..."
						if(usr.KamuiType=="Impulse")
							switch(usr.SagaLevel)
								if(2)
									src.VaizardHealth=1
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
									src.OffMessage="runs out of blood to feed their Kamui, releasing the transformed state..."
								if(3)
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
									src.OffMessage="runs out of blood to feed their Kamui, releasing the transformed state..."
								if(4)
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
									src.ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
									src.OffMessage="runs out of blood to feed their Kamui, releasing the transformed state..."
								if(5)
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="feeds blood into their Kamui, drawing on its full power.  Life Fiber Synchronize!"
									src.OffMessage="runs out of blood to feed their Kamui, releasing the transformed state..."
								if(6)
									src.HealthThreshold=0
									passives = list ("HealthPU" = 1, "BleedHit" = 1, "FatigueLeak" = 1, "TechniqueMastery" = 5)
									src.TechniqueMastery=5
									src.EnergyMult=1.5 //Counteract PowerMult drains. Perfect Syncronization!!!1111
									src.WoundCost=0
									src.HealthCost=0
									src.VaizardHealth=0
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="synchronizes perfectly with their Kamui!"
									src.ActiveMessage="synchronizes perfectly with their Kamui!"
									src.OffMessage="separates from their Kamui..."
								if(7)
									src.HealthThreshold=0
									passives = list ("HealthPU" = 1, "BleedHit" = 1, "FatigueLeak" = 1, "TechniqueMastery" = 5)
									src.TechniqueMastery=5
									src.EnergyMult=1.5
									src.WoundCost=0
									src.HealthCost=0
									src.VaizardHealth=0
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="synchronizes perfectly with their Kamui!"
									src.ActiveMessage="synchronizes perfectly with their Kamui!"
									src.OffMessage="separates from their Kamui..."
								if(8)
									src.HealthThreshold=0
									passives = list ("HealthPU" = 1, "BleedHit" = 1, "FatigueLeak" = 1, "TechniqueMastery" = 5)
									src.TechniqueMastery=5
									src.EnergyMult=1.5
									src.WoundCost=0
									src.HealthCost=0
									src.VaizardHealth=0
									// src.IconLock='senketsu_v2.dmi'
									// src.TopOverlayLock='senketsu_v2_headpiece.dmi'
									src.TopOverlayX=0
									src.TopOverlayY=0
									src.ActiveMessage="synchronizes perfectly with their Kamui!"
									src.ActiveMessage="synchronizes perfectly with their Kamui!"
									src.OffMessage="separates from their Kamui..."
				src.Trigger(usr)
		KamuiJunketsu
			OverClock=0.25
			PowerMult = 1
			StrMult=1.15
			EndMult=1.15
			SpdMult=1.25
			RegenMult=0.5
			Cooldown=5
			// IconLock='junketsu_activated.dmi'
			// TopOverlayLock='junketsu_activated_headpiece.dmi'
			TopOverlayX=0
			TopOverlayY=0
			BuffName="Life Fiber Override"
			ActiveMessage="forces their blood into their Kamui, making use of its full power.  Life Fiber Override!"
			OffMessage="relaxes their bloodflow, allowing the Kamui they wear to revert..."
			verb/Life_Fiber_Override()
				set category="Skills"
				if(!usr.BuffOn(src))
					if(usr.SagaLevel<1||usr.Saga!="Kamui")
						src.PowerMult=2
						src.OverClock=1
						src.StrMult=1.25
						src.EndMult=1.25
						src.SpdMult=0.1
						src.RegenMult=0.1
						src.ActiveMessage="is having the life sucked out of them by a Kamui!"
						src.OffMessage="manages to take the Kamui off..."
					else if(usr.Saga=="Kamui")
						switch(usr.SagaLevel)
							if(3)
								src.OverClock=0.15
								src.StrMult=1.15
								src.EndMult=1.15
								src.SpdMult=1.15
								src.RegenMult=0.5
							if(4)
								src.OverClock=0.15
								src.StrMult=1.25
								src.EndMult=1.25
								src.SpdMult=1.25
								src.RegenMult=0.5
							if(5)
								src.OverClock=0.05
								src.StrMult=1.25
								src.EndMult=1.25
								src.SpdMult=1.25
								src.RegenMult=0.5
							if(6)
								src.OverClock=0.05
								src.StrMult=1.5
								src.EndMult=1.5
								src.SpdMult=1.5
								src.RegenMult=0.5
							if(7)
								src.OverClock=0.05
								src.StrMult=1.5
								src.EndMult=1.5
								src.SpdMult=1.5
								src.RegenMult=0.5
							if(8)
								src.OverClock=0.05
								src.StrMult=1.5
								src.EndMult=1.5
								src.SpdMult=1.5
								src.RegenMult=0.5
					if(usr.KamuiType=="Impulse")
						src.IconLock='JunKamui_Stage_2_RyuVer.dmi'
						src.TopOverlayLock='JunKamui_Stage_2_RyuVer_Pauldrons-Headpiece.dmi'
						src.TopOverlayX=0
						src.TopOverlayY=0
				src.Trigger(usr)




// Special Buffs

/obj/Skills/Buffs/SpecialBuffs
	SpecialSlot=1
	KamuiSenjin
		FlashChange=1
		KenWave=1
		KenWaveIcon='SparkleRed.dmi'
		KenWaveSize=2
		KenWaveTime=5
		KenWaveX=105
		KenWaveY=105
		ABuffNeeded=list("Life Fiber Synchronize")
		ActiveMessage="augments their Kamui with powerful blades!"
		OffMessage="shrinks the blades back into their uniform..."
		StrMult=1.25
		OffMult=1.25
		passives = list("PureDamage" = 1, "DeathField" = 1, "HardStyle" = 1 )
		// IconLock='senketsu_senjin.dmi'
		// TopOverlayLock='senketsu_senjin_headpiece.dmi'
		TopOverlayX=0
		TopOverlayY=0
		verb/Kamui_Senjin()
			set category="Skills"
			passives = list("PureDamage" = clamp(usr.SagaLevel/5,0.01, 1), "DeathField" = 1, "HardStyle" = 1 )
			if(usr.SagaLevel >= 4)
				passives = list("DeathField" = 1, "PureDamage" = clamp(usr.SagaLevel/5,0.01, 1), "HardStyle" = 1.5, "Instinct" = 1)
			src.Trigger(usr)
	KamuiShippu
		FlashChange=1
		KenWave=1
		KenWaveIcon='SparkleRed.dmi'
		KenWaveSize=2
		KenWaveTime=5
		KenWaveX=105
		KenWaveY=105
		ABuffNeeded=list("Life Fiber Synchronize")
		ActiveMessage="augments their Kamui to become a streamlined aerial form!"
		OffMessage="relaxes the aerodynamics of their uniform..."
		SpdMult=1.25
		DefMult=1.25
		passives = list("VoidField" = 1, "PureReduction" = 1, "Flicker" = 1)
		// IconLock='senketsu_shippu.dmi'
		LockX=-14
		LockY=-16
		// TopOverlayLock='senketsu_shippu_headpiece.dmi'
		TopOverlayX=-16
		TopOverlayY=-16
		verb/Kamui_Shippu()
			set category="Skills"
			passives = list("VoidField" = 1, "PureReduction" = clamp(usr.SagaLevel/5,0.01, 1), "Flicker" = 1 )
			if(usr.SagaLevel >= 4)
				passives = list("VoidField" = 1, "PureReduction" = clamp(usr.SagaLevel/5,0.01, 1), "Flicker" = 1,)
			src.Trigger(usr)
	KamuiSenjinShippu
		FlashChange=1
		KenWave=1
		KenWaveIcon='SparkleRed.dmi'
		KenWaveSize=2
		KenWaveTime=5
		KenWaveX=105
		KenWaveY=105
		ABuffNeeded=list("Life Fiber Synchronize")
		ActiveMessage="balances destructive capability and quick movement with a new fierce Kamui form!"
		OffMessage="returns their Kamui to its usual configuration..."
		StrMult=1.25
		SpdMult=1.25
		DefMult=1.25
		OffMult=1.25
		passives = list("PureDamage" = 1, "DeathField" = 1, "HardStyle" = 1, "VoidField" = 1, "PureReduction" = 1, "Flicker" = 1, "Instinct" = 1 )
		// IconLock='senketsu_senjinshippu.dmi'
		LockX=-14
		LockY=-16
		// TopOverlayLock='senketsu_senjinshippu_headpiece.dmi'
		verb/Kamui_Senjin_Shippu()
			set category="Skills"
			passives = list("PureDamage" = 1, "DeathField" = 1, "HardStyle" = 1.25, "VoidField" = 1, "PureReduction" = 1, "Flicker" = 1, "Instinct" = 1 )
			src.Trigger(usr)
	KamuiSenpu
		KiControl=1
		PUSpike=100
		FlashChange=1
		KenWave=1
		KenWaveIcon='SparkleRed.dmi'
		KenWaveSize=2
		KenWaveTime=5
		KenWaveX=105
		KenWaveY=105
		ABuffNeeded=list("Life Fiber Override")
		ActiveMessage="forces their Kamui to assume a more aerodynamic form!"
		OffMessage="allows their Kamui to rest..."
		SpdMult=1.3
		EndMult=1.3
		passives = list("KiControl" = 1, "VoidField" = 1, "PureReduction" = 1, "Flicker" = 1)
		Pursuer=3
		Skimming=2
		Flicker=1
		// IconLock='junketsu_senpu.dmi'
		LockX=-16
		LockY=-16
		// TopOverlayLock='junketsu_senpu_headpiece.dmi'
		TopOverlayX=-32
		TopOverlayY=-32
		verb/Kamui_Senpu()
			set category="Skills"
			if(!usr.BuffOn(src))
				if(usr.PowerControl>100)
					usr << "You cannot risk pouring that amount of blood into the Kamui!"
					return
			src.Trigger(usr)
	KamuiSenpuZanken
		KiControl=1
		PUSpike=100
		FlashChange=1
		KenWave=1
		KenWaveIcon='SparkleRed.dmi'
		KenWaveSize=2
		KenWaveTime=5
		KenWaveX=105
		KenWaveY=105
		ABuffNeeded=list("Life Fiber Override")
		ActiveMessage="forces their Kamui to assume a dangerous and agile form!"
		OffMessage="allows their Kamui to rest..."
		StrMult=1.25
		SpdMult=1.3
		EndMult=1.25
		passives = list("KiControl" = 1, "PureDamage" = 1, "DeathField" = 1, "HardStyle" = 1, "VoidField" = 1, "PureReduction" = 1, "Flicker" = 1)
		PureDamage=3
		DeathField=3
		HardStyle=1
		Juggernaut=1
		Pursuer=3
		Skimming=2
		Flicker=1
		// IconLock='junketsu_senpuzenkan.dmi'
		LockX=-16
		LockY=-16
		// TopOverlayLock='junketsu_senpuzenkan_headpiece.dmi'
		TopOverlayX=-16
		TopOverlayY=-16
		verb/Kamui_Senpu_Zanken()
			set category="Skills"
			if(!usr.BuffOn(src))
				if(usr.PowerControl>100)
					usr << "You cannot risk pouring that amount of blood into the Kamui!"
					return
			src.Trigger(usr)
	Kamui_Unite
		HardStyle=5
		Juggernaut=2
		DeathField=10
		Pursuer=5
		Flicker=3
		passives = list("HardStyle" = 3, "Juggernaut" = 2, "DeathField" = 3, "Pursuer" = 3, "Flicker" = 2)
		StrMult=1.4
		EndMult=1.4
		SpdMult=1.4
		ActiveMessage="unites with their Kamui!"
		Cooldown=60//just to force using
		verb/Kamui_Unite()
			set category="Skills"
			if(usr.KamuiType=="Impulse")
				src.ABuffNeeded=list("Life Fiber Synchronize")
			else
				src.ABuffNeeded=list("Life Fiber Override")
			src.Trigger(usr)
			if(src.Using)
				usr.GodKi=0
				if(usr.KamuiType=="Impulse")
					OMsg(usr, "<font color='red'>Senketsu says: [usr] ... There comes a time when every girl has to put away their sailor suit...</font color>")
					OMsg(usr, "<font color='red'>Senketsu crumbles away due to the batshit insane strain on his fibers...")
					usr.KamuiBuffLock=1
				if(usr.KamuiType=="Purity")
					OMsg(usr, "<font color='cyan'>[usr] says: At last ... My empire is fulfilled...</font color>")
					OMsg(usr, "<font color='cyan'>Junketsu screams one last time before its life fibers are completely subjugated...")
					usr.KamuiBuffLock=1
				usr.ActiveBuff.Trigger(usr)
				for(var/obj/Items/Symbiotic/Kamui/KamuiSenketsu/ks in usr)
					if(ks.suffix)
						ks.AlignEquip(usr)
					del ks
				for(var/obj/Items/Symbiotic/Kamui/KamuiJunketsu/ks in usr)
					if(ks.suffix)
						ks.AlignEquip(usr)
					del ks

	Resolve//Purity Kamui special slot
		EndMult=1.25
		AllOutPU=1
		KKTWave=3
		KKTWaveSize=0.8
		OffMessage="relaxes their resolve..."
		FatigueThreshold=90
		FatigueLeak=2
		verb/Resolve()
			set category="Skills"
			if(!usr.BuffOn(src))
				if(usr.PowerControl>100)
					usr << "You need to steel your resolve first!"
					return
				var/sLevel = usr.SagaLevel
				passives = list("AllOutPU" = 1, "MovementMastery" = sLevel * 1.5,\
				"BuffMastery" = clamp(round(sLevel/2, 0.5), 1, 4), FatigueLeak = 4)
				EndMult = clamp(1 + (0.1 * sLevel), 1.1, 1.7)
				if(sLevel >= 4)
					passives += list("Flicker" = round(sLevel/3,1),  "Pursuer" =  round(sLevel/4,1))
					passives["FatigueLeak"] = 3
				if(sLevel >= 5)
					passives += list("DeathField" = (sLevel-4), "HardStyle" = (sLevel-4) * 0.5, "PureDamage" = (sLevel-4))
					passives["FatigueLeak"] = 2
				if(sLevel >= 7)
					passives += list("PureReduction" = (sLevel-4))
					SureHitTimerLimit = 25
					SureDodgeTimerLimit = 25
					passives["FatigueLeak"] = 1
				if(sLevel >= 8)
					passives["FatigueLeak"] = 0
				// switch(usr.SagaLevel)
				// 	if(2)
				// 		src.ActiveMessage="draws on the resolve to fulfill their goals!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 2, "BuffMastery" = 2, "FatigueLeak" = 2)
				// 		src.MovementMastery=2
				// 		src.BuffMastery=2
				// 		FatigueLeak=2
				// 	if(3)
				// 		src.ActiveMessage="draws on the resolve to fulfill their goals!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 5, "BuffMastery" = 2.5, "FatigueLeak" = 2)
				// 		src.MovementMastery=4
				// 		src.BuffMastery=2.5
				// 		FatigueLeak=2
				// 	if(4)
				// 		src.ActiveMessage="sharpens the resolve to mercilessly fulfill their goals!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 6, "BuffMastery" = 3, "FatigueLeak" = 2, "Flicker" = 1, "Pursuer"  = 1)
				// 		src.MovementMastery=6
				// 		src.BuffMastery=3
				// 		src.Pursuer=1
				// 		src.Flicker=1
				// 		src.FatigueLeak=2
				// 	if(5)
				// 		src.ActiveMessage="sharpens the resolve to mercilessly fulfill their goals!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 8, "BuffMastery" = 3, "FatigueLeak" = 2, "Flicker" = 1, "Pursuer"  = 1, "DeathField" =  2, "HardStyle" = 0.5, "PureDamage" = 1)
				// 		src.MovementMastery=8
				// 		src.BuffMastery=3
				// 		src.Pursuer=1
				// 		src.Flicker=1
				// 		src.PureDamage=1
				// 		src.DeathField=3
				// 		src.HardStyle=0.5
				// 		FatigueLeak=2
				// 	if(6)
				// 		src.ActiveMessage="sharpens the resolve to extend their empire!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 10, "BuffMastery" = 4, "FatigueLeak" = 2, "Flicker" = 1, "Pursuer"  = 2, "DeathField" =  3, "HardStyle" = 1, "PureDamage" = 2)
				// 		src.MovementMastery=10
				// 		src.BuffMastery=4
				// 		src.Pursuer=2
				// 		src.Flicker=1
				// 		src.PureDamage=2
				// 		src.DeathField=4
				// 		src.HardStyle=1
				// 		FatigueLeak=2
				// 	if(7)
				// 		src.ActiveMessage="sharpens the resolve to extend their empire!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 12, "BuffMastery" = 5, "FatigueLeak" = 1, "Flicker" = 2, "Pursuer"  = 3, "DeathField" =  5, "HardStyle" = 2, "PureDamage" = 3, "PureReduction" = 3)
				// 		src.MovementMastery=12
				// 		src.BuffMastery=5
				// 		src.Pursuer=3
				// 		src.Flicker=2
				// 		src.PureDamage=3
				// 		src.PureReduction=3
				// 		src.DeathField=5
				// 		src.HardStyle=2
				// 		src.SureHitTimerLimit=10
				// 		src.SureDodgeTimerLimit=10
				// 		FatigueLeak=1
				// 	if(8)
				// 		src.ActiveMessage="sharpens the resolve to extend their empire!"
				// 		passives = list("AllOutPU" = 1, "MovementMastery" = 12, "BuffMastery" = 5, "FatigueLeak" = 1, "Flicker" = 2, "Pursuer"  = 3, "DeathField" =  5, "HardStyle" = 2, "PureDamage" = 3, "PureReduction" = 3)
				// 		src.MovementMastery=12
				// 		src.BuffMastery=5
				// 		FatigueLeak=0
				// 		FatigueThreshold=null
			src.Trigger(usr)