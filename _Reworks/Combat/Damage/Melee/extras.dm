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
    alpha = 0
    pixel_x = -12
    pixel_y = 12

/mob/var/tmp/last_fa_jin = 0 
/mob/var/tmp/obj/fa_jin/fa_jin_effect

/mob/proc/generate_fa_jin()
    if(!fa_jin_effect)
        // exists
        fa_jin_effect = new()
        vis_contents += fa_jin_effect
        animate(fa_jin_effect, alpha = 255, time=2)
/mob/proc/fa_jin_effect()
    if(fa_jin_effect.alpha == 255)
        animate(fa_jin_effect, alpha = 0, time=2)
    else
        animate(fa_jin_effect, alpha = 255, time=2)
    
    


/mob/verb/testFaJinEffect()
    set category = "Debug"
    fa_jin_effect()

/obj/FTG_seeker
    icon = 'kunai.dmi' // make this changable w/ the style
    var/tmp/mob/owner
    var/tmp/mob/target
    New(loc, _target, _owner)
        . = ..()
        //if(owner.styleActive?:FTG_icon)
            //icon = FTG_icon
        filters = list(filter(type="motion_blur", x=0,y=0), filter(type="outline"))
        target = _target
        owner = _owner
        ticking_generic += src
    proc/end_effect()
        owner.Comboz(target,)
        LightningBolt(target, 1)
        ticking_generic-=src
        del src
    Update()
        // get distance, increase speed the further they move, prob
        if(src.loc == target.loc)
            end_effect()
        else
            var/distance = get_dist(src, target)
            if(distance >= 6)
                distance*=2
            step_towards(src, target, 32 * (1.5 + distance/10))   
