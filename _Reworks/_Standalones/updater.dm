/*

essentially check if we are -on update x, if not, update to x, if so, do nothing


*/

// make it so on world load we make the current version datum and use it for all people

/proc/generateVersionDatum()
	var/updateversion = "/datum/update/version[glob.UPDATE_VERSION]"
	glob.currentUpdate = new updateversion

/datum/globalTracker/proc/updatePlayer(mob/p)
	// essentially
	p << "[SYSTEM]UPDATING [SYSTEMTEXTEND]]"
	p<< "[SYSTEM]USER IS AT VERSION [p.updateVersion]] [SYSTEMTEXTEND]"
	p<< "[SYSTEM]CURRENT VERSION IS [UPDATE_VERSION]] [SYSTEMTEXTEND]"
	if(p.updateVersion + 1 == UPDATE_VERSION)
        // we dont need to generate new datums to update him
		var/updateversion = "/datum/update/version[p.updateVersion + 1]"
		var/datum/update/update = new updateversion
		update.updateMob(p)
	else
		for(var/x in 1 to abs(p.updateVersion - UPDATE_VERSION))
			// get the number of updates we are missing
			var/updateversion = "/datum/update/version[p.updateVersion + 1]"
			var/datum/update/update = new updateversion
			update.updateMob(p)
			del update // i guess loc = null doesn't work cause datums have no loc




/datum/globalTracker/var/UPDATE_VERSION = 6
/datum/globalTracker/var/tmp/datum/update/currentUpdate
// LETS HAVE EVERYONE BE 1

/mob/var/updateVersion = 1

/datum/update
    //XD

/datum/update/proc/updateMob(mob/p)
	p << "[SYSTEM] PLAYER [p] HAS UPDATED TO VERSION [version] ][SYSTEMTEXTEND]"
	p.updateVersion = version

/datum/update/var/version = 1
// a small package that just does a proc, i think thats bascially what we can do?


/datum/update/version2
	version = 2
	updateMob(mob/p)
		// essentially do the update needed her
		// for example, with the next thing we will be finding fiber stacks and reducing their asc giving power
		..()


/datum/update/version3
	version = 3
	updateMob(mob/p)
		// essentially do the update needed her
		// for example, with the next thing we will be finding fiber stacks and reducing their asc giving power
		..()

/datum/update/version4
	version = 4
	updateMob(mob/p)
		if(p.Race=="Eldritch")
			p.see_invisible = 0
			p << "You have lost the ability to innately see invisible people."
		..()
// works from what i can see


/datum/update/version5
	version = 5
	updateMob(mob/p)
		var/list/fencingStyles = list("Trinity", "Dual Wield", "Five Rings")
		if(!p.Saga)
			for(var/obj/Skills/Buffs/Styles/x in p)
				if(x.BuffName in fencingStyles)
					p << "[SYSTEM]has updated [x.BuffName] to count as a fencing style.] [SYSTEMTEXTEND]"

		if(p.Race=="Dragon")
			switch(p.Class)
				if("Metal")
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Dragons_Tenacity)
					p << "[SYSTEM]has added the skill Dragon's Tenacity to your Buffs.] [SYSTEMTEXTEND]"

				if("Fire")
					p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Heat_Of_Passion)
					p << "[SYSTEM]has added the skill Heat Of Passion to your Buffs.] [SYSTEMTEXTEND]"
					p.AngerPoint = 50
					p << "[SYSTEM]has set your anger point to 50.] [SYSTEMTEXTEND]"
					p.passive_handler.Increase("DemonicDurability", 1)
					p.passive_handler.Increase("SpiritHand", 1)
					p.MeltyBlood=1
					p.DemonicDurability=1
					if(p.AscensionsAcquired==1)
						p.AngerPoint = 55
						p.passive_handler.Increase("DemonicDurability", 0.25)
						p.passive_handler.Increase("SpiritHand", 1)
						p.passive_handler.Set("Desperation", 0)
						p.Desperation=0
					if(p.AscensionsAcquired==2)
						p.AngerPoint = 60
						p.passive_handler.Set("Desperation", 0)
						p.Desperation=0
						p.passive_handler.Increase("DemonicDurability", 0.25)
						p.passive_handler.Increase("SpiritHand", 1)


		if(p.Race=="Majin")
			if(p.AscensionsAcquired == 1)
				p.NewAnger(1.5, 1)
			if(p.AscensionsAcquired == 2)
				p.NewAnger(1.6, 1)
			switch(p.Class)
				if("Innocent")
					if(p.AscensionsAcquired>=1)
						p.Adaptation = 1
						p.passive_handler.Set("Adaptation", 1)
						p.passive_handler.Increase("CallousedHands", 0.15)
						if(p.AscensionsAcquired==2)
							p.passive_handler.Increase("CallousedHands", 0.15)

			var/newPickslist = list()
			if(length(p.majinPicks) > 0)
				for(var/pick in p.majinPicks)
					newPickslist = p.majinPicks["[pick]"]
			newPickslist = splittext(newPickslist, ",")
			if(length(newPickslist)> 0)
				switch(newPickslist[1])
					if("Harness Evil")
						switch(newPickslist[2])
							if("Anger")
								p.passive_handler.Increase("DemonicDurability", 0.25)
								if(p.AngerPoint >= 65)
									p.EndlessAnger = 1
							if("Both")
								p.passive_handler.Increase("DemonicDurability", 0.125)
								if(p.AngerPoint >= 65)
									p.EndlessAnger = 1
					if("Become Docile")
						switch(newPickslist[2])
							if("Stability")
								p.passive_handler.Increase("VenomResistance", 0.25)
								p.passive_handler.Increase("DebuffImmune", 0.25)
								p.DebuffImmune += 0.25
								p.VenomResistance += 0.25
							if("Peace")
								p.passive_handler.Increase("Flow", 0.25)
								p.passive_handler.Increase("DeathField", 0.15)
								p.passive_handler.Increase("VoidField", 0.15)
								p.Flow += 0.25
								p.VoidField += 0.15
								p.DeathField += 0.15
							if("Both")
								p.passive_handler.Increase("VenomResistance", 0.275)
								p.passive_handler.Increase("DebuffImmune", 0.275)
								p.DebuffImmune += 0.275
								p.VenomResistance += 0.275
								p.passive_handler.Increase("Flow", 0.275)
								p.passive_handler.Increase("DeathField", 0.2)
								p.passive_handler.Increase("VoidField", 0.2)
								p.Flow += 0.275
								p.VoidField += 0.2
								p.DeathField += 0.2


			var/adapt = 0
			for(var/x in 1 to p.majinPicks.len)
				if(p.majinPicks[x] == "Remain Consistent,Adaptability" || p.majinPicks[x] == "Remain Consistent,Both")
					adapt++
			if(adapt >= 2)
				p.passive_handler.Increase("StealsStats",p.AscensionsAcquired > 2 ? 0.1 : 0)
				p.StealsStats += p.AscensionsAcquired > 2 ? 0.1 : 0
			var/Peace = 0
			for(var/x in 1 to p.majinPicks.len)
				if(p.majinPicks[x] == "Become Docile,Peace" || p.majinPicks[x] == "Become Docile,Both")
					Peace++
			if(Peace >= 2 && !p.CalmAnger)
				p.CalmAnger = 1


		..()

