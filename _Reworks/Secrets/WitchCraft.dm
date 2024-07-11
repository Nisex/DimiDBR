/**
 * 
 * https://docs.google.com/document/d/1sX9XgPEc-sWZ3RnSV4ujga0DnGVbiYtqQV7S6mkpHLw/edit
 * 
 * 
 */

// Soul for Power
obj/proc/SunderSoul(mob/P, mob/G)
	if(!P.client)
		return
	var/yesno = input(P, "You are proposed a trade, for your soul, for power by [G]. Do you accept this trade?", "Sunder your soul") in list("Yes", "No")
	
	switch(yesno)
		if("Yes")
			if(P.NoSoul)
				view(20)<< output("<font color=yellow>[P] lacks a soul to strike the deal !", "output")
				return
			view(20)<< output("<font color=yellow>[P] has accepted the deal !", "output")
			for(var/obj/WitchCraft/WitchesBook/s in G.contents)
				s.PactedList += P
				P.AddSkill(new/obj/Skills/Buffs/Witch_Style)
				P.AddSkill(new/obj/Skills/AutoHit/Dream_Walk)
				P.AddSkill(new/obj/Skills/AutoHit/Hex)
				P.AddSkill(new/obj/Skills/Queue/Grave_Curse)
				P.NoSoul = 1
		if("No")
			view(20)<< output("<font color=yellow>[P] has declined the deal !", "output")
obj/proc/checkIfNoPassives(mob/who)
	if(who.passive_handler.Get("Maki"))
		world << "tes"
		return
	else
		world << "test"
		who.passive_handler.Set("Maki", 1)

mob/Admin3/verb/GiveWitchBook()
	var/mob/who = input(usr, "Who do you wish to grant this crack book") in players
	var/obj/WitchCraft/WitchesBook/G = new
	G.loc = who
	who.passive_handler.Set("Maki", 1)
	who.AddSkill(new/obj/Skills/Buffs/Witch_Style)
	who.AddSkill(new/obj/Skills/AutoHit/Dream_Walk)
	who.AddSkill(new/obj/Skills/AutoHit/Hex)
	who.AddSkill(new/obj/Skills/Queue/Grave_Curse)

/obj/Skills/Buffs/Witch_Style
	StyleStr = 1.3
	StyleFor = 1.3
	StyleSpd = 1.1
	StyleDef = 1.1
	ElementalClass="Witch"
	StyleActive="Witch"
	ElementalOffense="Felfire"
	Finisher="/obj/Skills/Queue/Finisher/Shifting_Clouds"
	verb/Witch_Style()
		set hidden=1
		src.Trigger(usr)


/obj/WitchCraft/WitchesBook
	var/CurrentEssenceAmount = 0
	var/TakeEssenceCoolDown
	var/list/PactedList = list()
	
	verb/Kill_Essence(mob/M in get_step(usr, usr.dir))
		set name = "Drain Essence"
		set category = "Skills"
		if(!M.KO)
			return       
		var/kill = input(usr, "You're about to kill [M], by ripping apart his soul from his body, creating nothing but a husk behind, are you sure?") in list("Yes", "No")
		switch(kill)
			if("Yes")
				var/confirm = input(M, "You're about to be killed by [usr], if there has been any rules broken, please hit no, else, hit yes.") in list("Yes","No")
				switch(confirm)
					if("Yes")
						M.NoSoul = 1
						M.Death(src, "Witchery, has stolen their soul")
	
	verb/Take_Essence(mob/M in get_step(usr, usr.dir))
		set name = "Take Essence"
		set category = "Skills"
		if(!M.KO)
			return
		if(TakeEssenceCoolDown < world.time )
			CurrentEssenceAmount += 1
			view(10) << output("<font color=red>[M] feels as if their body decays slightly at the magic of [usr]..!!", "output")
			TakeEssenceCoolDown += 2500
		else 
			usr << "You're on cooldown till for... till [time2text(world.time, "Day/hh/mm/ss")]"

	verb/Give_Essence()
		set name = "Give Essence"
		set category = "Skills"
		var/list/PeopleWithBooks = list("Cancel", "----")

		for(var/mob/M in oview(20, src))
			if(locate(/obj/WitchCraft/WitchesBook, M))
				PeopleWithBooks.Add(M)

		var/mob/who = input(usr, "Which of these people do you wish to give your Essence to?") in PeopleWithBooks
		if(src.CurrentEssenceAmount > 0)
			var/give = input(usr, "You have currently [src.CurrentEssenceAmount], how many of them do you wish to give to [who]?", "Give Essence") as num
			if((src.CurrentEssenceAmount - give) < 0)
				return
			else 
				for(var/obj/WitchCraft/WitchesBook/G in who)
					G.CurrentEssenceAmount += give

	verb/Change_BookName()
		set name = "Change Tome Name"
		set category = "Roleplay"
		src.name = input(usr, "Your book has been tailored out for you, you can select a new name for it.", "Rename Book") as text

	verb/Make_Deal(mob/M in get_step(usr, usr.dir))
		set name = "Witch Apprenticeship"
		set category = "Roleplay"
		SunderSoul(M, usr)
	
	verb/FelMasterwork()
		if(src.CurrentEssenceAmount > 20)
			var/list/weapons = list()
			for(var/obj/Items/Sword/Weapon in usr)
				weapons += Weapon
			var/obj/Items/Sword/Weapon = input(usr, "Select which of the weapons you wish to Fel-Masterwork", "Fel Masterwork") in weapons
			Weapon.Element = "Felfire"
			src.CurrentEssenceAmount -= 20

