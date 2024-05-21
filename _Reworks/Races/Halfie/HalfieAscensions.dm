
/mob/proc/halfieClassSelection()
	switch(prompt("What side do you feel more in tune with?", "Class Selection", list("Human","Both","Saiyan")))
		if("Human")
			Class = "Desperate"
		if("Both")
			Class = "Effecient"
		if("Saiyan")
			Class = "Brutal"

/mob/proc/GetBrutalize()
	if(passive_handler.Get("Brutalize"))
		. = passive_handler.Get("Brutalize") / 10
	else
		return 0


mob
	proc
		HalfSaiyanAscension1()
			src.AscensionsAcquired=1
			if(!(Class in list("Desperate","Effecient","Brutal")))
				halfieClassSelection()
			switch(Class)
				if("Desperate")
					passive_handler.Increase("Desperation", 2)
					passive_handler.Increase("Adrenaline", 0.5)
					Desperation = 2
					NewAnger(1.5)
					Adrenaline = 0.5
					SpdAscension += 0.4
					DefAscension += 0.25
					StrAscension += 0.25
					Intelligence+=0.5
					Intimidation=2
				if("Effecient")
					passive_handler.Increase("Desperation", 1.5)
					passive_handler.Increase("TechniqueMastery", 1.5)
					Desperation = 1.5
					NewAnger(1.3)
					SpdAscension += 0.15
					DefAscension += 0.15
					StrAscension += 0.15
					EndAscension += 0.15
					OffAscension += 0.15
					ForAscension += 0.15
					Intelligence+=0.25
					Intimidation=4
				if("Brutal")
					passive_handler.Increase("Desperation", 1)
					Desperation = 1
					NewAnger(1.5)
					StrAscension += 0.4
					EndAscension += 0.4
					OffAscension += 0.25
					Intimidation=12
					passive_handler.Increase("Brutalize", 0.5)
					passive_handler.Increase("KillerInstinct", 0.05)
			src<<"You feel more in tune with your [Class] side."
		HalfSaiyanAscension2()
			src.AscensionsAcquired=2
			switch(Class)
				if("Desperate")
					passive_handler.Increase("Desperation", 0.5)
					passive_handler.Increase("Adrenaline", 0.5)
					Desperation = 2.5
					NewAnger(1.6)
					Adrenaline = 1
					SpdAscension += 0.25
					DefAscension += 0.25
					StrAscension += 0.15
					Intelligence+=0.5
					Intimidation+=2
				if("Effecient")
					passive_handler.Increase("Desperation", 0.5)
					passive_handler.Increase("TechniqueMastery", 0.5)
					Desperation = 2
					NewAnger(1.5)
					SpdAscension += 0.15
					DefAscension += 0.15
					EndAscension += 0.15
					StrAscension += 0.15
					OffAscension += 0.15
					ForAscension += 0.15
					Intelligence+=0.25
					Intimidation+=4
				if("Brutal")
					passive_handler.Decrease("Desperation", 0.5)
					passive_handler.Increase("Brutalize", 0.25)
					passive_handler.Increase("KillerInstinct", 0.05)
					Desperation = 0.5
					NewAnger(1.6)
					StrAscension += 0.25
					EndAscension += 0.25
					OffAscension += 0.15
					Intimidation=18
			src<<"You feel more and more [Class]."
		HalfSaiyanAscension3()
			src.AscensionsAcquired=3
			switch(Class)
				if("Desperate")
					passive_handler.Increase("Desperation", 0.5)
					passive_handler.Increase("Adrenaline", 0.5)
					Desperation = 3
					NewAnger(1.7)
					Adrenaline = 1.5
					SpdAscension += 0.4
					DefAscension += 0.4
					StrAscension += 0.25
					src<<"No matter the battle, you will never give up!"
				if("Effecient")
					passive_handler.Increase("Desperation", 0.5)
					passive_handler.Increase("TechniqueMastery", 1)
					Desperation = 2.5
					NewAnger(1.7)
					SpdAscension += 0.25
					DefAscension += 0.25
					EndAscension += 0.25
					StrAscension += 0.25
					OffAscension += 0.25
					ForAscension += 0.25
					Intelligence+=0.25
					Intimidation+=2
					src<<"Wisdom is the key to victory!"
				if("Brutal")
					passive_handler.Decrease("Desperation", 0.5)
					passive_handler.Increase("Brutalize", 0.25)
					passive_handler.Increase("KillerInstinct", 0.05)
					Desperation = 0
					NewAnger(1.7)
					StrAscension += 0.4
					EndAscension += 0.4
					OffAscension += 0.25
					Intimidation = 24
					src<<"Overbearing like the moon, feral like an Oozaru"

		HalfSaiyanAscension4()
			src.AscensionsAcquired=4
			switch(Class)
				if("Desperate")
					Desperation = 4
					passive_handler.Increase("Desperation", 1)
					NewAnger(1.8)
					SpdAscension += 0.4
					DefAscension += 0.4
					StrAscension += 0.3
					Intimidation+=2
					src<<"Courage swells within you, bravery doesn't require power."
				if("Effecient")
					Desperation = 2.5
					NewAnger(1.75)
					passive_handler.Increase("TechniqueMastery", 0.5)
					SpdAscension += 0.25
					DefAscension += 0.25
					EndAscension += 0.25
					StrAscension += 0.25
					OffAscension += 0.25
					ForAscension += 0.25
					Intelligence+=0.25
					Intimidation+=4
					src<<"Perfectly balanced like all thing should be."
				if("Brutal")
					NewAnger(1.8)
					StrAscension += 0.4
					EndAscension += 0.4
					OffAscension += 0.3
					Intimidation+=6
					src<<"Your Saiyan heritage shines through, blood is the key to victory."