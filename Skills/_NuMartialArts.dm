obj
	Skills
		Buffs
			Read(F)
				..()
				// death becomes u
				// if(!(altered || Using))
				// 	var/path = "[type]"
				// 	var/obj/Skills/Buffs/b = new path
				// 	if(isnull(passives))
				// 		world.log << "Hey. [src] didnt get passives."
				// 		passives = list()
				// 	for(var/x in b.passives)
				// 		passives["[x]"] = b.passives[x]
			var
				CorruptionGain
				ResourceCost
				ResourceThreshold
				AngerPoint // set an anger point
				StyleStr=1
				StyleFor=1
				StyleEnd=1
				StyleSpd=1
				StyleOff=1
				StyleDef=1
				Finisher//a text path that links to a queue attack which loads an autonomous buff
				CantTrans = FALSE

//Martial
			NuStyle
				var/tensionStorage = 0
				var/last_storage = 0
				var/tmp/triggerTension 
				proc/turnOff(mob/p)
					tensionStorage = p.Tension
					last_storage = world.time
					Trigger(usr, 1)
					cooldown_remaining = 0
				proc/giveBackTension(mob/p)
					if(last_storage + 1200 > world.time) // this should never happen ?
						// we can give it back
						if(tensionStorage)
							p.Tension = tensionStorage
							tensionStorage = 0
					else
						tensionStorage = 0
				skillDescription()
					..()
					if(StyleStr)
						if(StyleStr  < 1 &&  StyleStr  > 0)
							description += "Strength Reduction: [StyleStr]\n"
						else
							if(StyleStr > 1)
								description += "Strength Add: [StyleStr-1]\n"
					if(StyleFor)
						if(StyleFor  < 1 &&  StyleFor  > 0)
							description += "Force Reduction: [StyleFor]\n"
						else
							if(StyleFor > 1)
								description += "Force Add: [StyleFor-1]\n"
					if(StyleEnd)
						if(StyleEnd  < 1 &&  StyleEnd  > 0)
							description += "Endurance Reduction: [StyleEnd]\n"
						else
							if(StyleEnd > 1)
								description += "Endurance Add: [StyleEnd-1]\n"
					if(StyleSpd)
						if(StyleSpd  < 1 &&  StyleSpd  > 0)
							description += "Speed Reduction: [StyleSpd]\n"
						else
							if(StyleSpd > 1)
								description += "Speed Add: [StyleSpd-1]\n"
					if(StyleOff)
						if(StyleOff  < 1 &&  StyleOff  > 0)
							description += "Offense Reduction: [StyleOff]\n"
						else
							if(StyleOff > 1)
								description += "Offense Add: [StyleOff-1]\n"
					if(StyleDef)
						if(StyleDef  < 1 &&  StyleDef  > 0)
							description += "Defense Reduction: [StyleDef]\n"
						else
							if(StyleDef > 1)
								description += "Defense Add: [StyleDef-1]\n"

				var/StylePrimeUnlock //obtained from getting mastery 4; can be a list
				var/StyleComboUnlock=list()//obtained from getting mastery 3 in 2 styles; MUST be a list
				Mastery=0
				Copyable=0
				SkillCost=20
				StyleSlot=1
				var/list/UnlockedStances=list("Cancel")
				UnarmedStyle
					NoSword=1
					NoStaff=1

					Earth_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Water_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tranquil_Dove_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wind_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style")
						StyleStr=1.1
						StyleEnd=1.1
						StyleFor=1.1
						NoStaff = 0
						ElementalClass="Earth"
						StyleActive="Earth"
						ElementalOffense="Earth"
						ElementalDefense="Earth"
						Finisher="/obj/Skills/Queue/Finisher/Mountain_Crusher"
						verb/Earth_Style()
							set hidden=1
							src.Trigger(usr)
					Wind_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Fire_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Sunlit_Sky_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Earth_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style")
						StyleStr=1.1
						StyleFor=1.1
						StyleSpd=1.1
						NoStaff = 0
						ElementalClass="Wind"
						StyleActive="Wind"
						ElementalOffense="Wind"
						ElementalDefense="Wind"
						Finisher="/obj/Skills/Queue/Finisher/Shifting_Clouds"
						verb/Wind_Style()
							set hidden=1
							src.Trigger(usr)
					Fire_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Water_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Inverse_Poison_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wind_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Sunlit_Sky_Style")
						StyleEnd=1.1
						StyleFor=1.1
						StyleSpd=1.1
						NoStaff = 0
						ElementalClass="Fire"
						StyleActive="Fire"
						ElementalOffense="Fire"
						ElementalDefense="Fire"
						IconLock='Flaming Arms.dmi'
						LockX=0
						LockY=0
						Finisher="/obj/Skills/Queue/Finisher/Hellraiser"
						verb/Fire_Style()
							set hidden=1
							src.Trigger(usr)
					Water_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Earth_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tranquil_Dove_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Fire_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Inverse_Poison_Style")
						StyleStr=1.1
						StyleEnd=1.1
						StyleSpd=1.1
						NoStaff = 0
						ElementalClass="Water"
						StyleActive="Water"
						ElementalOffense="Water"
						ElementalDefense="Water"
						Finisher="/obj/Skills/Queue/Finisher/Split_River"
						verb/Water_Style()
							set hidden=1
							src.Trigger(usr)
					//Signature Styles T1
						
					Heavenly_Demon_T3
						name = "Heavenly Demon's Chaotic Way of Shattered Realms"
						StyleActive = "Heavenly Demon's Chaotic Way of Shattered Realms"
						SignatureTechnique=3
						Copyable=0
						passives = list("Conductor" = 90, "Antsy" = 10, "CounterMaster" = 5, "SwordPunching" = 1, "NeedsSword" = 0, "NoSword" = 1)
						NeedsSword=0
						NoSword=1
						SwordPunching=1
						StyleStr=1
						StyleEnd=1
						StyleOff=1
						StyleDef=1
						StyleFor=1
						Finisher="/obj/Skills/Queue/Finisher/Cycle_of_Samsara"
					

					Circuit_Breaker_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.1
						StyleEnd=1.1
						StyleFor=1.1
						StyleSpd=1.15
						NoStaff = 0
						ElementalClass=list("Wind", "Earth")
						StyleActive="Circuit Break"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Inverse_Poison_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Entropy_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Gentle_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Flow_Reversal_Style")
						ElementalOffense="Earth"
						ElementalDefense="Wind"
						passives = list("CyberStigma" = 4, "PureDamage" = 0.5, "PureReduction" = 0.5)
						CyberStigma=1
						IconLock='Overdrive.dmi'
						Finisher="/obj/Skills/Queue/Finisher/Ray_Divider"
						verb/Circuit_Breaker_Style()
							set hidden=1
							src.Trigger(usr)

					Drunken_Fist_Style
						SignatureTechnique=2
						Copyable=0
						StyleEnd=1.3
						StyleDef=1.3
						passives = list("CounterMaster" = 3, "SoftStyle" = 2, "FluidForm" = 1)
						CounterMaster=2
						SoftStyle=2
						FluidForm=1
						StyleActive="Drunken Fist"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Golden_Kirin_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/North_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Tetsuzankou"
						verb/Drunken_Master_Style()
							set name="Drunken Fist Style"
							set hidden=1
							src.Trigger(usr)
					
					//Unarmed Saga Styles
					Ansatsuken_Style
						Copyable=0
						SagaSignature=1
						StyleStr=1.25
						StyleEnd=1.25
						StyleFor=1.25
						StyleSpd=1.25
						StyleActive="Ansatsuken"
						passives = list("AllOutAttack" = 1)
						ManaCost=100
						Mastery=4
						AllOutAttack=1
						verb/Ansatsuken_Style()
							set hidden=1
							src.Trigger(usr)


				SwordStyle
					NeedsSword=1
					NoStaff=1

