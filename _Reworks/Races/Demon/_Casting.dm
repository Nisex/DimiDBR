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
    var/list/queue = list()
    var/TRIGGERED = FALSE

    proc/operator+=(key_data)
        var/currentindex = length(queue) + 1
        queue.Add("filler")
        queue[currentindex] = key_data
        world<<"added a key"
    
    proc/trigger()
        TRIGGERED = length(queue)
    
    proc/detectInput(lookingFor, delay)
        var/triggerTime = queue[TRIGGERED][2]
        for(var/index in TRIGGERED to length(queue))
            if(queue[index][2] < triggerTime + delay)
                continue
            // ignore everything that happens between the delay and last press
            if(lookingFor != queue[index][1])
                // you have misinputted
                world<<"you have misinputted"
                break
            else
                world<<"execute thing from LookingFor prob return true or soething"
                break
// needs to be cleaned up ^
/client/var/tmp/datum/queueTracker/keyQueue = new()

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