// jesus christ lets get a grip

#define WSNAMES list("Masamune", "Durendal", "Kusanagi", "Caledfwlch", "Muramasa", "Soul Calibur", "Soul Edge", "Dainsleif")
#define BRONZECLOTHS list("Pegasus","Dragon","Cygnus","Andromeda","Phoenix")
#define GOLDCLOTHS list("Aries",/* "Taurus" */,"Gemini","Cancer","Leo","Virgo","Libra","Scorpio",/*"Sagittarius"*/,"Capricorn","Aquarius","Pisces")

/var/datum/globalTracker/glob = new()

/mob/Admin2/verb/editGlobalVariables()
    set name = "Edit Global Variables"
    set category = "Admin"
    var/atom/A = glob
    var/Edit="<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
    var/list/B=new
    Edit+="[A]<br>[A.type]"
    Edit+="<table width=10%>"
    for(var/C in A.vars)
        B+=C
        CHECK_TICK
    for(var/C in B)
        Edit+="<td><a href=byond://?src=\ref[A];action=edit;var=[C]>"
        Edit+=C
        if(istype(A.vars[C], /datum) && !istype(A.vars[C], /obj))
            if(A.vars[C].type in typesof(/datum))
                Edit+="<td><a href=byond://?src=\ref[A.vars[C]];action=edit;var=[C]>[C]</td></tr>"
        else
            Edit+="<td>[Value(A.vars[C])]</td></tr>"
        CHECK_TICK
    usr<<browse(Edit,"window=[A];size=450x600")

/mob/Admin2/verb/editGlobalVariables2()
    set name = "Edit Global Variables 2"
    set category = "Admin"
    var/atom/A = glob
    Edit(A)


/proc/transferGlobalstoGlob()
    if(!glob)
        glob = new()
    glob.progress.WipeStart = global.WipeStart
    glob.progress.DaysOfWipe = global.DaysOfWipe
    for(var/varName in glob.vars)
        if(varName == "progress")
            // recursion moment
            if(!glob.progress)
                for(var/progressVars in glob.progress)
                    try
                        glob.progress.vars[progressVars] = global.vars[progressVars]
                    catch
                        world<<"[progressVars] doesn't exist globally!"
        else
            try
                glob.vars[varName] = global.vars[varName]
            catch
                switch(varName)
                    if("DEATH_LOCATION")
                        glob.DEATH_LOCATION = list(DeadX, DeadY, DeadZ)
                    // if("DMG_END_EXPONENT")
                    //     glob.DMG_END_EXPONENT = global.DMG2_END_EFFECTIVENESS
                    // if("DMG_STR_EXPONENT")
                    //     glob.DMG_STR_EXPONENT = global.DMG2_STR_EFFECTIVENESS
                    // if("DMG_POWER_EXPONENT")
                    //     glob.DMG_POWER_EXPONENT = global.DMG2_POWER_EFFECTIVENESS
    world<<"[glob.progress.WipeStart] [glob.progress.DaysOfWipe]"


/mob/Admin4/verb/convertGlobalInfo()
    transferGlobalstoGlob()



/datum/progressTracker

/datum/progressTracker/proc/incrementTotal()
    totalRPPToDate += RPPDaily
    totalPotentialToDate += PotentialDaily
    if(totalPotentialToDate > 100)
        totalPotentialToDate = 100
    if(totalRPPToDate > RPPLimit)
        totalRPPToDate = RPPLimit


//TODO add a proc that increases total rpp/pot daily, ensuring nothing goes over the rpp limit

/datum/progressTracker/var/Era = 1

//economy
/datum/progressTracker/var/EconomyIncome = 1000
/datum/progressTracker/var/EconomyCost = 1000
/datum/progressTracker/var/EconomyMana = 100
/datum/progressTracker/var/EconomyMult = 1
/datum/progressTracker/var/maxAscension = 5
/datum/progressTracker/var/MoneyName = "Dollars"

//potential
/datum/progressTracker/var/PotentialDaily = 1
/datum/progressTracker/var/totalPotentialToDate = 31


// rpp
/datum/progressTracker/var/totalRPPToDate = 1680 // a dynamic variable, that just gets added to every day tick
/datum/progressTracker/var/RPPDaily = 30
/datum/progressTracker/var/RPPLimit = 1680
/datum/progressTracker/var/RPPStarting = 800
/datum/progressTracker/var/RPPStartingDays = 3
/datum/progressTracker/var/RPPBaseMult = 1



// time
/datum/progressTracker/var/WipeStart = 0
/datum/progressTracker/var/DaysOfWipe = 32


/****************************************************
  *  *  *  *  *  * * GLOBAL TRACKER  *  *  *  *  *  *
 *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
*****************************************************/


