// aids
// make it so basically when they use flow, they drain energy or something
// but also make it not spammable
/datum/globalTracker/var/BASE_FLOW_PROB = 4
/datum/globalTracker/var/BASE_FLUIDFORM_PROB = 10


/mob/Admin4/verb/testDummy()
    var/mob/Players/P = new()
    P.passive_handler = new()
    P.loc = src.loc
    P.icon = 'Namek1.dmi'