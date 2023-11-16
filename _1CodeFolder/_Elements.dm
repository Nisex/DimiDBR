proc
	ElementalCheck(var/mob/Attacker, var/mob/Defender, var/ForcedDebuff=0, var/DebuffIntensity=1)
		var/Attack=0
		var/Defense=0
		if(Attacker.ElementalOffense)
			Attack=Attacker.ElementalOffense
		if(Defender.ElementalDefense)
			Defense=Defender.ElementalDefense
		if(Attack=="Ultima")
			ForcedDebuff+=1
		var/DamageMod=0
		var/DebuffRate=0
		DebuffIntensity*=1.2
		DebuffRate=GetDebuffRate(Attack, Defense, ForcedDebuff)
		if(Attacker.SenseUnlocked>5&&Attacker.SenseUnlocked>Attacker.SenseRobbed)
			DebuffRate+=10*(Attacker.SenseUnlocked-5)
		if(Defender.HasDebuffImmune())
			DebuffRate/=Defender.GetDebuffImmune()
		if(Defender.HasIntimidation())
			var/Effective=Defender.GetIntimidation()
			var/Ratio=Attacker.GetIntimidationIgnore(Defender)
			var/Ignored=Effective*Ratio
			Effective-=Ignored
			if(Effective<0)
				Effective=0
			DebuffRate-=Effective/10
		if(DebuffRate<0)
			DebuffRate=0
		switch(Attack)
			if("Ultima")
				DamageMod+=2
			if("Mirror")
				DamageMod+=2
			if("Chaos")
				DamageMod+=2
			if("Void")
				DamageMod+=2
			if("Fire")
				switch(Defense)
					if("Water")
						DamageMod-=1//Reduced damage
					if("Wind")
						DamageMod+=1//Increased damage mod
			if("Water")
				switch(Defense)
					if("Fire")
						DamageMod+=1
					if("Earth")
						DamageMod-=1
			if("Earth")
				switch(Defense)
					if("Water")
						DamageMod+=1
					if("Wind")
						DamageMod-=1
			if("Wind")
				switch(Defense)
					if("Fire")
						DamageMod-=1
					if("Earth")
						DamageMod+=1
		switch(Defense)
			if("Ultima")
				DamageMod-=2
			if("Mirror")
				DamageMod-=2
			if("Chaos")
				DamageMod-=2
			if("Void")
				DamageMod-=2
		if(prob(DebuffRate))
			switch(Attack)
				if("Chaos")
					if(prob(50))
						Defender.AddBurn(2*DebuffIntensity, Attacker)
					if(prob(50))
						Defender.AddSlow(2*DebuffIntensity, Attacker)
					if(prob(50))
						Defender.AddShatter(2*DebuffIntensity, Attacker)
					if(prob(50))
						Defender.AddShock(2*DebuffIntensity, Attacker)
					if(prob(50))
						Defender.AddPoison(2*DebuffIntensity, Attacker)
				if("Ultima")
					Defender.AddBurn(2*DebuffIntensity, Attacker)
					Defender.AddSlow(2*DebuffIntensity, Attacker)
					Defender.AddShatter(2*DebuffIntensity, Attacker)
					Defender.AddShock(2*DebuffIntensity, Attacker)
				if("Rain")
					Defender.AddSlow(4*DebuffIntensity, Attacker)
					Defender.AddShock(4*DebuffIntensity, Attacker)
				if("Poison")
					if(!Defender.HasVenomImmune()&&Defense!="Poison")
						Defender.AddPoison(2*DebuffIntensity, Attacker)
				if("Fire")
					if(!Defender.WalkThroughHell&&!Defender.DemonicPower())
						Defender.AddBurn(4*DebuffIntensity, Attacker)
					else
						Defender.AddBurn(2*DebuffIntensity, Attacker)
				if("Water")
					Defender.AddSlow(4*DebuffIntensity, Attacker)
				if("Earth")
					Defender.AddShatter(4*DebuffIntensity, Attacker)
				if("Wind")
					Defender.AddShock(4*DebuffIntensity, Attacker)
		return DamageMod/10
	GetDebuffRate(var/A, var/D, var/Forced=0)
		var/Return=0
		if(Forced)
			Return=100
			return Return
		switch(A)
			if("Rain")
				Return=30
			if("Fire")//Chance of burn
				Return=30//Chance of burn on every hit.
				switch(D)
					if("Mirror")
						Return-=20
					if("Fire")
						Return+=10
					if("Water")
						Return-=20
					if("Earth")
						Return-=10
					if("Wind")//Super effective
						Return+=20
					if("Ultima")
						Return+=50
			if("Water")//Chance of freeze
				Return=30
				switch(D)
					if("Mirror")
						Return-=20
					if("Fire")//Super Effective
						Return+=20
					if("Water")
						Return+=10
					if("Earth")
						Return-=20
					if("Wind")
						Return-=10
					if("Ultima")
						Return+=50
			if("Earth")//Chance of break
				Return=30
				switch(D)
					if("Mirror")
						Return-=20
					if("Fire")
						Return-=10
					if("Water")//Super Effective
						Return+=20
					if("Earth")
						Return+=10
					if("Wind")
						Return-=20
					if("Ultima")
						Return+=50
			if("Wind")//Chance of off/def reduction
				Return=30
				switch(D)
					if("Mirror")
						Return-=20
					if("Fire")
						Return-=20
					if("Water")
						Return-=10
					if("Earth")//Super Effective
						Return+=20
					if("Wind")
						Return+=10
					if("Ultima")
						Return+=50
		if(A=="Poison")//Chance to poison.
			Return=30
			switch(D)
				if("Mirror")
					Return-=20
				if("Ultima")
					Return+=40
		if(A=="Chaos")//Chance of EVERYTHING GOES TO HELL.
			Return=30
			switch(D)
				if("Mirror")
					Return-=20
				if("Ultima")
					Return+=40
		if(A=="Ultima")//Chance of EVERYTHING GOES TO HELL.
			Return=100
			switch(D)
				if("Mirror")
					Return-=20
		return Return
