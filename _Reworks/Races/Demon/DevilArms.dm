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
        if(!usr.BuffOn(src) && Mastery)
            evolve(usr)
            usr << "Activate again after."
            return
        src.Trigger(usr)

    proc/handlePassive(list/theList, input)
        . = TRUE
        if(passives["[input]"])
            if(passives["[input]"] + theList[input][1] > theList[input][2])
                return FALSE
            passives["[input]"] += theList[input][1]
        else
            passives["[input]"] = theList[input][1]
            

    proc/pickSelection(mob/p, secondary = FALSE)
        if(secondary)
            secondDevilArmPick = input(p, "What thing?") in list("Staff", "Sword", "Unarmed","Armor") - selection
        selection = input(p, "What thing?") in list("Staff", "Sword", "Unarmed","Armor")

    proc/evolve(mob/p)
        if(!selection)
            pickSelection(p, FALSE)
        if(!p.BuffOn(src))
            if(Mastery && totalEvolvesMain+1 <= round(p.Potential / 5))
                // evolve
                var/list/data = getJSONInfo(getPassiveTier(p), "GENERIC_PASSIVES")
                data.Add(getJSONInfo(getPassiveTier(p), "[uppertext(selection)]_PASSIVES"))
                var/choices = list()
                for(var/a in passives)
                    choices += "[a]"
                var/correct = FALSE
                var/attempts = 0
                while(correct == FALSE)
                    var/passive = input(p, "What passive?") in choices
                    if(attempts >=3)
                        p << "You tried too many times, alert an admin"
                        break
                    if(!handlePassive(data, passive))
                        p << "Too much passive value"
                        correct = FALSE // have them go again
                    else
                        correct = TRUE
                    attempts++
                Mastery--



