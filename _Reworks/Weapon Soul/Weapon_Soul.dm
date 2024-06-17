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
			new/obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Hope(src)
			src.AddSkill(new/obj/Skills/Queue/Blazing_Slash)

mob/tierUpSaga(Path)
	..()
	if(Path == "Weapon Soul")
		switch(SagaLevel)
			if(2)
				switch(WeaponSoulType)
					if("Kusanagi")
						src.contents += new/obj/Items/Yata_no_Kagami
						src.AddSkill(new/obj/Skills/Buffs/Slotless_Buffs/Yata_no_Kagami/Mirror_Protection)
						src.AddSkill(new/obj/Skills/Yata_no_Kagami/Mirror_Prison)

					if("Durendal")
						passive_handler.Increase("TeamFighter")
						src.AddSkill(new/obj/Skills/AutoHit/Blow_The_Horn)
						src.AddSkill(new/obj/Skills/Companion/PlayerCompanion/Squad/Oilphant)

			if(3)
				switch(WeaponSoulType)
					if("Kusanagi")
						src.contents += new/obj/Items/Yasakani_no_Magatama
						src.AddSkill(new/obj/Skills/Buffs/Slotless_Buffs/Yasakani_no_Magatama/Bead_Constraint)

					if("Durendal")
						src.AddSkill(new/obj/Skills/Buffs/Slotless_Buffs/Durendal_Relics/Saints_Tooth)
						src.AddSkill(new/obj/Skills/Buffs/Slotless_Buffs/Durendal_Relics/Saints_Blood)
						src.AddSkill(new/obj/Skills/Buffs/Slotless_Buffs/Durendal_Relics/Saints_Raiment)
						src.AddSkill(new/obj/Skills/Buffs/Slotless_Buffs/Durendal_Relics/Saints_Hair)

			if(4)
				switch(WeaponSoulType)
					if("Kusanagi")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Kusanagi)

					if("Durendal")
						src.AddSkill(new/obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Durendal)

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

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia
	NeedsSword = 1