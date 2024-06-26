/** 
 * Plan. 
 * 4 Diaries. 
 * 
 * 4, murder diary
 * 3, detective diary
 * 2, yuno gasai,
 * 1, mc diary
 * 
 * murder gets a murder / maim based kit
 * get maimstrike based moves.. 
 * 
 * 
 * detective knows the target,
 * get detective esque moves.. 
 * i.e tazer etc.. 
 * HolyMod ttached to user vs murders abyss
 * 
 * yuno gasai
 * get t1 knife skills
 * and overall passives..
 * 
 * 
 * mc diary get random passives purely % chance.. (make a remake guard for rerolling..)
 * 
 * 
 * on picking it, you get the future diary object that acts as a pseudo buff. 
 * 1 flow, 1.1 speed, 1.1 str & for 
 * 
 */

////
// VARIABLES
/// 
var/list/randomPassives = list("PureDamage", 
"Godspeed", "Void", "NoWhiff", "HolyMod", "AbyssMod",
"VenomImmune", "CounterMaster", "TechniqueMastery",
"HybridStrike", "SpiritStrike", "Extend", "MovementMastery", "UnlimitedPU",
"CriticalBlock", "Unstoppable", "DebuffImmune")
mob/var/futureDiaryLevel = 0 // maxes out at 4.
mob/var/whichDiary = 0 /// 1, 2, 3, 4 look for above...


// PROCS

/////
///
/// 


obj/proc/getPassivesFutureDiary(var/mob/Player/M) // MC Passives.. 
	var/list/passiveList = list()
	passiveList = pick(randomPassives)				
	return passiveList


mob/proc/levelUpDiary(mob/M)
	M.futureDiaryLevel ++ 
	switch(M.futureDiaryLevel)
		if(1)
			if(!locate(/obj/Skills/Buffs/SpecialBuff/futureDiary, M))
				M.AddSkill(new/obj/Skills/Buffs/SpecialBuff/futureDiary)
			src << "You feel a connection with your Diary.. It becomes special.. It feels empowered by the powers of the cosmos."
			switch(input(M, "It has came time to chose your Diary out of the four..", "Chose your Diary") in list("First","Second","Third","Fourth"))
				if("First")
					M.whichDiary = 1
				if("Second")
					M.whichDiary = 2
				if("Third")
					M.whichDiary = 3
				if("Fourth")
					M.whichDiary = 4

		if(2)
			src << "You feel your connection to your Diary improve..."
			switch(M.whichDiary)
				if(2)
					M.AddSkill(new/obj/Skills/Queue/LoveStab)
				if(3)
					M.AddSkill(new/obj/Skills/Projectile/DetectivesShot)
				if(4)
					M.AddSkill(new/obj/Skills/AutoHit/HeartStab)
		if(3)
			src << "You feel yourself connect with the Cosmos further with your Diary"
		if(4)
			src << "You feel like the winner.. of the Survival Game.. The God Hood awaits you."

/// 
/// Skills / buffs
/// 

