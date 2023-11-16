/mob/proc/prompt(message, title, list/options)
    var/choice = input(src, message, title) in options
    return choice

/datum/ascensions
    var/list/choices = list() // if there is a list of choices
    var/list/varsByAscension = list( "1" = list(), "2" = list(), "3" = list()) // a list of variables and values to give to them
    var/list/skillsByAscension = list( "1" = list(), "2" = list(), "3" = list()) // a list of skills and values to give to them
/datum/ascensions/majin

/mob/var/list/majinPicks = new()
/mob/proc/MajinAscension1()
    AscensionsAcquired=1
    Intimidation+=5

    NewAnger(1.5)
    switch(Class)
        if("Innocent")
            Adaptation=1
            passive_handler.Increase("CallousedHands", 0.15)
            switch(prompt("Why Everyoe so mean 2 u? becuz im lard or cause i protec", "Ascension Choice", list("lard", "protec")))
                if("lard")
                    EndAscension+=0.3
                    DefAscension+=0.3
                    SpdAscension-=0.1
                    src<<"why can we be obese?"
                if("protec")
                    DefAscension+=0.15
                    EndAscension+=0.15
                    SpdAscension+=0.1
                    src<<"OH MY GOD ITS 4AM"
            passive_handler.Increase("Blubber")
            Blubber=1
        if("Super")
            Adaptation=1
            switch(prompt("How do you want to proceed? Flexible (All around Boost) or Focused?", "Asension Choice", list("Flexible", "Focused")))
                if("Flexible")
                    StrAscension+=0.1
                    EndAscension+=0.1
                    SpdAscension+=0.1
                    ForAscension+=0.1
                    OffAscension+=0.1
                    DefAscension+=0.1
                    src<<"Doing everything is the best way to do anything..."
                if("Focused")
                    var/choice = 3
                    var/list/choices = list("Str","Def","End","Spd","For")
                    while(choice > 0)
                        switch(prompt("What Stats? You will pick 3", "Sub Choice", choices))
                            if("Str")
                                StrAscension+=0.2
                                choice--
                            if("Def")
                                DefAscension+=0.2
                                choice--
                            if("End")
                                EndAscension+=0.2
                                choice--
                            if("Spd")
                                SpdAscension+=0.2
                                choice--
                            if("For")
                                ForAscension+=0.2
                                choice--
                    src<<"Focus on your strengths, not your weaknesses..."
            passive_handler.Increase("FluidForm")
            FluidForm=1
        if("Unhinged")
            switch(prompt("What do you lean towards more? Carnage (Less Durability, More Speed) or Destruction (Less Durability, More Damage)", "Ascension Choice", list("Carnage", "Destruction")))
                if("Carnage")
                    // Decrease End/Def, Increase Spd/Off
                    EndAscension-=0.1
                    DefAscension-=0.1
                    SpdAscension+=0.15
                    OffAscension+=0.15
                    src<<"You will be the last thing they see..."
                if("Destruction")
                    // Decrease End/Def, Increase Str/Off
                    EndAscension-=0.1
                    DefAscension-=0.1
                    StrAscension+=0.15
                    OffAscension+=0.15
                    src<<"Buildings will crumble at your hands..."
            passive_handler.Increase("UnhingedForm")
            UnhingedForm=1
            AngerPoint=55


