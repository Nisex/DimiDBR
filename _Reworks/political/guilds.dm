/proc/moveElement(list/L, fromIndex, toIndex)
	if(fromIndex == toIndex || fromIndex+1 == toIndex)	//no need to move
		return
	if(fromIndex > toIndex)
		++fromIndex	//since a null will be inserted before fromIndex, the index needs to be nudged right by one
	L.Insert(toIndex, null)
	L.Swap(fromIndex, toIndex)
	L.Cut(fromIndex, fromIndex+1)

/proc/adjustRankings()
	for(var/x in 1 to length(glob.GUILD_RANKINGS))
		var/index = x // 1 to length, we cant use numericals to index the list that is indexed by text
		var/yindex =0
		for(var/y in glob.GUILD_RANKINGS)
			yindex++ // so we need to loop through this list, but not go over the index, essentially we only want to set something that is = to index
			if(yindex == index)
				glob.GUILD_RANKINGS[y] = x
/proc/getGuildRankings(guild)
	if(!glob.GUILD_RANKINGS[guild])
		return 10
	return glob.GUILD_RANKINGS[guild]

/proc/getExchangeRate(guild)
	var/highest = 1 // 1 is the highest rank
	var/lowest = 1 // 1 is the lowest rank
	for(var/x in glob.GUILD_RANKINGS)
		if(glob.GUILD_RANKINGS[x] < highest)
			highest = glob.GUILD_RANKINGS[x]
		else if(glob.GUILD_RANKINGS[x] > lowest)
			lowest = glob.GUILD_RANKINGS[x]
	if(!glob.GUILD_RANKINGS[guild])
		return 1
	// given the highest and lower, we can calculate the exchange rate
	return PLAYER_EXCHANGE_RATE + clamp(1 - glob.GUILD_RANKINGS[guild], -4 , 0)

/mob/Admin3/verb/AddGuildToRanking()
	set category = "Politics"
	var/guild = input("Guild Name: ") as text
	var/rank = input("Rank: ") as num
	var/previous = glob.GUILD_RANKINGS[guild]
	if(!previous)
		glob.GUILD_RANKINGS[guild] = rank
		moveElement(glob.GUILD_RANKINGS, length(glob.GUILD_RANKINGS), rank)
	else
		glob.GUILD_RANKINGS[guild] = rank
		moveElement(glob.GUILD_RANKINGS, previous, rank)
	adjustRankings()

/mob/Admin3/verb/RemoveGuildFromRanking()
	set category = "Politics"
	var/guild = input("Guild Name: ") in glob.GUILD_RANKINGS
	glob.GUILD_RANKINGS.Remove(guild)

/mob/verb/View_Guild_Ranks()
	set category = "Roleplay"
	var/startText = "[SYSTEM]Guild Rankings]"
	for(var/x in glob.GUILD_RANKINGS)
		if(glob.GUILD_RANKINGS[x] > 0)
			startText += "\n[SYSTEM][x] ([glob.GUILD_RANKINGS[x]])]"
	src << "[startText][SYSTEMTEXTEND]"