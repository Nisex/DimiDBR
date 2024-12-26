
/obj/plane_test
    plane = 11
    appearance_flags = PLANE_MASTER | PIXEL_SCALE
    screen_loc = "1,1"
    mouse_opacity = 0
    layer = BACKGROUND_LAYER

/obj/dorkness
    icon = 'blackcutin.dmi'
    alpha = 0
    layer = FLY_LAYER

/obj/lightness
    icon = 'lightcutin.dmi'
    alpha = 0
    layer = FLY_LAYER

/obj/flicker
    icon = 'flickercutin.dmi'
    alpha = 0
    layer = FLY_LAYER

// prob shouldn't make more objs, but w/e

/*

/mob/verb/testBeast()
    set category = "Debug"
    var/oldview = client.view
    Quake(30)
    client.eye = locate(50,50,21)
    client.perspective = EDGE_PERSPECTIVE
    client.edge_limit = "SOUTHWEST to NORTHEAST"
    var/obj/blankHolder = new()
    var/obj/dorkness/dorkness = new()
    var/obj/lightness/lightness = new()
    var/obj/i2 =new()
    i2.icon = 'Cut in Underlay-min.dmi'
    var/obj/i3 =new()
    i3.icon = 'Cut in Underlay-min.dmi'
    i3.pixel_y=672

    var/obj/i = new()
    i.icon = 'Cut in Overlay.dmi'
    i.screen_loc = "LEFT,BOTTOM"
    i.layer = FLY_LAYER
    blankHolder.vis_contents += i

    blankHolder.screen_loc = "LEFT,BOTTOM"
    client.screen += blankHolder
    blankHolder.vis_contents+=dorkness
    i2.vis_contents += i3
    blankHolder.vis_contents += i2

    // animation start
    animate(i2, pixel_y=-64,time = 20)
    flick("", i)
    sleep(15)
    animate(dorkness, alpha = 255, time = 10)
    sleep(15)
    del i
    del i2
    del i3
    dorkness.alpha = 0
    blankHolder.vis_contents-=dorkness
    // del blankHolder

    var/obj/plane_test/plane_master = new()
    plane_master.screen_loc = "LEFT,BOTTOM"
    client.screen += plane_master
    var/obj/bleh = new()
    bleh.appearance = src.appearance
    bleh.screen_loc = "CENTER,CENTER"
    bleh.appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
    bleh.dir = SOUTH

    var/obj/test = new()
    test.icon = 'SharinganEyes.dmi'
    test.appearance_flags = PIXEL_SCALE | KEEP_TOGETHER
    test.layer = MOB_LAYER


    plane_master.vis_contents += bleh
    plane_master.vis_contents += test
    blankHolder.vis_contents += lightness
    blankHolder.vis_contents += dorkness
    animate(plane_master, transform=matrix().Scale(126), time = 20, easing = CUBIC_EASING)
    sleep(30)
    lightness.alpha = 255
    sleep(2)
    lightness.alpha = 0
    dorkness.alpha = 255
    sleep(2)
    lightness.alpha = 255
    dorkness.alpha = 0
    sleep(2)
    lightness.alpha = 0
    del dorkness
    del test
    plane_master.screen_loc = "CENTER,CENTER"
    animate(plane_master, transform=matrix())
    client.view = oldview
    var/datum/effect/Test2/t = new(bleh, 250)
    t.emitters[1].alpha = 155
    animate(t.emitters[1], alpha = 255, time = 20)
    sleep(80)
    animate(lightness, alpha = 255, time = 2)
    del t
    sleep(10)
    plane_master.vis_contents -= bleh
    del bleh
    lightness.alpha = 0
    blankHolder.vis_contents -= lightness
    del blankHolder
    del lightness
    client.eye = src*/