/obj/bar/zanzo
    alpha = 255
    var/tmp/mob/owner
    New(client/_client, o, _x, _y)
        // overwrite it
        name = "Zanzoken"
        meter = new()
        holder = new(b=meter, loc_x=_x, loc_y=_y)
        client = _client
        holder.alpha = 255
        client.screen += holder
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
// so basically, we need (current + 1) - current
// or bro just do current - round(current), duh
// anyway it should be 36 (?) to fully offset it to 0, the issue is this shit is going opposite, so its -
// given this, everytime the update happens it'd be -(32 * (current - round(current)))
/mob/verb/testZanzoBarBreeze()
    set category = "Debug"
    client.add_hud("Zanzoken", new/obj/bar/zanzo(client, null, 1, 1))

/mob/verb/testZanzoCharge(n as num)
    set category = "Debug"
    client.hud_ids["Zanzoken"].meter.animateBar(n, 1)

// when it is 0 = -36
// when it is 1 = 0