mob
	proc
		AddBurn(var/Value, var/mob/Attacker=null)
			if(src.ElementalDefense=="Wind")
				Value*=1.5//Super Effective
			if(Attacker && (Attacker == src ? !src.BurningShot : 1))
				if(Attacker.Attunement=="Fire")
					Value*=1.5
			if(src.Attunement=="Wind")
				Value*=1.5
			if(Attunement=="Fire" && !src.BurningShot)
				Value/=2
			if(src.Infusion)
				if(!src.InfusionElement)
					src.InfusionElement="Fire"
				Value/=2
			if(src.HasDebuffImmune() && !src.BurningShot)
				Value/=1+src.GetDebuffImmune()
			Value = Value/**(1-(src.Burn/125))*/
			src.Burn+=Value
			if(Value >=1 && !src.BurningShot)
				animate(src, color = "#ff2643")
				animate(src, color = src.MobColor, time=5)

			if(Attacker&&Attacker.HasDarknessFlame()&&Attacker!=src)
				if(Attacker.IsEvil())
					Attacker.CursedWounds+=1
				src.AddPoison(Value*1.25, Attacker=Attacker)
				if(Attacker.IsEvil())
					Attacker.CursedWounds-=1

			if(src.Burn>100)
				src.Burn=100
			if(src.Burn<0)
				src.Burn=0
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Cooled)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Cooled+=100
		AddSlow(var/Value, var/mob/Attacker=null)
			if(src.ElementalDefense=="Fire")
				Value*=1.5//Super effective
			if(Attacker)
				if(Attacker.Attunement=="Water")
					Value*=1.5
			if(src.Attunement=="Fire")
				Value*=1.5

			if(Attunement=="Water")
				Value/=2


			if(src.Infusion)
				if(!src.InfusionElement)
					src.InfusionElement="Water"
				Value/=2
			if(src.HasDebuffImmune())
				Value/=1+src.GetDebuffImmune()
			Value = Value/**(1-(src.Slow/125))*/
			src.Slow+=Value

			if(Value >=1)
				animate(src, color = "#578cff")
				animate(src, color = src.MobColor, time=5)


				if(Attacker&&Attacker.HasAbsoluteZero())
					src.Shatter+=Value/2
					if(src.Shatter>100)
						src.Shatter=100
					src.Shock+=Value/2
					if(src.Shock>100)
						src.Shock=100
			if(src.Slow>100)
				src.Slow=100
			if(src.Slow<0)
				src.Slow=0
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Cooled)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Cooled+=100
		AddShatter(var/Value, var/mob/Attacker=null)
			if(src.ElementalDefense=="Water")
				Value*=1.5
			if(Attacker)
				if(Attacker.Attunement=="Earth")
					Value*=1.5
			if(src.Attunement=="Water")
				Value*=1.5
			if(src.Infusion)
				if(!src.InfusionElement)
					src.InfusionElement="Earth"
				Value/=2
			
			if(Attunement=="Earth")
				Value/=2

			if(src.HasDebuffImmune())
				Value/=1+src.GetDebuffImmune()
			Value = Value*(1-(src.Shatter/glob.DEBUFF_STACK_RESISTANCE))
			src.Shatter+=Value

			if(Value >=1)
				src.color = "#8f7946"
				animate(src, color = src.MobColor, time=5)


			if(src.Shatter>100)
				src.Shatter=100
			if(src.Shatter<0)
				src.Shatter=0
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Sprayed)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Sprayed+=100
		AddShock(var/Value, var/mob/Attacker=null)
			if(src.ElementalDefense=="Earth")
				Value*=1.5
			if(Attacker)
				if(Attacker.Attunement=="Wind")
					Value*=1.5
			if(src.Attunement=="Earth")
				Value*=1.5
			if(src.Infusion)
				if(!src.InfusionElement)
					src.InfusionElement="Wind"
				Value/=2
			if(Attunement=="Wind")
				Value/=2
			
			if(src.HasDebuffImmune())
				Value/=1+src.GetDebuffImmune()
			Value = Value*(1-(src.Shock/glob.DEBUFF_STACK_RESISTANCE))
			src.Shock+=Value

			if(Value >=1)
				animate(src, color = "#fff757")
				animate(src, color = src.MobColor, time=5)


			if(src.Shock>100)
				src.Shock=100
			if(src.Shock<0)
				src.Shock=0
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Stabilized)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Stabilized+=100
		AddPoison(var/Value, var/mob/Attacker=null)
			if(src.Infusion||src.VenomResistance)
				if(src.VenomResistance)
					src.Poison+=Value/(1+src.VenomResistance)
			else
				if(Attunement=="Poison")
					Value/=2
				Value = Value*(1-(src.Poison/glob.DEBUFF_STACK_RESISTANCE))
				src.Poison+=Value

				if(Value >=1)
					animate(src, color = "#ff1cff")
					animate(src, color = src.MobColor, time=5)

				if(Attacker&&Attacker.CursedWounds())
					src.Sheared+=Value/2
					if(src.Sheared>=100)
						src.Sheared=100
					src.Crippled+=Value/3
					if(src.Crippled>=100)
						src.Crippled=100
			if(src.Poison>100)
				src.Poison=100
			if(src.Poison<0)
				src.Poison=0
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Antivenomed)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Antivenomed+=100
		AddConfusing(var/Value, var/mob/Attacker=null)
			src.Confused+=Value
			if(src.Confused>100)
				src.Confused=100
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Stabilized)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Stabilized+=100
		AddShearing(var/Value, var/mob/Attacker=null)
			Value = Value*(1-(src.Sheared/glob.DEBUFF_STACK_RESISTANCE))
			src.Sheared+=Value
			if(src.Sheared>100)
				src.Sheared=100
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Sprayed)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Sprayed+=100
		AddCrippling(var/Value, var/mob/Attacker=null)
			// if(src.Race=="Majin")
			// 	if(!src.AscensionsAcquired||src.AscensionsAcquired>=3)
			// 		Value=0
			if(Race == "Dragon" && Class == "Lightning")
				Value = 0
			if(src.HasLegendaryPower() > 0.75)
				Value = Value*(1-(src.Crippled/glob.DEBUFF_STACK_RESISTANCE))
				src.Crippled+=Value
			if(src.Crippled>100)
				src.Crippled=100
			for(var/obj/Items/Gear/Automated_Aid_Dispenser/AD in src)
				if(AD.suffix&&AD.Uses)
					AD.Uses--
					if(AD.Uses<0)
						AD.Uses=0
					if(!src.Sprayed)
						OMsg(src, "<font color='[rgb(104, 153, 251)]'>[src]'s dispenser deploys a healing mist!!</font color>")
					src.Sprayed+=100
		AddAttracting(var/Value, var/mob/m)
			src.Attracted+=Value
			src.AttractedTo=m
			if(src.Attracted>100)
				src.Attracted=100
		AddTerrifying(var/Value, var/mob/m)
			src.Terrified+=Value
			src.TerrifiedOf=m
			if(src.Terrified>100)
				src.Terrified=100
		AddPacifying(var/Value, var/mob/Attacker=null)
			if(!src.DemonicPower())
				src.Calm(Pacified=1)
		AddEnraging(var/Value, var/mob/Attacker=null)
			src.Anger(Enraged=1)