/datum/update/version6
	version = 6
	updateMob(mob/p)
		p << "[SYSTEM]has removed all Anesthetics. They have been refunded at base price.] [SYSTEMTEXTEND]"
		for(var/obj/Items/Tech/Anesthetics/ans in p)
			p.GiveMoney(6000)
			del(ans)
		..()

/datum/update/version7
	version = 7
	updateMob(mob/p)
		switch(p.Race)
			if("Monster")
				if(p.Class == "Domination")
					var/asc = p.AscensionsAcquired
					p.IntimidationMult = 1+((asc)/10)
		..()

/datum/update/version8
	version = 8
	updateMob(mob/p)
		if(p.Race in list("Half Saiyan", "Saiyan"))
			if(p.Potential<45)
				if(p.ssj["unlocked"]>1)
					p.ssj["unlocked"]=1
					p.masteries["1mastery"]=100
					p.masteries["2mastery"]=0
		..()

/datum/update/version9
	version = 9
	updateMob(mob/p)
		for(var/obj/Items/Enchantment/Tome/T in p)
			if(T.suffix == "*Equipped*" || T.suffix)
				T.ObjectUse(p)
				T.suffix = ""
				if(length(T.Spells)>0)
					for(var/obj/Skills/spell in T.Spells)
						for(var/obj/Skills/ownerSpells in p)
							if(ownerSpells.type == spell.type)
								if(ownerSpells.Temporary)
									p.contents-=ownerSpells
									del ownerSpells
		..()

/datum/update/version10
	version = 10
	updateMob(mob/p)
		if(p.Race == "Monster")
			if(p.MonsterAscension == "Infernal")
				p.passive_handler.Decrease("DemonicDurability", 1*p.AscensionsAcquired)

				p<< "If your demonic dura is not 2.5 with no buffs on, please gmhelp."

		..()

/datum/update/version11
	version = 11
	updateMob(mob/p)
		if(p.Race == "Monster")
			if(p.Class == "Yokai")
				p.passive_handler.Decrease("TechniqueMastery", 4)
				p<< "If your TechniqueMastery is not 5.5 with no buffs on, please gmhelp."

		..()

/datum/update/version12
	version = 12
	updateMob(mob/p)
		if(p.Saga == "Ansatsuken" && p.AnsatsukenAscension == "Chikara")
			p<<"You have embraced the power of nothingness."
			p.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Kyoi_no_Hado)
		..()


