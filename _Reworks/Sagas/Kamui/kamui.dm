mob/proc/getSenketsuViewers()
    var/count = 0
    var/viewDistance = passive_handler.Get("Shameful Display") * 3 + 15
    for(var/mob/m as anything in players)
        if(see_invisible > m.invisibility && getdist(src, m) <= viewDistance)
            count++
    return count