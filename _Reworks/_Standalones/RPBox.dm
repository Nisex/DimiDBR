mob/proc
	RPLoop()
		while(rping)
			sleep(150)
			savedRoleplay = "[winget(src, "RPWindow.rpbox","text")]"
			savedRoleplay = replacetext(savedRoleplay, "\'", "\\\\'")
			savedRoleplay = replacetext(savedRoleplay, "\"", "\\\"")

mob/verb/
	SubmitRP()
		set hidden = 1
		set instant = 1

		usr.overlays -= usr.emoteBubble
		winset(usr, "RPWindow", "is-visible=false")
		var/msg = winget(usr, "RPWindow.rpbox", "text")

		winset(usr, "RPWindow.rpbox", "text=")

		rping = FALSE

		if(length(msg) == 0) return

		SubmitRoleplay(msg)

	CloseRP()
		set hidden = 1
		set instant = 1

		usr.overlays -= usr.emoteBubble
		var/msg = "[winget(usr, "RPWindow.rpbox","text")]"

		msg = replacetext(msg, "�\\","'")
		msg = replacetext(msg, "�\\","")
		msg = replacetext(msg, "�\\","'")
		msg = replacetext(msg, "\'", "\\\\'")
		msg = replacetext(msg, "\"", "\\\"")

		savedRoleplay = null
		if(length(msg) >= 45)
			if(fexists("Saved Roleplays/[usr.key].txt"))
				fdel("Saved Roleplays/[usr.key].txt")
				text2file(msg, "Saved Roleplays/[usr.key].txt")
			else
				text2file(msg, "Saved Roleplays/[usr.key].txt")
		winset(usr, "RPWindow","is-visible=false")
		winset(usr, "RPWindow.rpbox","text=")
		rping = 0

mob
	proc
		SubmitRoleplay(msg)
			if(length(msg)==0)
				overlays -= emoteBubble
				return

			var/format = "default"

			if(findtext(msg, "//",1,3) || findtext(msg,"||", 1,3))
				msg = replacetext(msg, "//", "", 1, 3)
				msg = replacetext(msg, "||", "", 1, 3)
				format = "thirdperson"

			var/regex/quotationTextColor = new(@{""[^"]*""}, "g")
			if(findtext(msg, quotationTextColor))
				msg = quotationTextColor.Replace(msg, "<font color=\"[usr.Text_Color]\">$0</font>")

			var/list/hearers
			if(usr.in_vessel) hearers = in_vessel.occupant_refs
			else hearers = ohearers(20,src)

			var/formattedMessage

			if(format=="default")
				formattedMessage = "<font color=[Text_Color]>*[name]<font color=[Emote_Color]> [html_decode(msg)]</font>*"
			else if(format == "thirdperson")
				formattedMessage = "<font color=[Text_Color]>*<font color=[Emote_Color]>[html_decode(msg)]</font>\n\n([name])*"

			src << output(formattedMessage, "output")
			src << output(formattedMessage, "icchat")
			Log(ChatLog(),"<font color=#CC3300>*[src]([key]) [html_decode(msg)]*")
			Log(sanitizedChatLog(),"<font color=#CC3300>*[src] [html_decode(msg)]*")
			for(var/mob/E in hearers)
				E << output("[E.Controlz(src)][formattedMessage]", "output")
				E << output("[E.Controlz(src)][formattedMessage]", "icchat")

				Log(E.ChatLog(),"<font color=red>*[usr]([usr.key]) [html_decode(formattedMessage)]*")
				Log(E.sanitizedChatLog(),"<font color=red>*[usr] [html_decode(formattedMessage)]*")
				if(E.BeingObserved.len>0)
					for(var/mob/m in E.BeingObserved)
						m<<output("<b>(OBSERVE)</b>[m.Controlz(src)][formattedMessage]", "icchat")
						m<<output("<b>(OBSERVE)</b>[m.Controlz(src)][formattedMessage]", "output")

				for(var/obj/Items/Enchantment/Arcane_Mask/EyeCheck in E)
					if(EyeCheck.suffix)
						for(var/mob/Players/OrbCheck in players)
							for(var/obj/Items/Enchantment/ArcanicOrb/FinalCheck in OrbCheck)
								if(EyeCheck.LinkTag in FinalCheck.LinkedMasks)
									if(FinalCheck.Active)
										OrbCheck << output("[FinalCheck](viewing [E])[formattedMessage]", "output")
										OrbCheck << output("[FinalCheck](viewing [E])[formattedMessage]", "icchat") //Outputs to the Orb owner the emote.

			for(var/obj/Items/Tech/Security_Camera/F in view(11,src))
				if(F.Active==1)
					for(var/mob/CC in players)
						if(CC.InMagitekRestrictedRegion()) continue
						for(var/obj/Items/Tech/Scouter/CCS in CC)
							if(F.Frequency==CCS.Frequency)
								if(CC.Timestamp)
									CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:[formattedMessage]</font>*", "output")
									CC << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:[formattedMessage]", "icchat")
								else
									CC << output("<font color=green>[F.name] transmits:[formattedMessage]", "output")
									CC << output("<font color=green>[F.name] transmits:[formattedMessage]", "icchat")

					if(F.activeListeners)
						for(var/obj/Items/Tech/Security_Display/G in world)
							if(G.Password==F.Password)
								if(G.Active==1)
									for(var/mob/H in hearers(G.AudioRange,G))
										H << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:[formattedMessage]", "output")
										H << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[F.name] transmits:[formattedMessage]", "icchat")
										Log(H.ChatLog(),"<font color=red>[F.name] transmits:*[src]([src.key]) [html_decode(formattedMessage)]*")
										Log(sanitizedChatLog(),"<font color=red>[F.name] transmits:*[src] [html_decode(formattedMessage)]*")
			for(var/obj/Items/Tech/Recon_Drone/FF in view(11,usr))
				if(FF.who)
					FF.who << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[FF.name] transmits:[formattedMessage]", "output")
					FF.who << output("<font color=red>[time2text(world.timeofday,"(hh:mm:ss)")]<font color=green>[FF.name] transmits:[formattedMessage]", "icchat")

			Say_Spark()
			if(usr.AFKTimer==0)
				overlays-=usr.AFKIcon

			AFKTimer=usr.AFKTimeLimit
			overlays-=emoteBubble