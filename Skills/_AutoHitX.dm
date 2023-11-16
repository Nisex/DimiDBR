mob
	var
		tmp/AutoHitting//You can't autohit while you autohit.

obj
	Skills
		AutoHit
			Distance=1//Unless otherwise stated, assume it's a one tile attack of varying style.
			var/DistanceAround//this is only used for AroundTarget type techs.
			var
				NoPierce=0//If this is flagged it will make a technique terminate after hitting something.

				SwordOnly//TODO remove
				UnarmedOnly
				StanceNeeded
				ABuffNeeded
				SBuffNeeded
				GateNeeded
				//ClassNeeded

				DamageMult=1//Damage on top of whatever stat calculations.
				StepsDamage//Every step adds this value to damage mult.
				Knockback//Does the technique knockback?  If so, how far?

				//Cooldown

				//These four can be used in any combination.
				StrOffense//Uses STR for damage.
				ForOffense//Uses FOR for damage.
				EndDefense=1//Uses End for reduction.

				Area//variable to define what kind of hitzone to use.
				ChargeTech//Denotes if there is a charge
				ChargeTime//How much time it takes to move.
				ChargeFlight//superman tackle
				WindUp//Charge for this number of seconds.
				Slow//Makes it so that there is a pause in the movement of autohitters (The technique does not instantly hit all of its related tiles)

				Icon//Displays icon when used.
				IconX//Offsets.
				IconY
				IconZ
				Falling//should pixel_z animate towards 0?
				IconUnder=0
				IconTime=5//Duration of effect.
				Size//Makes icon bigger.
				ObjIcon//Makes autohit objects take on the appearance of the icon vars instead of the user.
				NoOverlay//Skip overlay code
				//These blend colors into the overlay
				IconRed=0
				IconGreen=0
				IconBlue=0


				Deluge//Makes water drown you
				Stasis//Makes you unable to do anything but can't be damaged.

				Rounds//Triggers multiple skillshots.
				RoundMovement=1//If this is 0, lock movement while using rounds.
				currentRounds
				DelayTime=1//time between attacks...
				NoLock//Doesn't lock autohitting.
				NoAttackLock

				Bang//defines if it causes an explosion on hit
				Bolt//shoot some lightning at motherfuckers
				BoltOffset //make lightning go scatter
				Scratch//scratch effects
				Punt//punch effects

				Divide//Great divide effect.
				TurfErupt//makes a boom
				TurfEruptOffset=0//affects the offset of booms
				TurfDirt//makes a boom
				TurfDirtOffset=0//affects the offset of dust
				TurfStrike
				TurfReplace//overlays this icon
				TurfShift//animates an image of another turf over existing
				TurfShiftLayer
				TurfShiftDuration=30
				TurfShiftDurationSpawn=10
				TurfShiftDurationDespawn=10
				Flash//Taiyoken effect

				WindupIcon=0
				WindupIconSize=1
				WindupIconUnder=0
				WindupIconX=0
				WindupIconY=0
				WindupMessage//Text for when the tech is triggered but not executed yet.
				WindupColor=rgb(255, 153, 51)//Holds a hex value for color
				WindupCustom//Allows for complete writing of text.
				ActiveMessage//Text for using the tech.
				ActiveColor=rgb(255,0,0)//Holds a hex value for color
				ActiveCustom//Allows for complete writing of text.

				HitSparkIcon//This holds the icon for a hitspark that will last as long as the autohit is being played out.
				HitSparkX=0
				HitSparkY=0
				HitSparkSize=1//The icon is scaled by this value.
				HitSparkTurns=0//Does it turn?  1 for yes, 0 for no.
				HitSparkCount=1
				HitSparkDispersion=8
				HitSparkDelay=1
				HitSparkLife=10

				FlickAttack//flicks the attack state.
				FlickSpin//flicks the KB state.
				Jump//jumps in the air
				Float//jumps in the air for a while longer

				PreShockwave//Does it happen before the attack?
				PreShockwaveDelay=0//Does it delay the attack itself?
				Shockwaves//How many rounds of shockwaves?
				Shockwave//How powerful of shockwaves? (reduces through numerous iterations)
				ShockIcon='fevKiai.dmi'//but you could make your own i guess...?
				ShockBlend=1//blend mode of shockwave
				ShockDiminish=2
				ShockTime=12
				PostShockwave=1//or after?

				Quaking//Makes the screen go shaka shaka.
				Earthshaking//as above but even if you miss
				PreQuake//gives people the jitters in windup

				//These variables are used to apply ki blade-like effects.
				TempStrOff
				TempForOff
				TempEndDef
				SpecialAttack=0//ignores all of the above

				ComboMaster//Does not lose damage against stunned and / or launched people.
				GuardBreak//Can't be dodged, blocked or reversaled.
				CanBeDodged//AIS can trigger and avoid these
				CanBeBlocked//You can whiff on these techniques

				PassThrough//teleport to the last autohit position.
				PassTo//place an afterimage next to damaged parties
				StopAtTarget//Stop at target for passthrough

				Thunderstorm//Make thunderstorm FX; value holds the range. - TODO: Remove with a lengthy turfshift with some kind of delayed animation?
				Gravity//Gravity FX; value holds the range. - TODO: Rework a good deal, remove with TurfShifts where possible
				Ice//Ice FX; value holds the range. - TODO: Remove, replace as above
				Hurricane//lock someone in a wind tunnel
				HurricaneDelay=1
				DarkCharge//evil sword technique FX

				Wander//At the end of the autohit's life, wander in random directions for this number of moves.
				Rush//Drives the user forward before deploying autohit.
				RushDelay=1
				ControlledRush//as above but you actually know where you're going
				MortalBlow//Makes you deal a mortal wound in midcombat.
				WarpAway//Toss them into a hole

				RipplePower=1//Holds a value for ripple empowerment

				ExtendMemory//So people cannot cheese their spirit sword into unlimited distance

				//these fucks just old old fucks
				OldHitSpark
				OldHitSparkX
				OldHitSparkY
				OldHitSparkTurns
				OldHitSparkSize

				RagingDemonAnimation = FALSE
				Executor // increase damage by x*10% while the enemy is under 25%, increased by 2x when they are under 5%
				SpeedStrike
				GrabMaster = FALSE
//NPC attacks
			Venom_Sting
				Area="Target"
				Distance=2
				DamageMult=1
				StrOffense=1
				EndDefense=1
				Toxic=2
				ActiveMessage="lashes out with their venomous sting!"
				HitSparkIcon='Hit Effect Wind.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=2
				HitSparkTurns=0
				Cooldown=30

			Sticky_Spray
				Area="Wave"
				Distance=3
				ForOffense=1
				EndDefense=1
				Crippling=2
				ActiveMessage="sprays some sticky silk!"
				Slow=0.5
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.5
				HitSparkTurns=1
				TurfStrike=4
				Cooldown=30

			Mush_Bonk
				Area="Wave"
				Distance=5
				StrOffense=1
				ForOffense=1
				EndDefense=0.75
				DamageMult=5
				Shattering=10
				ActiveMessage="bonks their head on the ground to rupture it!"
				Slow=0.5
				HitSparkIcon='Hit Effect Wind.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=2
				HitSparkTurns=0
				TurfStrike=3
				Cooldown=30


//Auto^2hits
			Explosive_Finish
				StrOffense=1
				ForOffense=1
				DamageMult=3
				Area="Circle"
				Distance=4
				TurfErupt=2
				TurfEruptOffset=3
				Slow=1
				Knockback=10
				ActiveMessage="detonates the energy held within their weapon!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Cooldown=4
				Earthshaking=15

			Cat_Claw_Rush
				Area="Arc"
				NoLock=1
				NoAttackLock=1
				Distance=1
				DamageMult=1
				StrOffense=1
				EndDefense=1
				Knockback=1
				Rounds=10
				ChargeTech=1
				ChargeTime=0.75
				ActiveMessage="chases their enemy down with raking cat claws!"
				HitSparkIcon='WolfFF.dmi'
				HitSparkX=0
				HitSparkY=0
				HitSparkTurns=1
				HitSparkDispersion=14
				HitSparkLife=7
				Cooldown=4
			Shatter_Shell
				Area="Target"
				NoLock=1
				NoAttackLock=1
				Distance=2
				DamageMult=3
				StrOffense=1
				EndDefense=1
				Knockback=10
				PassThrough=1
				ActiveMessage="blasts through their opponent with a destructive punch!"
				HitSparkIcon='Hit Effect Wind.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=3
				HitSparkTurns=0
				HitSparkLife=7
				Cooldown=4
			Blooming_Moon
				Area="Cross"
				NoLock=1
				NoAttackLock=1
				Distance=2
				Rounds=5
				Instinct=1
				DamageMult=1.5
				StrOffense=1
				EndDefense=1
				ActiveMessage="blossoms with a webwork of bladeplay!"
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkSize=1
				HitSparkTurns=1
				HitSparkLife=7
				TurfStrike=3
				Cooldown=4
			Strongest_Fist
				Area="Wide Wave"
				NoLock=1
				NoAttackLock=1
				Distance=5
				DistanceAround=5
				DamageMult=5
				StrOffense=1
				EndDefense=1
				Knockback=10
				ActiveMessage="follows up with an enormously destructive punch!!"
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=3
				HitSparkTurns=0
				HitSparkLife=7
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=30
				Cooldown=4
			Flamberge_Shot
				Area="Wide Wave"
				NoLock=1
				NoAttackLock=1
				Distance=5
				DamageMult=3
				StrOffense=0.75
				ForOffense=0.75
				EndDefense=1
				Knockback=10
				Scorching=20
				ActiveMessage="follows up with an incendiary kick!!"
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=3
				HitSparkTurns=0
				HitSparkLife=7
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=30
				Cooldown=4
			Drunken_Crash
				NoLock=1
				NoAttackLock=1
				Area="Wave"
				StrOffense=1
				Distance=7
				DelayTime=7
				Rounds=7
				DamageMult=0.8
				PassThrough=1
				GuardBreak=1
				ActiveMessage="begins to stumble through the battlefield like a drunken hobo!"
				HitSparkIcon='Hit Effect Oath.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=1
				HitSparkCount=2
				HitSparkDispersion=16
				TurfStrike=1
				Instinct=1
				Cooldown=4
			Galaxy_Clothesline
				NoLock=1
				NoAttackLock=1
				Area="Circle"
				StrOffense=1
				Distance=7
				Rounds=7
				DamageMult=0.8
				ChargeTech=1
				ChargeTime=0.5
				Knockback=1
				GuardBreak=1
				ActiveMessage="crashes through all in their path with a galactic clothesline!"
				HitSparkIcon='Hit Effect Oath.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=1
				HitSparkCount=2
				HitSparkDispersion=16
				TurfStrike=1
				Instinct=1
				Cooldown=4
			Blitz_Rush
				Area="Circle"
				NoLock=1
				NoAttackLock=1
				RoundMovement=1
				Distance=2
				DamageMult=0.6
				Rounds=10
				StrOffense=0.5
				ForOffense=0.5
				EndDefense=1
				Paralyzing=5
				ActiveMessage="continues their momentum with a rush of strikes!!"
				HitSparkIcon='Hit Effect Oath.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=3
				HitSparkTurns=0
				HitSparkLife=7
				Cooldown=4
			Divide_Effect
				Area="Arc"
				NoLock=1
				NoAttackLock=1
				Distance=5
				Instinct=1
				DamageMult=9
				StrOffense=1
				EndDefense=0.75
				ActiveMessage="ruptures the ground with their mega-powerful slash!"
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1
				HitSparkTurns=1
				HitSparkLife=7
				HitSparkSize=3
				TurfStrike=3
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=30
				Cooldown=4
			Flowing_Slash_Follow_Up
				Area="Strike"
				NoLock=1
				NoAttackLock=1
				Distance=10
				Instinct=4
				DamageMult=12
				StrOffense=1
				EndDefense=1
				ActiveMessage="lashes out with an elegant singular strike!"
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkSize=1
				HitSparkTurns=0
				HitSparkLife=7
				HitSparkSize=3
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=30
				Cooldown=4
			Whirlwind_Handstand
				Area="Circle"
				NoLock=1
				NoAttackLock=1
				RoundMovement=0
				Distance=1
				Instinct=4
				DamageMult=4
				Rounds=2
				StrOffense=1
				EndDefense=1
				WindUp=0.5
				WindupMessage="sets themselves into a handstand..."
				ActiveMessage="lets their legs rip like a top!!"
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkSize=1
				HitSparkTurns=1
				HitSparkLife=10
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				IconTime=10
				Cooldown=4
			Shunshin_Massacre
				Area="Target"
				NoLock=1
				NoAttackLock=1
				Distance=10
				Instinct=4
				DamageMult=2
				Rounds=5
				DelayTime=30
				GuardBreak=1
				StrOffense=1
				EndDefense=1
				PassThrough=1
				ActiveMessage="rips through their opponent with rapid godspeed slashes!"
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkSize=2
				HitSparkTurns=1
				HitSparkLife=10
				IconTime=10
				Cooldown=4
			Stop_Effect
				Area="Around Target"
				NoLock=1
				NoAttackLock=1
				Distance=15
				DistanceAround=5
				Stunner=5
				DamageMult=4
				StrOffense=0
				ForOffense=1
				GuardBreak=1
				SpecialAttack=1
				Crippling=5
				HitSparkIcon='Magic Time circle.dmi'
				HitSparkX=0
				HitSparkY=0
				HitSparkDispersion=0
				TurfShift='Gravity.dmi'
				TurfShiftLayer=MOB_LAYER+1
				TurfShiftDuration=0
				TurfShiftDurationSpawn=3
				TurfShiftDurationDespawn=7
				Cooldown=4
				Instinct=1
			Dark_Blast
				Area="Around Target"
				NoLock=1
				NoAttackLock=1
				Distance=5
				DistanceAround=4
				Knockback=15
				DamageMult=3
				StrOffense=1
				ForOffense=1
				GuardBreak=1
				SpecialAttack=1
				Crippling=5
				TurfShift='Gravity.dmi'
				TurfShiftLayer=MOB_LAYER+1
				TurfShiftDuration=0
				TurfShiftDurationSpawn=3
				TurfShiftDurationDespawn=7
				Cooldown=4
				Instinct=1
			Clothesline_Effect
				Area="Circle"
				StrOffense=1
				DamageMult=0.5
				Rounds=10
				ChargeTech=1
				ChargeTime=1
				Knockback=1
				Cooldown=4
				Size=1
				Instinct=1
			Dancing_Blade_Effect
				Area="Circle"
				StrOffense=1
				DamageMult=0.5
				Rounds=15
				RoundMovement=1
				Size=2
				Distance=2
				Instinct=1
				Icon='MagicWish.dmi'
				IconX=-8
				IconY=-8
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.5
				HitSparkTurns=0
				Cooldown=4
				Instinct=1
			Tatsumaki_Effect
				UnarmedOnly=1
				NoLock=1
				NoAttackLock=1
				Area="Circle"
				StrOffense=1
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				Size=1
				DamageMult=0.25
				ManaCost=0
				Rounds=10
				ChargeTech=1
				ChargeTime=0.75
				ActiveMessage="lifts themselves into the air with the speed of endless rapid kicks!"
				Cooldown=4
				Instinct=1
			Knockoff_Wave
				Area="Circle"
				SpecialAttack=1
				GuardBreak=1
				StrOffense=0.5
				ForOffense=0.5
				DamageMult=1
				Distance=2
				Launcher=1
				NoAttackLock=1
				NoLock=1
				Cooldown=4
////Keyblade
			FeverPitch
				Area="Arc"
				NoLock=1
				StrOffense=1
				DamageMult=3
				Distance=5
				Instinct=1
				TurfStrike=1
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=2
				HitSparkTurns=0
				ActiveMessage="swings their blade, sending out an arc of energy!"
				Cooldown=4
				NoAttackLock=1
				NoLock=1
			FatalMode
				Area="Circle"
				StrOffense=1
				DamageMult=3
				Distance=5
				Slow=1
				FlickAttack=1
				Instinct=1
				ShockIcon='KenShockwaveGold.dmi'
				Shockwave=4
				Shockwaves=1
				PostShockwave=0
				PreShockwave=1
				HitSparkIcon='Hit Effect Ripple.dmi'
				ActiveMessage="slams their blade into the ground!"
				Cooldown=4
				NoAttackLock=1
				NoLock=1
			MagicWish
				Area="Circle"
				ForOffense=1
				DamageMult=0.2
				Rounds=15
				RoundMovement=1
				Size=2
				Distance=2
				Instinct=1
				Icon='MagicWish.dmi'
				IconX=-8
				IconY=-8
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.5
				HitSparkTurns=0
				ActiveMessage="spins in a dance-like fashion!"
				Cooldown=4
				NoAttackLock=1
				NoLock=1
			CycloneCharge
				Area="Circle"
				Distance=1
				DamageMult=0.2
				Knockback=1
				Rounds=25
				StrOffense=1
				ChargeTech=1
				ChargeTime=1
				Instinct=1
				Icon='Tornado.dmi'
				IconX=-8
				IconY=-8
				ActiveMessage="bursts forward while spinning rapidly!"
				//Doesn't get a verb because it is cast from melee.
				NoAttackLock=1
				NoLock=1
				Cooldown=4

			Atomic_Crush
				Area="Circle"
				StrOffense=1
				ForOffense=1
				NoLock=1
				NoAttackLock=1
				DamageMult=5
				Distance=7
				Instinct=2
				Jump=2
				GuardBreak=1
				ActiveMessage="follows up with an atom-splitting high kick!"
				Slow=0.5
				HitSparkIcon='fevExplosion - Susanoo.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				Cooldown=4

			Tensho_Juji_Ho
				Area="Wave"
				StrOffense=1
				ForOffense=1
				NoAttackLock=1
				ComboMaster=1
				DamageMult=10
				Distance=6
				Flash=1
				Rush=15
				Instinct=2
				ControlledRush=1
				WindUp=0.5
				ShockIcon='KenShockwaveGold.dmi'
				Shockwave=4
				Shockwaves=1
				PostShockwave=0
				PreShockwave=1
				WindupIcon='Ripple Radiance.dmi'
				WindupIconUnder=1
				WindupIconX=-32
				WindupIconY=-32
				WindupIconSize=1
				GuardBreak=1
				PassThrough=1
				Knockback=0
				ActiveMessage="launches into a powerful aerial attack and glides through their opponents defenses!"
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkCount=10
				HitSparkTurns=1
				HitSparkDispersion=16
				HitSparkDelay=1
				Cooldown=4

			WingbladeFlash
				Area="Circle"
				StrOffense=1
				ForOffense=1
				EndDefense=0.5
				DamageMult=2.5
				Jump=2
				Knockback=5
				Distance=4
				Flash=3
				SpecialAttack=1
				Instinct=1
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				TurfShift='BrightDay2.dmi'
				TurfShiftLayer=EFFECTS_LAYER
				TurfShiftDuration=-10
				TurfShiftDurationSpawn=0
				TurfShiftDurationDespawn=5
				ActiveMessage="stabs their light blades into the ground, causing them to erupt into a bright flash!"
				NoAttackLock=1
				NoLock=1
				Cooldown=4
				//Doesn't get a verb because it is cast from melee.
				Cooldown=4
			BladeChargeRave
				Area="Circle"
				NeedsSword=1
				StrOffense=1
				ForOffense=1
				RoundMovement=1
				DamageMult=0.2
				Rounds=20
				WindUp=0.5
				WindupMessage="engorges their energy blade with a massive amount of magic!"
				Size=2
				Distance=2
				Instinct=1
				Icon='BladeCharge.dmi'
				IconX=-32
				IconY=-32
				HitSparkIcon='Slash - Zero.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.5
				HitSparkTurns=1
				ActiveMessage="tears through their surroundings with a series of reckless swings!"
				//Doesn't get a verb because it is cast from melee.
				Cooldown=4

////Vampirism
			CallBlood
				Distance=10
				WindupMessage="reaches out to the blood in their prey's body..."
				DamageMult=1
				StrOffense=1
				ForOffense=1
				ActiveMessage="rips the blood right out of their enemy's body!"
				Area="Target"
				GuardBreak=1
				//No longer has verb because is set by reverse dash
			Shadow_Tendril_Strike
				Distance=10
				Knockback=1
				Slow=1
				Area="Strike"
				ActiveMessage="bursts out with tendrils of shadow!!"
				StrOffense=0
				ForOffense=1
				DamageMult=0.5
				GuardBreak=1
				TurfStrike=3
				HitSparkIcon='Slash - Vampire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1
				HitSparkTurns=1
			Shadow_Tendril_Wave
				Distance=10
				Knockback=1
				Slow=1
				Area="Wave"
				ActiveMessage="bursts out with tendrils of shadow!!"
				StrOffense=0
				ForOffense=1
				DamageMult=1.5
				GuardBreak=1
				TurfStrike=3
				HitSparkIcon='Slash - Vampire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1
				HitSparkTurns=1
				//no verb because is set by throw

////Lycanthropia
			Howl
				Area="Circle"
				Distance=15
				StrOffense=0
				ForOffense=1
				DamageMult=0
				Shockwaves=4
				Shockwave=5
				PreShockwave=1
				PostShockwave=0
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Stunner=2
				Crippling=15
				ShockIcon='DarkKiai.dmi'
				ActiveMessage="unleashes a terrifying howl!"
			Rabid_Retaliation
				Area="Arc"
				StrOffense=1
				DamageMult=1
				Rounds=15
				Knockback=1
				Size=1
				Crippling=2
				ActiveMessage="retaliates with bestial ferocity!"
				HitSparkIcon='WolfFF.dmi'
				HitSparkX=0
				HitSparkY=0
				HitSparkTurns=1
				HitSparkSize=1.2
//No Verbs
			AirSmash
				NoAttackLock=1
				Area="Wave"
				Distance=5
				StrOffense=1
				Knockback=1
				HitSparkIcon='BLANK.dmi'
				Slow=1
				DamageMult=2
				NoOverlay=1
				ObjIcon=1
				Icon='SekiZou.dmi'
				IconX=-48
				IconY=-48
				Size=1
//Racial
			AntennaBeam
				Area="Strike"
				ForOffense=1
				DamageMult=1
				GuardBreak=1
				Stunner=2
				Distance=3
				Knockback=0
				Size=6
				Icon='Antenna Beam.dmi'
				HitSparkIcon='BLANK.dmi'
				Cooldown=150
				ActiveMessage="shoots out crackling energy from their antennas!!!"
				verb/Antenna_Beam()
					set category="Skills"
					usr.Activate(src)

//Skill Tree

////UNARMED
//T1 is in Queues.

