
/mob/proc/checkOtherMacros(obj/Skills/Buffs/SlotlessBuffs/DemonMagic/org)
    for(var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/dm in src)
        if(dm == org) continue
        if(dm.keyMacro != null)
            if(dm.keyMacro == org.keyMacro)
                return dm
    return TRUE

/mob/var/hasDemonCasting = FALSE

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic
    // VARS
    var/keyMacro = null
    var/KEYWORD = "error"
    var/list/obj/Skills/possible_skills = list()
    TimerLimit = 1
    Cooldown = 120
    // PROCS

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Cooldown(modify, Time, mob/p, t)
    for(var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/dm in p)
        if("[dm.type]" == "[t]") // all instances of this 
            for(var/x in dm.possible_skills)
                if(dm.possible_skills[x])
                    dm.possible_skills[x].Using= 0 
                    dm.possible_skills[x].Cooldown(modify, Time, p)
                    p << "[dm.possible_skills[x]] has been put on cooldown."

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/proc/setUpMacro(mob/p)
    keyMacro = null
    p << "The next button you press will be the macro for this. There will be an alert, give it a second."
    p.client.trackingMacro = src // send a trigger to track for this skill's keymacro


/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/proc/fakeTrigger(mob/p)
    if(!keyMacro)
        setUpMacro(p)
    else
        if(p.client.trackingMacro) return
        Trigger(p, 0)
/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Trigger(mob/User, Override = 0)
    if(Using)
        if(possible_skills["DarkMagic"].MultiShots)
            User.UseProjectile(possible_skills["DarkMagic"])
        else
            ..()
    else
        if(User.client.keyQueue.TRIGGERED && User.client.keyQueue.LAST_CAST + 300 <world.time)
            User.client.keyQueue.TRIGGERED = null
        if(isnull(User.client.keyQueue.TRIGGERED))
            if(User.client.keyQueue.LAST_CAST + 45 < world.time)
                User.client.keyQueue.trigger(type)
                User << "You have started to cast [src]." // replace with animation of text above head.
                User.castAnimation()
                Cooldown = 0
                User.client.keyQueue.LAST_CAST = world.time
        else
            var/initType = User.client.keyQueue.initType
            // this has already been activated, therefore this must be the 2nd input
            var/result = User.client.keyQueue.detectInput(keyMacro, 15)
            switch(result)
                if(1)
                    // execute the skill here
                    var/trueType = splittext("[initType]", "/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/")
                    var/obj/Skills/theSkill = possible_skills[trueType[2]]
                    if(possible_skills[trueType[2]].cooldown_remaining > 0)
                        User << "This is on cooldown"
                        return
                    User << "You have used your [KEYWORD] spell."
                    var/triggered = theSkill?:Trigger(User, 0)
                    if(!(isnull(triggered) || !triggered))
                        Cooldown(1, null, User, type)
                    User.client.keyQueue.TRIGGERED = null
                if(-1)
                    User << "Too Soon..."
                if(0)
                    User << "You have missinputted."
                    Cooldown(1, null, User, type)
                    User.client.keyQueue.TRIGGERED = null


/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/DarkMagic
    name = "Dark Magic"
    
    KEYWORD = "damage"
    verb/Dark_Magic()
        set hidden = TRUE
        fakeTrigger(usr)
    verb/Change_Macro()
        set category = "Other"
        setUpMacro(usr)


    possible_skills = list("DarkMagic" = new/obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball, "HellFire" = new/obj/Skills/Projectile/Magic/HellFire/Hellpyre ,"Corruption" = new/obj/Skills/AutoHit/Magic/Corruption/Corrupt_Reality )


/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire
    name = "Hell Fire"
    KEYWORD = "utility"
    verb/Hell_Fire()
        set hidden = TRUE
        fakeTrigger(usr)
        if(!possible_skills["Corruption"])
            possible_skills["Corruption"] = new/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Space
    verb/Change_Macro()
        set category = "Other"
        setUpMacro(usr)

    possible_skills = list("DarkMagic" = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech, "HellFire" = new/obj/Skills/AutoHit/Magic/HellFire/Hellstorm ,"Corruption" = new/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Space)
/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Corruption
    name = "Corruption"
    KEYWORD = "crowd control"
    verb/Corruption()
        set hidden = TRUE
        fakeTrigger(usr)
    verb/Change_Macro()
        set category = "Other"
        setUpMacro(usr)

    possible_skills = list("DarkMagic" = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind, "HellFire" = new/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat,"Corruption" = new/obj/Skills/Buffs/SlotlessBuffs/Magic/Corruption/Corrupt_Time )
