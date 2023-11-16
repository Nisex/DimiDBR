

/mob/proc/fixTitle()
    if(length(information.title) < 1)
        information.addTitle("Noob", "#fff")


/datum/characterInformation
    var/rankingTier = "Rookie"
    var/rankingNumber = "ERROR"
    var/title = list()

    //ranking tier = "Top Ranker", "Ranker" , "Rookie"
    //ranking number = "1-100+""
    //title = "Heavenly Demonic Beast", "Demon King", "The Unkillable Demon", etc.

    proc/resetRanking()
        setRankingTier("Rookie")
        setRankingNumber(rand(1000,9001))
        addTitle("Noob", "#fff")

    proc/addTitle(newTitle,hex)
        title += "<font color=[hex]>[newTitle]</font>"

    proc/getInfo()
        var/content = "Ranking Tier: [rankingTier] ( [rankingNumber] )] \n"
        content += "\[SYSTEM: Titles: "
        var/xLimit = 4
        var/curX = 0
        for(var/x in title)
            if(curX < xLimit)
                content += "( [x] ) "
                curX++
            else
                content += "\n"
                curX = 0
                content += "( [x] ) "
        return content

    proc/setRankingTier(newRankingTier)
        rankingTier = newRankingTier

    proc/setRankingNumber(newRankingNumber)
        rankingNumber = newRankingNumber

    proc/setTitle(newTitle)
        title = list(newTitle)

    proc/pickRankingTier(mob/admin, mob/target)
        var/rankingTier = input(admin, target, "Pick a ranking tier", "Ranking Tier") in RANKING
        target << "You are now a [rankingTier]!"
        setRankingTier(rankingTier)

    proc/pickRankingNumber(mob/admin, mob/target)
        var/rankingNumber = input(admin, target, "Pick a ranking number", "Ranking Number") as num
        target << "You are now a [rankingNumber]!"
        setRankingNumber(rankingNumber)

    proc/pickTitle(mob/admin, mob/target)
        var/title = input(admin, target, "Pick a title", "Title") as text
        target << "You are now a [title]!"
        setTitle(title)