obj/Items/Sword/Heavy/Legendary/WeaponSoul/Sword_of_Hope//Durendal
	name="Sword of Hope"
	icon='Durendal.dmi'
	passives = list("ShockwaveBlows" = 1, "ArmorPeeling" = 1)
	Destructable=0
	ShatterTier=0

obj/Skills/AutoHit/Shockwave_Blows
	Area="Circle"
	Distance=5
	AdaptRate = 1
	GuardBreak=1
	DamageMult=1
	Knockback=2
	Cooldown=1
	Shockwaves=1
	Shockwave=3
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	ActiveMessage="swings their blade hard enough to make the air ripple!"
	EnergyCost=5


obj/Skills/Queue/Blazing_Slash
	ActiveMessage="channels the might of ancient saints into a slash worthy of a pyre!"
	DamageMult=4
	AccuracyMult=3
	KBMult=3
	SweepStrike=1
	Burning = 25
	Duration = 5
	Cooldown=30
	NeedsSword=1
	EnergyCost=5
	HitSparkIcon='Fire Slash.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkSize=1.5
	verb/Blazing_Slash()
		set category="Skills"
		usr.SetQueue(src)

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Durendal
	name = "Heavenly Regalia: The Saint"
	StrMult=1.3
	EndMult=1.3
	DefMult=1.3
	passives = list("ShockwaveBlows" = 1, "HolyMod" = 2)
	IconLock='EyeFlameC.dmi'
	ActiveMessage="'s legendary weapon and horn ring in resonance: Heavenly Regalia!"
	OffMessage="'s treasures lose their Saintly luster..."
	verb/Heavenly_Regalia()
		set category="Skills"
		src.Trigger(usr)