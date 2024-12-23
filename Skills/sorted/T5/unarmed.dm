/obj/Skills/var/HarderTheyFall = 0
/obj/Skills/Grapple/The_Show_Stopper
    SkillCost=TIER_5_COST
    Stunner=8
    DamageMult=12
    HarderTheyFall=5
    StrRate=2
    ForRate=0
    Effect="ShowStopper"



/mob/var/tmp/last_jump_animation = 0
/mob/verb/testJump()
    set category = "Debug"
    jump_animation(locate(x+10,y+10,z))
    
// CREDIT: Xerif 
/mob/proc/jump_animation(turf/target_turf)
	last_jump_animation = world.time

	var/pixel_x_location = round(1 + ((x - target_turf.x) * -32), 16)
	var/pixel_y_location = round(1 + ((y - target_turf.y) * -32), 16)

	var/jump_time = 2 * get_dist(src, target_turf)

	var/matrix/M = matrix()
	M.Translate(0, 100)

	dir = get_dir(src, target_turf)

	var/image/I = image(src, icon_state = "Fly", layer = 9001)
	I.loc = src
	I.override = 1
	world << I

	var/image/shadow = image('small_shadow.dmi')
	shadow.loc = src
	shadow.alpha = 0
	world << shadow

	animate(I, transform = M, time = jump_time / 2, easing = QUAD_EASING|EASE_OUT)
	animate(transform = null, time = jump_time / 2, easing = QUAD_EASING|EASE_IN)

	animate(src, pixel_x = pixel_x_location, pixel_y = pixel_y_location, time = jump_time, easing = LINEAR_EASING)
	animate(client, pixel_x = pixel_x_location, pixel_y = pixel_y_location, time = jump_time, easing = LINEAR_EASING)

	animate(shadow, alpha = 100, time = jump_time / 2, easing = QUAD_EASING|EASE_OUT)
	animate(alpha = 0, time = jump_time / 2, easing = QUAD_EASING|EASE_IN)


	var/old = animate_movement
	animate_movement = 0

	sleep(jump_time)

	del(I)
	del(shadow)

	transform = null
	pixel_x = 0
	pixel_y = 0
	client.pixel_x = 0
	client.pixel_y = 0

	src.loc = target_turf

	spawn(1)
		animate_movement = old
		layer = 4