/mob/proc/majinPicks()
    majinPicks["[AscensionsAcquired]"] = "" // create a new list for the current ascension
    // majinPicks["2"]
    var/choice
    switch(prompt("How do you move forward?", "Ascension choice", list("Harness Evil", "Remain Consistent", "Become Docile")))
        if("Harness Evil")
            choice = "Harness Evil"
            switch(prompt("Where do you focus?", "Narrowing down", list("Brutality", "Anger","Both")))
                if("Brutality")
                    if(BaseEnd() < 1)
                        passive_handler.Increase("UnhingedForm", 0.25)
                        UnhingedForm += 0.25
                    passive_handler.Increase("Pursuer")
                    Pursuer += 1
                    majinPicks["[AscensionsAcquired]"] = "[choice],Brutality"
                    src<<"You've become a monster, but you're still in control..."
                if("Anger")
                    // var/a = AngerMax + 0.15
                    // if(a + 0.15 >= 3)
                    //     a = 3
                    // NewAnger(a)
                    AngerPoint += 5
                    if(AngerPoint >= 65)
                        EndlessAnger = 1
                        src<<"You can't seem to calm yourself down."
                    passive_handler.Increase("DemonicDurability", 0.25)
                    src<<"You've lost more control over yourself..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Anger"
                if("Both")
                    if(GetEnd() < 1)
                        passive_handler.Increase("UnhingedForm", 0.125)
                        UnhingedForm += 0.125
                    passive_handler.Increase("Pursuer", 0.5)
                    Pursuer += 0.5
                    // var/a = AngerMax + 0.075
                    // if(a + 0.075 >= 3)
                    //     a = 3
                    // NewAnger(a)
                    AngerPoint += 2.5
                    if(AngerPoint >= 65)
                        EndlessAnger = 1
                    passive_handler.Increase("DemonicDurability", 0.125)
                    src<<"Both the lethality and anger of a monster, how will your control last?"
                    majinPicks["[AscensionsAcquired]"] = "[choice],Both"
        if("Remain Consistent")
            majinPicks["[AscensionsAcquired]"] = ""
            choice = "Remain Consistent"
            switch(prompt("Where do you focus?", "Narrowing down", list("Adaptability", "Consistency", "Both")))
                if("Adaptability")
                    Adaptation += 0.2
                    passive_handler.Increase("Flicker")
                    Flicker += 1
                    passive_handler.Increase("Hustle", 0.15)
                    Hustle += 0.15
                    src<<"Your enemy's tactics are your own, you have enhanced your capability to adapt..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Adaptability"
                if("Consistency")
                    passive_handler.Increase("Steady", 0.25)
                    Steady += 0.25
                    passive_handler.Increase("DebuffImmune", 0.15)
                    DebuffImmune += 0.15
                    StableBP += 0.5
                    if(StableBP > 1)
                        StableBP = 1
                    src<<"You've become more consistent in your abilities, you can now maintain your power..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Consistency"
                if("Both")
                    Adaptation += 0.1
                    passive_handler.Increase("Flicker", 0.5)
                    Flicker += 0.5
                    passive_handler.Increase("Hustle", 0.075)
                    Hustle += 0.075
                    passive_handler.Increase("StealsStats", AscensionsAcquired > 2 ? 0.05 : 0)
                    StealsStats += AscensionsAcquired > 2 ? 0.05 : 0
                    passive_handler.Increase("Steady", 0.125)
                    Steady += 0.125
                    passive_handler.Increase("DebuffImmune", 0.075)
                    DebuffImmune += 0.075
                    StableBP += 0.25
                    if(StableBP > 1)
                        StableBP = 1
                    src<<"Consistent and adaptable, the best of both world..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Both"
        if("Become Docile")
            majinPicks["[AscensionsAcquired]"] = ""
            choice = "Become Docile"
            switch(prompt("Where do you focus?", "Narrowing down", list("Stability", "Peace", "Both")))
                if("Stability")
                    passive_handler.Increase("VenomResistance", 0.5)
                    VenomResistance += 0.5
                    passive_handler.Increase("DebuffImmune",0.5)
                    DebuffImmune += 0.5
                    passive_handler.Increase("Juggernaut", 0.5)
                    Juggernaut += 0.5
                    if(Juggernaut >= 1)
                        passive_handler.Increase("GiantForm", 1)
                        GiantForm = 1
                    src<<"You've become more stable, you can now resist the effects of venom..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Stability"
                if("Peace")
                    // AngerPoint -= 5
                    // if(AngerPoint <= 35)
                    //     passive_handler.Increase("CalmAnger", 1)
                    //     CalmAnger=1
                    passive_handler.Increase("Flow", 0.5)
                    Flow += 0.5
                    passive_handler.Increase("DeathField", 0.25)
                    DeathField  += 0.25
                    passive_handler.Increase("VoidField", 0.25)
                    VoidField  += 0.25
                    src<<"You've become more docile, you can now control your anger better..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Peace"

                if("Both")
                    passive_handler.Increase("VenomResistance", 0.25)
                    VenomResistance += 0.25
                    passive_handler.Increase("DebuffImmune",0.25)
                    DebuffImmune += 0.25
                    passive_handler.Increase("Juggernaut",0.25)
                    Juggernaut += 0.25
                    if(Juggernaut >= 1)
                        passive_handler.Increase("GiantForm", 1)
                        GiantForm = 1
                    // AngerPoint -= 2.5
                    // if(AngerPoint <= 35)
                    //     passive_handler.Increase("CalmAnger", 1)
                    //     CalmAnger=1
                    passive_handler.Increase("Flow", 0.25)
                    Flow += 0.25
                    passive_handler.Increase("DeathField", 0.125)
                    VoidField  += 0.125
                    passive_handler.Increase("VoidField", 0.125)
                    VoidField  += 0.125
                    src<<"You've become more stable and docile, you can now resist the effects of venom and control your anger better..."
                    majinPicks["[AscensionsAcquired]"] = "[choice],Both"
            var/adapt = 0
            for(var/x in 1 to majinPicks)
                if(majinPicks[x] == "Remain Consistent,Adaptability" || majinPicks[x] == "Remain Consistent,Both")
                    adapt++
            if(adapt >= 2)
                passive_handler.Increase("StealsStats",AscensionsAcquired > 2 ? 0.1 : 0)
                StealsStats += AscensionsAcquired > 2 ? 0.1 : 0
            var/Peace = 0
            for(var/x in 1 to majinPicks)
                if(majinPicks[x] == "Become Docile,Peace" || majinPicks[x] == "Become Docile,Both")
                    Peace++
            if(Peace >= 2 && !CalmAnger)
                CalmAnger = 1
