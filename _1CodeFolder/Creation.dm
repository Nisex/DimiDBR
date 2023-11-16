#define WIPE_TOPIC "https://docs.google.com/document/d/1dujhKyWu_HgQyvylRFHopFi-TSw_kfXAp-sw60Ss5Fc/edit?usp=sharing"
#define DISCORD_INVITE "https://discord.gg/aTeBebEB2g"
#define PATREON_LINK "https://patreon.com/jordanzoSupport"
#define KO_FI_LINK "https://ko-fi.com/boberjones"
#define DONATION_MESSAGE "<a href='[PATREON_LINK]'>Patreon (Monthly)</a> <a href='[KO_FI_LINK]'>Ko-Fi (One Time)</a>"
#define THANKS_MESSAGE_DONATOR(tier) "Thank you for supporting! You have Tier [tier] donator benefits!"
#define THANKS_MESSAGE_SUPPORTER(tier) "Thank you for supporting, you have tier [tier] supporter benefits!"




/mob/Players/proc/addMissingSkills()
	var/list/missingSkills = list(/obj/Communication, /obj/Skills/Meditate, /obj/Skills/Queue/Heavy_Strike, \
	/obj/Skills/Grab, /obj/Skills/Grapple/Toss, /obj/Skills/Dragon_Dash, /obj/Skills/Target_Clear, /obj/Skills/Target_Switch, \
	/obj/Skills/Reverse_Dash, /obj/Skills/Aerial_Payback, /obj/Skills/Aerial_Recovery, \
	/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Clash, /obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Clash_Defensive, \
	/obj/Skills/Buffs/Styles/Style_Selector)
	for(var/S in missingSkills)
		if(!locate(S, usr.contents))
			usr.AddSkill(new S)

/mob
	var/resetPU = TRUE
	var/resetPU1 = TRUE
	var/resetStats = TRUE
	var/massReset = TRUE
	var/totalRecall = 0
	var/godMakeItStop = TRUE
	var/list/OldLoc = list()
	var/mass_magic_reset = TRUE
	var/passive_overhaul = TRUE
	var/greatAngerRemoval = TRUE
	var/buffrework = TRUE
/var/list/Races_Changed = list()
/var/list/typesOfItemsRemoved = list(/obj/Items/Enchantment/Scrying_Ward, /obj/Items/Enchantment/Crystal_Ball, \
/obj/Items/Enchantment/Arcane_Mask, /obj/Items/Enchantment/Magic_Crest, /obj/Items/Enchantment/ArcanicOrb, \
/obj/Items/Enchantment/Teleport_Amulet, /obj/Items/Enchantment/Teleport_Nexus, /obj/Items/Enchantment/Dimensional_Cage, \
/obj/Items/Enchantment/PocketDimensionGenerator, /obj/Items/Enchantment/Crystal_of_Bilocation, \
/obj/Items/Enchantment/AgeDeceivingPills, /obj/Items/Enchantment/Phylactery, /obj/Items/Enchantment/Elixir_of_Reincarnation, \
/obj/Items/Enchantment/Time_Displacer)




/mob/proc/MagicCulling()
	for(var/obj/Items/x in src)
		if(x.type in typesOfItemsRemoved)
			src<<"<font face='courier'><font color='#color'>\[SYSTEM: The \[SYSTEM\] has removed your [x] please contact the \[SYSTEM\] for compensation. \]</font color></font face> "
			del(x)


/mob/proc/StandardizeAngerPoint()
	if(Race != "Dragon")
		AngerPoint=50
		src<< "<font face='courier'><font color='#color'>\[SYSTEM: Your \[CLASS\]'s Anger Point has been set to 50!\]</font color></font face> "

/mob/proc/AdjustJob()
	if(information.job != "Branch Director" && information.job == "Staff Member")
		information.job = "Unregistered"


/mob/proc/GiveJobVerbs()
	if(information.job == "Branch Director")
		verbs += /mob/proc/RegisterMember
		verbs += /mob/proc/ExchangeMinerals
	if(information.job == "Resource Manager")
		verbs += /mob/proc/ExchangeMinerals



mob/Players
	Login()
		client.perspective=MOB_PERSPECTIVE
		players += usr
		usr.density=1
		usr.client.view=8
		if(usr.Class=="Dance"||usr.Class=="Potara")
			usr.Savable=0

		else if(usr.Manufactured)
			usr.Savable=1
			usr.Redo_Stats()
			usr.EraAge=global.Era
			for(var/obj/Items/Tech/Android_Frame/A in world)
				if(A.Savable == src.ckey)
					del A
		else
			if(usr.Savable==0)
				usr.Savable=1
				usr.Finalize()
		if(!locate(/obj/Money) in src)
			src.contents += new/obj/Money
		usr.ssj["transing"]=0
		usr.trans["transing"]=0
		winshow(usr,"StatsWindow",0)
		winshow(usr,"StatsWindow2",0)
		for(var/e in list("Health","Energy","Power","Mana"))
			winset(src,"Bar[e]","is-visible=true")
		usr.client.show_verb_panel=1
		usr.Admin("Check")
		usr.overlays-='Emoting.dmi'
		if(!Mapper)
			for(var/obj/Skills/Fly/f in src)
				del f
		if(usr.calmcounter)
			usr.calmcounter=2

		for(var/obj/Items/I in usr)
			usr.AddItem(I, AlreadyHere=1)

		for(var/obj/Skills/S in usr)
			usr.AddSkill(S, AlreadyHere=1)

		if(src.RPPSpendable<0)
			src.RPPSpendable=0



		if(src.RPPSpendableEvent>0)
			src.RPPSpendableEvent=0
		if(RPPSpentEvent>0)
			loc = locate(0,0,0)
		if(src.RPPMult<1)
			src.RPPMult=1
		for(var/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm/da in src)
			if(src.Race=="Demon")
				da.name="Devil Arm ([src.TrueName])"


		var/obj/Items/Tech/protecc
		for(var/obj/Items/Tech/Anesthetics/ans in src)
			if(!protecc)
				protecc=ans
			else
				protecc.TotalStack++
				del ans


		addMissingSkills()
		if(glob.TESTER_MODE)
			giveTesterVerbs(src)
		if(!src.RewardsLastGained)//a clause for pretty much just androids
			src.RewardsLastGained=glob.progress.DaysOfWipe-1

		src.RegenMod="N/A"
		src.EnergyMod="N/A"
		src.RecovMod=2
		if(src.Race=="Human")
			src.RecovMod=2
			src.RecovAscension=0

		if(src.sig_reset<2)
			if(!src.Saga)
				src.SignatureSelected=list()
				for(var/obj/Skills/s in src)
					if(s.SignatureTechnique)
						if(istype(s, /obj/Skills/Buffs/NuStyle))
							continue
						if(istype(s, /obj/Skills/Buffs/SlotlessBuffs/Devil_Arm))
							continue
						if(istype(s, /obj/Skills/Buffs/SpecialBuffs/SuperSaiyanGrade2))
							continue
						if(istype(s, /obj/Skills/Buffs/SpecialBuffs/SuperSaiyanGrade3))
							continue
						del s

				src << "Your signatures have been reset."
			src.sig_reset=2
		if(src.zenkai_reset<2)
			if(src.Race=="Saiyan")
				if(src.ssj["unlocked"]>2)
					src.ssj["unlocked"]=2
					src << "Your SSj level has been reset to 2, and your masteries are undone."
				if(src.masteries["2mastery"]>50)
					src.masteries["2mastery"]=50
			src.zenkai_reset=2

		for(var/obj/Skills/Buffs/NuStyle/ns in src)
			var/obj/Skills/Buffs/NuStyle/Prime=ns
			for(var/obj/Skills/Buffs/NuStyle/ns2 in src)
				if(ns2==Prime)
					continue
				if(ns2.type==Prime.type)
					if(ns2.Mastery>Prime.Mastery)
						del Prime
					else
						del ns2
