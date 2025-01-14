mob/proc/InterceptionStrike(stacks)
    var/obj/Skills/AutoHit/Counter/_counter
    for(var/obj/Skills/AutoHit/Counter/c in src)
        _counter = c
    if(!_counter)
        AddSkill(_counter)
    _counter.adjust(src, stacks)
    Activate(_counter)

/mob/proc/canFaJin()
    if(passive_handler["Fa Jin"])
        if(last_fa_jin + glob.FA_JIN_BASE_COOLDOWN - (passive_handler["Fa Jin"] * glob.FA_JIN_COOLDOWN_REDUCTION) < world.time)
            return TRUE
    return FALSE

/obj/fa_jin
    icon = 'fa_jin.dmi'
    layer = FLY_LAYER

/mob/var/tmp/last_fa_jin = 0 
/mob/var/tmp/obj/fa_jin/fa_jin_effect


/mob/proc/fa_jin_effect()
    if(!fa_jin_effect)
        // exists
        fa_jin_effect = new()
        vis_contents += fa_jin_effect
    else
        if(fa_jin_effect.alpha == 255)
            animate(fa_jin_effect, alpha = 0)
        else
            animate(fa_jin_effect, alpha = 255)
    
    


/mob/verb/testFaJinEffect()
    fa_jin_effect()