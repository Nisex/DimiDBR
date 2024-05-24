/*
	The "Any" macro is a single built-in macro that captures all button press events
	 from your keyboard and all gamepads.

	Client has a new variable, macros, which refers to the button tracker that
	 keeps track of the state of every macroable button.

	 By default, it initializes to a new instance of /button_tracker.
*/

client
	var
		// Button tracker in charge of tracking macro states.
		button_tracker/macros

	New()
		if(!macros)
			macros = new
		return ..()

	verb
		// Press the button for the button tracker.
		press_button(button as text)
			set hidden = TRUE
			set instant = TRUE
			if(macros)
				macros.Press(button)
				if(trackingMacro)
					var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/dm = mob.checkOtherMacros(button)
					if(dm != 1)
						var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/org = trackingMacro
						org.keyMacro = button
						mob << "[button] is the macro for [org]"
						sleep(15)
						trackingMacro = null
					else
						mob << "[dm != FALSE ? "[button] is assigned to [dm]" : "You arent allowed"]"

		// Release the button for the button tracker.
		release_button(button as text)
			set hidden = TRUE
			set instant = TRUE
			if(macros) 
				macros.Release(button)
				keyQueue+=list(button, world.time)
