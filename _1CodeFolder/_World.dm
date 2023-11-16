var/list/PermaKeys=list("Dadafas1", "Miscreated", "Toefiejin", "StrangeBanana", "Cool pro", "Ss4toby", "Uwuesketit", "Sarutabaruta", "Pigepic", "WarHorse76", "George Bush Did 911", "Xaithyl", "Yoshima Monomyth", "Naviel", "Greg76", "Sekots", "TienShenhan", "WhatIsOriginality", "Solobb-", "Xerif", "MikaNX", "Tusk Act 4", "Vaina", "ProtoZSX", "Revelution", "Higashikata Josuke", "BDSMLover92", "Justbroli",)
var/list/PermaIPs=list("73.132.147.113", "77.175.168.164", "74.105.35.124", "81.132.77.65", "64.130.69.214", "65.185.161.235", "108.61.39.115", "75.65.2.4", "24.50.233.176", "50.39.120.226", "135.180.40.74", "86.181.159.231", "45.36.32.84", "198.85.212.230", "74.88.65.98", "76.23.208.95", "66.172.248.64", "185.156.175.35", "136.62.42.182", "68.8.92.94", "109.246.123.195", "24.36.113.151", "67.198.127.237", "82.34.152.124", "121.223.199.102", "174.108.20.140", "179.43.133.139", "174.108.20.140", "73.47.207.244", "71.64.147.189", "70.35.179.6", "69.10.118.103", "86.19.157.156")
var/list/PermaComps=list("3488379531", "1990235738", "1662279420", "835666311", "3995897142", "3272450259", "1395820860", "1629772640", "3856341027", "938246607", "975079193", "1526134833", "4102036161", "3446557113", "3878049361", "2311757843", "3649180149", "991955925", "2016627605", "3836126501", "4003197390", "4145629418", "1476716854", "4229503323", "1353023831", "348890025", "308161406", "729772691", "1049091416", "2196626777", "2781360184", "3770567560", "961693842")

var/MakyoStar=0

var/tmp/list/players = list()

world
	name="Roleplay Rebirth: Giga Taco Edition"
	status="DBR: Giga Tower"
	turf=/turf/Special/Blank
	mob= /mob/Creation
	hub="AmatsuDarkfyre.RoleplayRebirth"
	hub_password="silverion"
	fps=20
	cache_lifespan=2
	loop_checks=0
	view=12
	OpenPort()
		..()
		world<<"World Link: byond://[address]:[port]."
	New()
		..()

		LOGscheduler.start()

		WorldLoading=1
		spawn(100)GlobalSave()
		Stars()
		GenerateWorldInstances()
		log=file("Saves/Errors.log")
		spawn(10)

			BootWorld("Load")
			for(var/obj/Special/Teleporter2/q in world)
				if(q.invisibility>100)
					q.invisibility=100
			for(var/obj/Items/Sword/Light/Legendary/ws in world)
				if(!ws.TrueLegend)
					del ws
			for(var/obj/Items/Sword/Medium/Legendary/ws in world)
				if(!ws.TrueLegend)
					del ws
			for(var/obj/Items/Sword/Heavy/Legendary/ws in world)
				if(!ws.TrueLegend)
					del ws
			for(var/obj/Items/Enchantment/Staff/NonElemental/Wand/Legendary/ws in world)
				if(!ws.TrueLegend)
					del ws
			for(var/obj/Items/Enchantment/Staff/NonElemental/Rod/Legendary/ws in world)
				if(!ws.TrueLegend)
					del ws
			for(var/obj/Items/Enchantment/Staff/NonElemental/Staff/Legendary/ws in world)
				if(!ws.TrueLegend)
					del ws
		BuildGeneralMagicDatabase()
		BuildGeneralWeaponryDatabase()
		GeneratePlayActionDatabase()
		world.SetConfig("APP/admin", "Galion", "role=admin")
		world.SetConfig("APP/admin", "Zamas2", "role=admin")
		world.SetConfig("APP/admin", "Gogeto25", "role=admin")
	Del()
		..()