//T2 has damage mult 2.5 - 3.5
			Focus_Punch
				SkillCost=80
				Copyable=2
				UnarmedOnly=1
				FlickAttack=1
				Area="Strike"
				ComboMaster=1
				Rush=2
				ControlledRush=1
				Distance=1
				StrOffense=1
				DamageMult=4
				Cooldown=60
				EnergyCost=2
				Knockback=15
				PreShockwave=1
				PreShockwaveDelay=2
				PostShockwave=0
				Shockwaves=2
				Shockwave=0.5
				ShockIcon='KenShockwaveFocus.dmi'
				ShockBlend=2
				ShockDiminish=1.15
				ShockTime=4
				Quaking=10
				Instinct=1
				ActiveMessage="focuses their entire power into a devastating strike!"
				verb/Focus_Punch()
					set category="Skills"
					usr.Activate(src)
			Force_Palm
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Focus_Punch")
				LockOut=list("/obj/Skills/AutoHit/Force_Stomp", "/obj/Skills/AutoHit/Phantom_Strike", "/obj/Skills/AutoHit/Dragon_Rush")
				UnarmedOnly=1
				FlickAttack=1
				Area="Arc"
				ComboMaster=1
				Distance=5
				Slow=0
				Knockback=10
				PreShockwave=1
				PostShockwave=0
				Shockwaves=1
				Shockwave=0.5
				ShockIcon='KenShockwave.dmi'
				ShockBlend=2
				ShockTime=4
				NoPierce=0
				StrOffense=1
				EndDefense=1
				DamageMult=6
				Cooldown=60
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				EnergyCost=3
				Quaking=5
				WindUp=1
				Instinct=1
				WindupMessage="focuses their chi..."
				ActiveMessage="sends a wave of force with a single palm thrust!"
				verb/Force_Palm()
					set category="Skills"
					usr.Activate(src)
			Force_Stomp
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Focus_Punch")
				LockOut=list("/obj/Skills/AutoHit/Force_Palm", "/obj/Skills/AutoHit/Phantom_Strike", "/obj/Skills/AutoHit/Dragon_Rush")
				UnarmedOnly=1
				Area="Circle"
				ComboMaster=1
				Distance=4
				StrOffense=1
				DamageMult=5.5
				Cooldown=60
				Stunner=1
				Knockback=20
				Size=1
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Shockwaves=3
				Shockwave=1
				EnergyCost=3
				SpecialAttack=1
				Earthshaking=15
				ActiveMessage="lifts their leg before performing a tremor-inducing stomp!"
				verb/Force_Stomp()
					set category="Skills"
					usr.Activate(src)
			Phantom_Strike
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Focus_Punch")
				LockOut=list("/obj/Skills/AutoHit/Force_Stomp", "/obj/Skills/AutoHit/Force_Palm", "/obj/Skills/AutoHit/Dragon_Rush")
				UnarmedOnly=1
				Area="Wave"
				ComboMaster=1
				GuardBreak=1
				StrOffense=1
				PassThrough=1
				PreShockwave=1
				PostShockwave=0
				Shockwave=2
				Shockwaves=2
				DamageMult=5.5
				Knockback=5
				Distance=7
				ActiveMessage="vanishes with a burst of speed to strike at their foe!"
				Cooldown=60
				EnergyCost=3
				Instinct=1
				verb/Phantom_Strike()
					set category="Skills"
					usr.Activate(src)
			Dragon_Rush
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Focus_Punch")
				LockOut=list("/obj/Skills/AutoHit/Force_Stomp", "/obj/Skills/AutoHit/Phantom_Strike", "/obj/Skills/AutoHit/Force_Palm")
				UnarmedOnly=1
				FlickAttack=3
				Area="Circle"
				NoLock=1
				NoAttackLock=1
				StrOffense=1
				DamageMult=4.8
				DelayTime=0
				PreShockwave=1
				PreShockwaveDelay=1
				PostShockwave=0
				Shockwaves=2
				Shockwave=0.5
				ShockIcon='KenShockwaveLegend.dmi'
				ShockBlend=2
				ShockDiminish=1.15
				ShockTime=4
				Rush=8
				ControlledRush=1
				HitSparkIcon='Hit Effect.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkCount=10
				HitSparkDispersion=12
				Launcher=3
				DelayedLauncher=1
				Cooldown=60
				EnergyCost=5
				ActiveMessage="rushes forward to deliver a flurry of strikes!"
				verb/Dragon_Rush()
					set category="Skills"
					usr.Activate(src)

			Roundhouse_Kick
				SkillCost=80
				Copyable=2
				UnarmedOnly=1
				Area="Arc"
				ComboMaster=1
				Distance=4
				StrOffense=1
				DamageMult=4.8
				Knockback=3
				Cooldown=60
				Icon='roundhouse.dmi'
				IconX=-16
				IconY=-16
				EnergyCost=2
				ActiveMessage="delivers a roundhouse kick!"
				verb/Roundhouse_Kick()
					set category="Skills"
					usr.Activate(src)
			Sweeping_Kick
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Roundhouse_Kick")
				LockOut=list("/obj/Skills/AutoHit/Helicopter_Kick", "/obj/Skills/AutoHit/Lightning_Kicks", "/obj/Skills/AutoHit/Flying_Kick")
				UnarmedOnly=1
				Area="Circle"
				Distance=1
				StrOffense=1
				DamageMult=1.8
				Launcher=3
				NoLock=1
				NoAttackLock=1
				Cooldown=60
				Size=0.75
				Rounds=3
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				EnergyCost=1
				CanBeDodged=1
				ActiveMessage="sweeps the legs from under their opponent!"
				verb/Leg_Sweep()
					set category="Skills"
					usr.Activate(src)
			Helicopter_Kick
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Roundhouse_Kick")
				LockOut=list("/obj/Skills/AutoHit/Sweeping_Kick", "/obj/Skills/AutoHit/Lightning_Kicks", "/obj/Skills/AutoHit/Flying_Kick")
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				DamageMult=2
				Cooldown=60
				Rounds=5
				Shattering=1
				RoundMovement=1
				Size=0.75
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				FlickSpin=1
				EnergyCost=1
				ActiveMessage="throws their body into a handstand while delivering numerous spin kick!"
				verb/Helicopter_Kick()
					set category="Skills"
					usr.Activate(src)
			Lightning_Kicks
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Roundhouse_Kick")
				LockOut=list("/obj/Skills/AutoHit/Sweeping_Kick", "/obj/Skills/AutoHit/Helicopter_Kick", "/obj/Skills/AutoHit/Flying_Kick")
				UnarmedOnly=1
				Area="Arc"
				StrOffense=1
				DamageMult=3
				Rounds=3
				ComboMaster=1
				RoundMovement=0
				NoAttackLock=1
				NoLock=1
				Cooldown=60
				Icon='Nest Slash.dmi'
				IconX=-16
				IconY=-16
				Size=2
				Distance=2
				EnergyCost=2
				Launcher=2
				Instinct=1
				ActiveMessage="delivers a series of flowing kicks!"
				verb/Lightning_Kicks()
					set category="Skills"
					usr.Activate(src)
			Flying_Kick
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Roundhouse_Kick")
				LockOut=list("/obj/Skills/AutoHit/Sweeping_Kick", "/obj/Skills/AutoHit/Lightning_Kicks", "/obj/Skills/AutoHit/Helicopter_Kick")
				UnarmedOnly=1
				Area="Arc"
				Distance=2
				StrOffense=1
				Rush=5
				Jump=1
				ControlledRush=1
				DamageMult=5.5
				Knockback=5
				Icon='Nest Slash.dmi'
				IconX=-16
				IconY=-16
				Size=2
				Cooldown=60
				EnergyCost=2
				ActiveMessage="goes flying through the air to deliver a graceful kick!"
				verb/Flying_Kick()
					set category="Skills"
					usr.Activate(src)

//T3 is in Grapples.

//T4 has damage mult 4 - 6.
			Clothesline
				SkillCost=160
				Copyable=4
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				DamageMult=1
				Rounds=10
				ChargeTech=1
				ChargeTime=1
				Knockback=1
				Cooldown=120
				Size=1
				EnergyCost=1
				Instinct=1
				ActiveMessage="charges forward with their arm held out!"
				verb/Clothesline()
					set category="Skills"
					usr.Activate(src)
			Spinning_Clothesline
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Clothesline")
				LockOut=list("/obj/Skills/AutoHit/Bullrush", "/obj/Skills/AutoHit/Hyper_Crash", "/obj/Skills/AutoHit/Dropkick_Surprise")
				UnarmedOnly=1
				Area="Circle"
				ComboMaster=1
				StrOffense=1
				DamageMult=0.55
				Rounds=20
				Launcher=2
				Cooldown=120
				Size=2
				Icon='Tornado.dmi'
				IconX=-8
				IconY=-8
				EnergyCost=2.5
				Instinct=1
				ActiveMessage="spins like a top, crushing anyone caught in their range!"
				verb/Spinning_Clothesline()
					set category="Skills"
					usr.Activate(src)
			Bullrush
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Clothesline")
				LockOut=list("/obj/Skills/AutoHit/Spinning_Clothesline", "/obj/Skills/AutoHit/Hyper_Crash", "/obj/Skills/AutoHit/Dropkick_Surprise")
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				DamageMult=1.5
				ComboMaster = 1
				GrabMaster = 1
				Stunner=3
				Grapple=1
				Rounds=10
				ChargeTech=1
				ChargeTime=1
				Knockback=1
				Cooldown=120
				WindUp=0.5
				WindupMessage="lowers their head..."
				Size=1
				EnergyCost=1
				ActiveMessage="charges forward, plowing through everyone in their path!"
				verb/Bullrush()
					set category="Skills"
					usr.Activate(src)
			Hyper_Crash
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Clothesline")
				LockOut=list("/obj/Skills/AutoHit/Bullrush", "/obj/Skills/AutoHit/Spinning_Clothesline", "/obj/Skills/AutoHit/Dropkick_Surprise")
				Area="Wide Wave"
				StrOffense=1
				Distance=10
				Knockback=10
				PassThrough=1
				PreShockwave=1
				PostShockwave=0
				Shockwave=2
				Shockwaves=2
				DamageMult=11
				WindUp=0.1
				WindupMessage="crouches into a starting position..."
				ActiveMessage="blasts forward with a super-sonic dash!"
				Cooldown=120
				verb/Hyper_Crash()
					set category="Skills"
					usr.Activate(src)
			Dropkick_Surprise
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Clothesline")
				LockOut=list("/obj/Skills/AutoHit/Bullrush", "/obj/Skills/AutoHit/Spinning_Clothesline", "/obj/Skills/AutoHit/Hyper_Crash")
				Area="Target"
				StrOffense=1
				Distance=5
				PassThrough=1
				DamageMult=13
				Knockback=10
				Jump=1
				WindUp=0.01
				WindupMessage="leaps into the air!"
				ActiveMessage="crashes into their opponent with a dropkick!"
				Cooldown=120
				verb/Dropkick_Surprise()
					set category="Skills"
					usr.Activate(src)

//T5 (Sig 1) has damage mult 5, usually

			Cast_Fist
				SignatureTechnique=1
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				DamageMult=13
				TurfDirt=1
				Distance=5
				Knockback=10
				FlickAttack=1
				ShockIcon='KenShockwave.dmi'
				Shockwave=5
				Shockwaves=1
				PostShockwave=1
				PreShockwave=0
				Cooldown=150
				WindUp=1
				Earthshaking=20
				Instinct=1
				WindupMessage="rises their fist, ready to cast a spell..."
				ActiveMessage="punches the ground!"
				verb/Cast_Fist()
					set category="Skills"
					usr.Activate(src)

			Wolf_Fang_Fist
				SignatureTechnique=1
				UnarmedOnly=1
				FlickAttack=3
				Area="Wave"
				StrOffense=1
				DamageMult=1.1
				Rounds=10
				Stunner=0.5
				Launcher=2
				ComboMaster=1
				ChargeTech=1
				ChargeTime=0.75
				Knockback=1
				Cooldown=160
				Size=1
				EnergyCost=5
				GuardBreak=1
				ActiveMessage="rushes while attacking with the ferocity of a wolf!"
				HitSparkIcon='WolfFF.dmi'
				HitSparkX=0
				HitSparkY=0
				HitSparkTurns=1
				HitSparkDispersion=14
				HitSparkLife=7
				Instinct=1
				verb/Wolf_Fang_Fist()
					set category="Skills"
					usr.Activate(src)

			Nova_Strike
				SignatureTechnique=1
				UnarmedOnly=1
				Area="Circle"
				StrOffense=0
				ForOffense=1
				DamageMult=0.8
				ComboMaster=1
				Rounds=10
				ChargeTech=1
				ChargeFlight=1
				ChargeTime=0.75
				Grapple=1
				Stunner=1
				Launcher=1
				Cooldown=150
				Size=1
				EnergyCost=10
				Icon='Novabolt.dmi'
				IconX=-33
				IconY=-33
				Instinct=1
				ActiveMessage="blasts forward surrounded by a veil of energy!"
				verb/Nova_Strike()
					set category="Skills"
					usr.Activate(src)

			One_Inch_Punch
				SignatureTechnique=1
				UnarmedOnly=1
				FlickAttack=1
				Area="Strike"
				StrOffense=1
				DamageMult=12.5
				GuardBreak=1
				Stunner=3
				Rush=3
				RushDelay=0.1
				ControlledRush=1
				Knockback=0
				Quaking=15
				Shattering=15
				PreShockwave=1
				PreShockwaveDelay=1
				PostShockwave=0
				Shockwaves=2
				Shockwave=0.5
				ShockIcon='KenShockwaveFocus.dmi'
				ShockBlend=2
				ShockDiminish=1.15
				ShockTime=4
				WindUp=0.5
				WindupMessage="extends their arm towards the opponent, reaching them with the tips of their fingers..."
				ActiveMessage="curls up their fingers into a fist and delivers a crushing blow!!!"
				EnergyCost=5
				Cooldown=150
				verb/One_Inch_Punch()
					set category="Skills"
					usr.Activate(src)

//T6 (Sig 2) has damage mult 7.5, usually

			Lariat
				SignatureTechnique=2
				Area="Circle"
				StrOffense=1
				ForOffense=1
				DamageMult=1.1
				Rounds=10
				ComboMaster=1
				ChargeTech=1
				ChargeTime=0.5
				Grapple=1
				Stunner=3
				Cooldown=180
				Size=1
				EnergyCost=10
				GuardBreak=1
				SpecialAttack=1
				Rush=5
				ControlledRush=1
				Instinct=1
				Icon='Glowing Electricity.dmi'
				ActiveMessage="is covered in lightning as they charge forward!"
				verb/Lariat()
					set category="Skills"
					usr.Activate(src)

			Hyper_Tornado
				SignatureTechnique=2
				Area="Wave"
				StrOffense=1
				ForOffense=1
				DamageMult=8
				ComboMaster=1
				ControlledRush=1
				Rush=15
				Instinct=2
				Knockback=15
				Cooldown=180
				HitSparkIcon='Hit Effect.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=0.8
				HitSparkCount=20
				HitSparkDispersion=24
				HitSparkDelay=1
				Hurricane="/obj/Skills/Projectile/Tornado"
				HurricaneDelay=0.1
				EnergyCost=10
				WindUp=0.25
				GuardBreak=1
				Instinct=1
				WindupMessage="spins rapidly, invoking a tornado that whisks their target!"
				ActiveMessage="bursts forward to deliver a storm of rapid strikes!!"
				verb/Hyper_Tornado()
					set category="Skills"
					usr.Activate(src)

//T7 is always a style or a special buff.


////UNIVERSAL
//T1 is in Projectiles

//T2 has damage mult 2 - 3.5. Some are in Queues.
			Warp_Storm
				Area="Circle"
				Distance=2
				ForOffense=1
				StrOffense=0
				SpecialAttack=1
				ComboMaster=1
				Rounds=5
				DamageMult=0.9//1 damage mult is from the projectile itself.
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				HitSparkIcon='Slash - Zero.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				RoundMovement=0
				//This is set from Warp Strike.

//T3 is in Projectiles - Beams.

			Destruction_Wave
				SkillCost=160
				Copyable=4
				EnergyCost=5
				Area="Wave"
				FlickAttack=1
				Distance=5
				ForOffense=1
				DamageMult=11
				Launcher=2
				NoLock=1
				NoAttackLock=1
				TurfErupt=2
				TurfEruptOffset=0
				Slow=1
				Size=1
				HitSparkX=0
				HitSparkY=0
				SpecialAttack=1
				Earthshaking=10
				Cooldown=120
				ActiveMessage="releases a burst of power with a wave of their hand!"
				verb/Destruction_Wave()
					set category="Skills"
					usr.Activate(src)
			Breaker_Wave
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Destruction_Wave")
				LockOut=list("/obj/Skills/AutoHit/Blazing_Storm", "/obj/Skills/AutoHit/Ghost_Wave", "/obj/Skills/AutoHit/Power_Pillar")
				EnergyCost=10
				Area="Wide Wave"
				FlickAttack=1
				Distance=10
				ForOffense=1
				DamageMult=11.5
				Stunner=3
				TurfErupt=2
				TurfEruptOffset=0
				Slow=1
				Size=1
				HitSparkX=0
				HitSparkY=0
				SpecialAttack=1
				Earthshaking=10
				WindUp=0.5
				ComboMaster = 1
				WindupMessage="focuses their power into a palm..."
				ActiveMessage="unleashes an obliterating wave of power from their hand!"
				Cooldown=120
				verb/Breaker_Wave()
					set category="Skills"
					usr.Activate(src)
			Blazing_Storm
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Destruction_Wave")
				LockOut=list("/obj/Skills/AutoHit/Breaker_Wave", "/obj/Skills/AutoHit/Ghost_Wave", "/obj/Skills/AutoHit/Power_Pillar")
				StrOffense=0
				ForOffense=1
				DamageMult=10
				Area="Around Target"
				FlickAttack=1
				Distance=15
				DistanceAround=3
				Divide=1
				TurfErupt=2
				TurfEruptOffset=6
				WindUp=0.5
				ComboMaster = 1
				WindupIcon='Ultima Arm.dmi'
				WindupIconSize=1.5
				Launcher=2
				WindupMessage="draws in a large amount of ki..."
				ActiveMessage="unleashes an explosive wave of power directly at their enemy!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Cooldown=120
				EnergyCost=10
				Earthshaking=15
				verb/Blazing_Storm()
					set category="Skills"
					usr.Activate(src)
			Ghost_Wave
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Destruction_Wave")
				LockOut=list("/obj/Skills/AutoHit/Blazing_Storm", "/obj/Skills/AutoHit/Breaker_Wave", "/obj/Skills/AutoHit/Power_Pillar")
				EnergyCost=10
				Area="Wave"
				FlickAttack=1
				Distance=3
				ForOffense=1
				Rush=5
				NoLock=1
				NoAttackLock=1
				ControlledRush=1
				DamageMult=12.5
				Launcher=2
				TurfErupt=2
				TurfEruptOffset=0
				Slow=1
				Size=1
				HitSparkX=0
				HitSparkY=0
				SpecialAttack=1
				Earthshaking=5
				ActiveMessage="blinks forward before unleashing a wave of power at point-blank range!"
				Cooldown=120
				verb/Ghost_Wave()
					set category="Skills"
					usr.Activate(src)
			Power_Pillar
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Destruction_Wave")
				LockOut=list("/obj/Skills/AutoHit/Blazing_Storm", "/obj/Skills/AutoHit/Breaker_Wave", "/obj/Skills/AutoHit/Ghost_Wave")
				EnergyCost=10
				Area="Circle"
				FlickAttack=1
				Distance=3
				RoundMovement=0
				Rounds=5
				ForOffense=1
				DamageMult=4.2
				NoAttackLock=1
				NoLock=1
				Launcher=2
				ComboMaster = 1
				TurfErupt=2
				TurfEruptOffset=0
				Size=1
				HitSparkX=0
				HitSparkY=0
				SpecialAttack=1
				Earthshaking=5
				WindUp=0.5
				WindupMessage="grows still..."
				ActiveMessage="crushes those nearby with their spiritual aura!!"
				Cooldown=120
				verb/Power_Pillar()
					set category="Skills"
					usr.Activate(src)





////SHIT AINT USED
			Pinpoint_Blast


//General app

///Sword
			Shining_Sword_Slash
				SignatureTechnique=1
				NeedsSword=1
				FlickAttack=3
				Area="Circle"
				StrOffense=1
				DamageMult=11
				DelayTime=0
				PreShockwave=1
				PreShockwaveDelay=1
				PostShockwave=0
				GuardBreak=1
				Shockwaves=2
				Shockwave=0.5
				ShockIcon='KenShockwaveFocus.dmi'
				ShockBlend=2
				ShockDiminish=1.15
				ShockTime=4
				GuardBreak=1
				Rush=7
				ControlledRush=1
				HitSparkIcon='Slash - Future.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkCount=7
				HitSparkDispersion=4
				Launcher=1
				DelayedLauncher=1
				Cooldown=150
				EnergyCost=5
				Instinct=1
				ActiveMessage="delivers swift justice with a flurry of slashes!"
				verb/Shining_Sword_Slash()
					set category="Skills"
					usr.Activate(src)
			Massacre
				SignatureTechnique=1
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				Distance=4
				DamageMult=11.5
				Knockback=10
				WindUp=0.5
				Slow=1
				WindupMessage="sheathes their blade..."
				ActiveMessage="cuts through any and all around them in the flash of an eye!"
				HitSparkIcon='JudgmentCut.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=2
				HitSparkCount=1
				HitSparkDispersion=16
				TurfStrike=1
				Cooldown=150
				EnergyCost=5
				Instinct=1
				verb/Massacre()
					set category="Skills"
					usr.Activate(src)
			Slam_Wave
				SignatureTechnique=1
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				DamageMult=11.5
				TurfDirt=1
				Distance=1
				Jump=2
				Knockback=10
				FlickAttack=2
				GuardBreak=1
				ShockIcon='KenShockwave.dmi'
				Shockwave=1
				Shockwaves=1
				PostShockwave=1
				HitSparkIcon='BLANK.dmi'
				Stunner=3
				Cooldown=150
				EnergyCost=10
				Earthshaking=1
				Instinct=1
				ActiveMessage="leaps in the air before falling back down, weapon-first!"
				verb/Slam_Wave()
					set category="Skills"
					var/obj/Items/Sword/S=usr.EquippedSword()
					src.Distance=round(usr.GetSwordDamage(S)*2,1)
					src.Shockwave=round(usr.GetSwordDamage(S)*2,1)
					src.Earthshaking=round(usr.GetSwordDamage(S)*2,1)
					usr.Activate(src)

			Zantetsuken
				SignatureTechnique=2
				NeedsSword=1
				Distance=15
				Gravity=5
				WindUp=1
				WindupMessage="prepares to deliver a peerless slash..."
				DamageMult=10
				StrOffense=1
				ActiveMessage="slashes through their enemy in the blink of an eye, aiming to mortally wound them!"
				Area="Target"
				GuardBreak=1
				PassThrough=1
				MortalBlow=0.25
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkTurns=1
				HitSparkSize=3
				Cooldown=-1
				EnergyCost=15
				Instinct=1
				verb/Zantetsuken()
					set category="Skills"
					usr.Activate(src)
			Shadow_Cut
				SignatureTechnique=2
				NeedsSword=1
				Area="Wide Wave"
				StrOffense=1
				Distance=7
				DelayTime=7
				Rounds=7
				DamageMult=2
				PassThrough=1
				GuardBreak=1
				WindUp=0.25
				WindupMessage="sheathes their blade..."
				ActiveMessage="begins to step through the battlefield like a passing shadow!"
				HitSparkIcon='JudgmentCut.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkCount=2
				HitSparkDelay=2
				HitSparkDispersion=16
				TurfStrike=1
				Cooldown=180
				EnergyCost=5
				Instinct=1
				verb/Shadow_Cut()
					set category="Skills"
					usr.Activate(src)
			Thousand_Man_Slayer//Give this to (scrubbed)
				SignatureTechnique=2
				PreRequisite=list("/obj/Skills/AutoHit/Massacre")
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				Distance=10
				PassTo=1
				DamageMult=17.5
				WindUp=1
				GuardBreak=1
				Knockback=25
				WindupMessage="lays a hand on their sheathed blade, concentrating for a moment..."
				ActiveMessage="blasts through surrounding foes with what appears to be a single strike!!"
				Cooldown=180
				EnergyCost=15
				verb/Thousand_Man_Slayer()
					set category="Skills"
					usr.Activate(src)

			Mugetsu
				SpecialAttack=1
				SBuffNeeded="Final Getsuga Tenshou"
				Area="Arc"
				Distance=30
				DamageMult=50
				StrOffense=1
				ForOffense=1
				Cooldown=-1
				TurfStrike=1
				TurfShiftLayer=EFFECTS_LAYER
				TurfShiftDuration=-10
				TurfShiftDurationSpawn=0
				TurfShiftDurationDespawn=5
				TurfShift='Gravity.dmi'
				Rush = 7
				ControlledRush = 1
				Divide=1
				Destructive=1
				GuardBreak=1//Can't be dodged or blocked
				WindUp=0.25
				WindupMessage="gathers darkness in form of a sword in their grasp..."
				ActiveMessage="releases an all-consuming wave of darkness!"
				verb/Mugetsu()
					set category="Skills"
					usr.Activate(src)
					spawn(100)
						if(usr.CheckSpecial("Final Getsuga Tenshou"))
							for(var/obj/Skills/Buffs/SpecialBuffs/Sword/Final_Getsuga_Tenshou/FGT in usr)
								usr.UseBuff(FGT)
								del FGT
					for(var/obj/Skills/AutoHit/Mugetsu/MGT in usr)
						del MGT

