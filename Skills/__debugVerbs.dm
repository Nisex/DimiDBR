/var/GLOBAL_QUEUE_DAMAGE = 0.85
/var/GLOBAL_MELEE_MULT = 0.9
/var/GLOBAL_POWER_MULT = 1
/var/GLOBAL_ITEM_DAMAGE_MULT = 0.75
/var/ENDURANCE_BASE_RATIO = 0.9
/var/ENDURANCE_DIVISOR = 15
/var/POWER_BASE_RATIO = 0.8 
/var/POWER_MULT_DIVISOR = 150
/var/EXPONENTIAL_PROJ_DAMAGE = FALSE
/var/PROJ_DAMAGE_MULT = 1
/var/AUTOHIT_GLOBAL_DAMAGE = 0.8


/mob/Admin3/verb/GlobalAutoHitDamage()
    set category = "Admin"
    set name = "Change AutoHit Damage"
    set desc = "Changes the global autohit damage multiplier."
    var/newVal = input("New value: ") as num
    if (newVal > 0)
        AUTOHIT_GLOBAL_DAMAGE = newVal
        world << "Global autohit damage multiplier set to [newVal]!"
    else
        usr << "Invalid value!"


/mob/Admin3/verb/GlobalProjDamage()
    set category = "Admin"
    set name = "Change Projectile Damage"
    set desc = "Changes the global projectile damage multiplier."
    var/newVal = input("New value: ") as num
    if (newVal > 0)
        PROJ_DAMAGE_MULT = newVal
        world << "Global projectile damage multiplier set to [newVal]!"
    else
        usr << "Invalid value!"


/mob/Admin3/verb/GlobalItemDmg()
    set category = "Admin"
    set name = "Change Item Damage"
    set desc = "Changes the global item damage multiplier."
    var/newVal = input("New value: ") as num
    if (newVal > 0)
        GLOBAL_ITEM_DAMAGE_MULT = newVal
        world << "Global item damage multiplier set to [newVal]!"
    else
        usr << "Invalid value!"


/mob/Admin3/verb/GlobalMDamage()
    set category = "Admin"
    set name = "Change Melee Damage"
    set desc = "Changes the global melee damage multiplier."
    var/newVal = input("New value: ") as num
    if (newVal > 0)
        GLOBAL_MELEE_MULT = newVal
        world << "Global melee damage multiplier set to [newVal]!"
    else
        usr << "Invalid value!"

/mob/Admin3/verb/globalQDamage()
    set category = "Admin"
    set name = "Change Queue Damage"
    set desc = "Changes the global queue damage multiplier."
    var/newVal = input("New value: ") as num
    if (newVal > 0)
        GLOBAL_QUEUE_DAMAGE = newVal
        world << "Global queue damage multiplier set to [newVal]!"
    else
        usr << "Invalid value!"

//** DEBUG VERB **/

// /mob/verb/giveRagingDemon()
//     AddSkill(new/obj/Skills/AutoHit/Raging_Demon)