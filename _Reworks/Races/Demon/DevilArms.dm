/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2
    passives = list()
    SignatureTechnique=3
    Mastery=0
    Copyable=0
    MakesSword=1
    FlashDraw=1
    SwordName="Demon Blade"
    SwordIcon='SwordBroad.dmi'
    StaffName="Demon Rod"
    StaffIcon='MageStaff.dmi'
    ArmorName="Demon Scales"
    StaffIcon='DevilScale.dmi'
    TextColor="#adf0ff"
    ActiveMessage=null
    OffMessage=null
    var/secondDevilArmPick
    var/selection
    var/totalEvolvesMain = 0
    var/totalEvolvesSecondary = 0
    Mastery = 1

    name = "Devil Arm"


    verb/Customize_Devil_Arm()
        var/options = list("Icon", "Name","ActiveMessage", "OffMessage","TextColor")
        if(selection == "Unarmed")
            options -= "Icon"
        var/thing = input(usr, "What do you want to customize?") in options
        if(thing == "Icon")
            vars["[selection][thing]"] = input(usr, "Change to what?") as icon | null
            vars["[selection]X"] = input(usr, "What is the pixel X?") as num
            vars["[selection]Y"] = input(usr, "What is the pixel y?") as num
        else if("Name")
            vars["[selection][thing]"] = input(usr, "Change to what?") as text
        else
            vars["[thing]"] = input(usr, "Change to what?") as message
    

    verb/Devil_Arm()
        set category = "Skills"
        if(!usr.isRace(DEMON)) return 
        if(!usr.BuffOn(src) && (usr.race?:devil_arm_upgrades || usr.race?:sub_devil_arm_upgrades) )
            evolve(usr)
            usr << "Activate again after."
            return
        src.Trigger(usr)

    proc/handlePassive(list/theList, input, secondary)
        . = TRUE
        
        if(passives["[input]"])
            if(passives["[input]"] + theList[input][1] > theList[input][2])
                return FALSE
            passives["[input]"] += theList[input][1]
        else
            passives["[input]"] = theList[input][1]
            

    proc/pickSelection(mob/p, secondary = FALSE)
        var/select
        MakesSword = 0
        if(secondary)
            secondDevilArmPick = input(p, "What thing?") in list("Staff", "Sword", "Unarmed","Armor") - selection
            select = secondDevilArmPick
        else
            selection = input(p, "What thing?") in list("Staff", "Sword", "Unarmed","Armor")
            select = selection
        vars["Makes[select]"] = 1
        var/class
        vars["[select]Name"] = input(p, "Change name to what?") as text
        if(select != "Unarmed")
            if(select == "Staff")
                class = input(p, "What thing?") in list("Wand", "Rod", "Staff")
            else
                class = input(p, "What thing?") in list("Light", "Medium", "Heavy")
            vars["[select]Class"] = class
            vars["[select]Icon"] = input(p, "Change name to what?") as icon | null
            vars["[select]X"] = input(p, "What is the pixel X?") as num
            vars["[select]Y"] = input(p, "What is the pixel y?") as num
    proc/pickPassive(mob/p, list/choices, list/mainData)
        var/correct = FALSE
        var/attempts = 0
        while(correct == FALSE)
            var/passive = input(p, "What passive?") in choices
            if(attempts >=3)
                p << "You tried too many times, alert an admin"
                break
            if(!handlePassive(mainData, passive))
                p << "Too much passive value"
                choices -= passive
                correct = FALSE // have them go again
            else
                correct = TRUE
            attempts++

    proc/evolve(mob/p)
        if(!selection)
            pickSelection(p, FALSE)
        if(!p.BuffOn(src))
            var/race/demon/r = p.race
            if(r.devil_arm_upgrades && totalEvolvesMain-1 < round(p.Potential / 5))
                var/list/data = getJSONInfo(getPassiveTier(p), "GENERIC_PASSIVES")
                var/list/secondaryData
                data.Add(getJSONInfo(getPassiveTier(p), "[uppertext(selection)]_PASSIVES"))
                if(secondDevilArmPick && r.sub_devil_arm_upgrades)
                    secondaryData = getJSONInfo(getPassiveTier(p), "[uppertext(secondDevilArmPick)]_PASSIVES")
                var/choices = list()
                var/secondChoices = list()
                for(var/a in data)
                    choices += "[a]"
                for(var/a in secondaryData)
                    secondChoices += "[a]"
                if(r.devil_arm_upgrades)
                    pickPassive(p, choices, data)
                    r.devil_arm_upgrades--
                    totalEvolvesMain++
                if(r.sub_devil_arm_upgrades)
                    pickPassive(p, secondChoices, secondaryData)
                    r.sub_devil_arm_upgrades--
                    totalEvolvesSecondary++


