#define CONFIG_OPTIONS_JSON_FOLDER "Saves/options_json/"


client/var/datum/Options/prefs = new()

/datum/Options/
    var/seePronouns = 1
    var/useSupporter = 0
    var/useDonator = 1
    var/disableLoginAlert = 0
    var/list/savableVars = list("seePronouns", "useSupporter", "useDonator", "disableLoginAlert")
    proc/savePrefs(ckey)
        . = list()
        for(var/opt in savableVars)
            .["[opt]"] += vars[opt]
        if(deleteOldPrefs(ckey))
            var/write = file("[CONFIG_OPTIONS_JSON_FOLDER][ckey].json")
            write << json_encode(.)
    proc/loadPrefs(ckey)
        var/thing2Return
        if(fexists("[CONFIG_OPTIONS_JSON_FOLDER][ckey].json"))
            var/read = file("[CONFIG_OPTIONS_JSON_FOLDER][ckey].json")
            if(read)
                thing2Return = json_decode(file2text(read))
                for(var/opt in vars)
                    if(!thing2Return["[opt]"])
                        thing2Return["[opt]"] = vars[opt]
            else
                thing2Return = list()
                for(var/opt in savableVars)
                    thing2Return["[opt]"] = vars[opt]
        else
            thing2Return = list()
            for(var/opt in savableVars)
                thing2Return["[opt]"] = vars[opt]
    proc/deleteOldPrefs(ckey)
        . = 1
        if(fexists("[CONFIG_OPTIONS_JSON_FOLDER][ckey].json"))
            if(!fdel("[CONFIG_OPTIONS_JSON_FOLDER][ckey].json"))
                world.log << "Failed to delete old preferences for [ckey]."
                return 0

        




/client/proc/togglePref(pref)
    if (pref == "seePronouns")
        prefs.seePronouns = !prefs.seePronouns
    else
        setPref(pref, !getPref(pref))

/client/proc/setPref(pref, value)
    prefs.vars["[pref]"] = value
    prefs.savePrefs(mob.ckey)

/client/proc/getPref(pref)
    return prefs.vars["[pref]"]

