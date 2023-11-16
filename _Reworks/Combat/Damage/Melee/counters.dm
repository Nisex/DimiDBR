/mob/proc/counterWarp(obj/Items/Sword/s, obj/Items/Sword/s2, obj/Items/Sword/s3)
	var/list/swordTypes = list("Wooden" = 1, "Light" = 2, "Medium" = 3, "Heavy" = 4)
	var/list/reqs = list("Trininty" = list(8, 3, 5, 8), \
	"Dual" = list(13, 5, 8, 13),\
	"Iaido" = list(25, 10, 15, 25))
	var/reqCounter = 0
	if(UsingIaido())
		if(HasSword())
			var/style = "Iaido"
			if(UsingTrinityStyle())
				style = "Trinity"
				reqCounter += reqs[style][swordTypes[s.Class]]
				reqCounter += reqs[style][swordTypes[s2.Class]]
				reqCounter += reqs[style][swordTypes[s3.Class]]
			else if(UsingDualWield())
				style = "Dual"
				reqCounter += reqs[style][swordTypes[s.Class]]
				reqCounter += reqs[style][swordTypes[s2.Class]]
			else
				reqCounter += reqs[style][swordTypes[s.Class]]
		else
			reqCounter = 10
		if(UsingIaido()>1)
			reqCounter-=(UsingIaido()-1)*5
		if(Saga=="Weapon Soul"&&SagaLevel>=2)
			reqCounter=max(1, reqCounter-3)
	if(UsingKendo()&&HasSword())
		if(s.Class == "Wooden")
			reqCounter = 10
		else
			reqCounter = 20
	
	if(UsingSpeedRave())
		reqCounter = 10
	if(reqCounter == 0)
		reqCounter = 999
	
	return reqCounter

/mob/proc/counterShit(mob/enemy, ignore)
	. = 0
	var/obj/Skills/Queue/q = enemy.AttackQueue
	var/counter = 0
	if(q)
		counter = q.Counter || q.CounterTemp ? 1 : 0
	var/buster = enemy.BusterTech && enemy.BusterTech.CounterShot ? 1 : 0
	var/ccd = enemy.Stunned || enemy.Launched ? 1 : 0
	if( ((q && counter) || buster) && !ccd &&!ignore)
		enemy.dir = get_dir(enemy, src)
		if(buster)
			enemy.UseProjectile(enemy.BusterTech)
		else
			if(!AttackQueue || (!AttackQueue && (AttackQueue.Counter|| AttackQueue.CounterTemp )))
				log2text("Counter Starting (counter/temp/dmgmult)", "[q.Counter] / [q.CounterTemp] / [q.DamageMult]", "damageDebugs.txt", "[ckey]/[name] :: enemy: [enemy.ckey]/[enemy.name]")
				. = q.Counter + q.CounterTemp
				log2text("Counter End", ., "damageDebugs.txt", "[ckey]/[name] :: enemy: [enemy.ckey]/[enemy.name]")
			if(enemy.UsingAnsatsuken())
				enemy.HealMana(enemy.SagaLevel / 15, 1)
			if(. && enemy.CanAttack())
				log2text("Counter damage", "[CounterDamage(.)]", "damageDebugs.txt", "[ckey]/[name] :: enemy: [enemy.ckey]/[enemy.name]")
				enemy.Melee1(CounterDamage(.), 2, 0,0, null, null, 0,0,2,1,0,1)
	


