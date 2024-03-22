#define WIPE_TOPIC "https://docs.google.com/document/d/1pe2uWf5aRKBSjOCKq2F6KzTkf_A_fM80ZS2Dwz8sp3I/edit#heading=h.uc68sooja4h"
#define DISCORD_INVITE "https://discord.gg/9jjWZJ7dDx"
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
	var/list/OldLoc = list()

/var/list/Races_Changed = list()
/var/list/typesOfItemsRemoved = list(/obj/Items/Enchantment/Scrying_Ward, /obj/Items/Enchantment/Crystal_Ball, \
/obj/Items/Enchantment/Arcane_Mask, /obj/Items/Enchantment/Magic_Crest, /obj/Items/Enchantment/ArcanicOrb, \
/obj/Items/Enchantment/Teleport_Amulet, /obj/Items/Enchantment/Teleport_Nexus, /obj/Items/Enchantment/Dimensional_Cage, \
/obj/Items/Enchantment/PocketDimensionGenerator, /obj/Items/Enchantment/Crystal_of_Bilocation, \
/obj/Items/Enchantment/AgeDeceivingPills, /obj/Items/Enchantment/Phylactery, /obj/Items/Enchantment/Elixir_of_Reincarnation, \
/obj/Items/Enchantment/Time_Displacer)
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
			if(src.isRace(DEMON))
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
		if(src.isRace(HUMAN))
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
			if(src.isRace(SAIYAN))
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
/*		if(src.isRace(SAIYAN))
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

		if(isplayer(src))
			move_speed = MovementSpeed()

		fixTitle()

		GiveJobVerbs()
		RewardsLastGained = 0
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
				if(src.isRace(SAIYAN)||src.Race=="Half Saiyan")
					src.Tail(1)
			if((Dif-ModifyBaby)>=1&&(Dif-(ModifyBaby+ModifyEarly))<2)
				src.EraBody="Youth"
				Message="You are now considered a youth.  You're able to access more of your power, but your full potential hasn't been unleashed yet!"
				if(src.isRace(SAIYAN)||src.Race=="Half Saiyan")
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

		if(length(savedRoleplay) >= 1)
			if(fexists("Saved Roleplays/[key].txt"))
				fdel("Saved Roleplays/[key].txt")
			text2file(savedRoleplay, "Saved Roleplays/[key].txt")

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

client/Del()
	if(highlightedAtoms.len > 0)
		ClearHighlights()
	..()

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
		else if(usr.gender =="Neuter")
			usr.Gender = "Neuter"
		for(var/W in list("Grid1","Grid2","Finalize_Screen","Race_Screen"))
			winshow(usr,"[W]",0)
		usr.Admin("Check")

		usr<<"<font color='red'><b>READ THIS BEFORE PLAYING:</b></font><br>"
		usr<<"Wipe Topic: <a href='[WIPE_TOPIC]'>Click Here</a>"
		usr<<"We have a Discord server at: [DISCORD_INVITE]<br>"
/*		usr<<"Donate Here: <a href='[PATREON_LINK]'>Patreon (Monthly)</a> <a href='[KO_FI_LINK]'>Ko-Fi (One Time)</a>"
		if(donationInformation.getDonator(key=key))
			usr<<"[THANKS_MESSAGE_DONATOR(donationInformation.getDonator(key=key).getTier())]"
		if(donationInformation.getSupporter(key=key))
			usr<<"[THANKS_MESSAGE_SUPPORTER(donationInformation.getSupporter(key=key).getTier())]"*/
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
		if(!race_selecting)
			return
		if(blah=="+")
			UpdateRaceScreen(1)
		if(blah=="-")
			UpdateRaceScreen(-1)

	IconSelect()
		set hidden=1
		set name=".Select_Icon"
		if(!(world.time > verb_delay))
			return
		verb_delay=world.time+1
		if(usr.isRace(HUMAN)||usr.isRace(SAIYAN)||usr.Race=="Tuffle"||usr.Race=="Half Saiyan")
			usr.Grid("CreationHuman")
		else if(usr.isRace(NAMEKIAN))
			usr.Grid("CreationNamekian")
		else if(usr.Race=="Changeling")
			usr.Grid("CreationChangeling")
		else if(usr.Race=="Alien"||usr.Race=="Monster"||isRace(MAJIN))
			usr.Grid("CreationAlien")
		else if(usr.isRace(DEMON))
			usr.Grid("CreationDemon")
		else if(usr.isRace(MAKYO))
			usr.Grid("CreationMakyo")
		else if(usr.Race=="Shinjin")
			usr.Grid("CreationKaio")
		else if(usr.Race=="Android")
			usr.Grid("CreationAndroid")
		else if(usr.isRace(ELDRITCH))
			usr.icon='Octopus Type.dmi'
		else
			if(!usr.icon)
				usr.icon='MaleLight.dmi'

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
			if(usr.isRace(NAMEKIAN))
				if(usr.Class=="Warrior")
					usr.Class="Dragon"
				else if(usr.Class=="Dragon")
					usr.Class="Warrior"

			usr.RacialStats()
			spawn()usr.UpdateBio()

		if(blah=="Sex")
			var/list/options = usr.race.gender_options
			var/current_index = options.Find(usr.Gender)

			if (current_index != -1)
				var/next_index = (current_index + 1) % (options.len+1)
				if(next_index == 0)
					next_index = 1
				usr.Gender = options[next_index]
			else
				usr.Gender = options[1]
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
	winset(src,"LabelRace","text=\"[race.name]\"")
	winset(src,"LabelSex","text=\"[Gender]\"")
	winset(src,"LabelType","text=\"[Class]\"")
	winset(src,"LabelName","text=\"[name]\"")