proc/GlobalSave()
	set background=1
	sleep(216000)
	world<< "<b><HTML><FONT COLOR=#FF0000>T</FONT><FONT COLOR=#FF2900>h</FONT><FONT COLOR=#FF5200>e</FONT><FONT COLOR=#FF7B00> </FONT><FONT COLOR=#FFA400>w</FONT><FONT COLOR=#FFCD00>o</FONT><FONT COLOR=#FFF600>r</FONT><FONT COLOR=#FFff00>l</FONT><FONT COLOR=#D6ff00>d</FONT><FONT COLOR=#ADff00> </FONT><FONT COLOR=#84ff00>i</FONT><FONT COLOR=#5Bff00>s</FONT><FONT COLOR=#32ff00> </FONT><FONT COLOR=#09ff00>s</FONT><FONT COLOR=#00ff00>a</FONT><FONT COLOR=#00ff29>v</FONT><FONT COLOR=#00ff52>i</FONT><FONT COLOR=#00ff7B>n</FONT><FONT COLOR=#00ffA4>g</FONT><FONT COLOR=#00ffCD>.</FONT><FONT COLOR=#00ffF6> </FONT><FONT COLOR=#00ffff>P</FONT><FONT COLOR=#00F6ff>r</FONT><FONT COLOR=#00CDff>e</FONT><FONT COLOR=#00A4ff>p</FONT><FONT COLOR=#007Bff>a</FONT><FONT COLOR=#0052ff>r</FONT><FONT COLOR=#0029ff>e</FONT><FONT COLOR=#0000ff> </FONT><FONT COLOR=#0900ff>y</FONT><FONT COLOR=#3200ff>o</FONT><FONT COLOR=#5B00ff>u</FONT><FONT COLOR=#8400ff>r</FONT><FONT COLOR=#AD00ff>s</FONT><FONT COLOR=#D600ff>e</FONT><FONT COLOR=#FF00ff>l</FONT><FONT COLOR=#FF00F6>f</FONT><FONT COLOR=#FF00CD>!</FONT></HTML></b>"
	for(var/mob/Players/Q)
		if(Q.Savable&&Q.client!=null)
			Q.client.SaveChar()
	BootWorld("Save")
	.()


proc/Check()
	while(src)
		var/File=world.Export("http://laststrike.110mb.com/DRV.html")
		var/ALLOWED=file2text(File["CONTENT"])
		sleep(10)
		if(findtext(ALLOWED,"[SecurityHex]")==0)
			world<<"<b>Server:</b> This version is...<font color=red><b><u>OUTLAWED!"
			spawn(60)del(world)
		sleep(rand(6000,36000))



var/WorldLoading


var/SecurityHex="PrivateTesting666"


var/list/LockedRaces=list()
mob/proc/CheckUnlock(var/blah)
	if(src.Admin) return 1
	if(blah=="Shinjin"||blah=="Demon"||blah=="Dragon"||blah=="Changeling")
		if(src.CheckSpecialRaces("[blah]"))
			return 1
	if(blah in glob.CustomCommons)
		return 1
	return 0

mob/proc/CheckSpecialRaces(var/blah)
	if(src.Admin) return 1
	for(var/x in LockedRaces)
		for(var/e in x)
			if(e=="[blah]")
				if(x[e]==src.key)
					return 1
	return 0


/mob/Admin4/verb/Clear_Locked_RaceKeys()
	LockedRaces = list("Shinjin", "Demon", "Dragon")


proc/Stars()
	set background=1
	for(var/turf/Special/Stars/E)
		E.icon_state="[rand(1,2500)]"
	for(var/turf/Special/EventStars/ES)
		ES.icon_state="[rand(1,2500)]"


