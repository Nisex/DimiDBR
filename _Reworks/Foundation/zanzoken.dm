/obj/bar/zanzo
    alpha = 255
    maptext_x = 16
    maptext_y = 4
    var/tmp/mob/owner
    New(client/_client, o, _x, _y)
        // overwrite it
        name = "Zanzoken"
        meter = new()
        holder = new(b=meter, loc_x=_x, loc_y=_y)
        barbg = new("zanzoken")
        barbg.screen_loc = "1:[_x-1],1:[_y-2]"
        client = _client
        holder.alpha = 255
        client.screen += holder
        client.screen += barbg
        meter.animateBar(0,4)
        owner = client.mob

    Update(add, total_charges)
        if(total_charges >= 3)
            meter.color = "#F00"
        else if(total_charges >= 2)
            meter.color = "#0f0"
        else 
            meter.color = "#666"
        meter.animateBar(add, world.tick_lag)
        holder.maptext = "[total_charges]"