/*		if(src.Race=="Saiyan")
			for(var/obj/Skills/Buffs/b in src)
				if(b.SpecialSlot && !b.UnrestrictedBuff)
					if(src.CheckSpecial(b.BuffName))
						b.Trigger(src)
					del b*/
		if(sig_reset<3)
			if(src.PotentialRate>0)
				for(var/obj/Skills/Buffs/SlotlessBuffs/Sparking_Blast/sb in src)
					src << "Sparking Blast removed."
					del sb
				for(var/obj/Skills/Buffs/SlotlessBuffs/Unbound_Mode/sb in src)
					src << "Unbound Mode removed."
					del sb
				for(var/obj/Skills/Buffs/SlotlessBuffs/Legend_of_Black_Heaven/sb in src)
					src << "Legend of Black Heaven removed."
					del sb
				src.SignatureSelected.Remove("Sparking Blast")
				src.SignatureSelected.Remove("Unbound Mode")
				src.SignatureSelected.Remove("Legend of Black Heaven")
			sig_reset=3
		if(grimoire_reset<1)
			if(!src.Race=="Shinjin")
				if(locate(/obj/Skills/Utility/Grimoire_Arcana, src))
					for(var/obj/Skills/Utility/Grimoire_Arcana/ga in src)
						del ga
						src << "You have lost access to Grimoire Arcana."
				for(var/obj/Skills/Buffs/SlotlessBuffs/Grimoire/g in src)
					del g
				for(var/obj/Items/Gear/Pure_Grimoire/pa in src)
					del pa
				for(var/obj/Items/Gear/Prosthetic_Limb/Azure_Grimoire/ag in src)
					del ag
				for(var/obj/Items/Gear/Prosthetic_Limb/Blue_Grimoire/ag in src)
					del ag
				for(var/obj/Items/Gear/Crimson_Grimoire/cg in src)
					del cg
				for(var/obj/Items/Gear/Blood_Grimoire/bg in src)
					del bg
				for(var/obj/Skills/Queue/Ragna_Blade/rb in src)
					del rb
				for(var/obj/Skills/AutoHit/Giga_Slave/gs in src)
					del gs
				for(var/obj/Skills/Teleport/Traverse_Void/tv in src)
					del tv
				src << "You have lost access to any grimoires you had on you."
			grimoire_reset=1

		for(var/obj/Items/Enchantment/Magic_Crest/mc in src)
			for(var/obj/Skills/s in mc.Spells)
				if(s.Cooldown==-1)
					src << "[s] has been removed from your magic crest."
					mc.Spells.Remove(s)
				if(s.NoTransplant)
					src << "[s] has been removed from your magic crest."
					mc.Spells.Remove(s)

		if(src.Base!=glob.WorldBaseAmount)
			src.Base=glob.WorldBaseAmount

		if(src.NoSoul)
			src.NoSoul=0

		if(src.Potential<1)
			src.Potential=1
		src.potential_max()

		if(src.Imagination<=0)
			if(src.Race=="Android")
				src.Imagination=0.05
			else
				src.Imagination=0.25
		if(src.Intelligence<=0)
			src.Intelligence=0.25

		for(var/obj/Skills/Buffs/NuStyle/s in src)
			src.StyleUnlock(s)


		for(var/obj/Items/e in src)
			if(e.name=="" || e.name==null || !e.name)
				e.name="Item"

		src.potential_gain(0, npc=0)//set status message.

		for(var/obj/Items/Enchantment/Crystal_Ball/cb in src)
			if(cb.suffix)
				cb.suffix=null
				Reset_Overlays()

		//stop holding zanzo charges
		if(usr.ActiveZanzo)
			usr.ActiveZanzo=0
		for(var/obj/Skills/Zanzoken/z in usr)
			z.ZanzoAmount=0

		if(updateVersion != glob.UPDATE_VERSION)
			glob.updatePlayer(src)



		if(buffrework)
			for(var/obj/Skills/Buffs/B in src)
				if(src.BuffOn(B))
					B.Trigger(src, Override = 1)
			SlotlessBuffs = list()
			buffrework = FALSE


		if(Race=="Makyo"&&AngerMax == 1.3)
			AngerMax = 1.5
			src << "[SYSTEM]LUMINERE has receieved a ANGER BUFF to 1.5x."

		if(godMakeItStop)
			// adjust all recoveries changed
			var/textString = "[SYSTEM]ADMIN has adjusted CLASS: "
			for(var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/f in src)
				f.Cooldown = 0
			src << "[SYSTEM]Finishers can be used more than once per fight now.[SYSTEMTEXTEND]"
			src << "[SYSTEM]ADMIN has adjusted TECHNOLOGY TREE. ADMIN HELP for REFUND.[SYSTEMTEXTEND]"
			for(var/obj/Skills/Utility/Seal_Turf/s in src)
				if(src.key == "MayaWinky")
					src<<"You are allowed to have Seal Turf. It was not removed."
					continue
				del s
			src << "[SYSTEM]has removed SEAL_TURF after PLAYERS were ABUSING it. It is now APPLICATION ONLY[SYSTEMTEXTEND]"
			if(Race == "Majin")
				textString += "Dokkaebei"
				for(var/obj/Regenerate/r in src)
					del r
				if(Adaptation)
					Adaptation=0
					textString += "...Adaptation pushed to 1st ASCENSION."
				src<< "[textString][SYSTEMTEXTEND]"
				src << "[SYSTEM]ADMIN has adjusted CLASS: Majin...Recovery set to 2"
			if(Race == "Human")
				src << "[textString]Human... Recovery set to 2"
				src << "[SYSTEM]ADMIN has adjusted CLASS: Human... increased Injury recovery, depending on Injury amount.[SYSTEMTEXTEND]"
			godMakeItStop = FALSE


		if(greatAngerRemoval)
			for(var/obj/Items/Tech/Anesthetics/a in src)
				del a
			src << "[SYSTEM]ADMIN has increased ANESTHETICS PRICE. ALL FOUND HAVE BEEN REMOVED, PLEASE MAKE MORE.[SYSTEMTEXTEND]"
			greatAngerRemoval = FALSE

		if(passive_overhaul&&!passive_handler)
			passive_handler=new
			for(var/obj/Skills/Buffs/B in src)
				if(src.BuffOn(B))
					B.Trigger(src)
			if(EquippedSword())
				var/obj/Items/Sword/s = EquippedSword()
				s.suffix = ""
			for(var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/ki in src.contents)
				switch(ki.selectedPassive)
					if("Flicker")
						ki.passives = list("Flicker"=1, "KiControl" = 1, "EnergyLeak" = 1)
					if("Godspeed")
						ki.passives = list("Godspeed"=1, "KiControl" = 1, "EnergyLeak" = 1)
					if("Pursuer")
						ki.passives = list("Pursuer"=1, "KiControl" = 1, "EnergyLeak" = 1)
			if(Potential>=5)
				passive_handler.Set("KiControlMastery", 1)
			if(Potential>=15)
				passive_handler.Set("KiControlMastery", 2)
			if(Saga)
				switch(Saga)
					if("Cosmo")
						passive_handler.Increase("KiControlMastery")
					if("Hiten Mitsurugi-Ryuu")
						if(SagaLevel >= 2)
							passive_handler.Increase("SlayerMod", 0.625)
							passive_handler.Increase("Pursuer", 0.5)
							passive_handler.Increase("SuperDash", 0.25)
							passive_handler.Increase("Godspeed", 0.25)
						if(SagaLevel >= 3)
							passive_handler.Increase("SlayerMod", 0.625)
							passive_handler.Increase("Pursuer", 0.5)
							passive_handler.Increase("SuperDash", 0.25)
							passive_handler.Increase("Godspeed", 0.25)
						passive_handler.Increase("SlayerMod", 0.625)
						passive_handler.Increase("Pursuer", 0.5)
						passive_handler.Increase("SuperDash", 0.25)
						passive_handler.Increase("Godspeed", 0.25)
					if("Ansatsuken")
						if(SagaLevel >= 2)
							passive_handler.Increase("SlayerMod",0.25)
						if(SagaLevel >= 3)
							passive_handler.Increase("SlayerMod",0.25)
						passive_handler.Increase("SlayerMod",0.625)
					if("Weapon Soul")
						if(SagaLevel >=3)
							if(TechniqueMastery&&!Flow)
								passive_handler.Increase("TechniqueMastery", 3)
							else if(Flow&&!TechniqueMastery)
								passive_handler.Increase("Instinct")
								passive_handler.Increase("Flow")
			switch(Race)
				if("Saiyan")
					if(AscensionsAcquired >= 1)
						Intimidation = 10


				if("Makyo")
					if(AscensionsAcquired >= 1)
						Intimidation = 5
						passive_handler.Increase("Juggernaut", 0.25)
				if("Human")
					passive_handler.Increase("Desperation", 1)
					passive_handler.Increase("Adrenaline", 0.5)
					passive_handler.Increase("TechniqueMastery", 5)
					CyberizeMod = 0
					if(HumanAscension == "Technology")
						CyberizeMod = 0.5
					if(AscensionsAcquired >= 1)
						passive_handler.Decrease("TechniqueMastery", 1)
						passive_handler.Increase("Desperation", 1.5)
						passive_handler.Increase("Adrenaline", 1)
						switch(HumanAscension)
							if("Human Spirit")
								passive_handler.Increase("DemonicDurability", 1)
				if("Half Saiyan")
					if(AscensionsAcquired >= 1)
						switch(Class)
							if("Desperate")
								passive_handler.Increase("Desperation", 2)
								passive_handler.Increase("Adrenaline", 0.5)
								NewAnger(1.5)
							if("Effecient")
								passive_handler.Increase("Desperation", 1.5)
								passive_handler.Increase("TechniqueMastery", 1.5)
							if("Brutal")
								passive_handler.Increase("Desperation", 1)
				if("Namekian")
					if(Class=="Warrior")
						Intimidation = 10

					if(Class=="Enchanter")
						passive_handler.Increase("ManaCapMult", 1)
				if("Monster")
					switch(Class)
						if("Yokai")
							if(AscensionsAcquired>=1)
								passive_handler.Increase("ManaCapMult", 0.25)
								passive_handler.Increase("TechniqueMastery", 2)
						if("Eldritch")
							passive_handler.Increase("SpaceWalk", 1)
							if(AscensionsAcquired>= 1)
								passive_handler.Increase("DebuffImmune", 0.25)
								passive_handler.Increase("VenomResistance", 0.5)
								passive_handler.Increase("Void", 1)
								passive_handler.Increase("SoulFire", 0.2)
								passive_handler.Increase("DeathField",0.15)
								passive_handler.Increase("VoidField",0.15)
					if(AscensionsAcquired>=1)
						Intimidation = 10
						switch(MonsterSource)
							if("Domination")
								passive_handler.Increase("Steady", 0.5)
								passive_handler.Increase("HeavyHitter", 0.25)
								passive_handler.Increase("HellRisen", 0.25)
							if("Determination")
								passive_handler.Increase("Desperation",0.5)
						switch(MonsterAscension)
							if("Celestial")
								passive_handler.Increase("HolyMod", 1)
								passive_handler.Increase("MovementMastery", 2)
							if("Natural")
								passive_handler.Increase("BuffMastery", 0.3)
								passive_handler.Increase("LegendaryPower", 0.2)
							if("Infernal")
								passive_handler.Increase("AbyssMod", 1)
								passive_handler.Increase("DemonicDurability", 1)
				if("Shinjin")
					if(SpiritPower)
						passive_handler.Increase("SpiritPower", 1)
						passive_handler.Increase("CalmAnger", 1)
					if(HellPower)
						passive_handler.Increase("HellPower", 1)
						passive_handler.Increase("StaticWalk", 1)
					switch(Class)
						if("South")
							passive_handler.Increase("WalkThroughHell", 1)
						if("East")
							passive_handler.Increase("SpaceWalk", 1)
						if("West")
							passive_handler.Increase("WaterWalk",1)
				if("Majin")
					if(majinAbsorb)
						if(majinAbsorb.absorbCount > 0)
							findAlteredVariables()

					passive_handler.Increase("StaticWalk", 1)
					switch(Class)
						if("Innocent")
							passive_handler.Increase("DemonicDurability", 1)
							if(AscensionsAcquired>=1)
								passive_handler.Increase("Blubber")
						if("Super")
							passive_handler.Increase("Steady", 1)
							if(AscensionsAcquired>=1)
								passive_handler.Increase("FluidForm")
						if("Unhinged")
							if(AscensionsAcquired>=1)
								passive_handler.Increase("UnhingedForm")
							passive_handler.Increase("Adrenaline", 1)
							passive_handler.Increase("Hustle", 1)

				if("Dragon")
					passive_handler.Increase("DebuffImmune", 1)
					switch(Class)
						if("Metal")
							if(AscensionsAcquired>=1)
								Intimidation = 30
								passive_handler.Increase("Juggernaut")
								passive_handler.Increase("Unstoppable", 0.25)
								passive_handler.Increase("HeavyHitter", 0.5)
								passive_handler.Increase("DeathField", 0.25)
							passive_handler.Increase("Hardening", 1)

			passive_overhaul = FALSE

		if(isplayer(src))
			move_speed = MovementSpeed()

		fixTitle()

		if(mass_magic_reset)
			refundAllMagic()
			removeAllTomes()
			refundOldMagicShit()
			mass_magic_reset = FALSE
		if(massReset)
			MagicCulling()
			AdjustJob()
			StandardizeAngerPoint()
			massReset = FALSE
		GiveJobVerbs()
		// if(RewardsLastGained > 100)
		// 	Respec1()
		// 	quickDirtyRefund()
		// 	setStartingRPP()
		setMaxRPP()
		fixRewardLastGained()
		//automation
		src.reward_auto()//checks to see if its been a day

		if(locate(/obj/Skills/Buffs/ActiveBuffs/Ki_Control, src) && (resetPU||resetPU1))
			for(var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/ki in src)
				del ki
			src.PoweredFormSetup()
		if(RPPSpent<0)
			src<<"RPPSpent was negative, resetting to 0"
			RPPSpent=0

		if(resetStats && Race in Races_Changed)
			src<<"Your race was recently changed, your stats have been reset."
			Redo_Stats()
			resetStats=FALSE

		if(!killed_AI)
			killed_AI = list()

		if(last_online)
			var regen_time = (world.realtime - last_online)/10 //Seconds.
			if((TotalInjury + TotalFatigue + TotalCapacity) >= 10)
				usr << "You have been offline for [round(((world.realtime - last_online)/10)/60)] minutes. Your wound timer, injury, capacity, and fatigue have been restored accordingly."
			var/purerpmode
			if(regen_time >= 3600)
				purerpmode=PureRPMode
				PureRPMode=0
			Recover("Injury", regen_time)
			Recover("Fatigue", regen_time)
			Recover("Capacity", regen_time)

			if(regen_time >= 3600)
				PureRPMode=purerpmode

			OverClockTime = max(1, OverClockTime - regen_time)
			BPPoisonTimer = max(1,BPPoisonTimer - regen_time)

			var/food_time=0
			var/was_drunk=0
			if(src.Satiated)
				if(src.Satiated>=regen_time)
					src.Satiated-=regen_time
					food_time=regen_time
				else
					food_time=src.Satiated
					src.Satiated=0
					if(src.Drunk)
						was_drunk = 1
						src.Drunk=0
				if(!was_drunk)
					BPPoisonTimer = max(1,BPPoisonTimer - food_time)
					if(src.StrTax)
						src.SubStrTax(0.25/RawDays(1)*food_time, Forced=1)
					if(src.EndTax)
						src.SubEndTax(0.25/RawDays(1)*food_time, Forced=1)
					if(src.SpdTax)
						src.SubSpdTax(0.25/RawDays(1)*food_time, Forced=1)
					if(src.ForTax)
						src.SubForTax(0.25/RawDays(1)*food_time, Forced=1)
					if(src.OffTax)
						src.SubOffTax(0.25/RawDays(1)*food_time, Forced=1)
					if(src.DefTax)
						src.SubDefTax(0.25/RawDays(1)*food_time, Forced=1)
					if(src.RecovTax)
						src.SubRecovTax(0.25/RawDays(1)*food_time, Forced=1)
			if(regen_time>food_time)
				regen_time-=food_time
				if(src.StrTax)
					src.SubStrTax(0.25/RawDays(1)*regen_time)
				if(src.EndTax)
					src.SubEndTax(0.25/RawDays(1)*regen_time)
				if(src.SpdTax)
					src.SubSpdTax(0.25/RawDays(1)*regen_time)
				if(src.ForTax)
					src.SubForTax(0.25/RawDays(1)*regen_time)
				if(src.OffTax)
					src.SubOffTax(0.25/RawDays(1)*regen_time)
				if(src.DefTax)
					src.SubDefTax(0.25/RawDays(1)*regen_time)
				if(src.RecovTax)
					src.SubRecovTax(0.25/RawDays(1)*regen_time)

			last_online = world.realtime

		if(usr.passive_handler.Get("GiantForm"))
			if(usr.appearance_flags<512)
				usr.appearance_flags+=512
		if(global.ContractBroken)
			if(usr.ckey in ContractBroken)
				usr << "One of your contracts was broken while you were asleep!"
				usr.SummonContract--
				global.ContractBroken.Remove(usr.ckey)
		for(var/obj/Skills/Buffs/b in usr.Buffs)
			if(!b.BuffName)
				b.BuffName="[b.name]"

		for(var/obj/Skills/Projectile/_Projectile/PS in src)
			del PS

		if(src.ModifyBaby)
			src.ModifyBaby=0
		if(src.ModifyEarly)
			src.ModifyEarly=0
		if(src.ModifyPrime)
			src.ModifyPrime=0
		if(src.ModifyLate)
			src.ModifyLate=0
		if(src.ModifyPrime)
			src.ModifyPrime=0

		if(src.Class=="Dance"||src.Class=="Potara")
			src.Timeless=1

		var/Dif=global.Era-src.EraAge

		if(icon_state == "KB")
			icon_state = ""

		if(!src.Timeless)
			if(src.Dead&&!src.DeadTime)
				src.DeadAge=Dif
				src.DeadTime=global.Era
			if(src.DeadAge)
				if(src.Dead)
					src.EraAge=global.Era-src.DeadAge
					Dif=global.Era-src.EraAge
				else
					src.DeadAge=0

			var/CurrentBody=src.EraBody
			var/Message
			//EraAge only tracks what era the person was born in; it does not move
			//global Era WILL move.
			if(Dif>=0&&(Dif-ModifyBaby)<1)
				src.EraBody="Child"
				Message="You are considered a child.  You're quite weak, but at least you have a long life ahead of you!"
				if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
					src.Tail(1)
			if((Dif-ModifyBaby)>=1&&(Dif-(ModifyBaby+ModifyEarly))<2)
				src.EraBody="Youth"
				Message="You are now considered a youth.  You're able to access more of your power, but your full potential hasn't been unleashed yet!"
				if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
					src.Tail(1)
			if((Dif-(ModifyBaby+ModifyEarly))>=2&&(Dif-(ModifyBaby+ModifyEarly+ModifyPrime))<4)
				src.EraBody="Adult"
				Message="You are now an adult, and you are able to access your full power!"
			if((Dif-(ModifyBaby+ModifyEarly+ModifyPrime))>=4&&(Dif-(ModifyBaby+ModifyEarly+ModifyPrime+ModifyLate))<5)
				src.EraBody="Elder"
				if(!locate(/obj/Skills/Utility/Teachz, src))
					src.AddSkill(new/obj/Skills/Utility/Teachz)
					src << "You can now teach those younger than you!"
				Message="You are now considered elderly and have permission to teach your techniques.  In just a few more years, you'll be reaching the end of your lifespan..."
			if((Dif-(ModifyBaby+ModifyEarly+ModifyPrime+ModifyLate))>=5)
				src.EraBody="Senile"
				Message="You have entered your last years of life."
				if(!locate(/obj/Skills/Utility/Teachz, src))
					src.AddSkill(new/obj/Skills/Utility/Teachz)
					src << "You can now teach those younger than you!"
			if((Dif-(ModifyBaby+ModifyEarly+ModifyPrime+ModifyLate+ModifyFinal))>=5)
				if(!src.EraDeathClock&&!src.Immortal)
					var/DeathClock=Day(7+GoCrand(0,1))
					var/DeathClockAdjustment=(Dif-5)
					if(DeathClockAdjustment>=0)
						DeathClock/=(5**DeathClockAdjustment)
					src.EraDeathClock=world.realtime+DeathClock
					Message+="<br><b>You will die from old age soon. Use your remaining time well.</b>"
			if(CurrentBody!=src.EraBody)
				src << Message
				if(src.EraBody=="Elder")
					src.RPPDonate=(src.RPPSpendable+src.RPPSpent)/4
				if(src.EraBody=="Senile")
					src.RPPDonate+=(src.RPPSpendable+src.RPPSpent)/2
		else
			if(Dif>=4)
				if(!locate(/obj/Skills/Utility/Teachz, src) && !(src.Class in list("Dance","Potara")) )
					src.AddSkill(new/obj/Skills/Utility/Teachz)
					src.RPPDonate+=(src.RPPSpendable+src.RPPSpent)/4
					src << "You can now teach those younger than you!"

		if(src.ParasiteCrest())
			var/obj/Items/Enchantment/Magic_Crest/mc=src.EquippedCrest()
			if(!mc.CrestMadeAge)
				mc.CrestMadeAge=global.Era
			if(global.Era > mc.CrestMadeAge)
				OMsg(src, "[src] struggles as their cursed crest begins to consume them!")
				spawn(66)
					src.Death(null, "being consumed by their cursed crest!", SuperDead=99)
					src.Reincarnate()

		src.SetCyberCancel()
		src.AppearanceOn()

		if(src.EnergyMax!=100)
			src.EnergyMax=100

		if(!src.MobColor)
			src.MobColor=list(1,0,0, 0,1,0, 0,0,1, 0,0,0)

		if(usr.Flying==null)
			usr.Flying=0

		for(var/obj/Regenerate/R in usr)
			if(R.X&&R.Y&&R.Z)
				spawn()
					Regenerate(R)
			break

		// mainLoop += src
		gain_loop.Add(src)
		var/list/lol=list("butt3","butt4")
		for(var/x in lol)
			winset(src,x,"'is-visible'=true")
		if(ScreenSize)
			src.client.view=ScreenSize


		if(usr.SenseRobbed>=5)
			animate(usr.client, color = list(-1,0,0, 0,-1,0, 0,0,-1, 1,1,1))

		if(src.StasisSpace)
			spawn()animate(src.client, color = list(-1,0,0, 0,-1,0, 0,0,-1, 0,1,1))

		spawn()src.FlickeringGlow(src)
		spawn()src.WindupGlow(src)
		var/obj/Items/Sword/sord
		for(var/obj/Items/Sword/s in src)
			if(s.suffix=="*Equipped*")
				sord=s
				break
		if(sord)
			equippedSword = sord

		var/obj/Items/Armor/armr
		for(var/obj/Items/Armor/s in src)
			if(s.suffix=="*Equipped*")
				armr=s
				break
		if(armr)
			equippedArmor = armr

		var/obj/Items/WeightedClothing/wght
		for(var/obj/Items/WeightedClothing/s in src)
			if(s.suffix=="*Equipped*")
				wght=s
				break
		if(wght)
			equippedWeights = wght
		src.CheckWeightsTraining()
		src.IgnoreFlyOver=0

		if(Secret == "Vampire")
			//TODO add blood hud here
			Secret = "Vampire"


		if(AllowObservers)
			winshow(src, "WatchersLabel",1)
		if(PureRPMode)
			if(Secret == "Vampire")
				secretDatum.secretVariable["LastBloodGain"] = world.time
			for(var/obj/Skills/s in src)
				if(s.cooldown_remaining)
					s.Using=1
		else
			if(Secret == "Vampire")
				secretDatum.secretVariable["LastBloodGain"] = 0
			for(var/obj/Skills/s in src)
				s.cooldown_remaining=0
				s.cooldown_start=0
		for(var/obj/Redo_Stats/r in src)
			if(r.LoginUse) r.RedoStats(src)
		if(locate(/obj/Skills/Companion/arcane_follower) in src) is_arcane_beast = locate(/obj/Skills/Companion/arcane_follower) in src
		for(var/obj/Items/Tech/Vessel/v in world)
			if("[ckey] [EnergySignature]" in v.occupants) v.AddOccupant(src)
		for(var/obj/Items/i in src.contents)
			if(!i.LegendaryItem && i.Augmented)
				if(i.suffix=="*Equipped*" && i.Techniques.len > 0)
					for(var/obj/Skills/x in i.Techniques)
						src.AddSkill(x)
						if(istype(x, /obj/Skills/Buffs/SlotlessBuffs/Augmented_Gear))
							x.verbs -= list(/obj/Skills/Buffs/SlotlessBuffs/Augmented_Gear/verb/Augmented_Gear)
							x.verbs += new /obj/Skills/Buffs/SlotlessBuffs/Augmented_Gear/verb/Augmented_Gear(x, x?:BuffName)
						if(istype(x, /obj/Skills/Buffs/SlotlessBuffs/Posture))
							x.verbs -= list(/obj/Skills/Buffs/SlotlessBuffs/Posture/verb/Posture)
							x.verbs += new /obj/Skills/Buffs/SlotlessBuffs/Posture/verb/Posture(x, x?:BuffName)

		if(src.AFKTimer==0)
			src.overlays+=src.AFKIcon

		return
	Logout()
		players -= src
		if(dancing) transform=dancing
		last_online = world.realtime
		gain_loop.Remove(src)


		// mainLoop -= src



		for(var/mob/Player/AI/p in ai_followers)
			p.EndLife()
			ai_followers -= p
		if(src.party)
			src.party.remove_member(src)
		..()
		for(var/obj/Skills/s in src)
			s.AssociatedLegend = null
			s.AssociatedGear = null
			s.loc = null
			DeleteSkill(s, 1)
		for(var/i in vis_contents)
			vis_contents -= i
		for(var/obj/Items/ite in src)
			Items.Remove(ite)
			del ite
		companion_ais.Remove(src)
		transform = null
		filters = null
		Hair = null
		Target = null
		GlobalCooldowns = null
		SkillsLocked = null
		OldLoc = null
		passive_handler = null
		Splits = null
		information = null
		secretDatum = null
		MonkeySoldiers = null
		knowledgeTracker = null
		Items = null
		equippedSword = null
		equippedArmor = null
		equippedWeights = null
		overlays = null
		underlays = null
		if(BeingObserved.len>0)
			for(var/mob/p in BeingObserved)
				Observify(p,p)
		if(BeingTargetted.len>0)
			for(var/mob/p in BeingTargetted)
				p.RemoveTarget()
		if(active_projectiles.len>0)
			for(var/obj/Skills/Projectile/_Projectile/p in active_projectiles)
				p.endLife()
		src.loc = null
		del(usr)



