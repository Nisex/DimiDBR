// jesus christ lets get a grip
#define GODS list("Janus", "The Calamity")
#define WSNAMES list("Masamune", "Durendal", "Kusanagi", "Caledfwlch", "Muramasa", "Soul Calibur", "Soul Edge", "Dainsleif", "Ryui Jingu Bang")
#define BRONZECLOTHS list("Pegasus","Dragon","Cygnus","Andromeda","Phoenix","Unicorn")
#define GOLDCLOTHS list("Aries",/* "Taurus" */,"Gemini","Cancer","Leo","Virgo","Libra","Scorpio", "Sagittarius","Capricorn","Aquarius","Pisces")

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
		LIVE_TESTING = 1
		TESTER_WHITE_LIST = list("Digi-Daisuke","RevealingFortune","Zamas2","Niezan", "Etro", "AMajin", "Redsarge", "Gogeto25",\
 "Tilthour", "Sakata Gintoki San", "Hellbante", "FoxMagnus")

// TARGETING
		LIMIT_CLICKS = TRUE
		CLICK_SAME_Z_FORCE = TRUE
		MAX_CLICK_DISTANCE = 30
		CANT_CLICK_INVS = TRUE
		ADMIN_INVIS_ONLY = FALSE
		BREAK_TARGET = TRUE
		BREAK_TARGET_ON_Z_CHANGE = TRUE
		BREAK_TARGET_ON_DIST = FALSE




//INTIM
		INTIMRATIO = 500
		NEWINTIMCALC = TRUE

//Wipe Specific
		list/GUILD_RANKINGS = list("Aegis" = 1, "Crimson Dawn" = 2, "Golden Circle" = 3, "Black Ifrit" = 5, "Revenants" = 6)
		list/VOID_LOCATION = list(144,140,15)
		VoidsAllowed = 1
		VoidChance = 78


		IGNORE_NOT_LOGGEDIN_LOGINS = TRUE

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
		BASE_HELL_SCALING_RATIO = 0.01
		HELL_SCALING_MULT = 1.5
		DEMON_NAME = "Shatterspawn"
		DEMON_ERODE_DEBUFF_INTENSITY = 0.005
		DEMON_DOT_DEBUFF_INTENSITY = 6
		DEMON_RESOURCE_DEBUFF_INTENSITY = 0.2
		UNDERDOG_DIVISOR = 4
		MADNESS_DRAIN = 5
		MADNESS_DRAIN_FORM = 2
		CONQ_HAKI_RACES = list(HUMAN, YOKAI, DEMON, ELF, SAIYAN, NAMEKIAN, MAJIN, MAKYO, DRAGON, BEASTMAN, GAJALAKA, CHANGELING)
		EXTRA_CONQ_HAKI_POWER = 1.5
		MONEYORFRAGMENTS = 1 // 1 = fragments, 0 = cash
// globals
		WorldBaseAmount = 1
		WorldDamageMult = 1
		WorldDefaultAcc = 50
		WorldWhiffRate = 25
		celestialObjectTicks
		NoSagaRaces = list(DEMON, DRAGON, ELF, SAIYAN)