/datum/globalTracker
/datum/globalTracker/New()
    if(!progress)
        progress = new()


/datum/globalTracker/var/datum/progressTracker/progress = new()
// TESTER
/datum/globalTracker/var/TESTER_MODE
/datum/globalTracker/var/TESTER_WHITE_LIST = list("Digi-Daisuke","RevealingFortune","Zamas2","Niezan", "Etro", "AMajin", "Redsarge", "Gogeto25",\
 "Tilthour", "Sakata Gintoki San", "Hellbante", "FoxMagnus")



//Wipe Specific
/datum/globalTracker/var/list/GUILD_RANKINGS = list("Aegis" = 1, "Crimson Dawn" = 2, "Golden Circle" = 3, "Black Ifrit" = 5, "Revenants" = 6)
/datum/globalTracker/var/list/VOID_LOCATION = list(158,253,3)
/datum/globalTracker/var/VoidsAllowed = 1
/datum/globalTracker/var/VoidChance = 78

/datum/globalTracker/var/list/DEATH_LOCATION = list(250, 250, 2)
/datum/globalTracker/var/list/REGEN_LOCATION = list()
/datum/globalTracker/var/list/NO_SOUL_LOCATION = list(182, 288, 2)
/datum/globalTracker/var/HALF_DEMON_POTENTIAL_REQ = 50

/datum/globalTracker/var/VOID_MESSAGE = ""
/datum/globalTracker/var/VOID_TIME = 15 MINUTES
/datum/globalTracker/var/SHOW_VOID_ROLL = 1 

// - races
/datum/globalTracker/var/list/LockedRaces = list()
/datum/globalTracker/var/list/CustomCommons = list("Majin","Half-Saiyan", "Android")



// globals
/datum/globalTracker/var/WorldBaseAmount = 1
/datum/globalTracker/var/WorldDamageMult = 1
/datum/globalTracker/var/WorldDefaultAcc = 50
/datum/globalTracker/var/WorldWhiffRate = 25
/datum/globalTracker/var/celestialObjectTicks
/datum/globalTracker/var/NoSagaRaces = list(/*"Saiyan", "Majin",*/ "Changeling", "Shinjin", "Demon", "Dragon")
// combat

/datum/globalTracker/var/MAX_HARDEN = 20
/datum/globalTracker/var/DEMONIC_DURA_BASE = 0.04
/datum/globalTracker/var/MAX_HARDENING = 5

/datum/globalTracker/var/BUFF_MASTER_HIGHTHRESHOLD = 1.2
/datum/globalTracker/var/BUFF_MASTERY_LOWTHRESHOLD = 0.95
/datum/globalTracker/var/BUFF_MASTERY_LOWMULT = 0.1
/datum/globalTracker/var/BUFF_MASTERY_HIGHMULT = 0.05

/datum/globalTracker/var/TECHNIQUE_MASTERY_DIVISOR = 10
/datum/globalTracker/var/TECHNIQUE_MASTERY_LIMIT = 2.5 // 1+(techmastery/10) is formula. 2.5 = 15 techmastery before no more does nothing at effectiveness = 1

/datum/globalTracker/var/SKILL_BRANCH_LOCK = 1

/datum/globalTracker/var/Q_DIVISOR = 10


/datum/globalTracker/var/LIGHT_ATTACK_SPEED_DMG_ENABLED = 0
/datum/globalTracker/var/LIGHT_ATTACK_SPEED_DMG_EXPONENT = 0.2
/datum/globalTracker/var/LIGHT_ATTACK_SPEED_DMG_LOWER = 0.8
/datum/globalTracker/var/LIGHT_ATTACK_SPEED_DMG_UPPER = 2
//EXTRAS?? //
/datum/globalTracker/var/MULTIHIT_NERF = FALSE
/datum/globalTracker/var/GetUpVar = 1 // how fast u get up ?
/datum/globalTracker/var/MAGIC_BASE_COST = 50
/datum/globalTracker/var/MAGIC_INTELL_MATTERS = TRUE
/datum/globalTracker/var/WorldPUDrain = 1
/datum/globalTracker/var/DMG_CALC_2 = TRUE
// global mults
/datum/globalTracker/var/GLOBAL_QUEUE_DAMAGE = 0.85
/datum/globalTracker/var/GLOBAL_MELEE_MULT = 0.9
/datum/globalTracker/var/GLOBAL_POWER_MULT = 1
/datum/globalTracker/var/GLOBAL_ITEM_DAMAGE_MULT = 0.75
/datum/globalTracker/var/EXPONENTIAL_PROJ_DAMAGE = FALSE
/datum/globalTracker/var/PROJ_DAMAGE_MULT = 1
/datum/globalTracker/var/AUTOHIT_GLOBAL_DAMAGE = 0.8
/datum/globalTracker/var/INTIMRATIO = 500

