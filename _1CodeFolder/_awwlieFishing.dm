/** 
 * basically
 * we want a to add few objects to the players screen. 
 * a fishing lake / a hole 
 * then we want to add fish to that said screen. 
 * if they hit the fish at a correct moment or something like that, they catch the fish. 
 * 
 * erm this was a good thing,
 * but, 
 * 
 * make it so we have a obj called fishing rod, if a fish bumps()
 * we catch fish ?
 * mby more cool.
 */
mob
	var
		tmp/obj/fishing_ui/ui
	verb
		Test_open()
			if(!ui)
				ui = new(usr)
			usr.client.screen.Add(ui)
		Test_close()
			usr.client.screen.Remove(ui)
			for(var/obj/fish/A in ui.vis_contents)
				del(A)
				ui.vis_contents = list()
			del ui
				


obj
	fishing_ui
		screen_loc = "CENTER-8, CENTER-8"
		plane = 1000
		layer = 5
		icon = 'Icons/awwlieFishing/background.dmi'
		icon_state = "background"

		var
			tmp
				list/sizes = list("<b>LARGE</b>", "<b>MEDIUM</b>", "<b>SMALL</b>")
				list/fishes = list("Cod", "Trout", "Bass", "Catfish", "Tarpfish", "Seadragon", "Blobfish")
				rarity = list("<font color = gray><b>COMMON</b></font>","<font color = white<b>UNCOMMON</b></font>" ,"<font color = red> <b>RARE</b></font>", "<font color = violet><b>LEGENDARY</b></font>")
				mob/parent = null


		New(new_parent)
			..()
			parent = new_parent
			spawn(10)
				spawnFish()
				
		proc
			spawnFish()
				var/number = rand(1,10)
				src.vis_contents = list()
				spawn()
					for(var/counter = 0, counter < number, counter++ )
						sleep(rand(1,50))
						var/obj/fish/A = new
						A.pixel_y = rand(1,448)
						A.Reversed = pick(TRUE, FALSE)
						A.alpha = 1
						if(A.Reversed)
							A.pixel_x = 1001
						src.vis_contents.Add(A)
						A.name = "[pick(rarity)] [pick(sizes)] - [pick(fishes)]"
						spawn()
							A.fishMovementLoop()
							src.vis_contents.Remove(A)
	
					
	fish
		icon = 'AngryFishmanRed.dmi'
		icon_state = "KO"
		plane = 1001
		layer = 7
		var
			type_fish = null
			tmp/struggle = 4
			var/Reversed = FALSE
		Click()
			usr << "You have caught a [src]."
			del(src)

		proc/fishMovementLoop()
			var/timeToCatch = rand(10, 160)
			while(src)
				sleep(10)
				if(Reversed && src.pixel_x > 1000)
					animate(src, alpha = 255, time = 0.2, easing = CUBIC_EASING | EASE_OUT)
					animate(src, pixel_x = 0, time = timeToCatch, easing = QUAD_EASING)

				if(!Reversed && src.pixel_x < 1 )
					animate(src, alpha = 255, time = 0.2, easing = CUBIC_EASING | EASE_OUT)
					animate(src, pixel_x = 1050, time = timeToCatch, easing = QUAD_EASING)
				world << src
				spawn(timeToCatch)
					usr << "You missed [src], as it swims away."
					del(src)
			return .