/mob/proc/MajinAscension2()
    src.AscensionsAcquired=2
    //TODO add new passive that reverses KBs AT HALF the rate
    // INNOCENT
    Intimidation+=5
    majinPicks()
    NewAnger(1.6)
    switch(Class)
        if("Innocent")
            EndAscension+=0.1
            DefAscension+=0.1
            StrAscension+=0.05
            SpdAscension-=0.05
            passive_handler.Increase("CallousedHands", 0.15)
            passive_handler.Increase("Blubber", 0.5)
            Blubber+=0.5
        if("Super")
            // SUPER
            StrAscension+=0.05
            SpdAscension+=0.05
            DefAscension+=0.05
            EndAscension+=0.05
            OffAscension+=0.05

        if("Unhinged")
            // UNHINGED
            EndAscension-=0.1
            DefAscension-=0.1
            StrAscension+=0.1
            SpdAscension+=0.1
            OffAscension+=0.1
            passive_handler.Increase("UnhingedForm", 0.25)
            UnhingedForm+=0.25

    src<<"You have evolved into a new form, your body shifts, bones crack and you sanity is tested..."
/mob/proc/MajinAscension3()
    src.AscensionsAcquired=3
    IntimidationMult += 0.5
    NewAnger(1.7)
    switch(Class)
        if("Innocent")
            passive_handler.Increase("CallousedHands", 0.15)
            passive_handler.Increase("Blubber", 1)
            Blubber+=1
            EndAscension+=0.25
            DefAscension+=0.15
            StrAscension+=0.15
        if("Super")
            // SUPER
            StrAscension+=0.25
            SpdAscension+=0.25
            DefAscension+=0.25
            EndAscension+=0.25
            OffAscension+=0.25
        if("Unhinged")
            // UNHINGED
            EndAscension-=0.2
            DefAscension-=0.2
            StrAscension+=0.1
            SpdAscension+=0.1
            OffAscension+=0.1
            passive_handler.Increase("UnhingedForm", 0.5)
            UnhingedForm+=0.5
    majinPicks()
    src<<"You've cast away all that you've learned to return to your primal, furious and inexhaustible nature!"



/mob/proc/MajinAscension4()
    src.AscensionsAcquired=4
    Intimidation += 10
    NewAnger(2)
    switch(Class)
        if("Innocent")
            passive_handler.Decrease("CallousedHands", 0.15*4)
            passive_handler.Increase("HardenedFrame", 1)
            passive_handler.Increase("Blubber", 1)
            Blubber+=1
            EndAscension+=0.2
            DefAscension+=0.2
            StrAscension+=0.1
        if("Super")
            // SUPER
            StrAscension+=0.1
            SpdAscension+=0.1
            DefAscension+=0.1
            EndAscension+=0.1
            OffAscension+=0.1
        if("Unhinged")
            // UNHINGED
            EndAscension-=0.1
            DefAscension-=0.1
            StrAscension+=0.2
            SpdAscension+=0.2
            OffAscension+=0.2
            passive_handler.Increase("UnhingedForm", 0.5)
            UnhingedForm+=0.5
    majinPicks()
    src<<"Your body is tested, ever reforming and changing, you can hardly cal yourself a mortal anymore..."


/mob/proc/MajinAscension5()
    src.AscensionsAcquired=5
    Intimidation += 10
    switch(Class)
        if("Innocent")
            passive_handler.Increase("Blubber", 1)
            Blubber+=1
            EndAscension+=0.2
            DefAscension+=0.2
            StrAscension+=0.1
        if("Super")
            // SUPER
            StrAscension+=0.05
            SpdAscension+=0.05
            DefAscension+=0.05
            EndAscension+=0.05
            OffAscension+=0.05
        if("Unhinged")
            // UNHINGED
            StrAscension+=0.2
            SpdAscension+=0.2
            OffAscension+=0.2
            passive_handler.Increase("UnhingedForm", 1)
            UnhingedForm+=1
            NewAnger(2.5)
    majinPicks()
    src<<"You've reached the pinnacle of your power, your power is now unmatched!"