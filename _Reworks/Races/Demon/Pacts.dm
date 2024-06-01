
/datum/Pact

/datum/Pact/var/details
/datum/Pact/var/owner
/datum/Pact/var/subject

/datum/DemonRacials/var/PactsByCkey

/datum/DemonRacials/var/PactsTaken

/datum/DemonRacials/proc/givePact(mob/o,mob/p, datum/Pact/pact)
    var/asc = o.AscensionsAcquired + 1
    if(PactsTaken + 1 > asc)
        o <<"You can't make any more pacts."
        return
    
    p << "(By Accepting [o]'s pact, you are bound to fulfil the details, lest you wish to fall to the consequences of breaking it. May that be injury, death or loss of the soul.)"
    p << browse(pact.details)

    var/accept = input(p, "Do you accept the conditions?") in list("Yes", "No")
    if(accept == "Yes")
        PactsByCkey["[p.ckey]"] = pact
        pact.owner = o
        pact.subject = p
    
    giveReward(o, p)



/datum/DemonRacials/proc/giveReward(mob/o, mob/p, option)
    switch(option)
        if("Magic")
            var/skills = list("DarkMagic" = list("Shadow Ball" = /obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball, \
            "Soul Leech" = /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech, "Dominate Mind" = /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind), \
            "HellFire" = list("Hellpyre" = /obj/Skills/Projectile/Magic/HellFire/Hellpyre, \
            "Hellstorm" = /obj/Skills/AutoHit/Magic/HellFire/Hellstorm, "OverHeat" = /obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat))
            var/exists = TRUE
            var/exit = FALSE
            var/obj/Skills/newSkill = null
            while(exit == FALSE)
                var/category = input(o, "What category") in list("DarkMagic", "HellFire")
                var/selection = input(o, "What skill?") in skills[category]
                for(var/obj/Skills/x in p)
                    if(x.type == selection)
                        exists = TRUE
                        break
                if(exists)
                    break
                newSkill = new selection
                exit = TRUE
                // i hate this shit
            
            p.AddSkill(newSkill)
        if("Passive")
            var/passive = input(o, "What passive?") in o.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2).passives
            if(!passive)
                o << "You have none"
                return
            var/obj/Skills/Buffs/SlotlessBuffs/Posture_2/posture = p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Posture_2)
            if(posture)
                posture.passives["[passive]"] += 0
                // devil arm function to calculate what gets what
            