/mob/verb/View_Current_Passives()
    set category = "Other"
    var/html = "<body bgcolor=#000000 text=#339999><b>Current Passives:</b><br>"
    for(var/passive in passive_handler.passives)
        if(passive_handler.passives[passive]>0)
            html += "<b>[passive] : [passive_handler.passives[passive]]</b><br>"
    src<<browse(html,"window=[src]'s Passives;size=450x600")



/mob/Admin4/verb/giveTestBuffs()
    AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Dragons_Tenacity)