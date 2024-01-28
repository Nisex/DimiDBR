mob/verb/t(var/Source as num,Path as text)
 set hidden=1
 if(!Source)
  var/ProcPath=text2path("/[Path]")
  if(ispath(ProcPath))
   call(ProcPath)()
 else
  call(src,Path)()







mob/var/WhichFutureDiary
mob/var/DiaryLevel=0
// ABILITIES 
mob/proc/Obsession()
    var/list/varPeople = list()
    if(src.Health==100)
        for(var/mob/T in world)
            if(T.client)
                varPeople += T.name
        var/Obsessed=input(src,"Select your Obession","Obsession selection") in varPeople 
        src << "You are Obsessed to " + Obsessed + ". You alongside them deal extra damage to your enemies if you are in the same party!"
        //increase their hit and dodge rate by 50% 

mob/proc/Stalker()
    if(src.Health==100)
        for(var/mob/Players/M in players)
            var/random=pick(M)
            src << random




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
    if (src.DiaryLevel == 1)
        src.AwardFutureDiary()
    else     
        switch(src.DiaryLevel)
            if(1)
                switch(src.WhichFutureDiary)
                    if("First")
                    if("Second")
                    if("Third")
                    if("Fourth")
                    if("Sixth")
                    if("Seventh")
                    if("Ninth")
                    if("Tenth")
                    if("Eleventh")
                    if("Twelfth")
                   