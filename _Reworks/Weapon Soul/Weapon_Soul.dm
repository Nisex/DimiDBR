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

			if(3)
				switch(WeaponSoulType)
					if("Kusanagi")