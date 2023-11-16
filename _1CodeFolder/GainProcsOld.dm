mob/proc/Meditation()
	set waitfor=0
	var/obj/Skills/Meditate/med
	for(var/obj/Skills/Meditate/m in src)
		med = m
		break
	if(med.delay)
		sleep(5)
		return

	spawn()
		if(src.VaizardHealth>0)
			src.VaizardHealth=0
		med.delayTimer()