mob/Creation
	Login()
		client.perspective=MOB_PERSPECTIVE | EDGE_PERSPECTIVE
		usr.client.view=8
		usr<<browse("[basehtml][Notes]")
		if(copytext(usr.key,1,6)=="Guest")
			usr<<"Guest keys are disabled at this time, please login using a real key!"
			del(usr)

		for(var/e in list("Health","Energy","Power","Mana"))
			winset(src,"Bar[e]","is-visible=false")
		usr.CheckPunishment("Ban")
		usr.Gender="Male"
		if(usr.gender=="female")
			usr.Gender="Female"
		for(var/W in list("Grid1","Grid2","Finalize_Screen","Race_Screen"))
			winshow(usr,"[W]",0)
		usr.Admin("Check")

		usr<<"<font color='red'><b>READ THIS BEFORE PLAYING:</b></font>"
		usr<<"Wipe Topic: <a href='[WIPE_TOPIC]'>Click Here</a>"
		usr<<"We have a Discord server at: [DISCORD_INVITE]"
		usr<<"Donate Here: <a href='[PATREON_LINK]'>Patreon (Monthly)</a> <a href='[KO_FI_LINK]'>Ko-Fi (One Time)</a>"
		if(donationInformation.getDonator(key=key))
			usr<<"[THANKS_MESSAGE_DONATOR(donationInformation.getDonator(key=key).getTier())]"
		if(donationInformation.getSupporter(key=key))
			usr<<"[THANKS_MESSAGE_SUPPORTER(donationInformation.getSupporter(key=key).getTier())]"
		usr<<"<br><font color=#FFFF00>Welcome to [world.name]!"
		usr<<"<b><small>Click the title screen to continue...</b><br>"
		if(glob.TESTER_MODE)
			usr<<"<font color=red><b>TESTER MODE IS ENABLED!</b></font>"
		usr.loc=locate(1,7,1)

	Logout()
		..()
		del(usr)