/datum/update/version13
	version = 13
	updateMob(mob/p)
		if(p.Race == "Half Saiyan")
			if(p.AngerMax>=1.65)
				if(p.AscensionsAcquired>=3)
					switch(p.Class)
						if("Desperate")
							p.NewAnger(1.7, 1)
						if("Brutal")
							p.NewAnger(1.7, 1)
						if("Effecient")
							p.NewAnger(1.7, 1)

		if(p.Saga == "Cosmo")
			p.SenseUnlocked = 5
			p<<"Your sense unlocked is [p.SenseUnlocked]. If you logged in while powered up, or in seventh sense, please admin help."
		..()

/datum/update/version14
	version = 14
	updateMob(mob/p)
		if(p.Race == "Half Saiyan")
			if(p.AngerMax>=1.65)
				if(p.AscensionsAcquired>=3)
					switch(p.Class)
						if("Desperate")
							p.NewAnger(1.7, 1)
						if("Brutal")
							p.NewAnger(1.7, 1)
						if("Effecient")
							p.NewAnger(1.7, 1)
		if(p.Saga == "Unlimited Blade Works")
			p<< "You have been given the Unlimited Blade Works style."
			p.AddSkill(new/obj/Skills/Buffs/NuStyle/SwordStyle/Sword_Savant)
		..()

/datum/update/version15
	version = 15
	updateMob(mob/p)
		if(p.Saga=="Unlimited Blade Works")
			for(var/obj/Skills/Buffs/SlotlessBuffs/GaeBolg/GB)
				p.AddSkill(new/obj/Skills/Projectile/Zone_Attacks/Gae_Bolg)
		..()

/datum/update/version16
	version = 16
	updateMob(mob/p)
		for(var/obj/Skills/Buffs/x in p.Buffs)
			if(x.SignatureTechnique==3)
				var/n = x.BuffName
				if(n in list("Ripper Mode", "Ovedrive", "Armstrong Augmentation", "Ray Gear")) continue
				p.Buffs -= x
				del x
				p.SignatureSelected -= n
				p << "[SYSTEM]You have been refunded [n].] [SYSTEMTEXTEND]"

		..()

/datum/update/version17
	version = 17
	updateMob(mob/p)
		if(p.Saga == "Hiten Mitsurugi-Ryuu")
			for(var/obj/Skills/Buffs/NuStyle/SwordStyle/Hiten_Mitsurugi_Ryuu/hmr in p.contents)
				if(hmr.Finisher=="/obj/Skills/Queue/Finisher/True_Flash_Strike")
					hmr.Finisher="/obj/Skills/Queue/Finisher/Flash_Strike"
					p << "[SYSTEM]Your Finisher has moved to Tier 6. If you don't have your slotter, gmhelp [SYSTEMTEXTEND]"
		if(p.Race == "Half Saiyan")
			if(p.Class=="Brutal" && p.AscensionsAcquired == 3)
				for(var/obj/Skills/Buffs/x in p)
					if(p.BuffOn(x))
						x.Trigger(p, Override=1)
				if(p.passive_handler.Get("Brutalize")<=0)
					p.passive_handler.Set("Brutalize", 1)
					p << "[SYSTEM]You have been given the passive Brutalize.] [SYSTEMTEXTEND]"
				if(p.passive_handler.Get("KillerInstinct")<=0)
					p.passive_handler.Set("KillerInstinct", 0.15)
					p << "[SYSTEM]You have been given the passive Killer Instinct.] [SYSTEMTEXTEND]"
				if(p.Intimidation <= 24)
					p.Intimidation = 25
					p << "[SYSTEM]Your Intimidation has been set to 25.] [SYSTEMTEXTEND]"
				p << "[SYSTEM]Your Specialization now does more damage the more injuries your enemyies have.] [SYSTEMTEXTEND]"
		if(p.Race == "Monster"&& p.AscensionsAcquired == 3)
			for(var/obj/Skills/Buffs/x in p)
				if(p.BuffOn(x))
					x.Trigger(p, Override=1)
			switch(p.Class)
				if("Natural")
					switch(p.AscensionsAcquired)
						if(1)
							p.passive_handler.Set("BuffMastery", 0.5)
						if(2)
							p.passive_handler.Set("BuffMastery", 1)
						if(3)
							p.passive_handler.Set("BuffMastery", 1.2)
					p << "[SYSTEM]Your Buff Mastery has been buffed. If you have less than 1.2 and are asc 3, gm help. ] [SYSTEMTEXTEND]"
		..()
/datum/update/version18
	version = 18
	updateMob(mob/p)
		if(p.Race == "Monster")
			switch(p.MonsterAscension)
				if("Infernal")
					switch(p.AscensionsAcquired)
						if(2)
							p.passive_handler.Set("HellPower", 0.2)
						if(3)
							p.passive_handler.Set("HellPower", 0.4)
					p << "[SYSTEM]Your Hell Power has been nerfed. If you have less than (or more) 0.4 and are asc 3, gm help. ] [SYSTEMTEXTEND]"
		if(p.Class == "Saiyan")
			if(p.AscensionsAcquired == 4)
				p.NewAnger(2,1)
		..()