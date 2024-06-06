#define BROADCAST_RANGE 12
#define BROADCAST_COLOR "<font color=green>"
var/tmp/list/globalListeners = list()

proc/addToGlobalListeners(obj/Items/Tech/listener)
	if(globalListeners["[listener.Frequency]"])
		globalListeners["[listener.Frequency]"] |= listener
	else
		globalListeners += listener.Frequency
		globalListeners["[listener.Frequency]"] = list(listener)

proc/removeFromGlobalListeners(obj/Items/Tech/listener)
	if(globalListeners[listener.Frequency])
		globalListeners[listener.Frequency] -= listener

obj/Items/Tech/proc/broadcastToListeners(msg)
//	if(!Active) return
	if(!Frequency) return
	for(var/obj/Items/Tech/i in globalListeners["[Frequency]"])
		i.recieveBroadcast(msg)

obj/Items/Tech/proc/recieveBroadcast(msg)
//	if(!Active) return
	if(!Frequency) return
	if(ismob(loc))
		var/broadcastFormattingPersonal = "[BROADCAST_COLOR]<b>([name])</b>[msg]"
		var/mob/owner = loc
		if(owner.client)
			owner.client.outputToChat(broadcastFormattingPersonal, IC_OUTPUT)
			Log(owner.ChatLog(),broadcastFormattingPersonal)
			Log(owner.sanitizedChatLog(),broadcastFormattingPersonal)
	else
		var/broadcastFormattingAllAround = "[BROADCAST_COLOR]<b>([name]) crackles to life from the floor:</b>[msg]"
		OMsg(BROADCAST_RANGE,broadcastFormattingAllAround)


mob/Players/
	Login()
		..()
		for(var/obj/Items/Tech/F in contents)
			if(!F.Frequency) continue
			addToGlobalListeners(F)

	Logout()
		..()
		for(var/obj/Items/Tech/F in contents)
			if(!F.Frequency) continue
			removeFromGlobalListeners(F)