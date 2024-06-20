/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Ticking_Bomb
    TooMuchHealth = 55
    NeedsHealth = 50
    HealthThreshold = 0.1
    passives = list("AbsorbingDamage" = 1, "AbsorbLimit" = 1)
    ActiveMessage = "prepares themselves for incoming damage!"
    Cooldown = -1
    adjust(mob/p)
        var/asc = p.AscensionsAcquired
        passives["AbsorbLimit"] = 5 + (5 * asc)
        passives["AbsorbingDamage"] = 1

    Trigger(mob/User, Override)
        if(!User.BuffOn(src))
            // update
            adjust(User)
        ..()

    verb/Unleash_Rage()
        set category = "Skills"
        if(usr.BuffOn(src)) // this means it has proc'd
            // find the autohit, if not, make it
            // adjust the auto hit
            // cast the autohit, send on cooldown
            var/obj/Skills/AutoHit/Haymaker/h = usr.FindSkill(/obj/Skills/AutoHit/Haymaker)
            if(!h)
                h = new()
                usr.AddSkill(h)
            var/dmg = usr.passive_handler.Get("AbsorbingDamage")
            h.adjust(usr, dmg) // sets up the damage and what not
            passives["AbsorbingDamage"] = dmg // this should do it
            Trigger(Override = 1) // set off to cooldown
            usr.Activate(h)
            usr.VaizardHealth += dmg / 2
            // buuuutt just in case
            usr.passive_handler.Set("AbsorbingDamage", 0)
            passives["AbsorbingDamage"] = 1
        else
            usr << "The buff isn't even active yet."


/obj/Skills/AutoHit/Haymaker
    Copyable=0
    NeedsSword=0
    UnarmedOnly=1
    Area="Arc"
    StrOffense=1
    DamageMult=2
    Cooldown=5
    Distance=2
    Size=1
    FlickAttack=1
    ShockIcon='KenShockwave.dmi'
    Shockwave=2
    Shockwaves=1
    PostShockwave=1
    PreShockwave=0
    WindUp=0.5
    Earthshaking=20
    Instinct=1
    Icon='roundhouse.dmi'
    IconX=-16
    IconY=-16
    HitSparkIcon='Hit Effect.dmi'
    HitSparkX=-32
    HitSparkY=-32
    HitSparkTurns=1
    HitSparkSize=1.5
    HitSparkDispersion=1
    TurfStrike=1
    TurfShift='Dirt1.dmi'
    TurfShiftDuration=1
    ActiveMessage="unleashes a vacuum powered slash!"
    adjust(mob/p, dmg)
        var/asc = p.AscensionsAcquired
        DamageMult = dmg * 0.25 +(0.25*asc)
        Size = 1 + (1*asc)
        Distance = 2 + (1*asc)
    

