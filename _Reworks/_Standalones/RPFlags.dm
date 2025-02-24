RPFlag
	parent_type = /obj/

	invisibility = 100
	icon = 'skilltree.dmi'

	alpha = 155

	density = 0
	opacity = 0

	Crossed(atom/movable/O)
		if(isplayer(O))
			var/mob/Players/p = O
			AdminMessage("[p] has crossed a RPFlag titled ([name]) at [x],[y],[z]!")

mob/Admin3/verb/CreateRPFlag()
	var/nameofFlag = input(usr, "What do you want the flag to be titled?") as text||null
	if(!nameofFlag)
		return
	var/RPFlag/rpflag = new(usr.loc)
	rpflag.name = nameofFlag