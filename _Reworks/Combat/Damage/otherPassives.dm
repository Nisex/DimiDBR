/globalTracker/var/BASE_HARDENING_CHANCE = 20
/globalTracker/var/BASE_MOMENTUM_CHANCE = 20
/globalTracker/var/MAX_MOMENTUM_STACKS = 20
/globalTracker/var/MOMENTUM_DIVISOR = 4

/globalTracker/var/MOMENTUM_BASE_BOON = 0.005
/globalTracker/var/MOMENTUM_MAX_BOON = 4

/globalTracker/var/BASE_FURY_CHANCE = 20
/globalTracker/var/MAX_FURY_STACKS = 20
/globalTracker/var/FURY_DIVISOR = 4

/globalTracker/var/FURY_BASE_BOON = 0.005
/globalTracker/var/FURY_MAX_BOON = 4


/mob/proc/applySoftCC(mob/defender, val)
    if(defender.HasHardening())
        if(prob(glob.BASE_HARDENING_CHANCE * defender.GetHardening()))
            defender.Harden = clamp(defender.Harden + defender.GetHardening()/4, 0, 20)
    if(HasHardening())
        if(prob(glob.BASE_HARDENING_CHANCE * GetHardening()))
            Harden = clamp(Harden + GetHardening()/4, 0, 20)
    if(HasDisorienting())
        if(prob(GetDisorienting()*25))
            defender.AddConfusing(clamp(val, 1,10) * 1.25)
    if(HasStunningStrike())
        if(!defender.Stunned)
            if(prob(clamp(GetStunningStrike() * 10, 10, 70)))
                Stun(defender, 3)
/mob/proc/applyAdditonalDebuffs(mob/defender, value)
    var/list/debuffs = list("Shearing", "Confusing","Crippling", "Attracting", "Terrifying", "Pacifying", "Enraging")
    for(var/debuff in debuffs)
        if(passive_handler.Get("[debuff]"))
            call(defender, "Add[debuff]")(passive_handler.Get("[debuff]") * clamp(value, 0.1, 1))


/mob/proc/finalModifiers(mob/defender)
    if(defender.GetWeaponSoulType() == "Soul Calibur")
        . -= 2