///Special

			Kiai
				SignatureTechnique=1
				Area="Circle"
				Distance=10
				//** POTENTIAL CHANGES **//
				/*
				StrOffense=0.75
				ForOffense=0.75
				DamageMult=0.6
				Rounds=3
				Knockback=3
				Stunner=1.5
				*/
				StrOffense=0
				ForOffense=1
				DamageMult=10
				Knockback=10
				Cooldown=150
				Shockwaves=3
				Shockwave=4
				SpecialAttack=1
				Stunner=3
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				ActiveMessage="unleashes a wave of ki!"
				EnergyCost=5
				verb/Kiai()
					set category="Skills"
					if(!usr.AfterImageStrike  && !src.Using)
						usr.SkillStunX("After Image Strike",src)
					usr.Activate(src)
			Taiyoken
				SignatureTechnique=1
				AllOutAttack=1
				Area="Circle"
				Distance=10
				StrOffense=0
				ForOffense=1
				DamageMult=0
				Flash=35
				WindUp=0.5
				WindupIcon='BLANK.dmi'
				WindupMessage="brings their hands to their face..."
				SpecialAttack=1
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				TurfShift='BrightDay2.dmi'
				TurfShiftLayer=EFFECTS_LAYER
				TurfShiftDuration=-10
				TurfShiftDurationSpawn=0
				TurfShiftDurationDespawn=5
				ActiveMessage="converts their ki to a wave of blinding light!"
				Cooldown=150
				EnergyCost=20
				verb/Taiyoken()
					set category="Skills"
					usr.Activate(src)
			Chidori
				Area="Strike"
				StrOffense=1
				ForOffense=1
				Rush=20
				SpecialAttack=1
				CanBeDodged=0
				CanBeBlocked=1
				DamageMult=11
				SlayerMod=30
				Stunner=3
				MortalBlow=0.25
				Knockback=0
				WindUp=1
				WindupIcon='Chidori.dmi'
				WindupMessage="begins charging lightning into their palm!"
				ActiveMessage="rushes in with terrifying piercing force!"
				Icon='Chidori.dmi'
				HitSparkIcon='Hit Effect Vampire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1
				Cooldown=-1
				EnergyCost=15
				Instinct=1
				verb/Chidori()
					set category="Skills"
					if(usr.Saga=="Sharingan")
						src.ControlledRush=1
					usr.Activate(src)
			Super_Explosive_Wave
				SignatureTechnique=1
				StrOffense=0
				ForOffense=1
				DamageMult=12.5
				Area="Circle"
				Distance=7
				TurfErupt=2
				TurfEruptOffset=3
				Slow=1
				WindUp=1
				WindupIcon='Ripple Radiance.dmi'
				WindupIconUnder=1
				WindupIconX=-32
				WindupIconY=-32
				WindupIconSize=1.3
				Divide=1
				Knockback=25
				WindupMessage="draws in a large amount of ki..."
				ActiveMessage="unleashes an explosive wave of power!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Cooldown=150

				Earthshaking=15
				PreQuake=1
				verb/Super_Explosive_Wave()
					set category="Skills"
					usr.Activate(src)
			Kikoho
				SignatureTechnique=1
				AllOutAttack=1
				StrOffense=0
				ForOffense=1
				DamageMult=13
				WoundCost=6
				ComboMaster=1
				Area="Around Target"
				Distance=15
				DistanceAround=4
				Divide=1
				Launcher=1
				Stunner=0.5
				WindUp=1.5
				WindupIcon='Ripple Radiance.dmi'
				WindupIconUnder=1
				WindupIconX=-32
				WindupIconY=-32
				WindupIconSize=1
				WindupMessage="begins drawing on their life force..."
				ActiveMessage="unleashes an explosive wave of power directly at their enemy!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				PreShockwave=1
				PreShockwaveDelay=2
				PostShockwave=0
				Shockwaves=2
				Shockwave=0.5
				ShockIcon='KenShockwaveGold.dmi'
				ShockBlend=2
				ShockDiminish=1.15
				ShockTime=4
				TurfShift='Lightning.dmi'
				TurfShiftLayer=6
				TurfShiftDuration=-10
				TurfShiftDurationSpawn=0
				TurfShiftDurationDespawn=5
				TurfErupt=2
				Cooldown=150
				Earthshaking=15
				GuardBreak=1
				Crippling=3
				Instinct=1
				verb/Kikoho()
					set category="Skills"
					usr.Activate(src)

			Shin_Kikoho
				PreRequisite=list("/obj/Skills/AutoHit/Kikoho")
				SignatureTechnique=2
				AllOutAttack=1
				StrOffense=0
				ForOffense=1
				Launcher=1
				WoundCost=20
				DamageMult=12
				Rounds=4
				DelayTime = 5
				ComboMaster=1
				Cooldown=180
				Area="Around Target"
				Distance=15
				DistanceAround=4
				Divide=1
				WindUp=0.1
				WindupIcon='Ripple Radiance.dmi'
				WindupIconUnder=1
				WindupIconX=-32
				WindupIconY=-32
				WindupIconSize=1.2
				Float=6
				ActiveMessage="recklessly unleashes an explosive wave of power directly at their enemy!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				PreShockwave=1
				PreShockwaveDelay=2
				PostShockwave=0
				Shockwaves=2
				Shockwave=0.8
				ShockIcon='KenShockwaveGold.dmi'
				ShockBlend=2
				ShockDiminish=1.15
				ShockTime=4
				TurfShift='Lightning.dmi'
				TurfShiftLayer=6
				TurfShiftDuration=-10
				TurfShiftDurationSpawn=0
				TurfShiftDurationDespawn=5
				TurfErupt=2
				Earthshaking=15
				GuardBreak=1
				Crippling=3
				Instinct=1
				verb/Shin_Kikoho()
					set category="Skills"
					usr.Activate(src)

////Racial
			Fire_Breath
				ElementalClass="Fire"
				StrOffense=1
				ForOffense=1.5
				SpecialAttack=1
				GuardBreak=1
				DamageMult=15
				Scorching=30
				TurfErupt=1
				WindUp=0.5
				WindupMessage="breathes deeply..."
				ActiveMessage="lets loose an enormous breath infused with fire!"
				Cooldown=90
				Distance=30
				Slow=1
				Area="Arc"
				verb/Fire_Breath()
					set category="Skills"
					if(!altered)
						DamageMult = 15 + (5 * usr.AscensionsAcquired)
						Cooldown = 90 + (15 * usr.AscensionsAcquired)
						Distance = 15 + (10 * usr.AscensionsAcquired)
						ForOffense = 1 + (0.1 * usr.AscensionsAcquired)
						StrOffense = 1 + (0.1 * usr.AscensionsAcquired)
					usr.Activate(src)
			Poison_Gas
				ElementalClass="Poison"
				StrOffense=0.5
				ForOffense=0.5
				EndDefense=0.5
				DamageMult=1.5
				NoLock=1
				NoAttackLock=1
				SpecialAttack=1
				GuardBreak=1
				Area="Circle"
				Distance=1
				Wander=10
				Toxic=5
				ActiveMessage="releases a noxious sweat!"
				ObjIcon=1
				Icon='PoisonGas.dmi'
				IconX=-16
				IconY=-16
				Size=1.5
				Cooldown=90
				Rounds=40
				DelayTime=5
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				verb/Poison_Gas()
					set category="Skills"
					usr.Activate(src)
			Great_Deluge
				ElementalClass="Water"
				ForOffense=1
				StrOffense=0
				Area="Circle"
				TurfReplace='PlainWater.dmi'
				Distance=20
				WindUp=2
				DamageMult=15
				SpecialAttack=1
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=6
				TurfStrike=1
				WindupMessage="calls upon the waters of the world..."
				ActiveMessage="crushes the area with a massive downpour of water!"
				Slow=1
				NoLock=1
				Deluge=1
				Cooldown=10800
				verb/Great_Deluge()
					set category="Skills"
					usr.Activate(src)
			Gwych_Dymestl
				ElementalClass="Wind"
				ForOffense=1
				StrOffense=0
				Area="Around Target"
				DistanceAround
				CanBeDodged=1
				Distance=20
				DistanceAround=15
				DamageMult=0.5
				WindUp=2
				DelayTime=70
				Rounds=40
				Slow=3
				Paralyzing=5
				SpecialAttack=1
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				WindupMessage="conjures ominous clouds to hang in the sky..."
				ActiveMessage="unleashes a grand thunderstorm!!"
				Thunderstorm=20
				Bolt=1
				NoLock=1
				Cooldown=10800
				verb/Grand_Dymestl()
					set name="Gwych Dymestyl"
					set category="Skills"
					usr.Activate(src)

////Magic
			Magic
				MagicNeeded=1
				Blizzard
					ElementalClass="Water"
					SkillCost=80
					Copyable=2
					Area="Wave"
					Distance=6
					Freezing=2
					Slow=1
					DamageMult=3
					SpecialAttack=1
					StrOffense=0
					ForOffense=1
					FlickAttack=1
					CanBeDodged=1
					CanBeBlocked=0
					HitSparkIcon='SnowBurst2.dmi'
					HitSparkTurns=0
					HitSparkSize=1
					HitSparkDispersion=8
					TurfStrike=1
					ManaCost=3
					Cooldown=60
					ActiveMessage="invokes: <font size=+1>BLIZZARD!</font size>"
					verb/Blizzard()
						set category="Skills"
						usr.Activate(src)
				Blizzara
					ElementalClass="Water"
					SkillCost=80
					Copyable=3
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Blizzard")
					Area="Wide Wave"
					Distance=6
					Freezing=4
					Slow=1
					DamageMult=6
					SpecialAttack=1
					StrOffense=0
					ForOffense=1
					CanBeDodged=1
					CanBeBlocked=0
					HitSparkIcon='SnowBurst2.dmi'
					HitSparkSize=1
					HitSparkDispersion=16
					TurfStrike=3
					ManaCost=6
					Cooldown=60
					ActiveMessage="invokes: <font size=+1>BLIZZARA!</font size>"
					verb/Blizzara()
						set category="Skills"
						usr.Activate(src)
				Blizzaga
					ElementalClass="Water"
					SkillCost=80
					Copyable=4
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Blizzara")
					Area="Circle"
					Distance=6
					Freezing=6
					Slow=1
					DamageMult=8
					SpecialAttack=1
					StrOffense=0
					ForOffense=1
					CanBeDodged=1
					CanBeBlocked=0
					HitSparkIcon='SnowBurst2.dmi'
					HitSparkSize=1
					HitSparkDispersion=16
					TurfStrike=3
					ManaCost=9
					Cooldown=60
					ActiveMessage="invokes: <font size=+1>BLIZZAGA!</font size>"
					verb/Blizzaga()
						set category="Skills"
						usr.Activate(src)

				Thunder
					ElementalClass="Wind"
					FlickAttack=1
					SkillCost=80
					Copyable=2
					Distance=6
					Area="Target"
					ForOffense=1
					DamageMult=3
					Paralyzing=1
					Size=1
					Bolt=2
					Distance=5
					HitSparkIcon='BLANK.dmi'
					HitSparkX=0
					HitSparkY=0
					WindUp=1
					ManaCost=3
					SpecialAttack=1
					CanBeDodged=1
					CanBeBlocked=0
					Cooldown=60
					WindupMessage="invokes: <font size=+1>THUNDER!</font size>"
					verb/Thunder()
						set category="Skills"
						usr.Activate(src)
				Thundara
					ElementalClass="Wind"
					FlickAttack=1
					SkillCost=80
					Copyable=3
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Thunder")
					Area="Circle"
					Distance=8
					Paralyzing=2
					Bolt=2
					WindUp=1
					DamageMult=6
					SpecialAttack=1
					ForOffense=1
					CanBeDodged=1
					CanBeBlocked=0
					ManaCost=5
					Cooldown=60
					WindupMessage="invokes: <font size=+1>THUNDARA!</font size>"
					verb/Thundara()
						set category="Skills"
						usr.Activate(src)
				Thundaga
					ElementalClass="Wind"
					FlickAttack=1
					SkillCost=80
					Copyable=4
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Thundara")
					Area="Around Target"
					Distance=10
					DistanceAround=7
					Paralyzing=4
					Bolt=2
					BoltOffset=1
					WindUp=1
					DamageMult=1.5
					Rounds=5
					SpecialAttack=1
					ForOffense=1
					CanBeDodged=0
					CanBeBlocked=1
					ManaCost=10
					Cooldown=60
					WindupMessage="invokes: <font size=+1>THUNDAGA!</font size>"
					verb/Thundaga()
						set category="Skills"
						usr.Activate(src)

				Magnet
					ElementalClass="Earth"
					FlickAttack=1
					SkillCost=160
					Copyable=4
					StrOffense=0
					ForOffense=1
					DamageMult=0.3
					Area="Around Target"
					SpecialAttack=1
					NoLock=1
					NoAttackLock=1
					Distance=15
					DistanceAround=3
					Rounds=15
					DelayTime=2
					Launcher=3
					CanBeDodged=1
					CanBeBlocked=0
					Icon='LightningBolt.dmi'
					Size=0.5
					IconX=-33
					IconY=-33
					ActiveMessage="invokes: <font size=+1>MAGNET!</font size>"
					Cooldown=120
					ManaCost=10
					verb/Magnet()
						set category="Skills"
						usr.Activate(src)
				Gravity
					ElementalClass="Earth"
					SkillCost=160
					Copyable=5
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Magnet")
					Area="Around Target"
					Distance=15
					DistanceAround=4
					WindUp=0.5
					GuardBreak=1
					SpecialAttack=1
					NoLock=1
					NoAttackLock=1
					StrOffense=0
					ForOffense=1
					DamageMult=11
					Rounds=1
					DelayTime=2
					Launcher=1
					Crippling=20
					TurfShift='Gravity.dmi'
					TurfShiftLayer=MOB_LAYER+1
					TurfShiftDuration=0
					TurfShiftDurationSpawn=3
					TurfShiftDurationDespawn=7
					WindupMessage="invokes: <font size=+1>GRAVITY!</font size>"
					Cooldown=120
					ManaCost=15
					verb/Gravity()
						set category="Skills"
						usr.Activate(src)
				Stop
					ElementalClass="Earth"
					SkillCost=160
					Copyable=6
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Gravity")
					Area="Around Target"
					Distance=15
					DistanceAround=5
					WindUp=1
					Stunner=5
					DamageMult=4
					StrOffense=0
					ForOffense=1
					GuardBreak=1
					SpecialAttack=1
					NoLock=1
					NoAttackLock=1
					Launcher=1
					Crippling=5
					HitSparkIcon='Magic Time circle.dmi'
					HitSparkX=0
					HitSparkY=0
					HitSparkDispersion=0
					TurfShift='Gravity.dmi'
					TurfShiftLayer=MOB_LAYER+1
					TurfShiftDuration=0
					TurfShiftDurationSpawn=3
					TurfShiftDurationDespawn=7
					Cooldown=120
					ManaCost=20
					WindupMessage="invokes: <font size=+1>STOP!</font size>"
					verb/Stop()
						set category="Skills"
						usr.Activate(src)

				Flare
					ElementalClass="Fire"
					SkillCost=160
					Copyable=6
					PreRequisite=list("/obj/Skills/Projectile/Magic/Meteor")
					Area="Around Target"
					Distance=15
					DistanceAround=7
					DamageMult=11
					ManaCost=20
					Cooldown=120
					GuardBreak=1
					Slow=0.5
					DelayTime=1
					HitSparkIcon='Hit Effect Ripple.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkTurns=1
					HitSparkSize=2
					HitSparkCount=1
					HitSparkDispersion=24
					TurfStrike=1
					WindUp=0.5
					WindupIcon='Cure.dmi'
					WindupMessage="invokes: <font size=+1>FLARE!</font size>"
					ForOffense=1
					EndDefense=1
					SpecialAttack=1
					Instinct=1
					verb/Flare()
						set category="Skills"
						usr.Activate(src)


				Magnetga
					ElementalClass="Earth"
					SagaSignature=1
					SignatureTechnique=1
					SignatureName="Advanced Space Magic"
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Stop")
					FlickAttack=1
					StrOffense=0
					ForOffense=1
					DamageMult=0.7
					Area="Around Target"
					SpecialAttack=1
					NoLock=1
					NoAttackLock=1
					Distance=30
					DistanceAround=4
					Rounds=20
					DelayTime=2
					WindUp=0.5
					Launcher=4
					Icon='LightningBolt.dmi'
					Size=0.8
					IconX=-33
					IconY=-33
					WindupMessage="invokes: <font size=+1>MAGNETGA!</font size>"
					ActiveMessage="creates a powerful orb of magnetism, drawing their opponents towards the sky!"
					Cooldown=180
					ManaCost=25
					verb/Magnetga()
						set category="Skills"
						usr.Activate(src)
				Graviga
					ElementalClass="Earth"
					SagaSignature=1
					SignatureTechnique=1
					SignatureName="Advanced Space Magic"
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Stop")
					Area="Circle"
					Distance=8
					WindUp=1
					NoLock=1
					NoAttackLock=1
					GuardBreak=1
					SpecialAttack=1
					StrOffense=0
					ForOffense=1
					DamageMult=12
					Cooldown=180
					ManaCost=25
					Crippling=3
					TurfShift='Gravity.dmi'
					TurfShiftLayer=MOB_LAYER+1
					TurfShiftDuration=0
					TurfShiftDurationSpawn=3
					TurfShiftDurationDespawn=7
					WindupMessage="invokes: <font size=+1>GRAVIGA!</font size>"
					verb/Graviga()
						set category="Skills"
						usr.Activate(src)
				Stopga
					ElementalClass="Earth"
					SagaSignature=1
					SignatureTechnique=1
					SignatureName="Advanced Space Magic"
					PreRequisite=list("/obj/Skills/AutoHit/Magic/Stop")
					Area="Circle"
					Distance=10
					Stunner=5
					DamageMult=0
					StrOffense=0
					ForOffense=1
					GuardBreak=1
					NoLock=1
					NoAttackLock=1
					SpecialAttack=1
					HitSparkIcon='Magic Time circle.dmi'
					HitSparkX=0
					HitSparkY=0
					HitSparkDispersion=0
					Cooldown=180
					ManaCost=30
					WindupMessage="invokes: <font size=+1>STOPGA!</font size>"
					verb/Stopga()
						set category="Skills"
						usr.Activate(src)

				Holy
					ElementalClass="Water"
					SagaSignature=1
					SignatureTechnique=2
					SignatureName="Holy Magic"
					Area="Target"
					Distance=7
					HolyMod=20
					Purity=1
					DamageMult=18
					WindUp=1
					ManaCost=30
					Cooldown=180
					GuardBreak=1
					HitSparkIcon='Hit Effect Pearl.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkTurns=1
					HitSparkSize=5
					HitSparkCount=10
					HitSparkDispersion=1
					ForOffense=1
					SpecialAttack=1
					WindupMessage="invokes: <font size=+1>HOLY!</font size>"
					verb/Holy()
						set category="Skills"
						usr.Activate(src)

				Thousand_Thunderbolts
				Snowstorm_of_Darkness
				Light_Eater
				Cage_of_Time

				Ultima
					SignatureTechnique=4
					Destructive=1
////SWORD
//T1 has damage mult 1.5 - 2.5

			//todo: remove
			SwordPressure//dedname
			ArcSlash//dedname
			RendingChop//dedname
			HackNSlash//dedname
			SweepingBlade//dedname
			SweepingRush//dedname
			SpiralBlade//dedname
			ArkBrave//dedname

			Tipper
				SkillCost=40
				Copyable=1
				NeedsSword=1
				FlickAttack=1
				Area="Strike"
				Distance=2
				StrOffense=1
				NoPierce=1
				Knockback=15
				DamageMult=2.5
				StepsDamage=1
				Cooldown=30
				EnergyCost=1
				ActiveMessage="thrusts their sword forward!"
				verb/Tipper()
					set category="Skills"
					usr.Activate(src)
			Sword_Pressure
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Tipper")
				LockOut=list("/obj/Skills/AutoHit/Overhead_Divide", "/obj/Skills/AutoHit/Light_Step", "/obj/Skills/AutoHit/Stinger")
				NeedsSword=1
				Area="Wave"
				Distance=10
				StrOffense=1
				Knockback=1
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=3
				TurfStrike=1
				Slow=1
				DamageMult=2.8
				StepsDamage=0.1
				Cooldown=30
				EnergyCost=3
				ActiveMessage="thrusts their blade forward, causing a powerful wave of pressure!"
				verb/Sword_Pressure()
					set category="Skills"
					usr.Activate(src)
			Stinger
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Tipper")
				LockOut=list("/obj/Skills/AutoHit/Sword_Pressure", "/obj/Skills/AutoHit/Light_Step", "/obj/Skills/AutoHit/Overhead_Divide")
				NeedsSword=1
				Area="Target"
				Distance=3
				StrOffense=1
				NoPierce=1
				Knockback=10
				DamageMult=2.6
				Cooldown=30
				EnergyCost=2
				ActiveMessage="dashes forward with a jousting strike!"
				verb/Stinger()
					set category="Skills"
					usr.Activate(src)
			Light_Step
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Tipper")
				LockOut=list("/obj/Skills/AutoHit/Sword_Pressure", "/obj/Skills/AutoHit/Overhead_Divide", "/obj/Skills/AutoHit/Stinger")
				NeedsSword=1
				Area="Wave"
				Distance=5
				PassThrough=1
				StrOffense=1
				DamageMult=2.5
				EnergyCost=1.5
				Rounds = 3
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize= 0.65
				HitSparkDelay = 1
				HitSparkLife = 5
				HitSparkCount = 4
				HitSparkDispersion = 12
				TurfStrike = 1
				PreShockwave = 1
				Shockwave = 1
				Shockwaves = 1
				SpeedStrike = 1
				Cooldown=30
				ActiveMessage="bursts forward with a lightning-fast slash!"
				verb/Light_Step()
					set category="Skills"
					usr.Activate(src)
			Overhead_Divide
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Tipper")
				LockOut=list("/obj/Skills/AutoHit/Sword_Pressure", "/obj/Skills/AutoHit/Light_Step", "/obj/Skills/AutoHit/Stinger")
				NeedsSword=1
				Rush=5
				ControlledRush=1
				Area="Wave"
				ComboMaster=1
				Distance=3
				StrOffense=1
				EndDefense=1
				DamageMult=2.8
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1.5
				HitSparkDispersion=1
				TurfStrike=2
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=3
				EnergyCost=3
				Cooldown=30
				ActiveMessage="brings their weapon down with a powerful overhead swing!"
				verb/Overhead_Divide()
					set category="Skills"
					usr.Activate(src)


			Arc_Slash
				SkillCost=40
				Copyable=1
				NeedsSword=1
				Area="Arc"
				StrOffense=1
				DamageMult=2.2
				Cooldown=30
				EnergyCost=1
				Rush=3
				ControlledRush=1
				Icon='roundhouse.dmi'
				IconX=-16
				IconY=-16
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1.5
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=1
				ActiveMessage="swings their blade in a wide arc!"
				verb/Arc_Slash()
					set category="Skills"
					usr.Activate(src)
			Vacuum_Render
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Arc_Slash")
				LockOut=list("/obj/Skills/AutoHit/Hack_n_Slash", "/obj/Skills/AutoHit/Hamstring", "/obj/Skills/AutoHit/Cross_Slash")
				NeedsSword=1
				Area="Arc"
				StrOffense=1
				Rush=1
				ControlledRush=1
				DamageMult=2.8
				Shearing=5
				Cooldown=30
				EnergyCost=3
				Distance=3
				Size=2.5
				Icon='roundhouse.dmi'
				IconX=-16
				IconY=-16
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1.5
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=1
				EnergyCost=1
				ActiveMessage="unleashes a vacuum powered slash!"
				verb/Vacuum_Render()
					set category="Skills"
					usr.Activate(src)
			Hack_n_Slash
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Arc_Slash")
				LockOut=list("/obj/Skills/AutoHit/Vacuum_Render", "/obj/Skills/AutoHit/Hamstring", "/obj/Skills/AutoHit/Cross_Slash")
				NeedsSword=1
				Area="Arc"
				Rush=1
				ControlledRush=1
				Distance=2
				StrOffense=1
				DamageMult=0.35
				RoundMovement=0
				ComboMaster=1
				Rounds=10
				Cooldown=30
				EnergyCost=2
				Icon='Nest Slash.dmi'
				IconX=-16
				IconY=-16
				Size=1.5
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				EnergyCost=1
				Instinct=1
				ActiveMessage="flourishes their blade in a series of strokes!"
				verb/Hack_n_Slash()
					set name="Hack'n'Slash"
					set category="Skills"
					usr.Activate(src)
			Hamstring
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Arc_Slash")
				LockOut=list("/obj/Skills/AutoHit/Vacuum_Render", "/obj/Skills/AutoHit/Hack_n_Slash", "/obj/Skills/AutoHit/Cross_Slash")
				NeedsSword=1
				Rush=3
				ControlledRush=1
				Area="Arc"
				NoLock=1
				NoAttackLock=1
				Launcher=2
				StrOffense=1
				DamageMult=2.8
				Distance=1
				Crippling=5
				Icon='roundhouse.dmi'
				IconX=-16
				IconY=-16
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=1
				EnergyCost=3
				Cooldown=30
				ActiveMessage="slashes for their opponent's legs to cripple them!"
				verb/Hamstring()
					set category="Skills"
					usr.Activate(src)
			Cross_Slash
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/AutoHit/Arc_Slash")
				LockOut=list("/obj/Skills/AutoHit/Vacuum_Render", "/obj/Skills/AutoHit/Hack_n_Slash", "/obj/Skills/AutoHit/Hamstring")
				NeedsSword=1
				Area="Circle"
				Rush=5
				ControlledRush=1
				Distance=1
				StrOffense=1
				DamageMult=3
				EnergyCost=3
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkTurns=1
				HitSparkSize=1.5
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=1
				Cooldown=30
				ActiveMessage="swings their weapon in a quick pattern!"
				verb/Cross_Slash()
					set category="Skills"
					usr.Activate(src)

