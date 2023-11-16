/mob/proc/adjustDelay(delay)
    log2text("Delay", "Delay start of adjustments", "damageDebugs.txt", "[ckey]/[name]")
    log2text("Delay", delay, "damageDebugs.txt", "[ckey]/[name]")
    if(UsingSpeedRave())
        delay /= 1.25
    if(UsingCriticalImpact())
        delay *= 1.4
    log2text("Delay", "Delay end of adjustments", "damageDebugs.txt", "[ckey]/[name]")
    log2text("Delay", delay, "damageDebugs.txt", "[ckey]/[name]")

    return delay
