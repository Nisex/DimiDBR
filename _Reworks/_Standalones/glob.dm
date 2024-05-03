// jesus christ lets get a grip

#define WSNAMES list("Masamune", "Durendal", "Kusanagi", "Caledfwlch", "Muramasa", "Soul Calibur", "Soul Edge", "Dainsleif")
#define BRONZECLOTHS list("Pegasus","Dragon","Cygnus","Andromeda","Phoenix","Unicorn")
#define GOLDCLOTHS list("Aries",/* "Taurus" */,"Gemini","Cancer","Leo","Virgo","Libra","Scorpio",/*"Sagittarius"*/,"Capricorn","Aquarius","Pisces")

var/globalTracker/glob = new()

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

/proc/transferGlobalstoGlob()
	if(!glob)
		world<<"[glob] doesn't exist!"
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
	BootWorld("Save")


/mob/Admin4/verb/convertGlobalInfo()
	transferGlobalstoGlob()



progressTracker

	proc/incrementTotal()
		totalRPPToDate += RPPDaily
		totalPotentialToDate += PotentialDaily
		if(totalPotentialToDate > 100)
			totalPotentialToDate = 100
		if(totalRPPToDate > RPPLimit)
			totalRPPToDate = RPPLimit

	var
//TODO add a proc that increases total rpp/pot daily, ensuring nothing goes over the rpp limit

		Era = 1

//economy
		EconomyIncome = 1000
		EconomyCost = 1000
		EconomyMana = 100
		EconomyMult = 1
		maxAscension = 5
		MoneyName = "Dollars"

//potential
		PotentialDaily = 1
		totalPotentialToDate = 31


// rpp
		totalRPPToDate = 1680 // a dynamic variable, that just gets added to every day tick
		RPPDaily = 30
		RPPLimit = 1680
		RPPStarting = 800
		RPPStartingDays = 3
		RPPBaseMult = 1



// time
		WipeStart = 0
		DaysOfWipe = 32


/****************************************************
  *  *  *  *  *  * * GLOBAL TRACKER  *  *  *  *  *  *
 *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
*****************************************************/


globalTracker
	New()
		if(!progress)
			progress = new()

	var

		progressTracker/progress = new()
// TESTER
		TESTER_MODE
		TESTER_WHITE_LIST = list("Digi-Daisuke","RevealingFortune","Zamas2","Niezan", "Etro", "AMajin", "Redsarge", "Gogeto25",\
 "Tilthour", "Sakata Gintoki San", "Hellbante", "FoxMagnus")



//Wipe Specific
		list/GUILD_RANKINGS = list("Aegis" = 1, "Crimson Dawn" = 2, "Golden Circle" = 3, "Black Ifrit" = 5, "Revenants" = 6)
		list/VOID_LOCATION = list(158,253,3)
		VoidsAllowed = 1
		VoidChance = 78

		list/DEATH_LOCATION = list(250, 250, 2)
		list/REGEN_LOCATION = list()
		list/NO_SOUL_LOCATION = list(182, 288, 2)
		HALF_DEMON_POTENTIAL_REQ = 50

		VOID_MESSAGE = ""
		VOID_TIME = 15 MINUTES
		SHOW_VOID_ROLL = 1

// - races
		list/LockedRaces = list()
		list/CustomCommons = list("Majin","Half-Saiyan", "Android")



// globals
		WorldBaseAmount = 1
		WorldDamageMult = 1
		WorldDefaultAcc = 50
		WorldWhiffRate = 25
		celestialObjectTicks
		NoSagaRaces = list(DEMON, DRAGON, ELF, SAIYAN)
// combat

		MAX_HARDEN = 20
		DEMONIC_DURA_BASE = 0.04
		MAX_HARDENING = 5

		BUFF_MASTER_HIGHTHRESHOLD = 1.2
		BUFF_MASTERY_LOWTHRESHOLD = 0.95
		BUFF_MASTERY_LOWMULT = 0.1
		BUFF_MASTERY_HIGHMULT = 0.05

		TECHNIQUE_MASTERY_DIVISOR = 10
		TECHNIQUE_MASTERY_LIMIT = 2.5 // 1+(techmastery/10) is formula. 2.5 = 15 techmastery before no more does nothing at effectiveness = 1

		SKILL_BRANCH_LOCK = 1

		Q_DIVISOR = 10


		LIGHT_ATTACK_SPEED_DMG_ENABLED = 0
		LIGHT_ATTACK_SPEED_DMG_EXPONENT = 0.2
		LIGHT_ATTACK_SPEED_DMG_LOWER = 0.8
		LIGHT_ATTACK_SPEED_DMG_UPPER = 2

		ZANZO_SPEED_EXPONENT = 0.25
		ZANZO_SPEED_HIGHEST_CLAMP = 2
		ZANZO_SPEED_LOWEST_CLAMP = 0.25

		ZANZO_FLICKER_DIVISOR = 10
		ZANZO_FLICKER_LOWEST_CLAMP = 1
		ZANZO_FLICKER_HIGHEST_CLAMP = 2

		DEBUFF_INTENSITY = 1.2
		BURN_INTENSITY = 1
		SLOW_INTENSITY = 1
		SHATTER_INTENSITY = 1
		SHOCK_INTENSITY = 1
		POISON_INTENSITY = 1
