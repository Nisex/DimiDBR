#define BROADCAST_RANGE 12
#define BROADCAST_COLOR "<font color=green>"
var/list/globalListeners = list()

proc/addToGlobalListeners(var/obj/Items/Tech/listener)
	if(globalListeners[listener.Frequency])
		globalListeners[listener.Frequency] |= listener
	else
		globalListeners[listener.Frequency] = list(listener)

proc/removeFromGlobalListeners(var/obj/Items/Tech/listener)
	if(globalListeners[listener.Frequency])
		globalListeners[listener.Frequency] -= listener

obj/Items/Tech/proc/broadcastToListeners(msg)
//	if(!Active) return
	for(var/obj/Items/Tech/i in globalListeners[Frequency])
		i.recieveBroadcast(msg)

obj/Items/Tech/proc/recieveBroadcast(msg)
//	if(!Active) return
	var/broadcastFormatting = "[BROADCAST_COLOR]<b>([name])</b>[msg]"
	if(ismob(loc))
		var/mob/owner = loc
		if(owner.client)
			owner.client.outputToChat(broadcastFormatting, list("icchat","output"))
			Log(owner.ChatLog(),"broadcastFormatting")
			Log(owner.sanitizedChatLog(),"broadcastFormatting")
	else
		OMsg(BROADCAST_RANGE,broadcastFormatting)


mob/Players/
	Login()
		..()
		for(var/obj/Items/Tech/F in contents)
			if(!F.Frequency) continue
			addToGlobalListeners(F)

	Logout()
		..()
		for(var/obj/Items/Tech/F in contents)
			removeFromGlobalListeners(F)