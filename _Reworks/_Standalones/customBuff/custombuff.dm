
/*
augments -
	augments do differnet things for the buff

	timed - adds more stat mult/adds, makes it timed
		tier 1 = 15 per asc, extra ? stats
	
	draining -
		energy, mana, health 
			health gives the most stats

	1 pick per asc ?



*/
#define HIGH_TIER(asc) 4 + (3 * asc)
#define MID_TIER(asc) 3 + (2 * asc)
#define LOW_TIER(asc) 2 + (1 * asc)
#define L_TIER(asc) 1 + (1 * asc)


/mob/proc/open_custom_buff_HUD()
	winshow(src, "custom_buff_add")
	winshow(src, "custom_buff_mult")
	custom_buff_update("mult")
	custom_buff_update("add")
/mob/proc/custom_buff_update(multOrAdd, datum/customBuff/custom_buff)
	if(!custom_buff)
		for(var/obj/Skills/Buffs/b in src)
			if(b.being_editted)
				custom_buff = b?:c_buff
				break
	var/datum/statHolder/statRef = custom_buff.vars["stats[multOrAdd]"]
	for(var/x in list("Strength","Endurance","Force","Offense","Defense","Speed"))
		winset(src,"custom_buff_[multOrAdd].[x]", "text=[statRef.calc_stat(statRef.vars[x], TRUE)]")
	winset(src,"custom_buff_[multOrAdd].Points Remaining", "text=[custom_buff.vars["stat_[multOrAdd]_total"] - custom_buff.vars["stat_[multOrAdd]_spent"]]")

/mob/verb/custom_buff_point_done(whatone as text)
	set name = ".custom_buff_point_done"
	set hidden = 1
	var/datum/customBuff/custom_buff
	var/obj/Skills/Buffs/buff 
	for(var/obj/Skills/Buffs/b in src)
		if(b.being_editted)
			custom_buff = b?:c_buff
			buff = b
			break
	if(custom_buff.vars["stat_[whatone]_total"] != custom_buff.vars["stat_[whatone]_spent"])
		src << "You have points left"
		return
	winshow(src, "custom_buff_[whatone]", 0)
	if(winget(src, "custom_buff_mult", "is-visible") == "false" && winget(src, "custom_buff_add", "is-visible") == "false")
		buff.being_editted = FALSE
		buff.adjust(src)

/mob/verb/custom_buff_point(updown as text, stat as text, multOrAdd as text)
	set name = ".custom_buff_point"
	set hidden = 1
	updown = text2num(updown)
	var/datum/customBuff/custom_buff
	for(var/obj/Skills/Buffs/b in src)
		if(b.being_editted)
			custom_buff = b?:c_buff
			break
	var/datum/statHolder/statRef = custom_buff.vars["stats[multOrAdd]"]
	if(updown == 1)
		if(custom_buff.vars["stat_[multOrAdd]_spent"] + 1 <= custom_buff.vars["stat_[multOrAdd]_total"])
			custom_buff.vars["stat_[multOrAdd]_spent"]++
			statRef.vars[stat].invested++
	else
		if(custom_buff.vars["stat_[multOrAdd]_spent"] - 1 >= 0 && statRef.vars[stat].invested - 1 >= 0)
			custom_buff.vars["stat_[multOrAdd]_spent"]--
			statRef.vars[stat].invested--
	custom_buff_update("mult", custom_buff)
	custom_buff_update("add", custom_buff)



