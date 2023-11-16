/obj/Items/Sword
    var/unsheathed = FALSE
    var/icon/unsheatheIcon
    var/unsheatheOffsetX = 0
    var/unsheatheOffsetY = 0
    var/unsheatheState = ""
    var/removeSheathedOnUnSheathe = FALSE
    // var/unsheatheSound = sound("unsheathe.ogg")
    proc/addUnsheathedState()
        if(suffix && unsheatheIcon)
            var/image/im = image(icon=unsheatheIcon, pixel_x=unsheatheOffsetX, pixel_y=unsheatheOffsetY)
            im.layer = src.layer+1
            if(usr.ArmamentGlow)
                im.filters+=usr.ArmamentGlow
            usr.overlays += im
            if(removeSheathedOnUnSheathe)
                AlignEquip(usr, TRUE)
    proc/removeUnsheathedState()
        if(suffix && unsheatheIcon)
            var/image/im = image(icon=unsheatheIcon, pixel_x=unsheatheOffsetX, pixel_y=unsheatheOffsetY)
            im.layer = src.layer+1
            if(usr.ArmamentGlow)
                im.filters+=usr.ArmamentGlow
            usr.overlays -= im
            if(removeSheathedOnUnSheathe)
                suffix = null
                if(usr.equippedSword == src)
                    usr.equippedSword = null
                AlignEquip(usr)
    verb/Unsheathe()
        if(!unsheatheIcon)
            usr<<"You need to set up an unsheathe icon for this sword."
            return
        if(unsheathed)
            usr<<"You already have your sword unsheathed."
            return
        unsheathed = TRUE
        addUnsheathedState()


    verb/Sheathe()
        if(!unsheatheIcon)
            usr<<"You need to set up an unsheathe icon for this sword."
            return
        if(!unsheathed)
            usr<<"You already have your sword sheathed."
            return
        unsheathed = FALSE
        removeUnsheathedState()


    verb/SetUnsheatheIcon()
        var/icon/newIcon = input(usr, "Set unsheathe icon", "Set unsheathe icon for this sword.") as icon
        if(newIcon)
            unsheatheIcon = newIcon
            usr<<"Unsheathe icon set."
        else
            usr<<"Unsheathe icon not set."
            return
        unsheatheOffsetX = input(usr, "Set unsheathe icon offset X", "Set unsheathe icon offset X for this sword.") as num
        unsheatheOffsetY = input(usr, "Set unsheathe icon offset Y", "Set unsheathe icon offset Y for this sword.") as num
        unsheatheState = input(usr, "Set unsheathe icon state", "Yes") as text
        if(!unsheatheState)
            unsheatheState = ""
        removeSheathedOnUnSheathe = input(usr, "Remove sheathed state on unsheathe?", "Yes") in list(TRUE, FALSE)
        usr<<"Unsheathe icon offset X and Y set."