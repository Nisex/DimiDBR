/mob/proc/AdjustGrit(option, val)
    var/maxGrit = 20 * AscensionsAcquired
    switch(option)
        if("add")
            if(passive_handler["Grit"] + val <= maxGrit)
                passive_handler.Increase("Grit", val)
        if("sub")
            if(passive_handler["Grit"] - val >= 1)
                passive_handler.Decrease("Grit", val)
        if("reset")
            passive_handler["Grit"] = 0