mob/var/tmp/race_selecting = 1
mob/Creation/verb
	RaceShift(var/blah as text)
		set hidden=1
		set name=".RaceShift"
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(!race_selecting)
			return
		if(blah=="+")
			UpdateRaceScreen("Race","+")
		if(blah=="-")
			UpdateRaceScreen("Race","-")
	IconSelect()
		set hidden=1
		set name=".Select_Icon"
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(usr.Race=="Human"||usr.Race=="Saiyan"||usr.Race=="Tuffle"||usr.Race=="Half Saiyan")
			usr.Grid("CreationHuman")
		else if(usr.Race=="Namekian")
			usr.Grid("CreationNamekian")
		else if(usr.Race=="Changeling")
			usr.Grid("CreationChangeling")
		else if(usr.Race=="Alien"||usr.Race=="Monster"||Race=="Majin")
			usr.Grid("CreationAlien")
		else if(usr.Race=="Demon")
			usr.Grid("CreationDemon")
		else if(usr.Race=="Makyo")
			usr.Grid("CreationMakyo")
		else if(usr.Race=="Shinjin")
			usr.Grid("CreationKaio")
		else if(usr.Race=="Android")
			usr.Grid("CreationAndroid")
		else if(usr.Race=="Monster"&&usr.Class=="Eldritch")
			usr.icon='Octopus Type.dmi'
		else
			if(!usr.icon)
				usr.icon='MaleLight.dmi'
	PlanetShift(var/blah as text)
		set hidden=1
		set name=".PlanetShift"
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(!race_selecting)
			return
		if(blah=="+")
			UpdateRaceScreen("Planet","+")
		if(blah=="-")
			UpdateRaceScreen("Planet","-")

	NextStep()
		set hidden=1
		set name=".Next_Step"
		if(!race_selecting)
			return
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		race_selecting=0
		if(usr.Race=="Android")
			var/Choice
			var/list/Androids=list("Cancel")
			for(var/obj/Items/Tech/Android_Frame/A in world)
				if(A.Savable == usr.ckey)
					Choice = A
					break
				if(A.invisibility<=0&&A.CreatorKey)
					Androids.Add(A)
			if(!Choice)
				if(Androids.len<2)
					usr << "There are no free frames in the world."
					del usr
					return
				Choice = input("There are free Android frames in the world; would you like to activate one of them?","Android Activation") in Androids
				if(Choice!="Cancel")
					if(Choice:Password)
						var/Pass=input(usr, "This item is protected by a password; you have to provide it before inhabiting it.", "Remove Safety") as text
						if(Choice:Password!=Pass)
							usr << "That is not the correct password."
							del usr
							return
					usr.loc=Choice:loc
					usr.name=Choice:name
					usr.icon=Choice:icon
					usr.icon_state=Choice:icon_state
					usr.AscensionsUnlocked=Choice:Level
					usr.Manufactured=1
					del Choice
				else
					del usr
					return
		winshow(usr,"Race_Screen",0)
		winshow(usr,"Finalize_Screen",1)
		usr.RacialStats()
		usr.UpdateBio()
		usr<<output(usr, "IconUpdate:1,[usr]")
		spawn()
			Namez//label
			src.name=html_encode(copytext(input(src,"Name? (25 letter limit)"),1,25))
			while(sanatizeName(name))
				src<<"Your name contains illegal characters. Please try again."
				src.name=html_encode(copytext(input(src,"Name? (25 letter limit)"),1,25))
			if(!src.name)
				goto Namez
				return
			if(findtext(name,"\n"))
				world<<"[key] ([client.address]) tried to use their name to spam. They were booted."
				del(src)
				return
			usr.UpdateBio()
proc/sanatizeName(n)
	var/list/nonos = list("http", ":/", ":", "<html>", "html","<font>", ".com", "www.", ".org", ".net")
	for(var/x in nonos)
		if(findtext(n, x))
			return 1
	return 0

mob/Creation/proc
	NextStep2(mob/usrr)
		set hidden=1
		set name=".Next_Step2"
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(!usrr.race_selecting)
			return
		if(!usrr)
			usrr=usr
		usrr.race_selecting=0
		winshow(usrr,"Race_Screen",0)
		winshow(usrr,"Finalize_Screen",1)
		usrr.UpdateBio()
		usrr.RacialStats()
		usrr.UpdateBio()
		usrr<<output(usr, "IconUpdate:1,[usrr]")
		spawn()
			Namez//label
			usrr.name=html_encode(copytext(input(usrr,"Name? (25 letter limit)"),1,25))
			while(sanatizeName(usrr.name))
				usrr<<"Your name contains illegal characters. Please try again."
				usrr.name=html_encode(copytext(input(usrr,"Name? (25 letter limit)"),1,25))
			if(!usrr.name)
				goto Namez
				return
			if(findtext(usrr.name,"\n"))
				world<<"[usrr.key] ([usrr.client.address]) tried to use their name to spam. They were booted."
				del(usrr)
				return
			usrr.UpdateBio()

mob/Creation/verb
	AbortingCC()
		set hidden=1
		set name=".Aborting_CC"
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(race_selecting)
			return
		verb_delay=world.time+1
		race_selecting=1
		winshow(usr,"Race_Screen",1)
		winshow(usr,"Finalize_Screen",0)
		spawn()
			usr.UpdateRaceScreen()
	ToggleBlah(var/blah as text)
		set name=".ToggleBlah"
		set hidden=1
		if(race_selecting)
			return
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(blah=="Name")
			Namez
			src.name=html_encode(copytext(input(src,"Name? (25 letter limit)"),1,25))
			if(!src.name)
				goto Namez
				return
			if(findtext(name,"\n"))
				world<<"[key] ([client.address]) tried to use their name to spam. They were booted."
				del(src)
			usr.UpdateBio()
		if(blah=="Class")
			if(usr.Race=="Namekian")
				if(usr.Class=="Warrior")
					usr.Class="Dragon"
				else if(usr.Class=="Dragon")
					usr.Class="Warrior"

			else if(usr.Race=="Monster")
				if(usr.Class=="Beastmen")
					usr.Class="Yokai"
					usr.icon='AlienElf_Male.dmi'
				else if(usr.Class=="Yokai")
					usr.Class="Eldritch"
					usr.icon='AlienSquid.dmi'
				else if(usr.Class=="Eldritch")
					usr.Class="Beastmen"
					usr.icon='AlienTiger_Male.dmi'

			else if(usr.Race=="Shinjin")
				if(usr.Class=="South")
					usr.Class="East"
				else if(usr.Class=="East")
					usr.Class="North"
				else if(usr.Class=="North")
					usr.Class="West"
				else if(usr.Class=="West")
					usr.Class="South"
			else if(Race=="Majin")
				if(Class=="Innocent")
					Class = "Super"
				else if(Class=="Super")
					Class = "Unhinged"
				else if(Class=="Unhinged")
					Class = "Innocent"

			usr.RacialStats()
			spawn()usr.UpdateBio()

		if(blah=="Sex")
			if(usr.Asexual)
				usr.Gender="---"
			else if(usr.Gender=="Male")
				usr.Gender="Female"
			else
				usr.Gender="Male"
			usr.RacialStats()
			usr.UpdateBio()
			return

	ToggleHelp(var/blah as text)
		set name=".ToggleHelp"
		set hidden=1
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(blah=="Name")
			alert("This will be what other people see you as, it's your character's In Character (IC) name.")
		if(blah=="Class")
			alert("Wizards are energy/magic users, sacrificing physical skills. Fighers are just the default. Technologists are more intelluctual over combat skills, some races may have alternate classes.")
		if(blah=="Sex")
			alert("Female or Male...used for breeding purposes.")
		if(blah=="Race")
			alert("Odds are you already read the blurb.")
		if(blah=="Size")
			alert("Mediums are default, small are agile, large are gigantic. Will complete later..")
		if(blah=="Battle Power")
			alert("This determines how fast (or slow) you gain Battle Power (BP).")
		if(blah=="Zenkai")
			alert("This determines how fast (or slow) you gain BP though being injured.")
		if(blah=="TrainRate")
			alert("This determines various gain rates. Training typically is used for gains related to the Train verb.")
		if(blah=="MedRate")
			alert("This determines various gain rates. Meditation typically is used for gains related to Meditating.")
		if(blah=="IntelMod")
			alert("This determines how fast (or slow) you gain Intelligence Experience. Intelligence is used to make Technology.")
		if(blah=="EnchantMod")
			alert("This determines how fast (or slow) you gain Enchantment Experience. Enchantment is used to make Magical Items.")
		if(blah=="EnergyMod")
			alert("This determines how fast (or slow) you gain Maximum Energy. Energy is used for a wide range of things, including learning new skills, using those skills, and more. If you are low on Energy, many options may become unavailable, and your movement speed will be dramatically reduced.")
		if(blah=="StrMod")
			alert("This determines how fast (or slow) you gain Strength. Strength is used for melee attacks for the most part, though a few ranged attacks do exist.")
		if(blah=="EndMod")
			alert("This determines how fast (or slow) you gain Endurance. Endurance is used for melee defense. The more you have, the less damage melee attacks will do to you.")
		if(blah=="SpdMod")
			alert("This determines how fast (or slow) you gain Speed. Speed has a range of uses, including Attack Speed (mod), and is a important part of the Accuracy math.")
		if(blah=="ForMod")
			alert("This determines how fast (or slow) you gain Force. Force is used for both Ki and Magical attacks, and determines the damage done by those.")
		if(blah=="OffMod")
			alert("This determines how fast (or slow) you gain Offense. Offense is extremely important in regards to hitting players.")
		if(blah=="DefMod")
			alert("This determines how fast (or slow) you gain Defense. Defense is extremely important in regards to avoiding attacks, both melee and ranged.")
		if(blah=="RegenerationMod")
			alert("This determines how fast (or slow) you recover Health while Meditating. This cannot be increased at character creation, but various items and abilities may be able to increase it.")
		if(blah=="RecoveryMod")
			alert("This determines how fast (or slow) you recover Energy and charge Ki attacks. It cannot be trained, but various abilities can increase or decrease it.")
		if(blah=="AngerMod")
			alert("This determines how much power you gain when you Anger, an event that occurs if a hit that would have reduced you under 25% heatlh happens..")

