/mob/Admin3/verb/GetExactTime()
    DaysOfWipe()
    var/day = 24 HOURS
    var/days = (world.realtime / day) - (glob.progress.WipeStart / day)
    src<<(world.realtime / day)
    src<<(glob.progress.WipeStart / day)
    src<<days/day
    src<< "Days since wipe: [days]"
    src<<time2text(days, "DD:MM:YYYY hh:mm:ss")


/mob/proc/Respec1()
    var/Refund=0
    var/list/obj/Skills/Refundable=list("Cancel")
    for(var/obj/Skills/S in src)
        if((S.Copyable>0&&S.SkillCost) || istype(S, /obj/Skills/Buffs/NuStyle))
            Refundable.Add(S)
    for(var/obj/Skills/Choice in Refundable)
        Refund=Choice.SkillCost
        if(istype(Choice, /obj/Skills/Buffs/NuStyle))
            if(Choice.SignatureTechnique > 0) Refund = 0
            else src.SignatureSelected -= Choice.name
            Refund += ((2**(Choice.SignatureTechnique+1)*10)) * max(0,(Choice.Mastery-1))
        else if(Choice.Mastery>1)
            Refund+=(Choice.SkillCost*(Choice.Mastery-1))
        src.RPPSpendable+=Refund
        src.RPPSpent-=Refund
        src << "You've refunded [Choice] for [Commas(Refund)] RPP."
        for(var/obj/Skills/S in src)
            if(Choice&&S)
                if(S.type==Choice.type)
                    if(S.PreRequisite.len>0 && !istype(Choice, /obj/Skills/Buffs/NuStyle))
                        for(var/path in S.PreRequisite)
                            var/p=text2path(path)
                            var/obj/Skills/oldskill=new p
                            src.AddSkill(oldskill)
                            src << "The prerequisite skill for [Choice], [oldskill] has been readded to your contents."
                    del S
        for(var/obj/Skills/Buffs/NuStyle/s in src)
            src.StyleUnlock(s)



/mob/proc/GetRPPSpendable()
    var/Total=0
    Total+=src.RPPSpendable
    Total+=src.RPPSpendableEvent
    return Total
/mob/proc/GetRPP()
    var/Total=0
    Total+=src.RPPSpendable
    Total+=src.RPPSpent
    return Total
/mob/proc/GetRPPEvent()
    var/Total=0
    Total+=src.RPPSpendableEvent
    Total+=src.RPPSpentEvent
    return Total

/proc/getMaxRPP()
    var/max = glob.progress.totalRPPToDate
    if(max > glob.progress.RPPLimit)
        max = glob.progress.RPPLimit
    // this should be the max rpp ppl can have, im p sure
    return max

/mob/proc/setMaxRPP()
    var/max = getMaxPlayerRPP()
    RPPCurrent = max


/mob/proc/getMaxPlayerRPP()
    var/globalMax = getMaxRPP()
    var/Mult = GetRPPMult()
    globalMax *= Mult
    return globalMax // this should be the max rpp a player can have, im p sure

/mob/proc/setStartingRPP()
    if(RPPSpendable+RPPSpent < glob.progress.RPPStarting)
        RPPSpendable = glob.progress.RPPStarting - (RPPSpent)
        RPPCurrent = getMaxPlayerRPP()
    if(RPPCurrent < getMaxPlayerRPP())
        RPPCurrent = getMaxPlayerRPP()
        RPPSpendable = glob.progress.RPPStarting
        RPPSpent = 0

/mob/proc/GiveRPP(amount)
    var/maxRPP = getMaxPlayerRPP()
    RPPCurrent = maxRPP
    if(amount+RPPSpendable+RPPSpent > maxRPP)
        RPPSpendable += maxRPP - (RPPSpendable+RPPSpent)
        src<<"You've been given [maxRPP - (RPPSpendable+RPPSpent)] RPP."
    else
        RPPSpendable += amount
        src<<"You've been given [amount] RPP."