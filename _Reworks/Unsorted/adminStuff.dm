/mob/Admin3/verb/Races()
    set name = "Races"
    set category = "Utility"
    var/Human = 0
    var/Majin = 0
    var/Saiyan = 0
    var/HalfSaiyans = 0
    var/Monster = 0
    var/Namekian = 0
    var/Makyo = 0
    for(var/mob/x in players)
        switch(x.Race)
            if("Human")
                Human += 1
            if("Majin")
                Majin += 1
            if("Saiyan")
                Saiyan += 1
            if("Half Saiyan")
                HalfSaiyans += 1
            if("Monster")
                Monster += 1
            if("Namekian")
                Namekian += 1
            if("Makyo")
                Makyo += 1
    src<<"Humans: [Human]"
    src<<"Majins: [Majin]"
    src<<"Saiyans: [Saiyan]"
    src<<"Half-Saiyans: [HalfSaiyans]"
    src<<"Monsters: [Monster]"
    src<<"Namekians: [Namekian]"
    src<<"Makyos: [Makyo]"


/var/global/datum/GlobalStorage/globalStorage = new()

/datum/GlobalStorage
    var/tmp/objs = list()
    var/tmp/objHTML = ""
    var/tmp/skills = list()
    var/tmp/skillHTML = ""
    var/tmp/items = list()
    var/tmp/itemHTML = ""
    var/tmp/mobs = list()
    var/tmp/mobHTML = ""
    var/tmp/turfs = list()
    var/tmp/turfHTML = ""
    var/tmp/generated = 0
/datum/GlobalStorage/proc/generate(type)
    switch(type)
        if("obj")
            objs += typesof(/obj)
            for(var/x in objs)
                if(x in subtypesof(/obj/Skills))
                    skills += x
                if(x in subtypesof(/obj/Items))
                    items += x
        if("mob")
            mobs += typesof(/mob)
        if("turf")
            turfs += typesof(/turf)

/datum/GlobalStorage/proc/generateHTML(type)
    switch(type)
        if("obj")
            for(var/x in objs)
                objHTML += "<td><a href=byond://?src=INSERTHERE;action=magic;var=[x]>[x]<td></td></tr>"
        if("mob")
            for(var/x in mobs)
                mobHTML += "<td><a href=byond://?src=INSERTHERE;action=magic;var=[x]>[x]<td></td></tr>"
        if("turf")
            for(var/x in turfs)
                turfHTML += "<td><a href=byond://?src=INSERTHERE;action=magic;var=[x]>[x]<td></td></tr>"
        if("skill")
            for(var/x in skills)
                skillHTML += "<td><a href=byond://?src=INSERTHERE;action=magic;var=[x]>[x]<td></td></tr>"
        if("item")
            for(var/x in items)
                itemHTML += "<td><a href=byond://?src=INSERTHERE;action=magic;var=[x]>[x]<td></td></tr>"

/datum/GlobalStorage/proc/init()
    generate("obj")
    generate("mob")
    generate("turf")
    generateHTML("obj")
    generateHTML("skill")
    generateHTML("item")
    generateHTML("mob")
    generateHTML("turf")
    generated = 1
    

/mob/Admin4/verb/ChangeWorldSettings()
    set category = "Admin"
    set name = "Change World Settings"
    var/i = input(src, "ssss") in list("tick_lag","fps")
    src << "Current [i] is [world.vars[i]]"
    var/x = input(src, "ssss") as num 
    world.vars[i] = x
    src << "Changed [i] to [x]"
    src << "Current [i] is [world.vars[i]]"

/mob/verb/changeClientFPS()
    set category = "Other"
    set name = "Change Client FPS"
    client.fps = input(src, "ssss") as num
    src.client<<"[client.fps]"

/mob/Admin3/verb/Copy(obj/O in world)
    set category = "Admin"
    set name = "Copy"
    var/obj/O2 = copyatom(O)
    O2.name = "[O.name]_copy"
    O2.Move(src)


/mob/Admin2/verb/Give_Make(mob/A in world)
    set category="Admin"
    set name="Give/Make"
    var/blah={"<Magic><body bgcolor=#000000 text="white" link="red">"}
    blah+="[A]<br>[A.type]"
    blah+="<table width=10%>"
    var/info =""
    if(!globalStorage.generated)
        globalStorage.init()
    switch(input(usr, "What do you want to select?") in list("Skills","Items","Object","Mob","Turf","Cancel"))
        if("Skills")
            info = globalStorage.skillHTML
        if("Items")
            info = globalStorage.itemHTML
        if("Object")
            info = globalStorage.objHTML
        if("Mob")
            info = globalStorage.mobHTML
        if("Turf")
            info = globalStorage.turfHTML
        if("Cancel") return
    blah += replacetext(info,"INSERTHERE","\ref[A]")
    usr<<browse(blah,"window=[A];size=450x600")
    

