

race
	beastman
		name = "Beastman"
		desc = "Bearers of Al-Munshaq’s will, these survivors from Najim Ha’aar now live as natives within Mt. Red. They are fierce people with origins spanning across many cultures."
		visual = 'Monstrous.png'
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk,/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Ticking_Bomb)
		strength = 1.25
		endurance = 1.25
		force = 1.25
		offense = 1.25
		defense = 1.25
		speed = 1.25
		regeneration = 1.5
		intellect = 0.5
		// attaching this here cause lol
		var/MaxGrit = 0
		var/Grit = 0 
		var/Racial = "" // first sub ascension choice
		onFinalization(mob/user)
			user.EnhancedSmell=1
			user.EnhancedHearing=1
			ascensions[1].choiceSelection(user) // force them to pick their ascension type here, without applying it
			src << "Information to what each racial does: "
			var/f = list("Heart of The Beastman", "Monkey King", "Unseen Predator", "Undying Rage")
			var/nim = list("Feather Maker", "Path Finder???")
			var/nic = list("Spirit Walker", "Shapeshifter", "Trickster", "Fox Fire")
			while(Racial == "" || Racial == "Cancel")
				switch(ascensions[1].choiceSelected)
					if("Ferocious")
						Racial = input(user, "What racial do you want?", "Racial") in f + "Cancel"
					if("Nimble")
						Racial = input(user, "What racial do you want?", "Racial") in nim + "Cancel"
						if(Racial == "Feather Maker")
							Racial = input(user, "What racial do you want?", "Racial") in list("Feather Knife", "Feather Cloak", "Cancel")
					if("Niche")
						Racial = input(user, "What racial do you want?", "Racial") in nic + "Cancel"
				sleep(world.tick_lag)
			..()
		
		proc/GiveRacial(mob/p)
			switch(Racial)
				if("Heart of The Beastman")
					MaxGrit = 25
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/The_Grit)
				if("Monkey King")
					p.passive_handler.Increase("Hardening", 1)
					p.passive_handler.Increase("Instinct", 1)
					p.passive_handler.Increase("Nimbus", 1)
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Never_Fall)
				if("Unseen Predator")
					p.passive_handler.Set("Heavy Strike" , "Unseen Predator")
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Savagery)
				if("Undying Rage")
					p.passive_handler.Increase("Fury", 1)
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Undying_Rage)

				if("Feather Cloak")
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Feather_Cowl)
					p.passive_handler.Increase("Hardening", 1)
					p.passive_handler.Increase("Pressure", 1)
				
				if("Feather Knife")
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Clean_Cuts)
					p.passive_handler.Increase("Feather Knives", 1)
					p.passive_handler.Increase("Momentum", 1)
				

				if("Spirit Walker")
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Pheonix_Form)
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Ram_Form)
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Bear_Form)
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Turtle_Form)
				
				if("Shapeshifter")
					var/obj/Skills/Buffs/SlotlessBuffs/Racial/Shapeshift/s = new()
					p.AddSkill(s)
					s.init(p) // set up the shapeshift buff
				
				if("Trickster")
					p.passive_handler.Increase("Spiritual Tactician", 1)
					p.AddSkill(new/obj/Skills/Utility/Imitate)
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Racial/Blend_In)
				
				if("Fox Fire")
					p.Attunement = "Fox Fire"
					p.passive_handler.Set("Heavy Attack" , "Fox Fire")
					p.AddSkill(new/obj/Skills/Projectile/Racial/Fox_Fire_Barrage)

