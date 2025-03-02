/obj/Items/Sword/Light/Nox
    LegendaryItem = 1
    Ascended = 5
    Destructable = 0
    Unobtainable = 1

/obj/Items/Sword/Light/Nox/Ouroboros
    name = "Geminus Anguium: Ouroboros"
    desc = {"The Snake Pair: Ouroboros (蛇双・ウロボロス Jasō: Uroborosu, localized as Geminus Anguium: Ouroboros) is an Arch-Enemy Event Weapon in the shape of a black snake head attached to a never-ending chain.
Ouroboros is summoned from a special space, and can directly attack the soul or mind of the target."}
    passives = list("SwordPunching" = 1, "Extend" = 1, "Grippy" = 3, "CalmAnger" = 1, "AngerThreshold" = 1.5, "RenameMana" = "HEAT")
    NoSaga=1
    CalmAnger=1
    MagicSword=1
    // Element="Void"
    // void offense would have 2 do something
    Techniques=list("/obj/Skills/Utility/Ouroboros", "/obj/Skills/AutoHit/Ouroboros/Devouring_Fang", "/obj/Skills/AutoHit/Ouroboros/Rising_Fang", "/obj/Skills/AutoHit/Ouroboros/Falling_Fang")


/*
we have an ouroboros skill that is needed to be activated in order to use other moves
each move it calls out to  has its own seperate cooldown

idea: if you use x y z in order you cast a, which consumes mana
ech move's dammage and etc scales with potential
crisis buff probably, might as well fuck it right ?

each ouro skill is like 30-45 cd

grab skillshot proj will snare the enemy
make a skill that reqs them to be snared in order to use
thsi way we can make it seem like a 'reactionary' skill activation, but its only really looking for them to be in that state annd not technically hit by that move specifically


the utility skill holds if it is in use as well as the last used, and the last input
when the last three inputs are a combo is will result in a super (?)


*/
/mob/proc/inRekka()
    var/obj/Skills/Utility/Ouroboros/oo = FindSkill(/obj/Skills/Utility/Ouroboros)
    if(oo.Using)
        return oo
    return FALSE

/obj/Skills/Utility/Ouroboros
    var/last_triggered = ""
    var/list/inputQueue = list()


    verb/Ouroboros()
        set category = "Skills"
        if(!Using)
            Using = 1
            if(usr.hudIsLive("Oro", /obj/orohud))
                animate(usr.client.hud_ids["Oro"], alpha = 255, time = 3)
        else
            Using = 0
            if(usr.client.hud_ids["Oro"])
                animate(usr.client.hud_ids["Oro"], alpha = 0, time = 3)

/obj/orohud
    icon = 'orohud.dmi'
    screen_loc = "1:1,1:128"


/obj/Skills/AutoHit/Ouroboros/Devouring_Fang
    Area = "Arc"
    AdaptRate = 1
    DamageMult = 1
    Distance = 2
    TurfStrike=1
    GuardBreak = 1
    ComboMaster = 1
    TurfShift='Dirt1.dmi'
    TurfShiftDuration=10
    // Cooldown = 45

    adjust(mob/p)
        DamageMult = 1.5 + (p.Potential/25)
        // Cooldown = 45 - (p.Potential/10)
    verb/Devouring_Fang()
        set category = "Skills"
        var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
        if(oo)
            adjust(usr)
            var/acitvated = usr.Activate(src)
            if(acitvated)
                oo.Ouroboros()
                oo.last_triggered = name
            oo.inputQueue.Add(name)

/obj/Skills/AutoHit/Ouroboros/Rising_Fang

    Area="Arc"
    Distance=1
    AdaptRate = 1
    Launcher = 4
    DamageMult=1
    // Cooldown=45 
    TurfShift='Dirt1.dmi'
    TurfShiftDuration=10
    adjust(mob/p)
        DamageMult = 1.5 + (p.Potential/25)
        // Cooldown = 45 - (p.Potential/10)
    verb/Rising_Fang()
        set category = "Skills"
        var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
        if(oo)
            adjust(usr)
            usr.Activate(src)
            oo.Ouroboros()

/obj/Skills/AutoHit/Ouroboros/Falling_Fang
    Area="Cone"
    Distance=1
    AdaptRate = 1
    Dunker = 1
    DamageMult=1
    // Cooldown=45 
    TurfShift='Dirt1.dmi'
    TurfShiftDuration=10
    adjust(mob/p)
        DamageMult = 1.5 + (p.Potential/25)
        Dunker = 1 + (p.Potential/25)
        // Cooldown = 45 - (p.Potential/10)
    verb/Falling_Fang()
        set category = "Skills"
        var/obj/Skills/Utility/Ouroboros/oo = usr.inRekka()
        if(oo)
            adjust(usr)
            usr.Activate(src)
            oo.Ouroboros()