/mob/proc/log2text(attribute, value, filename, src_key)
    if(!glob.TESTER_MODE)
        return
    if(!src_key)
        return
    var/f = file("Saves/damageLogs/[time2text(world.realtime, "MM-DD-YYYY")]/[src.ckey]/[filename]")
    if(f)
        f << "[time2text(world.realtime, "MM-DD-YYYY")]|[world.time] - [src_key] - [attribute] - [value]\n"
    else
        world<<"Error! Could not open file!"