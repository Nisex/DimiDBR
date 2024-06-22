#define ASCENSION_ONE_POTENTIAL 10
#define ASCENSION_TWO_POTENTIAL 30
#define ASCENSION_THREE_POTENTIAL 55
#define ASCENSION_FOUR_POTENTIAL 75
#define ASCENSION_FIVE_POTENTIAL 90
ascension
	var
		powerAdd = 0
		strength = 0
		endurance = 0
		force = 0
		offense = 0
		defense = 0
		speed = 0
		recovery = 0
		learning = 0
		intelligenceAdd = 0
		imaginationAdd = 0
		anger = 0
		unlock_potential = 1
		intimidation = 0
		intimidationMult = 1
		pilotingProwess = 0
		cyberizeModAdd = 0
		enhanceChips = 0
		rppAdd = 0
		ecoAdd = 0

		angerPoint
		new_anger_message

		list/skills = list()
		list/passives = list()

		choiceTitle = "Ascension Selection"
		choiceMessage = ""
		list/choices = list()
		ascension/choiceSelected
		tmp/pickingChoice = FALSE

		on_ascension_message

		applied = FALSE

	proc
		revertAscension(mob/owner)
			if(!applied || pickingChoice) return

			owner.PotentialRate -= powerAdd
			owner.StrAscension -= strength
			owner.EndAscension -= endurance
			owner.ForAscension -= force
			owner.OffAscension -= offense
			owner.DefAscension -= defense
			owner.SpdAscension -= speed
			owner.RecovAscension -=  recovery

			if(skills.len > 0)
				for(var/obj/Skills/added_skill in skills)
					if(!locate(added_skill,owner)) continue
					owner.DeleteSkill(new added_skill)

			if(passives.len > 0)
				owner.passive_handler.decreaseList(passives)

			if(angerPoint)
				owner.AngerPoint -= angerPoint

			if(new_anger_message)
				if(owner.race.ascensions[owner.AscensionsAcquired-1].new_anger_message)
					owner.AngerMessage = owner.race.ascensions[owner.AscensionsAcquired-1].new_anger_message
				else
					owner.AngerMessage = "becomes angry!"

			if(anger != 0)
				owner.NewAnger(owner.AngerMax-anger)

			owner.Intimidation -= intimidation
			owner.Intimidation /= intimidationMult

			owner.Intelligence -= intelligenceAdd
			owner.Imagination -= imaginationAdd

			owner.CyberizeMod -= cyberizeModAdd

			owner.RPPMult -= rppAdd
			owner.EconomyMult -= ecoAdd
			owner.PilotingProwess -= pilotingProwess
			owner.EnhanceChipsMax -= enhanceChips
			owner.AscensionsAcquired-=1

			if(choiceSelected)
				var/ascension/choiceAsc = choiceSelected
				choiceAsc.revertAscension(owner)
				choiceSelected = null

			owner.SetCyberCancel()

			applied = FALSE

		onAscension(mob/owner)
			. = TRUE
			if(applied || pickingChoice) return FALSE
			choiceSelection(owner)
			if(choices && choices.len > 0 && !choiceSelected) return FALSE
			applied = TRUE

			owner.PotentialRate += powerAdd
			owner.StrAscension += strength
			owner.EndAscension += endurance
			owner.ForAscension += force
			owner.OffAscension += offense
			owner.DefAscension += defense
			owner.SpdAscension += speed
			owner.RecovAscension +=  recovery

			if(skills.len > 0)
				for(var/added_skill in skills)
					if(locate(added_skill,owner)) continue
					owner.AddSkill(new added_skill)

			if(passives.len > 0)
				owner.passive_handler.increaseList(passives)

			if(angerPoint)
				owner.AngerPoint += angerPoint

			if(new_anger_message)
				owner.AngerMessage = new_anger_message

			if(anger != 0)
				owner.NewAnger(owner.AngerMax+anger)

			owner.Intimidation += intimidation
			owner.IntimidationMult += intimidationMult

			owner.Intelligence += intelligenceAdd
			owner.Imagination += imaginationAdd

			owner.CyberizeMod += cyberizeModAdd

			owner.RPPMult += rppAdd
			owner.EconomyMult += ecoAdd
			owner.PilotingProwess += pilotingProwess
			owner.EnhanceChipsMax += enhanceChips

			if(!istype(src, /ascension/sub_ascension))
				owner.AscensionsAcquired+=1

			if(choiceSelected)
				var/ascension/choiceAsc = new choiceSelected
				choiceAsc.onAscension(owner)

			owner.SetCyberCancel()

			owner << on_ascension_message

		choiceSelection(mob/owner)
			if(!choices) return
			if(choices.len == 0 || choiceSelected || pickingChoice) return
			pickingChoice = TRUE
			var/selected = input(owner, choiceMessage, choiceTitle) in choices
			choiceSelected = choices[selected]
			pickingChoice = FALSE

		checkAscensionUnlock(mob/target,potential)
			if(target.AscensionsUnlocked > target.AscensionsAcquired) return 1
			if(unlock_potential==-1 || applied) return 0
			if(potential >= unlock_potential)
				return 1
			return 0

	human
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			anger = 0.1
			passives = list("Desperation" = 1.5, "Adrenaline" = 1, "TechniqueMastery" = -1, "Underdog" = 1)
			new_anger_message = "grows desperate!"
			on_ascension_message = "You learn the meaning of desperation..."
			choices = list("Technology" = /ascension/sub_ascension/human/technology, "Fighting" = /ascension/sub_ascension/human/fighting)

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("Desperation" = 1, "Adrenaline" = 1, "TechniqueMastery" = -1)
			anger = 0.1
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			new_anger_message = "grows determined!"
			on_ascension_message = "You learn the meaning of responsibility..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["DemonicDurability"] = 1
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 1
					cyberizeModAdd = 0.2
					pilotingProwess = 1.5
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list("Desperation" = 1.5, "Underdog" = 1)
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			anger = 0.1
			new_anger_message="grows confident!"
			on_ascension_message = "You learn the meaning of confidence..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["DemonicDurability"] = 0.5
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 1
					cyberizeModAdd = 0.1
					pilotingProwess = 1.5
				..()

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list("Desperation" = 1.5, "Underdog" = 1)
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			anger = 0.1
			new_anger_message = "gains absolute clarity!"
			on_ascension_message = "You learn the meaning of competence..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["DemonicDurability"] = 0.5
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 1
					cyberizeModAdd = 0.1
					pilotingProwess = 1.5
				..()

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list("Desperation" = 1.5, "TechniqueMastery" = -1.5)
			strength = 1
			endurance = 1
			force = 1
			offense = 1
			defense = 1
			speed = 1
			anger = 0.2
			new_anger_message = "becomes angry!"
			on_ascension_message = "You learn the meaning of humanity..."

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/fighting)
					passives["StableBP"] = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/human/technology)
					enhanceChips = 2
					cyberizeModAdd = 0.1
					pilotingProwess = 1.5
				..()

	yokai
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			passives = list("TechniqueMastery" = 1)
			strength = 0.25
			force = 0.25
			offense = 0.25
			choices = list("Genius" = /ascension/sub_ascension/yokai/genius, "Grand Caster" = /ascension/sub_ascension/yokai/grand_caster, "Two become One" = /ascension/sub_ascension/yokai/two_become_one)

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			strength = 0.25
			force = 0.25
			offense = 0.25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/genius)
					cyberizeModAdd = 0.25
					enhanceChips = 1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/grand_caster)
					passives["ManaGeneration"] = 1
					passives["QuickCast"] = 1
					passives["ManaCapMult"] = 0.25
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/two_become_one)
					passives = list("MovementMastery" = 2, "ManaStats" = 0.5)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form/sf in owner.contents)
						sf.passives["TechniqueMastery"] = 1
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			strength = 0.25
			force = 0.25
			offense = 0.25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/genius)
					cyberizeModAdd = 0.25
					ecoAdd = 0.5
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/grand_caster)
					passives["ManaGeneration"] = 1
					passives["QuickCast"] = 1
					passives["ManaCapMult"] = 0.25
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/two_become_one)
					passives = list("MovementMastery" = 2, "ManaStats" = 0.25)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form/sf in owner.contents)
						sf.passives["TechniqueMastery"] = 2
				..()

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			strength = 0.25
			force = 0.25
			endurance = 0.25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/genius)
					enhanceChips = 2
					ecoAdd = 0.5
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/grand_caster)
					passives["SpiritStrike"] = 0.25
					passives["ManaCapMult"] = 0.25
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/two_become_one)
					passives = list("MovementMastery" = 2, "ManaStats" = 0.25)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form/sf in owner.contents)
						sf.ManaDrain -= 0.05
				..()

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			strength = 0.25
			force = 0.25
			endurance = 0.25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/genius)
					ecoAdd = 0.5
					enhanceChips = 2
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/grand_caster)
					passives["SpiritStrike"] = 0.75
					passives["ManaCapMult"] = 0.25
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/yokai/two_become_one)
					passives = list("MovementMastery" = 2, "ManaStats" = 0.5)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form/sf in owner.contents)
						sf.ManaDrain = 0
				..()


	eldritch
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			endurance = 0.25
			defense = 0.25
			speed = 0.25
			passives = list("DebuffImmune" = 0.25, "VenomResistance" = 0.25, "SoulFire" = 0.15, "DeathField" = 0.15, "VoidField" = 0.15, "PureReduction" = 1)
			onAscension(mob/owner)
				owner.secretDatum.tierUp(2, owner)
				..()
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			endurance = 0.25
			defense = 0.25
			speed = 0.25
			passives = list("DebuffImmune" = 0.25, "VenomResistance" = 0.25, "Void" = 1, "SoulFire" = 0.15, "DeathField" = 0.15, "VoidField" = 0.15, "PureReduction" = 1)
			onAscension(mob/owner)
				owner.secretDatum.tierUp(3, owner)
				..()
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			passives = list("DebuffImmune" = 0.25, "VenomResistance" = 0.5, "Void" = 1, "SoulFire" = 0.15, "DeathField" = 0.15, "VoidField" = 0.15, "PureReduction" = 1)
			onAscension(mob/owner)
				owner.secretDatum.tierUp(4, owner)
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			passives = list("DebuffImmune" = 0.25, "VenomResistance" = 0.5, "Void" = 1, "SoulFire" = 0.15, "DeathField" = 0.15, "VoidField" = 0.15, "PureReduction" = 1)
			onAscension(mob/owner)
				owner.secretDatum.tierUp(5, owner)
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			passives = list("DebuffImmune" = 0.25, "VenomResistance" = 0.5, "Void" = 1, "SoulFire" = 0.15, "DeathField" = 0.15, "VoidField" = 0.15, "PureReduction" = 1)
			onAscension(mob/owner)
				owner.secretDatum.tierUp(6, owner)
				..()
	high_faoroan
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			intimidation = 5
			passives = list("ManaCapMult" = 0.25, "Deicide" = 1, "Xenobiology" = 1, "SpiritFlow" = 0.25)
			choices = list("Distort" = /ascension/sub_ascension/high_faoroan/distort, "Define" = /ascension/sub_ascension/high_faoroan/define)

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			strength = 0.25
			endurance = 0.25
			force = 0.25
			offense = 0.25
			defense = 0.25
			speed = 0.25
			anger = 0.15
			passives = list("TechniqueMastery" = 1.5, "ManaCapMult" = 0.25, "Deicide" = 1)
			choices = list("Destroy" = /ascension/sub_ascension/high_faoroan/destroy, "Remove" = /ascension/sub_ascension/high_faoroan/remove)

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			passives = list("ManaCapMult" = 0.25, "Deicide" = 1, "Xenobiology" = 1)
			intimidation = 10
			onAscension(mob/owner)
				..()
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/high_faoroan/distort)
					owner.AddSkill(new/obj/Skills/AutoHit/Myriad_Truths)
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/high_faoroan/define)
					owner.AddSkill(new/obj/Skills/AutoHit/Devils_Advocate)

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			intimidation = 10
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			passives = list("ManaCapMult" = 0.25, "Deicide" = 2, "Xenobiology" = 1)
			choices = list("Conquer" = /ascension/sub_ascension/high_faoroan/conquer, "Obliterate" = /ascension/sub_ascension/high_faoroan/obliterate)

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			intimidation = 10
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			passives = list("Deicide" = 2, "Xenobiology" = 1)
			choices = list("Rest" = /ascension/sub_ascension/high_faoroan/rest, "Sacrifice" = /ascension/sub_ascension/high_faoroan/sacrifice)

	demon
		var/list/trueFormPerAsc = list(1 = list("HellPower" = 0.15, "AngerAdaptiveForce" = 0.25, "TechniqueMastery" = 2), \
									 2 = list("HellPower" = 0.15,"Hellrisen" = 0.25,  "AngerAdaptiveForce" = 0.1, "TechniqueMastery" = 3), \
									3 = list("HellPower" = 0.15, "TechniqueMastery" = 5), \
									4 = list("HellPower" = 0.4, "AngerAdaptiveForce" = 0.3, "Hellrisen" = 0.5, "TechniqueMastery" = 5))
		proc/findTrueForm(mob/p)
			var/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon/d = new()
			d = locate() in p
			if(!d)
				world.log << "There was an error finding [p]'s ture form, please fix as their ascension is likely bugged"
				p << "Please report to the admin or discord that your true form is bugged on asc"
			return d
		onAscension(mob/owner)
			var/result = ..()
			if(result)
				for(var/passive in trueFormPerAsc[owner.AscensionsAcquired])
					findTrueForm(owner).passives[passive] += trueFormPerAsc[owner.AscensionsAcquired][passive]
				owner.demon.selectPassive(owner, "CORRUPTION_PASSIVES", "Buff")
				owner.demon.selectPassive(owner, "CORRUPTION_DEBUFFS", "Debuff")
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			passives = list("HellPower" = 0.1, "AbyssMod" = 0.25, "SpiritPower" = 0.25)
			anger = 0.15
			intimidation = 50
			strength = 0.25
			endurance = 0.25
			speed = 0.25
			onAscension(mob/owner)
				..()
				owner.Class = "B"

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("HellPower" = 0.1, "AbyssMod" = 0.75, "SpiritPower" = 0.25)
			intimidation = 50
			strength = 0.25
			force = 0.5
			defense = 0.25
			offense = 0.25
			anger = 0.1
			onAscension(mob/owner)
				..()
				var/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2/da = owner.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2)
				if(!da.secondDevilArmPick)
					owner.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2).pickSelection(owner, TRUE)
					owner.race?:sub_devil_arm_upgrades = 1
				owner.Class = "A"
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list("HellPower" = 0.1, "AbyssMod" = 1, "SpiritPower" = 0.25)
			anger = 0.2
			intimidation = 100
			strength = 0.25
			force = 0.25
			endurance = 0.5
			onAscension(mob/owner)
				..()
				owner.Class = "S"
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list("HellPower" = 0.1, "AbyssMod" = 2)
			anger = 0.15
			intimidation = 250
			strength = 0.25
			force = 0.25
			defense = 0.75
			offense = 0.75
			endurance = 0.25
			speed = 0.75
			onAscension(mob/owner)
				..()
				owner.Class = "False King"
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list("EndlessAnger" = 1, "SpiritPower" = 0.25)
			intimidation = 250

			onAscension(mob/owner)
				..()
				owner.Class = "Maou"

	beastman
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			angerPoint = 5
			strength = 0.25
			defense = 0.25
			endurance = 0.25
			passives = list("PureReduction" = 1, "Godspeed" = 1)
			onAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 15
					b.TooMuchHealth = 20
					b.AngerMult = 1.3
					b.passives = list("AngerAdaptiveForce" = 0.1, "Brutalize" = 1)
					b.VaizardHealth = 0.5
				..()
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			angerPoint = 5
			strength = 0.25
			speed = 0.25
			endurance = 0.25
			passives = list("PureDamage" = 1, "Flicker" = 1)
			onAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 20
					b.TooMuchHealth = 25
					b.AngerMult = 1.35
					b.passives = list("AngerAdaptiveForce" = 0.2 , "Brutalize" = 1.5)
					b.VaizardHealth = 1
				..()
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			angerPoint = 5
			speed = 0.25
			defense = 0.25
			endurance = 0.25
			passives = list("Pursuer" = 1, "Flicker" = 1)
			onAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 25
					b.TooMuchHealth = 30
					b.AngerMult = 1.4
					b.passives = list("AngerAdaptiveForce" = 0.3, "Void" = 1, "Brutalize" = 2)
					b.VaizardHealth = 1.5
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			angerPoint = 5
			endurance = 0.5
			passives = list("Godspeed" = 1, "PureReduction" = 1)
			onAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 25
					b.TooMuchHealth = 35
					b.AngerMult = 1.45
					b.passives = list("AngerAdaptiveForce" = 0.4, "Void" = 1, "Brutalize" = 2.5)
					b.VaizardHealth = 1.5
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			angerPoint = 5
			strength = 0.5
			endurance = 0.5
			onAscension(mob/owner)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk/b in owner.Buffs)
					b.NeedsHealth = 30
					b.TooMuchHealth = 50
					b.AngerMult = 1.5
					b.passives = list("AngerAdaptiveForce" = 0.5, "Void" = 1, "Brutalize" = 3)
					b.VaizardHealth = 2.0
				..()

	dragon
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			intimidation = 30
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						passives = list("Juggernaut" = 0.5, "Unstoppable" = 0.25, "HeavyHitter" = 0.5, "DeathField" = 0.25)
						strength += 0.25
						endurance += 0.25
						offense += 0.5

					if("Fire")
						angerPoint += 5
						passives = list("MeltyBlood" = 1, "SpiritHand" = 1, "AngerAdaptiveForce" = 0.25)
						strength += 0.25
						force += 0.5
						offense += 0.25

					if("Water")
						passives = list("SoftStyle" = 1, "AbsoluteZero" = 1, "LikeWater" = 2,"Flow" = 1, "Instinct" = 1)
						strength += 0.25
						force += 0.25
						defense += 0.5

						
					if("Wind")
						passives = list("VenomBlood" = 1,"BlurringStrikes" = 0.25, "Flicker" = 1, "Adrenaline" = 2)
						speed += 0.5
						offense += 0.25
						defense += 0.25
					if("Gold")
						passives = list("Blubber" = 0.25, "CashCow" = 1)
						ecoAdd = 2
						endurance += 0.5
						speed += 0.25
				..()

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			intimidation = 20
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						passives = list("Juggernaut" = 0.5, "Unstoppable" = 0.25, "HeavyHitter" = 0.5, "DeathField" = 0.25, "GodKi" = 0.05)
						strength += 0.25
						endurance += 0.25
						defense += 0.25

					if("Fire")
						angerPoint += 5
						passives = list("DemonicDurability" = 0.25, "SpiritHand" = 1, "GodKi" = 0.05)
						strength += 0.25
						force += 0.25
						offense += 0.25
					if("Water")
						passives = list("SoftStyle" = 1, "AbsoluteZero" = 1, "LikeWater" = 2,"Flow" = 1, "Instinct" = 1)
						strength += 0.25
						force += 0.25
						defense += 0.5
					if("Wind")
						passives = list("BlurringStrikes" = 0.25, "Flicker" = 1, "GodKi" = 0.05)
						speed += 0.25
						offense += 0.25
						defense += 0.25
					if("Gold")
						passives = list("Blubber" = 0.25, "CashCow" = 1, "GodKi" = 0.05)
						ecoAdd = 1
						endurance += 0.5
						speed += 0.25
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			intimidation = 40
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						passives = list("Unstoppable" = 0.25, "HeavyHitter" = 1, "DeathField" = 0.5, "GodKi" = 0.05)
						strength += 0.25
						endurance += 0.25
						defense += 0.25

					if("Fire")
						angerPoint += 5
						passives = list("DemonicDurability" = 0.25, "SpiritHand" = 1, "GodKi" = 0.05)
						strength += 0.25
						force += 0.25
						offense += 0.25
					 if("Water")
						passives = list("SoftStyle" = 1, "FluidForm" = 1, "GodKi" = 0.05, "Flow" = 1)
						strength += 0.25
						force += 0.25
						defense += 0.25
					if("Wind")
						passives = list("BlurringStrikes" = 0.25, "Flicker" = 1, "GodKi" = 0.05)
						speed += 0.25
						offense += 0.25
						defense += 0.25
					if("Gold")
						passives = list("Blubber" = 0.25, "CashCow" = 1, "GodKi" = 0.05)
						ecoAdd = 1
						endurance += 0.5
						speed += 0.25
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						passives = list("Unstoppable" = 0.25, "HeavyHitter" = 0.5, "DeathField" = 0.25, "GodKi" = 0.05)
						strength += 0.25
						endurance += 0.25
						defense += 0.25

					if("Fire")
						angerPoint += 5
						passives = list("DemonicDurability" = 0.25, "SpiritHand" = 1, "GodKi" = 0.05)
						strength += 0.25
						force += 0.25
						offense += 0.25
					if("Water")
						passives = list("GodKi" = 0.05, "CalmAnger" = 1, "FluidForm" = 1, "SoftStyle" = 1)
						strength += 0.25
						force += 0.25
						defense += 0.25
					if("Wind")
						passives = list("BlurringStrikes" = 0.25, "Flicker" = 1, "GodKi" = 0.05)
						speed += 0.25
						offense += 0.25
						defense += 0.25
					if("Gold")
						passives = list("Blubber" = 0.25, "CashCow" = 1, "GodKi" = 0.05)
						ecoAdd = 1
						endurance += 0.5
						speed += 0.25
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						passives = list("Unstoppable" = 0.25, "HeavyHitter" = 0.5, "DeathField" = 0.25, "GodKi" = 0.05)
						strength += 0.25
						endurance += 0.25
						defense += 0.25

					if("Fire")
						angerPoint += 5
						passives = list("DemonicDurability" = 0.25, "SpiritHand" = 1, "GodKi" = 0.05)
						strength += 0.25
						force += 0.25
						offense += 0.25

					if("Water")
						passives = list("FluidForm" = 1, "SoftStyle" = 1, "Flow" = 1, "GodKi" = 0.05)
						strength += 0.25
						force += 0.25
						defense += 0.25


					if("Wind")
						passives = list("BlurringStrikes" = 0.25, "Flicker" = 1, "GodKi" = 0.05)
						speed += 0.25
						offense += 0.25
						defense += 0.25
					if("Gold")
						passives = list("Blubber" = 0.25, "CashCow" = 1, "GodKi" = 0.05)
						ecoAdd = 1
						endurance += 0.5
						speed += 0.25
				..()
	makyo
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			passives = list("Juggernaut" = 0.25, "DemonicDurability" = 1, "HeavyHitter" = 0.25)
			strength = 0.25
			endurance = 0.25
			offense = 0.25
			intimidation = 25

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("Juggernaut" = 0.25, "DemonicDurability" = 0.5, "HeavyHitter" = 0.25)
			strength = 0.25
			endurance = 0.25
			force = 0.25
			intimidation = 75
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list("Juggernaut" = 0.5, "DemonicDurability" = 0.5, "HeavyHitter" = 0.5)
			strength = 0.5
			endurance = 0.25
			force = 0.5
			intimidation = 50
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list("Juggernaut" = 0.5, "DemonicDurability" = 0.5, "HeavyHitter" = 1)
			strength = 0.5
			endurance = 0.25
			force = 0.5
			intimidation = 25
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list("Juggernaut" = 0.5, "DemonicDurability" = 0.5, "HeavyHitter" = 2)
			strength = 1
			endurance = 0.25
			force = 1
			intimidation = 25

	alien
		proc
			AlienStatIncrease()
				var/choicesLeft = 3
				while(choicesLeft)
					switch(input(usr, "Your body begins to mutate in novel ways...", "Each step...") in list("Strength", "Endurance", "Speed", "Offense", "Defense", "Force"))
						if("Strength")
							strength += 0.25
						if("Endurance")
							endurance += 0.25
						if("Speed")
							speed += 0.25
						if("Offense")
							offense += 0.25
						if("Defense")
							defense +=0.25
						if("Force")
							force += 0.25
					choicesLeft--

		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			onAscension(mob/owner)
				if(applied || pickingChoice) return
				AlienStatIncrease(owner)
				..()

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			onAscension(mob/owner)
				if(applied || pickingChoice) return
				AlienStatIncrease(owner)
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			onAscension(mob/owner)
				if(applied || pickingChoice) return
				AlienStatIncrease(owner)
				..()

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			onAscension(mob/owner)
				if(applied || pickingChoice) return
				AlienStatIncrease(owner)
				..()

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			onAscension(mob/owner)
				if(applied || pickingChoice) return
				AlienStatIncrease(owner)
				..()

	saiyan
		one
			unlock_potential = 10
			choices = list("Pride" = /ascension/sub_ascension/saiyan/pride, "Honor" =  /ascension/sub_ascension/saiyan/honor, "Zeal" = /ascension/sub_ascension/saiyan/zeal)
			intimidation = 25
			passives = list("Brutalize" = 0.25)
			// GIVE MY NIGGAS SOMETHING TO EAT WITH
			strength = 0.25
			offense = 0.25
			endurance = 0.25
		two
			unlock_potential = 25
			anger = 0.25
			intimidation = 25
			passives = list("Brutalize" = 0.5)
			strength = 0.25
			defense = 0.25
			endurance = 0.25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/zeal)
					passives = list("Adaptation" = 0.5)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/honor)
					passives = list("AngerAdaptiveForce" = 0.2, "Adrenaline" = 1)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/pride)
					passives = list("Steady" = 1)
				..()
		three
			unlock_potential = 40
			intimidation = 25
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/zeal)
					passives = list("Adaptation" = 0.5)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/honor)
					passives = list("AngerAdaptiveForce" = 0.2, "Adrenaline" = 1)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/pride)
					passives = list("Steady" = 1)
				..()
		four
			unlock_potential = 60
			intimidation = 25
			anger = 0.25
			passives = list("Brutalize" = 1)
			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/zeal)
					passives = list("Adaptation" = 0.5)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/honor)
					passives = list("AngerAdaptiveForce" = 0.2, "Adrenaline" = 1)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/saiyan/pride)
					passives = list("Steady" = 1)
				..()
	majin
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			choices = list("Innocence" = /ascension/sub_ascension/majin/innocence, "Super" = /ascension/sub_ascension/majin/super, "Unhinged" = /ascension/sub_ascension/majin/unhinged)
			anger = 0.1
			intimidation = 15
			imaginationAdd = 0.2

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
			intimidation = 15
			anger = 0.1
			imaginationAdd = 0.25

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/innocence)
					endurance = 0.1
					defense = 0.1
					strength = 0.05
					speed = -0.05
					passives = list("Blubber" = 0.5, "CallousedHands" = 0.15)
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/super)
					strength = 0.1
					endurance = 0.1
					defense = 0.1
					speed = 0.1
					force = 0.1
					offense = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/unhinged)
					strength = 0.15
					defense = -0.1
					force = 0.15
					endurance = -0.1
					passives = list("UnhingedForm" = 0.25)
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
			intimidationMult = 0.5
			anger = 0.1

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/innocence)
					endurance = 0.25
					defense = 0.15
					strength = 0.15
					passives = list("Blubber" = 1, "CallousedHands" = 0.15)
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/super)
					strength = 0.25
					endurance = 0.25
					defense = 0.25
					speed = 0.25
					force = 0.25
					offense = 0.25
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/unhinged)
					strength = 0.15
					defense = -0.1
					force = 0.15
					endurance = -0.1
					speed = 0.25
					passives = list("UnhingedForm" = 0.5)
				..()

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
			intimidation = 10
			anger = 0.15
			imaginationAdd = 0.2

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/innocence)
					endurance = 0.2
					defense = 0.2
					strength = 0.1
					passives = list("Blubber" = 1, "CallousedHands" = -0.6, "HardenedFrame" = 1)
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/super)
					strength = 0.1
					endurance = 0.1
					defense = 0.1
					speed = 0.1
					force = 0.1
					offense = 0.1
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/unhinged)
					strength = 0.2
					defense = -0.1
					force = 0.2
					endurance = -0.1
					speed = 0.25
					passives = list("UnhingedForm" = 0.5)
				..()

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
			intimidation = 10

			onAscension(mob/owner)
				if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/innocence)
					endurance = 0.25
					defense = 0.2
					strength = 0.2
					passives = list("Blubber" = 1)
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/super)
					strength = 0.05
					endurance = 0.05
					defense = 0.05
					speed = 0.05
					force = 0.05
					offense = 0.05
				else if(owner.race.ascensions[1].choiceSelected == /ascension/sub_ascension/majin/unhinged)
					strength = 0.2
					offense = 0.2
					force = 0.15
					speed = 0.2
					passives = list("UnhingedForm" = 0.5)
					anger = 0.15
				..()

	gajalaka
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			cyberizeModAdd = 0.1
			passives = list("CashCow" = 1)
			on_ascension_message = "Your goblin greed grows..."
			powerAdd = 0.25
			pilotingProwess = 1.5
			intelligenceAdd = 0.25

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			cyberizeModAdd = 0.1
			passives = list("CashCow" = 1)
			on_ascension_message = "Your goblin greed grows..."
			intelligenceAdd = 0.5
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			cyberizeModAdd = 0.1
			passives = list("CashCow" = 1)
			on_ascension_message = "Your goblin greed grows..."
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			cyberizeModAdd = 0.1
			passives = list("CashCow" = 1)
			on_ascension_message = "Your goblin greed grows..."
			enhanceChips = 1
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			strength = 0.5
			endurance = 0.5
			force = 0.5
			offense = 0.5
			defense = 0.5
			speed = 0.5
			cyberizeModAdd = 0.1
			passives = list("CashCow" = 1)
			on_ascension_message = "Your goblin greed grows..."
			enhanceChips = 2


	namekian
		one
			unlock_potential	=	ASCENSION_ONE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Demon")
						//power = 0.75
						strength = 0.25
						speed = 0.25
						endurance = 0.25
						anger = 0.15 // 1.4
						passives = list("Hellrisen" = 0.25)
					if("Dragon")  /// after the merge, unmerged Dragon and Warrior will also receive some scaling power. Levi added it in for Gaja's in his push
						///power = 0.75
						passives = list("SpiritFlow" = 0.25)
						force = 0.5
						imaginationAdd = 0.5
						recovery = 0.25
						skills = list(/obj/Skills/Utility/Send_Energy)
					if("Warrior")
						//power = 1
						passives = list("Duelist" = 0.5)
						strength = 0.25
						endurance = 0.25
				if(owner.Class=="Dragon")
					for(var/obj/Skills/Utility/Send_Energy/se in owner.contents)
						se.SagaSignature=1
						se.SignatureTechnique=0
				..()
		two
			unlock_potential	=	ASCENSION_TWO_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Demon")
						//power = 1
						offense = 0.25
						defense = 0.25
						speed = 0.25
						strength = 0.25
						anger = 0.1 // 1.5
						skills = list(/obj/Skills/Buffs/SpecialBuffs/Daimou_Form)
						on_ascension_message =  "Your reliance on infernal power has given you insight to the power of a Great Demon King!"
					if("Dragon")
						//power = 1
						passives =list("SpiritHand" = 0.5, "SpiritFlow" = 0.25)
						force = 0.25
						offense = 0.25
						imaginationAdd = 0.25
						learning = 0.25
						skills = list(/obj/Skills/Utility/Heal)

					if("Warrior")
						//power = 1.5
						passives = list(,"Duelist" = 1)
						intimidation = 10
						strength = 0.5
						endurance = 0.5
						skills = list(/obj/Skills/Buffs/SpecialBuffs/Giant_Form)
				..()
		three
			unlock_potential	=	ASCENSION_THREE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class) // super namek era
					if("Demon")
						// power = 1.5
						speed = 0.25
						anger = 0.1 // 1.6
					if("Dragon")
						//power = 1.5
						force= 0.25
						endurance = 0.5
						passives = list("Spirit Flow" = 0.25, "HybridStrike" = 0.25)
						recovery = 0.25
					if("Warrior")
						//power = 2
						offense = 0.5
						passives = list ("Duelist" = 2, "Extend" = 1)
						strength = 0.5
						recovery = 0.5
						endurance = 0.5
				..()
		four
			unlock_potential =  ASCENSION_FOUR_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Demon")
						//power = 2
						intimidation = 20
						passives = list("SlayerMod" = 1.5, "MovementMastery" = 4)
					if("Warrior")
						//power = 3
						passives = list("Duelist" = 2.5, "Extend" = 2)
						strength = 0.75
						endurance = 0.25
						recovery = 0.5
						intimidation = 30
					if("Dragon")
						//power = 2.5
						force = 0.75
						recovery = 0.5
						passives = list("HybridStrike" = 0.25)
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class) ///orange namek should be unlocked here
					if("Demon")
						//power = 3
						speed = 0.5
						anger = 0.2 // 2
						intimidation = 50
					if("Warrior")
						//power = 4
						strength = 1
						endurance = 1
						intimidation = 70
					if("Dragon")
						//power = 3.5
						force = 1
						recovery = 1
						passives = list("ManaSeal" = 1, "CyberMenace" = 1, "HybridStrike" = 0.5)
				..()
	changeling
		one
			unlock_potential	=	ASCENSION_ONE_POTENTIAL
			intimidation = 3
			endurance = 0.25
			on_ascension_message = "You are now able to enter your true form!"

		two
			unlock_potential	=	ASCENSION_TWO_POTENTIAL
			intimidation = 3
			endurance = 0.25
			on_ascension_message = "You are now able to use 100% of your true forms power!"
			skills = list(/obj/Skills/Buffs/SpecialBuffs/OneHundredPercentPower)

		three
			unlock_potential	=	ASCENSION_THREE_POTENTIAL
			intimidation = 3
			endurance = 0.25
			on_ascension_message = "You feel there is yet another power beyond your true form..."

		four
			unlock_potential	=	ASCENSION_FOUR_POTENTIAL
			intimidation = 3
			endurance = 0.25
			skills = list(/obj/Skills/Buffs/SlotlessBuffs/Golden_Form)
			on_ascension_message = "Your evolutionary power now could be made to rival the very God's..."

		five
			unlock_potential	=	ASCENSION_FIVE_POTENTIAL
			intimidation = 3
			endurance = 0.25
			skills = list(/obj/Skills/Buffs/SlotlessBuffs/Black_Form)
			on_ascension_message = "You begin to surpass reality iself; transcendng it with access to a black void form...make them bow, Emperor."


	sub_ascension
		saiyan
			honor
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Saiyan_Grit)
				passives = list("Defiance" = 1)

			pride
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Saiyan_Dominance)
				passives = list("Pride" = 1)

			zeal
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Saiyan_Soul)
				passives = list("Adaptation" = 0.5)

		human
			technology
				rppAdd = 0.5
				ecoAdd = 0.5
				intelligenceAdd = 1
				cyberizeModAdd = 0.5
				imaginationAdd = 0.25
				pilotingProwess = 1.5
				enhanceChips = 1
			fighting
				passives = list("DemonicDurability" = 1, "StableBP" = 0.25)

		majin
			innocence
				choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
				endurance = 0.3
				defense  = 0.3
				speed = -0.1
				passives = list("Blubber" = 1, "CallousedHands" = 0.15, "Adaptation" = 1)

			super
				choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
				strength = 0.125
				force = 0.125
				endurance = 0.125
				speed = 0.125
				offense = 0.125
				defense = 0.125
				passives = list("FluidForm" = 1, "Adaptation" = 1)

			unhinged
				choices = list("Harness Evil" = /ascension/sub_ascension/majin/harness_evil, "Remain Consistent" = /ascension/sub_ascension/majin/remain_consistent, "Become Docile" = /ascension/sub_ascension/majin/become_docile)
				strength = 0.3
				endurance = -0.2
				defense = -0.2
				offense = 0.3
				passives = list("UnhingedForm" = 1)
				angerPoint = 5

			harness_evil
				choices = list("Brutality" = /ascension/sub_ascension/majin/harness_evil/brutality, "Anger" = /ascension/sub_ascension/majin/harness_evil/anger, "Both" = /ascension/sub_ascension/majin/harness_evil/both)
				brutality
					choices = list()
					passives = list("UnhingedForm" = 0.25, "Pursuer" = 1)

				anger
					choices = list()
					angerPoint = 5
					passives = list("DemonicDurability" = 0.25)

					onAscension(mob/owner)
						if(angerPoint+owner.AngerPoint > 65)
							passives["EndlessAnger"] = 1
						..()

				both
					choices = list()
					angerPoint = 2.5
					passives = list("DemonicDurability" = 0.175, "UnhingedForm" = 0.175, "Pursuer" = 0.5)
					onAscension(mob/owner)
						if(angerPoint+owner.AngerPoint > 65)
							passives["EndlessAnger"] = 1
						..()

			remain_consistent
				choices = list("Adaptability" = /ascension/sub_ascension/majin/remain_consistent/adaptability, "Consistency" = /ascension/sub_ascension/majin/remain_consistent/consistency, "Both" = /ascension/sub_ascension/majin/remain_consistent/both)
				adaptability
					choices = list()
					passives = list("Adaptation" = 0.2, "Flicker" = 1, "Hustle" = 0.15)

				consistency
					choices = list()
					passives = list("Steady" = 0.25, "DebuffImmune" = 0.15, "StableBP" = 0.5)

				both
					choices = list()
					passives = list("Adaptation" = 0.1, "Flicker" = 0.5, "Hustle" = 0.075, "Steady" = 0.175, "DebuffImmune" = 0.075, "StableBP" = 0.25)

			become_docile
				choices = list("Stability" = /ascension/sub_ascension/majin/become_docile/stability, "Peace" = /ascension/sub_ascension/majin/become_docile/peace, "Both" = /ascension/sub_ascension/majin/become_docile/both)
				stability
					choices = list()
					passives = list("VenomResistance" = 0.25, "DebuffImmune" = 0.25, "Juggernaut" = 0.5)

					onAscension(mob/owner)
						if(owner.passive_handler.Get("Juggernaut")+passives["Juggernaut"] >= 1)
							passives["GiantForm"] =1
						..()

				peace
					choices = list()
					passives = list("Flow" = 0.5, "DeathField" = 0.25, "VoidField" = 0.25)

				both
					choices = list()
					passives = list("VenomResistance" = 0.25, "DebuffImmune" = 0.25, "Juggernaut" = 0.25, "Flow" = 0.25, "DeathField" = 0.175, "VoidField" = 0.175)

					onAscension(mob/owner)
						if(owner.passive_handler.Get("Juggernaut")+passives["Juggernaut"] >= 1)
							passives["GiantForm"] =1
						..()

		high_faoroan
			distort
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/The_Crown/tc in owner.contents)
						tc.passives["SwordPunching"] = 1
						tc.passives["TechniqueMastery"] = 1
						tc.passives["Adrenaline"] = 1
					..()

			define
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/The_Crown/tc in owner.contents)
						tc.passives["LikeWater"] = 2
						tc.passives["Flow"] = 1
						tc.passives["Instinct"] = 1
					..()

			destroy
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/The_Crown/tc in owner.contents)
						tc.passives["Desperation"] = 2
						tc.passives["Unstoppable"] = 1
						tc.passives["MartialMagic"] = 1
					..()

			remove
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/The_Crown/tc in owner.contents)
						tc.passives["Extend"] = 1
						tc.passives["SpiritStrike"] = 1
						tc.passives["HybridStrike"] = 1
					..()

			conquer
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/The_Crown/tc in owner.contents)
						tc.passives["DrainlessMana"] = 1
						tc.passives["SlayerMod"] = 2
						tc.passives["WeaponBreaker"] = 1
						tc.passives["Erosion"] = 1
					..()

			obliterate
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/The_Crown/tc in owner.contents)
						tc.passives["WeaponBreaker"] = 1
						tc.passives["Hellpower"] = 1
						tc.passives["Erosion"] = 1
					..()

			rest
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Regeneration)
			sacrifice
				skills = list(/obj/Skills/Buffs/SlotlessBuffs/Sacrifice)

		yokai
			genius
				rppAdd = 0.25
				ecoAdd = 0.75
				intelligenceAdd = 1
				cyberizeModAdd = 1
				imaginationAdd = 0.5
				pilotingProwess = 1.5
				enhanceChips = 1

			grand_caster
				passives = list("QuickCast" = 1, "ManaGeneration" = 2)
				offense = 0.25
				force = 0.25

			two_become_one
				passives = list("MovementMastery" = 2, "ManaStats" = 0.25)
				onAscension(mob/owner)
					for(var/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form/sf in owner.contents)
						sf.passives["TechniqueMastery"] = 0
					..()