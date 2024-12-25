obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Glory//Caledfwlch
	name="Sword of Glory"
	icon='Caledfwlch.dmi'
	pixel_x=-31
	pixel_y=-30
	var/caledLight = TRUE
	passives = list("SpiritSword" = 0.25)

// it gets excalibur

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Caledfwlch
	name = "Heavenly Regalia: The King"
	StrMult=1.5
	EndMult=1.5
	passives = list("CriticalBlock" = 0.25, "Juggernaut" = 0.5, "Reversal" = 0.5, "BlockChance" = 25)
	IconLock='EyeFlameC.dmi'
	ActiveMessage="resonates their royal treasures: Heavenly Regalia!"
	OffMessage="'s treasures loses their royal luster..."
	verb/Heavenly_Regalia()
		set category="Skills"
		src.Trigger(usr)
#warn MAKE EXCALIBUR COOLER
obj/Skills/Projectile/Weapon_Soul
	Excalibur
		IconLock='Excaliblast.dmi'
		ActiveMessage = "lets loose a slash full of Promised Victory: Excalibur!"
		LockX=-50
		LockY=-50
		DamageMult=1
		AccMult=25
		MultiHit=6
		Knockback=1
		Radius=3
		ZoneAttack=1
		ZoneAttackX=0
		ZoneAttackY=0
		FireFromSelf=1
		FireFromEnemy=0
		Explode=3
		StrRate=1
		ForRate=1
		EndRate=1
		Trail='ExcaliTrail.dmi'
		TrailDuration=1
		Dodgeable=-1
		Deflectable=-1
		HolyMod=5
		Distance=100
		Cooldown = 60
		verb/Excalibur()
			set category = "Skills"
			usr.UseProjectile(src)

	Excalibur_Morgan
		IconLock='DExcaliblast.dmi'
		ActiveMessage = "lets loose a slash full of Promised Victory: Excalibur Morgan!"
		LockX=-50
		LockY=-50
		DamageMult=0.25
		AccMult=25
		MultiHit=25
		Trail='Trail - Scorpio.dmi'
		TrailDuration=1
		Knockback=1
		Radius=3
		ZoneAttack=1
		ZoneAttackX=0
		ZoneAttackY=0
		FireFromSelf=1
		FireFromEnemy=0
		Explode=3
		StrRate=1
		ForRate=1
		EndRate=1
		Dodgeable=-1
		Deflectable=-1
		Distance=100
		Cooldown = 90
		verb/Excalibur_Morgan()
			set category = "Skills"
			usr.UseProjectile(src)
