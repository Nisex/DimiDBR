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
				AngerPoint // set an anger point
				StyleStr=1
				StyleFor=1
				StyleEnd=1
				StyleSpd=1
				StyleOff=1
				StyleDef=1
				Finisher//a text path that links to a queue attack which loads an autonomous buff

//Martial
			NuStyle
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


					// NEW SHIT
					Lucha_Libre_Style

						Copyable = 0
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Red_Cyclone_Style")
						StyleStr=1.35
						StyleEnd=1.35
						StyleOff=1.35
						passives = list("Muscle Power" = 1, "Grippy" = 2, "Scoop" = 1)
						StyleActive="Lucha Libre"
						Finisher="/obj/Skills/Queue/Finisher/Hold"

					Red_Cyclone_Style
						SignatureTechnique=1
						Copyable=0
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Ubermensch_Style")
						StyleStr=1.5
						StyleEnd=1.5
						passives = list("Muscle Power" = 2, "Grippy" = 4, "Scoop" = 2, "Iron Grip" = 1)
						StyleActive="Red Cyclone"
						Finisher="/obj/Skills/Queue/Finisher/Leg_Grab"

					Ubermensch_Style
						SignatureTechnique=2
						Copyable=0
						StyleEnd=1.5
						StyleStr=1.5
						passives = list("Muscle Power" = 4, "Grippy" = 5, "Scoop" = 2, "Iron Grip" = 1, "DeathField" = 3)
						StyleActive="Ubermensch"
						Finisher="/obj/Skills/Queue/Finisher/Command_Grab"


					Murim_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/FreeStyle/Shield_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wushu_Style")
						StyleStr=1.2
						StyleEnd=1.25
						StyleSpd=1.2
						StyleOff=1.2
						StyleDef=1.2
						passives = list("Hardening" = 1)
						StyleActive="Heavenly"
						Finisher="/obj/Skills/Queue/Finisher/Heavenly_Storm_Dragon_Emergence"
						verb/Murim_Style()
							set hidden=1
							src.Trigger(usr)

					Turtle_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Crane_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Gentle_Fist_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Cat_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style")
						StyleStr=1.35
						StyleEnd=1.35
						StyleFor=1.35
						StyleActive="Turtle"
						Finisher="/obj/Skills/Queue/Finisher/Iron_Fortress"
						verb/Turtle_Style()
							set hidden=1
							src.Trigger(usr)
					Crane_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Gentle_Fist_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Snake_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Lightning_Kickboxing_Style")
						StyleEnd=1.35
						StyleFor=1.35
						StyleSpd=1.35
						StyleActive="Crane"
						Finisher="/obj/Skills/Queue/Finisher/Fire_Dancer"
						verb/Crane_Style()
							set hidden=1
							src.Trigger(usr)
					Snake_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Crane_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Lightning_Kickboxing_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Cat_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style")
						StyleStr=1.35
						StyleFor=1.35
						StyleSpd=1.35
						StyleActive="Snake"
						Finisher="/obj/Skills/Queue/Finisher/Dragon_Falls"
						verb/Snake_Style()
							set hidden=1
							src.Trigger(usr)
					Cat_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Turtle_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Snake_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style")
						StyleStr=1.35
						StyleEnd=1.35
						StyleSpd=1.35
						StyleActive="Cat"
						Finisher="/obj/Skills/Queue/Finisher/Hungry_Fang"
						verb/Cat_Style()
							set hidden=1
							src.Trigger(usr)

					Earth_Style
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Water_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tranquil_Dove_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wind_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style")
						StyleStr=1.2
						StyleEnd=1.3
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
						StyleFor=1.2
						StyleSpd=1.3
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
						StyleFor=1.3
						StyleSpd=1.2
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
						StyleStr=1.3
						StyleEnd=1.2
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
					Wushu_Style
						SignatureTechnique=1
						Copyable=0
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Divine_Arts_of_The_Heavenly_Demon", \
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Iron_Fist_Style")
						StyleStr=1.25
						StyleEnd=1.25
						StyleOff=1.25
						StyleDef=1.25
						passives = list("Hardening" = 1, "Deflection" = 0.5, "UnarmedDamage" = 1, "CounterMaster" = 1, "Momentum" = 0.5, "Pressure" = 1)
						StyleActive="Heavenly Dragon Stance"
						Finisher="/obj/Skills/Queue/Finisher/Heavenly_Dragons_Omniscient_Surge"
						verb/Wushu_Style()
							set hidden=1
							src.Trigger(usr)


					Divine_Arts_of_The_Heavenly_Demon
						// to stop runtimes
						SignatureTechnique=2
						Copyable=0
						passives = list("Hardening" = 1.5, "Deflection" = 1, "UnarmedDamage" = 1.5, "CounterMaster" = 3, "Momentum" = 1, "Pressure" = 2, "SwordPunching" = 1, "NeedsSword" = 0, "NoSword" = 1)
						NeedsSword=0
						NoSword=1
						SwordPunching=1
						StyleStr=1.25
						StyleEnd=1.5
						StyleOff=1.25
						StyleActive="Divine Arts of The Heavenly Demon"
						Finisher="/obj/Skills/Queue/Finisher/Divine_Finisher"
						verb/Divine_Arts_of_The_Heavenly_Demon_Style()
							set hidden=1
							src.Trigger(usr)

					Iron_Fist_Style
						passives = list("Deflection" = 2, "UnarmedDamage" = 2, "HardStyle" = 2, "HeavyHitter"= 0.5)
						StyleStr=1.75
						StyleOff=1.25
						SignatureTechnique=2
						Copyable=0
						StyleActive="Iron Fist Style"
						Finisher="/obj/Skills/Queue/Finisher/Chi_Punch"
						verb/Iron_Fist_Style()
							set hidden=1
							src.Trigger(usr)
					Black_Leg_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.25
						StyleEnd=1.5
						StyleSpd=1.25
						StyleActive="Black Leg"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Golden_Kirin_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Sunlit_Sky_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Devil_Leg_Style")
						passives = list("UnarmedDamage" = 1, "BlurringStrikes" = 1, "Instinct" = 1)
						UnarmedDamage=1
						Finisher="/obj/Skills/Queue/Finisher/Mouton_Shot"
						verb/Black_Leg_Style()
							set hidden=1
							src.Trigger(usr)
					Strong_Fist_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.5
						StyleEnd=1.5
						StyleActive="Strong Fist"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Golden_Kirin_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tranquil_Dove_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Dire_Wolf_Style")
						passives = list("HardStyle" = 1, "HeavyHitter" = 0.25, "Instinct" = 1, "UnarmedDamage" = 1)
						HardStyle=1
						HeavyHitter=0.15
						Finisher="/obj/Skills/Queue/Finisher/Rising_Wind"
						verb/Strong_Fist_Style()
							set hidden=1
							src.Trigger(usr)
					Gentle_Fist_Style
						SignatureTechnique=1
						Copyable=0

						StyleEnd=1.25
						StyleFor=1.25
						StyleSpd=1.5
						StyleActive="Gentle Fist"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Lightning_Kickboxing_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Drunken_Fist_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Flow_Reversal_Style")
						passives = list("SoftStyle" = 1, "UnarmedDamage" = 1, "Siphon" = 1)
						SoftStyle=1
						Finisher="/obj/Skills/Queue/Finisher/Eight_Trigrams"
						verb/Gentle_Fist_Style()
							set hidden=1
							src.Trigger(usr)
					Lightning_Kickboxing_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.5
						StyleFor=1.5
						StyleActive="Lightning Kickboxing"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Gentle_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Drunken_Fist_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Inverse_Poison_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Phage_Style")
						passives = list("SpiritHand" = 1, "TechniqueMastery" = 2, "UnarmedDamage" = 1)
						Finisher="/obj/Skills/Queue/Finisher/Rolling_Sobat"
						verb/Lightning_Kickboxing_Style()
							set hidden=1
							src.Trigger(usr)

					Circuit_Breaker_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.25
						StyleEnd=1.25
						StyleFor=1.25
						StyleSpd=1.25
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
					Inverse_Poison_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.25
						StyleEnd=1.25
						StyleFor=1.25
						StyleSpd=1.25
						NoStaff = 0
						ElementalClass=list("Fire", "Water", "Poison")
						passives = list("PureDamage" = 2, "Toxic" = 1)
						StyleActive="Inverse Poison"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Circuit_Breaker_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Entropy_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Lightning_Kickboxing_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Phage_Style")
						ElementalOffense="Poison"
						IconLock='Toxic Arms.dmi'
						LockX=0
						LockY=0
						Finisher="/obj/Skills/Queue/Finisher/Badlands"
						verb/Inverse_Poison_Style()
							set hidden=1
							src.Trigger(usr)
					Sunlit_Sky_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.15
						StyleEnd=1.15
						StyleFor=1.35
						StyleSpd=1.35
						ElementalClass=list("Fire", "Wind")
						StyleActive="Sunlight"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Tranquil_Dove_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Moonlit_Lake_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Black_Leg_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Devil_Leg_Style")
						passives = list("SpiritHand" = 2, "SpiritFlow" = 0.5)
						NoStaff = 0
						SpiritHand=1
						HitSpark='fevExplosion.dmi'
						HitX=-32
						HitY=-32
						HitSize=0.5
						ElementalOffense="Fire"
						ElementalDefense="Wind"
						Finisher="/obj/Skills/Queue/Finisher/Crimson_Star_Road"
						verb/Sunlit_Sky_Style()
							set hidden=1
							src.Trigger(usr)
					Tranquil_Dove_Style
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.3
						StyleEnd=1.2
						StyleFor=1.2
						StyleSpd=1.3
						NoStaff = 0
						ElementalClass=list("Water", "Earth")
						passives = list("StableBP" = 0.5, "Hardening" = 1, "SpiritHand" = 1)
						StyleActive="Tranquil Dove"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Sunlit_Sky_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Moonlit_Lake_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Strong_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Dire_Wolf_Style")
						ElementalOffense="Water"
						ElementalDefense="Earth"
						Finisher="/obj/Skills/Queue/Finisher/Surprise_Rose"
						verb/Tranquil_Dove_Style()
							set hidden=1
							src.Trigger(usr)
						//Signature Styles T2
					Drunken_Fist_Style
						SignatureTechnique=2
						Copyable=0
						StyleEnd=1.5
						StyleDef=1.5
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
					Golden_Kirin_Style
						SignatureTechnique=2
						Copyable=0
						StyleStr=1.5
						StyleEnd=1.5
						passives = list("UnarmedDamage" = 2, "HardStyle" = 2, "HeavyHitter" = 0.5, "Flicker" = 1, "FluidForm" = 1)
						UnarmedDamage=2.5
						HardStyle=2
						HeavyHitter = 0.5
						Flicker=1
						FluidForm=1
						StyleActive="Golden Kirin"

						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Drunken_Fist_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/North_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Galactica_Phantom"
						verb/Golden_Kirin_Style()
							set hidden=1
							src.Trigger(usr)
					Dire_Wolf_Style
						SignatureTechnique=2
						Copyable=0

						StyleStr=1.2
						StyleEnd=1.3
						StyleFor=1.3
						StyleSpd=1.2
						ElementalClass=list("Water", "Earth")
						StyleActive="Dire Wolf"
						passives=list("Hardening" = 2, "SpiritHand" = 2,)
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Devil_Leg_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Imperial_Style")
						ElementalOffense="Earth"
						ElementalDefense="Earth"
						Finisher="/obj/Skills/Queue/Finisher/Spiral_Fang"
						verb/Dire_Wolf_Style()
							set hidden=1
							src.Trigger(usr)
					Moonlit_Lake_Style
						SignatureTechnique=2
						Copyable=0

						StyleStr=1.35
						StyleEnd=1.35
						StyleFor=1.15
						StyleSpd=1.15
						ElementalClass=list("Fire", "Wind", "Earth", "Water")
						StyleActive="Moonlight"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Entropy_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Atomic_Karate_Style")
						passives = list("SpiritFlow" = 1, "SpiritHand" = 2, "Hardening" = 1, "StableBP" = 1)
						NoStaff = 0
						SpiritFlow=1
						SpiritHand=1
						ElementalOffense="Water"
						ElementalDefense="Void"
						Finisher="/obj/Skills/Queue/Finisher/Astral_Shot"
						verb/Moonlit_Lake_Style()
							set hidden=1
							src.Trigger(usr)

					Entropy_Style
						SignatureTechnique=2
						Copyable=0

						StyleSpd=1.5
						StyleOff=1.5
						NoStaff = 0
						ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
						StyleActive="Entropy"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Moonlit_Lake_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Atomic_Karate_Style")
						passives = list("CyberStigma" = 4, "Flow" = 2, "FluidForm" = 1)
						CyberStigma=2
						ElementalOffense="Chaos"
						ElementalDefense="Chaos"
						Finisher="/obj/Skills/Queue/Finisher/Immortal_Change"
						verb/Entropy_Style()
							set hidden=1
							src.Trigger(usr)
					Devil_Leg_Style
						SignatureTechnique=2
						Copyable=0
						StyleStr=1.5
						StyleFor=1.5
						passives = list("SpiritHand" = 2, "DarknessFlame" = 1, "UnarmedDamage" = 2)
						SpiritHand=1
						DarknessFlame=1
						StyleActive="Devil Leg"
						ElementalOffense="Fire"
						ElementalDefense="Poison"
						ElementalClass=list("Fire", "Poison", "Wind")
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Dire_Wolf_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Imperial_Style")
						Finisher="/obj/Skills/Queue/Finisher/Maiden_Masher"
						verb/Devil_Leg_Style()
							set hidden=1
							src.Trigger(usr)
					Flow_Reversal_Style
						SignatureTechnique=2
						Copyable=0
						StyleEnd=1.5
						StyleSpd=1.5
						passives = list("SoftStyle" = 2, "CyberStigma" = 4, "SoulFire" = 4)
						SoftStyle=2
						CyberStigma=2
						ManaSeal=2
						NoStaff = 0
						StyleActive="Flow Reversal"
						ElementalOffense="Earth"
						ElementalDefense="Wind"
						ElementalClass=list("Wind", "Earth")
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Phage_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/East_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Maxima_Press"
						verb/Flow_Reversal_Style()
							set hidden=1
							src.Trigger(usr)
					Phage_Style
						SignatureTechnique=2
						Copyable=0
						StyleDef=1.5
						StyleEnd=1.5
						passives = list("CounterMaster" = 2, "UnarmedDamage" = 2, "VoidField" = 4, "DeathField" = 4)
						CounterMaster=2
						VoidField=2
						DeathField=2
						NoStaff = 0
						StyleActive="Phage"
						ElementalOffense="Poison"
						ElementalDefense="Poison"
						ElementalClass=list("Water", "Fire", "Poison")
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/UnarmedStyle/Flow_Reversal_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/East_Star_Style")
						Finisher="/obj/Skills/Queue/Finisher/Morbid_Angel"
						verb/Phage_Style()
							set hidden=1
							src.Trigger(usr)
					//Signature Styles T3
					North_Star_Style
						SignatureTechnique=3
						Copyable=0
						StyleStr=1.25
						StyleEnd=1.75
						ElementalClass="Earth"
						StyleActive="North Star"
						passives = list("HardStyle" = 3, "SoftStyle" = 3, "UnarmedDamage" = 3, "CounterMaster" = 5)
						HardStyle=3
						SoftStyle=3
						UnarmedDamage=3
						CounterMaster=5
						HitSpark='HitsparkStar.dmi'
						HitX=0
						HitY=0
						HitTurn=0
						Finisher="/obj/Skills/Queue/Finisher/Pressure_Point"
						verb/North_Star_Style()
							set hidden=1
							src.Trigger(usr)
					Imperial_Style
						SignatureTechnique=3
						Copyable=0

						StyleStr=1.5
						StyleFor=1.5
						ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
						ElementalOffense="Void"
						ElementalDefense="Void"
						passives = list("DarknessFlame" = 2, "UnarmedDamage" = 1, "SpiritHand" = 4, "Void" = 1)
						DarknessFlame=2
						UnarmedDamage=1
						SpiritHand=1
						Void=1
						name="Imperial Devil Style"
						StyleActive="Imperial Devil"
						Finisher="/obj/Skills/Queue/Finisher/Imperial_Assessment"
						verb/Imperial_Style()
							set hidden=1
							src.Trigger(usr)
					East_Star_Style
						SignatureTechnique=3
						Copyable=0
						StyleEnd=1.5
						StyleSpd=1.5
						passives = list("SoftStyle" = 3, "SoulFire" = 3, "CyberStigma" = 3, "CounterMaster" = 3, "VoidField" = 10, "DeathField" = 10)
						SoftStyle=3
						ManaSeal=3
						CyberStigma=3
						CounterMaster=3
						VoidField=10
						DeathField=10
						NoStaff = 0
						StyleActive="East Star"
						ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
						Finisher="/obj/Skills/Queue/Finisher/Over_The_Horizon"
						verb/East_Star_Style()
							set hidden=1
							src.Trigger(usr)
					Atomic_Karate_Style
						SignatureTechnique=3
						Copyable=0
						StyleStr=1.5
						StyleFor=1.5
						passives = list("SpiritHand" = 4, "SpiritFlow" = 1, "CyberStigma" = 4, "PureDamage" = 2, "PureReduction" = 2)
						NoStaff = 0
						SpiritHand=1
						SpiritFlow=1
						CyberStigma=3
						ElementalClass=list("Water", "Fire", "Earth", "Wind", "Poison")
						StyleActive="Atomic Karate"
						ElementalOffense="Ultima"
						ElementalDefense="Ultima"
						Finisher="/obj/Skills/Queue/Finisher/Atomic_Split"
						verb/Atomic_Karate_Style()
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
					Gladiator_Style
						// A style that builds into the sword and shield style, disarms your enemy every few seconds
						StyleOff = 1.3
						StyleEnd = 1.5
						StyleDef = 1.2
						StyleActive="Gladiator"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Shield_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield")
						Finisher="/obj/Skills/Queue/Finisher/Challenge"
						verb/Gladiator_Style()
							set hidden=1
							src.Trigger(usr)


					Iaido_Style
						StyleStr=1.3
						StyleEnd=1.2
						StyleSpd=1.5
						StyleActive="Iaido"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Fencing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Dual_Wield_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Swordless_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Secret_Knife_Style")
						Finisher="/obj/Skills/Queue/Finisher/Mist_Finer"
						verb/Iaido_Style()
							set hidden=1
							src.Trigger(usr)
					Fencing_Style
						StyleStr=1.2
						StyleEnd=1.3
						StyleSpd=1.5
						StyleActive="Fencing"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Dual_Wield_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Zornhau_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Kendo_Style")
						Finisher="/obj/Skills/Queue/Finisher/Vicious_Moon"
						verb/Fencing_Style()
							set hidden=1
							src.Trigger(usr)
					Zornhau_Style
						StyleStr=1.5
						StyleEnd=1.3
						StyleSpd=1.2
						StyleActive="Zornhau"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Fencing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Kendo_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Swordless_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style")
						Finisher="/obj/Skills/Queue/Finisher/Soul_Survivor"
						verb/Zornhau_Style()
							set hidden=1
							src.Trigger(usr)
					Swordless_Style
						NeedsSword=0
						NoSword=1
						passives = list("SwordPunching" = 1, "NeedsSword" = 0, "NoSword" = 1)
						SwordPunching=1
						StyleStr=1.5
						StyleEnd=1.2
						StyleSpd=1.3
						StyleActive="Living Weapon"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Zornhau_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style",\
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Iaido_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Secret_Knife_Style")
						Finisher="/obj/Skills/Queue/Finisher/Hammer_Fall"
						verb/Swordless_Style()
							set hidden=1
							src.Trigger(usr)

