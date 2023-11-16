// NEW VARS
/mob/var/IntimidationMult // a very important part that multiplies intim so it can remain a normal value
/var/INTIMRATIO = 500
/var/NEWINTIMCALC = TRUE


// NEW PROCS
/mob/proc/getSSIntim(mob/defender, val) // get Saiyan Soul Intim
    if(!defender) return
    if(defender.CheckSlotless("Saiyan Soul") && !defender.Target.CheckSlotless("Saiyan Soul"))
        if(val < defender.Target.GetIntimidation())
            return defender.Target.GetIntimidation()
    return val
// NEW MAIN FUNCTIONS
/mob/proc/getIntimDMGReduction(mob/defender)
    if(!INTIMRATIO)
        INTIMRATIO = 500
    var/defIntim = defender.GetIntimidation()
    var/atkIntim = GetIntimidation()
    var/atkIntimIgnore = GetIntimidationIgnore(defender)
    var/defIntimIgnore = defender.GetIntimidationIgnore(src)
    var/val = defIntim // the intimidation as it stands
    var/totalMult = 0 // return value

    //def intim = 5, atk intim = 0, intim ignore = 0
    


    val = getSSIntim(defender, val)
    if(val > 1)
        atkIntim -= (atkIntim*defIntimIgnore)
    if(val > 1)
        val -= (val*atkIntimIgnore)
    if(val == 1 && atkIntim == 1)
        return 0
    if(val <=0)
        val = 1
    if(NEWINTIMCALC)
        if(val > atkIntim)
            totalMult = -((val - atkIntim) / INTIMRATIO)
        else
            totalMult = ((atkIntim - val) / INTIMRATIO)
    if(totalMult >= 10)
        totalMult = 10
    if(totalMult <= -10)
        totalMult = -10
    return totalMult




/mob/proc/getVampireIntim()
    if(Secret != "Vampire")
        return 0
    var/obj/Skills/Buffs/SlotlessBuffs/v = GetSlotless("Vampire")
    var/obj/Skills/Buffs/SlotlessBuffs/w = GetSlotless("Wassil")
    var/obj/Skills/Buffs/SlotlessBuffs/r = GetSlotless("Rotshreck")
    if(r)
        return round((1 + (getSecretLevel() * 0.5)) * (1 + secretDatum:getBloodPowerRatio()), 0.05)
    else if(w)
        return round((1 + (getSecretLevel()  * 0.25)) * (1 + secretDatum:getHungerRatio()), 0.05)
    else if(v)
        return 1.25 + round((getSecretLevel() * 0.125) * (1 + secretDatum:getBloodPowerRatio()), 0.05)



/mob/proc/GetIntimidation() //TODO add vampire shit
    var/Effective=src.Intimidation
    if(src.ShinjinAscension=="Makai")
        Effective*=src.GetGodKi()*50
    if(src.Race in list("Demon" /*"Majin"*/) || src.CheckSlotless("Majin"))
        Effective*=(src.Potential/2)
        if(src.Race=="Demon"&&src.AscensionsAcquired>=5)
            Effective*=2
    if(src.Race=="Majin")
        var/unhingedBoon = Class == "Unhinged" ? 1 : 0
        if(unhingedBoon)
            unhingedBoon = abs(src.Health - 100)/40
        switch(src.AscensionsAcquired)
            if(1)
                Effective*= 1.5 + unhingedBoon
            if(2)
                Effective*= 3 + unhingedBoon
            if(3)
                Effective*= 4.5 + unhingedBoon
            if(4)
                Effective*= 6 + unhingedBoon
            if(5)
                Effective*= 8 + unhingedBoon
            
    if(!src.CheckSlotless("Majin"))
        var/stp=src.SaiyanTransPower()
        var/halfieNerf = Race == "Half Saiyan" ? 0.8 : 1
        if(stp)
            switch(stp)
                if(1)
                    Effective*=3
                if(2)
                    Effective*=5
                if(3)
                    Effective*=7
                if(4)
                    Effective*=10
            Effective *= halfieNerf
        if(src.Race=="Makyo"&&src.ActiveBuff&&src.AscensionsAcquired&&!src.CyberCancel)
            switch(src.AscensionsAcquired)
                if(1)
                    Effective*=4
                if(2)
                    Effective*=10
                if(3)
                    Effective*=15
                if(4)
                    Effective*=30
                if(5)
                    Effective*=50

    if(src.Race=="Changeling"&&src.TransActive()&&src.AscensionsAcquired)
        Effective+=(10*src.AscensionsAcquired)
    if(src.CheckActive("Mobile Suit")||src.CheckSlotless("Battosai")||src.CheckSlotless("Susanoo"))
        Effective+=5
        if(Effective<15)
            Effective=15
            if(src.CheckActive("Mobile Suit"))
                for(var/obj/Items/Gear/Mobile_Suit/ms in src)
                    Effective*=ms.Level
    if(src.Health<(10-src.HealthCut)&&src.HealthAnnounce10&&src.Saga=="King of Braves"&&src.SpecialBuff)
        var/modifier = 1 - (Health / 10)
        if(src.SpecialBuff.BuffName=="Broken Brave")
            Effective*= (SagaLevel/2) + modifier
        else if(src.SpecialBuff.BuffName=="Genesic Brave")
            Effective *= SagaLevel + modifier
    var/ShonenPower = ShonenPowerCheck(src)
    if(ShonenPower)
        Effective*=GetSPScaling(ShonenPower)
    if(src.HasHellPower())
        Effective*=src.GetHellScaling()
    if(src.KaiokenBP>1)
        Effective*=src.KaiokenBP
    Effective+=src.getVampireIntim()
    if(src.IntimidationMult)
        Effective*=src.IntimidationMult
    if(Effective<0)
        Effective=1
    return Effective

// ADMIN VERBS
/mob/Admin3/verb/changeIntimidationRatio()
    set name = "Change Intim Ratio"
    set desc = "Change the ratio of Intimidation to damage reduction"
    set category = "Admin"
    INTIMRATIO = input("Enter the new ratio: ") as num
    if(INTIMRATIO <= 0)
        INTIMRATIO = 1
    if(INTIMRATIO > 1000)
        INTIMRATIO = 1000
    world<<"Global Intimidation Ratio set to [INTIMRATIO]."

/mob/Admin3/verb/changeIntimidationCalc()
    set name = "Toggle Intimidation Usefulness"
    set desc = "Toggle whether or not Intimidation is useful"
    set category = "Admin"
    NEWINTIMCALC = !NEWINTIMCALC
    world<<"Intimidation is now [NEWINTIMCALC ? "useful" : "useless"]."