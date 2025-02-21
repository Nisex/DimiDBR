/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/The_Grit
	// since grit won't b used elsewhere i could just make it consume the grit on active, but that is sloppy
	// otherwise i can replace the usesX vars and make it 1 variable BUT I AM LAZY AS HELL
	Cooldown = -1
	NeedsHealth = 50
	ActiveMessage = "channels their grit and prepares for the next attack!"
	ResourceCost = list("Grit", 999) // consumes all grit on use
	adjust(mob/p)
		var/currentGrit = p.passive_handler["Grit"]
		currentGrit/=10
		VaizardHealth = currentGrit
	verb/The_Grit()
		set category = "Skills"
		Trigger(usr)


/obj/Skills/Queue/Racial/Beastman/Savagery
	BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Ripped"
	DamageMult = 1.5
	Dominator = 2
	Finisher = 2
	AccuracyMult = 1.5
	HitMessage = "tears into their enemy!"
	HitSparkIcon = 'MasterSlash.dmi'
	HitSparkX=-16
	HitSparkY=-16
	EnergyCost = 3
	Cooldown = 45


	adjust(mob/p)
		DamageMult = 1.5 + (p.AscensionsAcquired * 0.25)
		Dominator = 2 + (p.AscensionsAcquired * 0.5)
		Finisher = 2 + (p.AscensionsAcquired * 0.5)
		Cooldown = 45 - (p.AscensionsAcquired * 5)
	
	verb/Savagery()
		set category = "Skills"
		adjust(usr)
		usr.SetQueue(src)


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Ripped // TODO: make the buffedaffected attackQ work correctly n make this scale
	passives = list("PureReduction" = -0.5)
/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Beastman/Thrill_of_the_Hunt
	AlwaysOn = 1
	NeedsPassword = 1
	TimerLimit = 30
	Crippling = 15
	passives = list("Brutalize" = 1.5, "Afterimages" = 2)

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Undying_Rage
	TooMuchHealth = 1
	NeedsHealth = 0.1
	passives = list("Undying Rage" = 1)
	Cooldown = -1
	ActiveMessage = "is too angry to die!"
	adjust(mob/p)
		TimerLimit = 5 + (glob.racials.UNDYINGRAGE_DURATION* (p.AscensionsAcquired))
	Trigger(mob/User, Override)
		. = ..()
		if(!User.BuffOn(src))
			adjust(User)
/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Feather_Cowl
	EnergyCost = 5
	WoundCost = 3
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		VaizardHealth = (100-p.Health * (0.1 + (glob.racials.COWLSHIELDVAL * asc)))/10
		passives = list("Hardening" = clamp(asc, 1, 5), "Deflection" = 0.5 + (asc * 0.5), "Reversal" = 0.1 + (asc * 0.1))
		VaizardShatter = 1
	
	verb/Feather_Cowl()
		set category = "Skills"
		Trigger(usr)
	

/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Clean_Cuts
	IconLock = 'Innovator Wings.dmi'
	HitScanIcon = 'feathers.dmi'
	HitScanHitSpark = 'Slash_-_Ragna.dmi'
	EnergyCost = 6
	EnergyDrain = 0.05
	TimerLimit = 30
	Cooldown = 180
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		passives = list("Hit Scan" = 1 + (asc/2), "Momentum" = 0.5 + asc/2, "Fury" = 0.5 + asc/2, "Relentlessness" = 1, "Tossing" = clamp(asc/2, 0, 2.5))
		TimerLimit = 10 + (glob.racials.FEATHERDUR * asc)
		Cooldown = 180 - ((glob.racials.FEATHERDUR*2) * asc)
	verb/Clean_Cuts()
		set category = "Skills"
		Trigger(usr)
/mob/proc/preForm()
	if(SlotlessBuffs["Pheonix Form"] || SlotlessBuffs["Ram Form"] || SlotlessBuffs["Bear Form"] || SlotlessBuffs["Turtle Form"])
		for(var/index in SlotlessBuffs)
			if(isAChild(SlotlessBuffs[index].type, /obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Spirit_Walker))
				SlotlessBuffs[index].Trigger(src, TRUE)
				



/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Spirit_Walker
	TimerLimit = 30
	Cooldown = 120
/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Spirit_Walker/Pheonix_Form
	endAdd = -0.25
	defAdd = -0.25
	offAdd = 0.5
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		passives = list("SweepingStrikes" = 1, "Extend" = 1 + (asc/4), "Gum Gum" = 1 + (asc/4), "ComboMaster" = 1)
	verb/Pheonix_Form()
		set category = "Stances"
		usr.preForm()
		Trigger(usr)

/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Spirit_Walker/Ram_Form
	spdAdd = 0.25
	endAdd = 0.25
	offAdd = -0.25
	defAdd = -0.25
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		passives = list("Godspeed" = 1 + (asc/2), "BlurringStrikes" = clamp(asc/4, 0.25, 1), "Brutalize" = 0.5 + (asc/2))
	verb/Ram_Form()
		set category = "Stances"
		usr.preForm()
		Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Spirit_Walker/Bear_Form
	strAdd = 0.25
	defAdd = -0.5
	forAdd = 0.25
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		passives = list("StunningStrike" = 1+asc, "Combomaster" = 1,  "CheapShot" = asc/2, "Instinct" = asc)
	verb/Bear_Form()
		set category = "Stances"
		usr.preForm()
		Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Spirit_Walker/Turtle_Form
	endAdd = 0.5
	defAdd = -0.5
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		passives = list("Hardening" = 0.5 + asc/2,  "HardenedFrame" = 1, "DeathField" = 1+asc*2)
	verb/Turtle_Form()
		set category = "Stances"
		usr.preForm()
		Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Racial/Beastman/Shapeshift
	var/datum/customBuff/c_buff = new()
	proc/init(mob/p)
		c_buff.init(p, src)
	adjust(mob/p)
		if(p.BuffOn(src))
			return
		var/list/full2short = list("Strength" = "str", "Force" = "for", "Endurance" = "end", "Offense" = "off", "Defense" = "def", \
									"Speed" = "spd")
		for(var/x in full2short)
			var/raa = "[uppertext(copytext(full2short[x],1,2))][copytext(full2short[x], 2,4)]"
			vars["[raa]Mult"] = c_buff.statsadd.calc_stat(c_buff.statsmult.vars[x], TRUE)
			vars["[full2short[x]]Add"] = c_buff.statsadd.calc_stat(c_buff.statsadd.vars[x], TRUE)
		
		passives = list(c_buff.current_passives)
	verb/Shapeshift()
		set category = "Skills"
		Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Racial/Blend_In
	Invisible = 22
	ActiveMessage = "blends into their surroundings"
/obj/Skills/Projectile/Racial/Fox_Fire_Barrage
	FoxFire = 2
	Homing = 1
	Distance=30
	DamageMult=2.5
	Burning = 10
	Blasts=3
	AccMult=2
	Homing=1
	HomingCharge=1
	HomingDelay=1
	EnergyCost=8
	Delay=5
	Speed=1.5
	IconChargeOverhead=1
	IconLock = 'Elec Ball Blue.dmi'