/obj/Skills/Buffs/var/tmp/being_editted = TRUE
/datum/customBuff
	var/passive_limit  = 1
	var/passive_tier = 1

	var/stat_mult_total  = 0
	var/stat_add_total = 0

	var/stat_mult_spent = 0
	var/stat_add_spent = 0

	var/datum/statHolder/statsmult = new()
	var/datum/statHolder/statsadd = new()
	var/list/current_passives = list()

	var/list/current_stat_mults = list()

	var/list/current_stat_adds = list()

	var/list/current_augments = list()
	var/selecting_aguments = FALSE
	proc/init(mob/p, obj/Skills/Buffs/parent_buff)
		adjust_custom_buff(p, parent_buff)
	
	proc/select_augment(mob/p)
		for(var/x in 1 to p.AscensionsAcquired)
			var/list/augments_to_pick = list("Timed", "Draining", "Potent Passives", "Potent Stats")
			var/the_pick = input(p, "What one?") in augments_to_pick
			current_augments += the_pick
			augments_to_pick -= the_pick
		selecting_aguments = FALSE
		
	
	proc/adjust_custom_buff(mob/p, obj/Skills/Buffs/parent_buff)
		parent_buff.being_editted = TRUE
		selecting_aguments = TRUE
		select_augments(p)
		while(selecting_aguments)
			sleep(1)
		statsadd.reset(list(0,0,0,0,0,0))
		statsmult.reset(list(1,1,1,1,1,1))
		setMaxes(p)
		p.open_custom_buff_HUD()
		current_passives = list()
		if(passive_limit > 0)
			for(var/x in 1 to passive_limit)
				selectPassive(p)

	proc/selectPassive(mob/p)
		var/list/data = getJSONInfo(getPassiveTier(p), "GENERIC_PASSIVES")
		data.Add(getJSONInfo(getPassiveTier(p), "SWORD_PASSIVES"))
		data.Add(getJSONInfo(getPassiveTier(p), "UNARMED_PASSIVES"))
		data.Add(getJSONInfo(getPassiveTier(p), "STAFF_PASSIVES"))
		data.Add(getJSONInfo(getPassiveTier(p), "ARMOR_PASSIVES"))

		var/correct = FALSE
		var/attempts = 0
		var/choices = list()
		for(var/x in data)
			choices += "[x]"
		while(correct == FALSE)
			var/passive = input(p, "what passive") in choices
			if(attempts >= 5)
				p << "tried to omany times, admin can help"
				break
			if(!handlePassive(data, passive))
				p << "Too Much Value"
				choices -= passive
				correct = FALSE
			else
				correct = TRUE
			attempts++


	proc/handlePassive(list/theList, input, secondary)
		. = TRUE

		if(current_passives["[input]"])
			if(current_passives["[input]"] + theList[input][1] > theList[input][2])
				return FALSE
			switch(input)
				if("CriticalChance")
					current_passives["[input]"] += theList[input][1]
					current_passives["CriticalDamage"] += 0.1
					return
				if("BlockChance")
					current_passives["[input]"] += theList[input][1]
					current_passives["CriticalDamage"] += 0.1
					return
			current_passives["[input]"] += theList[input][1]
		else
			current_passives["[input]"] = theList[input][1]

	proc/setMaxes(mob/p)
		var/asc = p.AscensionsAcquired
		stat_mult_total = glob.CUSTOMBUFFMULTTOTAL + (glob.CUSTOMBUFFMULTTOTAL * asc)
		stat_add_total = glob.CUSTOMBUFFADDTOTAL + (glob.CUSTOMBUFFADDTOTAL * asc)
		passive_limit = glob.CUSTOMBUFFPASSIVETOTAL + (glob.CUSTOMBUFFPASSIVETOTAL * asc) // likely use the demon thing here
		passive_tier = asc
		for(var/x in current_augments)
			switch(x)
				if("Timed")
					stat_mult_total += MID_TIER(asc)
					stat_add_total += LOW_TIER(asc)
				if("Draining")
					var/option = current_augments[x][1]
					switch(option)
						if("health")
							stat_mult_total += HIGH_TIER(asc)
							stat_add_total += MID_TIER(asc)
						if("energy")
							stat_mult_total += MID_TIER(asc)
							stat_add_total += LOW_TIER(asc)
						if("mana")
							stat_mult_total += LOW_TIER(asc)
							stat_add_total += L_TIER(asc)
				if("Potent Passives")
					stat_mult_total -= 0.15
					statsadd.reset(list(-0.1,-0.1,-0.1,-0.1,-0.1,-0.1))
				if("Potent Stats")
					passive_limit -= 1
					stat_mult_total += MID_TIER(asc)
					stat_add_total += LOW_TIER(asc)
		