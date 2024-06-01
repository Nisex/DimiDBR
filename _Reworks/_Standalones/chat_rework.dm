var/list/chat_options = list("Font Size", "Font Family")
var/list/chat_tabs = list("AllChatTab", "ICChatTab", "LOOCChatTab", "OOCChatTab")
var/list/valid_chat_fonts = list("Gotham Book", "Arial", "Verdana")

#define CURRENTFONTFAMILY "currentFontFamily"
#define CURRENTFONTSIZE "currentFontSize"
client
	New()
		if(getPref(CURRENTFONTFAMILY) == null)
			setPref(CURRENTFONTFAMILY, "Gotham Book")
		if(getPref(CURRENTFONTSIZE) == null)
			setPref(CURRENTFONTSIZE, 8)
		setFontSize(getPref(CURRENTFONTSIZE))
		setFontFamily(getPref(CURRENTFONTFAMILY))
		..()

	proc
		setFontSize(size)
			winset(src,"AllChatTab.output","font-size=[size]")
			winset(src,"ICChatTab.icchat","font-size=[size]")
			winset(src,"OOCChatTab.oocchat","font-size=[size]")
			winset(src,"LOOCChatTab.loocchat","font-size=[size]")

		setFontFamily(family)
			winset(src,"AllChatTab.output","font-family=[family]")
			winset(src,"ICChatTab.icchat","font-family=[family]")
			winset(src,"OOCChatTab.oocchat","font-family=[family]")
			winset(src,"LOOCChatTab.loocchat","font-family=[family]")

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
			var/current_font_size = client.getPref(CURRENTFONTSIZE)
			var/choice = input(src,"What would you like to change the font size to?\nThe font size is currently: [current_font_size]pt.","Chat Font Size",current_font_size) as null|num
			if(!choice) return
			choice = clamp(1, choice, 100)
			client.setFontSize(choice)
			client.setPref(CURRENTFONTFAMILY, choice)

		fontFamily()
			var/current_font_family = client.getPref(CURRENTFONTFAMILY)
			var/choice = input(src,"What would you like to change the font to?\nThe current font is: [current_font_family].","Chat Font",current_font_family) as null|anything in valid_chat_fonts
			if(!choice) return
			client.setFontFamily(choice)
			client.setPref(CURRENTFONTSIZE, choice)