//Signature Style T1
					Sword_And_Shield
						SignatureTechnique=1
						Copyable=0
						StyleEnd=1.3
						StyleStr=1.15
						StyleActive="Sword And Shield"
						passives = list("Hardening" = 1, "Deflection" = 0.5)
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Phalanx_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wushu_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Divine_Arts_of_The_Heavenly_Demon")
						Finisher="/obj/Skills/Queue/Finisher/Behemoth_Typhoon"
					Nito_Ichi//iaido + fencing
						SignatureTechnique=1
						NeedsSecondSword=1
						Copyable=0
						StyleOff=1.15
						StyleSpd=1.3
						StyleActive="Nito Ichi"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Secret_Knife_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Soul_Crushing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Arcane_Bladework_Style")
						passives = list("BlurringStrikes", "DoubleStrike" = 1, "NeedsSecondSword" = 1)
						DoubleStrike=1
						Finisher="/obj/Skills/Queue/Finisher/Geo_de_Ray"
						verb/Nito_Ichi()
							set hidden=1
							src.Trigger(usr)
					Kunst_des_Fechtens//fencing + zornhau
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.3
						StyleEnd=0.85
						StyleOff=1.3
						StyleActive="German Longsword"
						passives = list("Zornhau" = 1)
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Butcher_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Spirit_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Battle_Mage_Style")
						Finisher="/obj/Skills/Queue/Finisher/Ichimonji"
						verb/Kendo_Style()
							set hidden=1
							src.Trigger(usr)
					Assassination_Style// iaido + swordless
						SignatureTechnique=1
						Copyable=0
						passives = list("SwordPunching" = 1)
						SwordPunching=1
						StyleStr=1.15
						StyleEnd=1.15
						StyleSpd=1.15
						NeedsSword=0

						StyleActive="Assassination"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Nito_Ichi"="/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Resonance_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Blade_Singing_Style")
						Finisher="/obj/Skills/Queue/Finisher/Flying_Barcelona"
						verb/Secret_Knife_Style()
							set hidden=1
							src.Trigger(usr)
					Arcane_Bladework_Style
						SignatureTechnique=2
						Copyable=0
						StyleStr=1.25
						StyleFor=1.25
						StyleSpd=1.5
						passives = list("DoubleStrike" = 1, "ArcaneBladework" = 1, "TechniqueMastery" = 3, "SpiritSword" = 0.75, "WeaponBreaker" = 2)
						DoubleStrike=1
						NoStaff=0
						ArcaneBladework=1
						TechniqueMastery=5
						SpiritSword=0.75
						WeaponBreaker=2
						StyleActive="Arcane Bladework"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Battle_Mage_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/South_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Sacred_Edge"
						verb/Arcane_Bladework_Style()
							set hidden=1
							src.Trigger(usr)
					Blade_Singing_Style
						SignatureTechnique=2
						Copyable=0
						NeedsSword=0
						passives = list("SwordPunching" = 1, "WeaponBreaker" = 3, "Pursuer" = 2, "Flicker" = 2)
						SwordPunching=1
						StyleSpd=2
						StyleOff=1.25
						StyleStr=1.25
						WeaponBreaker=3
						Pursuer=2
						Flicker=2
						StyleActive="Blade Singing"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Shunko_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Rhythm_of_War_Style")
						Finisher="/obj/Skills/Queue/Finisher/Centifoila"
						verb/Blade_Singing_Style()
							set hidden=1
							src.Trigger(usr)
					Battle_Mage_Style
						SignatureTechnique=2
						Copyable=0
						NoSword=1
						NeedsSword=0
						NoStaff=0
						NeedsStaff=1
						passives = list("Flicker" = 2, "Pursuer" = 2, "TechniqueMastery" = 3, "MartialMagic" = 1)
						Flicker=2
						Pursuer=2
						StyleStr=1.25
						StyleFor=1.25
						StyleSpd=1.5
						MartialMagic=1
						//Staff-as-sword
						//Refinement
						StyleActive="Battle Mage"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Arcane_Bladework_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/South_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Absolute_Truth"
						verb/Battle_Mage_Style()
							set hidden=1
							src.Trigger(usr)

