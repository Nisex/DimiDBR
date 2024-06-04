#define NO_PENALTY 0
#define TAX_PENALTY (1 << 1)
#define HEALTH_PENALTY (1 << 2)
#define ENERGY_PENALTY (1 << 3)
#define MANA_PENALTY (1 << 4)
#define DEATH_PENALTY (1 << 5)
#define PENALTY_LIST list("No Penalty", "Tax Penalty", "Health Penalty", "Energy Penalty", "Mana Penalty", "Death Penalty")
#define PENALTY_TRANSLATION_LIST list("No Penalty" = NO_PENALTY, "Tax Penalty" = TAX_PENALTY, "Health Penalty" = HEALTH_PENALTY, "Energy Penalty" = ENERGY_PENALTY, "Mana Penalty" = MANA_PENALTY, "Death Penalty" = DEATH_PENALTY)

#define PACT_LIMIT 3

//i didn't add a way for pactees to view their pacts
// i also didn't test any of it
// im not sure pacts will actually show different in checkPact as options or in breakPact (we can find names via getPlayerNameByUID if need be)
// i also think owner & subject should have their own terms / penalties
// right now an admin is the only one who can actually break a pact. (maybe turn offable)
// the pactee should also have a list or /obj/Pact i think to track this pact that'll update on login as well (pact is broken offline)
// if the pactee also has a /obj/Pact, it should be /obj/Pact/Pactee, and the normal pact should be /obj/Pact/Pacter

/mob/Admin3/verb/BreakPact()
	var/datum/Pact/whichPact = input(usr, "Which pact would you like to break?") in glob.allPacts
	var/withPenalties = input(usr, "Would you like to break that pact with penalties or without?") in list("With Penalties", "Without Penalties")
	switch(withPenalties)
		if("With Penalties")
			withPenalties = TRUE
		if("Without Penalties")
			withPenalties = FALSE
	whichPact.breakPact(withPenalties)

/globalTracker/var/list/allPacts = list() // where the actual pact datum ends up.

proc/findPactByID(id)
	for(var/datum/Pact/pact in glob.allPacts)
		if(pact.pactID == id)
			return pact

/obj/Pact
/obj/Pact/var/pactLimit = PACT_LIMIT
/obj/Pact/var/list/currentPacts // a list with ids to pacts in it

/obj/Pact/New()
	..()
	currentPacts = list()

/obj/Pact/verb/Create_Pact()
	set category = "Skills"
	createPact(usr)

/obj/Pact/verb/Check_Pact()
	set category = "Skills"
	checkPact(usr)

/obj/Pact/proc/checkPact(mob/user)
	var/list/allPacts = getAllPacts()
	if(allPacts.len == 0)
		user << "You don't have any pacts set up!"
		return

	var/datum/Pact/whichPact = input(user, "What pact would you like to view the details and penalty of?") in allPacts
	whichPact.viewAllDetails(user)

/obj/Pact/proc/getAllPacts()
	. = list()
	for(var/pactID in currentPacts)
		. += findPactByID(pactID)

/obj/Pact/proc/checkPactRequirements(mob/user)
	if(currentPacts.len >= pactLimit)
		user << "You already are at the limits for your pacts!"
		return 0
	return 1

/obj/Pact/proc/getTargets(mob/user)
	. = list("Cancel")
	for(var/mob/m in oview(15,user))
		. += m

/obj/Pact/proc/pickTarget(mob/user, list/validTargets)
	var/target = input(user, "Who would you like to make a pact with?") in validTargets
	if(target=="Cancel") return 0
	return target

/obj/Pact/proc/createPact(mob/user)
	if(!checkPactRequirements(user))
		return

	var/list/validTargets = getTargets(user)

	var/target = pickTarget(user, validTargets)

	var/datum/Pact/pact = new(user, target)
	currentPacts += pact.pactID

/datum/Pact
/datum/Pact/var/details // html / text of the details of the pact.
/datum/Pact/var/penalty = NO_PENALTY // bitflag of what penalties to cause.
/datum/Pact/var/subjectUID // subject's UniqueID
/datum/Pact/var/ownerUID // owner's UniqueID
/datum/Pact/var/sealed = FALSE // if the pact is actually active and enforced
/datum/Pact/var/broken = FALSE // if the pact is broken.
/datum/Pact/var/pactID

/datum/Pact/New(mob/Players/owner, mob/Players/subject)
	ownerUID = owner.UniqueID
	subjectUID = subject.UniqueID
	createDetails(owner)
	choosePenalties(owner)
	if(!confirmDetails(owner))
		del src
	if(!presentPact(subject))
		owner << "[subject] rejected your pact!"
		del src
	owner << "[subject] has accepted your pact!"
	subject << "The pact is signed..."
	sealed = TRUE
	pactID = glob.allPacts.len+1
	glob.allPacts += src

