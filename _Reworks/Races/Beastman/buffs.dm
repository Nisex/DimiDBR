/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Heart_of_the_Half_Beast
    TooMuchHealth = 30
    NeedsHealth = 10
    UnrestrictedBuff=1
    Cooldown=-1
    CooldownStatic=1
    CooldownScaling=1
    HealthHeal = 0.5
    StableHeal = 1
    TimerLimit = 20
    ActiveMessage="'s heart begins to pump into overdrive!"
    OffMessage="'s heart can't keep up..."
    proc/getRegenRate(mob/p)
        var/baseHeal = 2.5
        if(!altered)
            var/asc = p.AscensionsAcquired
            baseHeal *= asc
            var/amt = baseHeal
            HealthHeal = (amt / 8-asc) * world.tick_lag // health per tick(?)
            WoundHeal = HealthHeal/2
            TimerLimit = 8-asc             // ticks per regen
    Trigger(mob/User, Override)
        getRegenRate(User)
        ..()



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
            Trigger(usr, Override = 1) // set off to cooldown
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
    WindUp=0.25
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
        DamageMult = dmg * 0.5 + (0.25*asc)
        Size = 3 + (1*asc)
        Distance = 4 + (1*asc)
    

