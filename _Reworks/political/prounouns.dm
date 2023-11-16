


/mob/proc/subjectpronoun()
	if(!client) return "It"
	return information.pronouns[1]

/mob/proc/objectpronoun()
	if(!client) return "It"
	return information.pronouns[2]

/mob/proc/possessivepronoun()
	switch(information.pronouns[1])
		if("He")
			return "His"
		if("She")
			return "Her"
		if("They")
			return "Their"
		if("It")
			return "Its"


/datum/characterInformation
	var/list/pronouns = list()
	var/seePronouns = TRUE
	proc/setPronouns(firsttime)
		if(firsttime)
			var/yesno = input(usr, "Do you want different pronouns than your selected sex?") in list("Yes", "No")
			if(yesno == "No")
				switch(usr.Gender)
					if("Male")
						pronouns = list(SUBJECT_PRONOUNS[1],OBJECT_PRONOUNS[1])
					if("Female")
						pronouns = list(SUBJECT_PRONOUNS[2],OBJECT_PRONOUNS[2])
					if("neuter")
						pronouns = list("It","It")
			else
				var/subject = input(usr,"What is your subject pronoun? (He, She, They, It)") in SUBJECT_PRONOUNS
				var/object = input(usr,"What is your object pronoun? (Him, Her, Them, It)") in OBJECT_PRONOUNS
				pronouns = list(subject, object)
			if(usr.client.getPref("seePronouns") == null)
				yesno = input(usr,"Do you want to see other's pronouns?") in list("Yes", "No")
				yesno = yesno == "Yes" ? TRUE : FALSE
				usr.client.setPref("seePronouns", yesno)
		else
			var/subject = input(usr,"What is your subject pronoun? (He, She, They, It)") in SUBJECT_PRONOUNS
			var/object = input(usr,"What is your object pronoun? (Him, Her, Them, It)") in OBJECT_PRONOUNS
			pronouns = list(subject, object)
	proc/seeOthersPronouns()
		usr.client.setPref("seePronouns", !usr.client.prefs.seePronouns)
		usr<<"[usr.client.getPref("seePronouns") ? "You can now see other people's pronouns." : "You can no longer see other people's pronouns."]"


/mob/verb/Toggle_Pronouns()
	set category = "Other"
	information.seeOthersPronouns()

/mob/verb/Change_Pronouns()
	set category = "Other"
	information.setPronouns(FALSE)
	usr<<"[information.pronouns[1]]/[information.pronouns[2]] are now your pronouns."