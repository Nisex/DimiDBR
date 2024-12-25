ritual
    var/name = "Base Ritual"
    var/list/components
    var/manaCost = 100
    var/list/associatedKnowledges

    proc/checkComponents(obj/Magic_Circle/circle)
        var/componentsFound = 0
        for(var/atom/i in range(1, circle))
            if(i.type in components)
                componentsFound += 1
        return componentsFound
    
    proc/checkKnowledges(mob/p)
        var/checkedKnowledges = 0
        for(var/k in associatedKnowledges)
            if(k in p.knowledgeTracker.learnedMagic)
                checkedKnowledges += 1
        return checkedKnowledges

    proc/checkRitualRequirements(obj/Magic_Circle/circle, mob/p)
        if(checkComponents(circle) == length(components) && checkKnowledges(p) == length(associatedKnowledges))
            return 1
        return 0

    proc/performRitual(obj/Magic_Circle/circle, mob/p)
        if(checkRitualRequirements(circle, p))
            p.mana -= manaCost
            for(var/atom/i in range(1, circle))
                if(i.type in components)
                    i.type = null
            return 1
        return 0