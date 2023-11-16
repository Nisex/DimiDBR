/mob/var/datum/vuffa/vuffa = null

/mob/proc/giveVuffaMoment()
    if(key in VuffaKeys)
        if(!findVuffa())
            vuffa = new/datum/vuffa()
        verbs += /datum/vuffa/verb/toggleVuffaMoment
        verbs += /datum/vuffa/verb/setVuffaMomentMessage

/mob/proc/findVuffa()
    if(vuffa != null)
        return vuffa
    return FALSE

/datum/vuffa
    var/vuffaMoment = 0
    var/vuffaMessage = "name is in a Vuffa Moment! They take "
/datum/vuffa/verb/toggleVuffaMoment()
    set name = "Vuffa Moment"
    set category = "Utility"
    usr.vuffa.vuffaMoment = usr.vuffa.vuffaMoment ? 0 : 1
    usr << "Vuffa Moment is now [usr.vuffa.vuffaMoment ? "on" : "off"]"

/datum/vuffa/verb/setVuffaMomentMessage()
    set name = "Set Vuffa Moment Message"
    set category = "Utility"
    usr << "Enter the message you want to display when you're in a Vuffa Moment."
    usr << "Enter \"none\" to disable the message. example: (name is in a Vuffa Moment! They take ) "
    var/input = input(src, "Enter the message you want to display when you're in a Vuffa Moment.") as text
    if(input == "none")
        usr.vuffa.vuffaMessage = null
        usr << "Vuffa Moment message disabled."
    else
        usr.vuffa.vuffaMessage = input
        usr.vuffa.vuffaMessage = replacetext(usr.vuffa.vuffaMessage, "name", usr.name)
        usr << "Vuffa Moment message set to [usr.vuffa.vuffaMessage]"
    