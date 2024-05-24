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

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic
    // VARS
    var/keyMacro = null
    TimerLimit = 1
    Cooldown = 120
    // PROCS

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/proc/setUpMacro(mob/p)
    p << "The next button you press will be the macro for this. There will be an alert, give it a second."
    p.client.trackingMacro = src // send a trigger to track for this skill's keymacro




/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Trigger(mob/User, Override = 0)
    if(Using)
        ..()
    else
        if(isnull(User.client.keyQueue.TRIGGERED))
            User.client.keyQueue.trigger()
            User << "You have started to cast [src]" // replace with animation of text above head.
            Cooldown = 0
        else
            // this has already been activated, therefore this must be the 2nd input
            if(User.client.keyQueue.detectInput(keyMacro, 50) != -1 )
                Cooldown = 120
                // execute the skill here
                
                Cooldown()
/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/DarkMagic
    verb/Dark_Magic()
        set hidden = TRUE
        if(!keyMacro)
            setUpMacro(usr)
        else
            if(usr.client.trackingMacro) return
            Trigger(usr, 0)
    verb/Change_Macro()
        setUpMacro(usr)


/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/HellFire

/obj/Skills/Buffs/SlotlessBuffs/DemonMagic/Corruption
    


/obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind
    var/corruptionGain = list(5,5,8,8,10)
    Range = 25
    ManaCost = 15
    AffectTarget = 1

    applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    proc/adjust(mob/p)
        if(p.isRace(DEMON) && applyToTarget.type != /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon)
            applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon
    
    Trigger(var/mob/User, Override=0)
        if(!altered)
            adjust(User)
            applyToTarget?:adjust(User)
        if(..())
            world<<"here"
            if(1)// usr.isRace(DEMON))
                usr << "you gain coorruption !!"
                var/asc = usr.AscensionsAcquired
                if(asc < 1)
                    asc = 1
                usr << "[corruptionGain[asc]]"
        else
            world<< "here"
/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    BuffName = "Dominate Mind Applied"
    MagicNeeded = 0
    StunAffected = 10
    InstantAffect = 1
    TimerLimit = 10
    proc/adjust(mob/p)
        TimerLimit = MAX_STUN_TIME
        


/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon
    BuffName = "Mind Dominated"

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech