
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
	winset(src,"custom_buff_[multOrAdd].[stat]", "text=[statRef.calc_stat(statRef.vars[stat], TRUE)]")
	winset(src,"custom_buff_[multOrAdd].Points Remaining", "text=[custom_buff.vars["stat_[multOrAdd]_total"] - custom_buff.vars["stat_[multOrAdd]_spent"]]")



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

	proc/init(mob/p, obj/Skills/Buffs/parent_buff)
		var/list/augments_to_pick = list("Timed", "Draining", "Potent Passives", "Potent Stats")
		p << "Timed makes the buff timed, but gives you extra stat mult/add points. 30 + 15 seconds per asc, with double that as a cd \n Draining has you pick between mana/energy/health drain, health gives the most stat mults/add \n Potent Passives makes your passives stronger, but all of your stats are -0.1. Potent Stats is the opposite"
		var/the_pick = input(p, "What one?") in augments_to_pick
		current_augments += the_pick
		adjust_custom_buff(p, parent_buff)
	
	proc/adjust_custom_buff(mob/p, obj/Skills/Buffs/parent_buff)
		parent_buff.being_editted = TRUE
		statsadd.reset(list(0,0,0,0,0,0))
		statsmult.reset(list(1,1,1,1,1,1))
		setMaxes(p)
		p.open_custom_buff_HUD()



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
		