/mob/verb/testDOM()
    set category = "Demon Magic Testing"
    var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/DarkMagic/dm = new()
    src.AddSkill(dm)

/mob/proc/checkOtherMacros(obj/Skills/Buffs/SlotlessBuffs/DemonMagic/org)
    for(var/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/dm in src)
        if(dm == org) continue
        if(dm.keyMacro == org.keyMacro)
            return dm
    return TRUE

/mob/var/hasDemonCasting = FALSE

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic
    // VARS
    var/keyMacro = null
    var/KEYWORD = "error"
    var/obj/Skills/possible_skills
    TimerLimit = 1
    Cooldown = 120
    var/CURRENTLY_SEALED
    // PROCS

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/proc/setUpMacro(mob/p)
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
        if(isnull(User.client.keyQueue.TRIGGERED))
            User.client.keyQueue.trigger(type)
            User << "You have started to cast [src]." // replace with animation of text above head.
            Cooldown = 0
        else
            var/initType = User.client.keyQueue.initType
            // this has already been activated, therefore this must be the 2nd input
            if(User.client.keyQueue.detectInput(keyMacro, 25) != -1 )
                User << "You have used your [KEYWORD] spell."
                Cooldown = 30
                // execute the skill here
                var/trueType = splittext("[initType]", "/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/")
                var/obj/Skills/theSkill = possible_skills[trueType[2]]
                theSkill?:Trigger(User, 0)
                Cooldown()
                User.client.keyQueue.TRIGGERED = null
            else
                User << "Too Soon..."
/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/DarkMagic
    name = "Dark Magic"
    KEYWORD = "damage"
    verb/Dark_Magic()
        set hidden = TRUE
        fakeTrigger(usr)
    verb/Change_Macro()
        setUpMacro(usr)
    Cooldown(modify, Time)
        for(var/index in possible_skills)
            if(possible_skills[index])
                possible_skills[index].Cooldown()

    
    possible_skills = list("DarkMagic" = new/obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball, "HellFire" = new/obj/Skills/Projectile/Magic/HellFire/Hellpyre ,"Corruption" )


/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire
    name = "Hell Fire"
    KEYWORD = "utility"
    verb/Hell_Fire()
        set hidden = TRUE
        fakeTrigger(usr)
    verb/Change_Macro()
        setUpMacro(usr)

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Corruption
    name = "Corruption"
    verb/Corruption()
        set hidden = TRUE
        fakeTrigger(usr)
    verb/Change_Macro()
        setUpMacro(usr)
