/mob/verb/testDOM()
    set category = "Demon Magic Testing"
    var/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind/dm = new()
    src.AddSkill(dm)
    dm.Trigger(src)


/obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind
    var/corruptionGain = list(5,5,8,8,10)
    Range = 25
    ManaCost = 15
    AffectTarget = 1

    applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    proc/adjust(mob/p)
        if(p.isRace(DEMON) && applyToTarget.type != /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon)
            applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon
    
    Trigger(var/mob/User, Override=0)
        if(!altered)
            adjust(User)
            applyToTarget?:adjust(User)
        if(..())
            world<<"here"
            if(1)// usr.isRace(DEMON))
                usr << "you gain coorruption !!"
                var/asc = usr.AscensionsAcquired
                if(asc < 1)
                    asc = 1
                usr << "[corruptionGain[asc]]"
        else
            world<< "here"
/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply
    BuffName = "Dominate Mind Applied"
    MagicNeeded = 0
    StunAffected = 10
    InstantAffect = 1
    TimerLimit = 10
    proc/adjust(mob/p)
        TimerLimit = MAX_STUN_TIME
        


/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind_Apply/Demon
    BuffName = "Mind Dominated"

/obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech