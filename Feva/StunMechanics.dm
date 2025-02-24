
/mob/var/tmp/last_stunned = 0

/mob/Admin3/verb/changeStunImmune()
	set category = "Admin"
	set name = "Change Stun Immune Timer"
	glob.STUN_IMMUNE_TIMER = input("Enter the new stun immune timer as seconds") as num
	glob.STUN_IMMUNE_TIMER = glob.STUN_IMMUNE_TIMER * 10
	if(glob.STUN_IMMUNE_TIMER < 1 || glob.STUN_IMMUNE_TIMER > 100)
		world << "Stun immune timer changed to [glob.STUN_IMMUNE_TIMER/10] seconds."

/mob/Admin3/verb/changeMaxStun()
	set category = "Admin"
	set name = "Change Max Stun Time"
	glob.MAX_STUN_TIME = input("Enter the new stun time as seconds") as num
	glob.MAX_STUN_TIME = glob.MAX_STUN_TIME * 10
	world << "Max stunned time changed to [glob.MAX_STUN_TIME/10] seconds."


proc
	Stun(mob/m,amount=5, ignoreImmune = FALSE)
		if(!m)
			return
		if(!m.client)
			return
		if(m.Saga != "Kamui" && !m.CheckActive("Kamui Senketsu"))
			if(m.InUBW&&m.MadeOfSwords)
				return
			if(m.StunImmune && !ignoreImmune)
				return
		if(m.CheckSlotless("Great Ape"))
			amount *= 0.75
		if(m.HasLegendaryPower() > 0.25 || m.passive_handler.Get("Juggernaut"))
			var/mod = (m.HasLegendaryPower() * 0.5) + m.passive_handler.Get("Juggernaut") * 0.25
			amount /= 1 + mod

		if(m.HasDebuffResistance())
			amount/=(m.GetDebuffResistance()*0.75)
		if(m.ContinuousAttacking)
			for(var/obj/Skills/Projectile/p in m.contents)
				if(p.ContinuousOn && !p.StormFall)
					m.UseProjectile(p)
				continue
		var/Stun_Amount=world.time+(amount*8)
		world<<"stunning for [Stun_Amount]"
		if(m.Stunned)
			m.Stunned+=(amount*2)
			if(m.Stunned > m.last_stunned + glob.MAX_STUN_TIME)
				m.Stunned = m.last_stunned + glob.MAX_STUN_TIME
		else
			var/obj/Effects/Stun/S=new
			S.appearance_flags=66
			m.Stunned=Stun_Amount
			m.last_stunned = world.time
			m.overlays+=S
			m.ForceCancelBeam()
			m.ForceCancelBuster()
	StunCheck(mob/mob)

		if(mob.Stunned)
			if(mob.Stunned<=world.time)
				var/obj/Effects/Stun/S=new
				S.appearance_flags=66
				mob.overlays-=S
				mob.Stunned=0
				mob.StasisStun=0
				mob.overlays-='IceCoffin.dmi'
				var/mod = (mob.HasLegendaryPower() * 0.5) + mob.passive_handler.Get("Juggernaut") * 0.25
				mob.StunImmune=world.time+(glob.STUN_IMMUNE_TIMER*(1+mod))
				if(mob.passive_handler["Shellshocked"])
					mob.passive_handler.Set("Shellschocked", 0)
			else
				return 1
	StunClear(mob/mob)
		if(mob.Stunned)
			if(mob.CheckSlotless("Mind Dominated") || mob.passive_handler["Shellshocked"]) // this should b some passive that causes this
			// however, fuck you
				mob << "You feel unable to clear your head."
			else
				var/obj/Effects/Stun/S=new
				S.appearance_flags=66
				mob.overlays-=S
				mob.Stunned=0
				mob.StasisStun=0
				mob.overlays-='IceCoffin.dmi'
				var/mod = (mob.HasLegendaryPower() * 0.5) + mob.passive_handler.Get("Juggernaut") * 0.25
				mob.StunImmune=world.time+(glob.STUN_IMMUNE_TIMER*(1+mod))
	StunImmuneCheck(mob/mob)
		if(mob.StunImmune && mob.Saga != "Kamui" && !mob.CheckActive("Kamui Senketsu"))
			if(mob.StunImmune<world.time)
				mob.StunImmune=0
			else
				return 1