/datum/Pact/proc/presentPact(mob/presentingTo)
	viewDetails(presentingTo)
	var/accept = input(presentingTo, "Do you accept the pact with the penalties of [translatePenalty()] from [findPlayerByUID(ownerUID)]?") in list("Yes", "No")
	switch(accept)
		if("Yes")
			return 1
		if("No")
			return 0

/datum/Pact/proc/translatePenalty()
	var/text = ""
	if(penalty & NO_PENALTY)
		text += "No Penalty."
	if(penalty & TAX_PENALTY)
		text += "Tax Penalty, "
	if(penalty & HEALTH_PENALTY)
		text += "Health Penalty, "
	if(penalty & ENERGY_PENALTY)
		text += "Energy Penalty, "
	if(penalty & MANA_PENALTY)
		text += "Mana Penalty, "
	if(penalty & DEATH_PENALTY)
		text += "Death Penalty, "
	text = replacetext(text, ", ", ".", -3, 0)
	return text

/datum/Pact/proc/choosePenalties(mob/picker)
	var/choice
	while(choice != "No Penalty")
		choice = input(picker, "What penalties would you like to add, the current penalties are [translatePenalty()] Click No Penalty when done.", "Penalty Selection") in PENALTY_LIST
		penalty |= PENALTY_TRANSLATION_LIST[choice]

/datum/Pact/proc/createDetails(mob/writer)
	details = input(writer, "What would you like the details to be?") as message

/datum/Pact/proc/viewDetails(mob/viewer)
	viewer << browse(details)

/datum/Pact/proc/confirmDetails(mob/owner)
	viewDetails(owner)
	var/confirm = input("Are you sure you want to present this pact to [findPlayerByUID(subjectUID)] with the penalties of [translatePenalty()] and the following details?") in list("Yes", "No")
	switch(confirm)
		if("Yes")
			return 1
		if("No")
			return 0

/datum/Pact/proc/breakPact(inflictPenalties = FALSE)
	var/mob/subject = findPlayerByUID(subjectUID)
	var/mob/owner = findPlayerByUID(ownerUID)
	if(subject)
		breakPactMessage(subject)
	if(owner)
		breakPactMessage(owner)
	if(inflictPenalties)
		inflictPenalties(owner, subject)
	del src

/datum/Pact/proc/inflictPenalties(mob/owner, mob/subject)

/datum/Pact/proc/breakPactMessage(mob/tellThem)
	if(tellThem)
		viewDetails(tellThem)
		tellThem << "Your pact with the penalties of [translatePenalty()] & the following details has been broken!"

/datum/Pact/proc/viewAllDetails(mob/viewer)
	viewDetails(viewer)
	viewer << "This pact has the penalties of [translatePenalty()]"


// i didnt look at anything below here rly

/datum/DemonRacials/var/PactsByCkey

/datum/DemonRacials/var/PactsTaken

/datum/DemonRacials/proc/givePact(mob/o,mob/p, datum/Pact/pact)
	var/asc = o.AscensionsAcquired + 1
	if(PactsTaken + 1 > asc)
		o <<"You can't make any more pacts."
		return

	giveReward(o, p)



/datum/DemonRacials/proc/giveReward(mob/o, mob/p, option)
	switch(option)
		if("Magic")
			var/skills = list("DarkMagic" = list("Shadow Ball" = /obj/Skills/Projectile/Magic/DarkMagic/Shadow_Ball, \
			"Soul Leech" = /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Soul_Leech, "Dominate Mind" = /obj/Skills/Buffs/SlotlessBuffs/Magic/DarkMagic/Dominate_Mind), \
			"HellFire" = list("Hellpyre" = /obj/Skills/Projectile/Magic/HellFire/Hellpyre, \
			"Hellstorm" = /obj/Skills/AutoHit/Magic/HellFire/Hellstorm, "OverHeat" = /obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat))
			var/exists = TRUE
			var/exit = FALSE
			var/obj/Skills/newSkill = null
			while(exit == FALSE)
				var/category = input(o, "What category") in list("DarkMagic", "HellFire")
				var/selection = input(o, "What skill?") in skills[category]
				for(var/obj/Skills/x in p)
					if(x.type == selection)
						exists = TRUE
						break
				if(exists)
					break
				newSkill = new selection
				exit = TRUE
				// i hate this shit

			p.AddSkill(newSkill)

		if("Passive")
			var/passive = input(o, "What passive?") in o.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2).passives
			if(!passive)
				o << "You have none"
				return
			var/obj/Skills/Buffs/SlotlessBuffs/Posture_2/posture = p.FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Posture_2)
			if(posture)
				posture.passives["[passive]"] += 0
			    // devil arm function to calculate what gets what