//T2
			Hero_Spin
				SkillCost=80
				Copyable=2
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				DamageMult=4.8
				Cooldown=60
				Rush=3
				ControlledRush=1
				Knockback=3
				Size=1
				Icon='CircleWind.dmi'
				IconX=-32
				IconY=-32
				EnergyCost=2
				ActiveMessage="spins with a powerful slash!"
				verb/Hero_Spin()
					set category="Skills"
					usr.Activate(src)
			Drill_Spin
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Hero_Spin")
				LockOut=list("/obj/Skills/AutoHit/Rising_Spire", "/obj/Skills/AutoHit/Ark_Brave", "/obj/Skills/AutoHit/Judgment")
				NeedsSword=1
				Area="Circle"
				ComboMaster=1
				Shearing=1
				ControlledRush=1
				Rush=3
				ChargeTech=1
				ChargeTime=1
				Rounds=5
				StrOffense=1
				DamageMult=1.1
				Cooldown=60
				Knockback=1
				Size=1
				Icon='CircleWind.dmi'
				IconX=-32
				IconY=-32
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=1
				EnergyCost=5
				Instinct=1
				ActiveMessage="spins their sword like a drill bit!"
				verb/Drill_Spin()
					set category="Skills"
					usr.Activate(src)
			Rising_Spire
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Hero_Spin")
				LockOut=list("/obj/Skills/AutoHit/Drill_Spin", "/obj/Skills/AutoHit/Ark_Brave", "/obj/Skills/AutoHit/Judgment")
				NeedsSword=1
				Area="Circle"
				ControlledRush=1
				Rush=3
				StrOffense=1
				DamageMult=1.8
				Cooldown=60
				Knockback=0
				Rounds=3
				Launcher=2
				NoLock=1
				NoAttackLock=1
				Size=1
				Icon='CircleWind.dmi'
				IconX=-32
				IconY=-32
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				EnergyCost=4
				ActiveMessage="spins upwards with their weapon extended!"
				verb/Rising_Spire()
					set category="Skills"
					usr.Activate(src)
			Ark_Brave
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Hero_Spin")
				LockOut=list("/obj/Skills/AutoHit/Rising_Spire", "/obj/Skills/AutoHit/Drill_Spin", "/obj/Skills/AutoHit/Judgment")
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				EndDefense=1
				DamageMult=5
				Cooldown=60
				Knockback=5
				Size=2
				Distance=2
				Rush=2
				ControlledRush=1
				RoundMovement=0
				WindUp=1
				WindupMessage="charges their blade with imperial willpower!"
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=3
				EnergyCost=10
				Quaking=10
				ActiveMessage="releases a hyper destructive slash!"
				verb/Ark_Brave()
					set category="Skills"
					usr.Activate(src)
			Judgment
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/AutoHit/Hero_Spin")
				LockOut=list("/obj/Skills/AutoHit/Rising_Spire", "/obj/Skills/AutoHit/Ark_Brave", "/obj/Skills/AutoHit/Drill_Spin")
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				Cooldown = 60
				DamageMult=0.35
				Rounds=20
				ComboMaster=1
				Size=1
				EnergyCost=5
				Icon='CircleWind.dmi'
				IconX=-32
				IconY=-32
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				ActiveMessage="spins for glory!"
				verb/Judgment()
					set category="Skills"
					usr.Activate(src)

//T3 is in Grapples.

//T4 is in Projectiles too.

			Flash_Cut
				SkillCost=160
				Copyable=4
				NeedsSword=1
				Area="Circle"
				GuardBreak=1
				StrOffense=1
				Distance=1
				Rush=10
				ControlledRush=1
				PassThrough=1
				DamageMult=10
				WindUp=1
				WindupMessage="sheathes their blade..."
				ActiveMessage="erupts with a burst of godspeed, reaching their target in an instant!"
				Cooldown=120
				PassThrough=1
				PreShockwave=1
				PostShockwave=0
				Shockwave=2
				Shockwaves=2
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				Earthshaking=10
				verb/Flash_Cut()
					set category="Skills"
					usr.Activate(src)
			Jet_Slice
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Flash_Cut")
				LockOut=list("/obj/Skills/AutoHit/Crowd_Cutter", "/obj/Skills/AutoHit/Holy_Justice", "/obj/Skills/AutoHit/Doom_of_Damocles")
				NeedsSword=1
				Area="Target"
				GuardBreak=1
				StrOffense=1
				DamageMult=12
				Distance=10
				PassThrough=1
				PreShockwave=1
				PostShockwave=1
				Shockwave=2
				Shockwaves=2
				ActiveMessage="flickers behind their opponent for an instantaneous slash!"
				Cooldown=120
				EnergyCost=10
				verb/Jet_Slicer()
					set category="Skills"
					usr.Activate(src)
			Crowd_Cutter
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Flash_Cut")
				LockOut=list("/obj/Skills/AutoHit/Jet_Slice", "/obj/Skills/AutoHit/Holy_Justice", "/obj/Skills/AutoHit/Doom_of_Damocles")
				NeedsSword=1
				Area="Wide Wave"
				StrOffense=1
				Distance=10
				PassThrough=1
				PreShockwave=1
				PostShockwave=0
				Shockwave=2
				Shockwaves=2
				DamageMult=12
				WindUp=0.1
				WindupMessage="sheathes their blade..."
				ActiveMessage="blasts through all opposition in a blink of an eye!"
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='Dirt1.dmi'
				TurfShiftDuration=3
				Cooldown=120
				Instinct=1
				verb/Crowd_Cutter()
					set category="Skills"
					usr.Activate(src)
			Holy_Justice
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Flash_Cut")
				LockOut=list("/obj/Skills/AutoHit/Jet_Slice", "/obj/Skills/AutoHit/Crowd_Cutter", "/obj/Skills/AutoHit/Doom_of_Damocles")
				NeedsSword=1
				Area="Around Target"
				StrOffense=0.5
				ForOffense=1
				DamageMult=1
				HolyMod=2.5
				Distance=5
				DistanceAround=3
				Rounds=20
				TurfErupt=1.25
				TurfEruptOffset=6
				DelayTime=1
				Stunner=3
				Icon='SwordHugeHolyJustice.dmi'
				Size=1
				IconX=-159
				IconY=0
				Falling=1//animates towards pixel_z=0 while it is displayed
				ActiveMessage="plunges a phantom blade down for holy justice!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Cooldown=120
				Instinct=1
				verb/Holy_Justice()
					set category="Skills"
					usr.Activate(src)
			Doom_of_Damocles
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Flash_Cut")
				LockOut=list("/obj/Skills/AutoHit/Jet_Slice", "/obj/Skills/AutoHit/Holy_Justice", "/obj/Skills/AutoHit/Crowd_Cutter")
				NeedsSword=1
				Area="Around Target"
				StrOffense=1
				ForOffense=0.5
				DamageMult=0.75
				AbyssMod=2.5
				Distance=5
				DistanceAround=3
				Rounds=20
				TurfErupt=1.25
				TurfEruptOffset=6
				DelayTime=1
				Stunner=3
				Icon='SwordHugeDoomofDamocles.dmi'
				Size=1
				IconX=-159
				IconY=0
				Falling=1//animates towards pixel_z=0 while it is displayed
				ActiveMessage="plunges an ethereal sword down for a cruel execution!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Cooldown=120
				Instinct=1
				verb/Doom_of_Damocles()
					set category="Skills"
					usr.Activate(src)



//SHIT AINT USED
			SpinRave
				SkillCost=80
				Copyable=3
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				DamageMult=5
				Cooldown=120
				Knockback=20
				Size=2
				Distance=2
				RoundMovement=0
				WindUp=0.5
				WindupMessage="charges a massive amount of energy into their blade...!"
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				EnergyCost=5
				ActiveMessage="spins their blade with destructive force!"
				verb/Spin_Rave()
					set category="Skills"
					usr.Activate(src)
			TornadoRave
				SkillCost=60
				Copyable=4
				PreRequisite=list("/obj/Skills/AutoHit/SpinRave")
				LockOut=list("/obj/Skills/AutoHit/ArkBrave")
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				DamageMult=1
				Cooldown=240
				Knockback=1
				Rounds=7
				Size=2
				Distance=2
				RoundMovement=0
				WindUp=0.5
				WindupMessage="focuses the power of wind into their blade!!"
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				EnergyCost=10
				Shocking=1
				Instinct=1
				ActiveMessage="unleashes a tornado of strikes!"
				verb/Tornado_Rave()
					set category="Skills"
					usr.Activate(src)
			RecklessCharge
				SkillCost=30
				Copyable=3
				NeedsSword=1
				Area="Arc"
				StrOffense=1
				DamageMult=0.5
				Rounds=10
				ChargeTech=1
				ChargeTime=1
				Knockback=1
				Cooldown=140
				Size=1
				Icon='reckless.dmi'
				IconX=-16
				IconY=-16
				EnergyCost=1
				Instinct=1
				ActiveMessage="charges forward while performing countless slashing attacks!"
				verb/Reckless_Charge()
					set category="Skills"
					usr.Activate(src)
			BloodRush
				SkillCost=60
				Copyable=4
				PreRequisite=list("/obj/Skills/AutoHit/RecklessCharge")
				LockOut=list("/obj/Skills/AutoHit/SoulCharge")
				NeedsSword=1
				Area="Arc"
				StrOffense=1
				DamageMult=0.5
				LifeSteal=150
				WindUp=1
				WindupIcon='StormArmor.dmi'
				Rounds=10
				ChargeTech=1
				ChargeTime=1
				Knockback=1
				Cooldown=380
				Size=1
				Icon='reckless.dmi'
				IconX=-16
				IconY=-16
				WindupMessage="infuses their blade with bloodthirst..."
				ActiveMessage="carves through all in their path!"
				verb/Blood_Rush()
					set category="Skills"
					usr.Activate(src)
			SoulCharge
				SkillCost=60
				Copyable=4
				PreRequisite=list("/obj/Skills/AutoHit/RecklessCharge")
				LockOut=list("/obj/Skills/AutoHit/BloodRush")
				NeedsSword=1
				Area="Arc"
				StrOffense=1
				DamageMult=0.5
				EnergySteal=300
				WindUp=0.5
				WindupIcon='Overdrive.dmi'
				Rounds=15
				ChargeTech=1
				ChargeTime=1
				Knockback=1
				Cooldown=380
				Size=1
				Icon='reckless.dmi'
				IconX=-16
				IconY=-16
				WindupMessage="enchants their weapon with inspiration..."
				ActiveMessage="slices through every opponent in their path!"
				verb/Soul_Charge()
					set category="Skills"
					usr.Activate(src)
			HolyJudgment
				SkillCost=80
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Judgment")
				LockOut=list("/obj/Skills/AutoHit/DarkPurge")
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				HolyMod=5
				DamageMult=0.5
				Cooldown=300
				Rounds=30
				Size=1
				EnergyCost=10
				Icon='CircleWind.dmi'
				IconX=-32
				IconY=-32
				ActiveMessage="spins for holy justice!"
				verb/Holy_Judgment()
					set category="Skills"
					usr.Activate(src)
			DarkPurge
				SkillCost=80
				Copyable=5
				PreRequisite=list("/obj/Skills/AutoHit/Judgment")
				LockOut=list("/obj/Skills/AutoHit/HolyJudgment")
				NeedsSword=1
				Area="Circle"
				StrOffense=1
				AbyssMod=5
				DamageMult=0.4
				Cooldown=300
				Rounds=30
				Size=1
				EnergyCost=10
				Icon='CircleWind.dmi'
				IconX=-32
				IconY=-32
				ActiveMessage="spins for cruel vengence!"
				verb/Dark_Purge()
					set category="Skills"
					usr.Activate(src)
			FlashCutter
			CrowdCutter
			JetSlicer

//Tier S

///Eight Gates
			Night_Guy
				Destructive=1

///Saint Seiya
			Pegasus_Meteor_Fist//t5
				CosmoPowered=1
				FlickAttack=1
				Area="Wave"
				StrOffense=1
				DamageMult=11
				Launcher=1
				Distance=4
				Rush=10
				RushDelay=0.5
				ControlledRush=1
				GuardBreak=1
				PassThrough=1
				Knockback=0
				Cooldown=150
				WindUp=1
				WindupIcon=1
				WindupMessage="extends their arms and draws out the Pegasus constellation..."
				ActiveMessage="unleashes the god-defying barrage of Pegasus!"
				HitSparkIcon='Hit Effect Pegasus.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=0.8
				HitSparkCount=20
				HitSparkDispersion=24
				HitSparkDelay=1
				verb/Pegasus_Ryusei_Ken()
					set category="Skills"
					usr.Activate(src)
			Enraged_Dragon_Force
				CosmoPowered=1
			Aurora_Thunder_Attack
				CosmoPowered=1
				FlickAttack=1
				Area="Wave"
				ForOffense=1
				DamageMult=11
				Freezing=1
				Stasis=10
				Distance=12
				Slow=1
				GuardBreak=1
				Knockback=0.000001
				Cooldown=150
				WindUp=0.1
				WindupIcon=1
				WindupMessage="strikes towards the sky, filling the area with frigid aura!"
				PreShockwave=1
				PreShockwaveDelay=9
				Shockwaves=3
				Shockwave=5
				ShockIcon='fevKiaiG.dmi'
				PostShockwave=0
				ActiveMessage="unleashes a freezing blast of Swan's power!"
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=5
				HitSparkDispersion=1
				TurfStrike=1
				TurfShift='IceGround.dmi'
				TurfShiftDuration=180
				verb/Aurora_Thunder_Attack()
					set category="Skills"
					usr.Activate(src)
			Phoenix_Rising_Wing
				CosmoPowered=1
				FlickAttack=1
				Area="Wave"
				GuardBreak=1
				DamageMult=11
				Scorching=1
				Knockback=1
				Distance=15
				StrOffense=1
				ForOffense=1
				WindUp=0.5

				WindupIcon=1
				Slow=1
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=0.8
				HitSparkCount=1
				HitSparkDelay=1
				HitSparkDispersion=16
				Hurricane="/obj/Skills/Projectile/Phoenix_Wing"
				HurricaneDelay=0.5
				Cooldown=150
				WindupMessage="conjures scorching winds around their arms..."
				ActiveMessage="unleashes the destructive wingbeat of a Phoenix!"
				verb/Phoenix_Rising_Wing()
					set name="Houyoku Tenshou"
					set category="Skills"
					usr.Activate(src)
////Gold Cloth
			Starlight_Extinction
				CosmoPowered=1
				FlickAttack=2
				SpecialAttack=1
				Area="Target"
				GuardBreak=1
				WarpAway=4
				DamageMult=16
				Distance=5
				StrOffense=0
				ForOffense=1
				WindUp=2
				WindupIcon=1
				HitSparkIcon='AvalonLight.dmi'
				HitSparkX=-67
				HitSparkY=-3
				HitSparkSize=1
				HitSparkTurns=0
				HitSparkDelay=0
				HitSparkLife=50
				HitSparkDispersion=0
				Shockwaves=2
				Shockwave=1
				PreShockwave=1
				PostShockwave=0
				ShockIcon='KenShockwaveGold.dmi'
				ShockTime=4
				ShockBlend=2
				Cooldown=-1
				WindupMessage="focuses their telekinetic Cosmo to bend space to their whim..."
				ActiveMessage="casts their target away!"
				verb/Starlight_Extinction()
					set category="Skills"
					usr.Activate(src)
			Another_Dimension
				CosmoPowered=1
				FlickAttack=2
				SpecialAttack=1
				Area="Arc"
				GuardBreak=1
				WarpAway=1
				DamageMult=16
				Distance=7
				StrOffense=0
				ForOffense=1
				WindUp=1.5
				WindupIcon=1
				HitSparkIcon='Dimension Aura.dmi'
				HitSparkX=0
				HitSparkY=0
				HitSparkTurns=0
				HitSparkSize=2
				HitSparkCount=5
				HitSparkDelay=1
				HitSparkDispersion=32
				TurfShift='StarPixel.dmi'
				Cooldown=-1
				WindupMessage="focuses their Cosmo to disturb the dimensions..."
				ActiveMessage="opens up a rift to another world!"
				verb/Another_Dimension()
					set name="Another Dimension"
					set category="Skills"
					usr.Activate(src)
			Praesepe_Underworld_Waves
				CosmoPowered=1
				Area="Target"
				Distance=15
				StrOffense=0
				ForOffense=1
				DamageMult=15
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				GuardBreak=1
				WarpAway=3
				Shockwaves=6
				Shockwave=1
				PreShockwave=1
				PostShockwave=0
				ShockIcon='KenShockwaveGod.dmi'
				ShockTime=24
				ShockBlend=2
				WindUp=1
				WindupIcon=1
				WindupMessage="focuses their Cosmo into a wave of otherwordly energy..."
				ActiveMessage="casts out the souls of their targets into the antechamber of Underworld!"
				Cooldown=-1
				verb/Praesepe_Underworld_Waves()
					set name="Sekishiki Meikai Ha"
					set category="Skills"
					usr.Activate(src)
			Lightning_Plasma_Burst
				CosmoPowered=1
				FlickAttack=2
				Distance=8
				Slow=1
				Launcher=1
				Stunner=3
				Rounds=5
				RoundMovement=0
				DelayTime=1
				Area="Arc"
				StrOffense=1
				ForOffense=1
				DamageMult=11
				GuardBreak=1
				TurfStrike=1
				HitSparkIcon='LightningPlasma.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1
				HitSparkTurns=1
				HitSparkCount=2
				HitSparkDelay=2
				HitSparkDispersion=32
				Cooldown=150
				WindUp=1
				WindupIcon=1
				Rush=3
				ControlledRush=1
				WindupMessage="focuses Cosmo into their fist..."
				ActiveMessage="unleashes billion strikes in a second, creating a cage of light!"
				verb/Lightning_Plasma_Burst()
					set name="Lightning Plasma (Burst)"
					set category="Skills"
					usr.Activate(src)
			Demon_Pacifier
				CosmoPowered=1
				GodPowered=0.25
				RoundMovement=0
				SpecialAttack=1
				Area="Circle"
				GuardBreak=1
				DamageMult=11
				HolyMod=20
				Distance=6
				Knockback=10
				DelayTime=5
				StrOffense=0
				ForOffense=1
				WindUp=1
				WindupIcon=1
				PreShockwave=1
				Shockwaves=3
				Shockwave=5
				ShockIcon='fevKiaiDS.dmi'
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=0.8
				HitSparkCount=20
				HitSparkDelay=1
				HitSparkDispersion=16
				WindupMessage="utters a mantra, focusing their Cosmo..."
				ActiveMessage="presents their full majesty to the unworthy!"
				Cooldown=150
				verb/Demon_Pacifier()
					set category="Skills"
					set name="Tenma Kofuku"
					if(usr.SagaLevel<7 && usr.Health>15 && !usr.InjuryAnnounce)
						usr << "You can't use this technique except when in a dire pinch!"
						return
					usr.Activate(src)
			Heavenly_Ring_Dance
				CosmoPowered=1
				NoAttackLock=1
				SpecialAttack=1
				Area="Target"
				GuardBreak=1
				DamageMult=7
				Distance=10
				Knockback=15
				StrOffense=0
				ForOffense=1
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=1
				HitSparkCount=30
				HitSparkDelay=1
				HitSparkDispersion=32
				ActiveMessage="banishes their opponent from their presence!"
			Heavenly_Ring_Dance_Burst
				CosmoPowered=1
				NoAttackLock=1
				SpecialAttack=1
				Area="Circle"
				GuardBreak=1
				DamageMult=10
				Distance=6
				Stunner=4
				Knockback=15
				StrOffense=0
				ForOffense=1
				WindUp=1
				WindupIcon=1
				PreShockwave=1
				PostShockwave=0
				Shockwaves=1
				Shockwave=5
				ShockIcon='KenShockwaveGold.dmi'
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=1
				HitSparkCount=30
				HitSparkDelay=1
				HitSparkDispersion=32
				ActiveMessage="cripples and banishes the unworthy from their presence!"
			Restriction
				CosmoPowered=1
				SpecialAttack=1
				Area="Circle"
				Distance=15
				StrOffense=0
				ForOffense=1
				DamageMult=12
				Shockwaves=4
				Shockwave=5
				PreShockwave=1
				PostShockwave=0
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Stunner=2
				Crippling=15
				ShockIcon='KenShockwaveBloodlust.dmi'
				ShockTime=24
				ShockBlend=2
				WindUp=1
				WindupIcon=1
				WindupMessage="focuses their Cosmo into a wave of pure intimidation..."
				ActiveMessage="wraps their victims in their threatening Cosmo, paralyzing their bodies."
				Cooldown=150
				verb/Restriction()
					set category="Skills"
					usr.Activate(src)
			Sacred_Sword_Excalibur
				CosmoPowered=1
				GodPowered=0.25
				NeedsSword=1
				Area="Wave"
				TurfShift='Seiken2.dmi'
				TurfShiftLayer=4
				TurfShiftDuration=10
				TurfShiftDurationSpawn=-5
				TurfShiftDurationDespawn=10
				GuardBreak=1
				DamageMult=15
				MaimStrike=5
				Distance=10
				Cooldown=-1
				StrOffense=1
				ForOffense=1
				SpecialAttack=1
				Slow=0
				StopAtTarget=0
				WindUp=1
				WindupIcon=1
				WindupMessage="focuses their Cosmo as they slowly raise their arm..."
				ActiveMessage="unleashes the power of the Legendary Exalibur, parting everything before them!"
				verb/Sacred_Sword_Excalibur()
					set category="Skills"
					if(usr.SagaLevel<7 && usr.Health>15 && !usr.InjuryAnnounce)
						usr << "You can't use this technique except when in a dire pinch!"
						return
					usr.Activate(src)
			Ice_Coffin
				CosmoPowered=1
				SpecialAttack=1
				Distance=10
				Area="Target"
				GuardBreak=1
				DamageMult=5
				StrOffense=1
				Stasis=30
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=5
				HitSparkCount=9
				HitSparkDispersion=1
				WindUp=1
				WindupIcon=1
				WindupMessage="focuses Cosmo at the tip of their finger..."
				ActiveMessage="encases their target in a coffin of unbreakable ice!"
				Cooldown=150
				verb/Ice_Coffin()
					set category="Skills"
					usr.Activate(src)
			Bloody_Rose
				CosmoPowered=1
				SpecialAttack=1
				Distance=30
				Area="Target"
				GuardBreak=1
				DamageMult=0
				ForOffense=1
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.5
				HitSparkDispersion=0
				WindUp=1
				WindupIcon=1
				MortalBlow=1
				WindupMessage="focuses their Cosmo on a brilliantly white rose..."
				ActiveMessage="casts the rose at their target, unavoidably stabbing their heart!"
				Cooldown=-1
				verb/Bloody_Rose()
					set category="Skills"
					usr.Activate(src)

