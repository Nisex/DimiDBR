

/mob/proc/styleModifiers(mob/defender)

    if(HasSoftStyle())
        . += (defender.TotalFatigue/20) * (GetSoftStyle() / 2)
    if(passive_handler.Get("UnhingedForm"))
        . += (defender.TotalInjury/20) * (passive_handler.Get("UnhingedForm") / 5)
    if(Race == "Half Saiyan" && Class == "Brutal")
        . += (defender.TotalInjury/60) * (AscensionsAcquired / 5)

    if(HasCyberStigma())
        if(defender.CyberCancel || defender.Mechanized || defender.Saga == "King of Braves")
            var/mana = defender.ManaAmount
            var/manaCap = defender.ManaCapMult
            var/ratio = mana / manaCap
            ratio = abs(ratio - 100) / 33
            . += ratio * (max(defender.Mechanized,defender.CyberCancel) * (GetCyberStigma() ))

/mob/proc/DeicideDamage(mob/defender, forced = 0 )
    if(defender.HasGodKi())
        if(!forced)
            var/defenderGKi = defender.GetGodKi()
            var/deicideTicks = passive_handler.Get("Deicide")
            var/percent = deicideTicks * defenderGKi
            var/nerf = HasGodKi() ? 1 - GetGodKi() : 0
            if(nerf)
                if(nerf<=0)
                    nerf = defenderGKi - GetGodKi()
                    percent = deicideTicks * nerf
                . += percent * nerf
            else
                . += percent
        else
            . += forced



/mob/proc/attackModifiers(mob/defender)
    var/nerf = (defender.HasGodKi()) ? 1 - (0.3 * defender.GetGodKi()) : 0
    if(nerf && nerf <= 0)
        nerf = 0.1
    if(HasHolyMod())
        . += HolyDamage(defender) / 4
    if(HasAbyssMod())
        . += AbyssDamage(defender) / 4
    if(HasSlayerMod())
        . += SlayerDamage(defender) / 4
    if(passive_handler.Get("Deicide"))
        . += DeicideDamage(defender) * 4
    else
        if(nerf > 0)
            . *= nerf
