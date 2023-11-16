mob
	var
		passive/passive_handler
	verb
		GetAllPassives() //test verb, remove later
			usr << passive_handler.getAll()

passive
	var
		list/passives = list() //this list will track passives that are intended to stick to the character; racials/things sticking over relogs.
		tmp/list/tmp_passives = list() //this list is for buffs, or things that should fall off naturally/on a relog.

	proc
		Get(passive) // returns value of passive if it exists/has anything
			return passives[passive] ? passives[passive] : 0

		getAll() //outputs in text, will be used for some sort of psuedo-assess
			var/passiveText="Passives:"
			for(var/p in passives)
				passiveText+= "\n[p] = [passives[p]+tmp_passives[p]]"
			return "[passiveText]"

		Increase(passive, value = 1, temp = FALSE) // Used to specifically increment a passive upwards. If it doesn't exist, then it gets created and set to that value. passive can also be passed in as a list ofto increase.
			switch(islist(passive))
				if(FALSE)
					switch(temp)
						if(FALSE)
							passives[passive] += value
						if(TRUE)
							tmp_passives[passive] += value
				if(TRUE)
					increaseList(passive, temp)

		Set(passive, value = 0, temp = FALSE) // directly sets a passive
			switch(islist(passive))
				if(FALSE)
					switch(temp)
						if(FALSE)
							passives[passive] = value
						if(TRUE)
							tmp_passives[passive] = value
				if(TRUE)
					setList(passive, temp)

		Decrease(passive, value = 1, temp = FALSE)
			switch(islist(passive))
				if(FALSE)
					switch(temp)
						if(FALSE)
							passives[passive] -= value
						if(TRUE)
							tmp_passives[passive] -= value
				if(TRUE)
					decreaseList(passive, temp)

		decreaseList(list/settingPassiveList, temp = FALSE)
			switch(temp)
				if(FALSE)
					for(var/settingPassive in settingPassiveList)
						passives[settingPassive] -= settingPassiveList[settingPassive]
				if(TRUE)
					for(var/settingPassive in settingPassiveList)
						tmp_passives[settingPassive] -= settingPassiveList[settingPassive]

		increaseList(list/settingPassiveList, temp = FALSE)
			switch(temp)
				if(FALSE)
					for(var/settingPassive in settingPassiveList)
						passives[settingPassive] += settingPassiveList[settingPassive]
				if(TRUE)
					for(var/settingPassive in settingPassiveList)
						tmp_passives[settingPassive] += settingPassiveList[settingPassive]

		setList(list/settingPassiveList, temp = FALSE)
			switch(temp)
				if(FALSE)
					for(var/settingPassive in settingPassiveList)
						passives[settingPassive] = settingPassiveList[settingPassive]
				if(TRUE)
					for(var/settingPassive in settingPassiveList)
						tmp_passives[settingPassive] = settingPassiveList[settingPassive]

		operator|=(passive) // alternative way of checking passives. shorthand if(passive|="zornhau") returns the value of zornhau
			Get(passive)