/mob/proc/getMeleeKnockback(mob/enemy)
    var/knockDistance = 0
    if(KBAdd)
        knockDistance += KBAdd
    
    if(Grab==enemy)
        knockDistance += 5
        Grab=null
    
    if(HasSword())
        if(UsingZornhau())
            switch(EquippedSword().Class)
                if("Wooden")
                    knockDistance += 0.25
                if("Light")
                    knockDistance += 0.5
                if("Medium")
                    knockDistance += 1
                if("Heavy")
                    knockDistance += 1.5
            if(UsingZornhau()>1)
                knockDistance += 1
            if(Saga == "Weapon Soul"&&SagaLevel>=2)
                knockDistance += SagaLevel / 4
        if(UsingKendo())
            if(EquippedSword().Class == "Wooden")
                knockDistance += 0.75
            else
                knockDistance += 0.5
    if(UsingCriticalImpact())
        knockDistance *= 1.25
    
