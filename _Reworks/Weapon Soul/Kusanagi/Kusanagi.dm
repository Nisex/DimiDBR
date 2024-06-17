obj/Items/Sword/Medium/Legendary/WeaponSoul/Sword_of_Faith // Kusanagi
	name="Sword of Faith"
	icon='KusanagibutSharper.dmi'
	pixel_x=-16
	pixel_y=-16
	passives = list("MagicSword" = 1, "ManaSteal" = 2, "WindRelease" = 1)
	MagicSword=1
	TierTechniques=list(null, null, null, null, "/obj/Skills/Buffs/SlotlessBuffs/Totsuka_no_Tsurugi", null)

obj/Skills/AutoHit/Gale_Slash
	NeedsSword = 1
	Area="Circle"
	Distance=2
	StrOffense=1
	DamageMult=2
	ManaDrain = 2
	Launcher=3
	NoLock=1
	NoAttackLock=1
	Cooldown=90
	Size=2
	Rounds=5
	Icon='SweepingKick.dmi'
	IconX=-32
	IconY=-32
	EnergyCost=1
	CanBeDodged=1
	Knockback = 5
	ActiveMessage="lets loose a sweeping gale of wind towards their enemies!"
	verb/Gale_Slash()
		set category="Skills"
		usr.Activate(src)