// main gimbo
/obj/Skills/Buffs/SpecialBuff/futureDiary
	ManaGlow="#e99cdf"
	ManaGlowSize = 1
	OffMult=1.1
	DefMult=1.1	
	SpecialSlot=1
	TextColor="#FE4B87"
	LockX=0
	LockY=0
	ActiveMessage="is filled with the future knowledge..!!"
	OffMessage="loses their control of the future..!!"
	name = "Future Diary"
	BuffName="Future Diary"
	Cooldown = 360
	verb/Future_Diary()
		set category="Skills"
		if(!usr.BuffOn(src))
			switch(usr.futureDiaryLevel)
				if(1)
					switch(usr.whichDiary)
						if(1)
							passives = list("Instinct" = 2, "Flow" = 2, getPassivesFutureDiary(usr) = 1)
						if(2)
							passives = list("Instinct" = 2, "Flow" = 3 )
						if(3)
							passives = list("Instinct" = 3, "Flow" = 2)
						if(4)
							passives = list("Instinct" = 2, "Flow" = 2, "Maimstrike" = 1)
				if(2)
					switch(usr.whichDiary)
						if(1)
							passives = list ("Instinct" = 2, "Flow" = 2, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1 )
						if(2)
							passives += list("Flow" = 4, "Godspeed" = 1, "Instinct" = 3)
						if(3)
							passives += list("LikeWater" = 3, "Godspeed" = 3, "Instinct" = 3, "Flow" = 2)
						if(4)
							passives += list("Instinct" = 2, "Flow" = 2, "Maimstrike" = 1, "Unstoppable" = 1)

				if(3)
					switch(usr.whichDiary)
						if(1)
							passives = list ("Instinct" = 3, "Flow" = 3, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1 )
						if(2)
							passives = list("Flow" = 4, "Godspeed" = 1, "Instinct" = 3,"CriticalChance" = 2, "TechniqueMastery" = 1)
						if(3)
							passives = list("LikeWater" = 3, "Godspeed" = 3, "Instinct" = 3, "Flow" = 2, "HolyMod" = 2)
						if(4)	
							passives = list("Instinct" = 2, "Flow" = 2, "Maimstrike" = 1, "Unstoppable" = 1, "AbyssMod" = 1)
				if(4)
					switch(usr.whichDiary)
						if(1)
							passives = list("GodKi" = 1, "Instinct" = 4, "Flow" = 4, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1, getPassivesFutureDiary(usr) = 1 )
						if(2)
							passives = list("GodKi" = 1,"Flow" = 4, "Godspeed" = 1, "Instinct" = 4,"CriticalChance" = 4, "TechniqueMastery" = 4)
						if(3)
							passives = list("GodKi" = 1, "LikeWater" = 3, "Godspeed" = 6, "Instinct" = 3, "Flow" = 2, "HolyMod" = 4, "LikeWater" = 3)
						if(4)	
							passives = list("GodKi" = 1, "Instinct" = 2, "Flow" = 4, "Maimstrike" = 1, "Unstoppable" = 3, "AbyssMod" = 3)
		src.Trigger(usr)
// maim strike knife move.
/obj/Skills/AutoHit/HeartStab
	SignatureTechnique=1
	Area="Strike"
	NeedsSword = 1
	EnergyCost = 15	
	StrOffense = 1
	DamageMult = 4
	MaimStrike = 4
	Instinct = 1
	SpeedStrike = 1
	HitSparkIcon = 'Hit Effect Ripple.dmi'
	HitSparkIcon = 'Hit Effect Ripple.dmi'
	HitSparkX =- 32
	HitSparkY =- 32
	HitSparkTurns = 0
	HitSparkSize = 1
	Cooldown = 120
	ActiveMessage = "begins to stab their opponent constantly against their chest!"
	verb/Heart_Stab()
		set category="Skills"
		usr.Activate(src)

// yuno gasai stuff.
/obj/Skills/Queue/LoveStab
	SignatureTechnique=1
	NeedsSword = 1
	HitMessage="lunges at their love-interest, stabbing them over and over again...!!"
	DamageMult = 2.5
	AccuracyMult = 1.175
	NoWhiff = 1
	MultiHit = 5
	Duration=5
	Instinct=2
	Warp=2
	Cooldown=120
	EnergyCost=5
	verb/Love_Stab()
		set category="Skills"
		usr.SetQueue(src)

// detective stuff here.
/obj/Skills/Projectile/DetectivesShot
	SignatureTechnique=1
	IconLock='Blast20.dmi'
	DamageMult=8
	Knockback=1
	Radius=1
	FireFromSelf=1
	FireFromEnemy=0
	Explode=3
	StrRate=1
	ForRate=1
	Dodgeable=-1
	Deflectable=-1
	HolyMod=10
	Distance=100
	Cooldown = 90
	verb/Detectives_Shot()
		set category="Skills"
		usr.UseProjectile(src)


///
/// Admin verbs..
/// 

/mob/Admin3/verb/Give_FutureDiary()
	set category = "Admin"
	var/mob/P = input(src, "Give Future Diary to who?") in players
	if (P.futureDiaryLevel < 4)
		levelUpDiary(P)
	else 
		usr << "They are at the max level."