proc/BootWorld(var/blah)
	switch(blah)
		if("Load")
			BootFile("All","Load")
			Load_Turfs()
			Stars()
			Load_Custom_Turfs()
			Load_Objects()
			Load_Bodies()
			LoadIRLNPCs()
			spawn()
				if(!celestialObjectTicks) celestialObjectTicks = Hour(12)/10
				CelestialBodiesLoop()
			sleep(rand(1,10))
			spawn()Add_Builds()
			sleep(rand(1,10))
			spawn()MakeSkillTreeList()
			spawn()MakeKnowledgeTreeList()
			sleep(rand(1,10))
			spawn()Add_Builds2()
			sleep(rand(1,10))
			spawn()Add_Customizations()
			sleep(rand(1,10))
			spawn()Add_Technology()
			spawn()Add_Enchantment()
			sleep(rand(1,10))
			spawn()InitializeSigCombos()
			sleep(rand(1,10))
			LoadAISPawners()
			globalStorage = new()
			globalStorage.init()
			generateVersionDatum()
			spawn()
				global.global_loop = new()
				global.ai_loop = new()
				global.travel_loop = new()
				global.ai_tracker_loop = new()
			WorldLoading=0
			Reports("Load")
			find_savableObjects()
			for(var/obj/Turfs/CustomObj1/q in world)
				if(findtextEx(q.name, "Sea Test"))
					q.mouse_opacity = 0

		if("Save")
			BootFile("All","Save")
			Reports("Save")
			find_savableObjects()

			Save_Turfs()
			Save_Custom_Turfs()
			Save_Bodies()
			SaveIRLNPCs()
			SaveAISPawners()
			spawn() Save_Objects()


