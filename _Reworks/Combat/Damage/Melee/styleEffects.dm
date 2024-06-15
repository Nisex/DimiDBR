/mob/proc/activateStyleEffects(forcewarp, ignore=FALSE, disarm, mob/target)
    if(StyleActive=="Rhythm of War" && !ignore)
        if(!locate(/obj/Skills/Projectile/Warsong, src))
            AddSkill(new/obj/Skills/Projectile/Warsong)
        for(var/obj/Skills/Projectile/Warsong/sk in src)
            UseProjectile(sk)
    if(forcewarp)
        if(IaidoCounter)
            IaidoCounter = 0
        if(StyleActive=="Secret Knife" || (UBWPath == "Firm" && SagaLevel >=3))
            if(!locate(/obj/Skills/Projectile/Secret_Knives, src))
                AddSkill(new/obj/Skills/Projectile/Secret_Knives)
            for(var/obj/Skills/Projectile/Secret_Knives/sk in src)
                UseProjectile(sk)
        if(StyleActive=="Blade Singing")
            if(!locate(/obj/Skills/Projectile/Murder_Music, src))
                AddSkill(new/obj/Skills/Projectile/Murder_Music)
            for(var/obj/Skills/Projectile/Murder_Music/sk in src)
                if(CheckSlotless("Legend of Black Heaven"))
                    if(sk.IconLock == 'CheckmateKnives.dmi')
                        sk.IconLock='Soundwave.dmi'
                UseProjectile(sk)
    if(disarm)
        target.Disarm(src, UsingGladiator())

var/disarm_timer = 0

/mob/proc/Disarm(mob/atk, mod)
    passive_handler.Set("Disarmed", 1)
    ticking_generic += src
    disarm_timer = glob.DISARM_TIMER * mod

/mob/Update()
    disarm_timer--
    if(disarm_timer <= 0)
        passive_handler.Set("Disarmed", 0)
        src << "You regain control of your weapon."
        ticking_generic -= src
        disarm_timer = 0