//Signature Style T1
					Sword_And_Shield
						SignatureTechnique=1
						Copyable=0
						StyleEnd=1.5
						StyleStr=1.25
						StyleSpd=1
						StyleOff=1.25
						StyleActive="Sword And Shield"
						passives = list("Hardening" = 1, "Deflection" = 0.5)
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Phalanx_Style",\
						"/obj/Skills/Buffs/NuStyle/UnarmedStyle/Wushu_Style"="/obj/Skills/Buffs/NuStyle/UnarmedStyle/Divine_Arts_of_The_Heavenly_Demon")
						Finisher="/obj/Skills/Queue/Finisher/Behemoth_Typhoon"
					Dual_Wield_Style//iaido + fencing
						SignatureTechnique=1
						NeedsSecondSword=1
						Copyable=0
						StyleStr=1.4
						StyleOff=1.2
						StyleSpd=1.4
						StyleActive="Dual Wield"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Secret_Knife_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Trinity_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Soul_Crushing_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Arcane_Bladework_Style")
						passives = list("DoubleStrike" = 1, "NeedsSecondSword" = 1)
						DoubleStrike=1
						Finisher="/obj/Skills/Queue/Finisher/Geo_de_Ray"
						verb/Dual_Wield_Style()
							set hidden=1
							src.Trigger(usr)
					Kendo_Style//fencing + zornhau
						SignatureTechnique=1
						Copyable=0

						StyleStr=1.35
						StyleEnd=1.35
						StyleSpd=1.35
						StyleActive="Kendo"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Champloo_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Butcher_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Spirit_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Battle_Mage_Style")
						Finisher="/obj/Skills/Queue/Finisher/Ichimonji"
						verb/Kendo_Style()
							set hidden=1
							src.Trigger(usr)
					Secret_Knife_Style// iaido + swordless
						SignatureTechnique=1
						Copyable=0
						passives = list("SwordPunching" = 1)
						SwordPunching=1
						StyleStr=1.2
						StyleEnd=1.4
						StyleSpd=1.4
						NeedsSword=0
						StyleActive="Secret Knife"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Dual_Wield_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Trinity_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Resonance_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Blade_Singing_Style")
						Finisher="/obj/Skills/Queue/Finisher/Flying_Barcelona"
						verb/Secret_Knife_Style()
							set hidden=1
							src.Trigger(usr)
					Champloo_Style//swordless + zornhau
						SignatureTechnique=1
						Copyable=0
						NeedsSword=0
						passives = list("SwordPunching" = 1, "NeedsSword" = 0, "Shearing" = 1.5)
						SwordPunching=1
						StyleStr=1.5
						StyleEnd=1.25
						StyleSpd=1.25
						StyleActive="Champloo"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Kendo_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Butcher_Style",\
						"/obj/Skills/Buffs/NuStyle/FreeStyle/Yin_Yang_Style"="/obj/Skills/Buffs/NuStyle/FreeStyle/Shaolin_Style")
						Finisher="/obj/Skills/Queue/Finisher/Manji_Flip"
						verb/Champloo_Style()
							set hidden=1
							src.Trigger(usr)

