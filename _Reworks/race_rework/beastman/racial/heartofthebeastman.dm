/mob/proc/AdjustGrit(option, val)
    var/maxGrit = 20 * AscensionsAcquired
    switch(option)
        if("add")
            if(passive_handler["Grit"] + val <= maxGrit)
                passive_handler["Grit"] += val
        if("sub")
            if(passive_handler["Grit"] - val >= 0)
                passive_handler["Grit"] -= val
        if("reset")
            passive_handler["Grit"] = 0