mob/proc/UpdateBio()
	src.PerkDisplay()
	winset(src,"LabelRace","text=\"[src.Race]\"")
	if(src.Asexual)
		winset(src,"LabelSex","text=\"---\"")
	else
		winset(src,"LabelSex","text=\"[src.Gender]\"")
	winset(src,"LabelType","text=\"[src.Class]\"")
	winset(src,"LabelName","text=\"[src.name]\"")

mob
	verb/ToggleBlah2(var/blah as text)
		set name=".ToggleBlah"
		set hidden=1
		if(!(world.time > verb_delay)) return
		verb_delay=world.time+1
		if(!src.Redoing_Stats)
			return
		if(blah=="Name")
			Namez
			src.name=html_encode(copytext(input(src,"Name? (25 letter limit)"),1,25))
			if(!src.name)
				goto Namez
				return
			usr.UpdateBio()
		if(blah=="Class")
			if(usr.Race=="Namekian")
				if(usr.Class=="Warrior")
					usr.Class="Dragon"
				else if(usr.Class=="Dragon")
					usr.Class="Warrior"
				else if(usr.Class=="Fighter")
					usr.Class="Warrior"

			else if(usr.Race=="Monster")
				if(usr.Class=="Beastmen")
					usr.Class="Yokai"
					usr.icon='AlienElf_Male.dmi'
				else if(usr.Class=="Yokai")
					usr.Class="Eldritch"
					usr.icon='AlienSquid.dmi'
				else if(usr.Class=="Eldritch")
					usr.Class="Beastmen"
					usr.icon='AlienTiger_Male.dmi'
				else if(usr.Class=="Fighter")
					usr.Class="Beastmen"

			else if(usr.Race=="Shinjin")
				if(usr.Class=="South")
					usr.Class="East"
				else if(usr.Class=="East")
					usr.Class="North"
				else if(usr.Class=="North")
					usr.Class="West"
				else if(usr.Class=="West")
					usr.Class="South"
				else if(usr.Class=="Fighter")
					usr.Class="South"

			usr.RacialStats()
			spawn()usr.UpdateBio()

		if(blah=="Sex")
			if(usr.Asexual)
				usr.Gender="---"
			else if(usr.Gender=="Male")
				usr.Gender="Female"
			else
				usr.Gender="Male"
			usr.RacialStats()
			usr.UpdateBio()
			return



mob/var/Plan=1
mob/var/Rac=1
mob/var/Tin=1

var/list/SagaLockOut=list()
var/list/RaceLock=list()
var/list/TechLockOut=list()

mob/proc/CheckRace(var/Race, var/Dir)
	if(!src.CheckUnlock(Race))
		UpdateRaceScreen("Race", Dir)
mob/proc/CheckOffworld(var/Dir)
	if(!src.CheckUnlock("Shinjin")&&!src.CheckUnlock("Demon")&&!src.CheckUnlock("Dragon"))
		UpdateRaceScreen("Planet", Dir)
		return 1
	return 0
mob/proc/CheckCreated(var/Dir)
	if(!src.CheckUnlock("Android")&&!src.CheckUnlock("Majin"))
		UpdateRaceScreen("Planet", Dir)
		return 1
	return 0

mob/proc/UpdateRaceScreen(var/Mode,var/Change)
	if(Change)
		if(Mode)
			switch(Mode)
				if("Planet")
					Rac=1
					switch(Change)
						if("+")
							src.Plan++
							if(Plan>4)
								Plan=1
						if("-")
							src.Plan--
							if(Plan<1)
								Plan=4

				if("Race")
					switch(Change)
						if("+")
							Rac++
						if("-")
							Rac--
	else
		Change="+"
	src.Hairz("Remove")
	src.Class="Fighter"
	if(Plan==1)//Civilized; Human, Makyo, Half Saiyan, Namekian
		if(Rac>4)
			Rac=1
		if(Rac<1)
			Rac=4
		if(Rac==1)
			src.Asexual=0
			Race="Human"
			if(src.gender=="female")
				src.icon='FemaleLight.dmi'
			else
				src.icon='MaleLight.dmi'
		if(Rac==2)
			src.Asexual=0
			Race="Makyo"
			if(src.gender=="female")
				src.icon='Icons/Oni-Makyo/Makyo F.dmi'
			else
				src.icon='Icons/Oni-Makyo/Makyo M.dmi'
		if(Rac==3)
			src.Asexual=1
			src.Race="Namekian"
			src.Class="Dragon"
			src.icon='Namek1.dmi'
		if(Rac==4)
			src.Asexual=0
			Race="Half Saiyan"
			if(src.gender=="female")
				src.icon='FemaleLight.dmi'
			else
				src.icon='MaleLight.dmi'


	if(Plan==2)//Savage; Saiyan, Tuffle, Alien, Monster, Changeling
		if(Rac>5)
			Rac=1
		if(Rac<1)
			Rac=4
		if(Rac==4)//these boys are still rare
			src.CheckRace("Changeling", Change)

		if(Rac==1)
			src.Asexual=0
			src.Race="Saiyan"
			if(src.gender=="female")
				src.icon='FemaleLight.dmi'
			else
				src.icon='MaleLight.dmi'
		if(Rac==2)
			Class="Innocent"
			src.Asexual=0
			src.Race="Majin"
			if(src.gender=="female")
				icon = 'Icons/Majins/Majin Base Fem.dmi'
			else
				icon = 'Icons/Majins/Majin Base Masc.dmi'
		if(Rac==3)
			src.Asexual=0
			src.Race="Monster"
			src.Class="Beastmen"
			if(src.gender=="female")
				src.icon='AlienAvian_Female.dmi'
			else
				src.icon='AlienTiger_Male.dmi'
		if(Rac==4)
			src.Asexual=1
			src.Race="Changeling"
			src.icon='Frieza1.dmi'
			src.Class="Fighter"

	if(Plan==3)//Offworld; Shinjin, Demon, Dragon
		if(src.CheckOffworld(Change))
			return
		if(Rac>3)
			Rac=1
		if(Rac<1)
			Rac=3
		if(Rac==1)
			src.CheckRace("Shinjin", Change)
		if(Rac==2)
			src.CheckRace("Demon", Change)
		if(Rac==3)
			src.CheckRace("Dragon", Change)

		if(Rac==1)
			src.Asexual=0
			src.Race="Shinjin"
			src.Class="North"
			if(src.gender=="female")
				src.icon='CustomFemale.dmi'
			else
				src.icon='CustomMale.dmi'
		if(Rac==2)
			src.Asexual=0
			src.Race="Demon"
			src.icon='Demon1.dmi'
			src.Class="D"
		if(Rac==3)
			src.Asexual=1
			src.Race="Dragon"
			src.icon='Dragon1.dmi'


	if(Plan==4)//Created; Android, Majin
		if(src.CheckCreated(Change))
			return
		if(Rac>1)
			Rac=1
		if(Rac<1)
			Rac=1
		if(Rac==1)
			src.CheckRace("Android", Change)
		if(Rac==1)
			src.Asexual=1
			src.Race="Android"
			src.icon='Android1.dmi'
			src.Class="Fighter"

	winset(src,"RaceName","text=\"[src.Race]\"")
	if(Race == "Majin")
		winset(src,"RaceName","text=\"Dokkaebi\"")

	if(Plan==1)
		winset(src,"PlanetName","text='Humanoid'")
		winset(src,"Planet1","image=['Humanity.png']")
	if(Plan==2)
		winset(src,"PlanetName","text='Monstrous'")
		winset(src,"Planet1","image=['Monstrous.png']")
	if(Plan==3)
		winset(src,"PlanetName","text='Eldritch'")
		winset(src,"Planet1","image=['Eldritch.png']")
	if(Plan==4)
		winset(src,"PlanetName","text='Artificial'")
		winset(src,"Planet1","image=['Android.png']")

	if(src.Race=="Human")
		winset(usr,"Iconz","image=['Humans.png']")
		src<<output("Humanity. What is there more to say? The base class that is given to all PLAYERS who failed to receive anything special. A race that continues to rapidly advance in technology and culture to the point that it brought the emergence of the Tower. A race of people who always seek to rise up to the challenge and fight back even when all hope is lost. ","raceblurb")
	if(src.Race=="Makyo")
		winset(usr,"Iconz","image=['Makyo.png']")
		src<<output("A class representing the followers of the Moon. A racial class focused on channeling the power of lunar energy to power oneself to immense levels. They utilize the different phases of the moon in order to expand their strength to levels unheard, especially compared to regular humans. Those who have this class usually have some shade of gray skin color while also having a lunar symbol somewhere on their body.","raceblurb")
	if(src.Race=="Namekian")
		winset(usr,"Iconz","image=['Namek.png']")
		src<<output("Representatives of the Earth itself. Those who receive this class are those who value the Earth more than anything else. They fight to protect the very planet itself and wish to see it live past the age of Humanity. This class focuses more on the druidic arts and follows a very diverse nomadic culture. Their personalities tend to clash greatly with those of the LUMINERE class and conflicts usually ensue when they are in the same room. Those who receive this class usually have antenna, rocky parts, and/or Earthen skin (green to brown).","raceblurb")
	if(src.Race=="Half Saiyan")
		winset(usr,"Iconz","image=['Halfie.png']")
		src<<output("Some would say this class is pretty much a cheat class. Hell, what the hell is a hidden class anyways? They say it's the combination of two different classes, but those people sound like haters. A class that can do what two other classes can do and better? Well now that just sounds like bullshit. Those who receive this class usually have features that are the combination of both the HUMAN class and the MONKEY WARRIOR class.","raceblurb")

	if(src.Race=="Saiyan")
		winset(usr,"Iconz","image=['Saiyan.png']")
		src<<output("A class of warriors through and through. Those who receive this class usually tend to have been fighters or hold some sort of fighting spirit deep within them. Even those who were seen as cowardly were able to awaken to this class due the internal fight they had to suffer through every day. The MONKEY WARRIOR class is that of power and that of freedom. Some tend to be hot headed while others calm and strategic. Every person has their own way of showing their power after all. Those who receive this class tend to have primate features, be it tails or fur, and are usually larger than most humans.","raceblurb")
	if(src.Race=="Alien")
		winset(usr,"Iconz","image=['Alien.png']")
		src<<output("This class covers all that cannot be defined in the other numerous classes. Those who receive this class do not fit in any other classification and are much more flexible than any other class. They tend to be more open to other people and flexible when it comes to how they approach their various situations. Those of the GRAYSKIN class tend to have the most variety of features, yet still always keeping their humanoid figure even if they may not look like a human. ","raceblurb")
	if(src.Race=="Monster")
		winset(usr,"Iconz","image=['Monster.png']")
		src<<output("A very generalized class that represents all those that were given skills/features that others would deem ‘monstrous’. The MONSTER class is usually given to those who have experienced things no other humans should have in the world. Be it war, crime, drugs, or the darkest pits of human civilization. The people who receive this class tend to usually have rather melancholic personality or are cynical in nature. The features of this class are very diverse, but they tend to have a fearsome or ‘monstrous’ appearance.","raceblurb")
	if(src.Race=="Changeling")
		winset(usr,"Iconz","image=['i_Changling.gif']")
		src<<output("A class consisting of Players who have undergone a specific mutation, granting them the ability to store their power as a hardened carapace around their body. As they progress through a fight, they can reassimilate this, sacrificing defenses to greatly elevate their power. Beyond the presence of natural armor upon their frame, the STONESKIN has no specifically defining features, coming in all different shapes and sizes. Many have tails however and bear other lizard-like features, hence the name.","raceblurb")

	if(src.Race=="Shinjin")
		winset(usr,"Iconz","image=['Manager.png']")
		src<<output("A mysterious entity residing inside of the Tower. They're unknown, even to the Players, speaking only ever sweet whispers and strange phenomena.","raceblurb")
	if(src.Race=="Demon")
		winset(usr,"Iconz","image=['Demon.png']")
		src<<output("...!?","raceblurb")
	if(src.Race=="Dragon")
		winset(usr,"Iconz","image=['Dragon.png']")
		src<<output("...!?","raceblurb")

	if(src.Race=="Android")
		winset(usr,"Iconz","image=['i_Android.gif']")
		src<<output("Androids are artifical lifeforms typically created by skilled scientists.  They cannot upgrade their own systems, but they will never grow tired or weary.","raceblurb")
	if(src.Race=="Majin")
		winset(usr,"Iconz","image=['Majins.png']")
		src<<output("Those gifted with this class are dubbed as ‘Accursed’ despite the namesake representing a legendary Korean folktale. While normally classes are straight forward, or super secretive, this class is shrouded in confusion. The consistency between the people who inherit this class all vary greatly, however, the only consistency they have is their ability to consume monsters and Players alike, as well as their seemingly unkillable nature. Some believe the name of the class to be more like a taunt at those cursed to inherit the class and because of this, some bear through the pain of being able to regenerate from nigh-death and an endless hunger. While others let their inner desires loose, stopping at nothing to please the ‘goblin’ within them.","raceblurb")