var/mob/tmp/sex_ticker = 1
mob
	verb/ToggleBlah2(blah as text)
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
		else if(blah=="Class")
			if(usr.isRace(NAMEKIAN))
				if(usr.Class=="Warrior")
					usr.Class="Dragon"
				else if(usr.Class=="Dragon")
					usr.Class="Warrior"
				else if(usr.Class=="Fighter")
					usr.Class="Warrior"

			usr.RacialStats()
			spawn()usr.UpdateBio()

		else if(blah=="Sex")
			var/list/options = usr.race.gender_options
			var/current_index = options.Find(usr.Gender)

			if (current_index != -1)
				var/next_index = (current_index + 1) % (options.len+1)
				if(next_index == 0)
					next_index = 1
				usr.Gender = options[next_index]
			else
				usr.Gender = options[1]

			usr.RacialStats()
			usr.UpdateBio()

			if(usr.Gender == "Male")
				usr.icon = race.icon_male
			else if(usr.Gender == "Female")
				usr.icon = race.icon_female
			else if(usr.Gender == "Neuter")
				usr.icon = race.icon_neuter

mob/var/Plan=1
mob/var/Rac=1
mob/var/Tin=1

var/list/SagaLockOut=list()
var/list/RaceLock=list()
var/list/TechLockOut=list()

mob/var/tmp/race_index = 1

mob/proc/UpdateRaceScreen(change)
	var/race/r

	//TODO: pretty sure this can cause issues if theres absolutely nothing unlocked. would be smart to have a bail-out.
	while (1)
		if(change)
			if (change > 0)
				race_index++
				if (race_index > races.len)
					race_index = 1
			else
				race_index--
				if (race_index == 0)
					race_index = races.len

		r = races[race_index]
		if (CheckUnlock(r))
			break

	setRace(r)
	var/list/options = usr.race.gender_options
	var/current_index = options.Find(usr.Gender)

	if (current_index != -1)
		var/next_index = (current_index + 1) % (options.len+1)
		if(next_index == 0)
			next_index = 1
		usr.Gender = options[next_index]
	else
		usr.Gender = options[1]
	winset(src,"RaceName","text=[race.name]")
	winset(usr,"Iconz","image=[race.visual]")
	src << output(race.desc,"raceblurb")

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
				if(mob.isRace(MAJIN))
					if(!mob.majinPassive)
						mob.majinPassive = new(mob)
					if(!mob.majinAbsorb)
						mob<<"lacking majin absorb"
						mob.majinAbsorb = new()
						mob.findAlteredVariables()

				var/donator/d_info = donationInformation.getDonator(key = src.key)
				var/supporter/s_info = donationInformation.getSupporter(key = src.key)
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
		LOL.race = race
		LOL.setRace(race)
		src.client.mob=LOL
		del(src)

	Finalize(var/Warped=0)
		src.Hair_Forms()
		src.Hairz("Add")
		resetStats = FALSE
		if(src.Tail)
			src.Tail(1)
		src.ChargeIcon=image('BlastCharges.dmi',"[rand(1,9)]")
		src.Text_Color=pick("#4de31","#86bd1a","#31cd6f","#5cb3aa","#6297c3","#7071a8", "#8f70a8", "#b382dc", "#c9628a")
		src.OOC_Color=pick("#4de31","#86bd1a","#31cd6f","#5cb3aa","#6297c3","#7071a8", "#8f70a8", "#b382dc", "#c9628a")
		src.Emote_Color = pick("#de9f31","#5cb37f","#30a498","#c1db30","#708fa8","#dd7047", "#df4f19", "#e34381")

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

		race.onFinalization(src)

		src.StrOriginal=src.StrMod
		src.EndOriginal=src.EndMod
		src.SpdOriginal=src.SpdMod
		src.ForOriginal=src.ForMod
		src.OffOriginal=src.OffMod
		src.DefOriginal=src.DefMod
		src.RecovOriginal=src.RecovMod
		src.SetVars()

		if(!Warped)
			if(src.Race=="Alien"||isRace(BEASTMAN)||isRace(YOKAI))
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

			if(!src.Timeless)
				if(!(src.race in list(YOKAI,BEASTMAN,ELDRITCH,SAIYAN)))//these bois spawn in with deathtimers if theyre elder...
					//beastman monsters as elders would spawn in with death timers; yokai would be more powerful; eldritch dont even get this choice
					var/Age = "Youth"
					//=alert(src, "Do you want to start as a youth or an elder?  Youths have not yet reached their full potential as fighters. Elders have already passed it, and may teach younger folks.", "Age", "Youth", "Elder")
					src.EraBody=Age
					if(src.EraBody=="Youth")
						src.EraAge=global.Era-src.GetPassedEras("Youth")
						if(src.isRace(SAIYAN)||src.Race=="Half Saiyan")
							src.Tail(1)
					else
						src.EraAge=global.Era-src.GetPassedEras("Elder")
						if(src.isRace(SAIYAN)||src.Race=="Half Saiyan")
							src.Tail(1)
				else
					src.EraBody="Youth"
					src.EraAge=global.Era-src.GetPassedEras("Youth")
			else
				src.EraAge=-4
				if(isRace(ELDRITCH) || src.isRace(MAJIN))
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
