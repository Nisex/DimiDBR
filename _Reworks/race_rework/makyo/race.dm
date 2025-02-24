race
	makyo
		name = "Makyo"
		desc = "These spiritual beings are said to have arosen from nowhere, often taking up place as guardians of graveyards, spirit gates and temples."
		visual = 'Demon.png'
		var/accepting_boons = TRUE
		locked = FALSE
		strength = 2
		endurance = 2
		speed = 0.75
		force = 1
		offense = 1.25
		defense = 0.5
		imagination = 2
		passives = list("Juggernaut" = 0.5, "DemonicDurability" = 0.5, "HeavyHitter" = 0.5, "ShonenPower" = 0.15)
		onFinalization(mob/user)
			. = ..()
			user.verbs += /mob/proc/toggle_makyo_boons


/mob/proc/toggle_makyo_boons()
	if(isRace(MAKYO))
		race?:accepting_boons = !race?:accepting_boons
		src << "You are [race?:accepting_boons ? "now" : "no longer"] accepting boons."