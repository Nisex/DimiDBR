/obj/Skills/Buffs/SlotlessBuffs/HeavenlyRestriction/HeavenlyRestriction
    AlwaysOn = 1
    ActiveMessage = ""
    OffMessage = ""



/mob/verb/Toggle_Ping_Sound()
    PingSound = !PingSound
    src << "You have turned ping sound [PingSound ? "On" : "Off"]."

/*
pick something to restrict
pick something to improve
depending on the rescrit and improve, give an increase to that improve
if the improve is wide like melee damage, lessen the boon, if its narrow like normal attack widen the boon
if the restrict is narrow like using a sword, lessen the boon, if it is wide like 'using armed skills' widen the boon
(sword punching exists, so somebody could not use a sword, but still use armed skills making it narrow)

at intervals of 2, 4, 6 pick another restrict and improve, if you pick the same, increase the mult of the 1 boon

throw in stat mults at 2,4,5, depending on the path of restricting
    this is to say like a melee focus will get str , a force will get for, anda  hybrid will get both
    a melee will get str but lose for, by picking to lose for they get more str
    same as for and melee, by picking both the bonous is not that much

*/