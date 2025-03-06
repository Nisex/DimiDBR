/obj/Items/Sword/Light/Nox
	LegendaryItem = 1
	Ascended = 5
	Destructable = 0
	Unobtainable = 1

/obj/Items/Sword/Light/Nox/Ouroboros
	name = "Geminus Anguium: Ouroboros"
	desc = {"The Snake Pair: Ouroboros (蛇双・ウロボロス Jasō: Uroborosu, localized as Geminus Anguium: Ouroboros) is an Arch-Enemy Event Weapon in the shape of a black snake head attached to a never-ending chain.
Ouroboros is summoned from a special space, and can directly attack the soul or mind of the target."}
	passives = list("SwordPunching" = 1, "Extend" = 1, "Grippy" = 3, "CalmAnger" = 1, "AngerThreshold" = 1.5, "RenameMana" = "HEAT")
	NoSaga=1
	CalmAnger=1
	MagicSword=1
	icon = 'ouroboros (1).dmi'
	pixel_x = -32
	pixel_y = -32
	// Element="Void"
	// void offense would have 2 do something
	Techniques=list("/obj/Skills/Utility/Ouroboros", "/obj/Skills/AutoHit/Ouroboros/Devouring_Fang", "/obj/Skills/AutoHit/Ouroboros/Rising_Fang", "/obj/Skills/AutoHit/Ouroboros/Falling_Fang", \
					"/obj/Skills/Projectile/Ouroboros/Hungry_Coils", "/obj/Skills/Ouroboros/Serpents_Redemption", "/obj/Skills/Ouroboros/Serpents_Pull")


/*
we have an ouroboros skill that is needed to be activated in order to use other moves
each move it calls out to  has its own seperate cooldown

idea: if you use x y z in order you cast a, which consumes mana
ech move's dammage and etc scales with potential
crisis buff probably, might as well fuck it right ?

each ouro skill is like 30-45 cd

grab skillshot proj will snare the enemy
make a skill that reqs them to be snared in order to use
thsi way we can make it seem like a 'reactionary' skill activation, but its only really looking for them to be in that state annd not technically hit by that move specifically


the utility skill holds if it is in use as well as the last used, and the last input
when the last three inputs are a combo is will result in a super (?)


*/
// DEBUG //

/mob/Admin4/verb/giveOuroboros()
	src.contents += new/obj/Items/Sword/Light/Nox/Ouroboros
	AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Nox/The_Unholy_Wrath_of_the_Basilisk)



/mob/proc/inRekka()
	var/obj/Skills/Utility/Ouroboros/oo = FindSkill(/obj/Skills/Utility/Ouroboros)
	if(oo)
		if(glob.OUROMACROLOCK && oo.last_pressed + glob.OUROMACROLOCK > world.time)
			src << "You pressed too fast! (Ouroboros MACROLOCK is on.)"
			return FALSE
		if(oo.Using)
			return oo
	return FALSE

/obj/Skills/Utility/Ouroboros
	var/last_triggered = ""
	var/list/inputQueue = list()
	var/tmp/last_pressed = -9999

	verb/Ouroboros()
		set category = "Skills"
		if(!Using)
			if(glob.OUROMACROLOCK)
				last_pressed = world.time
			Using = 1
			if(usr.hudIsLive("Oro", /obj/orohud))
				usr.client.hud_ids["Oro"].filters = list(type="outline", size=1, color=rgb(255, 255, 255))
				animate(usr.client.hud_ids["Oro"], alpha = 255, time = 3)
		else
			Using = 0
			if(usr.client.hud_ids["Oro"])
				animate(usr.client.hud_ids["Oro"], alpha = 0, time = 3)

/obj/orohud
	icon = 'orohud.dmi'
	screen_loc = "1:1,1:128"


/obj/Skills/AutoHit/Ouroboros/Devouring_Fang
	Area = "Arc"
	AdaptRate = 1
	DamageMult = 1
	Distance = 2
	TurfStrike=1
	GuardBreak = 1
	ComboMaster = 1
	TurfShift='ouroborostile.dmi'
	HitSparkIcon='BLANK.dmi'
	TurfShiftDuration=6
	TurfShiftDurationSpawn = 1
	TurfShiftDurationDespawn = 5
	TurfShiftX = -6
	TurfShiftY = -6
	// Cooldown = 45

	adjust(mob/p)
		DamageMult = 1.5 + (p.Potential/25)
		// Cooldown = 45 - (p.Potential/10)
	verb/Devouring_Fang()
		set category = "Skills"
		var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
		if(oo)
			adjust(usr)
			var/acitvated = usr.Activate(src)
			if(acitvated)
				oo.Ouroboros()
				oo.last_triggered = name
			oo.inputQueue.Add(name)