///King of Braves
			Hell_And_Heaven
				Area="Circle"
				DamageMult=2
				Rounds=10
				ChargeTech=1
				StrOffense=1
				ForOffense=1
				Rush=10
				SpecialAttack=1
				Hurricane="/obj/Skills/Projectile/King_of_Braves/Brave_Tornado"
				GuardBreak=1
				Grapple=1
				GrabTrigger="/obj/Skills/Grapple/Erupting_Burning_Finger/Removable"
				Knockback=1
				WindUp=2
				WindupIcon='GaoGaoFists.dmi'
				WindupMessage="begins gathering the forces of Destruction and Creation in their hands!"
				ActiveMessage="rushes in for the certain kill!"
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkDispersion=1
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkCount=1
				Cooldown=-1
				verb/Hell_And_Heaven()
					set category="Skills"
					if(usr.SagaLevel>6)
						src.DamageMult=3
						src.ControlledRush=1
						WindupMessage="combines the forces of Destruction and Creation with absolute control!"
					usr.Activate(src)
			Goldion_Hammer
				StrOffense=1
				ForOffense=1
				DamageMult=15
				Area="Circle"
				Distance=5
				TurfErupt=2
				TurfEruptOffset=3
				Slow=1
				WindUp=2
				WindupIcon='GGG_Hammer.dmi'
				WindupIconX=-16
				WindupIconY=-16
				Divide=1
				Knockback=25
				WindupMessage="spawns in a hammer of immense size!"
				ActiveMessage="unleashes a single hammer strike that devastates everything nearby!"
				HitSparkIcon='BLANK.dmi'
				HitSparkX=0
				HitSparkY=0
				Cooldown=-1
				Earthshaking=15
				verb/Goldion_Hammer()
					set category="Skills"
					usr.Activate(src)

///Sharingan
			Tsukiyomi
				Area="Arc"
				ForOffense=1
				DamageMult=18
				Distance=10
				AllOutAttack=1
				DelayTime=0
				GuardBreak=1
				Stunner=6
				Shattering = 50
				EnergyCost = 30
				HitSparkIcon='BLANK.dmi'
				ActiveMessage="aims to trap their opponent in a powerful illusion with a single glance!"
				Cooldown=-1
				BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/MSDebuff/Seishinkai_to_Yami"
				verb/Tsukiyomi()
					set category="Skills"
					usr.Activate(src)
			Amaterasu
				StrOffense=1
				ForOffense=1
				DamageMult=13
				Scorching=1
				Toxic=1
				Area="Around Target"
				CanBeBlocked=0
				CanBeDodged=0
				Distance=7
				DistanceAround=3
				HitSparkIcon='Hit Effect Dark.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=4
				HitSparkCount=4
				HitSparkDispersion=4
				TurfStrike=1
				TurfShift='amaterasu.dmi'
				TurfShiftDuration=90
				Cooldown=200
				WoundCost=15
				BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/MSDebuff/Busshitsukai_to_Hikari"
				ActiveMessage="aims to incinerate their opponents in an ebony pyre!"
				proc/adjust(mob/p)
					var/sagaLevel = p.SagaLevel
					if(altered) return
					DarknessFlame = 0.25 + (sagaLevel/8)
					Scorching = 8 + sagaLevel
					Toxic = 8 + sagaLevel
					DamageMult = 4 + (sagaLevel*2)
					WoundCost = 15 - sagaLevel * 1.25
				verb/Amaterasu()
					set category="Skills"
					if(usr.SagaLevel>=7)
						WoundCost=0
						EnergyCost=20
					usr.Activate(src)
			Amaterasu2
				StrOffense=0
				ForOffense=1
				DamageMult=12
				Scorching=5
				Toxic=5
				Area="Around Target"
				CanBeBlocked=0
				CanBeDodged=1
				Distance=7
				DistanceAround=2
				HitSparkIcon='Hit Effect Dark.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=4
				HitSparkCount=4
				HitSparkDispersion=4
				TurfStrike=1
				TurfShift='amaterasu.dmi'
				TurfShiftDuration=90
				Cooldown=180
				WoundCost=10
				BuffAffected = "/obj/Skills/Buffs/SlotlessBuffs/Autonomous/MSDebuff/Busshitsukai_to_Hikari"
				ActiveMessage="aims to incinerate their opponents in an ebony pyre!"
				proc/adjust(mob/p)
					var/sagaLevel = p.SagaLevel
					if(altered) return
					DarknessFlame = 1 + (sagaLevel/8)
					Scorching = 10 + sagaLevel
					Toxic = 10 + sagaLevel
					DamageMult = 4 + (sagaLevel*2)
					WoundCost = 12 - sagaLevel * 1.25
				verb/Amaterasu()
					set category="Skills"
					if(usr.SagaLevel>=7)
						WoundCost=0
						EnergyCost=20
					usr.Activate(src)

///Hiten
			Sonic_Sheath
				name="Ryumeisen"
				Area="Circle"
				StrOffense=1
				StyleNeeded="Hiten Mitsurugi"
				DamageMult=0
				Distance=7
				PassThrough=1
				Stunner=5
				PreShockwave=1
				Shockwave=5
				Shockwaves=5
				PostShockwave=0
				Cooldown=180
				NoLock=1
				NoAttackLock=1
				HitSparkIcon='BLANK.dmi'
				ActiveMessage="sheathes their sword with stunning authority!"
				verb/Ryumeisen()
					set category="Skills"
					usr.Activate(src)
			NestedSlash
				name="Ryusousen"
				StyleNeeded="Hiten Mitsurugi"
				Area="Arc"
				StrOffense=1
				DamageMult=7
				EnergyCost=2
				Rush=3
				ControlledRush=1
				Cooldown=60
				Icon='Nest Slash.dmi'
				IconTime=0.7
				IconX=-16
				IconY=-16
				Size=0.8
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.8
				HitSparkTurns=1
				HitSparkCount=10
				NoLock=1
				NoAttackLock=1
				ActiveMessage="throws countless sword strikes in an endless flurry!"
				verb/Ryusousen()
					set category="Skills"
					usr.Activate(src)
			CoiledSlash
				name="Ryukansen"
				NeedsSword=1
				StyleNeeded="Hiten Mitsurugi"
				Area="Circle"
				StrOffense=1
				DamageMult=1.25
				ChargeTech=1
				ChargeTime=0
				DelayTime=0
				Cooldown=60
				Size=1
				Rounds=10
				Icon='Air Slash.dmi'
				IconX=-8
				IconY=-8
				HitSparkIcon='Slash.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.8
				HitSparkTurns=1
				TurfStrike=1
				EnergyCost=2
				NoLock=1
				NoAttackLock=1
				ActiveMessage="bursts forward, performing a whirling slash!"
				verb/Ryukansen()
					set category="Skills"
					usr.Activate(src)

///Ansatsuken
			Tatsumaki
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				Cooldown=50
				Size=1
				Rush=3
				ControlledRush=1
				ComboMaster=1
				StyleNeeded="Ansatsuken"
				proc/alter(mob/player)
					ManaCost = 0
					var/sagaLevel = player.SagaLevel
					var/damage = clamp(0.2 * (usr.SagaLevel/2), 0.2, 1)
					var/path = player.AnsatsukenPath == "Tatsumaki" ? 1 : 0
					var/manaCost = 25 // how much u need for ex
					var/rounds = clamp(1 + (usr.SagaLevel/2), 3, 8)
					var/cooldown = 50
					var/launch = 0
					if(path)
						cooldown = 30
						manaCost -= 10
						damage = clamp(0.35 * (usr.SagaLevel/2), 0.35, 1.5)
						rounds = clamp(usr.SagaLevel, 3, 8)


					if(player.ManaAmount>=manaCost && sagaLevel >= 2)
						damage = clamp(0.4 * (usr.SagaLevel/2), 0.4, 2)
						rounds = clamp(2 + usr.SagaLevel, 4, 11)
						ManaCost = 35
						launch = 3
						ActiveMessage="rises high in the air with a terrifying whirlwind of kicks!!"

					DamageMult = damage
					Cooldown = cooldown
					Rounds = rounds
					Launcher = launch
				verb/Tatsumaki()
					set category="Skills"
					alter(usr)
					ChargeTech = 1
					ChargeTime=0.75
					usr.Activate(src)
			ShinkuTatsumaki
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				DamageMult=0.5
				Crippling=1
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				Rounds=20
				Cooldown=300
				Size=3
				Distance=3
				ManaCost=100
				Rush=5
				ControlledRush=1
				Launcher=3
				ComboMaster=1
				StyleNeeded="Ansatsuken"
				ActiveMessage="ascends peerlessly, carried on a divine tornado of kicks!!!"
				verb/Shinku_Tatsumaki()
					set category="Skills"
					set name="Shinku-Tatsumaki"
					usr.Activate(src)
			Demon_Armageddon
				UnarmedOnly=1
				Area="Circle"
				StrOffense=1
				Crippling=1
				Icon='SweepingKick.dmi'
				IconX=-32
				IconY=-32
				Size=2
				Cooldown=10800
				Size=1
				Rush=3
				ControlledRush=1
				Launcher=2
				ComboMaster=1
				StyleNeeded="Ansatsuken"
				verb/Demon_Armageddon()
					set category="Skills"
					set name="Demon Armageddon"
					usr.Activate(src)
			Raging_Demon // Shun goku Satsu, but revamped
				Area="Target"
				SpecialAttack=1
				ComboMaster=1
				Launcher=5
				DamageMult = 1
				Rounds = 16
				StepsDamage = 0.05
				StrOffense=1
				Distance = 10
				Rush=5
				RushDelay=2
				ControlledRush=1
				GuardBreak=1
				PassThrough=1
				Cooldown=-10
				WindUp=1.5
				WindupIcon='BijuuInitial.dmi'
				WindupIconUnder=1
				WindupIconX=-32
				WindupIconY=-32
				WindupMessage="radiates murderous intent!"
				Gravity=5
				HitSparkIcon='Hit Effect Satsui.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkCount=2
				HitSparkDispersion=24
				HitSparkDelay=1
				RagingDemonAnimation = 1
				Executor = 10
				proc/update(mob/p)
					var/sagaLevel = p.SagaLevel
					StepsDamage = 0.01 * sagaLevel
					Distance = 5 + sagaLevel
					WindUp = 2 - (sagaLevel*0.2)
					StrOffense = 1 + (sagaLevel * 0.05)

				verb/Raging_Demon()
					set category="Skills"
					set name="Raging Demon"
					update(usr)
					usr.Activate(src)
			Shun_Goku_Satsu
				Area="Target"
				SpecialAttack=1
				StrOffense=1
				DamageMult=7.5
				HolyMod=10
				Distance=5
				Rush=5
				RushDelay=2
				ControlledRush=1
				GuardBreak=1
				FlickAttack=1
				PassThrough=1
				Knockback=0
				Cooldown=1
				WindUp=0.1
				WindupIcon='BijuuInitial.dmi'
				WindupIconUnder=1
				WindupIconX=-32
				WindupIconY=-32
				WindupMessage="radiates murderous intent!"
				ActiveMessage="slides towards their opponent and unleashes a demonic 16-hit combination!!!!"
				HitSparkIcon='Hit Effect Satsui.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkCount=16
				HitSparkDispersion=24
				HitSparkDelay=1
				Gravity=5


///Weapon Soul
			Great_Divide
				NeedsSword=1
				ABuffNeeded="Soul Resonance"
				EnergyCost=25
				Area="Arc"
				Distance=10
				DamageMult=15
				StrOffense=1
				EndDefense=1
				ForOffense=0
				Cooldown=-1
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=7
				TurfStrike=1
				Divide=1
				Slow=1
				WindUp=1
				GuardBreak=1//Can't be dodged or blocked
				WindupMessage="draws their blade back for a colossal swing..."
				ActiveMessage="releases a gigaton slash that parts the earth like butter!"
				verb/Great_Divide()
					set category="Skills"
					usr.Activate(src)
			DurendalPressure
				NoAttackLock=1
				NeedsSword=1
				Area="Wave"
				Distance=4
				StrOffense=1
				Knockback=1
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=5
				TurfStrike=1
				Slow=1
				DamageMult=2//First step is 1 damage
				StepsDamage=1//fourth step is 5 damage
				ActiveMessage="whiffs their swing, causing a powerful wave of pressure!"

			Crystal_Tomb
				NeedsSword=1
				ABuffNeeded="Soul Resonance"
				Distance=10
				WindUp=1
				WindupMessage="channels an oath of just order into Soul Calibur..."
				Area="Around Target"
				DistanceAround=7
				GuardBreak=1
				TurfStrike=1
				TurfShift='IceGround.dmi'
				TurfShiftDuration=500
				DamageMult=10
				HolyMod=10
				Purity=1
				StrOffense=1
				ActiveMessage="encases their target in a tomb of soul-infused crystal!  They are forced into perfect stasis!"
				Stasis=50
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=5
				HitSparkCount=9
				HitSparkDispersion=1
				Cooldown=-1
				verb/Crystal_Tomb()
					set category="Skills"
					usr.Activate(src)

			War_God_Descent
				NeedsSword=1
				ABuffNeeded="Soul Resonance"
				Distance=15
				Gravity=5
				WindUp=3
				WindupMessage="prepares to cut through the very space around them in defiance of everything..."
				DamageMult = 15
				StrOffense=1
				Stunner = 3
				ActiveMessage="slashes through the very concept of space, breaking reality to force their desires onto the world with the might of War!"
				Area="Target"
				GuardBreak=1
				PassThrough=1
				MortalBlow=2
				Shattering = 70
				Shocking = 70
				Crippling = 40
				HitSparkIcon='Slash - Zan.dmi'
				HitSparkX=-16
				HitSparkY=-16
				HitSparkTurns=1
				HitSparkSize=3
				Cooldown=-1
				EnergyCost=15
				Instinct=1
				verb/WarGodDescent()
					set name = "War God's Descent"
					set category="Skills"
					usr.Activate(src)
			Deathbringer
				NeedsSword=1
				ABuffNeeded="Soul Resonance"
				Distance=50
				WindUp=2
				WindupMessage="evokes the power of death..."
				DamageMult=15
				StrOffense=1
				ActiveMessage="slashes through their enemy in the blink of an eye, mortally wounding them!"
				Area="Target"
				GuardBreak=1
				StopAtTarget=1
				MortalBlow=2
				PostShockwave=0
				PreShockwave=1
				Shockwave=5
				Shockwaves=3
				ShockIcon='DarkKiai.dmi'
				HitSparkIcon='Slash - Hellfire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=2
				Cooldown=-1
				verb/Deathbringer()
					set category="Skills"
					usr.Activate(src)

//Cybernetics and enchantment
			Gear
				Incinerator
					Area="Wave"
					TurfErupt=1
					GuardBreak=1
					DamageMult=4.5
					Scorching=4
					Distance=10
					Cooldown=60
					StrOffense=0.5
					ForOffense=0.5
					Slow=1
					HitSparkIcon='BLANK.dmi'
					verb/Incinerator()
						set category="Skills"
						usr.Activate(src)
				Freeze_Ray
					Area="Strike"
					HitSparkIcon='Hit Effect Pearl.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkTurns=1
					HitSparkSize=5
					TurfStrike=1
					TurfShift='IceGround.dmi'
					TurfShiftDuration=180
					GuardBreak=1
					DamageMult=4.5
					Freezing=10
					Stasis=20
					Distance=10
					Cooldown=60
					StrOffense=0.5
					ForOffense=0.5
					Slow=1
					verb/Freeze_Ray()
						set category="Skills"
						usr.Activate(src)
				Integrated
					Integrated=1
					Integrated_Incinerator
						Area="Wave"
						TurfErupt=1
						GuardBreak=1
						DamageMult=4.5
						Scorching=4
						Distance=10
						Cooldown=60
						StrOffense=0.5
						ForOffense=0.5
						Slow=1
						HitSparkIcon='BLANK.dmi'
						verb/Incinerator()
							set category="Skills"
							usr.Activate(src)
					Integrated_Freeze_Ray
						Area="Strike"
						HitSparkIcon='Hit Effect Pearl.dmi'
						HitSparkX=-32
						HitSparkY=-32
						HitSparkTurns=1
						HitSparkSize=5
						TurfStrike=1
						TurfShift='IceGround.dmi'
						TurfShiftDuration=180
						GuardBreak=1
						DamageMult=4.5
						Freezing=10
						Stasis=20
						Distance=10
						Cooldown=60
						StrOffense=0.5
						ForOffense=0.5
						Slow=1
						verb/Freeze_Ray()
							set category="Skills"
							usr.Activate(src)
///Cybernetics
			Cyberize
				Machine_Gun_Flurry
					Area="Circle"
					Distance=1
					StrOffense=1
					ManaCost=2
					DamageMult=0.9
					Launcher = 2
					ComboMaster=1
					Rounds=10
					Rush=25
					ControlledRush=1
					Cooldown=60
					HitSparkIcon='Hit Effect Ripple.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkTurns=1
					HitSparkSize=0.6
					HitSparkCount=10
					HitSparkDispersion=24
					HitSparkDelay=1
					ActiveMessage="burns their battery to attack in a cybernetic flurry!"
					verb/Machine_Gun_Flurry()
						set category="Skills"
						usr.Activate(src)

///Enchantment

////Nox
			FrostBite
				NoTransplant=1
				Area="Strike"
				ControlledRush=1
				Rush=3
				Distance=1
				StrOffense=1
				ForOffense=0.5
				DamageMult=4.5
				HitSparkIcon='Hit Effect Pearl.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=5
				HitSparkCount=5
				HitSparkDispersion=1
				HitSparkDelay=1
				Cooldown=60
				ActiveMessage="thrusts their hand forward to freeze all within their grasp!"
				Freezing=20
				Stasis=10
				verb/Frost_Bite()
					set category="Skills"
					usr.Activate(src)
			OpticBarrel
				NoTransplant=1
				Area="Target"
				Distance=5
				Cooldown=20
				ForOffense=1
				DamageMult=2
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1
				HitSparkCount=5
				HitSparkDispersion=1
				HitSparkDelay=1
				ActiveMessage="yells: OPTIC BARREL!"
				verb/Optic_Barrel()
					set category="Skills"
					usr.Activate(src)
////General
			Giga_Slave
				NoTransplant=1
				ForOffense=1
				SpecialAttack=1
				DamageMult=40
				Area="Around Target"
				Distance=30
				DistanceAround=12
				WindupMessage="begins invoking an all-consuming force of destruction..."
				WindUp=3
				ActiveMessage="unleashes a massive wave of chaotic energies upon their foes!!"
				ManaCost=100
				CapacityCost=80
				Cooldown=10800
				MortalBlow=2
				GuardBreak=1//Can't be dodged or blocked
				Destructive=2
				HitSparkIcon='Hit Effect Dark.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=4
				HitSparkCount=4
				HitSparkDispersion=4
				TurfStrike=1
				TurfShiftLayer=EFFECTS_LAYER
				TurfShiftDuration=-10
				TurfShiftDurationSpawn=0
				TurfShiftDurationDespawn=5
				TurfShift='Gravity.dmi'
				verb/Giga_Slave()
					set category="Skills"
					usr.Activate(src)




