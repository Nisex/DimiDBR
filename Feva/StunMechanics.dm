/var/STUN_IMMUNE_TIMER=150
/var/MAX_STUN_TIME = 50
/mob/var/tmp/last_stunned = 0

/mob/Admin3/verb/changeStunImmune()
	set category = "Admin"
	set name = "Change Stun Immune Timer"
	STUN_IMMUNE_TIMER = input("Enter the new stun immune timer as seconds") as num
	STUN_IMMUNE_TIMER = STUN_IMMUNE_TIMER * 10
	if(STUN_IMMUNE_TIMER < 1 || STUN_IMMUNE_TIMER > 100)
		world << "Stun immune timer changed to [STUN_IMMUNE_TIMER/10] seconds."

/mob/Admin3/verb/changeMaxStun()
	set category = "Admin"
	set name = "Change Max Stun Time"
	MAX_STUN_TIME = input("Enter the new stun time as seconds") as num
	MAX_STUN_TIME = MAX_STUN_TIME * 10
	world << "Max stunned time changed to [MAX_STUN_TIME/10] seconds."


proc
	Stun(mob/m,amount=5)
		if(!m)
			return
		if(!m.client)
			return
		if(m.InUBW&&m.MadeOfSwords)
			return
		if(m.StunImmune)
			return
		if(m.Oozaru)
			amount *= 0.75
		if(m.HasLegendaryPower() > 0.25 || m.passive_handler.Get("Juggernaut"))
			var/mod = (m.HasLegendaryPower() * 0.5) + m.passive_handler.Get("Juggernaut") * 0.25
			amount /= 1 + mod

		if(m.HasDebuffImmune())
			amount/=(m.GetDebuffImmune()*0.75)
		if(m.ContinuousAttacking)
			for(var/obj/Skills/Projectile/p in m.contents)
				if(p.ContinuousOn && !p.StormFall)
					m.UseProjectile(p)
				continue
		var/Stun_Amount=world.time+(amount*8)
		if(m.Stunned)
			m.Stunned+=(amount*2)
			if(m.Stunned > m.last_stunned + MAX_STUN_TIME)
				m.Stunned = m.last_stunned + MAX_STUN_TIME
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
				mob.StunImmune=world.time+(STUN_IMMUNE_TIMER*(1+mod))
			else
				return 1
	StunClear(mob/mob)
		if(mob.Stunned)
			var/obj/Effects/Stun/S=new
			S.appearance_flags=66
			mob.overlays-=S
			mob.Stunned=0
			mob.StasisStun=0
			mob.overlays-='IceCoffin.dmi'
			var/mod = (mob.HasLegendaryPower() * 0.5) + mob.passive_handler.Get("Juggernaut") * 0.25
			mob.StunImmune=world.time+(STUN_IMMUNE_TIMER*(1+mod))
	StunImmuneCheck(mob/mob)
		if(mob.StunImmune)
			if(mob.StunImmune<world.time)
				mob.StunImmune=0
			else
				return 1