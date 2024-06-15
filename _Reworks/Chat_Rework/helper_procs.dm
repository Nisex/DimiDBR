proc
	MSay(mob/defender, msg, type="says:")
		for(var/mob/E in hearers(12,defender))
			E<<"<font color=[defender.Text_Color]>[defender] [type] [msg]"
	OMsg(mob/defender, msg)
		defender.OMessage(10, "[msg]", "[defender]([defender.key]) used ([msg]).")

mob/proc/OMessage(View=10,Msg,Log)
	for(var/mob/Players/E in hearers(View,src))
		if(Msg)
			E.client.outputToChat("[Msg]", ALL_OUTPUT)
		if(Log)
			Log(E.ChatLog(),Log)