//Signature Style T3
					Five_Rings_Style
						SignatureTechnique=3
						NeedsSecondSword=1
						NeedsThirdSword=1
						Copyable=0
						StyleStr=1.5
						StyleSpd=1.5
						passives = list("Shearing" = 5, "Crippling" = 5, "DoubleStrike" = 2, "TripleStrike" = 2, "SweepingStrike" = 1, "SlayerMod" = 2.5, "NeedsSecondSword" = 1, "NeedsThirdSword" = 1)
						Shearing=5
						Crippling=5
						NoForcedWhiff=1
						DoubleStrike=2
						TripleStrike=2
						SweepingStrike=1
						SlayerMod=2.5
						StyleActive="Five Rings"
						Finisher="/obj/Skills/Queue/Finisher/Ashura_Kai"
						verb/Toggle_Sword_Count()
							set category="Other"
							if(src.NeedsSecondSword&&src.NeedsThirdSword)
								src.NeedsSecondSword=1
								src.NeedsThirdSword=0
								usr << "You decide to wield <font color='yellow'>two</font color> swords."
							else if(src.NeedsSecondSword&&!src.NeedsThirdSword)
								src.NeedsSecondSword=0
								usr << "You decide to wield a <font color='red'>single</font color> sword."
							else
								src.NeedsSecondSword=1
								src.NeedsThirdSword=1
								usr << "You decide to wield <font color='green'>three</font color> swords."
						verb/Five_Rings_Style()
							set hidden=1
							src.Trigger(usr)
					South_Star_Style
						SignatureTechnique=3
						Copyable=0
						NeedsSword=0
						NoSword=1
						StyleStr=1.4
						StyleFor=1.4
						StyleSpd=1.2
						passives = list("Flicker" = 3, "Pursuer" = 3, "MovementMastery" = 8, "TechniqueMastery" = 4, "MartialMagic" = 1, "HybridStrike" = 1, "KiBlade" = 1)
						Flicker=3
						Pursuer=3
						MovementMastery=8
						TechniqueMastery=10
						MartialMagic=1
						DoubleStrike=1
						TripleStrike=1
						HybridStrike=1
						NoSword=1
						NoStaff=1
						KiBlade=1
						ElementalClass="Fire"
						StyleActive="South Star"
						Finisher="/obj/Skills/Queue/Finisher/Skyward_Strike"
						verb/South_Star_Style()
							set hidden=1
							src.Trigger(usr)
