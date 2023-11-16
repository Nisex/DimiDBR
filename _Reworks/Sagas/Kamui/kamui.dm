/mob/proc/getKamuiPower()
    if(Saga == "Kamui")
        var/boon = SagaLevel / 15
        return boon
    return 0


/obj/Skills/Buffs/ActiveBuffs/KamuiTentative
    KiControl=1
    HealthPU=1
    passives = list ("KiControl" = 1, "HealthPU" = 1, "BleedHit" = 0.5)
    StripEquip=1
    FlashChange=1
    HairLock=1
    IconLayer=3
    KenWave=1
    KenWaveIcon='SparkleRed.dmi'
    KenWaveSize=5
    KenWaveTime=30
    KenWaveX=105
    KenWaveY=105
    MakesArmor = TRUE


/obj/Skills/Buffs/ActiveBuffs/KamuiTentative/Senketsu
    HealthThreshold = 30
    StrMult = 1.25
    EndMult = 1.25
    SpdMult = 1.25
    Cooldown = -1
    ArmorClass = "Light"
    // ArmorIcon = 'senketsu_activated.dmi'
    ArmorName = "Senketsu"