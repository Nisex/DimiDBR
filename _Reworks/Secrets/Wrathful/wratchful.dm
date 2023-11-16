/*
staggering auto buffs that get better and better up until the best being at 10%, 
scaling with potential as well
*/


/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful
    AllOutAttack = 0
    Cooldown = -1
    HealthDrain = 0.01

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/proc/adjust(mob/p)

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_One
    ActiveMessage = "harnesses their primal form to increase their rage."
    OffMessage = "further degrades into a more primal state."
    NeedsHealth = 90
    TooMuchHealth = 91
    HealthThreshold = 75
    Enlarge = 1.5
    BuffName = "Wrath Form"
    HealthDrain = 0.01
    EndMult = 1
    StrMult = 1
    GiantForm = 1
    AutoAnger = 1
    adjust(mob/p)
        if(altered) return
        passives = list("GiantForm" = 1, "AutoAnger" = 1, "Hardening" = round(p.Potential/25,1))
        EndMult = 1 + (p.Potential/200)
        StrMult = 1 + (p.Potential/200)
        ForMult = 1 + (p.Potential/200)
        DefMult = clamp(0.75 + (p.Potential/200),0.75,1)
        SpdMult = clamp(0.75 + (p.Potential/200),0.75,1)
        OffMult = clamp(0.75 + (p.Potential/200),0.75,1)
        HealthDrain = 0.011 - (p.Potential * 0.0001)
        PowerMult = 1 + (p.Potential/200)
    Trigger(mob/User, Override=FALSE)
        adjust(User) 
        ..()
        // gain oozaru, but in base

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_Two
    ActiveMessage = "continues to degrade into a more primal state."
    OffMessage = "fails to keep control of their power."
    NeedsHealth = 75
    TooMuchHealth = 76
    HealthThreshold = 50
    Enlarge = 1.5
    AutoAnger = 1
    BuffName = "Wrathful"
    adjust(mob/p)
        if(altered) return
        passives = list("GiantForm" = 1, "AutoAnger" = 1, "Hardening" = round(p.Potential/25,1), "DemonicDurability" = round(p.Potential/25,1))
        EndMult = 1 + (p.Potential/150)
        StrMult = 1 + (p.Potential/150)
        ForMult = 1 + (p.Potential/150)
        // PowerMult = 1 + (p.Potential/200)
        HealthDrain = 0.02 - (p.Potential * 0.0001)
        AngerMult = 1 + (p.Potential/150)
        if(p.Potential>=100)
            passives["Wrathful"] = 1
    Trigger(mob/User, Override=FALSE)
        adjust(User) 
        ..()

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_Three
    ActiveMessage = "'s power flows out, in an almost uncontrollable manner!"
    OffMessage = "has lost control of their power!"
    NeedsHealth = 50
    TooMuchHealth = 51
    HealthThreshold = 15
    AutoAnger = 1
    Enlarge = 2
    BuffName = "Chou Wrathful"
    adjust(mob/p)
        if(altered) return
        passives = list("GiantForm" = 1, "AutoAnger" = 1, "Hardening" = round(p.Potential/25,1), "DemonicDurability" = round(p.Potential/20,1), "AngerAdaptiveForce" = round(p.Potential/100))
        EndMult = 1 + (p.Potential/150)
        StrMult = 1 + (p.Potential/150)
        ForMult = 1 + (p.Potential/150)
        PowerMult = 1 + (p.Potential/200)
        AngerMult = 1 + (p.Potential/125)
        EnergyHeal = 0.005 * p.Potential
        HealthDrain = 0.02 - (p.Potential * 0.0001)
        VaizardHealth = (5 * (p.Potential/100)) / 10
        if(p.Potential>=75)
            passives["Wrathful"] = 1
    Trigger(mob/User, Override=FALSE)
        adjust(User) 
        ..()

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_Four
    ActiveMessage = "'s power seeps from their very being, leaking out like an endless supply!"
    OffMessage = "'s rage has been quelled.'"
    NeedsHealth = 15
    TooMuchHealth = 16
    Enlarge = 2
    AutoAnger = 1
    BuffName = "Full Power Chou Wrathful"
    adjust(mob/p)
        if(altered) return
        passives = list("GiantForm" = 1, "AutoAnger" = 1, "Hardening" = round(p.Potential/25,1), "DemonicDurability" = round(p.Potential/15,1), "AngerAdaptiveForce" = round(p.Potential/100))
        EndMult = 1 + (p.Potential/100)
        StrMult = 1 + (p.Potential/100)
        ForMult = 1 + (p.Potential/100)
        PowerMult = 1 + (p.Potential/150)
        HealthDrain = 0.05 - (p.Potential * 0.0003)
        EnergyHeal = 0.01 * p.Potential
        AngerMult = 1 + (p.Potential/75)
        VaizardHealth = (15 * (p.Potential/100)) / 10
        if(p.Potential>=50)
            passives["Wrathful"] = 1
    Trigger(mob/User, Override=FALSE)
        adjust(User) 
        ..()


/mob/Admin3/verb/GiveWrathful()
    var/mob/p = input(src, "Who?") in players
    p << "You have been given the Wrathful buff."
    p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_One)
    p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_Two)
    p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_Three)
    p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Wrathful/Stage_Four)