//Saga Sword Styles

	//Hiten Mitsurugi
					Hiten_Mitsurugi_Ryuu
						Copyable=0
						SagaSignature=1
						StyleStr=1.5
						StyleSpd=1.5
						StyleActive="Hiten Mitsurugi"
						passives = list("Flicker" = 1)
						Flicker=1
						Mastery=4
						ClassNeeded = list("Light", "Wooden")
						Finisher="/obj/Skills/Queue/Finisher/Flash_Strike"
						verb/Hiten_Mitsurugi_Ryuu()
							set hidden=1
							src.Trigger(usr)

	//Keyblade
					Command
						Copyable=0
						FlashChange=1
						Mastery=4
						Speed_Rave_Style
							StyleStr = 1.5
							StyleSpd = 1.5
							StyleOff = 1.1
							StyleDef = 1.1
							StyleActive="Speed Rave"
							passives = list("BlurringStrikes" = 1, "AfterImages" = 1, "Steady" = 1)
							Finisher="/obj/Skills/Queue/Finisher/Fever_Pitch"
							verb/Speed_Rave_Style()
								set hidden=1
								src.Trigger(usr)
						Critical_Impact_Style
							StyleStr = 1.5
							StyleEnd = 1.5
							StyleOff = 1.2
							StyleActive="Critical Impact"
							passives = list("CriticalChance" = 15, "CriticalDamage" = 0.1, "HeavyHitter" = 1, "CallousedHands" = 0.15)
							Finisher="/obj/Skills/Queue/Finisher/Fatal_Mode"
							verb/Critical_Impact_Style()
								set hidden=1
								src.Trigger(usr)
						Spell_Weaver_Style
							StyleFor = 1.5
							StyleSpd = 1.5
							StyleDef = 1.1
							StyleActive="Spell Weaver"
							passives = list("SpiritFlow" = 0.15, "QuickCast" = 1, "MovingCharge" = 1, "Siphon" = 2)
							Finisher="/obj/Skills/Queue/Finisher/Magic_Wish"
							verb/Spell_Weaver_Style()
								set hidden=1
								src.Trigger(usr)
						Firestorm_Style
							StyleStr=1.5
							StyleFor=1.5
							ElementalClass="Fire"
							StyleActive="Firestorm"
							ElementalOffense="Fire"
							ElementalDefense="Fire"
							passives = list("Burning" = 1)
							Burning=1
							Finisher="/obj/Skills/Queue/Finisher/Fire_Storm"
							verb/Firestorm_Style()
								set hidden=1
								src.Trigger(usr)
						Diamond_Dust_Style
							StyleEnd=1.5
							StyleFor=1.5
							ElementalClass="Water"
							StyleActive="Diamond Dust"
							ElementalOffense="Water"
							ElementalDefense="Water"
							passives = list("Chilling" = 1)
							Chilling=1
							Finisher="/obj/Skills/Queue/Finisher/Diamond_Dust"
							verb/Diamond_Dust_Style()
								set hidden=1
								src.Trigger(usr)
						Thunderbolt_Style
							StyleEnd=1.5
							StyleSpd=1.5
							ElementalClass="Wind"
							StyleActive="Thunderbolt"
							ElementalOffense="Wind"
							ElementalDefense="Wind"
							passives = list("Shocking" = 1)
							Shocking=1
							Finisher="/obj/Skills/Queue/Finisher/Thunderbolt"
							verb/Thunderbolt_Style()
								set hidden=1
								src.Trigger(usr)
						Wing_Blade_Style
							StyleStr=1.25
							StyleFor=1.25
							StyleSpd=1.5
							StyleActive="Wing Blade"
							passives = list("SweepingStrike" = 1, "DoubleStrike" = 1, "BlurringStrikes" = 1)
							SweepingStrike=1
							SwordIcon='BLANK.dmi'
							SwordIconSecond='BLANK.dmi'
							IconLock='WingBlade.dmi'
							LockX=-16
							LockY=-16
							IconLockBlend=2
							IconApart=1
							Finisher="/obj/Skills/Queue/Finisher/Wing_Blade"
							verb/Wing_Blade_Style()
								set hidden=1
								src.Trigger(usr)
						Cyclone_Style
							StyleStr=1.25
							StyleFor=1.25
							StyleSpd=1.5
							ElementalClass="Wind"
							StyleActive="Cyclone"
							ElementalOffense="Wind"
							ElementalDefense="Wind"
							passives = list( "TechniqueMastery" = 1.5, "BlurringStrikes" = 1, "Paralyzing" = 1, "SpiritFlow" = 0.25)
							Shocking=1
							Paralyzing=0.2
							Finisher="/obj/Skills/Queue/Finisher/Cyclone"
							verb/Cyclone_Style()
								set hidden=1
								src.Trigger(usr)
						Rock_Breaker_Style
							StyleDef=1.25
							StyleStr=1.25
							StyleEnd=1.5
							ElementalClass="Earth"
							StyleActive="Rock Breaker"
							ElementalOffense="Earth"
							ElementalDefense="Earth"
							passives = list("Hardening" = 1, "Crushing" = 1, "ArmorPeeling" = 1, "CallousedHands" = 0.15)
							Crushing=1
							Finisher="/obj/Skills/Queue/Finisher/Rock_Breaker"
							verb/Rock_Breaker_Style()
								set hidden=1
								src.Trigger(usr)
						Dark_Impulse_Style
							StyleStr=1.5
							StyleEnd=1.5
							IconLock='DarknessGlow.dmi'
							IconUnder=1
							passives = list("Momentum" = 1, "CallousedHands " = 0.3)
							LockX=-32
							LockY=-32
							StyleActive="Dark Impulse"
							ElementalOffense = "Dark"
							ElementalDefense = "Dark"
							Finisher="/obj/Skills/Queue/Finisher/Dark_Impulse"
							verb/Dark_Impulse_Style()
								set hidden=1
								src.Trigger(usr)
						Ghost_Drive_Style
							StyleOff=1.25
							StyleDef=1.25
							StyleFor=1.5
							StyleActive="Ghost Drive"
							passives = list("Likewater" = 1, "Godspeed" = 1, "MovingCharge" = 1, "QuickCast" = 1, "SpiritFlow" = 0.5)
							Afterimages=1
							Finisher="/obj/Skills/Queue/Finisher/Ghost_Drive"
							verb/Ghost_Drive_Style()
								set hidden=1
								src.Trigger(usr)
						Blade_Charge_Style
							StyleStr = 1.25
							StyleOff = 1.25
							StyleFor = 1.5
							StyleActive="Blade Charge"
							passives = list("Extend" = 1, "SpiritSword" = 0.75, "SpiritHand" = 1)
							Extend=1
							SpiritSword=0.75
							Finisher="/obj/Skills/Queue/Finisher/Blade_Charge"
							verb/Blade_Charge_Style()
								set hidden=1
								src.Trigger(usr)

				FreeStyle
					NeedsSword=0
					NoSword=0
					NoStaff=0

					Feral_Style
						StyleStr=1.3
						StyleEnd=1.5
						StyleSpd=1.2
						StyleActive="Feral"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Blitz_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Spirit_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Flow_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Yin_Yang_Style")
						passives = list("Instinct" = 1)
						Instinct=1
						Finisher="/obj/Skills/Queue/Finisher/Berserker_Claw"
						verb/Feral_Style()
							set hidden=1
							src.Trigger(usr)
					Flow_Style
						StyleEnd=1.4
						StyleFor=1.2
						StyleSpd=1.4
						StyleActive="Flow"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Breaker_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Soul_Crushing_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Feral_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Yin_Yang_Style")
						passives = list("Flow" = 1)
						Flow=1
						Finisher="/obj/Skills/Queue/Finisher/Evac_Toss"
						verb/Flow_Style()
							set hidden=1
							src.Trigger(usr)
					Breaker_Style
						StyleStr=1.3
						StyleEnd=1.4
						StyleFor=1.3
						StyleActive="Breaker"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Flow_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Soul_Crushing_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Blitz_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Resonance_Style")
						passives = list("WeaponBreaker" = 1)
						WeaponBreaker=1
						Finisher="/obj/Skills/Queue/Finisher/Armor_Piercer"
						verb/Breaker_Style()
							set hidden=1
							src.Trigger(usr)
					Blitz_Style
						StyleStr=1.3
						StyleEnd=1.3
						StyleSpd=1.4
						StyleActive="Blitz"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Feral_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Spirit_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Breaker_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Resonance_Style")
						passives = list("Flicker" = 1, "Pursuer" = 1)
						Flicker=1
						Pursuer=1
						Finisher="/obj/Skills/Queue/Finisher/Riot_Stamp"
						verb/Blitz_Style()
							set hidden=1
							src.Trigger(usr)