/datum/globalTracker/var/GLOBAL_EXPONENT_MULT = 1/3
/datum/globalTracker/var/GRAPPLE_MELEE_BOON = 1.5
/datum/globalTracker/var/CLAMP_POWER = TRUE
/datum/globalTracker/var/MIN_POWER_DIFF = 0.6
/datum/globalTracker/var/MAX_POWER_DIFF = 2
/datum/globalTracker/var/AUTOHIT_GRAB_NERF = 0.5
/datum/globalTracker/var/PARTY_DAMAGE_NERF = 0.5
/datum/globalTracker/var/MOD_AFTER_ACC = TRUE


/datum/globalTracker/var/CONSTANT_DAMAGE_EXPONENT = 4

// effectiveness (dmg calc  shit)
/datum/globalTracker/var/STRENGTH_EFFECTIVENESS = 0.6
/datum/globalTracker/var/FORCE_EFFECTIVENESS = 1
/datum/globalTracker/var/END_EFFECTIVENESS = 0.8
/datum/globalTracker/var/MELEE_EFFECTIVENESS = 1
/datum/globalTracker/var/PROJECTILE_EFFECTIVNESS = -1
/datum/globalTracker/var/GRAPPLE_EFFECTIVNESS = 3
/datum/globalTracker/var/AUTOHIT_EFFECTIVNESS = 2

/datum/globalTracker/var/DMG_END_EXPONENT = 0.5
/datum/globalTracker/var/DMG_STR_EXPONENT = 0.5
/datum/globalTracker/var/DMG_POWER_EXPONENT = 0.75

/datum/globalTracker/var/NEWINTIMCALC = TRUE


// dmg rolls
/datum/globalTracker/var/min_damage_roll = 0.3
/datum/globalTracker/var/upper_damage_roll = 0.9




// CC related
/datum/globalTracker/var/CCDamageModifier = 0.33


// -- items -- //


// - swords
/datum/globalTracker/var/SwordAscDamage
/datum/globalTracker/var/SwordAscAcc
/datum/globalTracker/var/SwordAscDelay
// - staffs
/datum/globalTracker/var/StaffAscDamage
/datum/globalTracker/var/StaffAscAcc
/datum/globalTracker/var/StaffAscDelay
// - armor
/datum/globalTracker/var/ArmorAscDamage
/datum/globalTracker/var/ArmorAscDelay
/datum/globalTracker/var/ArmorAscAcc
// not sure why he made them all variable, but its more flexibility= FALSE


/datum/globalTracker/var/infWeaponSoul = TRUE
/datum/globalTracker/var/WeaponSoulNames = WSNAMES
/datum/globalTracker/var/list/WeaponSoul = list("Muramasa" = FALSE, "Soul Calibur" = FALSE,"Soul Edge" = FALSE,\
 "Dainsleif" = FALSE)
 // false = open, true = taken


/datum/globalTracker/var/list/var/Heroes = list("Finn")

/datum/globalTracker/var/infConstellations = TRUE
/datum/globalTracker/var/BronzeConstellationNames = BRONZECLOTHS
/datum/globalTracker/var/GoldConstellationNames = GOLDCLOTHS
/datum/globalTracker/var/list/BronzeConstellation = list("Pegasus" = FALSE,"Dragon" = FALSE,"Cygnus" = FALSE,"Andromeda" = FALSE,"Phoenix" = FALSE)
/datum/globalTracker/var/list/GoldConstellation = list("Aries" = FALSE,"Gemini" = FALSE,"Cancer" = FALSE,"Leo" = FALSE,"Virgo" = FALSE,"Libra" = FALSE,\
"Scorpio" = FALSE,"Capricorn" = FALSE,"Aquarius" = FALSE,"Pisces" = FALSE)



// FUNCTIONS

/datum/globalTracker/proc/takeLimited(option, n)
    if(vars[option][n] == TRUE)
        usr << "This is already taken, please report this error"
        return
    vars[option][n] = TRUE



/datum/globalTracker/proc/ResetSwords()
    WeaponSoul = list("Muramasa" = FALSE, "Soul Calibur" = FALSE,"Soul Edge" = FALSE,\
    "Dainsleif" = FALSE)
    Log("Admin", "All legendary swords have been selected, so the list was reset.")


/datum/globalTracker/proc/getOpen(option)
    var/list/returnList = vars["[option]Names"]
    for(var/item in vars[option])
        if(vars[option][item] == TRUE)
            returnList.Remove(item)
    return returnList