/obj/Skills/AutoHit/Ouroboros/Rising_Fang

	Area="Arc"
	Distance=1
	AdaptRate = 1
	Launcher = 4
	DamageMult=1
	Hit
	// Cooldown=45 
	TurfShift='ouroborostile.dmi'
	TurfShiftDuration=6
	TurfShiftDurationSpawn = 1
	TurfShiftDurationDespawn = 5
	adjust(mob/p)
		DamageMult = 1.5 + (p.Potential/25)
		// Cooldown = 45 - (p.Potential/10)
	verb/Rising_Fang()
		set category = "Skills"
		var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
		if(oo)
			adjust(usr)
			usr.Activate(src)
			oo.Ouroboros()

/obj/Skills/AutoHit/Ouroboros/Falling_Fang
	Area="Cone"
	Distance=1
	AdaptRate = 1
	Dunker = 1
	DamageMult=1
	// Cooldown=45 
	TurfShift='ouroborostile.dmi'
	TurfShiftDuration=6
	TurfShiftDurationSpawn = 1
	TurfShiftDurationDespawn = 5
	adjust(mob/p)
		DamageMult = 1.5 + (p.Potential/25)
		Dunker = 1 + (p.Potential/25)
		// Cooldown = 45 - (p.Potential/10)
	verb/Falling_Fang()
		set category = "Skills"
		var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
		if(oo)
			adjust(usr)
			usr.Activate(src)
			oo.Ouroboros()

/obj/Skills/Projectile/Ouroboros/Hungry_Coils
	Distance=1
	DamageMult=1
	AccMult=99
	Deflectable=0
	Dodgeable=0
	Striking=1
	Radius=1
	// Cooldown=30
	IconLock='ouroboros_blast.dmi'
	IconSize=0.5
	Variation=0
	Devour = 1
	Snaring = 1
	LockX=-32
	LockY=-16
	adjust(mob/p)
		Distance = 4 + round(p.Potential/25, 1)
		Speed = world.tick_lag*3 - (p.Potential/100)
		Snaring = 3 + round(p.Potential/50, 0.25)
		//Cooldown=30
	verb/Hungry_Coils()
		set category="Skills"
		var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
		if(oo)
			adjust(usr)
			usr.UseProjectile(src)
			oo.Ouroboros()


/obj/Skills/Ouroboros/Serpents_Redemption
	Cooldown = 30
	verb/Serpents_Redemption() // copy paste ? 
		set name="Serpents Redemption"
		set category="Skills"
		var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
		if(oo && usr.Target)
			if(usr.Target.passive_handler["Snared"])
				if(usr.Knockback)
					for(var/obj/Skills/Aerial_Payback/x in usr.Skills)
						if(!x.Using)
							usr.SkillX("Aerial Payback",x)
							oo.Ouroboros()
				else
					var/obj/Skills/Dragon_Dash/dd = usr.FindSkill(/obj/Skills/Dragon_Dash)
					var/triggered = usr.SkillX("DragonDash",dd)
					if(triggered)
						oo.Ouroboros()

/obj/Skills/Ouroboros/Serpents_Pull
	// Cooldown = 30 // we must drag them to us now
	verb/Serpents_Pull() // copy paste ? 
		set name="Serpents Pull"
		set category="Skills"
		var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
		if(oo && usr.Target)
			if(usr.Target.passive_handler["Snared"])
				oo.Ouroboros()
				usr.Knockback(20, usr.Target, get_dir(usr.Target, usr), TRUE, 0 , 0 , TRUE)
				usr.Target.applySnare(4 + usr.Potential/50, 'root.dmi', TRUE)


/mob/proc/applySnare(limit, _icon, force = FALSE)
	var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Snare/s = findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Snare) // try to find it
	if(force)
		if(BuffOn(s))
			s.Trigger(src, TRUE) // this will force it off
	if(!BuffOn(s))
		s.adjust(src, limit, _icon) // regardless adjust it, no need to make it new, just add or find it
		s.Trigger(src, TRUE)
	
	// this could be better i think?


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Nox/The_Unholy_Wrath_of_the_Basilisk
	KenWave=1
	KenWaveIcon='Azure Crest.dmi'
	KenWaveSize=0.2
	KenWaveX=-785
	KenWaveY=-389
	IconTint=rgb(11, 159, 4)
	ManaGlow = "#000"
	ManaGlowSize=0.5
	NeedsHealth=25
	TooMuchHealth=30
	ActiveMessage = "RAAAAAHH RIIICKKKKYYYY"
	IconLock='Susanoo Blade.dmi'
	LockX=-32
	LockY=-32