/**
 *              Future Diary 
 * 
 * Tier 1:
 * Choose a Phone between 1-12.
 * 
 * 1 Pointless infromation about everyone but you (deperation) / (Anaerobic)
 * 2 Infromation about someone you deeply care (Unstoppable)
 * 3 Murder Diary...... more info bout the people you wanna kill, ( Force evil ) (Unstoppable)
 * 4 Detective Diary..... more info bout people you need to catch ( force good ) (Pursuer)
 * 5 See info three times a day, morning, noon, night. Childish (Adaptation) 
 * 6 See what your subordinates see, blind of your own ideas.  (SoulSteal)
 * 7 Love diary part 2, fighting with a selected buddy, gives some bonus? (CriticalBlock)
 * 8 Server diary.... uh, probably could do some cool, like give a aoe slow skill. (Juggernaut)
 * 9 Escape diary.... escape run, seethe cope. (Flicker)
 * 10 Breeder Diary... uh could get some cool dog, that you can command around(?) (HybridStrike)
 * 11 The Watcher.... gets you something related to spying? Invisiblity? (CriticalChance)
 * 12 Justice Diary... Hypnotize people. (Steady)
 * 
 * 
 * + Flow 1 by normal standards.
 * 
 * Tier 2:
 * Skill... based on your diary....(?)
 * 
 * 1 Skill: "Useless beyond!"
 * - At 10% you gain extra adaptation, adaptation is based on your current adaptation times X/5, ( X being your RPL ) (PASSIVE)
 * 
 * 2 Skill: "Yandares cold death"
 * - If an chosen "target" is within range, gain a small damage bonus the lower HP you go. (PASSIVE)
 * 
 * 3 Skill: "Dark Machination"
 * - Slow a opponent down for X seconds, X is based on the current health of the aggressor. 
 * 
 * 4 Skill: "Righteous Pursuit
 * - Due to your police carrier, you have a gun; Autohit dealing X dmg. (Skill) (AUTOHIT)
 * 
 * 5 Skill: "Childish Insight"
 * - Gain a small gain in attack speed, due to your childhood trauma! (PASSIVE)
 * 
 * 6 Skill: "Blindess within"
 * - Inflict your own blindess upon your enemies, they have a blackscreen for a small duration of 1 second. (SKILL)
 * 
 * 
 * 7 Skill: "Heartfelt Guardian"
 * - For your chosen one, when fighting alongside them, you gain extra health for a small duration, when you need it for the most (VAHEALTH 10%) ((PASSIVE))
 * 
 * 
 * 8 Skill: "Cybernetic Halt"
 * - An AOE slow that causes everyone around them within 10 range, to move at a snails pace. (SLOW)
 * 
 * 
 * 9 Skill: "Ephemeral Vanish"
 * - Gain extra charges of Flicker, alongside your Zanzoken deals additional damage for 3 seconds. (PASSIVE)
 * 
 * 
 * 10 Skill: "Alpha's Command"
 * - Summon a wolf like creature to hold your opponent down for a 0.5 seconds! (STUN) (SKILL)
 * 
 * 
 * 11 Skill: "Veiled Watcher"
 * - Go invisible for a second, allowing yourself to catch your opponents offguard! (SKILL)
 * 
 * 
 * 12 Skill: "Hypnotic Oath"
 * - Compell people to move towards you within range of 10.. Effect lasts 1.5 seconds. (OPENER)
 * 
 * 
 * 
 * + Flow 2 by normal standard.
 * 
 * 
 * 
 * TIER 3: 
 * 
 * Like Water 3
 * Godspeed 5
 * Flow 3
 * Instinict 4
 */
mob/var/WhichFutureDiary
mob/var/SigLevel=0
mob/var/CurrentAdaptation

/*
Future Diary Skills   WIP FOR NOW.... !! I'LL JUST MAKE THIS A SCALING PASSIVE SIG !!
*/
/*
mob/verb/UselessBeyond()
    set name = "UselessBeyond"
    set category = "Options"
    if(src.Health>10)
        src<<"You have too much health to use this ability!"
        return
    else
        src.CurrentAdaptation=src.Adaptation
        sleep(5)
        src.Adaptation*=2
        sleep(500)
        src.Adaptation=src.CurrentAdaptation

mob/verb/DeathsColdGaze()
    set name = "DeathsColdGaze"
    set category = "Options"
    
    if(src.Target)
        src.DamageMod*=(1-src.Health/src.MaxHealth)
        sleep(500)

        return
*/


mob/proc/AwardFutureDiary()
    /**
     * This will be used to award the player with the first tier of the Sig
     */
    if(src.WhichFutureDiary!="")
        usr <<"You can only have one Diary at a time!"
        return
    switch (input(src, "Select one of the Twelve Diaries!","Future Diary") in list("First","Second","Third","Fourth","Fifth","Sixth","Seventh","Eighth","Ninth","Tenth","Eleventh","Twelfth"))
        if("First")
            src.WhichFutureDiary="First"
            passive_handler.Increase("Anaerobic")
            src.Anaerobic++
        if("Second")
            src.WhichFutureDiary="Second"
            passive_handler.Increase("Unstoppable")
            src.Unstoppable++
        if("Third")
            src.WhichFutureDiary="Third"
            passive_handler.Increase("Unstoppable")
            src.Unstoppable++
        if("Fourth")    
            src.WhichFutureDiary="Fourth"
            passive_handler.Increase("Pursuer")
            src.Pursuer++
        if("Fifth")
            src.WhichFutureDiary="Fifth"
            passive_handler.Increase("Adaptation")
            src.Adaptation++
        if("Sixth")
            src.WhichFutureDiary="Sixth"
            passive_handler.Increase("SoulSteal")
            src.SoulSteal++    
        if("Seventh")
            src.WhichFutureDiary="Seventh"
            passive_handler.Increase("CriticalBlock")
            src.CriticalBlock++
        if("Eighth")
            src.WhichFutureDiary="Eighth"
            passive_handler.Increase("Juggernaut")
            src.Juggernaut++
        if("Ninth")
            src.WhichFutureDiary="Ninth"
            passive_handler.Increase("Flicker")
            src.Flicker++
        if("Tenth")
            src.WhichFutureDiary="Tenth"
            passive_handler.Increase("TechniqueMastery")
            src.TechniqueMastery++
        if("Eleventh")
            src.WhichFutureDiary="Eleventh"
            passive_handler.Increase("CriticalChance")
            src.CriticalChance++
        if("Twelfth")
            src.WhichFutureDiary="Twelfth"
            passive_handler.Increase("Steady")
            src.Steady++


mob/proc/FutureDiaryLevelUp()
    switch(src.SigLevel)
        if(1)
            switch(src.WhichFutureDiary)
                if("First")

                if("Second")

                if("Third")

                if("Fourth")   

                if("Fifth")

                if("Sixth")

                if("Seventh")

                if("Eighth")

                if("Ninth")     

                if("Tenth")

                if("Eleventh")    

                if("Twelfth")



