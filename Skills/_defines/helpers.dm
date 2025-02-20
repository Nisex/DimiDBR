proc/isAChild(typePath, parentPath)
    if(typePath in typesof(parentPath))
        return TRUE
    return FALSE
/mob/proc/throwSkill(obj/Skills/s)
    if(isAChild(s.type, /obj/Skills/AutoHit))
        Activate(s)
    else if(isAChild(s.type, /obj/Skills/Projectile))
        UseProjectile(s)
    else if(isAChild(s.type, /obj/Skills/Queue))
        SetQueue(s)
    else if(isAChild(s.type, /obj/Skills/Grapple))
        s:Activate(src)

/mob/proc/findOrAddSkill(path) // find it, regardless
    var/obj/Skills/s 
    if(ispath(path))
        s = FindSkill(path)
        if(!s)
            s = new path
    else
        s = path
    AddSkill(s)
    return s

/mob/proc/throwFollowUp(path)
    set waitfor = FALSE
    if(istext(path))
        path = text2path(path)
    var/obj/Skills/s = findOrAddSkill(path)
    s.adjust(src)
    throwSkill(s)
    
/mob/proc/cycleStackingBuffs(var/obj/Skills/S)
    if(S.parent_type==/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Samsara || AttackQueue?:type == /obj/Skills/Queue/Finisher/Cycle_of_Samsara)
        AttackQueue.Mastery++
        for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Samsara/s in SlotlessBuffs)
            s.Timer = 0
    if(S.type==/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/What_Must_Be_Done)
        if(SlotlessBuffs["What Must Be Done"])
            SlotlessBuffs["What Must Be Done"].Mastery++
            SlotlessBuffs["What Must Be Done"].TimerLimit+=300


mob/proc/buffSelf(path)
    if(istext(path))
        path = text2path(path) // everything else has text useless to change it now, also makes edit easier
    var/obj/Skills/s = findOrAddSkill(path)
    if(!SlotlessBuffs[s.name])
        s.adjust(src)
    s.Password = UniqueID
    cycleStackingBuffs(s)

mob/proc/isSuperCharged(mob/p)
    if(p.passive_handler["SuperCharge"])
        if(StyleBuff.last_super_charge + glob.SUPERCHARGECD < world.time)
            return TRUE
    return FALSE

mob/proc/UsingHotnCold()
    if(StyleActive == "Hot Style")
        return TRUE
    if(StyleActive == "Cold Style")
        return TRUE
    return FALSE