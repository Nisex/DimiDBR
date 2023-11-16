var/knowledgePaths/magic/list/MagicTree = list()

/proc/fillMagicTree()
    . = typesof(/knowledgePaths/magic)
    for(var/x in .)
        var/knowledgePaths/magic/m = new x
        MagicTree[m.name] += m


/mob/proc/learnKnowledge(pathType, knowledgeList)
    var/theCost
    var/list/buyList = list()
    switch(pathType)
        if("Magic")
            if(Imagination == 0)
                src<< "You do not have a soul. You can't learn magic."
                return
            theCost = glob.MAGIC_BASE_COST
            if(glob.MAGIC_INTELL_MATTERS)
                var/int = Intelligence
                if(int < 0.5)
                    int = 0.5
                theCost /= Intelligence // can only increase it by half, so majins dont cry
            theCost /= Imagination
            if(theCost < 1)
                theCost = 1
            if(length(MagicTree) < 1)
                fillMagicTree()
        if("Technology")
            theCost = BASE_COST / Intelligence
            if(theCost < 1)
                theCost = 1
            if(length(TechnologyTree) < 1)
                fillOutTechTree()
    for(var/n in global.vars["[pathType]Tree"])
        var/knowledgePaths/knowledge = global.vars["[pathType]Tree"][n]
        if(n in knowledgeList)
            if(n == "Summon Magic")
                if(SummoningMagicUnlocked<5)
                    buyList += knowledge
            if(n == "Crest Legend")
                if(CrestCreationUnlocked<7)
                    buyList += knowledge
            continue
        if(length(knowledge.requires) > 0)
            if(knowledge.meetsReqs(knowledgeList))
                buyList += knowledge
            else
                continue
        else
            buyList += knowledge
    var/input = input(src, "What would you like to learn") in buyList + "Cancel"
    if(input == "Cancel")
        return
    if(input in buyList)
        var/knowledgePaths/knowledge = global.vars["[pathType]Tree"]["[input]"]
        
        if(knowledge.meetsReqs(knowledgeList))
            theCost *= 1 + (0.25 * length(knowledge.requires))
            if(knowledge.breakthrough)
                theCost /= 4
            theCost = round(theCost, 1)
            var/confirm = input(src, "Are you sure you want to learn [knowledge.name]? It will cost [theCost] rp points.") in list("Yes" , "No")
            if(confirm == "Yes")
                if(SpendRPP(theCost, "[knowledge.name]"))
                    UnlockTech(knowledge, pathType)
        


/mob/verb/learnMagic()
    set category = "Utility"
    set name = "Magic Learning"
    learnKnowledge("Magic", knowledgeTracker.learnedMagic)
