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

/mob/Admin3/verb/Debuff_Apply(n as num)
	glob.BURN_INTENSITY = n
	glob.SHOCK_INTENSITY = n 
	glob.SLOW_INTENSITY = n 
	glob.SHATTER_INTENSITY = n 
	glob.POISON_INTENSITY= n 

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

//INTIM
		INTIMRATIO = 500
		NEWINTIMCALC = TRUE

//Wipe Specific
		list/GUILD_RANKINGS = list("Aegis" = 1, "Crimson Dawn" = 2, "Golden Circle" = 3, "Black Ifrit" = 5, "Revenants" = 6)
		list/VOID_LOCATION = list(144,140,15)
		VoidsAllowed = 1
		VoidChance = 78


		list/Spawns = list()


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

		DEMON_ERODE_DEBUFF_INTENSITY = 0.005
		DEMON_DOT_DEBUFF_INTENSITY = 6
		DEMON_RESOURCE_DEBUFF_INTENSITY = 0.2
		UNDERDOG_DIVISOR = 4

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
		REGEN_ASC_ONE_HEAL = 3
		HEALTH_POTION_NERF = 4
		BUFF_MASTER_HIGHTHRESHOLD = 1.2
		BUFF_MASTERY_LOWTHRESHOLD = 0.95
		BUFF_MASTERY_LOWMULT = 0.1
		BUFF_MASTERY_HIGHMULT = 0.05

		TECHNIQUE_MASTERY_DIVISOR = 10
		TECHNIQUE_MASTERY_LIMIT = 2.5 // 1+(techmastery/10) is formula. 2.5 = 15 techmastery before no more does nothing at effectiveness = 1

		SKILL_BRANCH_LOCK = 1

		Q_DIVISOR = 10


		LIGHT_ATTACK_SPEED_DMG_ENABLED = 1
		LIGHT_ATTACK_SPEED_DMG_EXPONENT = 0.3
		LIGHT_ATTACK_SPEED_DMG_LOWER = 0.5
		LIGHT_ATTACK_SPEED_DMG_UPPER = 3

		ZANZO_SPEED_EXPONENT = 0.25
		ZANZO_SPEED_HIGHEST_CLAMP = 2
		ZANZO_SPEED_LOWEST_CLAMP = 0.25


		USE_SPEED_IN_ZANZO_RECHARGE = 0


		ZANZO_FLICKER_DIVISOR = 10
		ZANZO_FLICKER_LOWEST_CLAMP = 1
		ZANZO_FLICKER_HIGHEST_CLAMP = 2
		ZANZO_FLICKER_BASE_GAIN = 0.1

		DEBUFF_INTENSITY = 1.2
		BURN_INTENSITY = 1
		SLOW_INTENSITY = 1
		SHATTER_INTENSITY = 1
		SHOCK_INTENSITY = 1
		POISON_INTENSITY = 1
		BASE_DEBUFF_REDUCTION_DIVISOR = 100
		BASE_DEBUFF_REDUCTION_DIVISOR_LOWER = 0.05
		BASE_DEBUFF_REDUCTION_DIVISOR_UPPER = 1
		ZORNHAU_MULT = 0.15
//EXTRAS?? //
		MULTIHIT_NERF = FALSE
		GetUpVar = 1 // how fast u get up ?
		MAGIC_BASE_COST = 50
		TECH_BASE_COST = 30
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

		GLOBAL_EXPONENT_MULT = 1/3
		GRAPPLE_MELEE_BOON = 1.5
		CLAMP_POWER = TRUE
		MIN_POWER_DIFF = 0.7
		MAX_POWER_DIFF = 1.3
		AUTOHIT_GRAB_NERF = 0.5
		PARTY_DAMAGE_NERF = 0.5
		MOD_AFTER_ACC = TRUE

		GLADIATOR_DISARM_MAX = 600
		DISARM_TIMER = 100


		CONSTANT_DAMAGE_EXPONENT = 4

// effectiveness (dmg calc  shit)
		MELEE_EFFECTIVENESS = 1
		PROJECTILE_EFFECTIVNESS = 1
		GRAPPLE_EFFECTIVNESS = 3
		AUTOHIT_EFFECTIVNESS = 2

		DMG_END_EXPONENT = 0.4
		DMG_STR_EXPONENT = 0.4
		DMG_POWER_EXPONENT = 0.3
		PURE_MODIFIER = 0.25
		TENSION_MULTIPLIER = 1
		CORRUPTION_GAIN = 1.25
// dmg rolls
		min_damage_roll = 0.3
		upper_damage_roll = 0.9

//SPEED COOLDOWN SHIT
		SPEED_COOLDOWN_MODE = 0
		SPEED_COOLDOWN_EXPONENT = 0.25
		SPEED_COOLDOWN_MIN = 0.75
		SPEED_COOLDOWN_MAX = 1.5


// CC related
		CCDamageModifier = 0.33

		//Whiff dmg is now rand between these.
		MIN_WHIFF_DMG = 1.25
		MAX_WHIFF_DMG = 1.5

		//Min & max of AccMult in accuracy formula
		ACC_ACCMULT_MIN = 0.25
		ACC_ACCMULT_MAX = 2

		//how large the modifier for accuracy can be (off/def*accmult) clamped between these.
		ACC_MIN = 0.25
		ACC_MAX = 3

		//How much off, def, and spd contribute.
		ACC_OFF = 0.8
		ACC_DEF = 0.8
		ACC_OFF_SPD = 0.3
		ACC_DEF_SPD = 0.3

		//Attaches an exponent to the accmult before clamping.
		EXPERIMENTAL_ACCMULT = 1
		EXPERIMENTAL_ACCMULT_EXPONENT = 0.5

		//straight multiplier to how much it breaks.
		WEAPON_BREAKER_EFFECTIVENESS = 1
		//straight multiplier at the end; for ubw saga only (self-inflicted break)
		UBW_BREAK_MULTIPLIER = 10
		//firm multiplies break by a further x5
		UBW_FIRM_BREAK_MULTIPLIER = 5

		MAX_BREAK_MULT = 6
		MAX_BREAK_VAL = 200


		DEICIDE_DAMAGE_DIVISOR = 4
		HOLY_DAMAGE_DIVISOR = 4
		ABYSS_DAMAGE_DIVISOR = 4
		SLAYER_DAMAGE_DIVISOR = 4
		ENRAGED_DAMAGE_DIVISOR = 4
// -- items -- //

		JSON_PASSIVES = list()
// - swords
		SwordAscDamage= 0.05
		SwordAscAcc= 0.05
		SwordAscDelay= 0.05
// - staffs
		StaffAscDamage = 0.05
		StaffAscAcc = 0.05
		StaffAscDelay = 0.05
// - armor
		ArmorAscDamage = 0.05
		ArmorAscDelay = 0.05
		ArmorAscAcc = 0.05
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

		CHIKARA_WHITELIST = TRUE

		DESP_DMG_MULTIPLIER = 4
		DESP_DMG_REDUCTION = 4

		STAT_DMG_EXPONENT = 0.75
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
