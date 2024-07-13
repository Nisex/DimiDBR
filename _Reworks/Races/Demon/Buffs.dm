/obj/Skills/Buffs/SlotlessBuffs/True_Form/Demon
	passives = list("HellPower" = 0.1, "AngerAdaptiveForce" = 0.25, "TechniqueMastery" = 2, "Juggernaut" = 0.5, "FakePeace" = -1)
	Cooldown = -1
	TimerLimit = 0
	BuffName = "True Form"
	name = "True Form - Demon"
	IconLock='DarkInstinct.dmi'
	IconLockBlend=BLEND_MULTIPLY
	LockX=-32
	LockY=-32
	var/list/trueFormPerAsc = list( 1 = list("AngerAdaptiveForce" = 0.25, "TechniqueMastery" = 2, "Juggernaut" = 1, "Hellrisen" = 0.25), \
									2 = list("AngerAdaptiveForce" = 0.25,"TechniqueMastery" = 4, "FluidForm" = 1, "GiantForm" = 1, "Juggernaut" = 1.5, "Hellrisen" = 0.5), \
									3 = list("AngerAdaptiveForce" = 0.5,"TechniqueMastery" = 6, "FluidForm" = 1.5, "GiantForm" = 1, "Juggernaut" = 2,"Hellrisen" = 0.5), \
									4 = list("AngerAdaptiveForce" = 0.5,"TechniqueMastery" = 8, "FluidForm" = 2, "GiantForm" = 1, "Juggernaut" = 2,"Hellrisen" = 0.5,))
	ActiveMessage = "<i>has unleashed their true nature!</i>"
	// jsut set the niggas hellpower to 1
	adjust(mob/p)
		for(var/passive in trueFormPerAsc[p.AscensionsAcquired])
			passives[passive] = trueFormPerAsc[p.AscensionsAcquired][passive]
		var/hellpowerdif = 1 - p.passive_handler.Get("HellPower")
		if(hellpowerdif < 0)
			hellpowerdif = 0
		passives["HellPower"] = hellpowerdif
	verb/True_Form()
		set category = "Skills"
		if(!usr.BuffOn(src))
			adjust(usr)
			var/yesno = input(usr, "Are you sure?") in list("Yes", "No")
			if(yesno == "Yes")
				OMsg(usr, "<b>[usr] has revealed their true nature as a <i>[glob.DEMON_NAME]</i></b>")
			else
				return 0
		src.Trigger(usr)