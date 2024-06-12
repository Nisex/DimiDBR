/mob/var/Corruption = 0
/mob/var/MaxCorruption = 100
/mob/var/MinCorruption = 0


/mob/proc/gainCorruption(n)
    if(!isRace(DEMON)) return
    if(Corruption + n < MaxCorruption)
        Corruption+=n
    if(Corruption < MinCorruption)
        Corruption = MinCorruption
    if(Corruption < 0)
        Corruption = 0
    Corruption = round(Corruption, 1)
    client.updateCorruption()
    
    //TODO: some sort of animation here

/client/var/tmp/obj/corruptionHolder = new()

/client/proc/updateCorruption()
    if(corruptionHolder)
        if(!(corruptionHolder in screen))
            corruptionHolder.screen_loc = "RIGHT-1,BOTTOM"
            screen += corruptionHolder
        
        corruptionHolder.maptext = "[mob.Corruption]/[mob.MaxCorruption]"
        corruptionHolder.maptext_width = 400
        