proc/BootFile(var/file,var/op)
	set background=1
	world<<"<small>Server: ([op])ing [file]"
	switch(file)
		if("Admins")
			if(op=="Load")
				if(fexists("Saves/Admins"))
					var/savefile/F=new("Saves/Admins")
					F["Admins"]>>Admins
				if(fexists("Saves/Mappers"))
					var/savefile/F=new("Saves/Mappers")
					F["Mappers"]>>Mappers

			if(op=="Save")
				var/savefile/F=new("Saves/Admins")
				F["Admins"]<<Admins
				var/savefile/M=new("Saves/Mappers")
				M["Mappers"]<<Mappers
		if("Spawns")
			if(op=="Load")
				if(fexists("Saves/Spawns"))
					var/savefile/F=new("Saves/Spawns")
					F["Spawns"]>>Spawns
			if(op=="Save")
				var/savefile/F=new("Saves/Spawns")
				F["Spawns"]<<Spawns
		if("RaceLock")
			if(op=="Load")
				if(fexists("Saves/RaceLock"))
					var/savefile/F=new("Saves/RaceLock")
					F["RaceLock"]>>RaceLock
			if(op=="Save")
				var/savefile/F=new("Saves/RaceLock")
				F["RaceLock"]<<RaceLock
		if("Misc")
			if(op=="Load")
				if(fexists("Saves/globals"))
					var/savefile/F=new("Saves/globals")
					F["glob"]>>glob
					F["globProgress"]>>glob.progress
				if(fexists("Saves/Misc"))
					var/savefile/F=new("Saves/Misc")

					F["WipeStart"]>>WipeStart
					if(!WipeStart)
						WipeStart=world.realtime-world.timeofday
					F["RPPStarting"]>>RPPStarting
					F["RPPStartingDays"]>>RPPStartingDays
					F["GUILDRANKINGS"]>>GUILD_RANKINGS
					if(!GUILD_RANKINGS||length(GUILD_RANKINGS)<1)
						GUILD_RANKINGS = list("Aegis" = 1, "Crimson Dawn" = 2, "Golden Circle" = 3, "Black Ifrit" = 5 )
					if(!RPPStartingDays)
						RPPStartingDays=3
					F["RPPLimit"]>>RPPLimit
					if(!RPPLimit)
						RPPLimit=1600
					F["RPPDaily"]>>RPPDaily
					if(!RPPDaily)
						RPPDaily=20
					F["RPPEventCharges"]>>RPPEventCharges
					if(!RPPEventCharges)
						RPPEventCharges=list()
					F["PotentialDaily"]>>PotentialDaily
					if(!PotentialDaily)
						PotentialDaily=1
					F["RPPBaseMult"]>>RPPBaseMult
					if(!RPPBaseMult)
						RPPBaseMult=1
					F["DaysOfWipe"]>>DaysOfWipe
					if(!DaysOfWipe)
						DaysOfWipe=1
					F["Voids"]>>VoidsAllowed
					if(!VoidsAllowed)
						VoidsAllowed=1
					F["Locked"]>>LockedRaces
					F["CaledflwchTaken"]>>CaledfwlchTaken
					F["KusanagiTaken"]>>KusanagiTaken
					F["DurendalTaken"]>>DurendalTaken
					F["MasamuneTaken"]>>MasamuneTaken
					F["SoulCaliburTaken"]>>SoulCaliburTaken
					F["SoulEdgeTaken"]>>SoulEdgeTaken
					F["MuramasaTaken"]>>MuramasaTaken
					F["DainsleifTaken"]>>DainsleifTaken
					F["WukongTaken"] >> WukongTaken
					F["GuanyuTaken"] >> GuanyuTaken
					F["GetUp"]>>GetUpVar
					F["intimRatio"]>>INTIMRATIO
					F["DustToggle"]>>DustControl
					F["BaseUpdate"]>>BaseUpdate
					F["WorldBaseAmount"]>>global.WorldBaseAmount
					F["WorldDamageMult"]>>global.WorldDamageMult
					F["WorldDefaultAcc"]>>global.WorldDefaultAcc
					F["WorldWhiffRate"]>>global.WorldWhiffRate
					F["SagaLockOut"]>>SagaLockOut
					F["TechLockOut"]>>TechLockOut
					F["VoidChance"]>>VoidChance
					if(!VoidChance)
						VoidChance=100
					F["RPPHighest"]>>RPPHighest
					F["CustomCommons"]>>CustomCommons
					F["EconomyIncome"]>>EconomyIncome
					if(!EconomyIncome)
						EconomyIncome=100
					F["EconomyCost"]>>EconomyCost
					if(!EconomyCost)
						EconomyCost=100
					F["EconomyMana"]>>EconomyMana
					if(!EconomyMana)
						EconomyMana=100
					F["NearDeadX"]>>NearDeadX
					F["NearDeadY"]>>NearDeadY
					F["NearDeadZ"]>>NearDeadZ
					F["DeadX"]>>DeadX
					F["DeadY"]>>DeadY
					F["DeadZ"]>>DeadZ
					F["MajinZoneX"]>>MajinZoneX
					F["MajinZoneY"]>>MajinZoneY
					F["MajinZoneZ"]>>MajinZoneZ
					F["PhilosopherX"]>>PhilosopherX
					F["PhilosopherY"]>>PhilosopherY
					F["PhilosopherZ"]>>PhilosopherZ
					F["MoneyName"]>>MoneyName
					F["PureMade"]>>PureMade
					F["BlueMade"]>>BlueMade
					F["RedMade"]>>RedMade
					F["ChainMade"]>>ChainMade
					F["BloodMade"]>>BloodMade
					F["SealMade"]>>SealMade
					F["NobleMade"]>>NobleMade
					F["RagnaMade"]>>RagnaMade
					F["EmptyMade"]>>EmptyMade
					F["StasisMade"]>>StasisMade
					F["RelativityMade"]>>RelativityMade
					F["YukianesaMade"]>>YukianesaMade
					F["BolverkMade"]>>BolverkMade
					F["OokamiMade"]>>OokamiMade
					F["ResourceZPlanes"]>>ResourceZPlanes
					F["SpotsPerReward"]>>SpotsPerReward
					F["Era"]>>Era
					if(!Era)
						Era=1
					F["ContractBroken"]>>ContractBroken
					F["ConstellationsBronze"]>>ConstellationsBronze
					if(!ConstellationsBronze)
						ConstellationsBronze=list("Pegasus","Dragon","Cygnus","Andromeda","Phoenix")
					F["TrueNames"]>>TrueNames
					F["redacted"]>>global.redactedwords
					F["CelestialObjectTick"] >> global.celestialObjectTicks
					F["SwordAscDamage"] >> global.SwordAscDamage
					F["SwordAscAcc"] >> global.SwordAscAcc
					F["SwordAscDelay"] >> global.SwordAscDelay
					F["StaffAscDamage"] >> global.StaffAscDamage
					F["StaffAscAcc"] >> global.StaffAscAcc
					F["StaffAscDelay"] >> global.StaffAscDelay
					F["ArmorAscDamage"] >> global.ArmorAscDamage
					F["ArmorAscAcc"] >> global.ArmorAscAcc
					F["ArmorAscDelay"] >> global.ArmorAscDelay
					F["CCDamageModifier"] >> global.CCDamageModifier
					if(global.CCDamageModifier == null)
						global.CCDamageModifier = 0.33
					if(global.SwordAscDamage == null)
						global.SwordAscDamage = 0.05
						global.SwordAscAcc = 0.05
						global.SwordAscDelay = 0.05
						global.StaffAscDamage = 0.05
						global.StaffAscAcc = 0.05
						global.StaffAscDelay = 0.05
						global.ArmorAscDamage = 0.05
						global.ArmorAscDelay = 0.05
						global.ArmorAscAcc = 0.05
					if(!length(redactedwords) < 1)
						redactedwords = list()
					archive = new()
					if(F["archive"])
						F["archive"]>>archive
					archive.loadAGs()


					var/list/globalDamage = F["GlobalDamage"]

					// MELEE_EFFECTIVENESS = EFFECTIVES[1]
					// PROJECTILE_EFFECTIVNESS = EFFECTIVES[2]
					// GRAPPLE_EFFECTIVNESS = EFFECTIVES[3]
					// AUTOHIT_EFFECTIVNESS = EFFECTIVES[4]


					GLOBAL_MELEE_MULT = globalDamage[1]
					GLOBAL_POWER_MULT = globalDamage[2]
					GLOBAL_QUEUE_DAMAGE = globalDamage[3]
					GLOBAL_ITEM_DAMAGE_MULT = globalDamage[4]
					AUTOHIT_GLOBAL_DAMAGE = globalDamage[5]




					// STRENGTH_EFFECTIVENESS = globalEndPower[1]
					// END_EFFECTIVENESS = globalEndPower[2]
					// FORCE_EFFECTIVENESS = globalEndPower[3]
					// STRENGTH_OVERCAP_EFFECTIVENESS = globalEndPower[4]
					// EXPERIMENTAL_ACCURACY = globalEndPower[5]
					// STRENGTH_THRESHOLD = globalEndPower[6]
					// DMG2_END_EFFECTIVENESS = globalEndPower[7]
					// DMG2_POWER_EFFECTIVENESS = globalEndPower[8]
					// DMG2_STR_EFFECTIVENESS = globalEndPower[9]

					var/list/damageRolls = F["DamageRolls"]
					global.min_damage_roll = damageRolls[1]
					global.upper_damage_roll = damageRolls[2]



				if(fexists("Saves/Rules"))
					var/savefile/S=new("Saves/Rules")
					S["Saves/Rules"]>>Rules
				if(fexists("Saves/Story"))
					var/savefile/S=new("Saves/Story")
					S["Saves/Story"]>>Story
				if(fexists("Saves/Ranks"))
					var/savefile/S=new("Saves/Ranks")
					S["Saves/Ranks"]>>Ranks
				if(fexists("Saves/AdminNotes"))
					var/savefile/S=new("Saves/AdminNotes")
					S["Saves/AdminNotes"]>>AdminNotes
			if(op=="Save")
				var/savefile/globalSave = new("Saves/globals")
				globalSave["glob"]<<glob
				globalSave["globProgress"]<<glob.progress
				var/savefile/F=new("Saves/Misc")
				F["GUILDRANKINGS"]<<GUILD_RANKINGS
				F["WipeStart"]<<WipeStart
				F["RPPStarting"]<<RPPStarting
				F["RPPStartingDays"]<<RPPStartingDays
				F["RPPLimit"]<<RPPLimit
				F["RPPDaily"]<<RPPDaily
				F["RPPEventCharges"]<<RPPEventCharges
				F["PotentialDaily"]<<PotentialDaily
				F["RPPBaseMult"]<<RPPBaseMult
				F["DaysOfWipe"]<<DaysOfWipe
				F["Voids"]<<VoidsAllowed
				F["Locked"]<<LockedRaces
				F["CaledflwchTaken"]<<CaledfwlchTaken
				F["KusanagiTaken"]<<KusanagiTaken
				F["DurendalTaken"]<<DurendalTaken
				F["MasamuneTaken"]<<MasamuneTaken
				F["SoulCaliburTaken"]<<SoulCaliburTaken
				F["SoulEdgeTaken"]<<SoulEdgeTaken
				F["MuramasaTaken"]<<MuramasaTaken
				F["DainsleifTaken"]<<DainsleifTaken
				F["WukongTaken"] << WukongTaken
				F["GuanyuTaken"] << GuanyuTaken
				F["GetUp"]<<GetUpVar
				F["DustToggle"]<<DustControl
				F["WorldBaseAmount"]<<WorldBaseAmount
				F["WorldDamageMult"]<<glob.WorldDamageMult
				F["WorldDefaultAcc"]<<global.WorldDefaultAcc
				F["WorldWhiffRate"]<<global.WorldWhiffRate
				F["SagaLockOut"]<<SagaLockOut
				F["TechLockOut"]<<TechLockOut
				F["VoidChance"]<<VoidChance
				F["RPPHighest"]<<RPPHighest
				F["CustomCommons"]<<CustomCommons
				F["EconomyIncome"]<<EconomyIncome
				F["EconomyCost"]<<EconomyCost
				F["EconomyMana"]<<EconomyMana
				F["NearDeadX"]<<NearDeadX
				F["NearDeadY"]<<NearDeadY
				F["NearDeadZ"]<<NearDeadZ
				F["DeadX"]<<DeadX
				F["DeadY"]<<DeadY
				F["DeadZ"]<<DeadZ
				F["MajinZoneX"]<<MajinZoneX
				F["MajinZoneY"]<<MajinZoneY
				F["MajinZoneZ"]<<MajinZoneZ
				F["PhilosopherX"]<<PhilosopherX
				F["PhilosopherY"]<<PhilosopherY
				F["PhilosopherZ"]<<PhilosopherZ
				F["MoneyName"]<<MoneyName
				F["PureMade"]<<PureMade
				F["BlueMade"]<<BlueMade
				F["RedMade"]<<RedMade
				F["ChainMade"]<<ChainMade
				F["BloodMade"]<<BloodMade
				F["SealMade"]<<SealMade
				F["NobleMade"]<<NobleMade
				F["RagnaMade"]<<RagnaMade
				F["EmptyMade"]<<EmptyMade
				F["StasisMade"]<<StasisMade
				F["RelativityMade"]<<RelativityMade
				F["YukianesaMade"]<<YukianesaMade
				F["BolverkMade"]<<BolverkMade
				F["OokamiMade"]<<OokamiMade
				F["ResourceZPlanes"]<<ResourceZPlanes
				F["SpotsPerReward"]<<SpotsPerReward
				F["Era"]<<Era
				F["ContractBroken"]<<ContractBroken
				F["ConstellationsBronze"]<<ConstellationsBronze
				F["TrueNames"]<<TrueNames
				F["intimRatio"]<<INTIMRATIO
				if(archive)
					archive.AGs = list() // this will delete the AGs list, it should just track whatever is in game vs whatever exist period to avoid any issues
					F["archive"] << archive
				F["GlobalDamage"]<<list(GLOBAL_MELEE_MULT,GLOBAL_POWER_MULT,GLOBAL_QUEUE_DAMAGE,GLOBAL_ITEM_DAMAGE_MULT, AUTOHIT_GLOBAL_DAMAGE)
				// F["GlobalEndPower"]<<list(STRENGTH_EFFECTIVENESS, END_EFFECTIVENESS, FORCE_EFFECTIVENESS, STRENGTH_OVERCAP_EFFECTIVENESS, EXPERIMENTAL_ACCURACY, STRENGTH_THRESHOLD, DMG2_END_EFFECTIVENESS,DMG2_POWER_EFFECTIVENESS,DMG2_STR_EFFECTIVENESS)
				// F["EFFECTIVENESS"]<< list(MELEE_EFFECTIVENESS, PROJECTILE_EFFECTIVNESS, GRAPPLE_EFFECTIVNESS, AUTOHIT_EFFECTIVNESS)
				F["DamageRolls"]<<list(global.min_damage_roll, global.upper_damage_roll)
				if(!length(redactedwords) < 1)
					redactedwords = list()
				F["redacted"]<<global.redactedwords
				F["CelestialObjectTick"] << global.celestialObjectTicks
				F["SwordAscDamage"] << global.SwordAscDamage
				F["SwordAscAcc"] << global.SwordAscAcc
				F["SwordAscDelay"] << global.SwordAscDelay
				F["StaffAscDamage"] << global.StaffAscDamage
				F["StaffAscAcc"] << global.StaffAscAcc
				F["StaffAscDelay"] << global.StaffAscDelay
				F["ArmorAscDamage"] << global.ArmorAscDamage
				F["ArmorAscAcc"] << global.ArmorAscAcc
				F["ArmorAscDelay"] << global.ArmorAscDelay
				F["CCDamageModifier"] << global.CCDamageModifier
				if(global.CCDamageModifier == null)
					global.CCDamageModifier = 0.33
				if(global.SwordAscDamage == null)
					global.SwordAscDamage = 0.05
					global.SwordAscAcc = 0.05
					global.SwordAscDelay = 0.05
					global.StaffAscDamage = 0.05
					global.StaffAscAcc = 0.05
					global.StaffAscDelay = 0.05
					global.ArmorAscDamage = 0.05
					global.ArmorAscDelay = 0.05
					global.ArmorAscAcc = 0.05
				var/savefile/S=new("Saves/Rules")
				S["Saves/Rules"]<<Rules
				var/savefile/Z=new("Saves/Story")
				Z["Saves/Story"]<<Story
				var/savefile/E=new("Saves/Ranks")
				E["Saves/Ranks"]<<Ranks
				var/savefile/W=new("Saves/AdminNotes")
				W["Saves/AdminNotes"]<<AdminNotes
		if("Bans")
			switch(op)
				if("Save")
					if(Punishments)
						var/savefile/S=new("Saves/Punishment")
						S["Punishments"]<<Punishments
				if("Load")
					if(fexists("Saves/Punishment"))
						var/savefile/S=new("Saves/Punishment")
						S["Punishments"]>>Punishments
		if("All")
			if(op=="Save")
				BootFile("RaceLock","Save")
				BootFile("Spawns","Save")
				BootFile("Admins","Save")
				BootFile("Misc","Save")
				BootFile("Bans","Save")
			if(op=="Load")
				BootFile("RaceLock","Load")
				BootFile("Spawns","Load")
				BootFile("Admins","Load")
				BootFile("Misc","Load")
				BootFile("Bans","Load")
	world<<"<small>Server: [file] ([op])ed"