//EXTRAS?? //
		MULTIHIT_NERF = FALSE
		GetUpVar = 1 // how fast u get up ?
		MAGIC_BASE_COST = 50
		MAGIC_INTELL_MATTERS = TRUE
		WorldPUDrain = 1
		DMG_CALC_2 = TRUE
// global mults
		GLOBAL_BEAM_DAMAGE_DIVISOR = 30
		GLOBAL_QUEUE_DAMAGE = 0.85
		GLOBAL_MELEE_MULT = 0.9
		GLOBAL_POWER_MULT = 1
		GLOBAL_ITEM_DAMAGE_MULT = 0.75
		EXPONENTIAL_PROJ_DAMAGE = FALSE
		PROJ_DAMAGE_MULT = 1
		AUTOHIT_GLOBAL_DAMAGE = 0.8
		INTIMRATIO = 500

		GLOBAL_EXPONENT_MULT = 1/3
		GRAPPLE_MELEE_BOON = 1.5
		CLAMP_POWER = TRUE
		MIN_POWER_DIFF = 0.6
		MAX_POWER_DIFF = 2
		AUTOHIT_GRAB_NERF = 0.5
		PARTY_DAMAGE_NERF = 0.5
		MOD_AFTER_ACC = TRUE


		CONSTANT_DAMAGE_EXPONENT = 4

// effectiveness (dmg calc  shit)
		MELEE_EFFECTIVENESS = 1
		PROJECTILE_EFFECTIVNESS = 1
		GRAPPLE_EFFECTIVNESS = 3
		AUTOHIT_EFFECTIVNESS = 2

		DMG_END_EXPONENT = 0.5
		DMG_STR_EXPONENT = 0.5
		DMG_POWER_EXPONENT = 0.75

		NEWINTIMCALC = TRUE


// dmg rolls
		min_damage_roll = 0.3
		upper_damage_roll = 0.9




// CC related
		CCDamageModifier = 0.33


// -- items -- //


// - swords
		SwordAscDamage
		SwordAscAcc
		SwordAscDelay
// - staffs
		StaffAscDamage
		StaffAscAcc
		StaffAscDelay
// - armor
		ArmorAscDamage
		ArmorAscDelay
		ArmorAscAcc
// not sure why he made them all variable, but its more flexibility= FALSE


		infWeaponSoul = TRUE
		WeaponSoulNames = WSNAMES
		list/WeaponSoul = list("Muramasa" = FALSE, "Soul Calibur" = FALSE,"Soul Edge" = FALSE,\
 "Dainsleif" = FALSE)
 // false = open, true = taken

		MAKYO_TOTAL_TIME = 18000//30 minutes

		list/var/Heroes = list("Finn")

		infConstellations = TRUE
		BronzeConstellationNames = BRONZECLOTHS
		GoldConstellationNames = GOLDCLOTHS
		list/BronzeConstellation = list("Pegasus" = FALSE, "Dragon" = FALSE, "Cygnus" = FALSE, "Andromeda" = FALSE, "Phoenix" = FALSE, "Unicorn" = FALSE)
		list/GoldConstellation = list("Aries" = FALSE,"Gemini" = FALSE,"Cancer" = FALSE,"Leo" = FALSE,"Virgo" = FALSE,"Libra" = FALSE,\
"Scorpio" = FALSE,"Capricorn" = FALSE,"Aquarius" = FALSE,"Pisces" = FALSE)

// FUNCTIONS

globalTracker/proc/takeLimited(option, n)
	if(vars[option][n] == TRUE)
		usr << "This is already taken, please report this error"
		return
	vars[option][n] = TRUE



globalTracker/proc/ResetSwords()
	WeaponSoul = list("Muramasa" = FALSE, "Soul Calibur" = FALSE,"Soul Edge" = FALSE,\
	"Dainsleif" = FALSE)
	Log("Admin", "All legendary swords have been selected, so the list was reset.")


globalTracker/proc/getOpen(option)
	var/list/returnList = vars["[option]Names"]
	for(var/item in vars[option])
		if(vars[option][item] == TRUE)
			returnList.Remove(item)
	return returnList
