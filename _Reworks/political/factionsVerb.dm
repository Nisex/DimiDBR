/mob/Admin3/verb/EditCharacterInformation(mob/player in players)
    set name = "Edit Character Information"
    if(!player.client) return
    if(player.information)
        var/atom/A = player.information
        var/Edit="<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
        var/list/B=new
        Edit+="[A]<br>[A.type]"
        Edit+="<table width=10%>"
        for(var/C in A.vars) B+=C
        for(var/C in B)
            Edit+="<td><a href=byond://?src=\ref[A];action=edit;var=[C]>"
            Edit+=C
            Edit+="<td>[Value(A.vars[C])]</td></tr>"
        usr<<browse(Edit,"window=[A];size=450x600")

/proc/getCurrentPlayers()
    var/list/theplayers = list()
    for(var/mob/p in theplayers)
        if(p.client)
            theplayers += p
    return theplayers

/mob/Admin3/verb/GiveRegisterVerb()
    set name = "Give Register Verb"
    
    for(var/mob/p in players)
        if(p.information.faction == "Solo")
            players -= p
    var/mob/p = input(src, "Pick a player", "Player") in players
    p << "You have been given the register verb."
    p.verbs += /mob/proc/RegisterMember



/mob/Admin3/verb/AssignJob()
    set name = "Assign Job"
    
    var/mob/p = input(src, "Pick a player", "Player") in players
    var/choice = input(src, "Pick a job", "Job") in JOBS
    p.information.setJob(choice)


/mob/Admin3/verb/changeFaction(mob/b in players)
    set name = "Change Faction"
    if(!b.client)
        return
    var/choice = input(src, "Pick a faction", "Faction") in FACTIONS
    b.information.setFaction(choice)

/mob/Admin3/verb/changeNationalities(mob/b in players)
    set name = "Change Nationalities"
    if(!b.client)
        return
    alert("if i catch u abusing the freedom to freely input in this i will smite you")
    b.information.nationality = input(src, "What nationality?") as text
    b.information.secondNationality = input(src, "what second nationality") as text

/mob/Admin3/verb/offerNationalityChange(mob/b in players)
    set name = "Offer Nation Change"
    if(!b.client)
        return
    b.information.setNationality(b)

/mob/verb/customizePU()
    set name = "Customize: PU Charging"
    set category = "Other"
    if(!src.client)
        return
    var/choice = input(src, "Change PU Charging", "PU Charging Style") as text
    if(length(choice)>200)
        return
    if(length(choice)<1)
        return
    custom_powerup = choice
    choice = input(src, "Do you want to include your name in the PU charging?") in list("Yes", "No")
    if(choice == "Yes")
        customPUnameInclude = TRUE
    else
        customPUnameInclude = FALSE

/mob/verb/Admins()
    set name = "Admins"
    set category = "Other"
    for(var/mob/p in players)
        if(p.Admin)
            src<<"[p.DisplayKey ? p.DisplayKey : p.key] (Admin [p.Admin])"




/mob/verb/FactionCount()
    set name = "Faction Count"
    set category = "Other"
    var/list/total = FACTIONS
    for(var/mob/Players/M in players)
        if(!M.client)
            continue
        if(isai(M))
            continue
        if(M.information.faction in total)
            total["[M.information.faction]"] += 1
            continue
        else if(!(M.information.faction in FACTIONS))
            total["[M.information.faction]"] += 1
    src<<"______________"
    src<<"Faction Count:"
    src<<"______________"
    for(var/x in total)
        if(total[x]>0)
            src<<"[x]: [total[x]]"
/datum/characterInformation

/datum/characterInformation/proc/getInformation(mob/p, pronouns)
    var/msg = ""
    if(rankingNumber == "ERROR")
        rankingNumber = num2text(rand(1000,9001))


    if(p.Summonable)
        if(pronouns)
            var/theyString = p.subjectpronoun() == "They" ? "use" : "uses"
            var/theyString2 = p.subjectpronoun() == "They" ? "are" : "is"
            msg={"
<font face='courier'><font color='#color'>\[SYSTEM: ERROR! ERROR! [p.name]'s information...\]
\[SYSTEM: <font color='[factionColor]'>[faction] (<font color='[jobColor]'>Summon?</font>)</font> Character Sheet...\]
\[SYSTEM: [p.subjectpronoun()] [theyString] [p.subjectpronoun()]/[p.possessivepronoun()] pronouns. \]
\[SYSTEM: [p.subjectpronoun()] [theyString2] of UNKNOWN descent.\]
\[SYSTEM: Race: <font color='red'>ERROR</font>\]
\[SYSTEM: Class: <font color='red'>ERROR</font>\]
\[SYSTEM: Tier: [p.SummonTier]\]
\[SYSTEM: Closing Character Sheet...]</font color></font face> "}
        else
            msg={"
<font face='courier'><font color='#color'>\[SYSTEM: ERROR! ERROR! [p.name]'s information...\]
\[SYSTEM: <font color='[factionColor]'>[faction] (<font color='[jobColor]'>Summon?</font>)</font> Character Sheet...\]
\[SYSTEM: [p.subjectpronoun()] is of UNKNOWN descent.\]
\[SYSTEM: Race: <font color='red'>ERROR</font>\]
\[SYSTEM: Class: <font color='red'>ERROR</font>\]
\[SYSTEM: Tier: [p.SummonTier]\]
\[SYSTEM: Closing Character Sheet...]</font color></font face> "}


    else
        if(pronouns)
            var/theyString = p.subjectpronoun() == "They" ? "use" : "uses"
            var/theyString2 = p.subjectpronoun() == "They" ? "are" : "is"
            msg={"
<font face='courier'><font color='#color'>\[SYSTEM: Loading [p.name]'s information...\]
\[SYSTEM: <font color='[factionColor]'>[faction] (<font color='[jobColor]'>[job]</font>)</font> Character Sheet...\]
\[SYSTEM: [p.subjectpronoun()] [theyString] [p.subjectpronoun()]/[p.possessivepronoun()] \]
\[SYSTEM: [p.subjectpronoun()] [theyString2] [p.getNationalityInformation()]\]
\[SYSTEM: [getInfo()]\]
\[SYSTEM: Closing Character Sheet...]</font color></font face> "}
        else
            msg={"
<font face='courier'><font color='#color'>\[SYSTEM: Loading [p.name]'s information...\]
\[SYSTEM: <font color='[factionColor]'>[faction] (<font color='[jobColor]'>[job]</font>)</font> Character Sheet...\]
\[SYSTEM: [p.subjectpronoun()] is [p.getNationalityInformation()]\]
\[SYSTEM: [getInfo()]\]
\[SYSTEM: Closing Character Sheet...]</font color></font face> "}

    return msg

