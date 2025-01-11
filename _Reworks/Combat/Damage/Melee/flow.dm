// aids
// make it so basically when they use flow, they drain energy or something
// but also make it not spammable
globalTracker/var/BASE_FLOW_PROB = 5
globalTracker/var/BASE_FLUIDFORM_PROB = 10
globalTracker/var/BASE_BACKTRACK_PROB = 8

/mob/Admin4/verb/testDummy()
    var/mob/Players/P = new()
    P.passive_handler = new()
    P.setRace(HUMAN, FALSE)
    P.loc = src.loc
    P.icon = 'Namek1.dmi'