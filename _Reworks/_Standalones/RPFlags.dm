RPFlag
	parent_type = /obj/

	invisibility = 100
	icon = 'skilltree.dmi'

	alpha = 155

	density = 0
	opacity = 0

	var/requiresItem = null

	Crossed(atom/movable/O)
		if(isplayer(O))
			var/mob/Players/p = O
			AdminMessage("[p] has crossed a RPFlag titled ([name]) at [x],[y],[z]!")
	Cross(atom/movable/O)
		if(isplayer(O))
			if(requiresItem)
				for(var/obj/Items/i in O)
					if(istype(i, requiresItem))
						return TRUE
				O << "That seems like a bad idea..."
				return FALSE
			else
				return TRUE

/obj/Items/Tech/SpaceMask/Rebreather
	// its 9 am 

mob/Admin3/verb/CreateRPFlag()
	var/nameofFlag = input(usr, "What do you want the flag to be titled?") as text|null
	if(!nameofFlag)
		return
	var/RPFlag/rpflag = new(usr.loc)
	var/flagNeedsXItem = input(usr, "What item does the flag need?") in "None" + typesof(/obj/Items)
	if(flagNeedsXItem != "None")
		rpflag.requiresItem = flagNeedsXItem
	rpflag.name = nameofFlag