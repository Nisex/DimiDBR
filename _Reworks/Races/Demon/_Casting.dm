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
/datum/queueTracker
    var/tmp/list/queue = list()
    var/TRIGGERED = null
    var/tmp/initType = null

    proc/operator+=(key_data)
        var/currentindex = length(queue) + 1
        queue.Add("filler")
        queue[currentindex] = key_data
    
    proc/trigger(t)
        world<<t
        TRIGGERED = length(queue)
        initType = t
    
    proc/detectInput(lookingFor, delay)
        var/triggerTime = queue[TRIGGERED][2]
        for(var/index in TRIGGERED to length(queue))
            if(queue[index][2] < triggerTime + delay)
                continue
            // ignore everything that happens between the delay and last press
            if(lookingFor != queue[index][1])
            
                // you have misinputted
                TRIGGERED = null
                initType = null
                queue = list(1 = list(123, world.time-2))
                return FALSE
            else
                TRIGGERED = null
                initType = null
                queue = list(1 = list(123, world.time-2))
                return TRUE
        return -1
// needs to be cleaned up ^
/client/var/tmp/datum/queueTracker/keyQueue = new()



/client/var/tmp/trackingMacro = null
// need to define in the loop that when this is active to make it track for this skill








/mob/verb/testQueue()
    set category = "Queue Test"
    client.keyQueue+=list("A", world.time)
    client.keyQueue.trigger()
    sleep(1)
    client.keyQueue+=list("B", world.time)
    sleep(1)
    client.keyQueue+=list("C", world.time)
    sleep(1)
    client.keyQueue+=list("G", world.time)
    sleep(1)
    client.keyQueue+=list("B", world.time)
    sleep(1)
    client.keyQueue+=list("F", world.time)
    sleep(1)
    client.keyQueue+=list("R", world.time)
    sleep(1)
    client.keyQueue+=list("T", world.time)
    client.keyQueue.detectInput("B", 4)