mob
	proc
		Debuffs()
			if(src.Stasis)
				return
			if(src.Poison)
				doDebuffDamage("Poison")
			if(src.Burn)
				doDebuffDamage("Burn")

			if(src.Shatter)
				if(src.Sprayed)
					src.Shatter-=(src.GetEnd(0.25)+src.GetDef(0.1))*2*(1+src.GetDebuffImmune())
				else
					src.Shatter-=(src.GetEnd(0.25)+src.GetDef(0.1))*(1+src.GetDebuffImmune())
				if(src.Shatter<=0)
					src.Shatter=0

			if(src.Slow)
				if(src.Cooled)
					src.Slow-=(src.GetEnd(0.25)+src.GetSpd(0.1))*2*(1+src.GetDebuffImmune())
				else
					src.Slow-=(src.GetEnd(0.25)+src.GetSpd(0.1))*(1+src.GetDebuffImmune())
				if(src.Slow<=0)
					src.Slow=0

			if(src.Shock)
				if(src.Stabilized)
					src.Shock-=(src.GetEnd(0.25)+src.GetSpd(0.1))*2*(1+src.GetDebuffImmune())
				else
					src.Shock-=(src.GetEnd(0.25)+src.GetSpd(0.1))*(1+src.GetDebuffImmune())
				if(src.Shock<=0)
					src.Shock=0

			if(src.Crippled)
				if(src.Sprayed)
					src.Crippled-=(src.GetSpd(0.25)+src.GetDef(0.1))*2*(1+src.GetDebuffImmune())
				else
					src.Crippled-=(src.GetSpd(0.25)+src.GetDef(0.1))*(1+src.GetDebuffImmune())
				if(src.Crippled<=0)
					src.Crippled=0

			if(src.Confused&&!src.Stunned)
				if(src.Stabilized)
					src.Confused-=5
				else
					src.Confused--
				if(src.Confused<=0)
					src.Confused=0

			if(src.Sheared)
				if(src.Sprayed)
					if(src.icon_state=="Meditate")
						src.Sheared-=4
					else
						src.Sheared-=0.5
				else
					if(src.icon_state=="Meditate")
						src.Sheared-=2
					else
						src.Sheared-=0.25
			if(src.Sheared<=0)
				src.Sheared=0

			if(src.Attracted&&!src.Confused&&!src.Stunned)
				src.Attracted--
				if(src.Attracted<=0)
					src.Attracted=0
					src.AttractedTo=0

			if(!src.AttractedTo)
				if(src.Attracted>0)
					src.Attracted=0


