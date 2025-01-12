/obj/Bar
	icon = 'smallbar.dmi'
	icon_state = "fill"
	plane = FLOAT_PLANE
	layer = FLOAT_LAYER
	blend_mode = BLEND_INSET_OVERLAY
	proc/animateBar(x_offset, time2death)
		animate(src, pixel_x = x_offset, time=time2death, easing = SINE_EASING)
/obj/Container
	appearance_flags = KEEP_TOGETHER
	icon = 'smallbar.dmi'
	icon_state = "background"
	New(newloc, obj/Bar/b)
		vis_contents += b

/obj/barbg
	icon = 'barbgs.dmi'
	New(state)
		icon_state = state

		

client/var/list/hud_ids = list()

client/proc/add_hud(id, atom/movable/a)
	screen += hud_ids[id] = a
	return a
client/proc/remove_hud(id)
	screen -= hud_ids[id]
	mob.contents -= hud_ids[id]
	if(hud_ids[id])
		del hud_ids[id] // it should already b gone but 2 make sure, who knows
	hud_ids -= id

/obj/bar
	var/tmp/linked_var = ""
	var/obj/Bar/meter
	var/obj/Container/holder
	var/obj/barbg/barbg
	screen_loc = "LEFT,BOTTOM"
	icon = 'smallbar.dmi'
	var/tmp/client/client
	New(client/_client, o, _x, _y)
		name = "screen object"
		client = _client
		meter = new()
		holder=new(b=meter)
		linked_var = o
		holder.layer = FLY_LAYER+0.1
		holder.screen_loc = "1:[_x],1:[_y]"
		barbg = new(o)
		barbg.screen_loc = "1:[_x],1:[_y-7]"
		barbg.maptext = "<small>[client.mob.vars["[linked_var]"]]"
		barbg.maptext_y = 12
		barbg.maptext_width = 62
		client.screen+=holder
		client.screen+=barbg
		meter.animateBar(-32,4)
	Update()
		barbg.maptext = "<small>[client.mob.vars["[linked_var]"]]"
		var/gap = 32 - glob.vars["MAX_[uppertext(linked_var)]_STACKS"] 
		if(client.mob.vars["[linked_var]"] > glob.vars["MAX_[uppertext(linked_var)]_STACKS"] )
			meter.animateBar(clamp(client.mob.vars["[linked_var]"]/3, 0, 32) - 32,glob.STACK_ANIMATE_TIME)
		else
			if(client.mob.vars["[linked_var]"] <= gap)
				gap = 0
			meter.animateBar(clamp(client.mob.vars["[linked_var]"]+gap, 0, 32) - 32,glob.STACK_ANIMATE_TIME)

#define BAR_X_LOCS list("Fury" = 1, "Momentum" = 1, "Harden" = 1)
#define BAR_Y_LOCS list("Fury" = 80, "Momentum" = 124, "Harden" = 168)

/mob/proc/hudIsLive(option)
	if(client.hud_ids[option])
		return TRUE
	else 

		client.add_hud(option, new/obj/bar(client, option, BAR_X_LOCS[option], BAR_Y_LOCS[option]))
	

/mob/verb/test_stacks()
	set category = "Debug"
	Fury = 20
	Harden = 40
	Momentum = 80