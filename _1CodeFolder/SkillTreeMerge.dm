mob
	proc
		StyleUnlock(var/obj/Skills/Buffs/NuStyle/ns)//this proc accepts a style object as a parameter so it doesnt check for all styles ever
			/*if(ns.StylePrimeUnlock)//does this even exist?
				if(ns.Mastery>=4)
					if(IsList(ns.StylePrimeUnlock))
						for(var/x in ns.StylePrimeUnlock)
							var/path=text2path(x)
							var/obj/Skills/Buffs/NuStyle/prime = new path
							src.SignatureStyles.Add("[prime.name]" = "[prime.type]")
							src << "[prime.name] has been added to your signature style selection list."
							del prime
					else
						var/path=text2path(ns.StylePrimeUnlock)
						var/obj/Skills/Buffs/NuStyle/prime = new path
						src.SignatureStyles.Add("[prime.name]" = "[prime.type]")
						src << "[prime.name] has been added to your signature style selection list."
						del prime*/
			if(ns.StyleComboUnlock)//does this even exist?)
				if(IsList(ns.StyleComboUnlock))
					for(var/x in ns.StyleComboUnlock)
						if(!x) return //hmm?
						var/advanced_path=ns.StyleComboUnlock[x]
						if(!advanced_path) return
						var/obj/Skills/aps=new advanced_path
						if(locate(aps, src))
							del aps
							continue
						if(x == null)
							continue
						var/obj/Skills/bps=new x
						if(locate(bps, src))
							bps=locate(bps, src)
							if(!src.SignatureStyles.Find("[aps.name]"))
								src.SignatureStyles.Add("[aps.name]")
								src.SignatureStyles["[aps.name]"]="[aps.type]"
								src << "You can now unlock [aps.name] by investing a Tier [aps.SignatureTechnique] Signature into it!"
								del aps
							else
								del aps
								continue
						else
							del bps
							del aps
							continue
				else
					src << "Something is critically wrong with how [ns] is set up to get upgraded styles. Contact Yan."
					return
		// StanceUnlock(var/obj/Skills/Buffs/NuStyle/s)
		// 	var/StanceChoice
		// 	var/StanceConfirm
		// 	var/list/Stances=list()
		// 	Stances.Add("Advancing", "Striking", "Defensive", "Evasive")
		// 	Stances.Remove(s.UnlockedStances)
		// 	if(s.Mastery>=1)//if this aint your first rodeo, allow cancel
		// 		Stances.Add("Cancel")
		// 	while(StanceConfirm!="Yes")
		// 		StanceChoice=input(src, "What stance do you want to buy for [s]?", "Stances") in Stances
		// 		if(StanceChoice in s.UnlockedStances)
		// 			return 0
		// 		if(StanceChoice=="Cancel")
		// 			return 0
		// 		switch(StanceChoice)
		// 			if("Advancing")
		// 				StanceConfirm=alert(src, "Advancing stances focus primarily on offense.  Do you want to develop this stance for [s]?", "Stances", "No", "Yes")
		// 			if("Striking")
		// 				StanceConfirm=alert(src, "Striking stances focus primarily on strength and force.  Do you want to develop this stance for [s]?", "Stances", "No", "Yes")
		// 			if("Defensive")
		// 				StanceConfirm=alert(src, "Defensive stances focus primarily on enduring blows.  Do you want to develop this stance for [s]?", "Stances", "No", "Yes")
		// 			if("Evasive")
		// 				StanceConfirm=alert(src, "Evasive stances focus primarily on speed and defense.  Do you want to develop this stance for [s]?", "Stances", "No", "Yes")
		// 	if(StanceChoice in s.UnlockedStances)
		// 		return 0
		// 	s.UnlockedStances.Add(StanceChoice)
		// 	s.Mastery++
		// 	return StanceChoice
		PrerequisiteRemove(var/obj/Skills/s)
			if(s.PreRequisite.len > 0)
				for(var/x in s.PreRequisite)
					var/path=text2path(x)
					var/obj/Skills/ns=new path

					for(var/obj/Skills/cs in src.Skills)
						var/SwordSkill=0
						if(cs?:NeedsSword)
							SwordSkill=1
						if(src.Saga=="Weapon Soul"&&SwordSkill)
							continue//do not remove sword skills from weapon soul users
						if(cs.type == ns.type)
							src << "Prerequisite technique [ns] has been removed."
							src.SkillsLocked.Add(ns.type)
							src.DeleteSkill(cs)
							continue
					continue