//Signature Style T1
					Soul_Crushing_Style
						SignatureTechnique=1
						Copyable=0
						StyleFor=1.5
						StyleEnd=1.5
						passives = list("SpiritStrike" = 1, "WeaponBreaker" = 1, "MovingCharge" = 1)
						SpiritStrike=1
						WeaponBreaker=1
						MovingCharge=1
						StyleActive="Soul Crushing"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Spirit_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Shunko_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Nito_Ichi"="/obj/Skills/Buffs/NuStyle/SwordStyle/Arcane_Bladework_Style")
						Finisher="/obj/Skills/Queue/Finisher/Impact_Palm"
						verb/Soul_Crushing_Style()
							set hidden=1
							src.Trigger(usr)
					Spirit_Style
						SignatureTechnique=1
						Copyable=0
						StyleFor=1.5
						StyleSpd=1.5
						passives = list("Flicker" = 1, "Pursuer" = 1)
						Flicker=1
						Pursuer=1
						StyleActive="Spirit"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Soul_Crushing_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Shunko_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Kendo_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Battle_Mage_Style")
						Finisher="/obj/Skills/Queue/Finisher/Superbia"
						verb/Spirit_Style()
							set hidden=1
							src.Trigger(usr)
					Yin_Yang_Style
						SignatureTechnique=1
						Copyable=0
						StyleOff=1.25
						StyleDef=1.25
						StyleEnd=1.5
						passives = list("Flow" = 0.5, "Instinct" = 0.5, "LikeWater" = 1, "CounterMaster" = 2)
						//adaptation passive
						StyleActive="Balance"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Resonance_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Metta_Sutra_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Shaolin_Style")
						Finisher="/obj/Skills/Queue/Finisher/Turn_of_Fortune"
						verb/Yin_Yang_Style()
							set hidden=1
							src.Trigger(usr)
					Resonance_Style
						SignatureTechnique=1
						Copyable=0
						StyleStr=1.5
						StyleFor=1.5
						passives = list("WeaponBreaker" = 2, "Pursuer" = 1, "Flicker" = 1)
						WeaponBreaker=2
						Pursuer=1
						Flicker=1
						StyleActive="Resonance"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Yin_Yang_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Metta_Sutra_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Secret_Knife_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Blade_Singing_Style")
						Finisher="/obj/Skills/Queue/Finisher/Chemical_Love"
						verb/Resonance_Style()
							set hidden=1
							src.Trigger(usr)


