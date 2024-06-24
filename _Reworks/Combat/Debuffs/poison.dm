#define MAX_POISON_DAMAGE 0.06
#define BASE_BURN_DAMAGE 0.06
#define BURN_STACK_DIVISOR 25
#define BURN_NERF 1
#define POISON_STACKS_DIVISOR 100
#define POISON_NERF 1





globalTracker/var/var/maxPoisonDamage = MAX_POISON_DAMAGE
globalTracker/var/var/PoisonStackDivisor = POISON_STACKS_DIVISOR
globalTracker/var/var/PoisonNerf = POISON_NERF
globalTracker/var/var/maxBurnDamage = BASE_BURN_DAMAGE
globalTracker/var/var/BurnStackDivisor = BURN_STACK_DIVISOR
globalTracker/var/var/BurnNerf = BURN_NERF
globalTracker/var/var/DEBUFF_STACK_RESISTANCE = 100

globalTracker/var/var/MAX_DEBUFF_CLAMP = 0.1
globalTracker/var/var/LOWER_DEBUFF_CLAMP = 0.001

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
        
    return clamp(damage, glob.LOWER_DEBUFF_CLAMP, glob.MAX_DEBUFF_CLAMP)

/mob/proc/doDebuffDamage(typeOfDebuff)
    var/dmg = getDebuffDamage(typeOfDebuff)
    if(dmg < 0)
        world.log << "[src] Debuff Damage is negative [dmg], [typeOfDebuff]"
        dmg = 0.001
    var/desp = passive_handler.Get("Desperation")
    if(prob(desp*10)&&!HasInjuryImmune())
        WoundSelf(dmg/desp)
        dmg = 0
    // anger will not reduce debuff damage

    if(VaizardHealth)
        reduceVaiHealth(dmg)
    if(BioArmor)
        reduceBioArmor(dmg)
    if(typeOfDebuff == "Burn" && passive_handler.Get("FireAbsorb"))
        dmg = 0
    switch(typeOfDebuff)
        if("Burn")
            if(TRACKING_BURNING)
                currentBurn+=dmg
        if("Poison")
            if(TRACKING_POISON)
                currentPoi+=dmg
    Health-=dmg
    if(Health<=0 && !KO)
        if(typeOfDebuff == "Poison")
            Unconscious(null, "succumbing to Poison!")
        if(typeOfDebuff == "Burn")
            Unconscious(null, "burning up!")
    reduceDebuffStacks(typeOfDebuff)


/mob/proc/reduceDebuffStacks(typeOfDebuff)
    var/boon = 0
    var/base = clamp(vars["[typeOfDebuff]"] / glob.BASE_DEBUFF_REDUCTION_DIVISOR, glob.BASE_DEBUFF_REDUCTION_DIVISOR_LOWER,glob.BASE_DEBUFF_REDUCTION_DIVISOR_UPPER)
    switch(typeOfDebuff)
        if("Burn")
            if(Cooled)
                base = 1.5
            if(Burn>0)
                Burn -= base + ((GetEnd(0.15)+GetStr(0.15)) * (1+ (GetDebuffImmune() / 4))  )
            if(Burn<0)
                Burn = 0
        if("Poison")
            if(VenomResistance)
                boon = VenomResistance
            if(Antivenomed)
                base = 1.25
            if(Poison>0)
                Poison -= base + (GetEnd(0.15) * (1 + (GetDebuffImmune() / 4)+boon))
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

