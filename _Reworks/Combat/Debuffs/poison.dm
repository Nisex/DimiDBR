#define MAX_POISON_DAMAGE 0.06
#define BASE_BURN_DAMAGE 0.06
#define BURN_STACK_DIVISOR 25
#define BURN_NERF 1
#define POISON_STACKS_DIVISOR 100
#define POISON_NERF 1





/datum/globalTracker/var/var/maxPoisonDamage = MAX_POISON_DAMAGE
/datum/globalTracker/var/var/PoisonStackDivisor = POISON_STACKS_DIVISOR
/datum/globalTracker/var/var/PoisonNerf = POISON_NERF
/datum/globalTracker/var/var/maxBurnDamage = BASE_BURN_DAMAGE
/datum/globalTracker/var/var/BurnStackDivisor = BURN_STACK_DIVISOR
/datum/globalTracker/var/var/BurnNerf = BURN_NERF
/datum/globalTracker/var/var/DEBUFF_STACK_RESISTANCE = 100

/mob/proc/getDebuffDamage(typeOfDebuff)
    var/stackDivisor = glob.vars["[typeOfDebuff]StackDivisor"]
    var/nerf = glob.vars["[typeOfDebuff]Nerf"]
    var/base = glob.vars["max[typeOfDebuff]Damage"]
    var/debuff = src.vars["[typeOfDebuff]"]
    var/damage = (base * (debuff/stackDivisor)) * nerf
    switch(typeOfDebuff)
        if("Burn")
            if(Cooled)
                damage = damage / 2
        if("Poison")
            if(Antivenomed)
                damage = damage / 2
    return clamp(damage, 0.0001, 5)

/mob/proc/doDebuffDamage(typeOfDebuff)
    var/dmg = getDebuffDamage(typeOfDebuff)
    if(dmg < 0)
        world.log << "[src] Debuff Damage is negative [dmg], [typeOfDebuff]"
        dmg = 0.015
    var/desp = passive_handler.Get("Desperation")
    if(prob(desp*10)&&!HasInjuryImmune())
        WoundSelf(dmg/Desperation)
        dmg = 0
    // anger will not reduce debuff damage

    if(VaizardHealth)
        reduceVaiHealth(dmg)
    if(BioArmor)
        reduceBioArmor(dmg)
    Health-=dmg
    if(Health<=0 && !KO)
        Unconscious(null, "succumbing to Poison!")
    reduceDebuffStacks(typeOfDebuff)


/mob/proc/reduceDebuffStacks(typeOfDebuff)
    var/boon = 0
    var/base = 0
    switch(typeOfDebuff)
        if("Burn")
            if(Cooled)
                base = 1.5
            if(Burn>0)
                Burn -= base + ((GetEnd(0.25)+GetStr(0.1)) * (1+GetDebuffImmune())  )
            if(Burn<0)
                Burn = 0
        if("Poison")
            if(VenomResistance)
                boon = VenomResistance
            if(Antivenomed)
                base = 1.25
            if(Poison>0)
                Poison -= base + (GetEnd(0.25) * (1 + GetDebuffImmune()+boon))
            if(Poison<0)
                Poison = 0





// COPY PASTED CODE BELOW //
/mob/proc/reduceBioArmor(val)
    src.BioArmor-=val
    if(src.BioArmor<=0)
        val=(-1)*src.BioArmor
        src.BioArmor=0
    else
        val=0
/mob/proc/reduceVaiHealth(val)
    src.VaizardHealth-=val
    if(src.VaizardHealth<=0)
        if(src.ActiveBuff)
            if(src.ActiveBuff.VaizardShatter)
                src.ActiveBuff.Trigger(src)
        if(src.SpecialBuff)
            if(src.SpecialBuff.VaizardShatter)
                src.SpecialBuff.Trigger(src)
        for(var/sb in src.SlotlessBuffs)
            var/obj/Skills/Buffs/b = SlotlessBuffs[sb]
            if(b)
                if(b.VaizardShatter)
                    b.Trigger(src)
        if(src.VaizardHealth<0)
            val=((-1)*src.VaizardHealth)
            src.VaizardHealth=0
        else
            val=0
    else
        val=0

