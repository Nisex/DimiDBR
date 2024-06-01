// how do we do this


 /*
    on press -> trigger qTracker
    qTracker will start to track
    every key will be noted list(index = list("key", timepressed in ticks, TRIGGER = TRUE/FALSE))
    MAKE SURE TO IGNORE KEY INPUTS THAT ARE NORTH/SOUTH/EAST/WEST!!
    WHEN DONE TRACKING REMOVE THE ENTIRE THING

    on the 2nd cast, retrieve the list, make sure it is possible
    biggest issue with this is if you hit Q -> w -> -> W -> w
    hypothetically it will b impossible to complete, we must denote that Q is the start, and anything after is the thing, but anything that is done within the given time doesn't count
    so depending on the ms between the Q and the key will determine if it goes off or not
 */ 
#define LEEWAY_TIME 15


/datum/queueTracker
    var/tmp/list/queue = list(1 = list("123", -2))
    var/tmp/TRIGGERED = null
    var/tmp/initType = null
    var/tmp/LAST_CAST = -100

    proc/operator+=(key_data)
        var/currentindex = length(queue) + 1
        queue.Add("filler")
        queue[currentindex] = key_data
    
    proc/trigger(t)
        TRIGGERED = length(queue)
        initType = t
    
    proc/detectInput(lookingFor, delay)
        var/triggerTime = queue[TRIGGERED][2]
        for(var/index in TRIGGERED to length(queue))
            if(queue[index][2] < triggerTime + delay)
                continue
            // ignore everything that happens between the delay and last press
            if(queue[index][2] < triggerTime + (delay + LEEWAY_TIME) ) // they are in the grace
                if(lookingFor != queue[index][1])
                    continue
                else
                    TRIGGERED = null
                    initType = null
                    queue = list(1 = list("123", world.time-2))
                    return TRUE 
            else
                if(lookingFor != queue[index][1])
                    // you have misinputted
                    TRIGGERED = null
                    initType = null
                    queue = list(1 = list("123", world.time-2))
                    return FALSE
                else
                    TRIGGERED = null
                    initType = null
                    queue = list(1 = list("123", world.time-2))
                    return TRUE
        return -1
// needs to be cleaned up ^
/client/var/tmp/datum/queueTracker/keyQueue = new()



/client/var/tmp/trackingMacro = null
// need to define in the loop that when this is active to make it track for this skill




/obj/castingSpeechHolder
    var/toDeath = 40
    var/tmp/mob/owner = null
    maptext_width = 64
    maptext_height = 64
    alpha = 0
    New(msg, textColor, life, mob/p)
        companion_ais += src
        toDeath = life ? life : 50
        maptext = "<font color='[textColor]'><font size=small>[msg]</font>"
        filters = filter(type = "drop_shadow", size = 2, color = rgb(244, 244, 26, 126))
        animate(src, pixel_y = 36, time = 20)
        animate(src, alpha = 255, time = 20)
        owner = p
        p.vis_contents += src 
        ..()
    
    Update()
        toDeath--
        if(toDeath == 20)
            animate(src, alpha = 0, time = 20)
            animate(src, pixel_y = 0, time = 20)
        if(toDeath <= 0)
            companion_ais-=src
            owner.vis_contents -= src
            del src

            
/mob/proc/castAnimation()
    var/static/list/phrases = list("parvus pendetur fur, magnus abire videtur", "para bellum", "parturiunt montes, nascetur ridiculus mus", \
                                    "Pericula ludus", "principiis obst, et respice finem", "pro se", "pro scientia atque sapientia", "propria manu ", \
                                    "ad vitam aut culpam", "aut vincere aut mori", "cor aut mors", "esto perpetua", "usque ad finem")
    new/obj/castingSpeechHolder(pick(phrases), Text_Color, null, src)