// combat
		OVERHWELMING_BASE_END_NERF = 0.05
		OVERHWELMING_SHATTER_APPLY = 150
		OVERHWELMING_BASE_PR_NERF = 0.05
		OVERHWELMING_BASE_FLOW = 0.15
		BEAST_OVERHWELMING_STATIC = 20
		RUPTURE_BASE_DAMAGE = 2



		DESP_PROC_LIMIT = 6
		DESP_PROC_CHANCE = 3
		DESP_DIVISOR_LIMIT = 8
		DESP_REDUCE_DAMAGE = FALSE
		DESP_VAI_MULT = 2
		DESP_VAI_MIN = 5
		DESP_VAI_MAX = 15
		DESP_KB_RES_CHANCE = 2.5
		DESP_GETUP_CHANCE = 8
		MAX_CRIPPLE_MULT = 2
		CRIPPLE_DIVISOR = 100

		MECH_LEVEL_MULT = 0.15
		PILOT_MULT = 0.09


		DEVIL_ARM_STAT_MULTS = FALSE
		POSE_TIME_NEEDED = 2

		MAX_HARDEN = 20
		DEMONIC_DURA_BASE = 0.04
		MAX_HARDENING = 5
		HARDENING_BASE = 0.006
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
		BLINK_COST = 0.5
		DEBUFF_INTENSITY = 1.2
		ITEM_DEBUFF_APPLY_NERF = 2.5
		BURN_INTENSITY = 1
		SLOW_INTENSITY = 1
		SHATTER_INTENSITY = 1
		SHOCK_INTENSITY = 1
		POISON_INTENSITY = 1
		CHAOS_CHANCE = 25
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
		ENERGY_GEN_DIVISOR = 10
		ENERGY_GEN_MULT = 0.2
		LIFE_GEN_DIVISOR = 10
		LIFE_GEN_MULT = 0.2

		SSJ_BASE_CUT_OFF = 10
		SSJ_BASE_DRAIN = 0.1
		SSJ_CUT_OFF_PER_MAST = 0.25

		SSJ_MIN_MASTERY_GAIN = 0.01
		SSJ_MAX_MASTERY_GAIN = 0.02
		SSJ_TRANS_NUM_AS_MASTERY_MULT = TRUE

		OXYGEN_DRAIN = 3
		OXYGEN_DRAIN_DIVISOR = 2

		CAN_BE_SLOWED_GODSPEED = 6



		GLOBAL_BEAM_DAMAGE_DIVISOR = 30
		GLOBAL_QUEUE_DAMAGE = 0.85
		GLOBAL_MELEE_MULT = 0.9
		GLOBAL_POWER_MULT = 1
		GLOBAL_ITEM_DAMAGE_MULT = 0.75
		EXPONENTIAL_PROJ_DAMAGE = FALSE
		PROJ_DAMAGE_MULT = 1
		AUTOHIT_GLOBAL_DAMAGE = 0.8
		SOFT_STYLE_RATIO = 0.3
		SOFT_STYLE_DMG_BOON_DIVISOR = 2
		HARD_STYLE_DMG_BOON_DIVISOR = 3
		SOUL_FIRE_MANA_RATIO = 0.3
		SOUL_FIRE_FATIGUE_RATIO = 0.05
		CHEAP_SHOT_DIVISOR = 40
		HARD_STYLE_RATIO = 0.1
		CURSED_WOUNDS_RATE = 0.25
		GLOBAL_EXPONENT_MULT = 1/3
		GRAPPLE_MELEE_BOON = 1.5
		GRIPPY_MOD = 0.25
		CLAMP_POWER = TRUE
		MIN_POWER_DIFF = 0.7
		MAX_POWER_DIFF = 1.3
		AUTOHIT_GRAB_NERF = 0.5
		PARTY_DAMAGE_NERF = 0.8
		MOD_AFTER_ACC = TRUE
		MANA_STATS_BASE_BOON = 0.15
		YOKAI_MANA_STATS_BASE_BOON = 0.3

		GLADIATOR_DISARM_MAX = 600
		DISARM_TIMER = 100

		LOWEST_ACC = 25

		CONSTANT_DAMAGE_EXPONENT = 4

		GRAPPLE_WHIFF_DAMAGE = 3

// effectiveness (dmg calc  shit)
		MELEE_EFFECTIVENESS = 1
		PROJECTILE_EFFECTIVNESS = 1
		GRAPPLE_EFFECTIVNESS = 3
		AUTOHIT_EFFECTIVNESS = 2
		GRAPPLE_DAMAGE_MULT = 0.75
		MUSCLE_POWER_DIVISOR = 4
		MAX_PURSUER_BOON = 10
		DMG_END_EXPONENT = 0.4
		DMG_STR_EXPONENT = 0.4
		DMG_POWER_EXPONENT = 0.3
		PURE_MODIFIER = 0.75
		PURE_MOD_POST_CALC = TRUE
		TENSION_MULTIPLIER = 1
		MIN_TENSION = 10
		CORRUPTION_GAIN = 1.25
		FIELD_MODIFIERS = 0.01
		GLUTTONY_MODIFIER = 0.14
		STEADY_MODIFIER = 0.05
		UNARMED_DAMAGE_DIVISOR = 6


		HARDER_THEY_FALL_BIO_DIVISOR = 100 // if u use this when changie first start it will do big damage
		HARDER_THEY_FALL_VAI_DIVISOR = 25 // more often no1 has this much vai, in hindsight deus ex machima will give kob more tha nthis, but they will suffer 2x damage ig
		
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
		STUN_IMMUNE_TIMER = 250
		MAX_STUN_TIME = 50
		LAUNCH_LOCKOUT = 200
		MAX_LAUNCH_TIME = 25
		TIMESTOP_MULTIPLIER = 70
