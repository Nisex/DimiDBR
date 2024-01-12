#define ASCENSION_ONE_POTENTIAL 20
#define ASCENSION_TWO_POTENTIAL 40
#define ASCENSION_THREE_POTENTIAL 60
#define ASCENSION_FOUR_POTENTIAL 80
#define ASCENSION_FIVE_POTENTIAL 100
ascension
	var
		strength = 0
		endurance = 0
		force = 0
		offense = 0
		defense = 0
		speed = 0
		regeneration = 0
		recovery = 0
		learning = 0
		intelligenceAdd = 0
		imaginationAdd = 0
		anger = 0
		unlock_potential = 1
		mana = 0
		intimidation = 0
		intimidationMult = 1
		pilotingProwess = 0
		cyberizeModAdd = 0
		enhanceChips = 0
		rppAdd = 0
		ecoAdd = 0
		new_anger_message
		list/skills = list()
		list/passives = list()

		choiceTitle = "Ascension Selection"
		choiceMessage = ""
		list/choices = list()
		ascension/choiceSelected

		applied = FALSE

	proc
		onAscension(mob/owner)
			if(applied) return
			choiceSelection(owner)
			if(choices.len > 0 && !choiceSelected) return

			applied = TRUE

			owner.StrAscension += strength
			owner.EndAscension += endurance
			owner.ForAscension += force
			owner.OffAscension += offense
			owner.DefAscension += defense
			owner.SpdAscension += speed
			owner.RecovAscension +=  recovery
			owner.RegenAscension += regeneration
			owner.ManaCapMult += mana/100

			if(skills.len > 0)
				for(var/obj/Skills/added_skill in skills)
					if(locate(added_skill,owner)) continue
					owner.AddSkill(new added_skill)

			if(passives.len > 0)
				owner.passive_handler.increaseList(passives)

			if(new_anger_message)
				owner.AngerMessage = new_anger_message

			if(anger != 0)
				owner.NewAnger(owner.Anger+anger)

			owner.Intimidation += intimidation
			owner.Intimidation *= intimidationMult

			owner.Intelligence += intelligenceAdd
			owner.Imagination += imaginationAdd

			owner.CyberizeMod += cyberizeModAdd

			owner.RPPMult += rppAdd
			owner.EconomyMult += ecoAdd
			owner.PilotingProwess += pilotingProwess
			owner.EnhanceChipsMax += enhanceChips

			if(choiceSelected)
				var/ascension/choiceAsc = choiceSelected
				choiceAsc.onAscension(owner)

		choiceSelection(mob/owner)
			if(choices.len == 0 || choiceSelected) return
			var/selected = input(owner, choiceMessage, choiceTitle) in choices
			choiceSelected = choices[selected]

		checkAscensionUnlock(potential)
			if(unlock_potential==-1) return 0
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
			anger = 0.05
			passives = list("Desperation" = 1.5, "Adrenaline" = 1, "TechniqueMastery" = -1)
			new_anger_message = "grows desperate!"
			choices = list("Technology" = /ascension/sub_ascension/human/technology, "Fighting" = /ascension/sub_ascension/human/fighting)

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL

	sub_ascension
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