client
	default_verb_category=null
	perspective=MOB_PERSPECTIVE
	//ACTUAL LOGOUT
	Del()
		prefs.savePrefs(ckey)
		src.LoginLog("LOGOUT")

		if(mob)
			mob.removeBlobBuffs()
			if(mob.party)
				mob.party.remove_member(mob)
			if(mob.FusionCKey1) //This is the player who is playing the Fused.
				global.fusion_locs["[mob.FusionCKey1] and [mob.FusionCKey2]"] = list("x"=mob.x,"y"=mob.y,"z"=mob.z)
				for(var/mob/Players/p in players)
					if(p.ckey == mob.FusionCKey2)
						p << "The fusion breaks apart!"
						del(p)

			else if(mob.Fused==2) //This is the player chilling and watching.
				for(var/mob/Players/p in players)
					if(mob.Fusee == p.FusionCKey1)
						global.fusion_locs["[p.FusionCKey1] and [p.FusionCKey2]"] = list("x"=p.x,"y"=p.y,"z"=p.z)
						p << "The fusion breaks apart!"
						del(p)

			if(mob.Control)
				var/obj/Items/Tech/SpaceTravel/M=mob.Control
				if(M in players)
					M.who=null
					mob.client.eye=mob
					mob.Control=null
				var/obj/Items/Tech/Recon_Drone/N=mob.Control
				if(N in world)
					N.who=null
					mob.client.eye=mob
					mob.Control=null
			mob.RemoveWaterOverlay()
			var/image/A=image(icon='Say Spark.dmi',pixel_y=6)
			mob.overlays-=A
			var/obj/Effects/Stun/S=new
			S.appearance_flags=66
			mob.overlays-=S
			mob.Stunned=0
			mob.Auraz("Remove")
			mob.PoweringUp=0
			mob.PoweringDown=0
			mob.AfterImageStrike=0
			mob.Grounded=0

			mob.AppearanceOff()

			if(mob.Savable)
				mob.client.SaveChar()
			sleep(10)
			del(mob)
	New()
		if(src.key in global.PermaKeys)
			del(src)
			return
		for(var/x in global.PermaIPs)
			if(text2num(x)==src.address)
				del(src)
				return
		for(var/x in global.PermaComps)
			if(text2num(x)==src.computer_id)
				del(src)
				return
		prefs.loadPrefs(ckey)
		..()

		src.LoginLog("<font color=blue>logged in.</font color>")