obj/Login
	name="\[            \]"
	Savable=0
	Grabbable=0
	Screenz
		layer=555
		icon='Icons/Frontpage/final_version_but_for_real.dmi'
		density=1
	Newz
		icon='ArtificalObj.dmi'
		icon_state="Misc"
		layer=999
		alpha=0
		Click()
			if(WorldLoading)
				usr<<"Please wait until the world is done loading..."
				return
			if(usr.Race)
				usr<<"You have a race!?"
				return
			if(fexists("Saves/Players/[usr.ckey]"))
				var/savefile/f=new("Saves/Players/[usr.ckey]")
				var/cc
				f["name"] >> cc
				del f
				switch(alert("WARNING: You already have a character save on this key ([cc])! If you make a new character, it is likely your current one will be lost!","Oh snaps!","Yes","No"))
					if("Yes")
						winshow(usr,"Race_Screen",1)
						spawn()usr.UpdateRaceScreen()
					if("No")
						return
			else
				winshow(usr,"Race_Screen",1)
				spawn()usr.UpdateRaceScreen()
	Loadz
		icon='ArtificalObj.dmi'
		icon_state="Misc"
		layer=999
		alpha=0
		Click()
			if(WorldLoading)
				usr<<"Please wait until the world is done loading..."
				return
			if(usr.Race)return
			if(fexists("Saves/Players/[usr.ckey]"))
				usr.client.LoadChar()
			else
				usr<<"<font color=yellow><b>Attention:</b>Savefile for [usr.key] not found!"




mob/var
	tmp/Clicked
	tmp/ChooseStats

client
	proc
		LoadChar()
			if(fexists("Saves/Players/[src.ckey]"))
				var/savefile/F=new("Saves/Players/[src.ckey]")
				F["mob"] >> src.mob
				if(src.mob.Fused)
					if(global.fusion_locs.len)
						if(src.mob.Fused==1)
							var/list/l
							for(var/index in fusion_locs) if(findtext(index, ckey) || findtext(index, mob.Fusee))
								l = fusion_locs[index]
								break
							if(l)
								src.mob.loc=locate(l["x"], l["y"], l["z"])
								src.mob.BeginKB(WEST, 2)
						if(src.mob.Fused==2)
							var/list/l
							for(var/index in fusion_locs) if(findtext(index, ckey) || findtext(index, mob.Fusee))
								l = fusion_locs[index]
								break
							if(l)
								src.mob.loc=locate(l["x"]-1, l["y"], l["z"])
								src.mob.BeginKB(EAST, 2)
					src.mob.Fused=0
					src.mob.AppearanceOff()
					src.mob.AppearanceOn()
					for(var/obj/Skills/Buffs/SlotlessBuffs/Fusion_Dance/FD in src.mob)
						if(FD)
							FD.Cooldown()
					for(var/obj/Skills/Buffs/SlotlessBuffs/Divine_Fusion/DF in src.mob)
						if(DF)
							DF.Cooldown()
					src.mob.Health=25
				if(mob.Race=="Majin")
					if(!mob.majinPassive)
						mob.majinPassive = new(mob)
					if(!mob.majinAbsorb)
						mob<<"lacking majin absorb"
						mob.majinAbsorb = new()
						mob.findAlteredVariables()

				var/datum/donator/d_info = donationInformation.getDonator(key = src.key)
				var/datum/supporter/s_info = donationInformation.getSupporter(key = src.key)
				var/alreadydisplayed = FALSE
				if(d_info)
					if(d_info.getTier() >= 2)
						var/parse = replacetext(d_info.loginMessage, "name", d_info.name)
						parse = replacetext(parse, "key", d_info.key)
						world<<parse
						alreadydisplayed = TRUE
				if(s_info)
					if(s_info.getTier() >= 5 && !alreadydisplayed)
						var/parse = replacetext(s_info.loginMessage, "name", s_info.name)
						parse = replacetext(parse, "key", s_info.key)
						world<<parse

				if(key in VuffaKeys)
					mob.giveVuffaMoment()
				switch(mob.Secret)
					if("Vampire")
						mob.vampireBlood = new(mob, 6,70)
				if(mob:assigningStats)
					mob.Redo_Stats()





		BackupSaveChar()
			if(src.mob.Savable)
				var/savefilefound=file("Saves/Players/[src.ckey]")
				fcopy(savefilefound,"SaveBackups/Players/[src.ckey]")
		ArchiveSave()

		SaveChar()
			if(src.mob.Savable)
				if(istype(src.mob, /mob/Players))
					var/mob/p = src.mob
					p.last_online = world.realtime
				var/savefile/F=new("Saves/Players/[src.ckey]")
				F["mob"] << src.mob
				F["name"] << src.mob.name

/proc/ArchiveSave(mob/p, deleteSav = FALSE)
	if(p.Savable)
		var/savefile/F=new("Saves/Players/[p.ckey]")
		F["mob"] << p
		F["name"] << p.name
		var/savefile/F2=new("Saves/Players/Archives/[p.ckey]/[p.name]-[time2text(world.realtime, "mm-dd-yyyy_hh-mm-ss")]")
		F2["mob"] << p
		F2["name"] << p.name
		if(deleteSav)
			fdel("Saves/Players/[p.ckey]")

