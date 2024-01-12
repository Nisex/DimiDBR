// Gravity = waterwalk+godspeed+likewater+fluiodform


/obj/Skills/Buffs/SlotlessBuffs/Spirits/Base_Hat_Buff
    passives = list("MartialMagic" = 1)
    proc/getChildBoons(mob/p)
        passives += p.secretDatum:applyPassives(p)


    proc/adjust(mob/p, child)
        grantChildBoons(p)
        if(altered) return
        var/secretLevel = p.getSecretLevel()
        var/pot = p.Potential
        if(p.Class != "Yokai")
            passives["ManaStats"] = 0.25 * secretLevel + (0.01 * pot) // 0.25 per tier + 0.1 per 10 potential
            passives["ManaCapMult"] = 0.2 * secretLevel + (0.01 * pot) // 0.2 per tier + 0.1 per 10 potential
        passives["ManaSteal"] = 5 + (0.5 * pot + (5 * secretLevel)) // max 50% of dmg as mana back @ 50 pot, 80 @ 100
        strAdd = (0.05 * secretLevel) + (0.005 * pot)
        forAdd = (0.05 * secretLevel) + (0.005 * pot)