// acc
		SWORD_GLOBAL_ACCURACY_NERF = 0.1
		STAFF_GLOBAL_ACCURACY_NERF = 0.1
		ARMOR_GLOBAL_ACCURACY_NERF = 0.2


		AUTOHIT_WHIFF_DAMAGE = 4
		AUTOHIT_MISS_DAMAGE = 10

		//Whiff dmg is now rand between these.
		MIN_WHIFF_DMG = 1.25
		MAX_WHIFF_DMG = 1.5


		GRABS_AUTOHIT = 1

		FLUID_FORM_RATE = 0.1
		DESPERATION_HIT_CHANCE = 0.005
		DESPERATION_MAX_HIT_CHANCE = 0.05

		JORDAN_ACCURACY = FALSE

		MIN_JORDAN_ACC_MOD = 0.05
		MAX_JORDAN_ACC_MOD = 3


		OLD_ACCURACY = 0

		MOD_AFTER_ROLL = 0

		//Min & max of AccMult in accuracy formula
		ACC_ACCMULT_MIN = 0.25
		ACC_ACCMULT_MAX = 2
		DEBUG_MESSAGES_ACCURACY = FALSE
		//how large the modifier for accuracy can be (off/def*accmult) clamped between these.

		//How much off, def, and spd contribute.
		ACC_OFF = 0.8
		ACC_DEF = 0.8
		ACC_OFF_SPD = 0.3
		ACC_DEF_SPD = 0.3
		EXTRA_DEF_MOD = 1.1
		//Attaches an exponent to the accmult before clamping.

		//straight multiplier to how much it breaks.
		WEAPON_BREAKER_EFFECTIVENESS = 1
		WEAPON_BREAKER_DIVISOR = 1.5
		WEAPON_ASC_DURA_BOON = 0.3
		//straight multiplier at the end; for ubw saga only (self-inflicted break)
		UBW_BREAK_MULTIPLIER = 10
		//firm multiplies break by a further x5
		UBW_FIRM_BREAK_MULTIPLIER = 5

		//how much copy_blade costs.
		UBW_COPY_COST = 6

		MAX_BREAK_MULT = 6
		MAX_BREAK_VAL = 200


		DEICIDE_DAMAGE_DIVISOR = 4
		HOLY_DAMAGE_DIVISOR = 4
		ABYSS_DAMAGE_DIVISOR = 4
		SLAYER_DAMAGE_DIVISOR = 4
		ENRAGED_DAMAGE_DIVISOR = 4
		MAX_ADDITONAL_DAMAGE_CLAMP = 10
		SPIRIT_FORM_BASE_RATE = 0.15
		SPIRIT_FORM_LEAK_VAL = 3
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

		/// Dainsleif Drain
		DainsleifDrain = 0.05
		infWeaponSoul = TRUE
		WeaponSoulNames = WSNAMES
		prayerTargetNames = GODS
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
"Scorpio" = FALSE,"Capricorn" = FALSE,"Aquarius" = FALSE,"Pisces" = FALSE, "Sagittarius" = FALSE)

		CHIKARA_WHITELIST = TRUE

		DESP_DMG_MULTIPLIER = 4
		DESP_DMG_REDUCTION = 4

		STAT_DMG_EXPONENT = 0.75


		ALLOW_CLICK_CORPSE = 0
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
