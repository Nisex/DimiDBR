globalTracker/var/pot_between_refunds = 5

mob/var/last_refund_pot = 0
mob/var/refund_banned = FALSE
mob/var/tmp/refunding = FALSE

mob/proc/pick_refund_skill(mob/target = src)
	var/list/Refundable=list("Cancel")
	for(var/obj/Skills/S in target.Skills)
		if((S.Copyable>0&&S.SkillCost) || istype(S, /obj/Skills/Buffs/NuStyle))
			Refundable.Add(S)
	var/obj/Skills/Choice=input(src, "What skill are you refunding?", "RPP Refund") in Refundable
	if(Choice=="Cancel")
		return

	return Choice

mob/proc/refund_skill(obj/Skills/refunded_skill)
	var/Refund=refunded_skill.SkillCost

	if(istype(refunded_skill, /obj/Skills/Buffs/NuStyle))
		if(refunded_skill.SignatureTechnique > 0) Refund = 0
		else usr.SignatureSelected -= refunded_skill.name
		Refund += ((2**(refunded_skill.SignatureTechnique+1)*10)) * max(0,(refunded_skill.Mastery-1))
	else if(refunded_skill.Mastery>1)
		Refund+=(refunded_skill.SkillCost*(refunded_skill.Mastery-1))
	if(refunded_skill.name in usr.SkillsLocked)
		usr.SkillsLocked -= refunded_skill.name

	usr.RPPSpendable+=Refund
	usr.RPPSpent-=Refund
	usr << "You've refunded [refunded_skill] for [Commas(Refund)] RPP."

	for(var/obj/Skills/S in usr.Skills)
		if(refunded_skill&&S)
			if(S.type==refunded_skill.type)
				if(S.PreRequisite.len>0 && !istype(refunded_skill, /obj/Skills/Buffs/NuStyle))
					for(var/path in S.PreRequisite)
						var/p=text2path(path)
						var/obj/Skills/oldskill=new p
						usr.AddSkill(oldskill)
						usr << "The prerequisite skill for [refunded_skill], [oldskill] has been readded to your contents."
				if(istype(S, /obj/Skills/Buffs))
					var/obj/Skills/Buffs/s = S
					if(src.BuffOn(s))
						s.Trigger(usr, Override=1)
				del S
				break
	for(var/obj/Skills/Buffs/NuStyle/s in src)
		src.StyleUnlock(s)

mob/verb/Refund()
	set category="Other"
	if(refund_banned) return
	if(refunding)
		usr << "You're already trying to refund something!"
		return
	if(last_refund_pot!=0 && usr.Potential < last_refund_pot+glob.pot_between_refunds)
		usr << "You've already refunded something within the last [glob.pot_between_refunds] potential!"
		return
	refunding = TRUE

	var/refunding_skill = pick_refund_skill()

	if(!refunding_skill)
		refunding = FALSE
		return

	usr.refund_skill(refunding_skill)

	last_refund_pot = usr.Potential
	refunding = FALSE