
atom/proc/Examined(mob/user)
mob/Players/var/tmp/current_party_target_index = 1
mob/Players/verb
	Create_Party()
		set category="Party"
		if(src.Class in list("Dance", "Potara"))
			src << "You can't party with fused characters!"
			return
		if(src.party)
			src << "You are already in a party; you cannot create another one."
			return
		var/datum/Party/p=new
		p.create_party(src)

	Party_Target_Cycle()
		set category = "Party"
		if(!src.party)
			src << "You don't have a party to cycle target on!"
			return
		current_party_target_index +=1
		if(current_party_target_index > party.members.len)
			current_party_target_index = 1
		usr.Target = party.members[current_party_target_index]
		usr << "You target [usr.Target]."
	Manage_Party()
		set category="Party"
		if(!src.party)
			src << "You don't have a party to manage!"
			return
		var/list/options=list("Cancel", "Check Party", "Add Member", "Remove Member", "Pass Leader", "Leave Party")
		if(src.party.leader!=src)
			options.Remove("Add Member", "Remove Member", "Pass Leader")
		switch(input(src, "How do you want to manage your party?", "Manage Party") in options)
			if("Cancel")
				return
			if("Check Party")
				for(var/mob/m in src.party.members)
					if(m == src.party.leader)
						src << "\[LEADER\] - \..."
					src << "[m.name] - [round(m.Health, 10)]% / [round(m.Energy, 10)]%"
				return
			if("Add Member")
				if(src==src.party.leader)
					var/list/mob/the_boys=list("Cancel")
					for(var/mob/m in view(8, src))
						if(!m.party && !(m.Class in list("Dance", "Potara")))
							the_boys.Add(m)
					var/mob/my_boy=input(src, "Who do you want to add to your party?", "Add Member") in the_boys
					if(my_boy=="Cancel")
						return
					if(my_boy.party)
						return
					src.party.add_member(my_boy)
				return
			if("Remove Member")
				if(src==src.party.leader)
					var/list/mob/my_boys=list("Cancel")
					my_boys.Add(src.party.members)
					my_boys.Remove(src)
					var/mob/not_my_boy=input(src, "Who do you want to remove from your party?", "Remove Member") in my_boys
					if(not_my_boy=="Cancel")
						return
					if(src.party.members.Find(not_my_boy))
						src.party.remove_member(not_my_boy)
				return
			if("Pass Leader")
				if(src==src.party.leader)
					var/list/mob/my_boys=list("Cancel")
					my_boys.Add(src.party.members)
					my_boys.Remove(src)
					var/mob/the_best_boy=input(src, "Who do you want to pass your leadership to?", "Pass Leader") in my_boys
					if(the_best_boy=="Cancel")
						return
					if(src.party.members.Find(the_best_boy))
						src.party.pass_leader(src, the_best_boy)
				return
			if("Leave Party")
				if(src.party)
					src.party.remove_member(src)
				return

	Signature_Check()
		set category="Other"
		src.SignatureCheck=!src.SignatureCheck
		if(src.SignatureCheck)
			src<<"You have <font color='green'>ENABLED</font color> signature check."
			src.SignatureSelecting=1
			src.PotentialSkillCheck()
			src.SignatureSelecting=0
		else src<<"You have <font color='red'>DISABLED</font color> signature check."

	WatchCombat()
		set name = "Watch"
		set category = "Other"
		if(!(world.time > usr.verb_delay+4)) return
		usr.verb_delay=world.time+1

		if(usr.client.eye == usr) usr.Observing=0

		var/mob/m

		if(src.Observing==4)
			usr << "You stop watching [usr.client.eye]."
			Observify(usr,usr)
			Observing=0
			return
		if(usr.Target)
			m = usr.Target
			if(!m.AllowObservers)
				usr << "You cannot view them."
				return
			if(m.z != usr.z)
				usr << "You cannot view people from other dimensions."
				return
		if(!m)
			var/list/options = list()
			for(var/mob/a in view(15))
				if(a.AllowObservers) options += a
			if(!options.len) return
			options += "Cancel"

			m = input("Who would you like to observe in combat?") in options
		if(ismob(m))
			if(!m.AllowObservers)
				usr << "[m] does not have combat watching enabled."
				return
			Observify(usr, m)
			usr.Observing=4
			usr << "You're now observing [m] in battle!"

	ToggleCombatWatchers()
		set name = "Toggle Combat Watchers"
		set category = "Other"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1

		AllowObservers = !AllowObservers

		if(AllowObservers)
			usr << "People may now watch you in combat."
			viewers(usr) << "[usr] has enabled combat observing!"
			winshow(src, "WatchersLabel",1)
		else
			usr << "People can no longer watch you in combat."
			for(var/mob/m in usr.BeingObserved)
				if(m.Observing==4)
					Observify(m,m)
					m << "[usr] has disabled your ability to watch them fight!"
			winshow(src, "WatchersLabel",0)

	Loot()
		set category=null
		set src in range(1, usr)
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(!src.KO)
			usr << "You can only use this on unconscious opponents."
			return
		usr.Grid("Loot", Lootee=src)
		OMsg(usr, "[usr] begins to rifle through [src]'s belongings...")
	Examine(var/atom/A as mob|obj in view(15, usr))
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(istype(A,/obj))
			if(istype(A,/obj/Items))
				if(A:UpdatesDescription)
					A:Update_Description()
			if(A.desc)
				src<<A.desc
		else if(ismob(A))
			usr<<"This is: [A]"
			var/mob/person = A
			if(client.getPref("seePronouns"))
				usr<<person.information.getInformation(A, TRUE)
			else
				usr<<person.information.getInformation(A, FALSE)
			if(A:TransActive())
				usr << browse(A:ReturnProfile(A:TransActive()), "window=[A];size=900x650")
			else if(locate(/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form, A.contents))
				for(var/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form/SF in A.contents)
					if(SF.SlotlessOn)
						usr << browse(A:ReturnProfile(1), "window=[A];size=900x650")
					else
						usr << browse(A:Profile, "window=[A];size=900x650")
			else
				usr << browse(A:Profile, "window=[A];size=900x650")
			if(A:GimmickDesc!="")
				usr << browse(A:GimmickDesc, "window=Gimmick;size=325x325")
		A.Examined(src)

	Rename(var/atom/A as mob|obj in view(usr,5))
		set src=usr.client
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(istype(A,/obj/Planets))
			usr<<"You're not allowed to rename these objects."
			return
		var/blah=input("") as text
		if(istype(A,/mob))
			if(A!=usr)
				usr<<"You cannot rename other people!"
				return
		if(blah&&blah!=""&&blah!=" ")
			A.name=copytext(blah,1,30)
	SaveVerb()
		set hidden=1
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.Savable)
			if(!usr.SaveDelay)
				usr.SaveDelay=1
				usr<<"<b>Saving and backing up character...</b>"
				usr.client.SaveChar()
				usr.client.BackupSaveChar()
				usr<<"<b>Character saved! You can save again in 5 minutes!</b>"
				spawn(3000)usr.SaveDelay=null


	AFKToggle()
		set category="Other"
		set name="AFK Toggle"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.AFKTimer>0)
			usr.AFKTimer=1
		else if(usr.AFKTimer==0)
			usr.AFKTimer=usr.AFKTimeLimit
			usr.overlays-=usr.AFKIcon
	AFKIcon()
		set category="Other"
		set name="AFK Icon"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.AFKIcon!='afk.dmi')
			usr.AFKIcon='afk.dmi'
			usr<<"AFK icon reverted to default."
		else if(usr.AFKIcon=='afk.dmi')
			var/Z=input(usr,"Choose an icon for your AFK icon!","ChangeIcon")as icon|null
			if(Z==null)
				return
			if((length(Z) > 50000))
				usr <<"This file exceeds the limit of 50KB. It cannot be used."
				return
			usr.AFKIcon=Z
	AFKLimit()
		set category="Other"
		set name="AFK Time Limit"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		usr.AFKTimeLimit=input(usr,"Enter a time limit in seconds before you'll auto AFK. Minimum of 1000, maximum of 75000.","Timey wimey")as num
		if(usr.AFKTimeLimit<1000)
			usr.AFKTimeLimit=1000
		if(usr.AFKTimeLimit>75000)
			usr.AFKTimeLimit=75000
	Custom_Appearance_Skills()
		set category="Other"
		set name="Customize: Skills"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/list/obj/Skills/Choices=list("Cancel")
		for(var/obj/Skills/Power_Control/b in src)
			Choices.Add(b)
		for(var/obj/Skills/Buffs/b in src)
			if(istype(b, /obj/Skills/Buffs/NuStyle))
				continue
			if(istype(b, /obj/Skills/Buffs/Stances))
				continue
			if(istype(b, /obj/Skills/Buffs/Styles))
				continue
			Choices.Add(b)
		for(var/obj/Skills/Queue/b in src)
			Choices.Add(b)
		for(var/obj/Skills/Projectile/b in src)
			Choices.Add(b)
		for(var/obj/Skills/AutoHit/b in src)
			Choices.Add(b)
		var/obj/Skills/S=input(src, "What skill are you modifying?", "Customize Skill") in Choices
		if(S=="Cancel")
			return
		var/Mode
		var/list/PCOptions=list("Icon")
		var/list/BuffOptions=list("Active Message", "Off Message")
		var/list/QueueOptions=list("Charge Message", "Miss Message", "Hit Message", "Icon")
		var/list/ProjectileOptions=list("Charge Message", "Fire Message", "Icon")
		var/list/AutohitOptions=list("Charge Message", "Fire Message", "Icon")
		if(istype(S, /obj/Skills/Buffs/SlotlessBuffs/Aria_Chant))
			Mode=input(src, "What aspect do you wish to customize on [S]?", "Customize Skill") in list("Aria Lines")
		else if(istype(S,/obj/Skills/Power_Control))
			Mode=input(src, "What aspect do you wish to customize on [S]?", "Customize Skill") in PCOptions
		else if(istype(S,/obj/Skills/Buffs))
			Mode=input(src, "What aspect do you wish to customize on [S]?", "Customize Skill") in BuffOptions
		else if(istype(S,/obj/Skills/Queue))
			Mode=input(src, "What aspect do you wish to customize on [S]?", "Customize Skill") in QueueOptions
		else if(istype(S,/obj/Skills/Projectile))
			Mode=input(src, "What aspect do you wish to customize on [S]?", "Customize Skill") in ProjectileOptions
		else if(istype(S,/obj/Skills/AutoHit))
			Mode=input(src, "What aspect do you wish to customize on [S]?", "Customize Skill") in AutohitOptions
		else
			usr << "This skill can't be customized at this time!"
			return
		switch(Mode)
			if("Aria Lines")
				var/list/l = S:Aria
				l.Add("Cancel")
				var/LineNum = input(src, "What line do you want to change?") in l
				l.Remove("Cancel")
				if(LineNum=="Cancel") return
				var/linePos = S:Aria.Find(LineNum)
				var/newLine = input(src, "What would you like the new line to say?") as text|null
				if(!newLine) return
				S:Aria[linePos] = newLine

			if("Active Message")
				S.CustomActive=input(src, "What message do you want [S] to display when activated?  HTML is allowed.", "Set [Mode]") as text|null
				if(S.CustomActive=="")
					S.CustomActive=0
				if(S.CustomActive)
					src << "[S] [Mode] set to '[S.CustomActive]'"
				else
					src << "[S] custom active message cleared."
			if("Off Message")
				S.CustomOff=input(src, "What message do you want [S] to display when deactivated?  HTML is allowed.", "Set [Mode]") as text|null
				if(S.CustomOff=="")
					S.CustomOff=0
				if(S.CustomOff)
					src << "[S] [Mode] set to '[S.CustomOff]'"
				else
					src << "[S] custom off message cleared."
			if("Charge Message")
				S.CustomCharge=input(src, "What message do you want [S] to display when charging?  HTML is allowed.", "Set [Mode]") as text|null
				if(S.CustomCharge=="")
					S.CustomCharge=0
				if(S.CustomCharge)
					src << "[S] [Mode] set to '[S.CustomCharge]'"
				else
					src << "[S] custom charge message cleared."
			if("Fire Message")
				S.CustomActive=input(src, "What message do you want [S] to display when fired?  HTML is allowed.", "Set [Mode]") as text|null
				if(S.CustomActive=="")
					S.CustomActive=0
				if(S.CustomActive)
					src << "[S] [Mode] set to '[S.CustomActive]'"
				else
					src << "[S] custom fire message cleared."
			if("Hit Message")
				S.CustomActive=input(src, "What message do you want [S] to display when hit?  HTML is allowed.", "Set [Mode]") as text|null
				if(S.CustomActive=="")
					S.CustomActive=0
				if(S.CustomActive)
					src << "[S] [Mode] set to '[S.CustomActive]'"
				else
					src << "[S] custom hit message cleared."
			if("Miss Message")
				S.CustomOff=input(src, "What message do you want [S] to display when missed?  HTML is allowed.", "Set [Mode]") as text|null
				if(S.CustomOff=="")
					S.CustomOff=0
				if(S.CustomOff)
					src << "[S] [Mode] set to '[S.CustomOff]'"
				else
					src << "[S] custom miss message cleared."
			if("Icon")
				S.sicon=input("What icon?") as icon|null
				S.sicon_state=input("Icon state?") as text|null
				S.pixel_x=input("Pixel X?") as num|null
				S.pixel_y=input("Pixel Y?") as num|null
				if(S.type in typesof(/obj/Skills/Queue))
					S:IconLock=S.sicon
					S:LockX=S.pixel_x
					S:LockY=S.pixel_y
				if(S.type in typesof(/obj/Skills/Projectile))
					S:LockX=S.pixel_x
					S:LockY=S.pixel_y
					S:IconLock=S.sicon
				if(S.type in typesof(/obj/Skills/AutoHit))
					S:IconX=S.pixel_x
					S:IconY=S.pixel_y
					S:Icon=S.sicon
				usr<<"[S] icon is now changed to: [S.sicon] / [S.sicon_state]"
	Custom_Appearance_Hair(var/mob/A as mob in view(usr,5))
		set src=usr.client
		set category="Other"
		set name="Customize: Hair"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(istype(A,/mob))
			if(usr.Alert("You sure you wanna change [A]'s hair icon?"))
				var/Z=input(usr,"Choose an icon for [A]!","ChangeIcon")as icon|null
				if(Z==null)
					return
				if((length(Z) > 102400))
					usr <<"This file exceeds the limit of 100KB. It cannot be used."
					return
				if(A!=usr)
					var/hm=input(A,"Do you want to change your hair icon into [Z] which [usr] presented?")in list("No","Yes")
					if(hm=="No")
						return
				var/Color=input(A,"Choose color if needed, otherwise hit cancel.") as color|null
				if(Color) Z+=Color
				A.Hair_Base=Z
				A.Hair_Color=Color
				A.Hair_Forms()
				A.Hairz("Add")
	Custom_Appearance_Hair_Details()
		set category="Other"
		set name="Customize: Hair Details"
		src.Hairz("Remove")
		src.HairUnderlay=input(src, "Set a hair underlay.", "Hair Underlay") as file|null
		if(src.HairUnderlay)
			src.HairUnderlayX=input(src, "Pixel X for underlay?", "Hair Underlay X") as num|null
			src.HairUnderlayY=input(src, "Pixel Y for underlay?", "Hair Underlay Y") as num|null
		if(alert(src, "Do you want to set an x/y offset for your hair overlay?", "Hair Overlay Offset", "Yes", "No")=="Yes")
			src.HairX=input(src, "Pixel X for overlay?", "Hair Overlay X") as num|null
			src.HairY=input(src, "Pixel Y for overlay?", "Hair Overlay Y") as num|null
		src.Hairz("Add")
		src << "Done."
	Custom_Appearance_General(var/atom/A as mob|obj in view(usr,5))
		set src=usr.client
		set category="Other"
		set name="Customize: Icon"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(istype(A,/obj))
			if(istype(A,/obj/Planets)||istype(A,/obj/Oozaru)||istype(A,/obj/Login))
				usr<<"You're not allowed to change these icons."
				return
			if(usr.Alert("You sure you wanna change [A]'s icon?"))
				var/Z=input(usr,"Choose an icon for [A]!","ChangeIcon")as icon|null
				if(Z==null)
					return
				if((length(Z) > 95000))
					usr <<"This file exceeds the limit of 50KB. It cannot be used."
					return
				A.LastIconChange=usr.key
				A.icon=Z
				A.icon_state=input("icon state") as text
				A.pixel_x=input("X adjustment.") as num
				A.pixel_y=input("Y adjustment.") as num
		if(istype(A,/mob))
			if(usr.Alert("You sure you wanna change [A]'s icon?"))
				var/Z=input(usr,"Choose an icon for [A]!","ChangeIcon")as icon|null
				if(Z==null)
					return
				if((length(Z) > 102400))
					usr <<"This file exceeds the limit of 100KB. It cannot be used."
					return
				if(A!=usr)
					var/hm=input(A,"Do you want to change your icon into [Z] which [usr] presented?")in list("No","Yes")
					if(hm=="No")
						return
				A.LastIconChange=usr.key
				A.icon=Z
				A.pixel_x=input("X adjustment.") as num
				A.pixel_y=input("Y adjustment.") as num
				A?:customPixelX= A.pixel_x
				A?:customPixelY= A.pixel_y

	Custom_Appearance_Forms(var/atom/A as mob in view(usr,5))
		set src=usr.client
		set category="Other"
		set name="Customize: Forms"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/list/Options=list("Cancel")
		if(istype(A,/mob))
			if(usr.Race=="Human")
				if(usr.HellPower)
					Options.Add("Devil Trigger Base")
					Options.Add("Devil Trigger Hair")
					Options.Add("Devil Trigger Overlay")
					Options.Add("Devil Trigger Top Overlay")
					Options.Add("Devil Trigger Profile")
					if(usr.HellPower>=2)
						Options.Add("Sin Devil Trigger Base")
						Options.Add("Sin Devil Trigger Hair")
						Options.Add("Sin Devil Trigger Overlay")
						Options.Add("Sin Devil Trigger Top Overlay")
						Options.Add("Sin Devil Trigger Profile")
				if(usr.LegendaryPower)
					Options.Add("God Mode Base")
					Options.Add("God Mode Hair")
					Options.Add("God Mode Overlay")
					Options.Add("God Mode Top Overlay")
					Options.Add("God Mode Profile")
			else if(usr.Race in list("Shinjin","Tuffle"))
				if(locate(/obj/Skills/Buffs/SlotlessBuffs/Majin) in usr)
					Options.Add("Sin Devil Trigger Base")
					Options.Add("Sin Devil Trigger Hair")
					Options.Add("Sin Devil Trigger Overlay")
					Options.Add("Sin Devil Trigger Top Overlay")
					Options.Add("Sin Devil Trigger Profile")

			else if(usr.Race=="Demon")
				Options.Add("Devil Trigger Base")
				Options.Add("Devil Trigger Hair")
				Options.Add("Devil Trigger Overlay")
				Options.Add("Devil Trigger Top Overlay")
				Options.Add("Devil Trigger Profile")
			else if(usr.Race=="Makyo")
				Options.Add("Expanded State")
			else if(usr.Race=="Half Saiyan"||usr.Race=="Saiyan")
				Options.Add("Super Saiyan Hair")
				Options.Add("Super Saiyan Profile")
				Options.Add("Super Saiyan 2 Hair")
				Options.Add("Super Saiyan 2 Profile")
				Options.Add("Super Saiyan 3 Hair")
				Options.Add("Super Saiyan 3 Profile")
				Options.Add("Super Saiyan 4 Eyes")
				Options.Add("Super Saiyan 4 Hair")
				Options.Add("Super Saiyan 4 Fur")
				Options.Add("Super Saiyan 4 Clothing")
				Options.Add("Super Saiyan 4 Tail")
				Options.Add("Super Saiyan 4 Profile")
				if(usr.Race=="Saiyan")
					Options.Add("Super Saiyan God Hair")
					Options.Add("Super Saiyan God Profile")
				if(usr.Race=="Half Saiyan")
					Options.Add("Super Saiyan Rage Hair")
					Options.Add("Super Saiyan Rage Profile")
				Options.Add("Ascended Super Saiyan Base")
			else if(usr.Race=="Namekian")
				Options.Add("Super Namekian Base")
				Options.Add("Super Namekian Overlay")
				Options.Add("Super Namekian Top Overlay")
				Options.Add("Super Namekian Profile")
			else if(usr.Race=="Alien")
				Options.Add("Super Alien Base")
				Options.Add("Super Alien Hair")
				Options.Add("Super Alien Overlay")
				Options.Add("Super Alien Top Overlay")
				Options.Add("Super Alien Profile")
				Options.Add("Super Alien Aura")
				Options.Add("Super Alien Active Text")
				Options.Add("Super Alien Revert Text")
				Options.Add("Ascended Super Alien Base")
				Options.Add("Ascended Super Alien Hair")
				Options.Add("Ascended Super Alien Overlay")
				Options.Add("Ascended Super Alien Top Overlay")
				Options.Add("Ascended Super Alien Profile")
				Options.Add("Ascended Super Alien Aura")
				Options.Add("Ascended Super Alien Active Text")
				Options.Add("Ascended Super Alien Revert Text")
				Options.Add("Evolved Ascended Super Alien Base")
				Options.Add("Evolved Ascended Super Alien Hair")
				Options.Add("Evolved Ascended Super Alien Overlay")
				Options.Add("Evolved Ascended Super Alien Top Overlay")
				Options.Add("Evolved Ascended Super Alien Profile")
				Options.Add("Evolved Ascended Super Alien Aura")
				Options.Add("Evolved Ascended Super Alien Active Text")
				Options.Add("Evolved Ascended Super Alien Revert Text")
				Options.Add("Ultimate Evolved Ascended Super Alien Base")
				Options.Add("Ultimate Evolved Ascended Super Alien Hair")
				Options.Add("Ultimate Evolved Ascended Super Alien Overlay")
				Options.Add("Ultimate Evolved Ascended Super Alien Top Overlay")
				Options.Add("Ultimate Evolved Ascended Super Alien Profile")
				Options.Add("Ultimate Evolved Ascended Super Alien Aura")
				Options.Add("Ultimate Evolved Ascended Super Alien Active Text")
				Options.Add("Ultimate Evolved Ascended Super Alien Revert Text")
			else if(usr.Race=="Changeling")
				Options.Add("First Restriction Form Base")
				Options.Add("Second Restriction Form Base")
				Options.Add("Third Restriction Form Base")
				Options.Add("Final Form Base")
				Options.Add("Final Form 100% / Fifth Form Base")
				Options.Add("Golden Form Base")
			else if(locate(/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form, usr))
				Options.Add("Spirit Form Base")
				Options.Add("Spirit Form Hair")
				Options.Add("Spirit Form Top Overlay")
				Options.Add("Spirit Form Overlay")
				Options.Add("Spirit Form Aura")
				Options.Add("Spirit Form Profile")
				Options.Add("Spirit Form Active Text")
				Options.Add("Spirit Form Revert Text")
			else
				usr << "Only certain races and class can change their form icons."
				return

			var/Choice=input(usr, "What aspect of your forms do you wish to edit?", "Change Form Icons") in Options
			switch(Choice)
				if("Expanded State")
					usr.ExpandBase=input(usr, "What base do you want to use for your Expanded State?", "Change Form Icon") as icon|null
				if("Devil Trigger Base")
					usr.Form1Base=input(usr, "What base icon will you use for Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form1Base)
						usr.Form1BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Devil Trigger Hair")
					usr.Form1Hair=input(usr, "What hair will you use for Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form1Hair)
						usr.Form1HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Devil Trigger Overlay")
					usr.Form1Overlay=input(usr, "What overlay will you use for Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form1Overlay)
						usr.Form1OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Devil Trigger Top Overlay")
					usr.Form1TopOverlay=input(usr, "What Top Overlay will you use for Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form1TopOverlay)
						usr.Form1TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Devil Trigger Profile")
					usr.Form1Profile=input(usr, "What will you show as your profile while in Devil Trigger?", "Change Form Icon", usr.Form1Profile) as message|null
				if("Sin Devil Trigger Base")
					usr.Form2Base=input(usr, "What base icon will you use for Sin Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form2Base)
						usr.Form2BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Sin Devil Trigger Hair")
					usr.Form2Hair=input(usr, "What hair will you use for Sin Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form2Hair)
						usr.Form2HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Sin Devil Trigger Overlay")
					usr.Form2Overlay=input(usr, "What overlay will you use for Sin Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form2Overlay)
						usr.Form2OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Sin Devil Trigger Top Overlay")
					usr.Form2TopOverlay=input(usr, "What Top Overlay will you use for Sin Devil Trigger?", "Change Form Icon") as icon|null
					if(usr.Form2TopOverlay)
						usr.Form2TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Sin Devil Trigger Profile")
					usr.Form2Profile=input(usr, "What will you show as your profile while in Sin Devil Trigger?", "Change Form Icon", usr.Form2Profile) as message|null

				if("God Mode Base")
					usr.Form1Base=input(usr, "What base icon will you use for God Mode?", "Change Form Icon") as icon|null
					if(usr.Form1Base)
						usr.Form1BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("God Mode Hair")
					usr.Form1Hair=input(usr, "What hair will you use for God Mode?", "Change Form Icon") as icon|null
					if(usr.Form1Hair)
						usr.Form1HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("God Mode Overlay")
					usr.Form1Overlay=input(usr, "What overlay will you use for God Mode?", "Change Form Icon") as icon|null
					if(usr.Form1Overlay)
						usr.Form1OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("God Mode Top Overlay")
					usr.Form1TopOverlay=input(usr, "What Top Overlay will you use for God Mode?", "Change Form Icon") as icon|null
					if(usr.Form1TopOverlay)
						usr.Form1TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("God Mode Profile")
					usr.Form1Profile=input(usr, "What will you show as your profile while in God Mode?", "Change Form Icon", usr.Form1Profile) as message|null

				if("Ascended Super Saiyan Base")
					usr.ExpandBase=input(usr, "What base do you want to use for Ascended Super Saiyan states?", "Change Form Icon") as icon|null
				if("Super Saiyan Hair")
					usr.Hair_SSJ1=input(usr, "What hair do you want to use for Super Saiyan?", "Change Form Icon") as icon|null
				if("Super Saiyan Hair")
					usr.Hair_FPSSJ1=input(usr, "What hair do you want to use for Super Saiyan Full Powered?", "Change Form Icon") as icon|null
				if("Super Saiyan Profile")
					usr.Form1Profile=input(usr, "What will you show as your profile while in Super Saiyan?", "Change Form Icon", usr.Form1Profile) as message|null
				if("Super Saiyan 2 Hair")
					usr.Hair_SSJ2=input(usr, "What hair do you want to use for Super Saiyan 2?", "Change Form Icon") as icon|null
				if("Super Saiyan 2 Profile")
					usr.Form2Profile=input(usr, "What will you show as your profile while in Super Saiyan 2?", "Change Form Icon", usr.Form2Profile) as message|null
				if("Super Saiyan 3 Hair")
					usr.Hair_SSJ3=input(usr, "What hair do you want to use for Super Saiyan 3?", "Change Form Icon") as icon|null
				if("Super Saiyan 3 Profile")
					usr.Form3Profile=input(usr, "What will you show as your profile while in Super Saiyan 3?", "Change Form Icon", usr.Form3Profile) as message|null
				if("Super Saiyan 4 Eyes")
					usr.EyesSSJ4=input(usr, "What base do you want to use for Super Saiyan 4?", "Change Form Icon") as icon|null
				if("Super Saiyan 4 Hair")
					usr.Hair_SSJ4=input(usr, "What hair do you want to use for Super Saiyan 4?", "Change Form Icon") as icon|null
				if("Super Saiyan 4 Fur")
					usr.FurSSJ4=input(usr, "What do you want to use for fur while in Super Saiyan 4?", "Change Form Icon") as icon|null
				if("Super Saiyan 4 Clothing")
					usr.ClothingSSJ4=input(usr, "What do you want to use for clothing while in Super Saiyan 4?", "Change Form Icon") as icon|null
				if("Super Saiyan 4 Tail")
					usr.TailSSJ4=input(usr, "What do you want to use for tail while in Super Saiyan 4?", "Change Form Icon") as icon|null
				if("Super Saiyan 4 Profile")
					usr.Form4Profile=input(usr, "What will you show as your profile while in Super Saiyan 4?", "Change Form Icon", usr.Form4Profile) as message|null
				if("Super Saiyan God Hair")
					usr.Hair_SSJGod=input(usr, "What hair do you want to use for Super Saiyan God?", "Change Form Icon") as icon|null
				if("Super Saiyan God Profile")
					usr.Form5Profile=input(usr, "What will you show as your profile while in Super Saiyan God?", "Change Form Icon", usr.Form5Profile) as message|null
				if("Super Saiyan Rage Hair")
					usr.Hair_SSJGod=input(usr, "What hair do you want to use for Super Saiyan Rage?", "Change Form Icon") as icon|null
				if("Super Saiyan Rage Profile")
					usr.Form5Profile=input(usr, "What will you show as your profile while in Super Saiyan Rage?", "Change Form Icon", usr.Form5Profile) as message|null

				if("Super Namekian Base")
					usr.Form1Base=input(usr, "What base would you like to use while in Super Namekian?", "Change Form Icon") as icon|null
					if(usr.Form1Base)
						usr.Form1BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Namekian Overlay")
					usr.Form1Overlay=input(usr, "What overlay would you like to use while in Super Namekian?", "Change Form Icon") as icon|null
					if(usr.Form1Overlay)
						usr.Form1OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Namekian Top Overlay")
					usr.Form1TopOverlay=input(usr, "What Top Overlay would you like to use while in Super Namekian?", "Change Form Icon") as icon|null
					if(usr.Form1TopOverlay)
						usr.Form1TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Namekian Profile")
					usr.Form1Profile=input(usr, "What profile would you like to display while in Super Namekian?", "Change Form Icon", usr.Form1Profile) as message|null

				if("Super Alien Base")
					usr.Form1Base=input(usr, "What base would you like to use while in Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form1Base)
						usr.Form1BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Alien Hair")
					usr.Form1Hair=input(usr, "What hair would you like to use while in Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form1Hair)
						usr.Form1HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Alien Overlay")
					usr.Form1Overlay=input(usr, "What overlay would you like to use while in Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form1Overlay)
						usr.Form1OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Alien Top Overlay")
					usr.Form1TopOverlay=input(usr, "What Top Overlay would you like to use while in Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form1TopOverlay)
						usr.Form1TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Alien Profile")
					usr.Form1Profile=input(usr, "What profile would you like to display while in Super Alien?", "Change Form Icon", usr.Form1Profile) as message|null
				if("Super Alien Aura")
					usr.Form1Aura=input(usr, "What aura would you like to use while in Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form1Aura)
						usr.Form1AuraX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1AuraY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Super Alien Active Text")
					usr.Form1ActiveText=input(usr, "What text would you like to display when entering Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Super Alien Revert Text")
					usr.Form1RevertText=input(usr, "What text would you like to display when exiting Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Ascended Super Alien Base")
					usr.Form2Base=input(usr, "What base would you like to use while in Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form2Base)
						usr.Form2BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ascended Super Alien Hair")
					usr.Form2Hair=input(usr, "What hair would you like to use while in Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form2Hair)
						usr.Form2HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ascended Super Alien Overlay")
					usr.Form2Overlay=input(usr, "What overlay would you like to use while in Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form2Overlay)
						usr.Form2OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ascended Super Alien Top Overlay")
					usr.Form2TopOverlay=input(usr, "What Top Overlay would you like to use while in Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form2TopOverlay)
						usr.Form2TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ascended Super Alien Profile")
					usr.Form2Profile=input(usr, "What profile would you like to display while in Ascended Super Alien?", "Change Form Icon", usr.Form2Profile) as message|null
				if("Ascended Super Alien Aura")
					usr.Form2Aura=input(usr, "What aura would you like to use while in Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form2Aura)
						usr.Form2AuraX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form2AuraY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ascended Super Alien Active Text")
					usr.Form2ActiveText=input(usr, "What text would you like to display when entering Ascended Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Ascended Super Alien Revert Text")
					usr.Form2RevertText=input(usr, "What text would you like to display when exiting Ascended Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Evolved Ascended Super Alien Base")
					usr.Form3Base=input(usr, "What base would you like to use while in Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form3Base)
						usr.Form3BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form3BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Evolved Ascended Super Alien Hair")
					usr.Form3Hair=input(usr, "What hair would you like to use while in Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form3Hair)
						usr.Form3HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form3HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Evolved Ascended Super Alien Overlay")
					usr.Form3Overlay=input(usr, "What overlay would you like to use while in Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form3Overlay)
						usr.Form3OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form3OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Evolved Ascended Super Alien Top Overlay")
					usr.Form3TopOverlay=input(usr, "What Top Overlay would you like to use while in Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form3TopOverlay)
						usr.Form3TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form3TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Evolved Ascended Super Alien Profile")
					usr.Form3Profile=input(usr, "What profile would you like to display while in Evolved Ascended Super Alien?", "Change Form Icon", usr.Form3Profile) as message|null
				if("Evolved Ascended Super Alien Aura")
					usr.Form3Aura=input(usr, "What aura would you like to use while in Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form3Aura)
						usr.Form3AuraX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form3AuraY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Evolved Ascended Super Alien Active Text")
					usr.Form3ActiveText=input(usr, "What text would you like to display when entering Evolved Ascended Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Evolved Ascended Super Alien Revert Text")
					usr.Form3RevertText=input(usr, "What text would you like to display when exiting Evolved Ascended Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Ultimate Evolved Ascended Super Alien Base")
					usr.Form4Base=input(usr, "What base would you like to use while in Ultimate Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form4Base)
						usr.Form4BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form4BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ultimate Evolved Ascended Super Alien Hair")
					usr.Form4Hair=input(usr, "What hair would you like to use while in Ultimate Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form4Hair)
						usr.Form4HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form4HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ultimate Evolved Ascended Super Alien Overlay")
					usr.Form4Overlay=input(usr, "What overlay would you like to use while in Ultimate Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form4Overlay)
						usr.Form4OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form4OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ultimate Evolved Ascended Super Alien Top Overlay")
					usr.Form4TopOverlay=input(usr, "What TopOverlay would you like to use while in Ultimate Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form4TopOverlay)
						usr.Form4TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form4TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ultimate Evolved Ascended Super Alien Profile")
					usr.Form4Profile=input(usr, "What profile would you like to display while in Ultimate Evolved Ascended Super Alien?", "Change Form Icon", usr.Form4Profile) as message|null
				if("Ultimate Evolved Ascended Super Alien Aura")
					usr.Form4Aura=input(usr, "What aura would you like to use while in Ultimate Evolved Ascended Super Alien?", "Change Form Icon") as icon|null
					if(usr.Form4Aura)
						usr.Form4AuraX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form4AuraY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Ultimate Evolved Ascended Super Alien Active Text")
					usr.Form4ActiveText=input(usr, "What text would you like to display when entering Ultimate Evolved Ascended Super Alien?  There is no default text.", "Change Form Icons") as text|null
				if("Ultimate Evolved Ascended Super Alien Revert Text")
					usr.Form4RevertText=input(usr, "What text would you like to display when exiting Ultimate Evolved Ascended Super Alien?  There is no default text.", "Change Form Icons") as text|null

				if("Spirit Form Base")
					usr.Form1Base=input(usr, "What base would you like to use while in Spirit Form?", "Change Form Icon") as icon|null
					if(usr.Form1Base)
						usr.Form1BaseX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1BaseY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Spirit Form Hair")
					usr.Form1Hair=input(usr, "What hair would you like to use while in Spirit Form?", "Change Form Icon") as icon|null
					if(usr.Form1Hair)
						usr.Form1HairX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1HairY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Spirit Form Overlay")
					usr.Form1Overlay=input(usr, "What overlay would you like to use while in Spirit Form?", "Change Form Icon") as icon|null
					if(usr.Form1Overlay)
						usr.Form1OverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1OverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Spirit Form Top Overlay")
					usr.Form1TopOverlay=input(usr, "What Top Overlay would you like to use while in Spirit Form?", "Change Form Icon") as icon|null
					if(usr.Form1TopOverlay)
						usr.Form1TopOverlayX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1TopOverlayY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Spirit Form Profile")
					usr.Form1Profile=input(usr, "What profile would you like to display while in Spirit Form?", "Change Form Icon", usr.Form1Profile) as message|null
				if("Spirit Form Aura")
					usr.Form1Aura=input(usr, "What aura would you like to use while in Spirit Form?", "Change Form Icon") as icon|null
					if(usr.Form1Aura)
						usr.Form1AuraX=input(usr, "X offset?", "Change Form Icon") as num|null
						usr.Form1AuraY=input(usr, "Y offset?", "Change Form Icon") as num|null
				if("Spirit Form Active Text")
					usr.Form1ActiveText=input(usr, "What text would you like to display while entering Spirit Form?  There is no default text.", "Change Form Icon") as text|null
				if("Spirit Form Revert Text")
					usr.Form1RevertText=input(usr, "What text would you like to display while entering Spirit Form?  There is no default text.", "Change Form Icon") as text|null

				if("First Restriction Form Base")
					usr.BaseBase=input(usr, "What base would you like to use while in First Restriction Form? This will also become your base icon.", "Change Form Icon") as icon|null
					if(usr.BaseBase)
						usr.icon=usr.BaseBase
				if("Second Restriction Form Base")
					usr.Form1Base=input(usr, "What base would you like to use while in Second Restriction Form?", "Change Form Icon") as icon|null
				if("Third Restriction Form Base")
					usr.Form2Base=input(usr, "What base would you like to use while in Third Restriction Form?", "Change Form Icon") as icon|null
				if("Final Form Base")
					usr.Form3Base=input(usr, "What base would you like to use while in Final Form?", "Change Form Icon") as icon|null
				if("Final Form 100% / Fifth Form Base")
					usr.Form4Base=input(usr, "What base would you like to use while in Final Form 100% / Fifth Form?", "Change Form Icon") as icon|null
				if("Golden Form Base")
					usr.Form5Base=input(usr, "What base would you like to use while in Golden Form?", "Change Form Icon") as icon|null

	Custom_Appearance_Charge()
		set category="Other"
		set name="Customize: Ki Charge"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/Z=input(usr,"Choose an icon for your Charge effect, that shows when charging a beam or Charge skill. The icon must have a blank named icon state in the file.","ChangeIcon")as icon | null
		if(!Z) return
		usr.ChargeIcon=Z
	Reset_Multipliers()
		set category="Other"
		set name="Reset Multipliers"
		if(!(world.time > usr.verb_delay)) return
		is_dashing = 0
		usr.verb_delay=world.time+1
		for(var/b in usr.SlotlessBuffs)
			var/obj/Skills/Buffs/x = usr.SlotlessBuffs[b]
			if(x==null)
				usr.SlotlessBuffs.Remove(null)
			if(x)
				if(istype(x, /obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Armament))
					x:Trigger(src)
				if(istype(x, /obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Observation))
					x:Trigger(src)
		if(usr.StanceBuff||usr.StyleBuff||usr.ActiveBuff||usr.SpecialBuff||usr.SlotlessBuffs.len>0)
			usr<<"You must disable all buffs before using this command."
			return
		if(usr.trans["active"]>0||usr.ssj["active"]>0)
			usr<<"You cannot do this while transed! Revert first!"
			return
		usr<<"Reseting stat and power multipliers."
		usr.Splits=new/list()
		usr.Power_Multiplier=1
		usr.StrMultTotal=1
		usr.EndMultTotal=1
		usr.SpdMultTotal=1
		usr.ForMultTotal=1
		usr.OffMultTotal=1
		usr.DefMultTotal=1
		usr.RecovMultTotal=1
		usr.KBMult=1
		usr.KBAdd=0
		sleep(20)
		usr<<"Stats and power successfully reset to normal."
	Reset_Overlays()
		set category="Other"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		usr.AppearanceOff()
		usr.AppearanceOn()
	Screen_Size()
		set category="Other"
		set hidden=1
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/screenx=input("Enter the width of the screen, max is 31.") as num
		screenx=min(max(1,screenx),31)
		var/screeny=input("Enter the height of the screen, max is 31.") as num
		screeny=min(max(1,screeny),31)
		client.view="[screenx]x[screeny]"
		src.ScreenSize = "[screenx]x[screeny]"
	Text_Color_Say()
		set category="Other"
		set name="Text Color: IC"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		src.Text_Color=input(usr, "Choose a color for Say.") as color
	Emote_Color()
		set category="Other"
		set name="Text Color: Emote"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		src.Emote_Color=input(usr, "Choose a color for Emote.") as color
	Text_Color_OOC()
		set category="Other"
		set name="Text Color: OOC"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		src.OOC_Color=input(usr, "Choose a color for OOC.") as color
	Who()
		set category="Other"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/View={"<html><head><title>Who</title><body>
<font size=3><font color=red>Player Panel:<hr><font size=2><font color=black>"}
		var/list/people=new
		for(var/mob/M in players)
			if(M.client)
				people.Add(M.key)
		var/list/sortedpeople=dd_sortedTextList(people,0)
		var/online=0
		if(usr.Admin)
			View+={"
					<table border=1 cellspacing=6>
					<tr>
					<th><font size=2>Key (IC Name)</th>
					<th><font size=2>IP Address (Computer ID)</th>
					<th><font size=2>Race (Class)</th>
					<th><font size=2>Location</th>
					<th><font size=2>Base (BaseMod )/ Age Category</th>
					<th><font size=2>Reward Points: Spent, Spendable, Total (Race Excluded)</th>
					</tr>"}
			for(var/x in sortedpeople)
				for(var/mob/M in players)
					if(M.key==x)
						online++
						View+={"<tr>
							<td><font size=2>[M.key] ([M.name])/(<a href=?src=\ref[M];action=MasterControl>x</a href>)</td>
							<td><font size=2>[M.client.address] ([M.client.computer_id])</td>
							<td><font size=2>[M.Race] ([M.Class])</td>
							<td><font size=2>[M.loc] ([M.x],[M.y],[M.z])</td>
							<td><font size=2>[M.Base]([M.potential_power_mult]) / [M.EraBody]</td>
							<td><font size=2>[M.RPPSpent], [M.RPPSpendable], [M.RPPSpendable+M.RPPSpent] ([round((M.RPPSpent+M.RPPSpendable)/M.RPPMult,1)])</td>
							</tr>"}
						break
			View+={"</table"><br>"}
		else

			for(var/x in sortedpeople)
				online++
				View+="[x]<br>"
		View+="<font color=green><b>Online:</b> [online]"
		if(usr.Admin)
			usr<<browse("[View]","window=Logzk;size=900x450")
		else
			usr<<browse("[View]","window=Logzk;size=150x400")


	Character_Description()
		set category="Roleplay"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		usr.Profile=input(src, "Please input a description for your character.", "Character Description", usr.Profile) as message
	Countdown()
		set category="Roleplay"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/time=30*10
		src.OMessage(30,"[src] is counting down! ([time/10] seconds)","<font color=silver>[src]([src.key]) used countdown.")
		spawn(time)	src.OMessage(30,"[src] ended counting down! (0 seconds)","<font color=silver>[src]([src.key]) ended using countdown.")
		spawn(time/2)	src.OMessage(30,"[src] counting down! ([time/2/10] seconds)")
		spawn(time/1.2)
			for(var/i=5, i>0, i--)
				src.OMessage(30,"[src] - [i]!")
				sleep(10)
		for(var/obj/Items/Tech/SpaceTravel/Ship/A in view(30,src)) //This for loop detects ships around those that use the say verb.
			for(var/obj/ShipConsole/B in world)
				if(A.Password==B.Password)
					for(var/mob/C in hearers(6,B))
						src.OMessage(30,"[src] is counting down! ([time/10] seconds)","<font color=silver>[src]([src.key]) used countdown.")
						spawn(time)	src.OMessage(30,"[src] ended counting down! (0 seconds)","<font color=silver>[src]([src.key]) ended using countdown.")
						spawn(time/2)	src.OMessage(30,"[src] counting down! ([time/2/10] seconds)")
		for(var/obj/ShipConsole/AA in view(5,src))
			for(var/obj/Items/Tech/SpaceTravel/Ship/BB in world)
				if(AA.Password==BB.Password&&AA.SpeakerToggle==1)
					for(var/mob/C in hearers(12,BB))
						src.OMessage(30,"[src] is counting down! ([time/10] seconds)","<font color=silver>[src]([src.key]) used countdown.")
						spawn(time)	src.OMessage(30,"[src] ended counting down! (0 seconds)","<font color=silver>[src]([src.key]) ended using countdown.")
						spawn(time/2)	src.OMessage(30,"[src] counting down! ([time/2/10] seconds)")
		for(var/obj/Items/Tech/SpaceTravel/SpacePod/A in view(30,src)) //This for loop detects ships around those that use the say verb.
			for(var/obj/PodConsole/B in world)
				if(A.Password==B.Password)
					for(var/mob/C in hearers(6,B))
						src.OMessage(30,"[src] is counting down! ([time/10] seconds)","<font color=silver>[src]([src.key]) used countdown.")
						spawn(time)	src.OMessage(30,"[src] ended counting down! (0 seconds)","<font color=silver>[src]([src.key]) ended using countdown.")
						spawn(time/2)	src.OMessage(30,"[src] counting down! ([time/2/10] seconds)")
		for(var/obj/PodConsole/AA in view(5,src))
			for(var/obj/Items/Tech/SpaceTravel/SpacePod/BB in world)
				if(AA.Password==BB.Password&&AA.SpeakerToggle==1)
					for(var/mob/C in hearers(12,BB))
						src.OMessage(30,"[src] is counting down! ([time/10] seconds)","<font color=silver>[src]([src.key]) used countdown.")
						spawn(time)	src.OMessage(30,"[src] ended counting down! (0 seconds)","<font color=silver>[src]([src.key]) ended using countdown.")
						spawn(time/2)	src.OMessage(30,"[src] counting down! ([time/2/10] seconds)")
	WoundIntent()
		set name="Intent to Injure"
		set category="Roleplay"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.WoundIntent)
			usr.WoundIntent=0
			src.OMessage(10, "<font color='grey'>[src] will no longer fight with intent to injure.</font>", "[src]([src.key]) turned injury intent off.")
		else
			usr.WoundIntent=1
			src.OMessage(10, "<font color='red'>[src] will now fight with intent to injure!!</font>", "[src]([src.key]) turned injury intent on.")
	LethalityToggle()
		set name="Intent to Kill"
		set category= "Roleplay"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(src.Lethal)
			src.Lethal=0
			src.OMessage(10, "<font color='grey'>[src] will no longer deal lethal damage!!</font>", "[src]([src.key]) toggled lethal off.")
			return
		if(!src.Lethal)
			src.OMessage(10, "<font color='red'>[src] will now deal lethal damage!!</font>", "[src]([src.key]) toggled lethal on.")
			src.Lethal=20
			return
	ToggleRPMode()
		set name="Intent to Roleplay"
		set category= "Roleplay"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		RPModeSwitch()


mob/proc/RPModeSwitch()
	if(src.PureRPMode)
		src.PureRPMode=0
		RPMode(src,"Off")
		src<< "You have toggled RP mode off. Regeneration and Recovery enabled. All of your Cooldowns are unpaused."
		src.OMessage(10,"[src] has disabled Pure RP Mode! Regen/Recovery reenabled!")
		for(var/mob/Player/AI/a in ai_followers)
			spawn(rand(1,6)) RPMode(a, "Off")
		for(var/obj/Skills/s in src)
			if(istype(s, /obj/Skills/Grab)) continue
			if(s.cooldown_remaining)
				s.Cooldown(modify=1,Time=s.cooldown_remaining)
		return
	if(!src.PureRPMode)
		RPMode(src,"On")
		src<< "You have toggled RP mode on. Regeneration and Recovery disabled. All of your Cooldowns are paused."
		src.PureRPMode=1
		src.NextAttack=0
		src.OMessage(10,"[src] has enabled Pure RP Mode! Regen/Recovery disabled!")
		for(var/mob/Player/AI/a in ai_followers)
			spawn(rand(1,6)) RPMode(a, "On")
		for(var/obj/Skills/s in src)
			if(istype(s, /obj/Skills/Grab)) continue
			if(s.cooldown_remaining)
				s.cooldown_remaining = s.cooldown_remaining - (world.realtime - s.cooldown_start)
				s.cooldown_start = 0
		return

mob/Players/verb
	Roll_Dice()
		set category="Roleplay"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/textstring=""
		var/total=0
		var/dienumber=input("How many dice?") as num
		if(dienumber>10)
			dienumber=10
		var/diesides=input("How many sides?") as num
		if(diesides>100)
			diesides=100
		var/diemodifer=input("Modify the total?") as num
		if(diemodifer>100)
			diemodifer=100
		if(diemodifer<-100)
			diemodifer=-100
		var/decision=input("Seperate the dice rolls?") in list("Yes","No")
		if(decision=="Yes")
			while(dienumber>0)
				var/die="1d[diesides]"
				var/dieroll=roll(die)
				textstring+="[dieroll] "
				total+=dieroll
				dienumber--
			total+=diemodifer
			usr.OMessage(10,"<b><font color=red>DICE:</b></font> [usr] rolled a total of [total], rolls were [textstring].")
		if(decision=="No")
			var/dice="[dienumber]d[diesides]+[diemodifer]"
			var/roll=roll(dice)
			usr.OMessage(10,"<b><font color=red>DICE:</b></font> [usr] rolled [roll] ([dienumber]d[diesides]+[diemodifer]).")

	Pose()
		set category="Skills"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(src.icon_state==""&&!src.PoseEnhancement)
			if(src.CheckSlotless("Half Moon Form")||src.CheckSlotless("Full Moon Form"))
				OMsg(src, "[src] radiates animalistic bloodlust as they prepare to pounce!")
			else if(src.Secret=="Ripple")
				OMsg(src, "[src] begins posing beautifully!")
			else if(src.Secret=="Vampire")
				OMsg(src, "[src] begins posing ominously!")
			else if(src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus")&&!src.CheckSlotless("Sage Mode"))
				OMsg(src, "[src] grows completely still!")
			else if(src.Secret=="Haki")
				if(src.CheckSlotless("Haki Armament"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Armament/H in src)
						H.Trigger(src)
				if(!src.CheckSlotless("Haki Observation"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Observation/H in src)
						H.Trigger(src)
				OMsg(src, "[src] relaxes, becoming a reed on the wind!")
				src.AddHaki("Observation")
				if(!src.CheckSlotless("Haki Relax")&&!src.CheckSlotless("Haki Relax Lite"))
					if(src.secretDatum.secretVariable["HakiSpecialization"]=="Observation")
						for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Relax/H in src)
							H.Trigger(src)
					else
						for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Relax_Lite/H in src)
							H.Trigger(src)
					src.PoseEnhancement=1
					spawn(Second(30))
						src.PoseEnhancement=0
				return
			src.icon_state="Train"
			return
		if(src.icon_state=="Train")
			src.icon_state=""
			if(!src.PoseEnhancement)
				if(!src.CheckSlotless("Half Moon Form")&&!src.CheckSlotless("Full Moon Form"))
					if(src.PoseTime>=5&&(src.HasRipple()||src.Secret=="Vampire"||src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus")))
						src.PoseTime=0
						if(src.HasRipple())
							src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Ripple_Enhancement)
						if(src.Secret=="Vampire")
							src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Restraint_Release)
						if(src.Secret=="Senjutsu"&&src.CheckSlotless("Senjutsu Focus"))
							src.ManaAmount+=25

				else
					var/PoseBuff=src.PoseTime
					if(PoseBuff<1)
						PoseBuff=1
					src.PoseTime=0
					if(src.Target)
						src.Comboz(src.Target)
						src.Melee1(damagemulti=PoseBuff, accmulti=PoseBuff, NoKB=1)
					src.PoseEnhancement=1
					spawn(Second(30))
						src.PoseEnhancement=0
			return
	Skill_Sheet()
		set name="Skill Sheet"
		set hidden=1
		set category="Skills"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		usr.Grid("SkillSheet")

	Access_Technology()
		set category="Utility"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		usr.Grid("Tech")
	Access_Enchantment()
		set category="Utility"
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		usr.Grid("Enchant")



/*	Admins()
		set category="Other"
		var/list/admins=new
		admins.Add(Admins,CodedAdmins)
		for(var/x in admins)
			for(var/mob/M in world)
				if(M.client)
					if(M.key==x)
						usr<<"[x] | [admins[x]]<font color=green> (Online)"
						admins.Remove(x)
		admins.Remove(CodedAdmins)
		for(var/y in admins)
			usr<<"[y] | [admins[y]]"*/



mob/proc/Controlz(var/mob/M)
	if(src.Admin)
		return "(<a href=?src=\ref[M];action=MasterControl>x</a href>)"

var/Allow_OOC=1

obj/Communication
	var/ShowOOC=1
	var/LOOCinIC=0
	var/AllTabOOC=1
	var/LOOCinAll=1
	var/AdminAlerts=1
	var/Logins = 1
	var/RewardAlerts=1
	var/Telepathy_Enabled=1


	verb/Toggle_Channels()
		set category="Other"
		if(!(world.time > usr.verb_delay))
			return
		usr.verb_delay=world.time+1
		var/selection=input("Select a toggle option.")in list("Toggle OOC","Toggle All Tab OOC","Toggle IC tab LOOC","Toggle All Tab LOOC")
		switch(selection)
			if("Toggle OOC")
				src.ShowOOC=!src.ShowOOC
				if(src.ShowOOC)
					usr<<"You turn your OOC <font color=green>on</font color>."
				else
					usr<<"You turn your OOC <font color=red>off</font color>."
			if("Toggle All Tab OOC")
				for(var/obj/Communication/C in usr)
					if(C.AllTabOOC)
						C.AllTabOOC=0
						usr<<"OOC messages will not display in the All tab."
					else
						C.AllTabOOC=1
						usr<<"OOC messages will display in the All tab."
			if("Toggle IC tab LOOC")
				for(var/obj/Communication/C in usr)
					if(C.LOOCinIC)
						C.LOOCinIC=0
						usr<<"LOOC messages will not display in the IC tab."
					else
						C.LOOCinIC=1
						usr<<"LOOC messages will display in the IC tab."
			if("Toggle All tab LOOC")
				for(var/obj/Communication/C in usr)
					if(C.LOOCinAll)
						C.LOOCinAll=0
						usr<<"LOOC messages will not display in the IC tab."
					else
						C.LOOCinAll=1
						usr<<"LOOC messages will display in the IC tab."

	verb/OOC(T as text)
		set category = "Other"
		set src=usr.contents
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		var/datum/donator/donator = donationInformation.getDonator(key = usr.key)
		var/datum/supporter/supporter = donationInformation.getSupporter(key = usr.key)
		var/oocOff = OOC_Check(T)
		if(oocOff == FALSE && (donator.getTier() >= 3))
			oocOff = TRUE
		if(oocOff)
			if(!usr.Admin) T=copytext(T,1,700)
			if(SpamCheck(usr,T))return
			var/keyjack=usr.key
			if(supporter)
				if(supporter.displayKey != "" && supporter.getTier() >=2)
//TODO make a client side json that lets them pick if they have both
					if(usr.DisplayKey != supporter.displayKey)
						usr.DisplayKey = supporter.displayKey
			if(donator)
				if(donator.displayKey != "" && donator.getTier() >=1)
					if(usr.DisplayKey != donator.displayKey)
						usr.DisplayKey = donator.displayKey
			if(usr.DisplayKey)
				keyjack=usr.DisplayKey
			for(var/mob/Players/P)
				for(var/obj/Communication/C in P)
					var/oocMsg = "<font color=lime><b>OOC:"
					if(C.ShowOOC)
						var/benefitsTitle = ""
						if(donator || supporter)
							benefitsTitle = usr.getBenefitTitle(donator, supporter)
						if(P.Timestamp)
							var/timestamp = "<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]</font>"
							if(C.AllTabOOC)
								P << output("[timestamp][benefitsTitle][oocMsg]</b><font color=[usr.OOC_Color]> <b>[keyjack]</b>[P.Controlz(usr)]: <font color=white>[html_encode(T)]", "output")
							P << output("[timestamp][benefitsTitle][oocMsg]</b><font color=[usr.OOC_Color]> <b>[keyjack]</b>[P.Controlz(usr)]: <font color=white>[html_encode(T)]", "oocchat")
						else
							if(C.AllTabOOC)
								P << output("[benefitsTitle][oocMsg]</b><font color=[usr.OOC_Color]> <b>[keyjack]</b>[P.Controlz(usr)]: <font color=white>[html_encode(T)]", "output")
							P << output("[benefitsTitle][oocMsg]</b><font color=[usr.OOC_Color]> <b>[keyjack]</b>[P.Controlz(usr)]: <font color=white>[html_encode(T)]", "oocchat")
	verb/Say(T as text)
		set category="Roleplay"
		set src=usr.contents
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1

		if(usr.Fused==2)
			var/mob/m = usr.client.eye
			if(m.ckey == usr.Fusee)
				for(var/obj/Communication/c in m)
					if(!(usr in m.BeingObserved)) m.BeingObserved.Add(usr)
					usr=m
					c.Say(T)
					return

		if(usr.CheckSlotless("Camouflage"))
			var/obj/Skills/Buffs/SlotlessBuffs/Camouflage/C = usr.GetSlotless("Camouflage")
				C.Trigger(usr)
			usr << "Your camouflage is broken!"
		if(usr.CheckSlotless("Invisibility"))
			var/obj/Skills/Buffs/SlotlessBuffs/Magic/Magic_Show/I = usr.GetSlotless("Magic Show")
			if(I.Invisible)
				I.Trigger(usr)
			usr << "You reveal yourself!"
		var/LOOCSay=findtext(T,")")
		var/LOOCSay2=findtext(T,"(")
		var/LOOCSay4=findtext(T,"{")
		var/LOOCSay5=findtext(T,"}")
		if(!LOOCSay&&!LOOCSay2&&!LOOCSay4&&!LOOCSay5)
			if(usr.SenseRobbed>=3)
				T="---"
		var/list/hearers
		if(usr.in_vessel) hearers = usr.in_vessel.occupant_refs
		else hearers = hearers(12,usr)
		for(var/mob/E in hearers)
			if(LOOCSay||LOOCSay2||LOOCSay4||LOOCSay5)
				for(var/obj/Communication/C in E)
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] LOOCs: [html_encode(T)]", "loocchat")
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] LOOCs: [html_encode(T)]", "oocchat")
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] LOOCs: [html_encode(T)]", "output")
			else
				T = usr.redactBannedWords(T)
				if(E.SenseRobbed<4)
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] says: [html_encode(T)]", "icchat")
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] says: [html_encode(T)]", "output")
			Log(E.ChatLog(),"<font color=green>[usr]([usr.key]) says: [html_encode(T)]")

			if(E.BeingObserved.len>0)
				for(var/mob/m in E.BeingObserved)
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] says: [html_encode(T)]", "icchat")
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] says: [html_encode(T)]", "output")


			for(var/obj/Items/Enchantment/Arcane_Mask/EarCheck in E)
				if(EarCheck.suffix) //Checks to make sure the ear(s) are equipped.
					for(var/mob/Players/OrbCheck in world) //Searches the world for players...
						for(var/obj/Items/Enchantment/ArcanicOrb/FinalCheck in OrbCheck) //Checks for Arcanic Orbs.
							if(EarCheck.LinkTag in FinalCheck.LinkedMasks)
								if(FinalCheck.Active)
									OrbCheck << output("[FinalCheck](hearing [E]):<font color=[usr.Text_Color]>[usr] says: [html_encode(T)]", "output")
									OrbCheck << output("[FinalCheck](hearing [E]):<font color=[usr.Text_Color]>[usr] says: [html_encode(T)]", "icchat")

			for(var/obj/Items/Tech/Planted_Wiretap/WT in E)
				for(var/mob/Players/M in players)
					if(M.InMagitekRestrictedRegion())
						continue
					for(var/obj/Items/Tech/Scouter/Q in M)
						if(Q.Frequency==WT.Frequency)
							if(!(M in hearers(12, usr)))
								M<<"<font color=green><b>([WT.name])</b> [usr.name]: [html_encode(T)]"
							Log(M.ChatLog(),"<font color=green>([WT.name])[usr]([usr.key]) says: [html_encode(T)]")
					for(var/obj/Items/Tech/Communicator/Q in M)
						if(Q.Frequency==WT.Frequency&&Q.toggled_on==1)
							if(!(M in hearers(12, usr)))
								M<<"<font color=green><b>([WT.name])</b> [usr.name]: [html_encode(T)]"
							Log(M.ChatLog(),"<font color=green>([WT.name])[usr]([usr.key]) says: [html_encode(T)]")
					for(var/obj/Skills/Utility/Internal_Communicator/B in M)
						if(B.ICFrequency==WT.Frequency)
							if(!(M in hearers(12, usr)))
								M<<"<font color=green><b>(Internal Comms (Freq:[B.ICFrequency]))</b> [usr.name]: [html_encode(T)]"
							Log(M.ChatLog(),"<font color=green>([WT.name])[usr]([usr.key]) says: [html_encode(T)]")
						if(B.MonitoringFrequency==WT.Frequency)
							if(!(M in hearers(12, usr)))
								M<<"<font color=green><b>(Internal Comms (Monitoring Freq:[B.MonitoringFrequency]))</b> [usr.name]: [html_encode(T)]"
							Log(M.ChatLog(),"<font color=green>([WT.name])[usr]([usr.key]) says: [html_encode(T)]")

		for(var/obj/Items/Tech/Security_Camera/F in view(11,usr)) //This for loop detects Security Cameras around those that use the say verb.
			if(F.Active==1)
				for(var/mob/Players/CC in players)
					if(CC.InMagitekRestrictedRegion()) continue
					for(var/obj/Items/Tech/Scouter/CCS in CC)
						if(F.Frequency==CCS.Frequency)
							if(CC.Timestamp)
								CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=[usr.Text_Color]>[F.name] transmits: [usr.name] says: [html_encode(T)]", "output")
								CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=[usr.Text_Color]>[F.name] transmits: [usr.name] says: [html_encode(T)]", "icchat")
							else
								CC << output("<font color=[usr.Text_Color]>[F.name] transmits: [usr.name] says: [html_encode(T)]", "output")
								CC << output("<font color=[usr.Text_Color]>[F.name] transmits: [usr.name] says: [html_encode(T)]", "icchat")

		for(var/obj/Items/Tech/Recon_Drone/FF in view(11,usr))
			if(FF.who)
				FF.who << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[FF.name] transmits: [usr] says: [html_encode(T)]", "output")
				FF.who << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[FF.name] transmits: [usr] says: [html_encode(T)]", "icchat")

		for(var/obj/Items/Tech/SpaceTravel/Ship/A in view(12,usr)) //This for loop detects ships around those that use the say verb.
			for(var/obj/ShipConsole/B in world)
				if(A.Password==B.Password)
					for(var/mob/C in hearers(20,B))
						C << output("<font color=green><b>([A.name] External Camera)</b> [usr.name]: [html_encode(T)]", "output")
						C << output("<font color=green><b>([A.name] External Camera)</b> [usr.name]: [html_encode(T)]", "icchat")

		for(var/obj/ShipConsole/AA in view(20,usr))
			for(var/obj/Items/Tech/SpaceTravel/Ship/BB in world)
				if(AA.Password==BB.Password&&AA.SpeakerToggle==1)
					for(var/mob/C in hearers(20,BB))
						C << output("<font color=green><b>([BB.name] External Speaker)</b> [usr.name]: [html_encode(T)]", "output")
						C << output("<font color=green><b>([BB.name] External Speaker)</b> [usr.name]: [html_encode(T)]", "icchat")

		for(var/obj/Items/Tech/SpaceTravel/SpacePod/A in view(20,usr)) //This for loop detects ships around those that use the say verb.
			for(var/obj/PodConsole/B in world)
				if(A.Password==B.Password)
					for(var/mob/C in hearers(20,B))
						C << output("<font color=green><b>([A.name] External Camera)</b> [usr.name]: [html_encode(T)]", "output")
						C << output("<font color=green><b>([A.name] External Camera)</b> [usr.name]: [html_encode(T)]", "icchat")

		for(var/obj/PodConsole/AA in view(20,usr))
			for(var/obj/Items/Tech/SpaceTravel/SpacePod/BB in world)
				if(AA.Password==BB.Password&&AA.SpeakerToggle==1)
					for(var/mob/C in hearers(20,BB))
						C << output("<font color=green><b>([BB.name] External Speaker)</b> [usr.name]: [html_encode(T)]", "output")
						C << output("<font color=green><b>([BB.name] External Speaker)</b> [usr.name]: [html_encode(T)]", "icchat")
		usr.Say_Spark()
		if(usr.AFKTimer==0)
			usr.overlays-=usr.AFKIcon

		usr.AFKTimer=usr.AFKTimeLimit



	verb/Yell(T as text)
		set category="Roleplay"
		set src=usr.contents
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.Fused==2)
			var/mob/m = usr.client.eye
			if(m.ckey == usr.Fusee)
				for(var/obj/Communication/c in m)
					if(!(usr in m.BeingObserved)) m.BeingObserved.Add(usr)
					usr=m
					c.Yell(T)
					return
		if(usr.CheckSlotless("Camouflage"))
			var/obj/Skills/Buffs/SlotlessBuffs/Camouflage/C = usr.GetSlotless("Camouflage")
				C.Trigger(usr)
			usr << "Your camouflage is broken!"
		if(usr.CheckSlotless("Invisibility"))
			var/obj/Skills/Buffs/SlotlessBuffs/Magic/Magic_Show/I = usr.GetSlotless("Magic Show")
			if(I.Invisible)
				I.Trigger(usr)
			usr << "You reveal yourself!"
		if(usr.SenseRobbed>=3)
			T="---"

		var/list/hearers
		if(usr.in_vessel) hearers = usr.in_vessel.occupant_refs
		else hearers = hearers(20,usr)
		for(var/mob/E in hearers)
			if(E.SenseRobbed<4)
				E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] yells: <b>[html_encode(T)]</b>", "output")
				E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] yells: <b>[html_encode(T)]</b>", "icchat")
				Log(E.ChatLog(),"<font color=green>[usr]([usr.key]) yells: <b>[html_encode(T)]</b>")

			if(E.BeingObserved.len>0)
				for(var/mob/m in E.BeingObserved)
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] yells: [html_encode(T)]", "icchat")
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] yells: [html_encode(T)]", "output")

			for(var/obj/Items/Enchantment/Arcane_Mask/EarCheck in E)
				if(EarCheck.suffix) //Checks to make sure the ear(s) are equipped.
					for(var/mob/Players/OrbCheck in players) //Searches the world for players...
						for(var/obj/Items/Enchantment/ArcanicOrb/FinalCheck in OrbCheck) //Checks for Arcanic Orbs.
							if(EarCheck.LinkTag in FinalCheck.LinkedMasks)
								if(FinalCheck.Active)
									OrbCheck<<output("<b>[FinalCheck](hearing [E]</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] yells: [html_encode(T)]", "icchat")
									OrbCheck<<output("<b>[FinalCheck](hearing [E])</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] yells: [html_encode(T)]", "output")

		for(var/obj/Items/Tech/Security_Camera/F in view(20,usr))
			if(F.Active==1)
				for(var/mob/CC in players)
					if(CC.InMagitekRestrictedRegion()) continue
					for(var/obj/Items/Tech/Scouter/CCS in CC)
						if(F.Frequency==CCS.Frequency)
							if(CC.Timestamp)
								CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=[usr.Text_Color]>*[F.name] transmits: [usr.name] yells: [html_encode(T)]", "output")
								CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=[usr.Text_Color]>*[F.name] transmits: [usr.name] yells: [html_encode(T)]", "icchat")
							else
								CC << output("<font color=[usr.Text_Color]>[F.name] transmits: [usr.name] yells: [html_encode(T)]", "output")
								CC << output("<font color=[usr.Text_Color]>[F.name] transmits: [usr.name] yells: [html_encode(T)]", "icchat")
				for(var/obj/Items/Tech/Security_Display/G in world)
					if(G.Password==F.Password)
						if(G.Active==1)
							for(var/mob/H in hearers(G.AudioRange,G))
								H << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits: [usr] yells: [html_encode(T)]", "output")
								H << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits: [usr] yells: [html_encode(T)]", "icchat")
								Log(H.ChatLog(),"<font color=green>[F.name](Made by [F.CreatorKey]) transmits: [usr] yells: [html_encode(T)]")





		usr.Say_Spark(3)
		if(usr.AFKTimer==0)
			usr.overlays-=usr.AFKIcon

		usr.AFKTimer=usr.AFKTimeLimit

	verb/Whisper(T as text)
		set category="Roleplay"
		set src=usr.contents
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.Fused==2)
			var/mob/m = usr.client.eye
			if(m.ckey == usr.Fusee)
				for(var/obj/Communication/c in m)
					if(!(usr in m.BeingObserved)) m.BeingObserved.Add(usr)
					usr=m
					c.Whisper(T)
					return
		var/list/peepz=new
		if(usr.SenseRobbed>=3)
			T="---"
		for(var/mob/E in hearers(1,usr))
			if(E.SenseRobbed<4)
				if(E.EnhancedHearing==0)
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] whispers: <i>[html_encode(T)]</i>", "output")
					E << output("<font color=[usr.Text_Color]>[usr][E.Controlz(usr)] whispers: <i>[html_encode(T)]</i>", "icchat")
					Log(E.ChatLog(),"<font color=green>[usr]([usr.key]) WHISPERS: [html_encode(T)]")
					peepz.Add(E)
//			if(E.BeingObserved.len>0)
//				for(var/mob/m in E.BeingObserved)
//					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] whispers: [html_encode(T)]", "icchat")
//					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] whispers: [html_encode(T)]", "output")
			for(var/obj/Items/Enchantment/Arcane_Mask/EarCheck in E)
				if(EarCheck.suffix) //Checks to make sure the ear(s) are equipped.
					for(var/mob/Players/OrbCheck in players) //Searches the world for players...
						for(var/obj/Items/Enchantment/ArcanicOrb/FinalCheck in OrbCheck) //Checks for Arcanic Orbs.
							if(EarCheck.LinkTag in FinalCheck.LinkedMasks)
								if(FinalCheck.Active)
									OrbCheck<<output("<b>[FinalCheck](hearing [E])</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] whispers: [html_encode(T)]", "icchat")
									OrbCheck<<output("<b>[FinalCheck](hearing [E])</b><font color=[usr.Text_Color]>[usr][E.Controlz(usr)] whispers: [html_encode(T)]", "output")
		for(var/mob/X in hearers(20,usr))
			if(!X.SenseRobbed||X.SenseRobbed<4)
				if(X.EnhancedHearing==1)
					X << output("<font color=[usr.Text_Color]>[usr][X.Controlz(usr)] whispers: <i>[html_encode(T)]</i>", "output")
					X << output("<font color=[usr.Text_Color]>[usr][X.Controlz(usr)] whispers: <i>[html_encode(T)]</i>", "icchat")
					Log(X.ChatLog(),"<font color=green>[usr]([usr.key]) WHISPERS: [html_encode(T)]")
					peepz.Add(X)
		for(var/mob/W in hearers(20,usr))
			if(W.BeingObserved.len>0)
				for(var/mob/m in W.BeingObserved)
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][W.Controlz(usr)] whispers: [html_encode(T)]", "icchat")
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][W.Controlz(usr)] whispers: [html_encode(T)]", "output")
			if(W in peepz)continue
			W << output("<font color=[usr.Text_Color]>[usr][W.Controlz(usr)] whispers...", "output")
			W << output("<font color=[usr.Text_Color]>[usr][W.Controlz(usr)] whispers...", "icchat")

		if(usr.AFKTimer==0)
			usr.overlays-=usr.AFKIcon

		usr.AFKTimer=usr.AFKTimeLimit

	verb/Think(T as text)
		set category="Roleplay"
		set src=usr.contents
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.Fused==2)
			var/mob/m = usr.client.eye
			if(m.ckey == usr.Fusee)
				for(var/obj/Communication/c in m)
					if(!(usr in m.BeingObserved)) m.BeingObserved.Add(usr)
					usr=m
					c.Think(T)
					return
		usr << output("<i><font color=[usr.Text_Color]>[usr][usr.Controlz(usr)] thinks: </i>[html_encode(T)]", "output")
		usr << output("<i><font color=[usr.Text_Color]>[usr][usr.Controlz(usr)] thinks: </i>[html_encode(T)]", "icchat")
		Log(usr.ChatLog(),"<font color=green>[usr]([usr.key]) THOUGHT: [html_encode(T)]")
		if(usr.BeingObserved.len>0)
			for(var/mob/m in usr.BeingObserved)
				if(m.HearThoughts&&m.HasTelepathy())
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][usr.Controlz(usr)] thinks: [html_encode(T)]", "icchat")
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>[usr][usr.Controlz(usr)] thinks: [html_encode(T)]", "output")

		for(var/mob/m in hearers(20,usr))
			if(m.HearThoughts&&m.HasTelepathy())
				if(usr.Timestamp)
					m << output("<i><font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=[usr.Text_Color]>[usr][m.Controlz(usr)] thinks</i>: [html_encode(T)]", "output")
					m << output("<i><font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=[usr.Text_Color]>[usr][m.Controlz(usr)] thinks</i>: [html_encode(T)]", "icchat")
					Log(m.ChatLog(),"<font color=green>[usr]([usr.key]) THOUGHT: [html_encode(T)]")
				else
					m << output("<i><font color=[usr.Text_Color]>[usr][m.Controlz(usr)] thinks: </i>[html_encode(T)]", "output")
					m << output("<i><font color=[usr.Text_Color]>[usr][m.Controlz(usr)] thinks: </i>[html_encode(T)]", "icchat")
					Log(m.ChatLog(),"<font color=green>[usr]([usr.key]) THOUGHT: [html_encode(T)]")

		if(usr.AFKTimer==0)
			usr.overlays-=usr.AFKIcon

		usr.AFKTimer=usr.AFKTimeLimit


	verb/Emote()
		set category="Roleplay"
		set src=usr.contents
		if(!(world.time > usr.verb_delay)) return
		usr.verb_delay=world.time+1
		if(usr.CheckSlotless("Camouflage"))
			var/obj/Skills/Buffs/SlotlessBuffs/Camouflage/C = usr.GetSlotless("Camouflage")
				C.Trigger(usr)
			usr << "Your camouflage is broken!"
		if(usr.CheckSlotless("Invisibility"))
			var/obj/Skills/Buffs/SlotlessBuffs/Magic/Magic_Show/I = usr.GetSlotless("Magic Show")
			if(I.Invisible)
				I.Trigger(usr)
			usr << "You reveal yourself!"

		if(usr.AFKTimer==0)
			usr.overlays-=usr.AFKIcon

		usr.AFKTimer=usr.AFKTimeLimit

		var/image/em=new('Emoting.dmi')
		em.appearance_flags=66
		em.layer=EFFECTS_LAYER
		em.pixel_x=0
		em.pixel_y=0
		usr.overlays+=em
		var/T=input("Emotes here!")as message|null
		if(T==null)
			usr.overlays-=em
			return
		var/regex/test = new(@{""[^"]*""}, "g")
		if(findtext(T, test))
			T = test.Replace(T, "<font color=\"[usr.Text_Color]\">$0</font>")
		var/list/hearers
		if(usr.in_vessel) hearers = usr.in_vessel.occupant_refs
		else hearers = hearers(20,usr)

		for(var/mob/E in hearers)
			E << output("<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]>[E.Controlz(usr)] [html_decode(T)]</font>*", "output")
			E << output("<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]>[E.Controlz(usr)] [html_decode(T)]</font>*", "icchat")
			if(E.BeingObserved.len>0)
				for(var/mob/m in E.BeingObserved)
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>*<font color=[usr.Emote_Color]>[usr][E.Controlz(usr)]  [html_decode(T)]</font>*", "icchat")
					m<<output("<b>(OBSERVE)</b><font color=[usr.Text_Color]>*<font color=[usr.Emote_Color]>[usr][E.Controlz(usr)]  [html_decode(T)]</font>*", "output")
			if(E==usr)
				spawn()Log(E.ChatLog(),"<font color=#CC3300>*[usr]([usr.key]) [html_decode(T)]*")
//				spawn()TempLog(E.ChatLog(),"<font color=#CC3300>*[usr]([usr.key]) [html_decode(T)]*")
			else
				Log(E.ChatLog(),"<font color=red>*[usr]([usr.key]) [html_decode(T)]*")
			for(var/obj/Items/Enchantment/Arcane_Mask/EyeCheck in E)
				if(EyeCheck.suffix)
					for(var/mob/Players/OrbCheck in players)
						for(var/obj/Items/Enchantment/ArcanicOrb/FinalCheck in OrbCheck)
							if(EyeCheck.LinkTag in FinalCheck.LinkedMasks)
								if(FinalCheck.Active)
									OrbCheck << output("[FinalCheck](viewing [E])<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]> [html_decode(T)]</font>*", "output")
									OrbCheck << output("[FinalCheck](viewing [E]):<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]> [html_decode(T)]</font>*", "icchat") //Outputs to the Orb owner the emote.

		for(var/obj/Items/Tech/Security_Camera/F in view(11,usr))
			if(F.Active==1)
				for(var/mob/CC in players)
					if(CC.InMagitekRestrictedRegion()) continue
					for(var/obj/Items/Tech/Scouter/CCS in CC)
						if(F.Frequency==CCS.Frequency)
							if(CC.Timestamp)
								CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]>[CC.Controlz(usr)] [html_decode(T)]*</font>*", "output")
								CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]>[CC.Controlz(usr)] [html_decode(T)]*", "icchat")
							else
								CC << output("<font color=green>[F.name] transmits:<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]>[CC.Controlz(usr)] [html_decode(T)]*", "output")
								CC << output("<font color=green>[F.name] transmits:<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]>[CC.Controlz(usr)] [html_decode(T)]*", "icchat")

				if(F.activeListeners)
					for(var/obj/Items/Tech/Security_Display/G in world)
						if(G.Password==F.Password)
							if(G.Active==1)
								for(var/mob/H in hearers(G.AudioRange,G))
									H << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:*<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]> [html_decode(T)]*", "output")
									H << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:*<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]> [html_decode(T)]*", "icchat")
									Log(H.ChatLog(),"<font color=red>[F.name] transmits:*[usr]([usr.key]) [html_decode(T)]*")

		for(var/obj/Items/Tech/Recon_Drone/FF in view(11,usr))
			if(FF.who)
				FF.who << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[FF.name] transmits:*<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]> [html_decode(T)]*", "output")
				FF.who << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[FF.name] transmits:*<font color=[usr.Text_Color]>*[usr.name]<font color=[usr.Emote_Color]> [html_decode(T)]*", "icchat")

		usr.Say_Spark()
		if(usr.AFKTimer==0)
			usr.overlays-=usr.AFKIcon

		usr.AFKTimer=usr.AFKTimeLimit
		usr.overlays-=em


mob/proc/OMessage(var/View=10,var/Msg,var/Log)
	for(var/mob/Players/E in hearers(View,src))
		if(Msg)
//			E<<"[Msg]"
			E << output("[Msg]", "loocchat")
			E << output("[Msg]", "oocchat")
			E << output("[Msg]", "output")
			E << output("[Msg]", "icchat")
		if(Log)
			Log(E.ChatLog(),Log)
mob/var/tmp/Spam=0

proc/SpamCheck(var/mob/M,var/T)
	if(M.CheckPunishment("Mute"))
		return 1
	if(!M.Admin)
		M.Spam++
		spawn(20)if(M.Spam>0)M.Spam--
		if(findtext(T,"\n\n\n")||M.Spam>9)
			world<<"[M]([M.key]) was just muted for spamming!(Auto)"
			var/Duration=Value(world.realtime+(5000))
			var/Reason="You fucked up, nigga."
			Punishment("Action=Add&Punishment=Mute&Key=[M.key]&IP=[M.client.address]&ComputerID=[M.client.computer_id]&Duration=[Duration]&User=[M.key]&Reason=[Reason]&Time=[TimeStamp()]")
			Punishment("Action=Add&Punishment=Ban&Key=[M.key]&IP=[M.client.address]&ComputerID=[M.client.computer_id]&Duration=[world.realtime+((10*60*60*24)*7)]&User=Auto&Reason=Spamming&Time=[TimeStamp()]")
		return 0

proc/OOC_Check(T)
	if(!Allow_OOC&&!(CodedAdmins.Find(usr.key)))
		usr<<"OOC is disabled."

		return 0
	return 1