//Signature Style T2
					Shunko_Style
						SignatureTechnique=2
						Copyable=0
						StyleStr=1.4
						StyleFor=1.4
						StyleEnd=1.1
						StyleSpd=1.1
						passives = list("IdealStrike" = 1, "HybridStrike" = 0.5, "MartialMagic" = 1,\
						"TechniqueMastery" = 2.5,"MovingCharge" = 1)
						StyleActive="Shunko"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Blade_Singing_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Rhythm_of_War_Style")
						Finisher="/obj/Skills/Queue/Finisher/Raioken"
						verb/Shunko_Style()
							set hidden=1
							src.Trigger(usr)
					Metta_Sutra_Style
						SignatureTechnique=2
						Copyable=0
						StyleStr=1.1
						StyleFor=1.1
						StyleEnd=1.4
						StyleSpd=1.4
						passives = list("WeaponBreaker" = 3, "Flow" = 1, "Instinct" = 1, "LikeWater" = 2, "Flicker" = 1, "Pursuer" = 1, "CounterMaster" = 4)
						WeaponBreaker=3
						Flow=2
						Instinct=2
						//adaptation
						Flicker=1
						Pursuer=1
						StyleActive="Metta Sutra"
						ElementalDefense="Mirror"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Shaolin_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/West_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Karaniyam"
						verb/Metta_Sutra_Style()
							set hidden=1
							src.Trigger(usr)
					Shaolin_Style
						SignatureTechnique=2
						Copyable=0
						NoStaff=0
						StyleStr=1.5
						StyleFor=1.5
						passives = list("Flow" = 2, "Instinct" = 2, "SwordPunching" = 1)
						Flow=2
						Instinct=2
						//adaptation passive
						//champloo's sord punching
						SwordPunching=1
						StyleActive="Shaolin"
						ElementalOffense="Mirror"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Metta_Sutra_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/West_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Bicycle_Kick"
						verb/Shaolin_Style()
							set hidden=1
							src.Trigger(usr)

