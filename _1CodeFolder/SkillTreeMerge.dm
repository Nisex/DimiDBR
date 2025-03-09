mob
	proc
		StyleUnlock(obj/Skills/Buffs/NuStyle/ns)//this proc accepts a style object as a parameter so it doesnt check for all styles ever
			if(ns.StyleComboUnlock)//does this even exist?)
				if(IsList(ns.StyleComboUnlock))
					for(var/x in ns.StyleComboUnlock)
						if(!x) return //hmm?
						var/advanced_path=ns.StyleComboUnlock[x]
						if(!advanced_path || advanced_path == null)
							return
						var/obj/Skills/aps=new advanced_path
						if(locate(aps, src))
							del aps
							continue
						if(x == null || isnull(x) || x == "")
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
