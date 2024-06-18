mob/proc/gainWeaponSoul()
	src << "You feel your soul resonate with a weapon..."
	src.Saga="Weapon Soul"
	src.SagaLevel=1
	src.AddSkill(new/obj/Skills/Buffs/ActiveBuffs/Weapon_Soul)
	var/list/openSwords = glob.WeaponSoulNames
	if(!glob.infWeaponSoul)
		openSwords = glob.getOpen("WeaponSoul")
		if(openSwords.len<1)
			glob.ResetSwords()
	WeaponSoulType = input("Which sword resonates with your soul?") in openSwords
	switch(WeaponSoulType)
		if("Kusanagi")
			new/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Faith(src)
			src.AddSkill(new/obj/Skills/AutoHit/Gale_Slash)

		if("Durendal")
			new/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Sword_of_Hope(src)
			src.AddSkill(new/obj/Skills/Queue/Blazing_Slash)

		if("Dainsleif")
			new/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Ruin(src)
			src.AddSkill(new/obj/Skills/Queue/Cursed_Blade)

		if("Caledfwlch")
			new/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Glory(src)
			AddSkill(new/obj/Skills/Projectile/Beams/Big/Weapon_Soul/Excalibur)

		if("Muramasa")
			new/obj/Items/Sword/Light/Legendary/WeaponSoul/Bane_of_Blades(src)
			AddSkill(new/obj/Skills/AutoHit/Deathbringer)

		if("Masamune")
			new/obj/Items/Sword/Light/Legendary/WeaponSoul/Sword_of_Purity(src)
			AddSkill(new/obj/Skills/AutoHit/Divine_Cleansing)

		if("Soul Calibur")
			new/obj/Items/Sword/Medium/Legendary/WeaponSoul/Blade_of_Order(src)
			AddSkill(new/obj/Skills/AutoHit/Crystal_Tomb)

		if("Soul Edge")
			new/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Blade_of_Chaos(src)

		if("Ruyi Jingu Bang")
			new/obj/Items/Sword/Wooden/Legendary/WeaponSoul/RyuiJinguBang(src)

		if("Guan Yu")
			new/obj/Items/Sword/Heavy/Legendary/WeaponSoul/Spear_of_War(src)
			AddSkill(new/obj/Skills/AutoHit/War_God_Descent)

mob/tierUpSaga(Path)
	..()
	if(Path == "Weapon Soul")
		switch(SagaLevel)
			if(2)
				switch(WeaponSoulType)
					if("Kusanagi")
						src.contents += new/obj/Items/Yata_no_Kagami
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Yata_no_Kagami/Mirror_Protection)
						src.AddSkill(new/obj/Skills/Yata_no_Kagami/Mirror_Prison)

					if("Durendal")
						passive_handler.Increase("TeamFighter")
						src.AddSkill(new/obj/Skills/AutoHit/Blow_The_Horn)
						src.AddSkill(new/obj/Skills/Companion/PlayerCompanion/Squad/Oilphant)

					if("Dainsleif")
						passive_handler.Increase("CursedSheath")

					if("Caledfwlch")
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Avalon)

					if("Muramasa")
						passive_handler.Increase("CriticalChance", 5)
						passive_handler.Increase("CriticalHit", 0.2)
						AddSkill(new/obj/Skills/AutoHit/Masterful_Death)

					if("Masamune")
						passive_handler.Increase("RefreshingBlows")

					if("Masamune")
						for(var/obj/Items/Sword/Light/Legendary/WeaponSoul/Sword_of_Purity/masamune in contents)
							masamune.Element = "Light"
						src.AddSkill(new/obj/Skills/AutoHit/Purifying_Frost)


			if(3)
				switch(WeaponSoulType)
					if("Kusanagi")
						src.contents += new/obj/Items/Yasakani_no_Magatama
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Yasakani_no_Magatama/Bead_Constraint)

					if("Durendal")
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Durendal_Relics/Saints_Tooth)
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Durendal_Relics/Saints_Blood)
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Durendal_Relics/Saints_Raiment)
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Durendal_Relics/Saints_Hair)

					if("Dainsleif")
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Niohoggrs_Chains)

					if("Caledfwlch")
						src.contents += new/obj/Items/Armor/Plated_Armor/Noble_Armor
						AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Noble_Shield)

					if("Muramasa")
						for(var/obj/Items/Sword/Light/Legendary/WeaponSoul/Bane_of_Blades/muramasa in contents)
							muramasa.Element = "Dark"
							muramasa.passives = list("WeaponBreaker" = 2, "AbyssMod" = 4)
						passive_handler.Increase("PureDamage",2)
						SagaThreshold("Spd",1)
						SagaThreshold("Str",1)

					if("Masamune")
						src.AddSkill(new/obj/Skills/Buffs/SlotlessBuffs/Blessed_Guard)
						passive_handler.Increase("RefreshingBlows")

			if(4)
				switch(WeaponSoulType)
					if("Kusanagi")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Kusanagi)

					if("Durendal")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Durendal)

					if("Dainsleif")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Dainsleif)

					if("Caledfwlch")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Caledfwlch)

					if("Muramasa")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Muramasa)

					if("Masamune")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Masamune)
			if(5)
				switch(WeaponSoulType)
					if("Kusanagi")
						for(var/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Kusanagi/kusa in src.Buffs)
							kusa.passives["WindRelease"] = 2
							kusa.passives["PureDamage"] = 1
							kusa.passives["SwordAscension"] = 1
							kusa.passives["PureReduction"] = 1
							kusa.passives["ManaGeneration"] = 15

					if("Durendal")
						for(var/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Durendal/dura in src.Buffs)
							dura.passives["Juggernaut"] = 1
							dura.passives["Adrenaline"] = 1
							dura.passives["HolyMod"] = 4
							dura.passives["ShockwaveBlows"] = 1
							dura.passives["SwordAscension"] = 1

					if("Dainsleif")
						for(var/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Dainsleif/dainsleif in src.Buffs)
							dainsleif.passives["Instinct"] = 4
							dainsleif.passives["Adrenaline"] = 1
							dainsleif.passives["AbyssMod"] = 4
							dainsleif.passives["SwordAscension"] = 1

					if("Caledfwlch")
						for(var/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Caledfwlch/caled in src.Buffs)
							caled.passives["Xenobiology"] = 1
							caled.passives["CriticalChance"] = 10
							caled.passives["CriticalDamage"] = 0.5
							caled.passives["Pursuer"] = 2

					if("Muramasa")
						for(var/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Muramasa/muramasa in src.Buffs)
							muramasa.passives["KillerInstinct"] = 1
							muramasa.passives["DemonicDurability"] = 2
							muramasa.passives["TechniqueMastery"] = 2

					if("Masamune")
						src.AddSkill(new/obj/Skills/Utility/Death_Killer)
						for(var/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Masamune/masamune in src.Buffs)
							masamune.passives["Unstoppable"] = 1
							masamune.passives["LifeSteal"] = 10
							masamune.passives["HolyMod"] = 2

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia
	NeedsSword = 1