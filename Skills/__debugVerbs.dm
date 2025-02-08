var/TRACKING_BURNING = FALSE
var/TRACKING_POISON = FALSE
var/currentBurn = 0
var/currentPoi = 0 

/mob/Admin4/verb/fillTension()
	set category = "Debug"
	Tension = 100
/mob/Admin3/verb/Admin_Screen_Size()
	set category="Other"
	set hidden=1
	if(!(world.time > usr.verb_delay)) return
	usr.verb_delay=world.time+1
	var/screenx=input("Enter the width of the screen, max is 999.") as num
	screenx=min(max(1,screenx),999)
	var/screeny=input("Enter the height of the screen, max is 999.") as num
	screeny=min(max(1,screeny),999)
	client.view="[screenx]x[screeny]"
	src.ScreenSize = "[screenx]x[screeny]"


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