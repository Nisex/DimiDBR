var/TRACKING_BURNING = FALSE
var/TRACKING_POISON = FALSE
var/currentBurn = 0
var/currentPoi = 0 
/mob/Admin3/verb/trackburning()
    set category = "Debug"
    TRACKING_BURNING = !TRACKING_BURNING
    if(!TRACKING_BURNING)
        currentBurn = 0

/mob/Admin3/verb/trackpoison()
    set category = "Debug"
    TRACKING_POISON = !TRACKING_POISON
    if(!TRACKING_POISON)
        currentPoi = 0