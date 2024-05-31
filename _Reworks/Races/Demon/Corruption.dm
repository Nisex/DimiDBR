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
    
    //TODO: some sort of animation here