//Signature Style T2
					Phalanx_Style
						SignatureTechnique=2
						Copyable=0
						StyleOff=1.25
						StyleStr=1.25
						StyleEnd=1.5
						StyleActive="Phalanx Style"
						SwordPunching = 1
						NoSword = 1
						NeedsSword = 0 
						passives = list("Reversal" = 0.25, "Deflection" = 1, "Hardening" = 1.5, "SwordPunching" = 1, "Shearing" = 3, "Unnerve" = 1)
						Finisher="/obj/Skills/Queue/Finisher/Shield_Vault"


					Trinity_Style
						SignatureTechnique=2
						NeedsThirdSword=1
						Copyable=0

						StyleStr=1.5
						StyleSpd=1.5
						StyleActive="Trinity"
						passives = list("SweepingStrike" = 1, "DoubleStrike" = 2, "TripleStrike" = 0.5, "NeedsThirdSword" = 1)
						DoubleStrike=2
						TripleStrike=0.5
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Butcher_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Five_Rings_Style")
						Finisher="/obj/Skills/Queue/Finisher/Ogre_Cutter"
						verb/Trinity_Style()
							set hidden=1
							src.Trigger(usr)
					Butcher_Style
						SignatureTechnique=2
						Copyable=0

						StyleStr=1.5
						StyleSpd=1.5
						StyleActive="Butcher"
						NeedsSword=0
						SwordPunching=1
						passives = list("Shearing" = 6, "SlayerMod" = 2, "SwordPunching" = 1, "NeedsSword" = 0)
						Shearing=2
						SlayerMod=2.5
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Trinity_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Five_Rings_Style")
						Finisher="/obj/Skills/Queue/Finisher/Crimson_Fountain"
						verb/Butcher_Style()
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
					Shield_Style
						StyleEnd=1.5
						StyleDef=1.5
						StyleSpd=0.8
						StyleStr=1.2
						StyleActive="Shield"
						StyleComboUnlock=list("/obj/Skills/Buffs/NuStyle/SwordStyle/Gladiator_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_And_Shield")
						passives = list("Hardening" = 1)
						Finisher="/obj/Skills/Queue/Finisher/Shield_Bash"
						verb/Shield_Style()
							set hidden = 1
							src.Trigger(usr)

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
						"/obj/Skills/Buffs/NuStyle/SwordStyle/Dual_Wield_Style"="/obj/Skills/Buffs/NuStyle/SwordStyle/Arcane_Bladework_Style")
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
						passives = list("IdealStrike" = 1, "HybridStrike" = 1, "WeaponBreaker" = 3, "Flicker" = 3, "Pursuer" = 3, "SuperDash" = 2, "SwordPunching" = 1, "TechniqueMastery" = 10, "MovementMastery" = 8, "MartialMagic" = 1, "MovingCharge" = 1)
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
						StyleStr = 1.3
						StyleFor = 1.3
						StyleSpd = 1.1
						StyleDef = 1.1
						ElementalClass= "Water" 
						StyleActive = "Witch"
						ElementalOffense = "Felfire"
						Finisher = "/obj/Skills/Queue/Finisher/Sundered_Sky"
						verb/Witch_Style()
							set hidden=1
							src.Trigger(usr)