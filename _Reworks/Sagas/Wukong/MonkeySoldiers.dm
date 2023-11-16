/datum/SoldierTracker
    var/totalSoldiers
    var/list/monkeySoldiers = list()
    var/maxSoldiers = 1
/mob/var/datum/SoldierTracker/MonkeySoldiers = new()


/mob/proc/summonMonkeySoldier(dmg, tier)
    if(tier != MonkeySoldiers.maxSoldiers) MonkeySoldiers.maxSoldiers = tier
    if(MonkeySoldiers.totalSoldiers < MonkeySoldiers.maxSoldiers)
        MonkeySoldiers.monkeySoldiers += new/mob/MonkeySoldier(src, dmg, tier * 75)
        MonkeySoldiers.totalSoldiers += 1
        blobLoop += MonkeySoldiers.monkeySoldiers[MonkeySoldiers.totalSoldiers]

/mob/MonkeySoldier
    var/damageValue
    var/timeLimit
    var/distanceLimit = 30
    var/spawnTime
    var/lastAttack
    var/attackDelay = 15
    var/owner_ref
    New(mob/p, dmg, timer)
        owner_ref = "\ref[p]"
        damageValue = clamp(dmg / 10, 0.1,1)
        timeLimit = timer
        lastAttack = 0
        attackDelay = 10
        Target = p.Target
        spawnTime = world.time
        icon = p.icon
        x = p.x
        y = p.y
        z = p.z
        appearance = new/mutable_appearance(p)
        alpha = 155
    Update()
        var/mob/owner = locate(owner_ref)
        if(world.time > spawnTime + timeLimit)
            owner.MonkeySoldiers.monkeySoldiers -= src
            owner.MonkeySoldiers.totalSoldiers --
            del(src)
        else
            if(Target != owner.Target) Target = owner.Target
            if(lastAttack + attackDelay < world.time)
                lastAttack = world.time
                if(Target && get_dist(Target,src) < distanceLimit)
                    lastAttack = world.time
                    flick("Attack", src)
                    owner.HitEffect(Target, 0, 1)
                    Target.LoseHealth(damageValue)

// /mob/verb/summonSoldier()
//     set category = "Debug"
//     if(!Target) return
//     if(Target == src) return
//     summonMonkeySoldier(min_max_scaling(25.43), 2)


/obj/Skills/Buffs/SlotlessBuffs
    TestBuff1
        MonkeyKing = 2
        Cooldown = 5
        verb/TestBuff1()
            set category = "Skills"
            set name = "Test Buff 1"
            src.Trigger(usr)