mob/proc
	NewMob()
		var/mob/LOL=new/mob/Players/
		LOL.name=src.name
		LOL.Race=src.Race
		LOL.loc=src.loc
		LOL.Class=src.Class
		LOL.icon=src.icon
		LOL.icon_state=src.icon_state
		LOL.PotentialRate=src.PotentialRate
		LOL.Base=src.Base
		LOL.EnergyMax=src.EnergyMax
		LOL.Gender=src.Gender
		LOL.StrMod=src.StrMod
		LOL.EndMod=src.EndMod
		LOL.SpdMod=src.SpdMod
		LOL.ForMod=src.ForMod
		LOL.OffMod=src.OffMod
		LOL.DefMod=src.DefMod
		LOL.RecovMod=src.RecovMod
		LOL.AngerMax=src.AngerMax
		LOL.RPPMult=src.RPPMult
		LOL.Intelligence=src.Intelligence
		LOL.Imagination=src.Imagination
		LOL.Hair_Base=src.Hair_Base
		LOL.Hair_Color=src.Hair_Color
		LOL.Tail=src.Tail
		LOL.GenRaces=src.GenRaces
		LOL.AscensionsUnlocked=src.AscensionsUnlocked
		src.client.mob=LOL
		del(src)
	Finalize(var/Warped=0)
		passive_overhaul = FALSE
		src.Hair_Forms()
		src.Hairz("Add")
		resetStats = FALSE
		if(src.Tail)
			src.Tail(1)
		src.ChargeIcon=image('BlastCharges.dmi',"[rand(1,9)]")
		src.Text_Color=pick("#00FF00","#FFFF00","#FF00FF","#0000FF","#FF0000","#00FFFF")
		src.OOC_Color=pick("#00FF00","#FFFF00","#FF00FF","#0000FF","#FF0000","#00FFFF")
		src.Emote_Color = pick("#00FF00","#FFFF00","#FF00FF","#0000FF","#FF0000","#00FFFF")
		passive_handler=new
		if(!Warped)
			src.Potential=0
			if(!locate(/obj/Money, src))
				src.contents+=new/obj/Money
		if(src.Race!="Android"&&src.Class!="Dance"&&src.Class!="Potara")
			src.EnergyUniqueness=GoCrand(0.8,1.2)
			src.EnergySignature=rand(1000,9000)
			// src.ClothGold=pick(global.ConstellationsGold)
		else
			src.EnergyUniqueness=1
			if(src.Class=="Dance"||src.Class=="Potara")
				src.EnergySignature=rand(9001,9999)
				src.ClothGold="Ophiuchus"

		if(src.Race=="Human")
			src.AngerMessage="grows panicked!"
			src.HiddenAnger=1
			src.AngerPoint=50
			passive_handler.Increase("Desperation", 1)
			passive_handler.Increase("Adrenaline", 0.5)
			passive_handler.Increase("TechniqueMastery", 5)
			Desperation=1
			Adrenaline=0.5
		if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
			src.Tail(1)
			src.contents+=new/obj/Oozaru
			if(src.Race=="Half Saiyan")
				passive_handler.Increase("Desperation", 0.5)
				src.Desperation=0.5
			if(src.Race=="Saiyan")
				src.PowerBoost=1
				src.PotentialRate=2.5
				src.ModifyPrime=1
				src.ModifyFinal=-1
		if(src.Race=="Makyo")
			if(src.icon=='Makyo1.dmi')
				src.ExpandBase='Makyo1_Buff.dmi'
			else if(src.icon=='Makyo2.dmi')
				src.ExpandBase='Makyo2_Buff.dmi'
			else if(src.icon=='Makyo3.dmi')
				src.ExpandBase='Makyo3_Buff.dmi'
			src.PoweredFormSetup()
		if(src.Race=="Namekian")
			var/Choice
			var/Confirm
			src.Asexual=0
			src.AddSkill(new/obj/Skills/Utility/Sense)
			src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Regeneration)
			src.AddSkill(new/obj/Skills/AutoHit/AntennaBeam)
			src.EnhancedHearing=1
			for(var/obj/Skills/Buffs/SlotlessBuffs/Regeneration/r in src)
				r.RegenerateLimbs=1


			if(src.Class=="Dragon")
				while(Confirm!="Yes")
					Choice=alert(src, "As you uncover more secrets of Namekian mysticism, you get to choose which secrets of Dragon clan to master. Which path will it be?", "Dragon Clan Secrets", "Healer", "Enchanter")
					switch(Choice)
						if("Healer")
							Confirm=alert(src, "Do you choose the path of healing, learning to mend any wound in an instant?", "Dragon Clan Secrets", "Yes", "No")
						if("Enchanter")
							Confirm=alert(src, "Do you choose the path of enchanting, learning to weave more intricate magicks?", "Dragon Clan Secrets", "Yes", "No")
						// if("Heretic")
						// 	Confirm=alert(src, "Do you choose the path of heresy, learning to imbue your body with dark energies and channeling its regenerative life force in alternate ways?", "Dragon Clan Secrets", "Yes", "No")
				if(Choice=="Healer")
					src.AddSkill(new/obj/Skills/Utility/Heal)
					for(var/obj/Skills/Utility/Heal/h in src)
						h.SagaSignature=1//protecc
						h.SignatureTechnique=0//brotecc
				else if(Choice=="Enchanter")
					passive_handler.Increase("ManaCapMult", 1)
					src.ManaCapMult+=1
				// else if(Choice=="Heretic")
				// 	src.AddSkill(new/obj/Skills/AutoHit/AntennaBeam)
				// 	src.NewAnger(1.5)
				// 	src.HellPower=0.5
				src.ModifyLate=1
				src.ModifyFinal=1
			else
				src.AddSkill(new/obj/Skills/AutoHit/AntennaBeam)
				src.AddSkill(new/obj/Skills/Utility/Make_Equipment)
				src.ModifyEarly=-1
				src.ModifyPrime=1

		if(src.Race=="Monster")
			if(src.Class=="Beastmen")
				src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Berserk)
				src << "As a beastman, your anger will flare when you are pressed to your limits!"
				src.ModifyBaby=0
				src.ModifyEarly=0
				src.ModifyPrime=1
				src.ModifyLate=-1
				src.EnhancedSmell=1
				src.EnhancedHearing=1
			if(src.Class=="Yokai")
				src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Spirit_Form)
				src << "As a yokai, you can shift to your spirit form to bolster your energy attacks!"
				src.ModifyLate=3
				src.ModifyFinal=-1
				src.EnhancedHearing=1
				src.Spiritual=1
			if(src.Class=="Eldritch")
				passive_handler.Increase("SpaceWalk", 1)
				src.SpaceWalk=1
				src.Timeless=1
				src << "As an eldritch being, you can last through entropy of time and space and see beyond normal sight."
		if(src.Race=="Tuffle")
			src.CyberizeMod=1
			src.EconomyMult=2
		if(src.Race=="Shinjin")
			src.Timeless=1

			switch(src.Class)
				if("North")
					//you heal faster when close to earth
					src.Restoration=1
					src.Attunement="Earth"
				if("South")
					//Fire doesn't hurt
					passive_handler.Increase("WalkThroughHell", 1)
					src.WalkThroughHell=1
					src.Attunement="Fire"
				if("East")
					//Breathe anything
					src.OxygenMax*=4
					passive_handler.Increase("SpaceWalk", 1)
					src.SpaceWalk=1
					src.Attunement="Wind"
				if("West")
					//You don't have to swim
					passive_handler.Increase("WaterWalk", 1)
					src.WaterWalk=1
					src.Attunement="Water"
			src.AddSkill(new/obj/Skills/Utility/Telepathy)
			src.AddSkill(new/obj/Skills/Utility/Sense)
			src.AddSkill(new/obj/Skills/Telekinesis)
			src.AddSkill(new/obj/Skills/Utility/Observe)
			src.AddSkill(new/obj/Skills/Utility/Keep_Body)
			// src.AddSkill(new/obj/Skills/Teleport/Traverse_Underworld)
			src.AddSkill(new/obj/Skills/Reincarnation)
			src.AddSkill(new/obj/Skills/Utility/Teachz)
			// src.AddSkill(new/obj/Skills/Utility/Grimoire_Arcana)
			var/list/Choices=list("Kai", "Makai")
			var/Confirm
			var/Choice
			if(!src.ShinjinAscension)
				while(Confirm!="Yes")
					Choice=input(src, "Which realm do you swear your loyalty to?", "Shinjin Ascension") in Choices
					switch(Choice)
						if("Kai")
							Confirm=alert(src, "Do you pledge your allegiance to the continuity and propserity of the Living Realm?", "Shinjin Ascension", "Yes", "No")
						if("Makai")
							Confirm=alert(src, "Do you pledge your allegiance to the expansion and domination of the Demon Realm?", "Shinjin Ascension", "Yes", "No")
				if(Choice=="Kai")
					passive_handler.Increase("SpiritPower", 1)
					passive_handler.Increase("CalmAnger", 1)
					src.SpiritPower=1
					src.CalmAnger=1
					src.Potential=10
					src.PotentialRate=0.1
				if(Choice=="Makai")
					passive_handler.Increase("HellPower", 1)
					passive_handler.Increase("StaticWalk", 1)
					src.HellPower=1
					src.NewAnger(2)
					src.Intimidation=10
					src.Potential=DaysOfWipe()
					src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Majin)
					src.PotentialRate=5
					src.StaticWalk=1
					// src.AddSkill(new/obj/Skills/Utility/Grant_Jagan)
				switch(src.Class)
					if("North")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Kaioken)
						src.AddSkill(new/obj/Skills/Projectile/Genki_Dama)
						var/obj/Skills/Buffs/NuStyle/UnarmedStyle/North_Star_Style/nss=new/obj/Skills/Buffs/NuStyle/UnarmedStyle/North_Star_Style
						src.AddSkill(nss)
					if("East")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Toppuken)
						src.AddSkill(new/obj/Skills/AutoHit/Gwych_Dymestl)
						var/obj/Skills/Buffs/NuStyle/UnarmedStyle/East_Star_Style/ess=new/obj/Skills/Buffs/NuStyle/UnarmedStyle/East_Star_Style
						src.AddSkill(ess)
					if("South")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Rekkaken)
						src.AddSkill(new/obj/Skills/Projectile/Zone_Attacks/Global_Devastation)
						var/obj/Skills/Buffs/NuStyle/SwordStyle/South_Star_Style/sss=new/obj/Skills/Buffs/NuStyle/SwordStyle/South_Star_Style
						src.AddSkill(sss)
					if("West")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Kyoukaken)
						src.AddSkill(new/obj/Skills/AutoHit/Great_Deluge)
						var/obj/Skills/Buffs/NuStyle/FreeStyle/West_Star_Style/wss=new/obj/Skills/Buffs/NuStyle/FreeStyle/West_Star_Style
						src.AddSkill(wss)

				src.ShinjinAscension=Choice

		if(src.Race=="Demon")
			if(src.icon=='Demon3.dmi')
				src.Form1Base='Demon3M.dmi'
			if(src.icon=='Demon4.dmi')
				src.Form1Base='Demon4M.dmi'
			if(src.icon=='Demon5.dmi')
				src.Form1Base='Demon5M.dmi'
			src.AngerPoint=50
			passive_handler.Increase("HellPower", 1)
			passive_handler.Increase("StaticWalk", 1)
			passive_handler.Increase("SpaceWalk", 1)
			passive_handler.Increase("CursedWounds", 1)
			src.HellPower=1
			src.StaticWalk=1
			src.SpaceWalk=1
			src.Timeless=1
			src.Spiritual=1
			src.CursedWounds=1
			src.Potential=DaysOfWipe()
			src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Regeneration)
			src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm)
			src.TrueName=input(src, "As a demon, you have a True Name that can be used to summon you by anyone with the magic and knowledge of it. It should be kept secret. What is your True Name?", "Get True Name") as text
			src << "The name by which you can be conjured is <b>[src.TrueName]</b>."
			global.TrueNames.Add(src.TrueName)
		if(src.Race=="Majin")
			//TODO: COME BACK TO THIS AND GIVE OTHER VARS FOR DIFFERENT CLASSES
			passive_handler.Increase("StaticWalk", 1)
			src.StaticWalk=1
			majinPassive = new(src)
			majinAbsorb = new(src)
			src.AngerPoint=50
			switch(Class)
				if("Innocent")
					DemonicDurability=1
					AngerPoint=50
				if("Super")
					Steady=1
				if("Unhinged")
					Adrenaline=1
					Hustle=1
					AngerPoint=50
			src.Timeless=1
			src.Spiritual=1
			src.AddSkill(new/obj/Skills/Absorb)
			src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Regeneration)
			for(var/obj/Skills/Buffs/SlotlessBuffs/Regeneration/r in src)
				r.RegenerateLimbs=1
			// src.contents+=new/obj/Regenerate
			// for(var/obj/Regenerate/x in src)
			// 	x.Level=4
		if(src.Race=="Dragon")
			src.Intimidation=10
			src.AngerMessage="roars furiously!"
			src.Class=input(src, "All dragons possess resilence against the elements, but they also possess an affinity for a specific element.  What is your affinity?", "Elemental Dragon") in list("Fire", "Water", "Metal", "Lightning", "Poison", "Gold", "Time")
			src.DebuffImmune=1
			passive_handler.Increase("DebuffImmune", 1)
			src.EconomyMult=4
			src.Timeless=1
			src.Spiritual=1
			src.Potential=DaysOfWipe()
			src.AngerPoint=50
			switch(src.Class)
				if("Fire")
					src.Attunement="Fire"
					src.AngerPoint=50
					src.AddSkill(new/obj/Skills/AutoHit/Fire_Breath)
					src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Heat_Of_Passion)
					passive_handler.Increase("DemonicDurability", 1)
					passive_handler.Increase("SpiritHand", 1)
					MeltyBlood=1
					DemonicDurability=1
					src.StrAscension=0.25
					src.ForAscension=0.25
					src.OffAscension=0.25
					src << "You have an affinity for <font color='red'><b>fire</b></font color>."
				if("Water")
					src.Attunement="Water"
					passive_handler.Increase("Fishman", 1)
					src.Fishman=1
					src.AddSkill(new/obj/Skills/Projectile/Beams/Ice_Dragon)
					src.EndAscension=0.25
					src.ForAscension=0.25
					src.DefAscension=0.25
					src << "You have an affinity for <font color='blue'><b>water</b></font color>."
				if("Metal")
					src.Attunement="Earth"
					passive_handler.Increase("Hardening", 1)
					src.Hardening=1
					src.AddSkill(new/obj/Skills/Projectile/Shard_Storm)
					src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Rage/Dragons_Tenacity)
					src.StrAscension=0.25
					src.EndAscension=0.25
					src.DefAscension=0.25
					src << "You have an affinity for <font color='green'><b>earth</b></font color>."
				if("Lightning")
					src.Attunement="Wind"
					passive_handler.Increase("Godspeed", 1)
					src.Godspeed=1
					src.AddSkill(new/obj/Skills/Projectile/Beams/Static_Stream)
					src.StrAscension=0.25
					src.EndAscension=0.25
					src.SpdAscension=0.25
					src << "You have an affinity for <font color='cyan'><b>lightning</b></font color>."
				if("Poison")
					passive_handler.Increase("VenomResistance", 2)
					src.VenomResistance+=2
					src.AddSkill(new/obj/Skills/AutoHit/Poison_Gas)
					src.StrAscension=0.25
					src.OffAscension=0.25
					src << "You have an affinity and partial immunity to <font color='purple'><b>poison</b></font color>."
				if("Gold")
					src.Intelligence=2
					src.EconomyMult*=4
					src.ForAscension=0.25
					src.OffAscension=0.25
					src << "You lack an elemental affinity but you're gifted with <font color='#FFFF00'><b>brilliance</b></font color>."
				if("Time")
					src.PowerBoost=1.5
					src.AngerMax=1
					src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Dragon_Force)
					src.StrAscension=0.25
					src.OffAscension=0.25
					src.DefAscension=0.25
					src << "You embrace timelessness of the ancient dragons and assert your <font color='#666666'><b>superiority</b></font color> over everything..."
		if(src.Race=="Alien")
			src.PotentialRate+=(2)//2 potential rate at 100 potentialcap, 1 potential rate at 200 potentialcap
			src.AlienRacials()
		if(src.Race=="Android")
			src.AddSkill(new/obj/Skills/Utility/Internal_Communicator)
			src.AddSkill(new/obj/Skills/Utility/Android_Integration)
			passive_handler.Increase("Mechanized", 1)
			passive_handler.Increase("StabilizeModule", 1)
			passive_handler.Increase("InjuryImmune", 1)
			passive_handler.Increase("FatigueImmune", 1)
			passive_handler.Increase("DebuffImmune", 1)
			passive_handler.Increase("VenomImmune", 1)
			passive_handler.Increase("ManaPU", 1)
			src.Mechanized=1//No magic
			src.StabilizeModule=1//In built life support
			src.InjuryImmune=1//What injury?
			src.FatigueImmune=1//What fatigue?
			src.DebuffImmune=1//What debuffs?
			src.VenomImmune=1//no corrosion
			src.EnhancedHearing=1
			src.InternalScouter=1
			src.ExhaustedMessage="appears heavily damaged!"
			src.ExhaustedColor="#999999"
			src.BarelyStandingMessage="appears to be reaching limits of functionality!"
			src.BarelyStandingColor="#999999"
			src.PUConstant=1
			src.ManaPU=1
			src.FusionPowered=1
			src.EnhanceChipsMax=8
			src.Timeless=1
			src.PotentialRate=3
			Warped=1
		if(src.Race=="Changeling")
			src.Intimidation=2
			src.Potential=pick(0, 0, 0, 0, 0, 0, 0, 0, 0, 10)
			passive_handler.Increase("Adrenaline", 1)
			src.Adrenaline=1//Go faster at lower health
			src.AngerMessage="loses their cool!"
			src.trans["unlocked"]=3
			src.Potential=DaysOfWipe()
			src.BioArmor=100
			src.BioArmorMax=100
			src.PoweredFormSetup()
			src.AddSkill(new/obj/Skills/Power_Control)
			src.ModifyBaby=-1
			src.ModifyEarly=1
			src.ModifyPrime=2
			src.ModifyLate=-1
			src.ModifyFinal=-1

		src.StrOriginal=src.StrMod
		src.EndOriginal=src.EndMod
		src.SpdOriginal=src.SpdMod
		src.ForOriginal=src.ForMod
		src.OffOriginal=src.OffMod
		src.DefOriginal=src.DefMod
		src.RecovOriginal=src.RecovMod
		src.SetVars()

		if(!Warped)
			if(src.Race=="Alien"||src.Race=="Monster")
				var/Choice=input(src, "Do you want to possess animal characteristics?  These options will give you tails and ears.", "Choose your animal traits.") in list("None", "Cat", "Fox", "Racoon", "Wolf", "Lizard", "Crow", "Bull")
				switch(Choice)
					if("Cat")
						src.Neko=1
					if("Fox")
						src.Kitsune=1
					if("Racoon")
						src.Tanuki=1
					if("Wolf")
						src.Wolf=1
					if("Lizard")
						src.Lizard=1
					if("Crow")
						src.Tengu=1
					if("Bull")
						src.Bull=1
				if(Choice!="None")
					var/Color=input(src,"Choose color") as color|null
					src.Trait_Color=Color
					src.contents+=new/obj/FurryOptions
					src.Hairz("Remove")
					src.Hairz("Add")
				if(src.Race=="Monster"&&src.Class!="Yokai")
					var/Spirits=alert(src, "Do you function as a spiritual being?  This is relevant for establishing summoning contracts.", "Are The Spirits With You?", "No", "Yes")
					if(Spirits=="Yes")
						src.Spiritual=1
					else
						src.Spiritual=0
				if(src.Race=="Monster")
					var/confirm1
					var/choice1
					while(confirm1!="Yes")
						choice1=alert(src, "All monsters hail from battle-ready castes. Which do you hail from?", "Monster Caste", "Warrior", "Shaman", "Hunter")
						switch(choice1)
							if("Warrior")
								confirm1=alert(src, "Warrior caste monsters focus on enduring blows and defeating opponents physically. Is this your caste?", "Warrior Caste", "Yes", "No")
							if("Shaman")
								confirm1=alert(src, "Shaman caste monsters focus on powerful and accurate energy attacks. Is this your caste?", "Shaman Caste", "Yes", "No")
							if("Hunter")
								confirm1=alert(src, "Hunter caste monsters embrace all methods of fighting with particular focus on speed and finesse. Is this your caste?", "Hunter Caste", "Yes", "No")
					src.MonsterClass=choice1

					var/choice2
					var/confirm2
					while(confirm2!="Yes")
						choice2=alert(src, "All monsters draw power from a metaphysical ideal. What is the source of your monstrous strength?", "Monster Source", "Domination", "Determination", "Ingenuity")
						switch(choice2)
							if("Domination")
								confirm2=alert(src, "Monsters sworn to Domination ruthlessly crush opponents with raw and intimidating power. Is this your source of strength?", "Domination Ideal", "Yes", "No")
							if("Determination")
								confirm2=alert(src, "Monsters sworn to Determination exhibit great efficiency of movement and unflagging courage. Is this your source of strength?", "Determination Ideal", "Yes", "No")
							if("Ingenuity")
								confirm2=alert(src, "Monsters sworn to Ingenuity focus on leading their lessers with wise counsel. Is this your source of strength?", "Ingenuity Ideal", "Yes", "No")
					src.MonsterSource=choice2

					var/choice3
					var/confirm3
					while(confirm3!="Yes")
						choice3=alert(src, "All monsters carry a shred of mythos within them that may be cultivated into a true legend. What is your destiny?", "Monster Destiny", "Celestial", "Natural", "Infernal")
						switch(choice3)
							if("Celestial")
								confirm3=alert(src, "Monsters carrying a shred of celestial energy are inherently good - perhaps too good for others to tolerate. Is this your eventual destiny?", "Celestial Destiny", "Yes", "No")
							if("Natural")
								confirm3=alert(src, "Monsters carrying no shred of outside energy are true followers of the laws of nature. Good and evil have no meaning to them, there is only one's own will. Is this your eventual destiny?", "Natural Destiny", "Yes", "No")
							if("Infernal")
								confirm3=alert(src, "Monsters carrying a shred of infernal energy are inherently hateful. As they grow in power, so do their selfish tendencies. Is this your eventual destiny?", "Infernal Destiny", "Yes", "No")
					src.MonsterAscension=choice3

			if(!src.Timeless)
				if(!(src.Race in list("Changeling", "Saiyan", "Monster")))//these bois spawn in with deathtimers if theyre elder...
					//beastman monsters as elders would spawn in with death timers; yokai would be more powerful; eldritch dont even get this choice
					var/Age="Youth"//=alert(src, "Do you want to start as a youth or an elder?  Youths have not yet reached their full potential as fighters. Elders have already passed it, and may teach younger folks.", "Age", "Youth", "Elder")
					src.EraBody=Age
					if(src.EraBody=="Youth")
						src.EraAge=global.Era-src.GetPassedEras("Youth")
						if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
							src.Tail(1)
					else
						src.EraAge=global.Era-src.GetPassedEras("Elder")
						if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
							src.Tail(1)
				else
					src.EraBody="Youth"
					src.EraAge=global.Era-src.GetPassedEras("Youth")
			else
				src.EraAge=-4
				if(src.Class=="Eldritch" || src.Race=="Majin")
					src.EraAge=global.Era-GetPassedEras("Adult")
				src.EraBody="Adult"
				src << "You've started as a timeless race. You learn slower than others, but can teach younger beings and always have your full power available."

			src.EraBirth=global.Era
			src.ChooseSpawn()

			//spawns can kill beastmens ability to learn anything so this is here now.
			if(src.Intelligence<=0.25)
				src.Intelligence=0.25
			if(src.Imagination<=0.25&&src.Race!="Android")
				src.Imagination=0.25

			if(src.EraAge > 0) //WE ARE ALL ADULTS NOW
				src.EraAge=0
				src.EraBody="Adult"

			// if(global.RPPEventCharges["[src.ckey]"])
			// 	src.RPPSpendableEvent+=global.RPPEventCharges["[src.ckey]"]*global.RPPDaily
			// 	src << "You've gained [global.RPPEventCharges["[src.ckey]"]] days of event RPP from a past life."

			if(glob.progress.WipeStart)
				src.PotentialLastDailyGain=glob.progress.WipeStart
				if(src.Potential==DaysOfWipe())//if its a bad boi who gets free potential
					src.PotentialLastDailyGain=glob.progress.DaysOfWipe-1
				src.RewardsLastGained=glob.progress.DaysOfWipe-1
				//set these to wipe start so that the login code will give them their rewards and allow them to grind potentialz
			information.setPronouns(TRUE)
			information.setNationality(src)
			killed_AI = list()
			// information.pickFaction(src)
			if(key in VuffaKeys)
				giveVuffaMoment()
			fixRewardLastGained()

