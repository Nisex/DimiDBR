obj
	Items
		Sword
			Medium
				Scissor_Blade
					name="Scissor Blade"
					icon='scissorcasetilted.dmi'
					UnderlayIcon = 'scissorcasetilted_under.dmi'
					passives = list("Shearing" = 0.5)
					Shearing=0.5
					iconAlt='Scissor_blade_decap.dmi'
					iconAltX=-32
					iconAltY=-32
					ClassAlt="Heavy"
					Techniques=list("/obj/Skills/Buffs/SlotlessBuffs/WeaponSystems/Decapitation_Mode", "/obj/Skills/Queue/Sen_I_Soshitsu", "/obj/Skills/AutoHit/Life_Fiber_Weave")
					unsheatheIcon = 'scissor_blade.dmi'
					unsheatheOffsetX = -16
					unsheatheOffsetY = -16

					verb/Restyle_Scissor_Blade_Case()
						var/caseType = input("What type of Case would you like?") in list("Slanted", "Straight")
						if(caseType == "Slanted")
							UnderlayIcon = 'scissorcasetilted_under.dmi'
							icon = 'scissorcasetilted.dmi'
						else if(caseType == "Straight")
							UnderlayIcon = 'scissorcase_under.dmi'
							icon = 'scissorcase.dmi'