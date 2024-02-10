/mob/Player/AI/GIGASpiritSummon
    var/list/voicelines = list("attack" = list(), \
                        "dash" = list(), \
                        "reverse_dash" = list(), \
                        "assist" = list())
    var/glow_filter    
    var/last_decision = "idle"
    var/last_decision_extended = "none"
/mob/Player/AI/GIGASpiritSummon/New()
    if(!passive_handler)
        passive_handler = new()
    ..() 


/mob/Player/AI/GIGASpiritSummon/proc/vanish()
    animate(src, alpha=0, time = 10, easing=SINE_EASING)
/mob/Player/AI/GIGASpiritSummon/proc/appear(mob/p)
    src.loc = locate(p.x, p.y, p.z)
    animate(src, alpha=255, time = 15, easing=SINE_EASING)
/mob/Player/AI/GIGASpiritSummon/proc/initSkills()
