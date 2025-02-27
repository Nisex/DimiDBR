/obj/leftOver
    Grabbable = 0
    Attackable = 0
    Destructable = 0
    density = 0
    var/power
    var/lifetime
    var/tmp/mob/owner
    var/tmp/list/tick_on = list()
    var/proc_to_call
    var/proc_params
    var/inflicts_owner = FALSE
    
/obj/leftOver/proc/on_tick()
    for(var/mob/m in tick_on)
        if(proc_to_call)
            call(m,proc_to_call)(list2params(proc_params))

/obj/leftOver/Cross(atom/movable/O)
    if(ismob(O) && O != owner)
        tick_on |= O
    . = ..()

/obj/leftOver/Uncross(atom/movable/O)
    if(ismob(O) && O != owner)
        if(O in tick_on)
            tick_on -= O
    . = ..()

/obj/leftOver/Update()
    lifetime-=world.tick_lag
    if(lifetime<=0)
        ticking_generic -= src
        owner = null
        tick_on = null
        loc = null
    else
        on_tick()

/obj/leftOver/proc/on_death()
    ticking_generic -= src
    owner = null
    tick_on = null
    loc = null
/obj/leftOver/proc/init()
    ticking_generic += src
    owner = p
    for(var/mob/m in loc)
        tick_on |= m

/obj/leftOver/Blood
    icon = 'Blood Floor.png'
    pixel_x = -9
    bound_height = 32
    bound_width = 32
    alpha= 0 
    New(turf/T, mob/p, style_value)
        loc = locate(T.x, T.y, T.z)
        alpha = 0
        lifetime = (5 SECONDS) * style_value
        init()
        animate(src, alpha = 255, time = 5, easing = ELASTIC_EASING)
    Cross(atom/movable/O)
        if(ismob(O) && O != owner)
            var/mob/Player/p = O
            if(!p.Swim)
                p.Swim = 1
                tick_on |= O
        . = ..()

    Uncross(atom/movable/O)
        if(ismob(O) && O != owner)
            var/mob/Player/p = O
            if(p.Swim)
                p.Swim = 0
                tick_on -= O
        . = ..()
    
    on_death()
        for(var/mob/p in tick_on)
            if(p.Swim)
                p.Swim = 0
        ..()
    
    on_tick()
        if(alpha == 0)
            animate(src, alpha = 255, time = 5, easing = ELASTIC_EASING)
        // do nothing

        
/obj/leftOver/poisonCloud
    icon = 'PoisonGas.dmi'
    power = 1
    lifetime = 15 SECONDS
    pixel_x = -32
    pixel_y = -32
    bound_height = 64
    bound_width = 64
    alpha = 0
    New(turf/_loc, mob/p, style_value)
        loc = locate(_loc.x,_loc.y,_loc.z)
        alpha = 0
        power = 2+style_value
        lifetime = (15 SECONDS) * style_value
        proc_params = list("Value" = style_value*glob.DEBUFF_INTENSITY, "Attacker" = owner)
        init()
        animate(src, alpha = 255, time = 5, easing = ELASTIC_EASING)
    on_death()
        animate(src, alpha = 0, time = 5, easing = ELASTIC_EASING)
        spawn(2)
            ..()


    Update()
        lifetime-=world.tick_lag
        if(alpha==0)
            animate(src, alpha = 255, time = 5, easing = ELASTIC_EASING)
        if(lifetime<=0)
            on_death()
        else
            on_tick()

        