/obj/Skills/AutoHit/Dream_Walk
	Area= "Area"
	AdaptRate= 1
	DamageMult= 6
	Rounds= 1
	TurfStrike=1
	TurfShift='Icons/NSE/spells/cast/cruel_thesis.dmi'
	TurfShiftDuration=3
	PreShockwave= 0
	Cooldown= 120
	Earthshaking= 20
	WindupMessage= "hosts up their hand....!!!"
	ActiveMessage= "slams their hand against the ground, corrupting the ground beneath..!!!"
	ComboMaster = 1
	verb/Dream_Walk()
		set category="Skills"
		var/resource = 0
		for(var/obj/WitchCraft/WitchesBook/G in usr)
			resource = G.CurrentEssenceAmount
		if(resource > 3)
			for(var/obj/WitchCraft/WitchesBook/G in usr)
				G.CurrentEssenceAmount -= 3
			usr.Activate(src)
		else
			usr << "Not enough Essence [resource] / 3"

/obj/Skills/AutoHit/Hex
	Area = "Around Target"
	DamageMult= 2
	Rounds= 1
	TurfDirt= 1
	ShockIcon= 'Icons/NSE/spells/cast/KrysiaHitspark2.dmi'
	Shockwave= 4
	Shockwaves= 1
	PostShockwave= 1
	PreShockwave= 0
	Cooldown= 150
	ManaCost = 50
	WindupMessage= "hosts up their hand....!!!"
	ActiveMessage= "slams their hand against the ground, corrupting the ground beneath..!!!"
	ComboMaster = 1
	BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Witch/HexDebuff"
	verb/Hex()
		set category="Skills"
		adjust(usr.Target)
		usr.Activate(src)


/obj/Skills/Buffs/SlotlessBuffs/Witch/HexDebuff
	StrMult = 0.5
	ForMult = 0.5
	SlowAffected = 1
	IconLock = 'SweatDrop.dmi'
	TimerLimit = 30


/obj/Skills/Queue/Grave_Curse
	ActiveMessage="fills the air with terrible images....!!"
	HitMessage="curses their opponents mind with horrible images...!!"
	DamageMult = 10 
	AccuracyMult = 1.175
	Instinct = 1
	Duration = 5
	KBMult = 0.00001
	Cooldown = 150
	Quaking = 5
	PushOut = 5
	PushOutWaves = 3
	PushOutIcon = 'Icons/NSE/spells/cast/KrysiaExplosion.dmi'
	verb/Grave_Curse()
		set category="Skills"
		var/resource = 0
		for(var/obj/WitchCraft/WitchesBook/G in usr)
			resource = G.CurrentEssenceAmount
		if(resource > 5)
			for(var/obj/WitchCraft/WitchesBook/G in usr)
				G.CurrentEssenceAmount -= 5
			usr.Activate(src)
		else
			usr << "Not enough Essence [resource] / 5"
		usr.SetQueue(src)


/obj/Skills/Queue/Finisher/Sundered_Sky
	DamageMult=6.5
	PushOutWaves=0
	PushOut=0
	Combo=4
	Rapid=1
	BuffSelf=0
	HitMessage=0

/obj/Skills/Queue/Mirror_Match
	ActiveMessage="fills their "
	HitMessage="drives the drill into their opponent!"
	Counter=1
	NoWhiff=1	
	DamageMult = 0.1
	AccuracyMult = 1.175
	Instinct = 1
	Duration = 5
	KBMult = 0.00001
	Cooldown = 150
	BuffSelf = "/obj/Skills/Buffs/SlotlessBuffs/Witch/Counter"
	verb/Mirror_Match()
		set category="Skills"
		var/resource = 0
		for(var/obj/WitchCraft/WitchesBook/G in usr)
			resource = G.CurrentEssenceAmount
		if(resource > 5)
			for(var/obj/WitchCraft/WitchesBook/G in usr)
				G.CurrentEssenceAmount -= 5
			usr.Activate(src)
		else
			usr << "Not enough Essence [resource] / 5"
			usr.SetQueue(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/WitchCounter
	DefMult = 1.3 // ur crazy
	CounterSpell = 1
	BuffName = "WitchCounter"
	TimerLimit = 30
