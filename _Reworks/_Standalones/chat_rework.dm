var/list/chat_options = list("Font Size", "Font Family")
var/list/chat_tabs = list("AllChatTab", "ICChatTab", "LOOCChatTab", "OOCChatTab")
var/list/valid_chat_fonts = list("Gotham Book", "Arial", "Verdana")

mob
	verb
		chatSettings()
			usr.chatOptions()

mob
	proc
		chatOptions()
			var/choice = input(src,,"Chat Options") as null|anything in chat_options
			if(!choice) return
			switch(choice)
				if("Font Size")
					fontSize()
				if("Font Family")
					fontFamily()

		fontSize()
			var/current_font_size = winget(src, "AllChatTab.output", "font-size")
			var/choice = input(src,"What would you like to change the font size to?\nThe font size is currently: [current_font_size]pt.","Chat Font Size",current_font_size) as null|num
			if(!choice) return
			winset(src,"AllChatTab.output","font-size=[choice]")
			winset(src,"ICChatTab.icchat","font-size=[choice]")
			winset(src,"OOCChatTab.oocchat","font-size=[choice]")
			winset(src,"LOOCChatTab.loocchat","font-size=[choice]")

		fontFamily()
			var/current_font_family = winget(src, "AllChatTab.output", "font-family")
			var/choice = input(src,"What would you like to change the font to?\nThe current font is: [current_font_family].","Chat Font",current_font_family) as null|anything in valid_chat_fonts
			if(!choice) return
			winset(src,"AllChatTab.output","font-family=[choice]")
			winset(src,"ICChatTab.icchat","font-family=[choice]")
			winset(src,"OOCChatTab.oocchat","font-family=[choice]")
			winset(src,"LOOCChatTab.loocchat","font-family=[choice]")