//Signature Style T3
					West_Star_Style
						SignatureTechnique=3
						Copyable=0
						NoStaff=0
						StyleEnd=1.5
						StyleSpd=1.5
						passives = list("WeaponBreaker" = 4, "Flow" = 3, "Instinct" = 3, "Flicker" = 2, "Pursuer" = 2, "SwordPunching" = 1)
						WeaponBreaker=4
						Flow=3
						Instinct=3
						Flicker=2
						Pursuer=2
						//adaptation
						//Champloo's sword punching
						SwordPunching=1
						ElementalOffense="Mirror"
						ElementalDefense="Mirror"
						ElementalClass="Water"
						StyleActive="West Star"
						Finisher="/obj/Skills/Queue/Finisher/Journey_End"
						verb/West_Star_Style()
							set hidden=1
							src.Trigger(usr)
					Rhythm_of_War_Style
						SignatureTechnique=3
						Copyable=0
						StyleStr=1.25
						StyleFor=1.25
						StyleSpd=1.5
						passives = list("IdealStrike" = 1, "WeaponBreaker" = 2, "Flicker" = 2, "Pursuer" = 3, "SuperDash" = 2, "SwordPunching" = 1, "TechniqueMastery" = 2, "MovementMastery" = 6, "MartialMagic" = 1, "MovingCharge" = 1)
						HybridStrike=1
						WeaponBreaker=3
						Flicker=3
						Pursuer=3
						SuperDash=2
						SwordPunching=1
						TechniqueMastery=10
						MovementMastery=8
						MartialMagic=1
						MovingCharge=1
						HitSpark='Hit Effect Vampire.dmi'
						HitX=-32
						HitY=-32
						HitTurn=0
						HitSize=1
						StyleActive="Rhythm of War"
						Finisher="/obj/Skills/Queue/Finisher/Death_Rattle"
						verb/Rhythm_of_War_Style()
							set hidden=1
							src.Trigger(usr)

///// WitchCraft
					Witch_Style
						StyleFor = 1.5
						StyleSpd = 1.1
						ElementalClass= "Water"
						StyleActive = "Witch"
						ElementalOffense = "Felfire"
						Finisher = "/obj/Skills/Queue/Finisher/Sundered_Sky"
						passives = list("QuickCast" = 1, "Flow" = 0.5, "MartialMagic" = 1)
						verb/Witch_Style()
							set hidden=1
							src.Trigger(usr)