var/list/VuffaKeys = list("Vuffa", "PacifistSnowball")

mob
	proc
		GetPassedEras(var/Age)
			var/Return=0
			Return+=(1+src.ModifyBaby)//How many eras did it take to become a youth?
			if(Age=="Youth")
				return Return
			Return+=(1+src.ModifyEarly)//How many eras did it take to become an adult?
			if(Age=="Adult")
				return Return
			Return+=(2+src.ModifyPrime)//How many eras did it take to become an elder?
			if(Age=="Elder")
				return Return
			Return+=(1+src.ModifyLate)//How many eras did it take to become an old, dying fuck?
			if(Age=="Senile")
				return Return


mob/proc/InhabitDroid(var/obj/Body,var/mob/Mind)
	var/mob/Players/Droid=new/mob/Players
	Droid.assigningStats=TRUE
	Droid.loc=Body.loc
	Droid.name=Body.name
	Droid.icon=Body.icon
	Droid.icon_state=Body.icon_state
	Droid.Race="Android"
	Droid.Asexual=1
	Droid.Manufactured=1
	Droid.RacialStats()
	Droid.UpdateBio()
	Droid.Finalize(Warped=1)
	Droid.Potential=DaysOfWipe()
	Droid.AscensionsAcquired=0
	var/obj/Redo_Stats/r = new
	r.LoginUse=1
	Droid.contents+=r
	Droid.droidFormerEnergysignature=src.EnergySignature
	var/list/DenyVars=list("client", "key", "loc", "x", "y", "z", "type", "locs", "parent_type", "verbs", "vars", "contents", "Transform", "appearance")
	for(var/obj/Skills/s in Mind)
		if(s.AssociatedGear)
			continue
		if(s.AssociatedLegend)
			continue
		if(s.MagicNeeded)
			continue
		if(!locate(s, Droid))
			var/obj/Skills/NewS=new s.type
			for(var/x in s.vars)
				if(x in DenyVars)
					continue
				NewS.vars[x]=s.vars[x]
			Droid.AddSkill(NewS)
	Droid.ForgingUnlocked=Mind.ForgingUnlocked
	Droid.RepairAndConversionUnlocked=Mind.RepairAndConversionUnlocked
	Droid.MedicineUnlocked=Mind.MedicineUnlocked
	Droid.ImprovedMedicalTechnologyUnlocked=Mind.ImprovedMedicalTechnologyUnlocked
	Droid.TelecommunicationsUnlocked=Mind.TelecommunicationsUnlocked
	Droid.AdvancedTransmissionTechnologyUnlocked=Mind.AdvancedTransmissionTechnologyUnlocked
	Droid.EngineeringUnlocked=Mind.EngineeringUnlocked
	Droid.CyberEngineeringUnlocked=Mind.CyberEngineeringUnlocked
	Droid.MilitaryTechnologyUnlocked=Mind.MilitaryTechnologyUnlocked
	Droid.MilitaryEngineeringUnlocked=Mind.MilitaryEngineeringUnlocked
	Droid.knowledgeTracker.learnedKnowledge=Mind.knowledgeTracker.learnedKnowledge

	var/mob/Body2=Mind
	Body2.Leave_Body(SuperDead=1)
	Mind.client.mob=Droid
	del Body


mob/proc/PilotMecha(var/mob/Mecha,var/mob/Pilot)
	Mecha.Manufactured=1
	Pilot.client.mob=Mecha
