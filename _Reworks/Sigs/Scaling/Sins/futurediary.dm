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
var/list/randomPassives = list("Flow" = 1, "PureDamage" = 1, 
"Godspeed" = 1, "Void" = 1, "NoWhiff" = 1, "HolyMod" = 1, "AbyssMod" = 1,
"Instinict " = 1, "VenomImmune" = 1, "CounterMaster" = 1, "TechniqueMastery" = 1,
"HybridStrike" = 1, "SpiritStrike" = 1, "Extend" = 1, "MovementMastery" = 1 )
mob/var/futureDiaryLevel = 0 // maxes out at 3.
mob/var/whichDiary /// 1, 2, 3, 4 look for above...


// PROCS

/////
///
/// 


obj/proc/getPassivesFutureDiary(var/mob/Player/M) // MC Passives.. 
	var/passiveList = list(null)
	switch(M.futureDiaryLevel)
		if(1)
			passiveList = pick(randomPassives)
		if(2)
			passiveList = pick(randomPassives)
			passiveList += pick(randomPassives)
		if(3)
			passiveList = pick(randomPassives)
			passiveList += pick(randomPassives)
			passiveList += pick(randomPassives)
		if(4)
			passiveList = pick(randomPassives)
			passiveList += pick(randomPassives)
			passiveList += pick(randomPassives)
			passiveList += pick(randomPassives)
			passiveList += pick(randomPassives)
			passiveList += pick(randomPassives)						
	return passiveList


mob/proc/levelUpDiary(mob/M)
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
/// 
/// Skills / buffs
/// 

// main gimbo
/obj/Skills/Buffs/SpecialBuff/futureDiary
	ManaGlow="#9ce9cb"
	OffMult=1.1
	DefMult=1.1	
	SignatureTechnique=1	
	TextColor="red"
	passives = list("Flow" = 1)
	ActiveMessage="begins to predict the future with their Diary...!!"
	OffMessage="relaxes their evolution..."
	BuffName="futureDiary"
	verb/futureDiary()
		set category="Skills"
		if(!usr.BuffOn(src))
			switch(usr.futureDiaryLevel)
				if(1)
					src.passives += list("Instinct" = 2, "Flow" = 2)
					switch(usr.whichDiary)
						if(1)
							src.passives += src.getPassivesFutureDiary()
						if(2)
							src.passives += list("Flow" = 1)
						if(3)
							src.passives += list("Instinict" = 1)
						if(4)
							src.passives += list("Maimstrike" = 1)
				if(2)
					switch(usr.whichDiary)
						if(1)
							src.passives += src.getPassivesFutureDiary()
						if(2)
							src.passives += list("Flow" = 2, "Godspeed" = 1, "Instinict" = 1)
						if(3)
							src.passives += list("LikeWater" = 3, "Godspeed" = 3)
						if(4)
							src.passives += list("Unstoppable" = 2)

				if(3)
					src.passives += list("Instinct" = 2, "Flow" = 2)
					switch(usr.whichDiary)
						if(1)
							src.passives += src.getPassivesFutureDiary()
						if(2)
							src.passives += list("CriticalChance" = 2, "TechniqueMastery" = 1)
						if(3)
							src.passives += list("HolyMod" = 2)
						if(4)	
							src.passives += list("AbyssMod" = 1)
				if(4)
					src.passives += list("GodKi" = 1)
					switch(usr.whichDiary)
						if(1)
							src.passives += src.getPassivesFutureDiary()
						if(2)
							src.passives += list("CriticalChance" = 4, "TechniqueMastery" = 2, "Flow" = 4, "Godspeed" = 2, "Instinict" = 2)
						if(3)
							src.passives += list("LikeWater" = 3, "Godspeed" = 3, "HolyMod" = 2)
						if(4)	
							src.passives += list("Unstoppable" = 2, "AbyssMod" = 2)

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
	verb/HeartStab()
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
	verb/The_Claw()
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