mob
	proc
		Activate(var/obj/Skills/AutoHit/Z)
			if(Z.Using)//Skill is on cooldown.
				return
			if(!src.CanAttack(1.5)&&!Z.NoAttackLock)
				return
			if(Z.Sealed)
				src << "You can't use [Z] it is Sealed!"
				return
			if(Z.AssociatedGear)
				if(!Z.AssociatedGear.InfiniteUses)
					if(Z.Integrated)
						if(Z.AssociatedGear.IntegratedUses<=0)
							src << "[Z] doesn't have enough power to function!"
							if(src.ManaAmount>=10)
								src << "Your [Z] automatically draws on new power to reload!"
								src.LoseMana(10)
								Z.AssociatedGear.IntegratedUses=Z.AssociatedGear.IntegratedMaxUses
							return
					else
						if(Z.AssociatedGear.Uses<=0)
							src << "[Z] doesn't have enough power to function!"
							return
			if(Z.MagicNeeded&&!src.HasLimitlessMagic())
				if(src.HasMechanized()&&src.HasLimitlessMagic()!=1)
					src << "You lack the ability to use magic!"
					return
				if(Z.Copyable>=3||!Z.Copyable)
					if(!src.HasSpellFocus(Z))
						src << "You need a spell focus to use [Z]."
						return
			if(Z.GuardBreak)
				Z.CanBeBlocked=0
				Z.CanBeDodged=0
			else
				if(!Z.CanBeBlocked&&!Z.CanBeDodged)
					if(Z.Area=="Circle"||Z.Area=="Arc")
						Z.CanBeBlocked=1
						Z.CanBeDodged=0
					else//Not circle
						Z.CanBeBlocked=0
						Z.CanBeDodged=1
			if(Z.Area=="Target"||Z.Area=="Around Target")
				if(!src.Target)
					src << "You need a target to use [Z]!"
					return
				if(src.Target==src)
					src << "You can't target yourself while using [Z]!"
					return
				if(src.Target.z!=src.z)
					src << "Stop trying to hit [src.Target] from a different dimension!"
					return
				if(!Z.Rush)//This one doesn't apply to rushes.
					if(src.x+Z.Distance<src.Target.x||src.x-Z.Distance>src.Target.x||src.y+Z.Distance<src.Target.y||src.y-Z.Distance>src.Target.y)
						src << "They're not in range!"
						return
				if(Target && Target.passive_handler.Get("CounterSpell"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Magic/Counterspell/s in Target)
						if(s.Using)
							s.Trigger(Target, Override = 1)
					OMsg(Target, "[Target]'s counterspell nullified [Z]")
					Z.Cooldown()
					return
			if(Z.NeedsSword)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(!s)
					if(!src.HasSwordPunching() && !src.UsingBattleMage())
						src << "You need a sword equipped to use [Z]!"
						return
			if(Z.UnarmedOnly)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(s)
					if(!HasSwordPunching())
						src << "You can't have a sword equipped when using [Z]!  It's an unarmed technique!"
						return
				if(src.UsingBattleMage())
					src << "You can't use unarmed techniques while using Battle Mage!"
					return
			if(Z.ABuffNeeded)
				if(!src.ActiveBuff||src.ActiveBuff.BuffName!=Z.ABuffNeeded)
					src << "You have to be in [Z.ABuffNeeded] state to use this!"
					return
			if(Z.SBuffNeeded)
				if(!src.SpecialBuff||src.SpecialBuff.BuffName!=Z.SBuffNeeded)
					src << "You have to be in [Z.SBuffNeeded] state to use this!"
					return
			if(Z.StanceNeeded)
				if(src.StanceActive!=Z.StanceNeeded)
					src << "You have to be in [Z.StanceNeeded] stance to use this!"
					return
			if(Z.StyleNeeded)
				if(src.StyleActive!=Z.StyleNeeded)
					src << "You have to be using [Z.StyleNeeded] style to use this!"
					return
			if(Z.GateNeeded)
				if(src.GatesActive<Z.GateNeeded)
					if(SagaLevel>=Z.GateNeeded&&Z.GateNeeded!=8)
						var/difference = Z.GateNeeded-src.GatesActive
						for(var/x in 1 to difference)
							ActiveBuff:handleGates(usr, TRUE)
					src << "You have to open at least Gate [Z.GateNeeded] to use this skill!"
					return
			if(Z.ClassNeeded)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(s.Class!=Z.ClassNeeded && (istype(Z.ClassNeeded, /list) && !(s.Class in Z.ClassNeeded)))
					src << "You need a [istype(Z.ClassNeeded, /list) ? Z.ClassNeeded[1] : Z.ClassNeeded]-class weapon to use this technique."
					return
			if(!Z.StrOffense&&!Z.ForOffense)
				src << "[Z] is bugged and doesn't know how to calculate damage."
				return
			if(Z.HealthCost)
				if(src.Health<Z.HealthCost*glob.WorldDamageMult&&!Z.AllOutAttack)
					return
			if(Z.EnergyCost)
				if(src.Energy<Z.EnergyCost&&!Z.AllOutAttack)
					if(!src.CheckSpecial("One Hundred Percent Power")&&!src.CheckSpecial("Fifth Form")&&!CheckActive("Eight Gates"))
						return
			if(Z.ManaCost && !src.HasDrainlessMana() && !Z.AllOutAttack)
				var/drain = src.passive_handler.Get("MasterfulCasting") ? Z.ManaCost - (Z.ManaCost * (passive_handler.Get("MasterfulCasting") * 0.3)) : Z.ManaCost
				if(drain <= 0)
					drain = 0.5
				if(!src.TomeSpell(Z))
					if(src.ManaAmount<drain)
						src << "You don't have enough mana to activate [Z]."
						return
				else
					if(src.ManaAmount<drain*(1-(0.45*src.TomeSpell(Z))))
						src << "You don't have enough mana to activate [Z]."
						return
			if(Z.HitSparkIcon)
				src.HitSparkIcon=Z.HitSparkIcon
				src.HitSparkX=Z.HitSparkX
				src.HitSparkY=Z.HitSparkY
				src.HitSparkTurns=Z.HitSparkTurns
				src.HitSparkSize=Z.HitSparkSize
				src.HitSparkCount=Z.HitSparkCount
				src.HitSparkDispersion=Z.HitSparkDispersion
				src.HitSparkDelay=Z.HitSparkDelay
				src.HitSparkLife=Z.HitSparkLife
			if(Z.Quaking)
				src.Quaking=Z.Quaking
			Z.ExtendMemory=0
			if(Z.NeedsSword&&src.HasExtend())
				Z.ExtendMemory=src.GetExtend()
				Z.Distance+=Z.ExtendMemory//Increase distance for this shot...
				Z.Size+=Z.ExtendMemory
			if(src.HasRipple())
				var/BreathCost=Z.DamageMult*10
				if(Z.Rounds)
					BreathCost*=sqrt(Z.Rounds)
				if(src.Oxygen>BreathCost)
					Z.RipplePower*=(1+(0.25*src.GetRipple()*max(1,src.PoseEnhancement*2)))
					Z.DamageMult*=Z.RipplePower
					src.Oxygen-=BreathCost/4
				else if(src.Oxygen >= src.OxygenMax*0.3)
					Z.RipplePower*=(1+(0.125*src.GetRipple()*max(1,src.PoseEnhancement*2)))
					Z.DamageMult*=Z.RipplePower
					src.Oxygen-=BreathCost/6
				else
					src.Oxygen-=BreathCost/8
				if(src.Oxygen<=0)
					src.Oxygen=0
			if(!Z.NoLock)
				src.AutoHitting=1
			var/turf/TrgLoc
			if(Z.Area=="Around Target"||Z.Area=="Target")
				TrgLoc=src.Target.loc
				if(Target.passive_handler.Get("CounterSpell"))
					for(var/obj/Skills/Buffs/SlotlessBuffs/Magic/Counterspell/s in Target)
						if(s.Using)
							s.Trigger(Target, Override = 1)
					OMsg(Target, "[Target]'s counterspell nullified [Z]")
					Z.Cooldown()
					return
			if(Z.CustomCharge)
				OMsg(src, "[Z.CustomCharge]")
			else
				if(Z.WindupMessage)
					OMsg(src, "<b><font color='[Z.WindupColor]'>[src] [Z.WindupMessage]</font color></b>")
			if(src.TomeSpell(Z))
				Z.Cooldown(1-(0.25*src.TomeSpell(Z)))
			else
				Z.Cooldown()
			if(Z.Copyable)
				spawn() for(var/mob/m in view(10, src))
					if(m.CheckSpecial("Sharingan"))
						if(m.SagaLevel<=Z.Copyable)
							continue
						if(m.client&&m.client.address==src.client.address)
							continue
						if(!locate(Z.type, m))
							m.AddSkill(new Z.type)
							m << "Your Sharingan analyzes and stores the [Z] technique you've just viewed."
				spawn()
					for(var/obj/Items/Tech/Security_Camera/SC in view(10, src))
						if(Z.PreRequisite.len<1)
							SC.ObservedTechniques["[Z.type]"]=Z.Copyable
				spawn()
					for(var/obj/Items/Tech/Recon_Drone/RD in view(10, src))
						if(Z.PreRequisite.len<1)
							RD.ObservedTechniques["[Z.type]"]=Z.Copyable
			if(Z.PassThrough)
				if(Z.Area=="Strike")
					Z.StopAtTarget=1

			var/missed = 0 //If the target is out of range at the end of a windup.
			if(Z.WindUp)
				src.Grab_Release()
				if(Z.Float)
					if(!src.pixel_z)
						spawn()
							Jump(src, FloatTime=Z.Float)
						sleep(3)
				if(Z.WindUp>=2)
					src.WindingUp=2
				else
					src.WindingUp=1
				if(Z.WindupIcon)
					if(Z.WindupIcon!=1)
						spawn()
							LeaveImage(src, Z.WindupIcon, Z.WindupIconX, Z.WindupIconY, 0, Z.WindupIconSize, Z.WindupIconUnder, Z.WindUp*10)
					else
						if(!src.AuraLocked&&!src.HasKiControl())
							src.Auraz("Add")
						else
							KenShockwave(src,icon='KenShockwaveFocus.dmi',Size=0.3, Blend=2, Time=2)
						spawn(Z.WindUp*10)
							if(!src.AuraLocked&&!src.HasKiControl())
								src.Auraz("Remove")
				if(Z.Hurricane)
					var/path=text2path(Z.Hurricane)
					if(!locate(path, src))
						src.AddSkill(new path)
					spawn(Z.HurricaneDelay*10)
						src.dir=get_dir(src,src.Target)
						for(var/obj/Skills/Projectile/p in src)
							if(istype(p, path))
								src.UseProjectile(p)
				else
					spawn()src.WindupGlow(src)
				if(Z.Float||Z.Ice||Z.Thunderstorm||Z.Gravity)
					src.Frozen=1
					if(Z.Float)
						spawn(Z.Float*10)
							src.Frozen=0
					if(Z.Ice)
						spawn()
							for(var/turf/T in Turf_Circle(src.Target, Z.Ice))
								spawn(rand(4,8))new/turf/Ice1(locate(T.x, T.y, T.z))
								spawn(rand(4,8))Destroy(T)
							spawn(10)
								src.Frozen=0
					if(Z.Thunderstorm)
						spawn()
							for(var/turf/t in Turf_Circle(src.Target, Z.Thunderstorm))
								sleep(-1)
								TurfShift('Night.dmi', t, 6000, src, MOB_LAYER+1)
								spawn(5)
									sleep(-1)
									TurfShift('Rain.dmi', t, 5990, src, MOB_LAYER+0.5)
							spawn(10)
								src.Frozen=0
					if(Z.Gravity)
						spawn()
							var/image/i
							var/turf/adjustedT
							for(var/turf/t in Turf_Circle(src.Target, Z.Gravity))
								if(t.x == Target.x && t.y == Target.y && Z.RagingDemonAnimation)
									adjustedT = t
								sleep(-1)
								TurfShift('Gravity.dmi', adjustedT, 30, src, MOB_LAYER+1)
							spawn(35)
								if(Z.RagingDemonAnimation)
									i = image('ragingDemonEffect.dmi', Target)
									i.color = rgb(138, 0, 0)
									i.pixel_x = -100
									i.pixel_y = -110
									i.layer = 99
									i.alpha = 155
									Target.vis_contents+=i
							spawn(40)
								if(Z.RagingDemonAnimation)
									Target.vis_contents -= i
									i.loc = null
									del i
								src.Frozen=0
				if(src.HasQuickCast())
					if(Z.PreQuake)
						spawn()
							src.Quake(Second(Z.WindUp/src.GetQuickCast()))
					sleep(Second(Z.WindUp/src.GetQuickCast()))
				else
					if(Z.PreQuake)
						spawn()
							src.Quake(Second(Z.WindUp))
					sleep(Second(Z.WindUp))
				src.WindingUp=0

				if(Z.Area=="Target"||Z.Area=="Around Target")
					if(!src.Target)
						missed=1
					if(src.Target==src)
						missed=1
					if(src.Target.z!=src.z)
						missed=1
					if(!Z.Rush)//This one doesn't apply to rushes.
						if(src.x+Z.Distance<src.Target.x||src.x-Z.Distance>src.Target.x||src.y+Z.Distance<src.Target.y||src.y-Z.Distance>src.Target.y)
							missed=1

			if(Z.CustomActive)
				OMsg(src, "[Z.CustomActive]")
			else
				if(Z.ActiveMessage)
					OMsg(src, "<b><font color='[Z.ActiveColor]'>[src] [Z.ActiveMessage]</font color></b>")
			if(!Z.SpecialAttack)
				if(src.UsingSpiritStrike())
					Z.TempStrOff=0
					Z.TempForOff=1
				if(Z.NeedsSword&&src.HasSpiritSword())
					Z.TempStrOff=1*src.GetSpiritSword()
					Z.TempForOff=1*src.GetSpiritSword()
				else if(src.HasHybridStrike())
					if(Z.TempStrOff && !Z.TempForOff)
						Z.TempForOff = GetHybridStrike() // get the value of hybrid strike
					else if(!Z.TempStrOff && Z.TempForOff)
						Z.TempStrOff = GetHybridStrike() // get the value of hybrid strike
					else if(!Z.TempStrOff && !Z.TempForOff)
						Z.TempForOff = 1
						Z.TempStrOff = GetHybridStrike()

				else
					Z.TempStrOff=1
					Z.TempForOff=0
			if(src.AttackQueue && !src.AttackQueue.FollowUp)
				src << "<b>You drop [src.AttackQueue.name] from your queue.</b>"
				src.QueueOverlayRemove()
				src.ClearQueue()
			if(Z.Purity)
				src.Purity+=Z.Purity
			if(Z.Burning)
				src.Burning+=Z.Burning
			if(Z.Scorching)
				src.Scorching+=Z.Scorching
			if(Z.Chilling)
				src.Chilling+=Z.Chilling
			if(Z.Freezing)
				src.Freezing+=Z.Freezing
			if(Z.Crushing)
				src.Crushing+=Z.Crushing
			if(Z.Shattering)
				src.Shattering+=Z.Shattering
			if(Z.Shocking)
				src.Shocking+=Z.Shocking
			if(Z.Paralyzing)
				src.Paralyzing+=Z.Paralyzing
			if(Z.Poisoning)
				src.Poisoning+=Z.Poisoning
			if(Z.Toxic)
				src.Toxic+=Z.Toxic
			if(Z.Attracting)
				src.Attracting+=Z.Attracting
			if(Z.Crippling)
				src.Crippling+=Z.Crippling
			if(Z.HolyMod)
				src.HolyMod+=Z.HolyMod
			if(Z.AbyssMod)
				src.AbyssMod+=Z.AbyssMod
			if(Z.SlayerMod)
				src.SlayerMod+=Z.SlayerMod
			if(Z.MaimStrike)
				src.MaimStrike+=Z.MaimStrike
			if(!Z.Rounds)
				Z.Rounds=1
			if(Z.Rounds<3&&!Z.ChargeTech)
				Z.DelayTime=5
			if(!Z.RoundMovement&&Z.Rounds>1)
				src.Frozen=2

			if(Z.PreShockwave)
				if(Z.Shockwave)
					spawn()
						var/ShockSize=Z.Shockwave
						if(Z.Shockwaves<1)
							Z.Shockwaves=1
						for(var/wav=Z.Shockwaves, wav>0, wav--)
							KenShockwave(src, icon=Z.ShockIcon, Size=ShockSize, Blend=Z.ShockBlend, Time=Z.ShockTime)
							ShockSize/=Z.ShockDiminish
				if(Z.PreShockwaveDelay)
					sleep(Z.PreShockwaveDelay)
			if(Z.Icon)
				var/icon/i=Z.Icon
				if(Z.IconRed||Z.IconGreen||Z.IconBlue)
					i+=rgb(Z.IconRed, Z.IconGreen, Z.IconBlue)
				var/Time
				if(Z.ChargeTime)
					Time=Z.ChargeTime
				else
					Time=Z.DelayTime
				if(Z.Area=="Around Target")
					spawn()
						if(Z.Falling)
							LeaveDescendingImage(User=0, Image=i, PX=src.Target.pixel_x+Z.IconX, PY=src.Target.pixel_y+Z.IconY, PZ=src.Target.pixel_z+16+(32*Z.Rounds/10), Size=Z.Size, Under=Z.IconUnder, Time=(Z.Rounds-1*max(1,Time)), AltLoc=TrgLoc)
						else
							LeaveImage(User=0, Image=i, PX=src.Target.pixel_x+Z.IconX, PY=src.Target.pixel_y+Z.IconY, PZ=src.Target.pixel_z+48, Size=Z.Size, Under=Z.IconUnder, Time=(Z.Rounds-1*max(1,Time)), AltLoc=TrgLoc)
				else
					spawn()LeaveImage(User=src, Image=i, PX=src.pixel_x+Z.IconX, PY=src.pixel_y+Z.IconY, PZ=src.pixel_z+Z.IconZ, Size=Z.Size, Under=Z.IconUnder, Time=(Z.Rounds*max(1,Time)), AltLoc=0)

			if(Z.Jump)
				if(Z.Jump==1)
					spawn()
						Jump(src)
					sleep(3)
				if(Z.Jump==2)
					spawn()
						Jump(src)
					sleep(5)

			var/Delay=0
			var/DelayRelease=0
			if(Z.Rush)
				src.is_dashing++
				src.WindingUp=1
				var/GO=Z.Rush
				src.icon_state="Flight"
				if(Z.RushDelay<1)
					VanishImage(src)
				while(GO>0)
					if(Z.ControlledRush&&src.Target)
						var/travel_angle = GetAngle(src, src.Target)
						if(length(src.filters) < 1)
							AppearanceOn()
							//TODO the error was found here,. i think this fixed it

						animate(src.filters[length(src.filters)], x=sin(travel_angle)*(6/Z.RushDelay), y=cos(travel_angle)*(6/Z.RushDelay), time=Z.RushDelay)
						step_towards(src,src.Target)
						if(get_dist(src,src.Target)==1)
							GO=0
							src.dir=get_dir(src,src.Target)
							if(src.Target.Knockbacked)
								src.Target.Knockbacked=0
								src.Target.Frozen=1
								spawn(3)
									src.Target.Frozen=0
						GO-=1
						DelayRelease+=Z.RushDelay
						if(DelayRelease>=1)
							DelayRelease--
							sleep(1)
					else
						var/travel_angle = dir2angle(src.dir)
						if(length(src.filters) < 1)
							AppearanceOn()
						animate(src.filters[filters.len], x=sin(travel_angle)*(6/Z.RushDelay), y=cos(travel_angle)*(6/Z.RushDelay), time=Z.RushDelay)
						step(src,src.dir)
						if(Z.Area=="Strike"||Z.Area=="Arc"||Z.Area=="Cone")
							for(var/atom/a in get_step(src,dir))
								if(a==src)
									continue
								if(a.density)
									GO=0
						else
							for(var/atom/a in view(1,src))
								if(a==src)
									continue
								if(a.density)
									GO=0
						GO-=1
						DelayRelease+=Z.RushDelay
						if(DelayRelease>=1)
							DelayRelease--
							sleep(1)
				src.is_dashing--
				if(is_dashing<0)
					is_dashing=0
				src.WindingUp=0
				animate(src.filters[filters.len], x=0, y=0)
				src.icon_state=""
			if(Z.FlickAttack==1)
				flick("Attack",src)
			var/RoundCount=Z.Rounds
			if(Z.MagicNeeded&&src.HasDualCast())
				RoundCount*= 1+ src.HasDualCast()
				RoundCount = floor(RoundCount)
			while(RoundCount>0)
				if(Z.Earthshaking)
					spawn()
						src.Quake(Z.Earthshaking)
				if(Z.FlickSpin)
					flick("KB",src)
				else if(Z.FlickAttack==2)
					src.icon_state="Attack"
				else if(Z.FlickAttack==3)
					if(RoundCount % 2)
						src.icon_state="Attack"
					else
						src.icon_state=""
				switch(Z.Area)
					if("Strike")
						src.Strike(Z)
					if("Arc")
						src.Arc(Z)
					if("Cone")
						src.Cone(Z)
					if("Cross")
						src.Cardinal(Z)
					if("Wave")
						src.Wave(Z)
					if("Wide Wave")
						src.WideWave(Z)
					if("Circle")
						src.Circle(Z)
					if("Target")
						src.Target(src.Target, Z, missed ? TrgLoc : null)
						if(missed) src << "[Z] missed because your target is out of range."
					if("Around Target")
						src.AroundTarget(null, Z, TrgLoc)
				if(Z.ChargeTime)
					Delay=Z.ChargeTime
				else
					Delay=Z.DelayTime
				if(Z.PostShockwave)
					if(Z.Shockwave)
						spawn()
							var/ShockSize=Z.Shockwave
							if(Z.Shockwaves<1)
								Z.Shockwaves=1
							for(var/wav=Z.Shockwaves, wav>0, wav--)
								KenShockwave(src, icon=Z.ShockIcon, Size=ShockSize, Blend=Z.ShockBlend, Time=Z.ShockTime)
								ShockSize/=2
				if(Z.ChargeTech)
					src.Frozen=1
					if(Z.ChargeFlight)
						src.icon_state="Flight"
					DelayRelease+=Delay
					if(DelayRelease>=1)
						DelayRelease--
						sleep(1)
					step(src, src.dir)
				else
					sleep(Delay)
				RoundCount--
			src.ClearTech(Z)

		ClearTech(var/obj/Skills/AutoHit/Z)//Used to resolve any variable conflicts at the end of an autohit
			var/CostMultiplier=1
			var/obj/Items/Sword/sord=src.EquippedSword()
			var/obj/Items/Enchantment/Staff/staf=src.EquippedStaff()
			var/obj/Items/Armor/WearingArmor=src.EquippedArmor()
			if(Z.NeedsSword&&sord)
				CostMultiplier/=src.GetSwordDelay(sord)
			if(Z.SpecialAttack&&staf)
				CostMultiplier/=src.GetStaffDrain(staf)
			if(src.UsingBattleMage()&&Z.NeedsSword)
				CostMultiplier/=src.GetStaffDrain(staf)
			if(WearingArmor)
				CostMultiplier/=src.GetArmorDelay(WearingArmor)
			else if(Z.SpecialAttack&&sord&&sord.MagicSword)
				CostMultiplier*=src.GetSwordDelay(sord)
			if(src.Frozen!=3)
				src.Frozen=0
			if(Z.ChargeFlight)
				src.icon_state=""
			if(Z.HitSparkIcon)
				src.HitSparkIcon=null
				src.HitSparkX=null
				src.HitSparkY=null
				src.HitSparkTurns=null
				src.HitSparkSize=null
				src.HitSparkCount=null
				src.HitSparkDispersion=null
				src.HitSparkDelay=null
				src.HitSparkLife=null
			if(Z.HealthCost)
				src.DoDamage(src, Z.HealthCost*CostMultiplier*glob.WorldDamageMult)
			if(Z.WoundCost)
				src.WoundSelf(Z.WoundCost*CostMultiplier*glob.WorldDamageMult)
			if(Z.EnergyCost)
				src.LoseEnergy(Z.EnergyCost*CostMultiplier)
			if(Z.FatigueCost)
				src.GainFatigue(Z.FatigueCost*CostMultiplier)
			if(Z.ManaCost)
				var/drain = src.passive_handler.Get("MasterfulCasting") ? Z.ManaCost - (Z.ManaCost * (passive_handler.Get("MasterfulCasting") * 0.3)) : Z.ManaCost
				if(drain <= 0)
					drain = 0.5
				if(!src.TomeSpell(Z))
					src.LoseMana(drain*CostMultiplier)
				else
					src.LoseMana(drain*CostMultiplier*(1-(0.45*src.TomeSpell(Z))))
			if(Z.CapacityCost)
				src.LoseCapacity(Z.CapacityCost*CostMultiplier)
			if(Z.Quaking)
				src.Quaking=0
			if(Z.NeedsSword&&Z.ExtendMemory)
				Z.Distance-=Z.ExtendMemory//...then take the distance away.
				Z.Size-=Z.ExtendMemory
			Z.TempStrOff=0
			Z.TempForOff=0
			Z.TempEndDef=0
			if(Z.RoundMovement&&Z.Rounds>1)
				src.Frozen=0
			if(Z.Purity)
				src.Purity-=Z.Purity
			if(Z.Burning)
				src.Burning-=Z.Burning
			if(Z.Scorching)
				src.Scorching-=Z.Scorching
			if(Z.Chilling)
				src.Chilling-=Z.Chilling
			if(Z.Freezing)
				src.Freezing-=Z.Freezing
			if(Z.Crushing)
				src.Crushing-=Z.Crushing
			if(Z.Shattering)
				src.Shattering-=Z.Shattering
			if(Z.Shocking)
				src.Shocking-=Z.Shocking
			if(Z.Paralyzing)
				src.Paralyzing-=Z.Paralyzing
			if(Z.Poisoning)
				src.Poisoning-=Z.Poisoning
			if(Z.Toxic)
				src.Toxic-=Z.Toxic
			if(Z.Attracting)
				src.Attracting-=Z.Attracting
			if(Z.Crippling)
				src.Crippling-=Z.Crippling
			if(Z.HolyMod)
				src.HolyMod-=Z.HolyMod
			if(Z.AbyssMod)
				src.AbyssMod-=Z.AbyssMod
			if(Z.SlayerMod)
				src.SlayerMod-=Z.SlayerMod
			if(Z.MaimStrike)
				src.MaimStrike-=Z.MaimStrike
			if(src.HasRipple())
				Z.DamageMult/=Z.RipplePower
				Z.RipplePower=1
			if(Z.OldHitSpark)
				Z.HitSparkIcon=Z.OldHitSpark
				Z.HitSparkX=Z.OldHitSparkX
				Z.HitSparkY=Z.OldHitSparkY
				Z.HitSparkTurns=Z.OldHitSparkTurns
				Z.HitSparkSize=Z.OldHitSparkSize
				Z.OldHitSpark=0
				Z.OldHitSparkX=0
				Z.OldHitSparkY=0
				Z.OldHitSparkTurns=0
				Z.OldHitSparkSize=0
			if(!Z.NoLock)
				src.AutoHitting=0
			if(Z.FlickSpin||Z.FlickAttack)
				src.icon_state=""
			if(Z.GrabTrigger)
				var/path=text2path(Z.GrabTrigger)
				if(!locate(path, src))
					src.AddSkill(new path)
				src.Grab_Update()
				if(src.Grab)
					for(var/obj/Skills/Grapple/g in src.Skills)
						if(g.type == path)
							g.Activate(src)
							break
			if(Z.AssociatedGear)
				if(!Z.AssociatedGear.InfiniteUses)
					if(Z.Integrated)
						Z.AssociatedGear.IntegratedUses--
						if(Z.AssociatedGear.IntegratedUses<=0)
							src << "Your [Z] is out of power!"
							if(src.ManaAmount>=10)
								src << "Your [Z] automatically draws on new power to reload!"
								src.LoseMana(10)
								Z.AssociatedGear.IntegratedUses=Z.AssociatedGear.IntegratedMaxUses
					else
						Z.AssociatedGear.Uses--
						if(Z.AssociatedGear.Uses<=0)
							src << "[Z] is out of power!"



mob
	proc
		AutoHitter(var/arc, var/wav, var/car, var/circ, var/mob/targ, var/obj/Skills/AutoHit/z, var/turf/trfloc=null)
			if(src.dir == SOUTHEAST || src.dir==NORTHEAST)
				src.dir=EAST
			if(src.dir==SOUTHWEST || src.dir==NORTHWEST)
				src.dir=WEST
			new/obj/AutoHitter(owner=src, arcing=arc, wave=wav, card=car, circle=circ, target=targ, Z=z, TrgLoc=trfloc)

		Strike(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(0, 0, 0, 0, null, Z)

		Arc(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(1, 0, 0, 0, null, Z)

		Cone(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(round(Z.Distance/5), 0, 0, 0, null, Z)

		Wave(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(0, 1, 0, 0, null, Z)

		WideWave(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(0, 2, 0, 0, null, Z)

		Cardinal(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(0, 0, 1, 0, null, Z)

		Circle(var/obj/Skills/AutoHit/Z)
			src.AutoHitter(0, 0, 0, 1, null, Z)

		Target(var/mob/trg, var/obj/Skills/AutoHit/Z, var/turf/MissedLoc)
			if(!MissedLoc)
				src.AutoHitter(0, 0, 0, 0, trg, Z)
			else
				src.AutoHitter(0, 0, 0, 0, targ=null, z=Z, trfloc=MissedLoc)

		AroundTarget(var/mob/trg, var/obj/Skills/AutoHit/Z, var/turf/TrgLoc)
			src.AutoHitter(0, 0, 0, 1, null, Z, TrgLoc)
obj
	AutoHitter
		density=1//It has to be dense to properly register contact.
		Destructable=0//Can't be explode
		var
			list/mob/Targets=list()//People who have been touched by the autohit.

			//Distance//Active count of tiles left to move.
			DistanceMax//Maximum amount; kept track of for arc purposes.
			NoPierce//It dies when it hits something

			Arcing//Triggers offshoots on every step that expand outwards.  Higher than 1 means that every X steps the range will widen.
			ArcingCount=0//Number of times arcing has been triggered.  Informs the game how many tiles to send the offshoots.
			Wave//Triggers offshoots that extend this number of steps on every step.
			Cardinal//Triggers offshoots in 4 directions.
			CardinalTriggered//Binary that makes sure crosses don't cross.
			Circle//Affects a circle
			mob/Target//Instantly hits this person
			turf/TargetLoc//Hits around this location

			ObjIcon//get an icon from the other obj
			currentRounds
			Damage//This is the amount of damage a skill will do if all stats and power are equal.
			StepsDamage=1
			StepsTaken=0//A variable for easy recording
			list/DamageSteps=list()//This is a variable that allows damage to scale based on the steps taken by the projectile.  Think Tipper.

			StrDmg//Does it factor in strength?
			ForDmg//Does it factor in force?
			//Mark both for hybrid.
			EndRes//Does endurance make it do less damage?

			Knockback//Number of KB tiles.
			ChargeTech//Is this a charge move?  Does it carry the enemy with it?  This only affects KB, it doesn't trigger any other charging behavior.
			ComboMaster // it dont lose damage against stunned/launched nerds

			UnarmedTech
			SwordTech
			SpecialAttack

			Stunner
			Deluge
			Stasis
			Destructive

			Bang
			Bolt
			BoltOffset
			Scratch
			Punt

			Grapple//IT GRAPPLES
			Launcher//LAUNCHERRR
			DelayedLauncher

			Divide
			TurfReplace
			TurfErupt
			TurfEruptOffset
			TurfDirt
			TurfDirtOffset
			TurfStrike
			TurfShift
			TurfShiftLayer
			TurfShiftDuration
			TurfShiftDurationSpawn
			TurfShiftDurationDespawn
			Flash

			Slow//Autohit doesn't hit instantly

			CanBeBlocked
			CanBeDodged

			PassThrough
			StopAtTarget
			Stopped//Use this to make sure you don't need to keep moving
			PassTo

			Wander//roam for this number of moves.
			WanderSize
			MortalBlow
			WarpAway
			CosmoPowered

			LifeSteal
			EnergySteal
			MagicNeeded
			DelayTime
			ChargeTime
			RagingDemonAnimation = FALSE
			Executor
			SpeedStrike

			Scorching
			Chilling
			Freezing
			Crushing

			grabNerf = 0
			BuffAffected = 0
			buffAffectedType = 0
			buffAffectedCompare = 0
			buffAffectedBoon = 0

		New(var/mob/owner, var/arcing=0, var/wave=0, var/card=0, var/circle=0, var/mob/target, var/obj/Skills/AutoHit/Z, var/turf/TrgLoc)
			set waitfor = FALSE
			if(!owner)
				Targets = null
				Target = null
				loc = null
				return
			src.Owner=owner
			if(owner.Grab && !Z.GrabMaster)
				grabNerf = 1
			src.Arcing=arcing
			src.Wave=wave
			src.Cardinal=card
			src.Circle=circle
			src.DistanceMax=Z.Distance
			if(TrgLoc)
				src.TargetLoc=TrgLoc
				src.DistanceMax=Z.DistanceAround
			src.Target=target
			src.NoPierce=Z.NoPierce

			src.Damage=Z.DamageMult
			src.StepsDamage=Z.StepsDamage
			src.MagicNeeded=Z.MagicNeeded
			if(Z.TempStrOff && !Z.StrOffense)
				src.StrDmg=Z.TempStrOff
			else
				src.StrDmg=Z.StrOffense
			if(Z.TempForOff && !Z.ForOffense)
				src.ForDmg=Z.TempForOff
			else
				src.ForDmg=Z.ForOffense
			if(Z.TempEndDef && !Z.EndDefense)
				src.EndRes=Z.TempEndDef
			else
				src.EndRes=Z.EndDefense
			src.Executor = Z.Executor
			src.RagingDemonAnimation = Z.RagingDemonAnimation
			src.Knockback=Z.Knockback
			src.ChargeTech=Z.ChargeTech
			src.UnarmedTech=Z.UnarmedOnly
			src.SwordTech=Z.NeedsSword
			src.SpecialAttack=Z.SpecialAttack
			src.Deluge=Z.Deluge
			src.Stunner=Z.Stunner
			src.Destructive=Z.Destructive
			src.Bang=Z.Bang
			src.Bolt=Z.Bolt
			src.BoltOffset=Z.BoltOffset
			src.Scratch=Z.Scratch
			src.Punt=Z.Punt
			src.Divide=Z.Divide
			src.TurfErupt=Z.TurfErupt
			src.TurfEruptOffset=Z.TurfEruptOffset
			src.TurfDirt=Z.TurfDirt
			src.TurfDirtOffset=Z.TurfDirtOffset
			src.TurfStrike=Z.TurfStrike
			src.TurfReplace=Z.TurfReplace
			src.TurfShift=Z.TurfShift
			src.TurfShiftLayer=Z.TurfShiftLayer
			src.TurfShiftDuration=Z.TurfShiftDuration
			src.TurfShiftDurationSpawn=Z.TurfShiftDurationSpawn
			src.TurfShiftDurationDespawn=Z.TurfShiftDurationDespawn
			src.Flash=Z.Flash
			src.ComboMaster=Z.ComboMaster
			src.CanBeBlocked=Z.CanBeBlocked
			src.CanBeDodged=Z.CanBeDodged
			src.Slow=Z.Slow
			src.PassThrough=Z.PassThrough//This does not get assigned to other types because it will always follow the primary autohit, not the offshoots.
			src.PassTo=Z.PassTo
			src.StopAtTarget=Z.StopAtTarget
			src.Wander=Z.Wander
			src.SpeedStrike = Z.SpeedStrike
			if(src.Wander)
				src.WanderSize=Z.Size
			src.Stasis=Z.Stasis
			src.MortalBlow=Z.MortalBlow
			src.WarpAway=Z.WarpAway
			if(Z.GodPowered)
				src.Owner.transcend(Z.GodPowered)
			src.CosmoPowered=Z.CosmoPowered
			src.Launcher=Z.Launcher
			src.DelayedLauncher=Z.DelayedLauncher
			src.Grapple=Z.Grapple
			src.LifeSteal=Z.LifeSteal
			src.EnergySteal=Z.EnergySteal
			src.DelayTime=Z.DelayTime
			src.ChargeTime=Z.ChargeTime
			src.BuffAffected=Z.BuffAffected
			src.buffAffectedType  = Z.buffAffectedType
			src.buffAffectedCompare = Z.buffAffectedCompare
			src.buffAffectedBoon = Z.buffAffectedBoon
			if(Z.ObjIcon)
				src.ObjIcon=Z.ObjIcon
				var/icon/i=Z.Icon
				if(Z.IconRed||Z.IconGreen||Z.IconBlue)
					i+=rgb(Z.IconRed, Z.IconGreen, Z.IconBlue)
				src.icon=i

				src.pixel_x=Z.IconX
				src.pixel_y=Z.IconY
				src.transform*=Z.Size


			src.dir=src.Owner.dir
			src.loc=src.Owner.loc
			src.Distance=src.DistanceMax

			src.Life()
			sleep(500)
			endLife()
		Bump(var/mob/m)
			if(istype(m, /mob))
				if(m!=src.Owner&&m.density)
					spawn()
						src.Damage(m)
						if(src.NoPierce)
							endLife()
							return
				src.loc=m.loc


		proc/endLife()
			set waitfor = FALSE
			try
				if(src.PassThrough)
					if(!src.Stopped)
						if(Owner)
							AfterImage(src.Owner)
							if(src.Target)//For targetted autohits...
								if(src.StopAtTarget)//Front
									if(Owner)
										src.Owner.loc=get_step(src.Owner.Target, src.Owner.Target.dir)
										src.Owner.dir=get_dir(src.Owner, src.Owner.Target)//facing them
								else
									if(Owner)
										src.Owner.loc=get_step(src.Owner.Target, turn(src.Owner.Target.dir, 180))//Appear behind the fucker
										src.Owner.dir=turn(get_dir(src.Owner, src.Owner.Target), 180)//facing away
							else
								if(Owner)
									src.Owner.loc=src.loc
			catch()
			walk(src,0)
			animate(src)
			Owner = null
			Targets = null
			loc = null
			sleep(10)
			del src
		proc
			Damage(var/mob/m)
				if(m && Owner && m in Owner.ai_followers)
					return
				if(istype(Owner, /mob/Player/AI) && m != Owner)
					var/mob/Player/AI/a = Owner
					if(!a.ai_team_fire && a.AllianceCheck(m))
						return
				if(src.StopAtTarget)
					AfterImage(src.Owner)
					src.Owner.loc=get_step(m, get_dir(m, src.Owner))
					src.Stopped=1
				if(src.PassTo)
					AfterImageA(src.Owner, forceloc=get_step(m, get_dir(m, src.Owner)))
				if(src.MagicNeeded)
					if(m.passive_handler.Get("CounterSpell"))
						OMsg(m, "[m]'s counterspell negates the spells damage!")
						return
				grabNerf = Owner.Grab ? 1 : 0
				var/FinalDmg
				var/powerDif = Owner.Power/m.Power
				if(glob.CLAMP_POWER)
					if(!Owner.ignoresPowerClamp())
						powerDif = clamp(powerDif, glob.MIN_POWER_DIFF, glob.MAX_POWER_DIFF)
				Owner.log2text("powerDif - Auto Hit", powerDif, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				var/atk = 0
				if(ForDmg && !StrDmg)
					atk = Owner.GetFor(ForDmg)
				else if(StrDmg && !ForDmg)
					atk = Owner.getStatDmg2() * StrDmg
				else if(StrDmg && ForDmg)
					atk = Owner.GetStr(StrDmg) *  1 + (Owner.GetFor(ForDmg)/10)
				else
					Owner << "Your auto hit could not calculate the damage it just did!! Report this !!"
				Owner.log2text("atk - Auto Hit", atk, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				var/dmgRoll = Owner.GetDamageMod()
				Owner.log2text("dmg roll - Auto Hit", dmgRoll, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				if(m.passive_handler.Get("GiantForm") || m.HasLegendaryPower() >= 1)
					var/mod = upper_damage_roll / 4
					dmgRoll = Owner.GetDamageMod(0, mod)
					Owner.log2text("dmg roll - Auto Hit", "After GiantForm", "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
					Owner.log2text("dmg roll - Auto Hit", dmgRoll, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				var/def = m.getEndStat(glob.END_EFFECTIVENESS) * EndRes
				if(def<0)
					def=0.1
				if(m.HasPridefulRage())
					if(m.Race == "Saiyan")
						if(Owner.passive_handler.Get("PridefulRage") >= 2)
							def = 1
						else
							def = clamp(def/2, 1, def)

				if(Owner.HasPridefulRage())
					if(Owner.passive_handler.Get("PridefulRage") >= 2)
						def = 1
					else
						def = clamp(def/2, 1, def)
				Owner.log2text("def - Auto Hit", def, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				var/dmgMulti = Damage
				if(src.SpecialAttack&&(src.Owner.UsingMoonlight()||src.Owner.HasSpiritFlow()))
					if(src.Owner.StyleActive!="Moonlight"&&src.Owner.StyleActive!="Astral")
						dmgMulti += Owner.GetStr(0.25) / 5
					else
						dmgMulti += Owner.GetStr(0.5) / 5
				// powerDif += Owner.getIntimDMGReduction(m)
				Owner.log2text("powerDif - Auto Hit", powerDif, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				if(glob.DMG_CALC_2)
					FinalDmg = (clamp(powerDif,0.1,100000)**glob.DMG_POWER_EXPONENT) * (glob.CONSTANT_DAMAGE_EXPONENT+glob.AUTOHIT_EFFECTIVNESS) ** -(def**glob.DMG_END_EXPONENT / atk**glob.DMG_STR_EXPONENT)
				else
					FinalDmg = (atk * powerDif) * glob.CONSTANT_DAMAGE_EXPONENT ** -(def/atk)
				Owner.log2text("FinalDmg(before dmgRoll) - Auto Hit", FinalDmg, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				FinalDmg *= dmgMulti
				FinalDmg *= dmgRoll
				Owner.log2text("FinalDmg - Auto Hit", FinalDmg, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				var/Precision=src.Damage
				var/itemMods = list(0,0,0)
				if(src.SwordTech&&!src.SpecialAttack)
					var/obj/Items/Sword/s=src.Owner.EquippedSword()
					var/obj/Items/Enchantment/st=src.Owner.EquippedStaff()
					itemMods = Owner.getItemDamage(list(s,FALSE,FALSE,st), 0, Precision, FALSE, FALSE, TRUE, FALSE )
				if(SpecialAttack)
					var/obj/Items/Sword/s=src.Owner.EquippedSword()
					var/obj/Items/Enchantment/st=src.Owner.EquippedStaff()
					itemMods = Owner.getItemDamage(list(s,FALSE,FALSE,st), 0, Precision, FALSE, FALSE, TRUE, TRUE)
				if(itemMods[3])
					Owner.log2text("Item Damage - Auto Hit", itemMods[3], "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
					FinalDmg *= itemMods[3]
					Owner.log2text("FinalDmg - Auto Hit", "After Item Damage", "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
					Owner.log2text("FinalDmg - Auto Hit", FinalDmg, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				if(itemMods[2])
					Precision *= itemMods[2]

				if(src.SpeedStrike>0)
					FinalDmg *= clamp(1,sqrt(1+((Owner.GetSpd())*(src.SpeedStrike/10))),3)
				if(Owner.UsingFencing())
					FinalDmg *= clamp(1,sqrt(1+((Owner.GetSpd())*(Owner.UsingFencing()/15))),3)
				if(!ComboMaster && (m.Launched||m.Stunned))
					FinalDmg *= glob.CCDamageModifier
					Owner.log2text("FinalDmg - Auto Hit", "After ComboMaster", "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
					Owner.log2text("FinalDmg - Auto Hit", FinalDmg, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				var/obj/Items/Armor/HittingArmor=m.EquippedArmor()
				var/obj/Items/Armor/WearingArmor=src.Owner.EquippedArmor()
				if(HittingArmor)//Reduced damage
					var/dmgEffective = m.GetArmorDamage(HittingArmor)
					FinalDmg -= FinalDmg * dmgEffective/10
					Owner.log2text("FinalDmg - Auto Hit", "After HittingArmor", "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
					Owner.log2text("FinalDmg - Auto Hit", FinalDmg, "damageDebugs.txt", "[Owner.ckey]/[Owner.name]")
				if(WearingArmor)//Reduced delay and accuracy
					Precision*=src.Owner.GetArmorAccuracy(WearingArmor)
				var/reversalChance = m.GetAutoReversal()
				if(prob(reversalChance * 100))
					if(m.HasAutoReversal()&&!src.SpecialAttack)
						if(Accuracy_Formula(src.Owner, m, AccMult=Precision, BaseChance=glob.WorldWhiffRate, IgnoreNoDodge=1) == (HIT || WHIFF))
							if(src.Damage>0.1)
								KenShockwave(m, icon='KenShockwave.dmi', Size=dmgRoll, Time=3)
								m.Knockback(src.Knockback+(reversalChance*2.5) , src.Owner, Direction=get_dir(m, src.Owner))
							m.DoDamage(src.Owner, (FinalDmg/5), UnarmedAttack=src.UnarmedTech, SwordAttack=src.SwordTech, SpiritAttack=src.SpecialAttack)
							if(src.Bang)
								Bang(src.Owner.loc, src.Bang)
							if(src.Scratch)
								Scratch(src.Owner)
							if(src.Bolt)
								LightningBolt(src.Owner, src.Bolt, src.BoltOffset)
							if(src.Punt)
								Hit_Effect(src.Owner, Size=src.Punt)
							src.Owner.HitEffect(src.Owner, src.UnarmedTech, src.SwordTech)
							return

				if(src.CanBeBlocked)
					if(Accuracy_Formula(src.Owner, m, AccMult=Precision, BaseChance=glob.WorldWhiffRate, IgnoreNoDodge=1) == WHIFF)
						if(!src.Owner.NoWhiff)
							var/obj/Items/Sword/s = Owner.EquippedSword()
							if(s)
								FinalDmg/=max(1,(2*(1/Owner.GetSwordAccuracy(s))))
							else
								FinalDmg/=2

				if(m in src.Owner.party)
					FinalDmg *= PARTY_DAMAGE_NERF

				if(!src.CanBeBlocked&&!src.CanBeDodged)
					FinalDmg *= AUTOHIT_GLOBAL_DAMAGE
					//TODO adjustments for auto hit damage
				else
					FinalDmg*=1.5

				if(m.passive_handler.Get("Siphon")&&src.ForDmg)
					var/Heal = (FinalDmg * (m.passive_handler.Get("Siphon")/ 5)) * ForDmg
					FinalDmg-=Heal //negated
					m.HealEnergy(Heal)

				if(m.HasDeflection()&&!src.CanBeDodged)
					if(m.CheckSlotless("Deflector Shield"))
						if(!m.Shielding)
							m.Shielding=1
							spawn()
								m.ForceField()
					FinalDmg*=max(1-(0.125*m.GetDeflection()),0.3)

				if(m.HasBlastShielding()&&!src.CanBeDodged)
					FinalDmg/=2**3
				if(Owner.Scorching||Owner.Chilling||Owner.Freezing||Owner.Crushing||Owner.Shattering||Owner.Shocking||Owner.Paralyzing||Owner.Poisoning||Owner.Toxic)
					// Owner.addElementalPassives(src)
					Owner.handleElementPassives(m)
					// Owner.removeElementalPassives(src)
				// if(src.CosmoPowered)
				// 	if(!src.Owner.SpecialBuff)
				// 		FinalDmg*=TrueDamage(1+(src.Owner.SenseUnlocked-5))
				if(src.Executor)
					var/additonal = src.Executor * 0.1
					if(m.Health<=5)
						additonal *= 2
					if(m.Health <=25)
						Damage *= 1 + additonal

				if(grabNerf)
					FinalDmg *= AUTOHIT_GRAB_NERF
//TODO: Remove a whole lot of those
				if(src.Bang)
					Bang(m.loc, src.Bang)
				if(src.Scratch)
					Scratch(m)
				if(src.Bolt)
					LightningBolt(m, src.Bolt, src.BoltOffset)
				if(src.Punt)
					Hit_Effect(m, Size=src.Punt)

				if(src.LifeSteal)
					src.Owner.LifeSteal+=src.LifeSteal
				if(src.EnergySteal)
					src.Owner.EnergySteal+=src.EnergySteal

				if(src.CanBeDodged)
					var/loc=m.loc
					if(m.AttackQueue&&(m.AttackQueue.Counter||m.AttackQueue.CounterTemp))
						m.dir=get_dir(m, src.Owner)
						if(m.UsingAnsatsuken())
							m.HealMana(m.SagaLevel*5)
						if(m.CanAttack())
							m.Melee1(Damage,2,0,0,null,null,0,0,2,1)
					if(m.HasFlow())
						if(prob(getFlowCalc(6, m.GetFlow(), src.Owner.HasInstinct() )))
							if(!src.TurfStrike)
								spawn()
									src.Owner.HitEffect(loc, src.UnarmedTech, src.SwordTech)
							StunClear(m)
							AfterImageStrike(m, src.Owner,0)
							return

					if(m.AfterImageStrike)
						if(!src.TurfStrike)
							spawn()
								src.Owner.HitEffect(loc, src.UnarmedTech, src.SwordTech)
						StunClear(m)
						AfterImageStrike(m, src.Owner,1)
						m.AfterImageStrike-=1
						if(m.AfterImageStrike<0)
							m.AfterImageStrike=0
							for(var/obj/Skills/Zanzoken/z in src)
								z.Cooldown()//freeze that after image shieet
						return
					else
						if(src.MortalBlow)
							if(src.MortalBlow<0)
								m.MortallyWounded+=4
							else
								if(prob(20*src.MortalBlow) && !m.MortallyWounded)
									var/MortalDamage = m.Health * 0.15
									m.LoseHealth(MortalDamage)
									m.WoundSelf(MortalDamage)
									m.MortallyWounded+=1
									src.Owner << "<b><font color=#ff0000>You mortally wound [m]!</font></b>"
								if(src.MortalBlow>1)
									if(m.Immortal)
										m.Immortal=0
						src.Owner.DoDamage(m, FinalDmg, src.UnarmedTech, src.SwordTech, Destructive=src.Destructive)
						if(src.Owner.UsingAnsatsuken())
							src.Owner.HealMana(src.Owner.SagaLevel)
				else
					if(src.MortalBlow)
						if(src.MortalBlow<0)
							m.MortallyWounded+=4
						else
							if(prob(20*src.MortalBlow) && !m.MortallyWounded)
								var/MortalDamage = m.Health * 0.15
								m.LoseHealth(MortalDamage)
								m.WoundSelf(MortalDamage)
								src.Owner << "<b><font color=#ff0000>You mortally wound [m]!</font></b>"
							if(src.MortalBlow>1)
								if(m.Immortal)
									m.Immortal=0
					src.Owner.DoDamage(m, FinalDmg, src.UnarmedTech, src.SwordTech, Destructive=src.Destructive)

					if(src.Owner.UsingAnsatsuken())
						src.Owner.HealMana(src.Owner.SagaLevel)

				if(src.LifeSteal)
					src.Owner.LifeSteal-=src.LifeSteal

				if(src.EnergySteal)
					src.Owner.EnergySteal-=src.EnergySteal

				if(src.Owner.HitSparkIcon!='BLANK.dmi')
					if(src.Launcher&&src.DelayedLauncher)

						src.Owner.Frozen=3
						var/Time=src.Launcher
						var/Delay=src.Owner.HitSparkCount*src.Owner.HitSparkDelay
						spawn()
							LaunchEffect(src.Owner, m, Time, Delay)
					if(!src.TurfStrike)
						spawn()
							if(Owner)
								src.Owner.HitEffect(m, src.UnarmedTech, src.SwordTech)

				if(src.Grapple)
					if(!src.Owner.Grab)
						src.Owner.Grab_Mob(m, Forced=1)

				if(src.Knockback)
					if(src.ChargeTech)
						if(m!=src.Owner.Grab)
							var delay
							if(ChargeTime || DelayTime) delay = ChargeTime ? (src.ChargeTime*world.tick_lag) : DelayTime
							src.Owner.Knockback(src.Knockback, m, Direction=src.Owner.dir, Forced=1, override_speed=delay)
					else
						if(src.UnarmedTech)
							KenShockwave(m, Size=min((src.Knockback+src.Owner.Intimidation/50)*max(2*src.Owner.GetGodKi(),1)*GoCrand(0.04,0.4),0.2),PixelX=pick(-12,-8,8,12),PixelY=pick(-12,-8,8,12))
						if(m!=src.Owner.Grab)
							src.Owner.Knockback(src.Knockback, m, Direction=get_dir(src.Owner, m))

				if(src.Stunner)
					Stun(m, src.Stunner+src.Owner.GetStunningStrike())
					if(src.Stunner>5)
						m << "Your mind is under attack!"
						if(m.client)
							animate(m.client, color = list(-1,-1,-1, -1,-1,-1, -1,-1,-1, 1,1,1), time = 5)
							m.TsukiyomiTime=6
				if(src.Flash)
					m.Blind(src.Flash*10)
					m.RemoveTarget()
					m.Grab_Release()

				if(src.Stasis)
					m.SetStasis(src.Stasis)

				if(src.Launcher&&!src.DelayedLauncher)
					var/Time=src.Launcher
					spawn()
						LaunchEffect(src.Owner, m, Time)

				if(src.WarpAway)
					WarpEffect(m, src.WarpAway)


				if(BuffAffected)

					var/path
					var/obj/Skills/Buffs/S
					var/AlreadyBuffed
					if(islist(BuffAffected))
						var/compare = buffAffectedCompare
						var/type = buffAffectedType
						if(compare)
							var/result = Owner.compareVariable(m, type, buffAffectedBoon)
							path = text2path(BuffAffected[result])
						else
							path = text2path(pick(BuffAffected))
					else
						path = text2path(BuffAffected)
					S = new path
					if(m.SlotlessBuffs[S.BuffName])
						AlreadyBuffed = 1
					if(!AlreadyBuffed)
						var/buffFound=0
						for(var/obj/Skills/theBuff in m)
							if(theBuff.type == S.type)
								buffFound = 1
								var/list/nonoVars = list("client", "key", "loc", "x", "y", "z", "type", "locs", "parent_type", "verbs", "vars", "contents", "Transform", "appearance")
								for(var/x in theBuff.vars - nonoVars)
									if(x in nonoVars)
										continue // not possible?
									S.vars[x] = theBuff.vars[x]
								break
						if(!buffFound)
							m.AddSkill(S)
						S.Password = m.name





			Life()
				if(src.loc == null) return
				if(src.Circle)
					if(src.TargetLoc)
						if(src.Slow&&src.Distance>1)
							src.Owner.Frozen=1
							var/list/AlreadyHit=list()
							for(var/Rounds=1, Rounds<=src.DistanceMax, Rounds++)
								if(src.StepsDamage&&Rounds>1)
									src.Damage+=src.StepsDamage//add growing damage
								if(src.DistanceMax>=3)//Greater than 3 distance, use circle
									for(var/turf/t in Turf_Circle(src.TargetLoc, Rounds))
										if(src.Divide)
											Destroy(t, 9001)
										if(src.TurfReplace)
											var/image/i=image(icon=src.TurfReplace)
											t.overlays+=i
											if(src.Deluge)
												t.Deluged=1
											spawn(3000)
												t.overlays-=i
												if(t.Deluged)
													t.Deluged=0
										if(src.TurfShift)
											sleep(-1)
											TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
										for(var/mob/m in t.contents)
											if(m==src.Owner)
												continue
											if(m in AlreadyHit)
												continue
											else
												src.Damage(m)
												AlreadyHit.Add(m)
									for(var/turf/t in Turf_Circle_Edge(src.TargetLoc, Rounds))
										if(src.TurfErupt)
											Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
										if(src.TurfDirt)
											Dust(t)
										if(src.TurfStrike)
											spawn()
												for(var/s=src.TurfStrike, s>0, s--)
													if(Owner)
														src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
														sleep(1)
								else//Less than 3 distance, use square.
									if(src.TurfErupt)
										for(var/turf/t in view(Rounds, src.TargetLoc))
											if(t in view(Rounds, src.TargetLoc))
												continue
											Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
									if(src.TurfDirt)
										for(var/turf/t in view(Rounds, src.TargetLoc))
											if(t in view(Rounds, src.TargetLoc))
												continue
											Dust(t)
									if(src.TurfStrike)
										for(var/turf/t in view(Rounds, src.TargetLoc))
											if(t in view(Rounds, src.TargetLoc))
												continue
											spawn()
												for(var/s=src.TurfStrike, s>0, s--)
													if(Owner)
														src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
														sleep(1)
									if(src.Divide)
										for(var/turf/t in view(Rounds, src.TargetLoc))
											if(t in view(Rounds, src.TargetLoc))//Don't doublehit people
												continue
											Destroy(t, 9001)
									if(src.TurfReplace)
										for(var/turf/t in view(Rounds, src.TargetLoc))
											if(t in view(Rounds, src.TargetLoc))
												continue
											var/image/i=image(icon=src.TurfReplace)
											t.overlays+=i
											if(src.Deluge)
												t.Deluged=1
											spawn(3000)
												t.overlays-=i
												t.Deluged=0
									if(src.TurfShift)
										for(var/turf/t in view(Rounds, src.TargetLoc))
											if(t in view(Rounds, src.TargetLoc))
												continue
											sleep(-1)
											TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
									for(var/mob/m in view(Rounds, src.TargetLoc))
										if(m in view(Rounds-1, src.TargetLoc))//Don't doublehit people
											continue
										if(m==src.Owner)
											continue
										src.Damage(m)
								sleep(src.Slow*world.tick_lag)
							src.Owner.Frozen=0
						else
							if(src.DistanceMax>=3)//If greater than 3 distance...
								if(src.TurfErupt)
									for(var/turf/t in Turf_Circle_Edge(src.TargetLoc, src.Distance))
										sleep(-1)
										Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
								if(src.TurfDirt)
									for(var/turf/t in Turf_Circle_Edge(src.TargetLoc, src.Distance))
										sleep(-1)
										Dust(t)
								if(src.TurfStrike)
									for(var/turf/t in Turf_Circle_Edge(src.TargetLoc, src.Distance))
										sleep(-1)
										spawn()
											for(var/s=src.TurfStrike, s>0, s--)
												if(Owner)
													src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
													sleep(1)
								if(src.Divide)
									for(var/turf/t in Turf_Circle(src.TargetLoc, src.Distance))
										sleep(-1)
										Destroy(t, 9001)
								if(src.TurfReplace)
									for(var/turf/t in Turf_Circle(src.TargetLoc, src.Distance))
										sleep(-1)
										var/image/i=image(icon=src.TurfReplace)
										t.overlays+=i
										if(src.Deluge)
											t.Deluged=1
										spawn(3000)
											t.overlays-=i
											t.Deluged=0
								if(src.TurfShift)
									for(var/turf/t in Turf_Circle(src.TargetLoc, src.Distance))
										sleep(-1)
										TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
								for(var/turf/t in Turf_Circle(src.TargetLoc, src.Distance))
									sleep(-1)
									for(var/mob/m in t)
										if(src.Owner!=m)
											src.Damage(m)
							else//If less than 3 distance...
								if(src.TurfErupt)
									for(var/turf/t in view(src.Distance, src.TargetLoc))
										Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
								if(src.TurfDirt)
									for(var/turf/t in view(src.Distance, src.TargetLoc))
										Dust(t)
								if(src.TurfStrike)
									for(var/turf/t in view(src.Distance, src.TargetLoc))
										spawn()
											for(var/s=src.TurfStrike, s>0, s--)
												if(Owner)
													src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
													sleep(1)
								if(src.Divide)
									for(var/turf/t in view(src.Distance, src.TargetLoc))
										Destroy(t, 9001)
								if(src.TurfReplace)
									for(var/turf/t in view(src.Distance, src.TargetLoc))
										var/image/i=image(icon=src.TurfReplace)
										t.overlays+=i
										if(src.Deluge)
											t.Deluged=1
										spawn(3000)
											t.overlays-=i
											t.Deluged=0
								if(src.TurfShift)
									for(var/turf/t in view(src.Distance, src.TargetLoc))
										sleep(-1)
										TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
								for(var/mob/m in view(src.Distance, src.TargetLoc))
									if(src.Owner!=m)
										src.Damage(m)
						goto Kill
					else
						if(src.Slow&&src.Distance>1)
							src.Owner.Frozen=1
							var/list/AlreadyHit=list()
							for(var/Rounds=1, Rounds<=src.DistanceMax, Rounds++)
								currentRounds = Rounds
								if(src.StepsDamage&&Rounds>1)
									src.Damage+=src.StepsDamage//add growing damage
								if(src.DistanceMax>=3)//Greater than 3 distance, use circle
									for(var/turf/t in Turf_Circle(src.Owner, Rounds))
										if(src.Divide)
											Destroy(t, 9001)
										if(src.TurfReplace)
											var/image/i=image(icon=src.TurfReplace)
											t.overlays+=i
											if(src.Deluge)
												t.Deluged=1
											spawn(3000)
												t.overlays-=i
												if(t.Deluged)
													t.Deluged=0
										if(src.TurfShift)
											sleep(-1)
											TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
										for(var/mob/m in t.contents)
											if(m==src.Owner)
												continue
											if(m in AlreadyHit)
												continue
											else
												src.Damage(m)
												AlreadyHit.Add(m)
									for(var/turf/t in Turf_Circle_Edge(src.Owner, Rounds))
										if(src.TurfErupt)
											Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
										if(src.TurfDirt)
											Dust(t)
										if(src.TurfStrike)
											spawn()
												for(var/s=src.TurfStrike, s>0, s--)
													if(Owner)
														src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
														sleep(1)
								else//Less than 3 distance, use square.
									if(src.TurfErupt)
										for(var/turf/t in view(Rounds, src.Owner))
											if(t in view(Rounds, src.Owner))
												continue
											Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
									if(src.TurfDirt)
										for(var/turf/t in view(Rounds, src.Owner))
											if(t in view(Rounds, src.Owner))
												continue
											Dust(t)
									if(src.TurfStrike)
										for(var/turf/t in view(Rounds, src.Owner))
											if(t in view(Rounds, src.Owner))
												continue
											spawn()
												for(var/s=src.TurfStrike, s>0, s--)
													if(Owner)
														src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
														sleep(1)
									if(src.Divide)
										for(var/turf/t in view(Rounds, src.Owner))
											if(t in view(Rounds, src.Owner))//Don't doublehit people
												continue
											Destroy(t, 9001)
									if(src.TurfReplace)
										for(var/turf/t in view(Rounds, src.Owner))
											if(t in view(Rounds, src.Owner))
												continue
											var/image/i=image(icon=src.TurfReplace)
											t.overlays+=i
											if(src.Deluge)
												t.Deluged=1
											spawn(3000)
												t.overlays-=i
												t.Deluged=0
									if(src.TurfShift)
										for(var/turf/t in view(Rounds, src.Owner))
											if(t in view(Rounds, src.Owner))
												continue
											sleep(-1)
											TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
									for(var/mob/m in view(Rounds, src.Owner))
										if(m in view(Rounds-1, src.Owner))//Don't doublehit people
											continue
										if(m==src.Owner)
											continue
										src.Damage(m)
								sleep(src.Slow*world.tick_lag)
							src.Owner.Frozen=0
						else
							if(src.DistanceMax>=3)//If greater than 3 distance...
								if(src.TurfErupt)
									for(var/turf/t in Turf_Circle_Edge(src.Owner, src.Distance))
										sleep(-1)
										Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
								if(src.TurfDirt)
									for(var/turf/t in Turf_Circle_Edge(src.Owner, src.Distance))
										sleep(-1)
										Dust(t)
								if(src.TurfStrike)
									for(var/turf/t in Turf_Circle_Edge(src.Owner, src.Distance))
										sleep(-1)
										spawn()
											for(var/s=src.TurfStrike, s>0, s--)
												if(Owner)
													src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
													sleep(1)
								if(src.Divide)
									for(var/turf/t in Turf_Circle(src.Owner, src.Distance))
										sleep(-1)
										Destroy(t, 9001)
								if(src.TurfReplace)
									for(var/turf/t in Turf_Circle(src.Owner, src.Distance))
										sleep(-1)
										var/image/i=image(icon=src.TurfReplace)
										t.overlays+=i
										if(src.Deluge)
											t.Deluged=1
										spawn(3000)
											t.overlays-=i
											t.Deluged=0
								if(src.TurfShift)
									for(var/turf/t in Turf_Circle(src.Owner, src.Distance))
										sleep(-1)
										TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
								for(var/turf/t in Turf_Circle(src.Owner, src.Distance))
									sleep(-1)
									for(var/mob/m in t)
										if(src.Owner!=m)
											src.Damage(m)
							else//If less than 3 distance...
								if(src.TurfErupt)
									for(var/turf/t in view(src.Distance, src.Owner))
										Bang(t, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
								if(src.TurfDirt)
									for(var/turf/t in view(src.Distance, src.Owner))
										Dust(t)
								if(src.TurfStrike)
									for(var/turf/t in view(src.Distance, src.Owner))
										spawn()
											for(var/s=src.TurfStrike, s>0, s--)
												if(Owner)
													src.Owner.HitEffect(t, src.UnarmedTech, src.SwordTech)
													sleep(1)
								if(src.Divide)
									for(var/turf/t in view(src.Distance, src.Owner))
										Destroy(t, 9001)
								if(src.TurfReplace)
									for(var/turf/t in view(src.Distance, src.Owner))
										var/image/i=image(icon=src.TurfReplace)
										t.overlays+=i
										if(src.Deluge)
											t.Deluged=1
										spawn(3000)
											t.overlays-=i
											t.Deluged=0
								if(src.TurfShift)
									for(var/turf/t in view(src.Distance, src.Owner))
										sleep(-1)
										TurfShift(src.TurfShift, t, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)
								for(var/mob/m in view(src.Distance, src.Owner))
									if(src.Owner!=m)
										src.Damage(m)
						goto Kill
				if(src.Target)
					if(src.Slow)
						src.Owner.Frozen=1
						sleep(src.Slow*world.tick_lag)
						src.Damage(src.Owner.Target)
						src.Owner.Frozen=0
					else
						src.Damage(src.Target)
					goto Kill
				while(src.Distance>0)
					if(src.Cardinal)
						if(!src.CardinalTriggered)
							new/obj/AutoHitter/CrossOffshoot(src, 1)//Left
							new/obj/AutoHitter/CrossOffshoot(src, 2)//Back
							new/obj/AutoHitter/CrossOffshoot(src, 0)//Right
							src.CardinalTriggered=1
					step(src, src.dir)
					if(src.StepsDamage&&src.StepsTaken>=1)
						src.Damage+=src.StepsDamage//add growing damage
					src.Distance--
					src.StepsTaken++
					if(src.TurfErupt)
						Bang(src.loc, Size=src.TurfErupt, Offset=src.TurfEruptOffset, Vanish=4)
					if(src.TurfDirt)
						Dust(src.loc)
					if(src.TurfStrike)
						spawn()
							for(var/s=src.TurfStrike, s>0, s--)
								if(!src.Owner)
									break
								src.Owner.HitEffect(src.loc, src.UnarmedTech, src.SwordTech)
								sleep(1)
							if(!Owner)
								break
					if(src.Divide)
						Destroy(src.loc, 9001)
					if(src.TurfReplace)
						var/image/i=image(icon=src.TurfReplace)
						var/turf/t=src.loc
						t.overlays+=i
						spawn(6000)
							t.overlays-=i
					if(src.TurfShift)
						sleep(-1)
						TurfShift(src.TurfShift, src.loc, src.TurfShiftDuration, src.Owner, layer=src.TurfShiftLayer, Spawn=src.TurfShiftDurationSpawn, Despawn=src.TurfShiftDurationDespawn)

					if(src.Arcing)
						var/Arc=0
						if(src.Arcing>1)
							if(src.Distance%src.Arcing==0)
								Arc=1
						else
							Arc=1
						if(Arc==1)
							src.ArcingCount++
						if(src.ArcingCount>0)
							new/obj/AutoHitter/ArcOffshoot(src, 1)//Left
							new/obj/AutoHitter/ArcOffshoot(src, 0)//Right
						if(src.Distance==src.DistanceMax-1)//first step of arcs
							new/obj/AutoHitter/ArcOffshoot(src, 1, FromMob=1)//hit them sides boi
							new/obj/AutoHitter/ArcOffshoot(src, 0, FromMob=1)
					if(src.Wave)
						new/obj/AutoHitter/WaveOffshoot(src, 1)
						new/obj/AutoHitter/WaveOffshoot(src, 0)
					sleep(src.Slow*world.tick_lag)
				if(RagingDemonAnimation)
					world.log<<"we get here"
				Kill//Label
				spawn()
					if(src.Wander)
						walk_rand(src, 5)
						animate(src, transform=matrix()*src.WanderSize, time=src.Wander*5)
						sleep(src.Wander*5)
					endLife()
		ArcOffshoot
			Arcing=0
			var
				Side//1 for left, 0 for right
			New(var/obj/AutoHitter/AH, var/side, var/FromMob=0)
				src.Owner=AH.Owner
				src.Side=side
				if(src.Side)
					if(src.Owner.dir!=NORTHEAST&&src.Owner.dir!=NORTHWEST&&src.Owner.dir!=SOUTHEAST&&src.Owner.dir!=SOUTHWEST)
						src.dir=turn(AH.dir, -90)
					else
						src.dir=turn(AH.dir, -45)
				else
					if(src.Owner.dir!=NORTHEAST&&src.Owner.dir!=NORTHWEST&&src.Owner.dir!=SOUTHEAST&&src.Owner.dir!=SOUTHWEST)
						src.dir=turn(AH.dir, 90)
					else
						src.dir=turn(AH.dir, 45)

				src.DistanceMax=AH.ArcingCount
				src.Distance=src.DistanceMax

				src.Damage=AH.Damage
				src.StrDmg=AH.StrDmg
				src.ForDmg=AH.ForDmg
				src.EndRes=AH.EndRes
				src.Knockback=AH.Knockback
				src.ChargeTech=AH.ChargeTech
				src.UnarmedTech=AH.UnarmedTech
				src.SwordTech=AH.SwordTech
//				src.Electrifying=AH.Electrifying
				src.Deluge=AH.Deluge
				src.Stunner=AH.Stunner
				src.Destructive=AH.Destructive
				src.Bang=AH.Bang
				src.Bolt=AH.Bolt
				src.Scratch=AH.Scratch
				src.Divide=AH.Divide
				src.TurfReplace=AH.TurfReplace
				src.TurfShift=AH.TurfShift
				src.TurfShiftLayer=AH.TurfShiftLayer
				src.TurfShiftDuration=AH.TurfShiftDuration
				src.TurfShiftDurationSpawn=AH.TurfShiftDurationSpawn
				src.TurfShiftDurationDespawn=AH.TurfShiftDurationDespawn
				src.TurfErupt=AH.TurfErupt
				src.TurfEruptOffset=AH.TurfEruptOffset
				src.TurfDirt=AH.TurfDirt
				src.TurfDirtOffset=AH.TurfDirtOffset
				src.TurfStrike=AH.TurfStrike
				src.CanBeBlocked=AH.CanBeBlocked
				src.CanBeDodged=AH.CanBeDodged
				src.Wander=AH.Wander
				src.WanderSize=AH.WanderSize
				src.Stasis=AH.Stasis
				src.MortalBlow=AH.MortalBlow
				src.WarpAway=AH.WarpAway
				src.Launcher=AH.Launcher
				src.DelayedLauncher=AH.DelayedLauncher

				if(AH.ObjIcon)
					src.ObjIcon=AH.ObjIcon
					src.icon=AH.icon
					src.pixel_x=AH.pixel_x
					src.pixel_y=AH.pixel_y

				src.loc=AH.loc
				if(FromMob)//only called on first step of arc
					src.loc=src.Owner.loc

				src.Life()
		WaveOffshoot
			Arcing=0
			var
				Side//1 for left, 0 for right
			New(var/obj/AutoHitter/AH, var/side)
				src.Owner=AH.Owner
				src.Side=side
				if(src.Side)
					src.dir=turn(AH.dir, -90)
				else
					src.dir=turn(AH.dir, 90)
				src.DistanceMax=AH.Wave
				src.Distance=src.DistanceMax

				src.Damage=AH.Damage
				src.StrDmg=AH.StrDmg
				src.ForDmg=AH.ForDmg
				src.EndRes=AH.EndRes
				src.Knockback=AH.Knockback
				src.ChargeTech=AH.ChargeTech
				src.UnarmedTech=AH.UnarmedTech
				src.SwordTech=AH.SwordTech
				src.Deluge=AH.Deluge
				src.Stunner=AH.Stunner
				src.Destructive=AH.Destructive
				src.Bang=AH.Bang
				src.Bolt=AH.Bolt
				src.Scratch=AH.Scratch
				src.Divide=AH.Divide
				src.TurfReplace=AH.TurfReplace
				src.TurfShift=AH.TurfShift
				src.TurfShiftLayer=AH.TurfShiftLayer
				src.TurfShiftDuration=AH.TurfShiftDuration
				src.TurfShiftDurationSpawn=AH.TurfShiftDurationSpawn
				src.TurfShiftDurationDespawn=AH.TurfShiftDurationDespawn
				src.TurfErupt=AH.TurfErupt
				src.TurfEruptOffset=AH.TurfEruptOffset
				src.TurfDirt=AH.TurfDirt
				src.TurfDirtOffset=AH.TurfDirtOffset
				src.TurfStrike=AH.TurfStrike
				src.CanBeBlocked=AH.CanBeBlocked
				src.CanBeDodged=AH.CanBeDodged
				src.Wander=AH.Wander
				src.WanderSize=AH.WanderSize
				src.Stasis=AH.Stasis
				src.MortalBlow=AH.MortalBlow
				src.WarpAway=AH.WarpAway
				src.Launcher=AH.Launcher
				src.DelayedLauncher=AH.DelayedLauncher

				if(AH.ObjIcon)
					src.ObjIcon=AH.ObjIcon
					src.icon=AH.icon
					src.pixel_x=AH.pixel_x
					src.pixel_y=AH.pixel_y

				src.loc=AH.loc

				src.Life()
		CrossOffshoot
			Cardinal=0
			var
				Side//1 for left, 2 for back, 0 for right.
			New(var/obj/AutoHitter/AH, var/side)
				src.Owner=AH.Owner
				src.Side=side
				if(src.Side==1)
					src.dir=turn(AH.dir, -90)
				else if(src.Side==2)
					src.dir=turn(AH.dir, -180)
				else
					src.dir=turn(AH.dir, 90)
				src.DistanceMax=AH.DistanceMax
				src.Distance=src.DistanceMax

				src.Damage=AH.Damage
				src.StepsDamage=AH.StepsDamage
				src.StrDmg=AH.StrDmg
				src.ForDmg=AH.ForDmg
				src.EndRes=AH.EndRes
				src.Knockback=AH.Knockback
				src.ChargeTech=AH.ChargeTech
				src.UnarmedTech=AH.UnarmedTech
				src.SwordTech=AH.SwordTech
				src.Stunner=AH.Stunner
				src.Deluge=AH.Deluge
				src.Destructive=AH.Destructive
				src.Bang=AH.Bang
				src.Bolt=AH.Bolt
				src.Scratch=AH.Scratch
				src.Divide=AH.Divide
				src.TurfReplace=AH.TurfReplace
				src.TurfShift=AH.TurfShift
				src.TurfShiftLayer=AH.TurfShiftLayer
				src.TurfShiftDuration=AH.TurfShiftDuration
				src.TurfShiftDurationSpawn=AH.TurfShiftDurationSpawn
				src.TurfShiftDurationDespawn=AH.TurfShiftDurationDespawn
				src.TurfErupt=AH.TurfErupt
				src.TurfEruptOffset=AH.TurfEruptOffset
				src.TurfDirt=AH.TurfDirt
				src.TurfDirtOffset=AH.TurfDirtOffset
				src.TurfStrike=AH.TurfStrike
				src.CanBeBlocked=AH.CanBeBlocked
				src.CanBeDodged=AH.CanBeDodged
				src.Slow=AH.Slow
				src.Wander=AH.Wander
				src.Stasis=AH.Stasis
				src.MortalBlow=AH.MortalBlow
				src.WarpAway=AH.WarpAway
				src.Launcher=AH.Launcher
				src.DelayedLauncher=AH.DelayedLauncher

				if(AH.ObjIcon)
					src.ObjIcon=AH.ObjIcon
					src.icon=AH.icon
					src.pixel_x=AH.pixel_x
					src.pixel_y=AH.pixel_y

				src.loc=AH.loc

				src.Life()