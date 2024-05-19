#define RANDOM_ALERT list("You feel watched", "Something deep within stirs", "Is there somebody behind you?", "You check over your shoulder, but there's nothing there.", "Faint arcane lingers in the area, if you can detect mana, its plentiful.", "What was... that?")

/obj/Skills/Utility/Imitate
    Cooldown = 10
    verb/Imitate()
        if(usr.Imitating)
            usr.invisibility = 99
            usr.information.loadProfile(usr, "[usr.ckey]_Old_Profile_1", FALSE)
            usr.swapToProfileVars(TRUE)
            sleep(10)
            usr.invisibility = 0
            src.Cooldown()
            usr.Imitating = 0
        else
            var/mob/Target = usr.Target 
            if(Target && get_dist(usr, Target) < 20)
                if(!Target.client) return
                Target <<"<i>[pick(RANDOM_ALERT)]</i>"
                usr.information.takeInformation(usr, usr, "Original Profile","Old_Profile", TRUE, 1)
                usr.invisibility = 99
                usr<<"<i>You fade into the ether as your dark magic replicates [Target]'s form.</i>"
                usr.information.takeInformation(Target, usr, "null", "discarded_file", TRUE, 1)
                usr.swapToProfileVars(FALSE)
                usr.appearance = Target.appearance
                sleep(10)
                usr.invisibility = 0
                usr.Imitating = 1
            else
                usr << "Your target is too far"
