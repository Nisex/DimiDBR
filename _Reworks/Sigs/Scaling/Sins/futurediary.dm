// mob/verb/t(var/Source as num,Path as text)
//  set hidden=1
//  if(!Source)
//   var/ProcPath=text2path("/[Path]")
//   if(ispath(ProcPath))
//    call(ProcPath)()
//  else
//   call(src,Path)()

// testing purposes

mob/var/WhichFutureDiary
mob/var/DiaryLevel=0


mob/proc/AwardFutureDiary()
    /**
     * This will be used to award the player with the first tier of the Sig
     */

    if(src.WhichFutureDiary!="")
        usr <<"You can only have one Diary at a time!" // edge case in case somehow they already have one.. but get run the proc?
        return

    switch (input(src, "Select one of the Twelve Diaries!","Future Diary") in list("First","Second","Third","Fourth","Fifth","Sixth","Seventh","Eighth","Ninth","Tenth","Eleventh","Twelfth"))
        if("First")
            src.WhichFutureDiary="First"
            passive_handler.Increase("Anaerobic", 1)
            src.Anaerobic++
        if("Second")
            src.WhichFutureDiary="Second"
            passive_handler.Increase("Unstoppable", 1)
            src.Unstoppable++
        if("Third")
            src.WhichFutureDiary="Third"
            passive_handler.Increase("Unstoppable", 1)
            src.Unstoppable++
        if("Fourth")    
            src.WhichFutureDiary="Fourth"
            passive_handler.Increase("Pursuer", 1)
            src.Pursuer++
        if("Fifth")
            src.WhichFutureDiary="Fifth"
            passive_handler.Increase("Adaptation", 1)
            src.Adaptation++
        if("Sixth")
            src.WhichFutureDiary="Sixth"
            passive_handler.Increase("SoulSteal", 1)
            src.SoulSteal++    
        if("Seventh")
            src.WhichFutureDiary="Seventh"
            passive_handler.Increase("CriticalBlock", 1)
            src.CriticalBlock++
        if("Eighth")
            src.WhichFutureDiary="Eighth"
            passive_handler.Increase("Juggernaut", 1)
            src.Juggernaut++
        if("Ninth")
            src.WhichFutureDiary="Ninth"
            passive_handler.Increase("Flicker", 1)
            src.Flicker++
        if("Tenth")
            src.WhichFutureDiary="Tenth"
            passive_handler.Increase("TechniqueMastery", 1)
            src.TechniqueMastery++
        if("Eleventh")
            src.WhichFutureDiary="Eleventh"
            passive_handler.Increase("CriticalChance", 1)
            src.CriticalChance++
        if("Twelfth")
            src.WhichFutureDiary="Twelfth"
            passive_handler.Increase("Steady", 1)
            src.Steady++


// mob/proc/FutureDiaryLevelUp()

//     if (src.DiaryLevel == 1) 
//         // If it the user is at 1, we want to give them a diary before any additional stuff. 
//         // this is the tier 1.
//         src.AwardFutureDiary()
//     else     
//         switch(src.DiaryLevel)
//             if(1)
//                 switch(src.WhichFutureDiary)
//                     if("First")
//                     if("Second")
//                     if("Third")
//                     if("Fourth")
//                     if("Sixth")
//                     if("Seventh")
//                     if("Ninth")
//                     if("Tenth")
//                     if("Eleventh")
//                     if("Twelfth")