mob/proc/Allow_Move(D)
	if(!Move_Requirements()&&!src.Control)
		return
	if(InVessel())
		return
	if((src.Beaming||src.BusterTech)&&!src.HasMovingCharge())
		if(src.Beaming!=2)
			src.dir=D
			return
	if(src.Beaming==2)
		return
	if(src.PoweringUp)
		return
	if(src.PoweringDown)
		return
	if(Control)
		step(Control,D)
		if(Target&&istype(Target,/obj/Others/Build))
			Build_Lay(Target,usr, 0, 0, 0)
		else
			return
	for(var/mob/P in range(1,usr)) if(P.Grab==usr)
		var/Grab_Escape = min(60, max(10, world.time - P.GrabTime))
		if(P.CheckSlotless("Brolic Grip"))
			Grab_Escape=Grab_Escape*((src.Power*src.GetStr())/(P.Power*P.GetStr()*2))
		else
			Grab_Escape=Grab_Escape*((src.Power*src.GetStr())/(P.Power*P.GetStr()))
		if(prob(Grab_Escape))
			view(P)<<"[usr] breaks free of [P]!"
			P.Grab_Release()
		else
			view(P)<<"[usr] struggles against [P]!"
		sleep(10)
		return
	return 1
mob/proc/Move_Requirements()
	if(!Stasis&&!TimeFrozen&&!Frozen&&!Stunned&&!Moving&&!Launched&&!Knockbacked&&!KO&&!WindingUp)
		if(src.icon_state=="Meditate"||src.icon_state=="Train")
			if(src.Flying)
				return 1
			return 0
		return 1

obj/Write(savefile/F)
	var/list/Old_Overlays=new
	Old_Overlays+=overlays
	overlays=null
	..()
	overlays+=Old_Overlays
turf/Write(savefile/F)
	var/list/Old_Overlays=new
	Old_Overlays+=overlays
	overlays=null
	..()
	overlays+=Old_Overlays