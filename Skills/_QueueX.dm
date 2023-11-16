obj
	Skills
		Queue//Queued skills like GET DUNKED and Axekick.
			var/Duration=5//This is how long the queue remains up for.
			var/UnarmedOnly=0//Can't use this with a sword.
			var/SwordOnly=0//todo remove
			//var/ClassNeeded//Requires a sword class.
			var/TextColor
			var/ActiveMessage//Displays on using the skill, if it exists.
			var/HitMessage//Displays on hitting with the skill, if it exists.
			var/MissMessage//Displays on missing with the skill, if it exists.
			var/DamageMult//obvs
			var/AccuracyMult//obvs
			var/MultiHit//hits multiple times before turning off.
			var/HitsUsed//Keeps a tally of how many hits have been used.
			var/KBAdd//Adds knockback
			var/KBMult//Multiplies knockback.
			var/KBDelayed//KBs after the move is finished
			var/Recoil/*If this is set, it will mark the attackers recoil damage.*/
			var/Finisher//Passive that makes damage scale.
			var/Opener//Passive that makes damage higher when health is higher.
			var/Decider//Passive that makes damage higher when health is near the middle.
			var/Dominator//win harder
			var/Determinator//turn a loss into a win
			var/Delayer//alliteration, but. this is a charge punch that does more damage when theres more time elapsed between queueing and bonking!!
			var/DelayerTime//+1 every second queue is queued. Mult this by Delayer when the attack finally gets thrown.
			var/Counter//guess
			var/CounterTemp//from coutnermaster
			var/NoWhiff //guess
			var/PrecisionStrike//attack only what you want to
			var/SpeedStrike/*Passive that multiplies damage by speed mod.  1 = 0.5 speed, 2 = full speed.*/
			var/SweepStrike/*Passive that multiplies damage by enemy's speed.  Reverse Speed Strike!*/
			var/DrawIn/*Passive that draws people in.  DrawIn value = the amount of tiles drawn in.*/
			var/PushOut//Passive that pushes people away. PushOut value = the amount of tiles pushed away.
			var/PushOutWaves=1
			var/PushOutIcon='fevKiai.dmi'
			var/Punt
			var/ComboMessaged//If the combo has displayed a message, flag this
			var/Combo//Value of combo is how many times it hits.
			var/ComboPerformed=0//Tracks number of hits done.
			var/list/ComboHitMessages=list()//X="message to be displayed"
			var/Rapid//Make Combos happen sooner
			var/InstantStrikes //the fasses of fass attacks
			var/InstantStrikesPerformed=0
			var/InstantStrikesDelay//when fass is too fass
			var/Warp//If this is ticked, it homes onto people.
			var/NoWarp
			var/SpecialEffect//shinies
			var/SpecialEffectRange=3//shinies big or smol
			var/RozanEffect//super launcher
			var/ShoryukenEffect//Do the shoryuken effect!
			var/GoshoryukenEffect
			var/Explosive//Makes explosions, duh.
			var/Shining//Makes shock effects.
			var/Bolt//Makes lightning drop effect.
			var/Darkness//Makes darkness tiles.
			var/IconLock='BLANK.dmi'
			var/IconLockUnder=0
			var/LockX=0
			var/LockY=0

			//ALL THREE OF THESE TAKE AN OBJECT TYPE.
			var/Step//sequential attacks for hits or misses
			var/HitStep//sequential attacks only if you hit
			var/MissStep//sequential attacks only if you miss

			//These three are all just binaries to determine what to do when you clear your queue and there's a step tech.
			var/Missed=0//Flagged for when attacks miss
			var/Hit=0//Flagged for when attacks hit
			var/RanOut=0//Flagged for when attacks just run out of time


			var/Dunker//Multiplies launched foes damage by this value.

			var/Projectile//holds the projectile type and decides if there is a projectile at all
			var/ProjectileCount=1//Fires the given projectile multiple times
			var/ProjectileCDBypass//sets CD to 0
			var/ProjectileBeam//Double tap for beams

//			var/GrabTrigger//adds and activates a grapple
			var/StanceNeeded
			var/ABuffNeeded
			var/SBuffNeeded
			var/GateNeeded


			var/Quaking//Makes screen go shakka shakka
			var/WarpAway



			var/SpiritStrike//Targets End with Force
			var/HybridStrike//For+Str
			var/SpiritHand//Sunlight stance
			var/SpiritSword//duh
			var/KiBlade//duh
			var/PridefulRage

			//Instinct//Ignore AIS/WS
			var/Steady//It do what steady do.
			var/WeaponBreaker//WHAT DO U THINK?!
			var/MortalBlow//WHHHHHHHHHHHAAAAAAAAAA-

			var/HitSparkIcon//you
			var/HitSparkX//know
			var/HitSparkY//how
			var/HitSparkSize//it
			var/HitSparkTurns//do
			var/HitSparkDispersion=8


			var/RipplePower=1//used to make ripple go higher
			var/DrainBlood=0// This is used for vampire grab + toss, makes them gain bloodpower
//Autoqueues

////General
			Finisher
				Duration=5
				Instinct=4
				DamageMult=1
				AccuracyMult=20
				KBMult=0.001
				Decider=1
				Finisher=1
				Rapid=1
				Warp=3
				PushOut=2
				PushOutWaves=3
				PushOutIcon='fevKiai.dmi'
				BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Generic_Finisher"
				HitMessage="strikes their opponent with a powerful blow!"
				Generic_Finisher
					name="Finishing Blow"

				Iron_Fortress
					Shattering=20
					DamageMult=3
					FollowUp="/obj/Skills/AutoHit/Shatter_Shell"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Turtle_Martial_Mastery"
					HitMessage="slams the full weight of their body into the opponent in a shoulder check!"
				Fire_Dancer
					DamageMult=2
					KBAdd=5
					KBMult=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Crane_Martial_Mastery"
					FollowUp="/obj/Skills/Projectile/Phoenix_Flares"
					HitMessage="turns on their heel, sending the enemy skyward with a reverse rising kick!"
				Dragon_Falls
					DamageMult=1.5
					Grapple=1
					KBMult=0.001
					FollowUp="/obj/Skills/Grapple/Snake_Fang_Bites"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Snake_Martial_Mastery"
					HitMessage="swings low and hooks the opponent into the air by the neck!"
				Hungry_Fang
					Stunner=1
					DamageMult=2.5
					FollowUp="/obj/Skills/AutoHit/Cat_Claw_Rush"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Cat_Martial_Mastery"
					HitMessage="delivers a brutal overhand swipe with a raking claw!"

				//t1 signature styles
				Eight_Trigrams
					Combo=8
					DamageMult=0.75
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Ki_Flow_Mastery"
					HitMessage="spins around their victim, striking endless pressure points in succession!"
				Rising_Wind
					KBMult=2
					KBAdd=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Body_Mastery"
					HitMessage="carries their opponent through a brutal haymaker!"
					FollowUp="/obj/Skills/AutoHit/Strongest_Fist"
				Mouton_Shot
					KBMult=0.001
					Crippling=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Spirit_Mastery"
					HitMessage="springs into a handstand, launching a destructive kick from below!"
					FollowUp="/obj/Skills/AutoHit/Flamberge_Shot"
				Rolling_Sobat
					Warp=5
					Paralyzing=10
					Crippling=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Rush_Mastery"
					HitMessage="cuts in with a smooth rolling kick to the side!"
					FollowUp="/obj/Skills/AutoHit/Blitz_Rush"

				//t2 signature styles
				Tetsuzankou
					DamageMult=3
					SoftStyle=2
					FollowUp="/obj/Skills/AutoHit/Drunken_Crash"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Drunken_Mastery"
					HitMessage="slides in with unnatural grace, delivering a bone crushing shoulder check!"
				Galactica_Phantom
					DamageMult=3
					HardStyle=2
					HitMessage="launches an earth-shattering, explosive clothesline!"
					FollowUp="/obj/Skills/AutoHit/Galaxy_Clothesline"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Strength_Mastery"
				Spiral_Fang
					DamageMult=2.5
					HardStyle=1.5
					HitMessage="drives their opponent into the ground with a twisting slam attack!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Dire_Empowerment"
				Astral_Shot
					DamageMult=2.5
					HitMessage="lands a brutal orbital kick, draining some of the victim's life from the impact!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Astral_Empowerment"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Astral_Drain"
				Immortal_Change
					Paralyzing=50
					Scorching=50
					Freezing=50
					Crushing=50
					HitMessage="unleashes a sphere of pure elemental chaos around them, and rams it into their foe!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Chaos_Empowerment"
				Maiden_Masher
					DamageMult=3
					HitMessage="unleashes their wrath on the opponent, engulfing them in an explosive wave of dark flame!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Devil_Luck"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Devil_Fire"
				Maxima_Press
					DamageMult=3
					Launcher=3
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Forced_Mechanize"
					HitMessage="drags their opponent by their face, launching them up with a magnetic charge!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Reversal_Mastery"
				Morbid_Angel
					DamageMult=3
					Launcher=3
					HitMessage="leaps onto their enemy's shoulders, gouging their throat with deadly venom!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Death_Mastery"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Bio_Break"

				Mountain_Crusher
					DamageMult=1.5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Earth_Empowerment"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Crystal_Crumbling"
					HitMessage="decimates with an Earth-empowered elbow strike to the sternum!"
				Shifting_Clouds
					DamageMult=1.5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Wind_Empowerment"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Constant_Cyclone"
					HitMessage="steps forward, dropping their Wind-empowered fist like a bolt of lightning!"
				Hellraiser
					DamageMult=1.5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Fire_Empowerment"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Continued_Conflagration"
					HitMessage="ducks, spins, and delivers an explosive Fire-empowered backhand slam!"
				Split_River
					DamageMult=1.5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Water_Empowerment"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Corrosive_Chill"
					HitMessage="crashes down like a wave with a Water-empowered wheel kick!"

				//t1 sig styles
				Ray_Divider
					DamageMult=2
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Forced_Mechanize"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Cyber_Crusher"
					HitMessage="launches a magic-powered strike that magnetically charges the enemy!"
				Badlands
					DamageMult=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Toxic_Crash"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Venom_Break"
					HitMessage="digs their venom deep into the flesh of their victim, forcing them to suffer..."
				Crimson_Star_Road
					DamageMult=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Corona_Splash"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Solar_Break"
					HitMessage="slides coolly past the opponent, before a string of explosions lights them up!"
				Surprise_Rose
					DamageMult=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Stillness"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Anger_Break"
					HitMessage="leaps towards the opponent, mocking them with repeated stomps from above!"

				Mist_Finer
					Warp=10
					FollowUp="/obj/Skills/Queue/Finisher/Drawing_Mist"
					HitMessage="strikes out with such speed and precision that their blade disappears!"
				Drawing_Mist
					Warp=10
					DamageMult=3
					SpeedStrike=4
					HitMessage="draws their blade back in from the dispersed mist!"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Off_Balance"
					BuffSelf=0
				Vicious_Moon
					Counter=1
					Stunner=2
					FollowUp="/obj/Skills/AutoHit/Blooming_Moon"
					HitMessage="carves a crescent through their foolish victim!"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Attack_Break"
					BuffSelf=0
				Soul_Survivor
					Warp=10
					Instinct=1
					KBMult=0.001
					FollowUp="/obj/Skills/AutoHit/Divide_Effect"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Overwhelmed"
					HitMessage="carves through the earth, destroying everything between them and their foe!"
					BuffSelf=0
				Hammer_Fall
					Counter=1
					Grapple=1
					KBMult=0.001
					FollowUp="/obj/Skills/Grapple/Hammer_Crush"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Debilitated"
					HitMessage="presses their powerful grip around both sides of the helpless foe!"
					BuffSelf=0

				//tier 1 sig styles

				Geo_de_Ray
					DamageMult=2
					Warp=10
					Crippling=10
					SpeedStrike=1
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Dual_Break"
					HitMessage="flies forward in a whirlwind of piercing blades!"
					FollowUp="/obj/Skills/Queue/Finisher/Dual_Flurry"
					BuffSelf=0
				Dual_Flurry
					Combo=20
					DamageMult=0.5
					PushOutWaves=0
					HitMessage="rips through their opponent with countless slashes!"
					IconLock='CircleWind.dmi'
					LockX=-32
					LockY=-32
					BuffSelf=0
				Ichimonji
					DamageMult=2
					KBMult=0.0001
					FollowUp="/obj/Skills/AutoHit/Flowing_Slash_Follow_Up"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Technique_Break"
					HitMessage="'s step is fluid and calm, landing a single, staggering overhead strike!"
					BuffSelf=0
				Flying_Barcelona
					Warp=10
					Grapple=1
					KBMult=0.001
					GrabTrigger="/obj/Skills/Grapple/Sword/Butterfly_Souffle"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Desiccated"
					HitMessage="soars through the air to their opponent with blade out, seizing them from a blind spot!"
					BuffSelf=0
				Manji_Flip
					Warp=10
					Launcher=1
					FollowUp="/obj/Skills/AutoHit/Whirlwind_Handstand"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Feral_Fear"
					HitMessage="performs an uncanny acrobatic strike, rocketing their foe upwards!"
					BuffSelf=0

				//t2 sig style
				Ogre_Cutter
					DamageMult=5
					Warp=10
					Crippling=20
					HitMessage="carves out with all three blades, leaving devastation in their wake!"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Tri_Break"
					FollowUp="/obj/Skills/Projectile/Oni_Giri"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Trinity_Mastery"
				Crimson_Fountain
					DamageMult=5
					KBMult=2
					Shearing=20
					FollowUp="/obj/Skills/Projectile/Devil_Divide"
					HitMessage="drives their bare fist into the enemy's chest, then hurls them away like trash!"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Impaled"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Maim_Mastery"
				Sacred_Edge
					DamageMult=3
					SpiritStrike=3
					HitMessage="drives a colossal shard of concentrated mana into the foe point-blank!"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Mana_Break"
					BuffSelf=0
				Absolute_Truth
					DamageMult=1
					Warp=10
					FollowUp="/obj/Skills/AutoHit/Stop_Effect"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Evasion_Negation"
					HitMessage="drives their staff into the ground, letting out a pulse of sealing force!"
					BuffSelf=0

				Berserker_Claw
					DamageMult=3
					Warp=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Bestial_Accuracy"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Locked_On"
					HitMessage="is gone in an instant, appearing behind their target for a vicious attack!"
				Evac_Toss
					DamageMult=2
					Counter=1
					Launcher=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Martial_Flow"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Disoriented"
					HitMessage="uses their opponent's momentum, effortlessly launching them skyward!"
				Armor_Piercer
					DamageMult=3
					WeaponBreaker=1.5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Anti_Material_Augment"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Broken_Bones"
					HitMessage="tears through the enemy's defense with a driving body blow!"
				Riot_Stamp
					DamageMult=1.5
					KBMult=2
					KBAdd=5
					Launcher=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Speed_Break"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Slow_Motion"
					HitMessage="hops back, then leaps in to stomp their opponent into the floor!"

				//t1 sig styles
				Impact_Palm
					KBAdd=10
					DamageMult=1.5
					SpiritStrike=1
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Sure_Shot"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Traced"
					HitMessage="breaks their enemy's defenses by shattering their aura with a swift energized palm!"
				Superbia
					KBMult=0.01
					Crippling=10
					DamageMult=1.5
					SpiritStrike=1
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Seeking_Spirits"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Traced"
					HitMessage="'s fist surge with power as they plunge into the enemy's aura, halting them in place!"
				Turn_of_Fortune
					DamageMult=3
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Ineffective_Fate"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Fortunate_Fate"
					HitMessage="gracefully spins around their foe's flank, landing precision strikes along the way!"
				Chemical_Love
					DamageMult=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Speed_of_Sound"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Shattered"
					HitMessage="'s perfect chord sends a razor-sharp soundwave through the opponent's body!"

				//t2 sig style
				Raioken
					InstantStrikes=10
					InstantStrikesDelay=1
					DamageMult=0.25
					HitMessage="unleashes a barrage of countless fists!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Flash_Cry"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Slow_Motion"
				Karaniyam
					DamageMult=2.5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/What_Must_Be_Done"
					HitMessage="chants a line of prayer!"
				Bicycle_Kick
					DamageMult=2.5
					HitMessage="spikes their opponent into the air before battering them with rapid kicks!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Self_Mastery"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Self_Shattered"
				Centifoila
					InstantStrikes=10
					InstantStrikesDelay=1
					DamageMult=0.25
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Dance_Mastery"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Ineffective_Fate"

				//t3 sig style
				Pressure_Point
					Stunner=3
					Launcher=3
					DamageMult=2
					HitMessage="locks their opponent's body up by striking a pressure point in their chest!"
					FollowUp="/obj/Skills/Queue/Hokuto_Hyakuretsu_Ken"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/North_Strength"

				Imperial_Assessment
					NoWhiff=1
					NoForcedWhiff=1
					CursedWounds=1
					DamageMult=3
					Grapple=1
					HitMessage="takes a measure of their opponent, before discarding them as worthless!"
					BuffSelf=0
					FollowUp="/obj/Skills/Grapple/Imperial_Disgust"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Useless"

				Over_The_Horizon
					DamageMult=2
					Launcher=3
					HitMessage="shoots their opponent into the sky on a sudden whirlwind! They're on someone else's turf now!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/East_Strength"

				Atomic_Split
					DamageMult=3
					Crippling=10
					HitMessage="punts their opponent up into the air!"
					FollowUp="/obj/Skills/AutoHit/Atomic_Crush"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Radioactive"
					BuffSelf=0

				Ashura_Kai
					DamageMult=1
					PureDamage=5
					InstantStrikes=10
					InstantStrikesDelay=1.5
					HitSparkIcon='Slash - Ragna.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkTurns=1
					HitMessage="expresses the mastery of a war god by casting innumerable strikes in an instant!"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/War_God"

				Journey_End
					DamageMult=1
					KBMult=0.001
					Crippling=20
					HitMessage="delivers a perfectly smooth blow to the enemy's sternum ... But that's not all ..."
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Flowing_River"

				Death_Rattle
					DamageMult=1
					KBMult=0.001
					Crippling=20
					HitMessage="pauses in their rhythm ... The silence seems to stretch forever."
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Moelach_Weezing"
					FollowUp="/obj/Skills/Projectile/Warsong_Finale"
					BuffSelf=0

				Skyward_Strike
					Stunner=3
					Launcher=3
					DamageMult=2
					KBAdd=5
					KBMult=0.000001
					HitMessage="sends their opponent airbourne with an upwards strike!"
					FollowUp="/obj/Skills/AutoHit/Tensho_Juji_Ho"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/South_Break"
					BuffSelf=0

				//Ansatsuken Finisher
				Isshin
					DamageMult=5
					Counter=1
					Stunner=5
					KBMult=4
					KBAdd=5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Hado_Kakusei"
					FollowUp="/obj/Skills/Projectile/Hadoken_Effect"
				Shoryureppa1
					DamageMult=2
					name="Shoryureppa"
					HitStep=/obj/Skills/Queue/Finisher/Shoryureppa2
					ShoryukenEffect=0.5
					AccuracyMult=20
					HitMessage=0
				Shoryureppa2
					DamageMult=2
					name="Shoryureppa"
					ShoryukenEffect=2
					Shattering=30
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Heat_Rush"
				Shippu_Jinraikyaku
					DamageMult=1
					PushOutWaves=0
					PushOut=0
					Combo=4
					Rapid=1
					HitStep=/obj/Skills/Queue/Finisher/Shippu_Jinraikyaku2
					BuffSelf=0
					HitMessage=0
				Shippu_Jinraikyaku2
					DamageMult=2
					Rapid=1
					FollowUp="/obj/Skills/AutoHit/Tatsumaki_Effect"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Violent_Personality"

				Rakan_Dantojin
					DamageMult=2
					AccuracyMult=20
					FollowUp="/obj/Skills/AutoHit/Shun_Goku_Satsu"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Violent_Personality"


				//Hiten Finisher
				Flash_Strike
					DamageMult=4
					Counter=1
					Warp=10
					SpeedStrike=2
					SlayerMod=2
					FollowUp="/obj/Skills/AutoHit/Shunshin_Massacre"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Shunshin"
				True_Flash_Strike
					DamageMult=6
					Counter=1
					Warp=10
					SpeedStrike=4
					SlayerMod=3
					FollowUp="/obj/Skills/AutoHit/Shunshin_Massacre"
					BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Godspeed_Assaulted"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Shunshin_Shin"

				//Keyblade Finishers
				Fever_Pitch
					KBAdd=2
					Launcher=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Fever_Pitch"
					FollowUp="/obj/Skills/AutoHit/FeverPitch"
					HitMessage="drives their heart into a fever pitch!"
				Fatal_Mode
					KBMult=0.001
					Stunner=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Fatal_Mode"
					FollowUp="/obj/Skills/AutoHit/FatalMode"
					HitMessage="embraces the inevitability of a fatality!"
				Magic_Wish
					InstantStrikes=5
					InstantStrikesDelay=2
					PrecisionStrike=2
					DamageMult=0.2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Magic_Wish"
					FollowUp="/obj/Skills/AutoHit/MagicWish"
					HitMessage="hopes upon a magic wish!"

				Fire_Storm
					Projectile="/obj/Skills/Projectile/Fire_Storm"
					ProjectileCount=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Fire_Storm"
					HitMessage="casts down a fire storm!"
				Diamond_Dust
					PrecisionStrike=3
					InstantStrikes=5
					InstantStrikesDelay=2
					DamageMult=0.2
					Freezing=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Diamond_Dust"
					HitMessage="twirls with diamond dust!"
				Thunderbolt
					Warp=10
					SpeedStrike=2
					Paralyzing=10
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Thunderbolt"
					HitMessage="lashes out quicker than a thunderbolt!"

				Wing_Blade
					Warp=10
					SpeedStrike=4
					Launcher=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Wing_Blade"
					FollowUp="/obj/Skills/AutoHit/WingbladeFlash"
					HitMessage="reveals a marvelous light!"
				Cyclone
					Warp=10
					SpeedStrike=4
					Launcher=2
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Cyclone"
					FollowUp="/obj/Skills/AutoHit/CycloneCharge"
					HitMessage="spins forward in a high-tension cyclone!"

				Rock_Breaker
					Stunner=5
					DamageMult=0.25
					Combo=10
					Projectile=/obj/Skills/Projectile/Rock_Bits
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Rock_Breaker"
					HitMessage="barrages their enemy with bone-breaking rocks!"
				Dark_Impulse
					Stunner=5
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Dark_Impulse"
					FollowUp="/obj/Skills/AutoHit/Dark_Blast"
					HitMessage="unleashes a point-blank blast of darkness!"

				Ghost_Drive
					SpiritHand=1
					SpiritStrike=1
					PridefulRage=1
					Combo=10
					DamageMult=0.1
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Ghost_Drive"
					HitMessage="phases through every defense like a ghost!"
				Blade_Charge
					SpiritHand=1
					SpiritStrike=1
					PridefulRage=1
					Crippling=10
					KBMult=0.001
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Blade_Charge"
					FollowUp="/obj/Skills/AutoHit/BladeChargeRave"
					HitMessage="hyper charges their keyblade with mana!"



			Hokuto_Hyakuretsu_Ken //Hundred Crack Fist
				DamageMult=0.1
				Warp=5
				KBAdd=0
				KBMult=0.00001
				Combo=25
				Launcher=1
				CursedWounds=1
				Rapid=1
				Instinct=4
				HitSparkIcon='Hit Effect.dmi'
				HitSparkX=-32
				HitSparkY=-32
				FollowUp="/obj/Skills/Queue/Hagan_Ken"
				ActiveMessage="performs rapid fire strikes!" //ATATATATATATATATATA
			East_Rush
				DamageMult=2
				KBAdd=0
				KBMult=0.001
				Rapid=1
				Projectile=/obj/Skills/Projectile/East_Gust


			Hagan_Ken
				DamageMult=2.5
				Finisher=1
				CursedWounds=1
				Dunker=1 //Just flashy to end the combo. No extra damage.
				Warp=5
				KBAdd=5
				KBMult=0.00001
				HitSparkIcon='Hit Effect.dmi'
				HitSparkX=-32
				HitSparkY=-32
				ActiveMessage="smashes their fist into their opponents face!" //WA TA
////Keyblade
			DarkImpulseGrab
				ActiveMessage="overflows with the power of darkness!"
				HitMessage="vanishes towards their opponent, smothering them with a malicious claw!"
				DamageMult=3
				AccuracyMult=3
				Duration=5
				Warp=3
				Grapple=1
				KBMult=0.001
				GrabTrigger=0.5
				GoshoryukenEffect=1
				PushOut=2
				PushOutWaves=3
				PushOutIcon='DarkKiai.dmi'
				//No verb since it is set from melee.
////Ripple
			Rebuff_Overdrive
				DamageMult=2.5
				AccuracyMult=1
				KBAdd=5
				Quaking=5
				Shining='Ripple Barrier.dmi'
				IconLock='Ultima Arm.dmi'
				Duration=2
				Counter=1
				ActiveMessage="rushes in with an elbow counter assault: <b>Rebuff Overdrive!!</b>"
				//set manually so no verb
			Zoom_Punch
				DamageMult=2.5
				AccuracyMult=2
				Warp=3
				KBAdd=5
				Duration=5
				Instinct=1
				IconLock='Ultima Arm.dmi'
				HitMessage="dislocates their arm to deliver a surprise strike: <b>Zoom Punch!</b>"
				//set manually so no verb
			Sunlight_Yellow_Overdrive
				DamageMult=1
				AccuracyMult=20
				Warp=5
				KBAdd=1
				KBMult=0.00001
				Combo=25
				Quaking=10
				Instinct=4
				IconLock='Ripple Arms.dmi'
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.3
				Duration=5
				ActiveMessage="unleashes the radiant beat of their heart, the Ripple of the Sun: <b><font color=#FFD700>Sunlight Yellow Overdrive!!!</font></b>"
				//set manually so no verb
////Vampirism
			Vampire_Lunge
				DamageMult=2
				AccuracyMult=2
				Warp=5
				KBAdd=0
				KBMult=0.00001
				LifeSteal=100
				Instinct=4
				HitSparkIcon='Hit Effect Vampire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.5
				Duration=5
				ActiveMessage="lets loose a dreaded battlecry as they leap forth!  WRYYYY!!"
				proc/adjust(mob/p)
					var/secretLevel = p.getSecretLevel()
					LifeSteal = min(25 * secretLevel,100)
					Crippling = secretLevel


				//set manually so no verb
			Vampire_Rage
				DamageMult=2
				AccuracyMult=2
				Warp=5
				KBAdd=1
				KBMult=0.00001
				LifeSteal=100
				Instinct=4
				Combo=10
				HitSparkIcon='Slash - Vampire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				Duration=5
				ActiveMessage="transforms their body into a storm of shadow blades!"
				// this is literally ora ora
				proc/adjust(mob/p)
					var/secretLevel = p.getSecretLevel()
					LifeSteal = min(50 * secretLevel,100)
					Crippling = secretLevel * 1.5


//Basic

			Heavy_Strike
				Duration=5
				DamageMult=2
				AccuracyMult=1
				KBAdd=5
				KBMult=3
				Cooldown=15
				verb/Heavy_Strike()
					set category="Skills"
					if(usr.Tension>=100)
						if(usr.HasTensionLock())
							return
						if(usr.AttackQueue)
							return
						usr.Tension=0
						if(usr.StyleBuff.Finisher)//if the style has a unique finisher
							var/path=text2path(usr.StyleBuff.Finisher)
							if(!locate(path, usr))
								usr.AddSkill(new path)//give it an object type to allow for customizations
							for(var/obj/Skills/Queue/q in usr.Queues)
								if(q.type==path)
									usr.SetQueue(q)
						else
							usr.SetQueue(new/obj/Skills/Queue/Finisher/Generic_Finisher)
						return
					else
						if(usr.AttackQueue)
							return // prevent heavy strike from overriding
						if(!usr.Secret|| usr.Secret == "Jagan" ||usr.Secret=="Necromancy"||usr.Secret=="Ripple"&&!usr.HasRipple()||usr.Secret=="Senjutsu"&&!usr.CheckSlotless("Senjutsu Focus"))//Just default Heavy Strike
							src.name="Heavy Strike"
							src.DamageMult=2
							src.AccuracyMult=1
							src.KBAdd=5
							src.KBMult=3
							src.Cooldown=15
							src.ActiveMessage=0
							src.HitMessage=0
							src.CursedWounds=0
							src.Scorching=0
							src.Freezing=0
							src.Paralyzing=0
							src.Shattering=0
							src.Toxic=0
							src.Combo=0
							src.Warp=0
							src.Rapid=0
							src.LifeSteal=0
							src.Crippling=0
							src.Grapple=0
							src.NoForcedWhiff=0
							src.IconLock='BLANK.dmi'
							src.HitSparkIcon=null
							src.HitSparkX=0
							src.HitSparkY=0
							src.HitSparkTurns=0
							src.HitSparkSize=1
							usr.SetQueue(src)
							return//and that's the end
						if(usr.Secret=="Senjutsu"&&usr.CheckSlotless("Senjutsu Focus"))
							src.name="Sage Energy Strike"
							src.DamageMult=2
							src.AccuracyMult=2
							src.KBAdd=5
							src.KBMult=3
							src.Cooldown=30
							src.ActiveMessage="focuses natural energy in their fist!"
							src.HitMessage=0
							src.Scorching=3
							src.Freezing=3
							src.Paralyzing=3
							src.Shattering=3
							src.CursedWounds=0
							src.Toxic=0
							src.Combo=0
							src.Warp=0
							src.Rapid=0
							src.LifeSteal=0
							src.Crippling=0
							src.Grapple=0
							src.NoForcedWhiff=0
							src.IconLock='BLANK.dmi'
							src.HitSparkIcon=null
							src.HitSparkX=0
							src.HitSparkY=0
							src.HitSparkTurns=0
							src.HitSparkSize=1
							usr.SetQueue(src)
						if(usr.Secret=="Haki")
							usr.AddHaki("Armament")
							if(!usr.CheckSlotless("Haki Armament"))
								for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Armament/H in usr)
									H.Trigger(usr)
							if(usr.CheckSlotless("Haki Observation"))
								for(var/obj/Skills/Buffs/SlotlessBuffs/Haki/Haki_Observation/H in usr)
									H.Trigger(usr)
							if(usr.HakiSpecialization=="Armament")
								src.name="Buso: Koka"
								src.DamageMult = 1 + usr.secretDatum.currentTier
								src.AccuracyMult=3
								src.KBAdd=10
								src.KBMult=3
								src.Cooldown=20
								src.ActiveMessage="has their arms darken in preparation for a devastating attack!"
								src.Paralyzing=0
								src.Toxic=0
								src.Scorching=0
								src.Freezing=0
								src.Shattering=0
								src.Combo=0
								src.CursedWounds=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=1
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=2
								src.IconLock='BusoKoka.dmi'
								usr.SetQueue(src)
								return
							else
								src.name="Armament Strike"
								src.DamageMult=2
								src.AccuracyMult=3
								src.KBAdd=5
								src.KBMult=3
								src.Cooldown=20
								src.ActiveMessage="focuses their will into their fist!"
								src.Paralyzing=0
								src.Toxic=0
								src.Scorching=0
								src.Freezing=0
								src.Shattering=0
								src.Combo=0
								src.CursedWounds=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=1
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								src.IconLock='BLANK.dmi'
								usr.SetQueue(src)
								return
						if(usr.Secret=="Ripple"&&usr.HasRipple())
							if(usr.SwordWounds()||usr.Harden)//no barrage for swords
								src.name="Ripple Overdrive"
								src.DamageMult=2
								src.AccuracyMult=3
								src.KBAdd=5
								src.KBMult=3
								src.Cooldown=30
								src.HitMessage="channels the Ripple through metal: <b>Metal Silver Overdrive!!</b>"
								src.Paralyzing=0
								src.Toxic=0
								src.Scorching=0
								src.Freezing=0
								src.Shattering=0
								src.CursedWounds=0
								src.Combo=0
								src.Warp=2
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='Ultima Arm.dmi'
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							if(prob(20))//always check for the barrage
								src.name="Ripple Overdrive"
								src.DamageMult=1
								src.AccuracyMult=3
								src.KBAdd=1
								src.KBMult=1
								src.Cooldown=30
								src.HitMessage="channels the Ripple for multiple powerful hits: <b>OVERDRIVE BARRAGE!!</b>"
								src.Scorching=0
								src.Freezing=0
								src.Paralyzing=0
								src.Toxic=0
								src.Shattering=0
								src.CursedWounds=0
								src.Combo=5
								src.Warp=5
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='Ripple Arms.dmi'
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							if(usr.ElementalOffense=="Water"||usr.Swim)
								src.name="Ripple Overdrive"
								src.DamageMult=2
								src.AccuracyMult=3
								src.KBAdd=5
								src.KBMult=3
								src.Cooldown=20
								src.HitMessage="channels the Ripple through water: <b>Turquoise Blue Overdrive!!</b>"
								src.Scorching=0
								src.Freezing=10
								src.Paralyzing=0
								src.Toxic=0
								src.Shattering=0
								src.CursedWounds=0
								src.Combo=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='Ultima Arm.dmi'
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							if(usr.ElementalOffense=="Fire"||usr.Burn)
								src.name="Ripple Overdrive"
								src.DamageMult=3
								src.AccuracyMult=2
								src.KBAdd=5
								src.KBMult=3
								src.Cooldown=20
								src.HitMessage="channels the Ripple into fire: <b>Scarlet Overdrive!!</b>"
								src.Scorching=10
								src.Freezing=0
								src.Paralyzing=0
								src.Toxic=0
								src.Shattering=0
								src.CursedWounds=0
								src.Combo=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='Ultima Arm.dmi'
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							if(usr.ElementalOffense=="Wind"||usr.Flying)
								src.name="Ripple Overdrive"
								src.DamageMult=2
								src.AccuracyMult=3
								src.KBAdd=5
								src.KBMult=3
								src.Cooldown=20
								src.HitMessage="channels the Ripple through a spinning kick: <b>Tornado Overdrive!!</b>"
								src.Scorching=0
								src.Freezing=0
								src.Paralyzing=10
								src.CursedWounds=0
								src.Toxic=0
								src.Combo=0
								src.Warp=3
								src.Rapid=1
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='Ultima Arm.dmi'
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							if(usr.ElementalOffense=="Earth")
								src.name="Ripple Overdrive"
								src.DamageMult=3
								src.AccuracyMult=2
								src.KBAdd=10
								src.KBMult=5
								src.Cooldown=20
								src.HitMessage="channels the Ripple through solid rock: <b>Sendo Ripple Overdrive!!</b>"
								src.Scorching=0
								src.Freezing=0
								src.Paralyzing=0
								src.Toxic=0
								src.Shattering=10
								src.CursedWounds=0
								src.Combo=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=0
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='Ultima Arm.dmi'
								src.HitSparkIcon=0
								src.HitSparkX=0
								src.HitSparkY=0
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							//But if all those fail, use this
							src.name="Ripple Overdrive"
							src.DamageMult=1
							src.AccuracyMult=3
							src.KBAdd=5
							src.KBMult=3
							src.Cooldown=20
							src.HitMessage="channels the Ripple through their strikes: <b>Ripple Overdrive!!</b>"
							src.Scorching=0
							src.Freezing=0
							src.Paralyzing=0
							src.Toxic=0
							src.CursedWounds=0
							src.Combo=0
							src.Warp=0
							src.Rapid=0
							src.LifeSteal=0
							src.Crippling=0
							src.Grapple=0
							src.NoForcedWhiff=0
							src.IconLock='Ultima Arm.dmi'
							src.HitSparkIcon=0
							src.HitSparkX=0
							src.HitSparkY=0
							src.HitSparkTurns=0
							src.HitSparkSize=1
							usr.SetQueue(src)
							return
						if(usr.Secret=="Vampire")
							if(!usr.PoseEnhancement)
								src.name="Vampiric Strike"
								src.DamageMult=2
								src.AccuracyMult=2
								src.KBAdd=0
								src.KBMult=0.0001
								src.Cooldown=20
								src.HitMessage="rips out their opponent's life force with a powerful strike!"
								src.Scorching=0
								src.Freezing=0
								src.Paralyzing=0
								src.Toxic=0
								src.CursedWounds=0
								src.Combo=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=100
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='BLANK.dmi'
								src.HitSparkIcon='Hit Effect Vampire.dmi'
								src.HitSparkX=-32
								src.HitSparkY=-32
								src.HitSparkTurns=0
								src.HitSparkSize=1
								usr.SetQueue(src)
								return
							else
								src.name="Vampiric Strike"
								src.DamageMult=3
								src.AccuracyMult=3
								src.KBAdd=5
								src.KBMult=0.0001
								src.Cooldown=20
								src.HitMessage="rips their opponent to shreds!"
								src.Scorching=0
								src.Freezing=0
								src.Paralyzing=0
								src.Toxic=0
								src.CursedWounds=0
								src.Combo=0
								src.Warp=0
								src.Rapid=0
								src.LifeSteal=100
								src.Crippling=0
								src.Grapple=0
								src.NoForcedWhiff=0
								src.IconLock='BLANK.dmi'
								src.HitSparkIcon='Slash - Vampire.dmi'
								src.HitSparkX=-32
								src.HitSparkY=-32
								src.HitSparkTurns=1
								src.HitSparkSize=2
								usr.SetQueue(src)
						if(usr.Secret=="Werewolf")
							src.name="Rip and Tear"
							src.DamageMult=2
							src.AccuracyMult=2
							src.KBAdd=0
							src.KBMult=5
							src.Cooldown=20
							src.HitMessage="digs their claws into their opponent, dealing crippling wounds!"
							src.Scorching=0
							src.Freezing=0
							src.Paralyzing=0
							src.Toxic=0
							src.CursedWounds=0
							src.Combo=0
							src.Warp=0
							src.Rapid=0
							src.LifeSteal=0
							src.Crippling=3
							src.Grapple=0
							src.NoForcedWhiff=0
							src.IconLock='BLANK.dmi'
							src.HitSparkIcon='WolfFF.dmi'
							src.HitSparkX=0
							src.HitSparkY=0
							src.HitSparkTurns=1
							src.HitSparkSize=2
							usr.SetQueue(src)
							return
						if(usr.Secret=="Zombie")
							src.name="Death Grasp"
							src.DamageMult=1
							src.AccuracyMult=3
							src.KBAdd=0
							src.KBMult=1
							src.Cooldown=20
							src.HitMessage="grasps hold of their opponent with necrotic energy!"
							src.Scorching=0
							src.Freezing=0
							src.Paralyzing=0
							src.Toxic= 10
							src.Shearing = 15
							src.CursedWounds=1
							src.Combo=0
							src.Warp=0
							src.Rapid=0
							src.LifeSteal=0
							src.Crippling=5
							src.Grapple=1
							src.NoForcedWhiff=0
							src.IconLock='BLANK.dmi'
							src.HitSparkIcon='Hit Effect Wind.dmi'
							src.HitSparkX=-32
							src.HitSparkY=-32
							src.HitSparkTurns=1
							src.HitSparkSize=1
							usr.SetQueue(src)
							return

//IM APPROPRIATING THESE NAMES FOR THE GLORIOUS NEW CONTENT
			Meteor_Mash
				name="Meteor Mash"
				DamageMult=1
				AccuracyMult=2
				Duration=5
				Scorching=1
				Shattering=1
				KBAdd=1
				Cooldown=150
				ManaCost=10
				Combo=5
				HitSparkIcon='fevExplosion.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.2
				verb/Meteor_Mash()
					set category="Skills"
					usr.SetQueue(src)
			Steam_Driver
				name="Steam Driver"
				DamageMult=1
				AccuracyMult=2
				Duration=5
				Scorching=1
				Freezing=1
				KBAdd=1
				Cooldown=150
				ManaCost=10
				Combo=5
				HitSparkIcon='fevExplosion - Steam.dmi'
				HitSparkX=-32
				HitSparkY=-32
				verb/Steam_Driver()
					set category="Skills"
					usr.SetQueue(src)
			Crystal_Crumbling
				name="Crystal Crumbling"
				DamageMult=1
				AccuracyMult=2
				Duration=5
				Shattering=1
				Freezing=1
				KBAdd=1
				Cooldown=150
				ManaCost=10
				Combo=5
				PushOutIcon='SnowBurst2.dmi'
				PushOut=3
				PushOutWaves=1
				verb/Crystal_Crumbling()
					set category="Skills"
					usr.SetQueue(src)
			Cyclone_Kicks
				name="Cyclone Kicks"
				DamageMult=1
				AccuracyMult=2
				Duration=5
				Freezing=1
				Paralyzing=1
				KBAdd=1
				Cooldown=150
				ManaCost=10
				Combo=5
				PushOutIcon='fevKiaiG.dmi'
				PushOut=1
				PushOutWaves=1
				verb/Cyclone_Kicks()
					set category="Skills"
					usr.SetQueue(src)


//racial
			Blaze_Burst
				name="Blaze Burst"
				DamageMult=2
				AccuracyMult=2
				Duration=5
				Scorching=3
				KBAdd=5
				Cooldown=90
				ManaCost=5
				HitSparkIcon='fevExplosion.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.8
				verb/Blaze_Burst()
					set category="Skills"
					usr.SetQueue(src)
			Winter_Shock
				name="Winter Shock"
				DamageMult=2
				AccuracyMult=2
				Duration=5
				Freezing=3
				KBMult=2
				Cooldown=90
				ManaCost=5
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.1
				verb/Winter_Shock()
					set category="Skills"
					usr.SetQueue(src)
			Terra_Crack
				name="Terra Crack"
				DamageMult=2
				AccuracyMult=2
				Duration=5
				Shattering=3
				KBAdd=10
				Cooldown=90
				ManaCost=5
				PushOutIcon='DarkKiai.dmi'
				PushOutWaves=3
				PushOut=1
				HitSparkIcon='BLANK.dmi'
				verb/Terra_Crack()
					set category="Skills"
					usr.SetQueue(src)
			Aero_Slash
				name="Aero Slash"
				DamageMult=2
				AccuracyMult=2
				Duration=5
				Paralyzing=3
				KBMult=1.5
				Cooldown=90
				ManaCost=5
				HitSparkIcon='Slash - Power.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.8
				HitSparkTurns=1
				verb/Aero_Slash()
					set category="Skills"
					usr.SetQueue(src)


			//SHIT AINT USED
			Sharpnel_Scatter
				name="Shrapnel Scatter"
				DamageMult=1
				AccuracyMult=2
				Duration=5
				Shattering=1
				Paralyzing=1
				KBAdd=1
				Cooldown=150
				ManaCost=10
				Combo=5
				HitSparkIcon='Hit Effect Satsui.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1.4
				verb/Sharpnel_Scatter()
					set category="Skills"
					set name="Shrapnel Scatter"
					usr.SetQueue(src)
			Desert_Wind
				name="Desert Wind"
				DamageMult=1
				AccuracyMult=2
				Duration=5
				Scorching=1
				Paralyzing=1
				KBAdd=1
				Cooldown=150
				ManaCost=10
				Combo=5
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.3
				verb/Desert_Wind()
					set category="Skills"
					usr.SetQueue(src)

//Skill Tree

////UNARMED

//T1 - Damage mults range from 1.5 to 2.5
			Uppercut
				SkillCost=40
				Copyable=1
				HitMessage="delivers a vicious uppercut!!"
				DamageMult=2
				AccuracyMult=2
				Duration=5
				KBMult=0.00001
				Cooldown=30
				UnarmedOnly=1
				Launcher=2
				EnergyCost=1.5
				name="Uppercut"
				verb/Uppercut()
					set category="Skills"
					set name="Uppercut"
					usr.SetQueue(src)
			Ikkotsu
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Uppercut")
				LockOut=list("/obj/Skills/Queue/Showstopper", "/obj/Skills/Queue/Dempsey_Roll", "/obj/Skills/Queue/Corkscrew_Blow")
				HitMessage="delivers a destructive one handed strike!!"
				DamageMult=2.8
				AccuracyMult=2
				Dominator=1
				Duration=5
				KBAdd=10
				Launcher=1
				Cooldown=30
				UnarmedOnly=1
				EnergyCost=2
				name="Ikkotsu"
				verb/Ikkotsu()
					set category="Skills"
					set name="Ikkotsu"
					usr.SetQueue(src)
			Showstopper
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Uppercut")
				LockOut=list("/obj/Skills/Queue/Ikkotsu", "/obj/Skills/Queue/Dempsey_Roll", "/obj/Skills/Queue/Corkscrew_Blow")
				HitMessage="delivers a vicious uppercut!!"
				DamageMult=3
				AccuracyMult=2.5
				Stunner=2
				Launcher=2
				Duration=5
				KBMult=0.00001
				Cooldown=30
				UnarmedOnly=1
				EnergyCost=2
				name="Showstopper"
				verb/Showstopper()
					set category="Skills"
					set name="Showstopper"
					usr.SetQueue(src)
			Dempsey_Roll
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Uppercut")
				LockOut=list("/obj/Skills/Queue/Ikkotsu", "/obj/Skills/Queue/Showstopper", "/obj/Skills/Queue/Corkscrew_Blow")
				ActiveMessage="punches with precisely articulated strikes to create whirlwind-like pull!"
				name="Dempsey Roll"
				DamageMult=0.6
				AccuracyMult=3
				KBMult=0.00001
				KBAdd=1
				Duration=8
				Cooldown=30
				UnarmedOnly=1
				Combo=4
				Warp=3
				Stunner=2
				IconLock='dempsey.dmi'
				LockX=-16
				LockY=-16
				PushOut=1
				PushOutIcon='BLANK.dmi'
				EnergyCost=1
				verb/Dempsey_Roll()
					set category="Skills"
					set name="Dempsey Roll"
					usr.SetQueue(src)
			Corkscrew_Blow
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Uppercut")
				LockOut=list("/obj/Skills/Queue/Ikkotsu", "/obj/Skills/Queue/Showstopper", "/obj/Skills/Queue/Dempsey_Roll")
				ActiveMessage="strikes with cyclone power!"
				name="Corkscrew Blow"
				DamageMult=1.2
				AccuracyMult=3
				KBAdd=3
				Duration=10
				Cooldown=30
				UnarmedOnly=1
				IconLock='Corkscrew.dmi'
				MultiHit=3
				Warp=2
				EnergyCost=1
				verb/Corkscrew_Blow()
					set category="Skills"
					set name="Corkscrew Blow"
					usr.SetQueue(src)

			Axe_Kick
				SkillCost=40
				Copyable=1
				name="Axe Kick"//Skill name displayed in message.
				HitMessage="brings their heel down in a mighty axe kick!!"
				DamageMult=2
				AccuracyMult=2
				Duration=5
				SpeedStrike=2
				Cooldown=30
				UnarmedOnly=1
				EnergyCost=1.5
				verb/Axe_Kick()
					set category="Skills"
					set name="Axe Kick"//Verb name.
					usr.SetQueue(src)
			Kinshasa
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Axe_Kick")
				LockOut=list("/obj/Skills/Queue/Piston_Kick", "/obj/Skills/Queue/Pin", "/obj/Skills/Queue/Cripple")
				name="Kinshasa"//Skill name displayed in message.
				HitMessage="builds up speed and knees their target in the face!!"
				DamageMult=2.8
				AccuracyMult=3
				Duration=5
				SpeedStrike=4
				Cooldown=30
				KBAdd = 6
				UnarmedOnly=1
				EnergyCost=2.5
				verb/Kinshasa()
					set category="Skills"
					set name="Kinshasa"//Verb name.
					usr.SetQueue(src)
			Piston_Kick
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Axe_Kick")
				LockOut=list("/obj/Skills/Queue/Kinshasa", "/obj/Skills/Queue/Pin", "/obj/Skills/Queue/Cripple")
				name="Piston Kick"//Skill name displayed in message.
				HitMessage="launches a shattering front kick with their heel!"
				DamageMult=2.2
				AccuracyMult=2
				SpeedStrike=2
				Opener=1
				Duration=5
				Cooldown=30
				UnarmedOnly=1
				EnergyCost=2.5
				verb/Piston_Kick()
					set category="Skills"
					set name="Piston Kick"//Verb name.
					usr.SetQueue(src)
			Cripple
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Axe_Kick")
				LockOut=list("/obj/Skills/Queue/Pin", "/obj/Skills/Queue/Kinshasa", "/obj/Skills/Queue/Piston_Kick")
				DamageMult=2.8
				AccuracyMult=3
				Duration=5
				Cooldown=30
				Crippling=4
				SpeedStrike=2
				SweepStrike=1
				UnarmedOnly=1
				EnergyCost=2.5
				HitMessage="delivers a crippling strike!"
				verb/Cripple()
					set category="Skills"
					usr.SetQueue(src)
			Pin
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Queue/Axe_Kick")
				LockOut=list("/obj/Skills/Queue/Cripple", "/obj/Skills/Queue/Kinshasa", "/obj/Skills/Queue/Piston_Kick")
				DamageMult=4
				AccuracyMult=3
				Instinct=2
				Grapple=1
				KBMult=0.001
				Warp=3
				SpeedStrike=1
				UnarmedOnly=1
				Duration=5
				Cooldown=30
				EnergyCost=2.5
				HitMessage="performs a pinning maneuver!"
				verb/Pin()
					set category="Skills"
					usr.SetQueue(src)

//T2 is in Autohits.

//T3 is in Grapples.

//T4 - Damage mults range from 4 to 6.
			GET_DUNKED
				SkillCost=160
				Copyable=4
				name="GET DUNKED"
				DamageMult=6
				AccuracyMult=5
				Duration=5
				KBMult=0.00001
				PushOut=3
				PushOutWaves=2
				Finisher=1
				Dunker=1
				Warp=2
				Stunner=3
				UnarmedOnly=1
				EnergyCost=4
				Quaking=1
				Cooldown=120
				verb/GET_DUNKED()
					set category="Skills"
					set name="Get Dunked"
					usr.SetQueue(src)
			Soukotsu
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/Queue/GET_DUNKED")
				LockOut=list("/obj/Skills/Queue/Curbstomp", "/obj/Skills/Queue/Six_Grand_Openings", "/obj/Skills/Queue/Skullcrusher")
				name="Soukotsu"
				DamageMult=2.5
				AccuracyMult=2
				Duration=5
				KBAdd=10
				PushOut=3
				PushOutWaves=2
				InstantStrikes=2
				InstantStrikesDelay=1.5
				Finisher=1
				Warp=3
				Dunker=1
				Stunner=2
				Instinct=1
				UnarmedOnly=1
				EnergyCost=8
				Quaking=1
				Cooldown=120
				verb/Soukotsu()
					set category="Skills"
					set name="Soukotsu"
					usr.SetQueue(src)
			Curbstomp
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/Queue/GET_DUNKED")
				LockOut=list("/obj/Skills/Queue/Soukotsu", "/obj/Skills/Queue/Six_Grand_Openings", "/obj/Skills/Queue/Skullcrusher")
				name="Curbstomp"
				DamageMult=8
				AccuracyMult=2
				Duration=5
				KBMult=0.0001
				PushOut=5
				PushOutWaves=3
				Finisher=1
				Warp=1
				Dunker=2
				Stunner=2
				UnarmedOnly=1
				EnergyCost=4
				Quaking=4
				Cooldown=120
				verb/Curbstomp()
					set category="Skills"
					set name="Curbstomp"
					usr.SetQueue(src)
			Six_Grand_Openings
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/Queue/GET_DUNKED")
				LockOut=list("/obj/Skills/Queue/Skullcrusher", "/obj/Skills/Queue/Soukotsu", "/obj/Skills/Queue/Curbstomp")
				name="Six Grand Openings"
				HitMessage="delivers a graceful and crippling blow with their elbow!"
				DamageMult=7.5
				AccuracyMult=6
				Duration=5
				Counter=1
				NoWhiff=1
				Crippling=5
				Stunner=2
				Dunker=1
				Decider=1
				KBMult=0.0001
				Cooldown=120
				UnarmedOnly=1
				EnergyCost=5
				verb/Six_Grand_Openings()
					set category="Skills"
					usr.SetQueue(src)
			Skullcrusher
				SkillCost=160
				Copyable=5
				PreRequisite=list("/obj/Skills/Queue/GET_DUNKED")
				LockOut=list("/obj/Skills/Queue/Six_Grand_Openings", "/obj/Skills/Queue/Soukotsu", "/obj/Skills/Queue/Curbstomp")
				name="Skullcrusher"
				HitMessage="brings their elbow down with crushing might!"
				DamageMult=7
				InstantStrikes=2
				InstantStrikesDelay=1.5
				AccuracyMult=2
				Duration=5
				Stunner=4
				KBMult=0.0001
				Cooldown=120
				UnarmedOnly=1
				EnergyCost=4
				verb/Skullcrusher()
					set category="Skills"
					usr.SetQueue(src)

//T5 (Sig 1) - Damage mults are usually 5
			Aura_Punch
				SignatureTechnique=1
				ActiveMessage="begins concentrating power..."
				HitMessage="unleashes a devasatating punch!"
				DamageMult=12
				AccuracyMult=5
				KBMult=5
				Duration=6
				Instinct=2
				Delayer=0.25//add 1 damage mult every second that this is queued but hasnt been punched yet
				Warp=5
				Cooldown=150
				EnergyCost=5
				IconLock='CommandSparks.dmi'
				verb/Aura_Punch()
					set category="Skills"
					usr.SetQueue(src)
			The_Claw
				SignatureTechnique=1
				name="Claw Grip"
				HitMessage="grabs the opponent's face in a crushing grip!"
				DamageMult=11
				AccuracyMult=5
				KBMult=0.00001
				Duration=5
				Instinct=2
				Opener=1
				Warp=2
				Cooldown=150
				Grapple=1
				EnergyCost=5
				BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Brolic_Grip"
				verb/The_Claw()
					set category="Skills"
					usr.SetQueue(src)
			Nerve_Shot
				SignatureTechnique=1
				DamageMult=2
				AccuracyMult=10
				Duration=5
				Stunner=2
				Crippling=412
				Combo=5
				Rapid=1
				Cooldown=150
				Instinct=2
				UnarmedOnly=1
				EnergyCost=5
				HitMessage="confuses the opponent's senses with a volley of pressure point strikes!"
				verb/Nerve_Shot()
					set category="Skills"
					usr.SetQueue(src)
			Gale_Strike
				SignatureTechnique=1
				DamageMult=1.8//there is 0.5 damage mult 10 multihit on the gale itself
				AccuracyMult=5
				KBMult=0.00001
				Duration=5
				Projectile="/obj/Skills/Projectile/GaleStrikeProjectile"
				Cooldown=150
				Instinct=2
				EnergyCost=10
				verb/Gale_Strike()
					set category="Skills"
					usr.SetQueue(src)
			Volleyball_Fist
				SignatureTechnique=1
				UnarmedOnly=1
				DamageMult=3
				AccuracyMult=15
				KBMult=0.00001
				Stunner=1
				Instinct=2
				Warp=2
				HitStep=/obj/Skills/Queue/Volleyball_Fist2
				Duration=5
				Rapid=1
				Opener=1
				Cooldown=150
				EnergyCost=5
				HitMessage="staggers the opponent by sliding at their legs!"
				verb/Volleyball_Fist()
					set category="Skills"
					usr.SetQueue(src)
			Volleyball_Fist2
				UnarmedOnly=1
				DamageMult=4
				AccuracyMult=5
				KBMult=0.00001
				HitStep=/obj/Skills/Queue/Volleyball_Fist3
				Duration=5
				Quaking=3
				Warp=3
				Rapid=1
				Launcher=1
				EnergyCost=5
				HitMessage="launches their opponent in the air like a volleyball!"
			Volleyball_Fist3
				UnarmedOnly=1
				DamageMult=4
				Instinct=5
				AccuracyMult=5
				KBAdd=5
				Duration=5
				PushOut=3
				PushOutWaves=3
				Quaking=5
				Dunker=2
				EnergyCost=5
				HitMessage="violently spikes the opponent towards the ground!!!"

//T6 (Sig 2) - Damage mults are normally 7.5

			Meteor_Combination
				SignatureTechnique=2
				DamageMult=6
				AccuracyMult=10
				Duration=5
				KBMult=0.00001
				Cooldown=180
				Instinct=2
				Opener=1
				Stunner=3
				UnarmedOnly=1
				EnergyCost=5
				Quaking=5
				HitStep=/obj/Skills/Queue/Meteor_Combination2
				ActiveMessage="takes a starting position!"
				HitMessage="opens the opponent with a shattering elbow strike!"
				verb/Meteor_Combination()
					set category="Skills"
					usr.SetQueue(src)
			Meteor_Combination2
				HitMessage="follows up with a storm of kicks!"
				DamageMult=0.5
				AccuracyMult=5
				Duration=5
				KBMult=0.00001
				Instinct=3
				Combo=10
				UnarmedOnly=1
				Quaking=2
				EnergyCost=5
				HitStep=/obj/Skills/Queue/Meteor_Combination3
			Meteor_Combination3
				HitMessage="finishes with a murderous uppercut!"
				DamageMult=6
				AccuracyMult=10
				Duration=5
				KBAdd=10
				Instinct=4
				Decider=1
				Launcher=1
				UnarmedOnly=1
				Quaking=10
				EnergyCost=10

			Defiance
				SignatureTechnique=2
				HitMessage="defiantly slams their head into the opponent!!"
				DamageMult=15
				AccuracyMult=5
				Instinct=3
				Duration=5
				KBMult=3
				Cooldown=180
				Determinator=1
				Counter=1
				UnarmedOnly=1
				EnergyCost=10
				name="Defiance"
				verb/Defiance()
					set category="Skills"
					usr.SetQueue(src)

			Void_Tiger_Fist
				SignatureTechnique=2
				DamageMult=3.6
				AccuracyMult=5
				Warp=2
				Shearing=5
				Instinct=4
				Duration=5
				KBAdd=2
				PushOut=3
				PushOutWaves=2
				InstantStrikes=5
				InstantStrikesDelay=1
				Cooldown=180
				UnarmedOnly=1
				EnergyCost=10
				ActiveMessage="focuses a bubble of vacuum around their fist..."
				HitMessage="unleashes a vacuum burst that tears the opponent apart!"
				verb/Void_Tiger_Fist()
					set category="Skills"
					usr.SetQueue(src)

			Final_Revenger
				SignatureTechnique=2
				DamageMult=15
				AccuracyMult=5
				Determinator=1
				Duration=5
				PushOut=5
				PushOutWaves=5
				Quaking=20
				Instinct=4
				Stunner=3
				KBMult=0.00001
				Cooldown=180
				UnarmedOnly=1
				EnergyCost=10
				IconLock=1
				verb/Final_Revenger()
					set category="Skills"
					usr.SetQueue(src)

			Red_Hot_Hundred
				SignatureTechnique=2
				DamageMult=0.75
				AccuracyMult=5
				Warp=5
				KBAdd=1
				KBMult=0.00001
				Combo=25
				Rapid=1
				Instinct=2
				IconLock='Flaming_fists.dmi'
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				Duration=5
				Cooldown=180
				UnarmedOnly=1
				EnergyCost=10
				ActiveMessage="blurs forward with a storm of countless attacks!"
				verb/Red_Hot_Hundred()
					set category="Skills"
					usr.SetQueue(src)

			True_Kamehameha
				PreRequisite=list("/obj/Skills/Projectile/Beams/Big/Super_Kamehameha")
				SignatureTechnique=2
				UnarmedOnly=1
				DamageMult=12
				AccuracyMult=5
				Instinct=5
				HitStep=/obj/Skills/Queue/True_Kamehameha2
				Duration=5
				Cooldown=180
				Combo=2
				Warp=10
				KBAdd=10
				EnergyCost=10
				IconLock=1
				ActiveMessage="begins to charge a powerful attack while opening their target up with crushing strikes!"
				ComboHitMessages=list(1="yells: KA... ME...", 2="yells: HA... ME...")
				verb/True_Kamehameha()
					set category="Skills"
					usr.SetQueue(src)
			True_Kamehameha2
				UnarmedOnly=1
				DamageMult=5
				AccuracyMult=25
				Instinct=5
				Duration=3
				Warp=10
				HitMessage="yells: HAAAAAAAAAA!"
				Projectile="/obj/Skills/Projectile/Beams/Big/True_Kamehameha"
				ProjectileBeam=1

			Final_Shine
				PreRequisite=list("/obj/Skills/Projectile/Beams/Big/Final_Flash")
				SignatureTechnique=2
				UnarmedOnly=1
				DamageMult=12
				AccuracyMult=5
				Instinct=5
				HitStep=/obj/Skills/Queue/Final_Shine2
				Duration=5
				Cooldown=180
				Combo=2
				Warp=10
				KBAdd=10
				EnergyCost=10
				IconLock=1
				ActiveMessage="begins to charge a powerful attack while dominating their target with a rapid assault!"
				verb/Final_Shine()
					set category="Skills"
					usr.SetQueue(src)
			Final_Shine2
				UnarmedOnly=1
				DamageMult=5
				AccuracyMult=25
				Instinct=5
				Duration=3
				Warp=10
				Projectile="/obj/Skills/Projectile/Beams/Big/Final_Shine"
				ProjectileBeam=1

			Super_Dragon_Fist
				UnarmedOnly=1
				DamageMult=18
				AccuracyMult=10
				Duration=10
				KBMult=0.0001
				Cooldown=180
				UnarmedOnly=1
				Instinct=5
				Stunner=5
				Projectile="/obj/Skills/Projectile/Beams/Big/Super_Dragon_Beam"
				ProjectileBeam=1
				HitMessage="throws a crippling punch into the opponent's midsection!"
				ActiveMessage="is surrounded by the ki of a full fledged dragon!!"
				verb/Super_Dragon_Fist()
					set category="Skills"
					usr.SetQueue(src)
//T7 is always a style or buff.

////Spirit
//T1 is in Projectiles.

//T2 has damage mult 2 - 3.5
			Dancing_Lights
				SkillCost=80
				Copyable=2
				DamageMult=1.2
				AccuracyMult=3
				Duration=5
				Projectile="/obj/Skills/Projectile/DancingBlast"
				Cooldown=60
				Combo=4
				EnergyCost=2
				IconLock='DancingLight.dmi'
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				verb/Dancing_Lights()
					set category="Skills"
					usr.SetQueue(src)
			Light_Rush
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/Queue/Dancing_Lights")
				LockOut=list("/obj/Skills/Queue/Burst_Combination")
				DamageMult=1.2
				AccuracyMult=5
				Duration=5
				Combo=4
				Rapid=1
				Cooldown=60
				EnergyCost=10
				IconLock=1
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitStep=/obj/Skills/Queue/Light_Rush2
				verb/Light_Rush()
					set category="Skills"
					usr.SetQueue(src)
			Light_Rush2
				DamageMult=0.5
				AccuracyMult=25
				Duration=3
				Warp=10
				Projectile="/obj/Skills/Projectile/RushBlast"
			Burst_Combination
				name="Burst Combination"
				SkillCost=40
				Copyable=3
				PreRequisite=list("/obj/Skills/Queue/Dancing_Lights")
				LockOut=list("/obj/Skills/Queue/Light_Rush")
				DamageMult=0.8
				AccuracyMult=5
				Stunner=2
				Duration=5
				Combo=10
				Projectile="/obj/Skills/Projectile/BurstBlast"
				ProjectileCount=1
				Cooldown=60
				EnergyCost=10
				IconLock=1
				HitSparkIcon='Hit Effect Satsui.dmi'
				HitSparkX=-32
				HitSparkY=-32
				verb/Burst_Combination()
					set category="Skills"
					usr.SetQueue(src)

//SHIT AINT USED
			Counter_Cannon
				SkillCost=40
				Copyable=2
				PreRequisite=list("/obj/Skills/Projectile/Charge")
				LockOut=list("/obj/Skills/Projectile/Crash_Burst", "/obj/Skills/Projectile/Feint_Shot", "/obj/Skills/Projectile/Dragon_Nova")
				DamageMult=1
				AccuracyMult=1
				Duration=5
				Projectile="/obj/Skills/Projectile/Counter_Cannon_Shot"
				Cooldown=30
				EnergyCost=3
				IconLock='DancingLight.dmi'
				HitSparkIcon='Hit Effect Divine.dmi'
				HitSparkX=-32
				HitSparkY=-32
				ActiveMessage="takes a defensive stance while charging a blast!"
				verb/Counter_Cannon()
					set category="Skills"
					usr.SetQueue(src)

////Sword
//SHIT AINT USED
			Camelia_Dance
				SkillCost=20
				Copyable=2
				ActiveMessage="prepares a flurry of thrusts!"
				DamageMult=1.5
				AccuracyMult=2
				Duration=10
				Cooldown=60
				NeedsSword=1
				InstantStrikes=3
				InstantStrikesDelay=1
				EnergyCost=1
				verb/Camelia_Dance()
					set category="Skills"
					usr.SetQueue(src)

//T2
			//todo: remove
			SwallowReversal//dedname
			InfinityTrap//dedname

			Swallow_Reversal
				SkillCost=80
				Copyable=2
				ActiveMessage="enters a graceful stance!"
				DamageMult=1.4
				AccuracyMult=3
				KBMult=0.00001
				SpeedStrike=1
				InstantStrikes=3
				InstantStrikesDelay=0
				Warp=2
				Duration=5
				Cooldown=60
				NeedsSword=1
				EnergyCost=3
				verb/Swallow_Reversal()
					set category="Skills"
					usr.SetQueue(src)
			Infinity_Trap
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/Queue/Swallow_Reversal")
				LockOut=list("/obj/Skills/Queue/Willow_Dance", "/obj/Skills/Queue/Zero_Reversal", "/obj/Skills/Queue/Larch_Dance")
				ActiveMessage="enters a thoughtful stance!"
				DamageMult=1.1
				AccuracyMult=3
				KBMult=0.00001
				Stunner=3
				InstantStrikes=5
				InstantStrikesDelay=0
				Warp=2
				PushOut=1
				PushOutIcon='BLANK.dmi'
				Duration=5
				Cooldown=60
				NeedsSword=1
				EnergyCost=5
				HitSparkIcon='Slash - Zero.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.75
				HitSparkTurns=1
				verb/Infinity_Trap()
					set category="Skills"
					usr.SetQueue(src)
			Zero_Reversal
				SkillCost=80
				Copyable=3
				PreRequisite=list("/obj/Skills/Queue/Swallow_Reversal")
				LockOut=list("/obj/Skills/Queue/Willow_Dance", "/obj/Skills/Queue/Larch_Dance", "/obj/Skills/Queue/Infinity_Trap")
				ActiveMessage="enters a low stance!"
				DamageMult=3
				AccuracyMult=3
				KBMult=0.00001
				SpeedStrike=1
				SweepStrike=1
				Counter=1
				Warp=2
				Duration=5
				Cooldown=60
				NeedsSword=1
				EnergyCost=5
				HitSparkIcon='Slash - Black.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.5
				verb/Zero_Reversal()
					set category="Skills"
					usr.SetQueue(src)
			Willow_Dance
				SkillCost=80
				PreRequisite=list("/obj/Skills/Queue/Swallow_Reversal")
				LockOut=list("/obj/Skills/Queue/Larch_Dance", "/obj/Skills/Queue/Zero_Reversal", "/obj/Skills/Queue/Infinity_Trap")
				Copyable=3
				ActiveMessage="begins to move fluidly, countering incoming blows!"
				DamageMult=0.9
				AccuracyMult=3
				Duration=8
				Cooldown=60
				NeedsSword=1
				MultiHit=3
				InstantStrikes=2
				InstantStrikesDelay=1
				Counter=1
				EnergyCost=1
				verb/Willow_Dance()
					set category="Skills"
					usr.SetQueue(src)
			Larch_Dance
				SkillCost=80
				PreRequisite=list("/obj/Skills/Queue/Swallow_Reversal")
				LockOut=list("/obj/Skills/Queue/Willow_Dance", "/obj/Skills/Queue/Zero_Reversal", "/obj/Skills/Queue/Infinity_Trap")
				Copyable=3
				ActiveMessage="prepares a murderous chain of counterattacks!"
				DamageMult=1.1
				AccuracyMult=2
				Duration=5
				Cooldown=60
				NeedsSword=1
				InstantStrikes=5
				InstantStrikesDelay=1
				Counter=1
				EnergyCost=1
				verb/Larch_Dance()
					set category="Skills"
					usr.SetQueue(src)

//T3
			Run_Through
				NeedsSword=1
				SkillCost=120
				PreRequisite=list("/obj/Skills/Grapple/Sword/Impale")
				LockOut=list("/obj/Skills/Grapple/Sword/Eviscerate", "/obj/Skills/Grapple/Sword/Hacksaw", "/obj/Skills/Grapple/Sword/Form_Ataru")
				Copyable=3
				ActiveMessage="grips their weapon strongly!"
				HitMessage="runs the opponent through with their weapon!"
				DamageMult=1.5
				AccuracyMult=2.5
				Duration=5
				Warp=2
				KBMult=0.001
				Grapple=1
				GrabTrigger="/obj/Skills/Grapple/Sword/Blade_Drive"
				EnergyCost=1
				Cooldown=120
				SpeedStrike = 2
				verb/Run_Through()
					set category="Skills"
					usr.SetQueue(src)



//Knowledge
			Anesthetic_Strike
				ActiveMessage="prepares a needle!"
				HitMessage="jabs the needle and deploys the anesthetic into their target!"
				MissMessage="fumbles with the needle and wastes the anesthetic!"
				DamageMult=1
				AccuracyMult=1
				Duration=3
				Pacifying=60
				//doesn't get a verb because it is set from the tech item

//General app

			Ragna_Blade
				NoTransplant=1
				DamageMult=20
				AccuracyMult=10
				WeaponBreaker=100
				Shearing=10
				Crippling=10
				Instinct=4
				SpiritStrike=1
				PridefulRage=1
				MortalBlow=0.5
				IconLock='Ragna Blade.dmi'
				LockX=-32
				LockY=-32
				Duration=-1 //Durationless
				HitSparkIcon='Slash - Ragna.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=5
				ActiveMessage="draws upon the might of the primodial Chaos!"
				HitMessage="slashes through reality itself!"
				Cooldown=10800
				verb/Ragna_Blade()
					set category="Skills"
					src.MultiHit=round(usr.ManaAmount/100,1)
					src.ManaCost=max(80, usr.ManaAmount)
					usr.SetQueue(src)

////Sword
			Blade_Dance
				SignatureTechnique=1
				NeedsSword=1
				DamageMult=7
				AccuracyMult=5
				HitStep=/obj/Skills/Queue/Blade_Dance2
				Duration=5
				Rapid=1
				Instinct=1
				Cooldown=160
				EnergyCost=5
				HitSparkIcon='Slash - Future.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1.5
				HitMessage="chases their enemy down with a rush of powerful sword strikes!"
				verb/Blade_Dance()
					set category="Skills"
					usr.SetQueue(src)
			Blade_Dance2
				NeedsSword=1
				DamageMult=1
				SpeedStrike=2
				AccuracyMult=1
				HitStep=/obj/Skills/Queue/Blade_Dance2
				Duration=4
				Warp=1
				EnergyCost=3
				HitSparkIcon='Slash - Future.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
			Nirvana_Slash
				SignatureTechnique=1
				NeedsSword=1
				ActiveMessage="fulfils their existence in their blade."
				HitMessage="slashes at the opponent's body with their enlightened blade!"
				DamageMult=11
				AccuracyMult=10
				SpiritSword=1
				KBAdd=10
				Duration=5
				Instinct=2
				Cooldown=150
				IconLock='EyeFlame.dmi'
				HitSparkIcon='LightningPlasma.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=2
				HitSparkTurns=1
				EnergyCost=5
				verb/Nirvana_Slash()
					set category="Skills"
					usr.SetQueue(src)
			Bad_Luck
				name="Bad Luck"
				HybridStrike=1
				DamageMult=4
				AccuracyMult=2
				Duration=5
				Cooldown=30
				EnergyCost=3
				HitMessage="whacks their enemy with their instrument with a triumphant twang!!"
				verb/Bad_Luck()
					set category="Skills"
					usr.SetQueue(src)
			Soul_Tear_Storm
				SignatureTechnique=1
				name="Soul Tear Storm"
				ActiveMessage="begins to glow with ethereal darkness!"
				DamageMult=2.25
				AccuracyMult=5
				KBMult=0.00001
				Combo=5
				Warp=5
				SpiritHand=0.5
				SpiritSword=0.5
				Duration=5
				Cooldown=150
				NeedsSword=1
				HitSparkIcon='Slash - Vampire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				Instinct=2
				EnergyCost=10
				CursedWounds=1
				verb/Soul_Tear_Storm()
					set category="Skills"
					usr.SetQueue(src)
			Omnislash
				SignatureTechnique=2
				name="Omnislash"
				ActiveMessage="begins to glow with limitless bravery!"
				DamageMult=2
				AccuracyMult=10
				KBMult=0.00001
				KBAdd=2
				Combo=12
				Warp=3
				Duration=5
				Cooldown=-1 //once per fight
				Decider=1
				NeedsSword=1
				Instinct=4
				EnergyCost=5
				HitSparkIcon='Slash - Power.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=1
				HitSparkSize=1.1
				HitStep=/obj/Skills/Queue/Omnislash2
				verb/Omnislash()
					set category="Skills"
					usr.SetQueue(src)
			Omnislash2
				ActiveMessage="goes for the finishing blow!"
				DamageMult=12
				AccuracyMult=10
				KBMult=10
				Warp=5
				Duration=5
				Decider=1
				NeedsSword=1
				Instinct=4
				EnergyCost=10
				IconLock='UltraInstinctSpark.dmi'
				HitSparkIcon='Slash - Power.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkTurns=0
				HitSparkSize=2
				verb/Omnislash()
					set category="Skills"
					usr.SetQueue(src)


//Saga

///Saint Seiya
			Pegasus_Rolling_Crash//t1
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=9
				AccuracyMult=5
				Instinct=4
				Duration=5
				Warp=1
				Grapple=1
				KBMult=0.001
				GrabTrigger="/obj/Skills/Grapple/Lotus_Drop"
				IconLock=1
				HitSparkIcon='BLANK.dmi'
				HitMessage="flies their opponent high on the wings of Pegasus!"
				Cooldown=150
				verb/Pegasus_Rolling_Crash()
					set category="Skills"
					usr.SetQueue(src)
			Rising_Dragon_Fist//t5
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=11
				AccuracyMult=5
				Instinct=4
				KBAdd=10
				Duration=5
				Dominator=1
				IconLock=1
				RozanEffect=2
				HitMessage="unleashes the power of the Dragon with an overpowering uppercut!"
				Cooldown=150
				verb/Rising_Dragon_Fist()
					set category="Skills"
					set name="Rozan Shoryu Ha"
					usr.SetQueue(src)
			Thunder_Wave
				DamageMult=2
				Instinct=3
				Launcher=1
				Paralyzing=10
				AccuracyMult=10
				KBAdd=3
				InstantStrikes=10
				InstantStrikesDelay=1.5
				PrecisionStrike=500
				Duration=5
				IconLock=1
				HitSparkIcon='Slash - Zero.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=2
				HitSparkTurns=1
				Cooldown=150
				ActiveMessage="sends Andromeda's shackles for an endless pursuit after their target!"
				verb/Thunder_Wave()
					set category="Skills"
					usr.SetQueue(src)
			Phoenix_Demon_Illusion_Strike
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=4.5
				AccuracyMult=10
				Instinct=4
				Duration=5
				Warp=10
				Stunner=6
				Crippling=5
				BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Demon_Illusion"
				Cooldown=-1
				IconLock=1
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.5
				HitMessage="scrambles the opponent's mind with the power of Phoenix!"
				verb/Phoenix_Demon_Illusion_Strike()
					set category="Skills"
					set name="Houou Genmaken"
					usr.SetQueue(src)


////Gold Cloth
			Demon_Emperor_Fist
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=4.5
				AccuracyMult=10
				Instinct=4
				Duration=5
				PrecisionStrike=10
				BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Demon_Grasp"
				Cooldown=-1
				IconLock=1
				HitSparkIcon='Hit Effect Satsui.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.5
				HitMessage="forces their opponent to obey them with the Demon Emperor Fist!"
				verb/Demon_Emperor_Fist()
					set category="Skills"
					set name="Genrou Maou Ken"
					usr.SetQueue(src)
			Acubens
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=9
				AccuracyMult=10
				Instinct=5
				Duration=3
				Counter=1
				Warp=1
				Grapple=1
				KBMult=0.001
				GrabTrigger="/obj/Skills/Grapple/Sword/Hacksaw/Cancer_Snap"
				IconLock=1
				HitSparkIcon='BLANK.dmi'
				HitMessage="snaps the opponent in half with their legs emulating Cancer pincers!"
				Cooldown=150
				verb/Acubens()
					set category="Skills"
					usr.SetQueue(src)
			Lightning_Plasma_Strike
				UnarmedOnly=1
				CosmoPowered=1
				GodPowered=0.25
				DamageMult=0.75
				InstantStrikes=20
				InstantStrikesDelay=1
				AccuracyMult=10
				Instinct=5
				Duration=5
				PrecisionStrike=10
				Cooldown=-1
				HybridStrike=1
				KBAdd=1
				IconLock=1
				HitSparkIcon='LightningPlasma.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.3
				HitSparkTurns=1
				HitSparkDispersion=32
				ActiveMessage="is surrounded by roar of thunder!"
				HitMessage="tears their opponent apart with golden fangs of light!"
				verb/Lightning_Plasma_Strike()
					set category="Skills"
					set name="Lightning Plasma (Strike)"
					if(usr.SagaLevel<7 && usr.Health>15 && !usr.InjuryAnnounce)
						usr << "You can't use this technique except when in a dire pinch!"
						return
					usr.SetQueue(src)
			Six_Transmigrations
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=15
				AccuracyMult=10
				Instinct=4
				Duration=5
				PrecisionStrike=5
				Cooldown=-1
				Launcher=1
				WarpAway=2
				IconLock=1
				PushOutIcon='fevKiaiDS.dmi'
				PushOutWaves=3
				PushOut=5
				HitSparkIcon='BLANK.dmi'
				ActiveMessage="is surrounded by an aura of absolute tranquility!"
				HitMessage="thrusts their opponent through six realms of reality!"
				verb/Six_Transmigrations()
					set category="Skills"
					set name="Rikudou Rinne"
					usr.SetQueue(src)
			Rising_Dragon_Lord
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=11
				AccuracyMult=10
				Instinct=4
				KBAdd=20
				Duration=5
				Warp=1
				Launcher=1
				Finisher=1
				Dominator=1
				IconLock=1
				RozanEffect=4
				HitMessage="unleashes the power of the Dragon with an overpowering uppercut!"
				Cooldown=150
				verb/Rising_Dragon_Lord()
					set category="Skills"
					set name="Rozan Shoryu Ha"
					usr.SetQueue(src)
			Antares
				UnarmedOnly=1
				CosmoPowered=1
				Warp=5
				DamageMult=13
				AccuracyMult=5
				Instinct=4
				Duration=5
				Dominator=1
				Stunner=3
				KBMult=0.00001
				Projectile="/obj/Skills/Projectile/Scarlet_Needle"
				PushOutIcon='KenShockwaveBloodlust.dmi'
				PushOutWaves=3
				PushOut=1
				HitSparkIcon='Hit Effect Vampire.dmi'
				ActiveMessage="raises their sting to execute a sure kill technique!"
				Cooldown=-1
				verb/Antares()
					set category="Skills"
					src.MortalBlow=(usr.Target.SenseRobbed*0.2)
					usr.SetQueue(src)
			Jumping_Stone
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=11
				AccuracyMult=10
				Instinct=5
				Duration=3
				Counter=1
				Grapple=1
				KBMult=0.001
				GrabTrigger="/obj/Skills/Grapple/Lotus_Drop"
				IconLock=1
				HitSparkIcon='BLANK.dmi'
				HitMessage="counters the opponent with the swift agility of Capricorn!"
				Cooldown=150
				verb/Jumping_Stone()
					set category="Skills"
					usr.SetQueue(src)
			Piranhan_Rose
				UnarmedOnly=1
				CosmoPowered=1
				DamageMult=0.85
				KBAdd=1
				AccuracyMult=10
				Instinct=4
				Duration=5
				PrecisionStrike=10
				InstantStrikes=10
				InstantStrikesDelay=2
				PridefulRage=1
				HitSparkIcon='fevExplosion - Hellfire.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.3
				ActiveMessage="grasps a handful of pitch-black roses..."
				HitMessage="throws the black roses which eat away at everything they touch!"
				Cooldown=150
				verb/Piranhan_Rose()
					set category="Skills"
					usr.SetQueue(src)
////KoB
			DrillKnee
				ActiveMessage="forms a drill around their knee!"
				HitMessage="drives the drill into their opponent!"
				SBuffNeeded="Broken Brave"
				DamageMult=12
				AccuracyMult=5
				Instinct=1
				Duration=5
				KBMult=0.00001
				Cooldown=150
				Decider=1
				ShoryukenEffect=2
				Quaking=5
				PushOut=5
				PushOutWaves=3
				PushOutIcon='KenShockwaveLegend.dmi'
				verb/Drill_Knee()
					set category="Skills"
					if(usr.SpecialBuff)
						if(usr.SpecialBuff.BuffName!="Genesic Brave"&&src.SBuffNeeded!="Broken Brave")
							src.SBuffNeeded="Broken Brave"
						else if(usr.SpecialBuff.BuffName=="Genesic Brave")
							src.SBuffNeeded="Genesic Brave"
					usr.SetQueue(src)
////Ansatsuken
			Shoryuken
				StyleNeeded="Ansatsuken"
				AccuracyMult=10
				Launcher=3
				Duration=5
				Shattering = 2
				Cooldown=40
				proc/resetVars()
					Launcher=initial(Launcher)
					Duration=initial(Duration)
					Cooldown=initial(Cooldown)
					ManaCost=initial(ManaCost)
					ShoryukenEffect=initial(ShoryukenEffect)
				proc/activate(mob/player)
					ManaCost = 0
					Launcher=2
					var/sagaLevel = player.SagaLevel
					var/damage = clamp(1.8*(sagaLevel/2), 1.8, 7)
					var/path = player.AnsatsukenPath == "Shoryuken" ? 1 : 0
					var/manaCost = 35 // how much u need for ex
					var/cooldown = 40
					var/hitMessage = "strikes their opponent into the air with a fearsome uppercut!!"
					ShoryukenEffect=1
					Shattering = 1.5 * sagaLevel
					if(path)
						manaCost -= 10
						cooldown -= 15
						damage =  clamp(2*(sagaLevel/2), 2, 8)
						hitMessage = "strikes their opponent into the air with a fearsome uppercut!!"
					if(player.AnsatsukenAscension=="Satsui")
						Shattering *= 1.25
						GoshoryukenEffect=1
					if(player.ManaAmount>=manaCost && sagaLevel >= 2)
						ManaCost = manaCost
						ShoryukenEffect=2
						Launcher=6
						hitMessage = "unleashes the power of the Dragon with an overpowering uppercut!"
						if(path)
							damage =  clamp(4*(sagaLevel/2), 4, 16)
						else
							damage = clamp(3*(sagaLevel/2), 3, 12)

					DamageMult = damage
					HitMessage = hitMessage
					Cooldown = cooldown
				verb/Shoryuken()
					set category="Skills"
					resetVars()
					activate(usr)
					usr.SetQueue(src)

			Shin_Shoryuken
				StyleNeeded="Ansatsuken"
				HitMessage="shouts '<b>SHIN...</b>' as they strike their opponent with a rising blow!!!"
				DamageMult=16
				AccuracyMult=10
				KBMult=0.00001
				Duration=5
				Cooldown=180
				PushOut=3
				AllOutAttack=1
				ManaCost=100
				Instinct=4
				Stunner=3
				Rapid=1
				HitStep=/obj/Skills/Queue/Shin_Shoryuken2
				verb/Shin_Shoryuken()
					set category="Skills"
					set name="Shin-Shoryuken"
					if(usr.AnsatsukenAscension=="Satsui")
						src.HitMessage="shouts '<b>METSU...</b>' as they strike their opponent with a rising blow!!!"
						src.HitStep=/obj/Skills/Queue/Metsu_Shoryuken2
					usr.SetQueue(src)
			Shin_Shoryuken2
				StyleNeeded="Ansatsuken"
				HitMessage="shouts '<b>SHORYUKEN!</b>' as they spike their opponent into the heavens with a divine uppercut!!!"
				DamageMult=5
				AccuracyMult=10
				KBMult=0.00001
				Duration=5
				Warp=5
				Instinct=4
				ShoryukenEffect=2
			Metsu_Shoryuken2
				StyleNeeded="Ansatsuken"
				HitMessage="shouts '<b>SHORYUKEN!</b>' as they spike their opponent into the heavens with a divine uppercut!!!"
				DamageMult=5
				AccuracyMult=10
				KBMult=0.00001
				Duration=5
				Warp=5
				Instinct=4
				GoshoryukenEffect=2

			Messatsu_Goshoryu
				GoshoryukenEffect=0.75
				Duration=5
				Warp=5
				Instinct=4
				DamageMult=7.5
				AccuracyMult=10
				KBMult=0.00001
				KBAdd=1
				ManaCost=50
				Stunner=4
				Counter=1
				Rapid=1
				IconLock='BijuuInitial.dmi'
				IconLockUnder=1
				LockX=-32
				LockY=-32
				HitStep=/obj/Skills/Queue/Messatsu_Goshoryu2
				verb/Messatsu_Goshoryu()
					set category="Skills"
					usr.SetQueue(src)
			Messatsu_Goshoryu2
				GoshoryukenEffect=1
				Duration=5
				Warp=5
				Instinct=4
				DamageMult=3
				AccuracyMult=10
				KBMult=0.00001
				KBAdd=1
				Rapid=1
				HitStep=/obj/Skills/Queue/Messatsu_Goshoryu3
			Messatsu_Goshoryu3
				DamageMult=7.5
				GoshoryukenEffect=2
				Duration=5
				Warp=5
				Instinct=4
				DamageMult=7.5
				AccuracyMult=10
				KBMult=0.00001

////Eight Gates
			Front_Lotus
				GateNeeded=1
				UnarmedOnly=1
				DamageMult=9
				AccuracyMult=10
				Stunner=3
				Instinct=4
				Duration=5
				Cooldown=150
				Warp=10
				KBMult=0.001
				Grapple=1
				GrabTrigger="/obj/Skills/Grapple/Lotus_Drop"
				HitMessage="kicks the opponent in the air before initiating a suicidal drop!"
				verb/Front_Lotus()
					set category="Skills"
					usr.SetQueue(src)
			Reverse_Lotus
				GateNeeded=3
				UnarmedOnly=1
				DamageMult=7
				AccuracyMult=10
				Stunner=3
				Instinct=4
				HitStep=/obj/Skills/Queue/Reverse_Lotus2
				Duration=5
				Cooldown=180
				Warp=10
				HitMessage="stuns the opponent with a precise blow; an opening!"
				verb/Reverse_Lotus()
					set category="Skills"
					usr.SetQueue(src)
			Reverse_Lotus2
				GateNeeded=4
				UnarmedOnly=1
				DamageMult=3
				AccuracyMult=1
				Combo=3
				KBAdd=3
				HitStep=/obj/Skills/Queue/Reverse_Lotus3
				MissStep=/obj/Skills/Queue/Reverse_Lotus3
				Step=/obj/Skills/Queue/Reverse_Lotus3
				Duration=5
				Quaking=2
				Warp=10
				HitMessage="tosses the opponent around with a flurry of crushing strikes!"
			Reverse_Lotus3
				GateNeeded=5
				UnarmedOnly=1
				DamageMult=3
				Instinct=4
				AccuracyMult=5
				Duration=5
				PushOut=5
				Quaking=5
				Warp=10
				SpecialEffect="Smash"
				HitMessage="finishes the opponent with a shattering punch!!!"
			Morning_Peacock
				UnarmedOnly=1
				ActiveMessage="radiates burning vigor!"
				HitMessage="expresses their youth with a firestorm of strikes!!!!"
				DamageMult=0.6
				AccuracyMult=10
				KBMult=0.00001
				Launcher=3
				Duration=5
				Instinct=2
				Combo=20
				Finisher=1
				HitStep=/obj/Skills/Queue/GET_DUNKED
				Projectile="/obj/Skills/Projectile/AsaKujaku"
				ProjectileCount=1
				Warp=3
				GateNeeded=6
				Cooldown=-1
				IconLock='Flaming_fists.dmi'
				HitSparkIcon='fevExplosion.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=0.3
				verb/Morning_Peacock()
					set category="Skills"
					usr.SetQueue(src)

///Hiten
			JawStrike//t1
				name="Ryushosen"
				StyleNeeded="Hiten Mitsurugi"
				DamageMult=3.8
				AccuracyMult=5
				SpeedStrike=2
				KBMult=0.0001
				Launcher=3
				Rapid=1
				Duration=5
				Cooldown=30
				EnergyCost=2
				HitMessage="strikes their opponent in the jaw with the flat of their sword!"
				verb/Ryushosen()
					set category="Skills"
					usr.SetQueue(src)
			FallingBlade//t1
				name="Ryutsuisen"
				StyleNeeded="Hiten Mitsurugi"
				DamageMult=3.4
				AccuracyMult=5
				SpeedStrike=2
				Dunker=2
				Rapid=1
				Duration=5
				Cooldown=30
				EnergyCost=2
				HitMessage="jumps up and brings their blade down to add momentum to their strike!"
				verb/Ryutsuisen()
					set category="Skills"
					usr.SetQueue(src)
			Twin_Dragon_Slash
				name="Souryusen"
				StyleNeeded="Hiten Mitsurugi"
				DamageMult=7
				AccuracyMult=7
				KBMult=0.0001
				SpeedStrike=2
				Duration=5
				Instinct=3
				Cooldown=120
				Rapid=1
				EnergyCost=5
				HitMessage="strikes with their blade faster than the eye can see!"
				HitStep=/obj/Skills/Queue/Sheath_Strike
				MissStep=/obj/Skills/Queue/Sheath_Strike
				verb/Souryusen()
					set category="Skills"
					usr.SetQueue(src)
			Sheath_Strike
				HitMessage="whips their sheath to follow up with their blade!"
				DamageMult=6
				AccuracyMult=7
				KBMult=2
				SpeedStrike=2
				Warp=3
				Shattering=5
				Stunner=2
				Duration=5
				NeedsSword=1
				Instinct=4
				Rapid=1
				HitSparkIcon='Hit Effect.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=1.5
			Nine_Dragons_Strike
				name="Kuzuryusen"
				StyleNeeded="Hiten Mitsurugi"
				DamageMult=1.5
				AccuracyMult=10
				KBMult=0.00001
				SpeedStrike=6
				InstantStrikes=9
				InstantStrikesDelay=1
				//do the combo message thing
				Warp=10
				Duration=20
				Finisher=1
				Cooldown=-1
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=4
				HitSparkDispersion=1
				PushOut=1
				Rapid=1
				PushOutIcon='BLANK.dmi'
				Instinct=4
				EnergyCost=5
				verb/Kuzuryusen()
					set category="Skills"
					usr.SetQueue(src)
			Heavenly_Dragon_Flash
				name="Amakakeru Ryuu no Hirameki"
				StyleNeeded="Hiten Mitsurugi"
				Duration=8
				DamageMult=8
				SpeedStrike=10
				AccuracyMult=1
				KBMult=0.00001
				Warp=10
				Instinct=4
				DrawIn=4
				Determinator=1
				Finisher=1
				Rapid=1
				Counter=1
				NoWhiff=1
				Cooldown=-1
				HitSparkIcon='Slash - Power.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=2
				PushOut=5
				AllOutAttack=1
				PushOutIcon='BLANK.dmi'
				HitStep=/obj/Skills/Queue/Heavenly_Dragon_Claw
				MissStep=/obj/Skills/Queue/Heavenly_Dragon_Claw
				ActiveMessage="grips the handle of their blade tightly!"
				HitMessage="utilizes a stutter-step to surpass godspeed with a single blow!"
				MissMessage="generates a powerful vacuum as their slash is blocked, drawing the opponent in!!!"
				verb/Amakakeru_Ryuu_no_Hirameki()
					set category="Skills"
					usr.SetQueue(src)
			Heavenly_Dragon_Claw
				StyleNeeded="Hiten Mitsurugi"
				Duration=10
				DamageMult=8 // but gimp damage since u will be doing 3x
				SpeedStrike=10 // p much get all ur speed
				AccuracyMult=20
				KBAdd=10
				Warp=10
				Instinct=10
				Quaking=10
				Rapid=1
				Counter=1
				NoWhiff=1
				Determinator=1
				Decider=1
				Finisher=1
				HitSparkIcon='Slash - Power.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=3
				HitMessage="throws all of their momentum into a centrifugal force-powered finishing blow!!!"
////Keyblades
			GhostDriveCombo
				DamageMult=0.5
				AccuracyMult=4
				Instinct=4
				KBMult=0.00001
				Combo=10
				Duration=5
				//no verb because it is set from melee
////Weapon Soul
			Holy_Blade
				ActiveMessage="is wrapped in holy force!!"
				HitMessage="lets out a shout as they unleash a peerless slash!!"
				AccuracyMult=5
				Instinct=4
				DamageMult=8
				KBMult=0.00001
				Cooldown=150
				Projectile="/obj/Skills/Projectile/Weapon_Soul/Holy_Slash"
				Duration=5
				NeedsSword=1
				IconLock='HolyBladeElec.dmi'
				verb/Holy_Blade()
					set category="Skills"
					usr.SetQueue(src)
			Darkness_Blade
				ActiveMessage="is wrapped in dark force!!"
				HitMessage="lets out a shout as they unleash a destructive slash!!"
				AccuracyMult=5
				Instinct=4
				DamageMult=8
				KBMult=0.00001
				Cooldown=150
				Projectile="/obj/Skills/Projectile/Weapon_Soul/Darkness_Slash"
				Duration=5
				NeedsSword=1
				IconLock='DarkShock.dmi'
				verb/Darkness_Blade()
					set category="Skills"
					usr.SetQueue(src)

// NEW QUEUES
//* * */
// Aura_Punch
// 				SignatureTechnique=1
// 				ActiveMessage="begins concentrating power..."
// 				HitMessage="unleashes a devasatating punch!"
// 				DamageMult=2.5
// 				AccuracyMult=5
// 				KBMult=5
// 				Duration=5
// 				Instinct=2
// 				Delayer=1//add 1 damage mult every second that this is queued but hasnt been punched yet
// 				Warp=5
// 				Cooldown=150
// 				EnergyCost=5
// 				IconLock='CommandSparks.dmi'
// 				verb/Aura_Punch()
// 					set category="Skills"
// 					usr.SetQueue(src)
			Rasengan
				ActiveMessage="forms a ball of chakra in their hand!"
				HitMessage="slams their opponent with a ball of chakra!"
				AccuracyMult=5
				SignatureTechnique=1
				Paralyzing=1
				KBAdd = 2
				Dunker = 1
				InstantStrikes = 5
				EnergyCost = 6
				Cooldown = 60
				DamageMult = 1.5
				Duration = 5
				KBMult = 1.15
				Shearing=1
				IconLock = 'Rasengan_DBR.dmi'
				HitSparkIcon = 'Hit Effect Oath.dmi'
				HitSparkX = -32
				HitSparkY = -32
				HitSparkSize = 1.5
				verb/Rasengan()
					set category="Skills"
					usr.SetQueue(src)
			Oodama_Rasengan
				ActiveMessage="forms a massive ball of chakra in their hand!"
				HitMessage="slams their opponent with a massive ball of chakra!"
				AccuracyMult=5
				SignatureTechnique=1
				Paralyzing=1
				KBAdd = 4
				Dunker = 1
				InstantStrikes = 5
				EnergyCost = 6
				ManaCost = 15
				Cooldown = 120
				DamageMult = 2.5
				Delayer=0.5
				Duration = 6
				KBMult = 1.5
				Shearing=3
				IconLock = 'Rasengan_DBR.dmi'
				HitSparkIcon = 'Hit Effect Oath.dmi'
				HitSparkX = -32
				HitSparkY = -32
				HitSparkSize = 1.5
				verb/Oodama_Rasengan()
					set category="Skills"
					usr.SetQueue(src)


//Cybernetics and enchantment
			Gear
				Pile_Bunker
					DamageMult=9
					AccuracyMult=5
					HybridStrike=0.5
					SpiritHand=1
					Steady=5
					Duration=10
					PushOut=2
					Explosive=2
					HitSparkIcon='Hit Effect Ripple.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkSize=2
					KBAdd=10
					KBMult=2
					Shattering=10
					Crippling=3
					Cooldown=180
					ActiveMessage="deploys a massive metal spike..."
					HitMessage="drives their devastating Pile Bunker forward!"
					verb/Pile_Bunker()
						set category="Skills"
						usr.SetQueue(src)
				Power_Fist
					NoSword=1
					DamageMult=8
					AccuracyMult=5
					Duration=10
					PushOut=4
					HitSparkIcon='Hit Effect Ripple.dmi'
					HitSparkX=-32
					HitSparkY=-32
					HitSparkSize=1.25
					KBAdd=10
					KBMult=2
					Cooldown=60
					ActiveMessage="activates their Power Fist; everyone's in for some pain!"
					HitMessage="discharges the round in their Power Fist!!"
					verb/Power_Fist()
						set category="Skills"
						usr.SetQueue(src)
				Power_Claw
					DamageMult=1.25
					HybridStrike=0.5
					AccuracyMult=2
					Cooldown=20
					Grapple=1
					KBMult=0.001
					GrabTrigger=0.5
					Duration=25
					IconLock='PowerClawDeployed.dmi'
					ActiveMessage="boots up their mechanical claw!"
					HitMessage="crushes their opponent with their Power Claw!"
					verb/Power_Claw()
						set category="Skills"
						usr.SetQueue(src)
				Hook_Grip_Claw
					DamageMult=5
					HybridStrike=0.5
					AccuracyMult=1
					Cooldown=120
					Grapple=1
					KBMult=0.001
					PrecisionStrike=5
					Duration=25
					IconLock='PowerClawDeployed.dmi'
					ActiveMessage="activates the hook shot mechanism in their claw..."
					HitMessage="stretches their mechanical appendage to grasp their foe!"
					verb/Hook_Grip_Claw()
						set category="Skills"
						usr.SetQueue(src)
				Integrated
					Integrated=1
					Integrated_Pile_Bunker
						DamageMult=9
						AccuracyMult=4
						HybridStrike=0.5
						SpiritHand=1
						Steady=5
						Duration=10
						PushOut=2
						Explosive=2
						HitSparkIcon='Hit Effect Ripple.dmi'
						HitSparkX=-32
						HitSparkY=-32
						HitSparkSize=2
						KBAdd=10
						KBMult=2
						Shattering=10
						Crippling=3
						Cooldown=180
						ActiveMessage="deploys a massive metal spike..."
						HitMessage="drives their devastating Pile Bunker forward!"
						verb/Pile_Bunker()
							set category="Skills"
							usr.SetQueue(src)
					Integrated_Power_Fist
						NoSword=1
						SpiritHand=1
						HybridStrike=0.5
						Steady=5
						DamageMult=3.5
						AccuracyMult=5
						Duration=10
						PushOut=4
						HitSparkIcon='Hit Effect Ripple.dmi'
						HitSparkX=-32
						HitSparkY=-32
						HitSparkSize=1.25
						KBAdd=10
						KBMult=2
						PureDamage=5
						Cooldown=180
						ActiveMessage="activates their Power Fist; everyone's in for some pain!"
						HitMessage="discharges the round in their Power Fist!!"
						verb/Power_Fist()
							set category="Skills"
							usr.SetQueue(src)
					Integrated_Power_Claw
						DamageMult=1.25
						HybridStrike=0.5
						AccuracyMult=2
						Cooldown=20
						Grapple=1
						KBMult=0.001
						GrabTrigger=0.5
						Duration=25
						IconLock='PowerClawDeployed.dmi'
						ActiveMessage="boots up their mechanical hand!"
						HitMessage="crushes their opponent with their Power Claw!"
						verb/Power_Claw()
							set category="Skills"
							usr.SetQueue(src)
					Integrated_Hook_Grip_Claw
						DamageMult=5
						HybridStrike=0.5
						AccuracyMult=1
						Cooldown=20
						Grapple=1
						KBMult=0.001
						PrecisionStrike=5
						Duration=25
						IconLock='PowerClawDeployed.dmi'
						ActiveMessage="activates the hook shot mechanism in their hand..."
						HitMessage="stretches their mechanical appendage to grasp their foe!"
						verb/Hook_Grip_Claw()
							set category="Skills"
							usr.SetQueue(src)
////Cybernetics
			Cyberize
				Taser_Strike
					name="Taser Strike"
					DamageMult=4
					AccuracyMult=5
					Duration=6
					Stunner=4
					KBMult=0.1
					Cooldown=60
					ManaCost=2
					ActiveMessage="builds up a stunning charge..."
					HitMessage="delivers an electrified strike!!"
					verb/Taser_Strike()
						set category="Skills"
						usr.SetQueue(src)
////Enchantment
			Megiddo
				ActiveMessage="builds up an enormous amount of magnetism!!"
				HitMessage="lets out a scream as a meteor falls from the heavens towards their enemy!!"
				KBMult=0.00001
				AccuracyMult=10
				DamageMult=8
				Instinct=4
				Cooldown=300
				Projectile="/obj/Skills/Projectile/MegiddoMeteor"
				Duration=5
				EnergyCost=10
				PushOut=5
				PushOutWaves=5
				PushOutIcon='KenShockwaveLegend.dmi'
				verb/Megiddo()
					set category="Skills"
					usr.SetQueue(src)
			KokujinYukikaze
				NoTransplant=1
				name="Void Formation: Snow Wind"
				ActiveMessage="enters a peerless stance!"
				HitMessage="rends the opponent apart with <b>Kokujin: YUKIKAZE</b>!"
				DamageMult=4.5
				AccuracyMult=5
				Counter=1
				Warp=2
				Duration=5
				Cooldown=60
				NeedsSword=1
				HitSparkIcon='Slash - Power.dmi'
				HitSparkX=-32
				HitSparkY=-32
				HitSparkSize=4
				verb/KokujinYukikaze()
					set category="Skills"
					set name="Void Formation: Snow Wind"
					usr.SetQueue(src)
			ChainRevolver
				NoTransplant=1
				name="Chain Revolver"
				ActiveMessage="begins to dance around their opponents in a display of graceful gun kata!"
				DamageMult=2.5
				AccuracyMult=2
				Duration=10
				Cooldown=60
				Warp=2
				MultiHit=3
				SpiritStrike=1
				HitSparkIcon='Hit Effect Ripple.dmi'
				HitSparkX=-32
				HitSparkY=-32
				verb/ChainRevolver()
					set category="Skills"
					set name="Chain Revolver"
					usr.SetQueue(src)




mob
	proc
		SetQueue(var/obj/Skills/Queue/Q)
			if(Q.Using)
				return//Can't use if on cooldown.
			if(Q.StanceNeeded)
				if(src.StanceActive!=Q.StanceNeeded)
					src << "You have to be in [Q.StanceNeeded] stance to use this!"
					return
			if(Q.StyleNeeded)
				if(src.StyleActive!=Q.StyleNeeded)
					src << "You have to be using [Q.StyleNeeded] style to use this!"
					return
			if(Q.ABuffNeeded)
				if(!src.ActiveBuff||src.ActiveBuff.BuffName!=Q.ABuffNeeded)
					src << "You have to be in [Q.ABuffNeeded] state!"
					return
			if(Q.SBuffNeeded)
				if(!src.SpecialBuff||src.SpecialBuff.BuffName!=Q.SBuffNeeded)
					src << "You have to be in [Q.SBuffNeeded] state!"
					return

			if(Q.GateNeeded)
				if(!src.CheckActive("Eight Gates"))
					src << "You need to open your Eight Gates to use [Q]!"
					return
				if(src.GatesActive<Q.GateNeeded)
					if(SagaLevel>=Q.GateNeeded&&Q.GateNeeded!=8)
						var/difference = Q.GateNeeded-src.GatesActive
						for(var/x in 1 to difference)
							ActiveBuff:handleGates(usr, TRUE)
					else
						src << "You have to open at least Gate [Q.GateNeeded] to use this skill!"
						return
			if(Q.MagicNeeded&&!src.HasLimitlessMagic())
				if(src.HasMechanized()&&src.HasLimitlessMagic()!=1)
					src << "You lack the ability to use magic!"
					return
				if(Q.Copyable>=3||!Q.Copyable)
					if(src.Saga!="Persona"&&src.Saga!="Magic Knight"&&!src.is_arcane_beast)
						var/obj/Items/Enchantment/Staff/st=src.EquippedStaff()
						//var/obj/Items/Enchantment/Magic_Crest/mc=src.EquippedCrest()
						var/obj/Items/Sword/sord=src.EquippedSword()
						if(!st&&!(CrestSpell(Q))&&(!sord||sord&&!sord.MagicSword))
							src << "You need a spell focus to use [Q]."
							return
			if(Q.NeedsSword||Q.UnarmedOnly)
				var/obj/Items/Sword/s=src.EquippedSword()
				if(Q.NeedsSword)
					if((!s && !HasSwordPunching()) && !src.UsingBattleMage())
						src << "You must have a sword equipped to use this technique."
						return
				if(Q.UnarmedOnly)//Has Sword AND UnarmedOnly.
					if(!HasSwordPunching() && s)
						src << "You can't have a sword equipped to use this technique."
						return
					if(src.UsingBattleMage())
						src << "You can't use unarmed techniques while using Battle Mage!"
						return
				if(Q.ClassNeeded)
					if(s.Class!=Q.ClassNeeded)
						src << "You need a [Q.ClassNeeded]-class weapon to use this technique."
						return
			if(Q.HealthCost)
				if(src.Health<Q.HealthCost*glob.WorldDamageMult&&!Q.AllOutAttack)
					return
			if(Q.EnergyCost)
				if(src.Energy<Q.EnergyCost&&!Q.AllOutAttack)
					if(!src.CheckSpecial("One Hundred Percent Power")&&!src.CheckSpecial("Fifth Form")&&!CheckActive("Eight Gates"))
						return
			if(Q.ManaCost && !src.HasDrainlessMana() && !Q.AllOutAttack)
				var/drain = src.passive_handler.Get("MasterfulCasting") ? Q.ManaCost - (Q.ManaCost * (passive_handler.Get("MasterfulCasting") * 0.3)) : Q.ManaCost
				if(drain <= 0)
					drain = 0.5
				if(!src.TomeSpell(Q))
					if(src.ManaAmount<drain)
						src << "You don't have enough mana to activate [Q]."
						return
				else
					if(src.ManaAmount<drain*(1-(0.45*src.TomeSpell(Q))))
						src << "You don't have enough mana to activate [Q]."
						return
			if(Q.AssociatedGear)
				if(!Q.AssociatedGear.InfiniteUses)
					if(Q.Integrated)
						if(Q.AssociatedGear.IntegratedUses<=0)
							src << "Your [Q] has run out of power!"
							if(src.ManaAmount>10)
								src.LoseMana(10)
								src << "Your [Q] automatically replenishes itself!"
								Q.AssociatedGear.IntegratedUses=Q.AssociatedGear.IntegratedMaxUses
							return
					else
						if(Q.AssociatedGear.Uses<=0)
							src << "[Q] doesn't have enough power to function!"
							return
			if(Q.Combo)
				if(src.Target==null)
					src << "You need a target to use [Q]!"
					return
				if(src.Target==src)
					src << "You can't target yourself with [Q]!"
					return
			if(src.Beaming > 0.5)
				return
			if(src.AttackQueue)
				src << "<b>You drop [src.AttackQueue.name] from your queue.</b>"
				src.QueueOverlayRemove()
				src.ClearQueue()
			if(src.HasRipple())
				var/BreathCost=1*Q.DamageMult
				if(Q.InstantStrikes)
					BreathCost*=Q.InstantStrikes
				if(src.Oxygen>=BreathCost)
					Q.RipplePower*=(1+(0.25*src.GetRipple()*max(1,src.PoseEnhancement*2)))
					Q.DamageMult*=Q.RipplePower
					Q.AccuracyMult*=Q.RipplePower
					src.Oxygen-=BreathCost/4
				else if(src.Oxygen>=src.OxygenMax*0.3)
					Q.RipplePower*=(1+(0.125*src.GetRipple()*max(1,src.PoseEnhancement*2)))
					Q.DamageMult*=Q.RipplePower
					Q.AccuracyMult*=Q.RipplePower
					src.Oxygen-=BreathCost/6
				else
					src.Oxygen-=BreathCost/8
				if(src.Oxygen<=0)
					src.Oxygen=0
			if(Q.Copyable)
				spawn() for(var/mob/m in view(10, src))
					if(m.CheckSpecial("Sharingan"))
						if(m.SagaLevel<=Q.Copyable)
							continue
						if(m.client&&m.client.address==src.client.address)
							continue
						if(!locate(Q.type, m))
							m.AddSkill(new Q.type)
							m << "Your Sharingan analyzes and stores the [Q] technique you've just viewed."
				spawn()
					for(var/obj/Items/Tech/Security_Camera/SC in view(10, src))
						if(IsList(Q.PreRequisite))
							SC.ObservedTechniques["[Q.type]"]=Q.Copyable
				spawn()
					for(var/obj/Items/Tech/Recon_Drone/RD in view(10, src))
						if(IsList(Q.PreRequisite))
							RD.ObservedTechniques["[Q.type]"]=Q.Copyable
			if(Q.Counter)
				KenShockwave(src,icon='KenShockwaveBloodlust.dmi',Size=0.4, Blend=2, Time=2)
			if(!Q.Combo && src.HasCounterMaster() && CounterMasterTimer <= 0)
				Q.CounterTemp = 0.25 * src.GetCounterMaster()
				KenShockwave(src,icon='KenShockwaveBloodlust.dmi',Size=0.3, Blend=2, Time=2)
				CounterMasterTimer = max(1, 25 - (src.HasCounterMaster()*5))
			src.AttackQueue=Q
			src.AttackQueue.RanOut=0
			src.AttackQueue.Hit=0
			src.AttackQueue.Missed=0
			if(src.AttackQueue.MultiHit)
				src.AttackQueue.HitsUsed=0
			src << "<font color=#ff0000>You queue up a [Q.name]!</font>"
			if(src.AttackQueue.GrabTrigger)
				var/path=text2path(src.AttackQueue.GrabTrigger)
				if(!locate(path, src))
					src.AddSkill(new path)
			src.QueuedActivationMessage()
			src.QueueOverlayAdd()
			if(src.TomeSpell(Q))
				Q.Cooldown(1-(0.25*src.TomeSpell(Q)))
			else
				Q.Cooldown()

			if(Q.Duration >= 0)
				spawn(Q.Duration*10)//After the duration...
					if(src.AttackQueue==Q)
						if(src.AttackQueue.ComboPerformed<1&&src.AttackQueue.InstantStrikesPerformed<1)
							src.AttackQueue.RanOut=1
							src.AttackQueue.Hit=0
							src.AttackQueue.Missed=0
							src.ClearQueue()
							src << "<font color=#ff0000>You drop [Q.name]!</font>"
		QueuedDamage(var/mob/P)
			var/Damage=1
			// this acts as a multiplier, so something like a 5 damage mult will result in insane numbers

			if(AttackQueue.Finisher)
				var/ratio = (clamp((100-P.Health) / 50, 1, AttackQueue.Finisher+1) / glob.Q_DIVISOR)
				if(ratio > 0)
					Damage+=ratio
			if(AttackQueue.Opener)
				var/ratio = (clamp(P.Health / 50, 1, AttackQueue.Opener+1) / glob.Q_DIVISOR)
				if(ratio > 0)
					Damage+=ratio

			if(src.AttackQueue.Decider)
				var/DeciderDmg = getDeciderDamage(Health, P.Health)
				if(DeciderDmg > 0)
					Damage+=DeciderDmg

			if(AttackQueue.Dominator)
				if(Health>P.Health)
					var/ratio = (clamp(P.Health / Health, 1, 4) / glob.Q_DIVISOR)
					if(ratio > 0)
						Damage+=ratio
			if(AttackQueue.Determinator)
				if(Health<P.Health&&Health!=0)
					var/ratio = clamp(Health / P.Health, 1, 4) / glob.Q_DIVISOR
					if(ratio > 0)
						Damage+=ratio

			if(src.AttackQueue.Delayer)
				var/addDamage = 1 + (clamp(src.AttackQueue.Delayer*src.AttackQueue.DelayerTime, 0.1, 3)/ glob.Q_DIVISOR)
				Damage+=(addDamage)

			if(src.AttackQueue.SpeedStrike>0)
				Damage *= clamp(1,sqrt(((src.GetSpd())*(src.AttackQueue.SpeedStrike/10))),3)

			if(src.AttackQueue.SweepStrike>0)
				Damage *= clamp(1,sqrt(((P.GetSpd())*(src.AttackQueue.SweepStrike/10))),3)

			if(src.AttackQueue.GodPowered)
				src.transcend(src.AttackQueue.GodPowered)
			if(src.AttackQueue.CosmoPowered)
				if(!src.SpecialBuff)
					Damage+=(0.5+(src.SenseUnlocked-4))
			if(Damage<0)
				Damage = 0.1
			if(src.AttackQueue.DamageMult>=0)
				var/dmgMult = src.AttackQueue.DamageMult
				Damage*=dmgMult
			if(Damage>0 && GLOBAL_QUEUE_DAMAGE > 0)
				Damage *= GLOBAL_QUEUE_DAMAGE
			
			Damage = clamp(Damage,0.01, 10) // fuck it
			if(Damage>=5)
				src<<"please report this still to the admins [AttackQueue]"
				world.log<<"[src] hit for over 5x dmg mult using [AttackQueue]"
			return Damage
		QueuedAccuracy()
			var/Accuracy=1
			if(src.AttackQueue.AccuracyMult)
				Accuracy=src.AttackQueue.AccuracyMult
			//Maybe there will be accuracy passives...But not now.
			return Accuracy
		QueuedKBAdd()
			var/KB=0
			if(src.AttackQueue.KBAdd)
				KB+=src.AttackQueue.KBAdd
			//One day, passives.
			return KB
		QueuedKBMult()
			var/Mult=1
			if(src.AttackQueue.KBMult)
				Mult*=src.AttackQueue.KBMult
			//One day, passives.
			return Mult
		QueuedActivationMessage()
			if(src.AttackQueue.CustomCharge)
				OMsg(src, "[src.AttackQueue.CustomCharge]")
			else
				if(src.AttackQueue.ActiveMessage)
					if(src.AttackQueue.TextColor)
						src.OMessage(10, "<font color='[src.AttackQueue.TextColor]'><b>[src] [src.AttackQueue.ActiveMessage]</b></font color>", "[src]([src.key]) queued [src.AttackQueue].")
					else
						src.OMessage(10, "<font color='[rgb(255,153,51)]'><b>[src] [src.AttackQueue.ActiveMessage]</b></font>", "[src]([src.key]) queued [src.AttackQueue].")
			if(src.AttackQueue.Recoil)
				src.RecoilDamage=src.AttackQueue.Recoil
			if(src.AttackQueue.Quaking)
				src.Quaking=src.AttackQueue.Quaking
			if(src.AttackQueue.Combo)
				src.AttackQueue.ComboPerformed=0
		QueuedHitMessage(var/mob/P)
			if(!AttackQueue) return
			src.AttackQueue.Hit=1
			src.AttackQueue.Missed=0
			src.AttackQueue.RanOut=0
			if(istype(src.AttackQueue, /obj/Skills/Queue/Shoryuken))
				if(src.AttackQueue.ShoryukenEffect==2)
					OMsg(src, "[src] yells: SHORYUKEN!", "[src] used Shoryuken.")
			if(src.AttackQueue.CustomActive)
				if(src.AttackQueue.Combo||src.AttackQueue.InstantStrikes)
					if(!src.AttackQueue.ComboMessaged)
						OMsg(src, "[src.AttackQueue.CustomActive]")
						src.AttackQueue.ComboMessaged=1
				else
					OMsg(src, "[src.AttackQueue.CustomActive]")
			else
				if(src.AttackQueue.HitMessage)
					if(src.AttackQueue.Combo||src.AttackQueue.InstantStrikes)
						if(!src.AttackQueue.ComboMessaged)
							if(src.AttackQueue.TextColor)
								src.OMessage(10, "<font color='[src.AttackQueue.TextColor]'><b>[src] [src.AttackQueue.HitMessage]</b></font color>", "[src]([src.key]) hit with [src.AttackQueue].")
							else
								src.OMessage(10, "<font color='red'><b>[src] [src.AttackQueue.HitMessage]</b></font color>", "[src]([src.key]) hit with [src.AttackQueue].")
							src.AttackQueue.ComboMessaged=1
					else
						if(src.AttackQueue.TextColor)
							src.OMessage(10, "<font color='[src.AttackQueue.TextColor]'><b>[src] [src.AttackQueue.HitMessage]</b></font color>", "[src]([src.key]) hit with [src.AttackQueue].")
						else
							src.OMessage(10, "<font color='red'><b>[src] [src.AttackQueue.HitMessage]</b></font color>", "[src]([src.key]) hit with [src.AttackQueue].")
			if(src.AttackQueue.Stunner)
				Stun(P, src.AttackQueue.Stunner+src.GetStunningStrike())
				if(src.AttackQueue.Stunner>5)
					P << "Your mind is under attack!"
					animate(P.client, color = list(-1,-1,-1, -1,-1,-1, -1,-1,-1, 1,1,1), time = 5)
					P.TsukiyomiTime=src.AttackQueue.Stunner+1
			if(src.AttackQueue.RozanEffect)
				var/Time=src.AttackQueue.RozanEffect
				spawn()src.Quake(8)
				RozanEffect(src, P, Time)
			if(src.AttackQueue.ShoryukenEffect)
				var/Time=src.AttackQueue.ShoryukenEffect
				spawn()src.Quake(8)
				ShoryukenEffect(src, P, Time)
			if(src.AttackQueue.GoshoryukenEffect)
				var/Time=src.AttackQueue.GoshoryukenEffect
				spawn()src.Quake(8)
				GoshoryukenEffect(src, P, Time)

			if(src.AttackQueue.BuffAffected)
				var/path=text2path(src.AttackQueue.BuffAffected)
				var/obj/S=new path
				var/AlreadyBuffed=0
				for(var/obj/Skills/SP in P)
					if(SP.type==S.type)
						AlreadyBuffed=1
						break
				if(!AlreadyBuffed)
					var/BuffFound=0
					for(var/obj/Skills/Ssrc in src)
						if(Ssrc.type==S.type)
							BuffFound=1
							var/list/DenyVars=list("client", "key", "loc", "x", "y", "z", "type", "locs", "parent_type", "verbs", "vars", "contents", "Transform", "appearance")
							for(var/x in Ssrc.vars)
								if(x in DenyVars)
									continue
								S.vars[x]=Ssrc.vars[x]
							break
					if(!BuffFound)
						src.AddSkill(new path)
					S.Password=src.name
					P.AddSkill(S)

			if(src.AttackQueue.Projectile)
				var/path=text2path(src.AttackQueue.Projectile)
				var/x=src.AttackQueue.ProjectileCount
				if(!locate(path, src))
					src.AddSkill(new path)
				for(var/obj/Skills/Projectile/p in src)
					if(istype(p, path))
						for(x, x>0, x--)
							if(src.AttackQueue.ProjectileCDBypass||src.AttackQueue.ProjectileCount>1)
								p.Using=0
							if(!p.AttackReplace)
								p.AttackReplace=1
							src.UseProjectile(p)
							if(src.AttackQueue.ProjectileBeam&&!p.Immediate)
								src.UseProjectile(p)//Double tap for beaming
							sleep(1)
						break


		QueuedMissMessage()
			src.AttackQueue.Missed=1
			src.AttackQueue.Hit=0
			src.AttackQueue.RanOut=0
			if(src.AttackQueue.CustomOff)
				OMsg(src, "[src.AttackQueue.CustomOff]")
			else
				if(src.AttackQueue.MissMessage)
					src.OMessage(10, "<font color='yellow'><b>[src] [src.AttackQueue.MissMessage]</b></font color>", "[src]([src.key]) missed with [src.AttackQueue].")
			if(src.AttackQueue.Projectile)
				var/path=text2path(src.AttackQueue.Projectile)
				if(!locate(path, src))
					src.AddSkill(new path)
				for(var/obj/Skills/Projectile/p in src)
					if(istype(p, path))
						for(var/x=src.AttackQueue.ProjectileCount, x>0, x--)
							if(src.AttackQueue.ProjectileCDBypass||src.AttackQueue.ProjectileCount>1)
								p.Using=0
							if(!p.AttackReplace)
								p.AttackReplace=1
							src.UseProjectile(p)
							if(src.AttackQueue.ProjectileBeam&&!p.Immediate)
								src.UseProjectile(p)//Double tap for beaming
							sleep(1)
						break
			if(src.AttackQueue.MultiHit)
				src.AttackQueue.HitsUsed++
				if(src.AttackQueue.HitsUsed>=src.AttackQueue.MultiHit)
					src.ClearQueue()
			else
				src.ClearQueue()

		ClearQueue()
			src.QueueOverlayRemove()
			src.AttackQueue.CounterTemp=0
			src.AttackQueue.DelayerTime=0
			if(src.AttackQueue.ComboMessaged)
				src.AttackQueue.ComboMessaged=0
			if(src.AttackQueue.InstantStrikes)
				src.AttackQueue.InstantStrikesPerformed=0
				src.AttackQueue.NoWarp=0
			if(src.AttackQueue.Combo)
				src.AttackQueue.ComboPerformed=0
			if(src.AttackQueue.Quaking)
				src.Quaking=0
			if(src.AttackQueue.RipplePower>1)
				src.AttackQueue.DamageMult/=src.AttackQueue.RipplePower
				src.AttackQueue.AccuracyMult/=src.AttackQueue.RipplePower
				src.AttackQueue.RipplePower=1
			if(src.AttackQueue.HealthCost)
				src.DoDamage(src, TrueDamage(src.AttackQueue.HealthCost*glob.WorldDamageMult))
			if(src.AttackQueue.WoundCost)
				src.WoundSelf(src.AttackQueue.WoundCost*glob.WorldDamageMult)
			if(src.AttackQueue.EnergyCost)
				src.LoseEnergy(src.AttackQueue.EnergyCost)
			if(src.AttackQueue.FatigueCost)
				src.GainFatigue(src.AttackQueue.FatigueCost)
			if(src.AttackQueue.ManaCost)
				var/drain = src.passive_handler.Get("MasterfulCasting") ? AttackQueue.ManaCost - (AttackQueue.ManaCost * (passive_handler.Get("MasterfulCasting") * 0.3)) : AttackQueue.ManaCost
				if(drain <= 0)
					drain = 0.5
				if(src.TomeSpell(src.AttackQueue))
					src.LoseMana(drain*(1-(0.45*src.TomeSpell(src.AttackQueue))))
				else
					src.LoseMana(drain)
			if(src.AttackQueue.AssociatedGear)
				if(!src.AttackQueue.AssociatedGear.InfiniteUses)
					if(src.AttackQueue.Integrated)
						src.AttackQueue.AssociatedGear.IntegratedUses--
						if(src.AttackQueue.AssociatedGear.IntegratedUses<=0)
							src << "Your [src.AttackQueue] is out of power!"
							if(src.ManaAmount>=10)
								src << "Your [src.AttackQueue] automatically draws on new power to reload!"
								src.LoseMana(10)
								src.AttackQueue.AssociatedGear.IntegratedUses=src.AttackQueue.AssociatedGear.IntegratedMaxUses
					else
						src.AttackQueue.AssociatedGear.Uses--
						if(src.AttackQueue.AssociatedGear.Uses<=0)
							src << "[src.AttackQueue] is out of power!"
			if(src.AttackQueue.Hit)
				if(src.AttackQueue.GrabTrigger)
					for(var/obj/Skills/Grapple/g in src.Skills)
						if(g.type==text2path(src.AttackQueue.GrabTrigger))
							g.Activate(src)
			if(src.AttackQueue.Hit)
				if(src.AttackQueue.FollowUp)
					var/mob/ThatBoi=src
					var/path=text2path(src.AttackQueue.FollowUp)
					spawn()
						var/obj/Skills/s=new path
						if(!locate(s.type, ThatBoi))
							ThatBoi.contents+=s
						else
							s=locate(s.type, ThatBoi)
						if(s.type in typesof(/obj/Skills/AutoHit))
							ThatBoi.Activate(s)
						if(s.type in typesof(/obj/Skills/Projectile))
							ThatBoi.UseProjectile(s)
						if(s.type in typesof(/obj/Skills/Queue))
							ThatBoi.SetQueue(s)
						if(s.type in typesof(/obj/Skills/Grapple))
							s:Activate(ThatBoi)
			if(src.AttackQueue.BuffSelf)
				var/path=text2path(src.AttackQueue.BuffSelf)
				var/obj/S=new path
				var/obj/SFound
				var/AlreadyBuffed=0
				for(var/obj/Skills/Buffs/SP in src.Buffs)
					if(SP.type == S.type)
						SFound=SP
						if(src.BuffOn(SP))
							AlreadyBuffed=1
						break
				if(!AlreadyBuffed)
					if(SFound)
						var/list/DenyVars=list("client", "key", "loc", "x", "y", "z", "type", "locs", "parent_type", "verbs", "vars", "contents", "Transform", "appearance")
						for(var/x in SFound.vars)
							if(x in DenyVars)
								continue
							S.vars[x]=SFound.vars  [x]
					if(!SFound)
						src.AddSkill(new path)
					S.Password=src.name
					src.AddSkill(S)//trigger buff on self
				if(S.type==/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/What_Must_Be_Done)
					if(SlotlessBuffs["What Must Be Done"])
						SlotlessBuffs["What Must Be Done"].Mastery++
						SlotlessBuffs["What Must Be Done"].TimerLimit+=300
			if(!src.AttackQueue.Step&&!src.AttackQueue.MissStep&&!src.AttackQueue.HitStep)
				src.AttackQueue=null
			else
				if(!src.AttackQueue.Hit&&!src.AttackQueue.RanOut&&src.AttackQueue.Missed)
					if(src.AttackQueue.MissStep)
						var/obj/Skills/Queue/S=new src.AttackQueue.MissStep
						src.AttackQueue=null
						src.SetQueue(S)
						return
				else if(!src.AttackQueue.RanOut&&!src.AttackQueue.Missed&&src.AttackQueue.Hit)
					if(src.AttackQueue.HitStep)
						var/obj/Skills/Queue/S=new src.AttackQueue.HitStep
						src.AttackQueue=null
						src.SetQueue(S)
						return
				else if(!src.AttackQueue.RanOut&&(src.AttackQueue.Missed||src.AttackQueue.Hit))
					var/obj/Skills/Queue/S=new src.AttackQueue.Step
					src.AttackQueue=null//But this triggers either way so long as you didn't just run out of time.
					src.SetQueue(S)
					return
				src.AttackQueue=null


		QueueOverlayAdd()
			if(src.AttackQueue.IconLock)
				if(src.AttackQueue.IconLock!=1)
					if(src.AttackQueue.IconLockUnder)
						src.underlays+=image(icon=src.AttackQueue.IconLock, pixel_x=src.AttackQueue.LockX, pixel_y=src.AttackQueue.LockY)
					else
						src.overlays+=image(icon=src.AttackQueue.IconLock, pixel_x=src.AttackQueue.LockX, pixel_y=src.AttackQueue.LockY)
				else
					if(!src.AuraLocked&&!src.HasKiControl())
						src.Auraz("Add")
					else
						KenShockwave(src,icon='KenShockwaveFocus.dmi',Size=0.3, Blend=2, Time=2)
		QueueOverlayRemove()
			if(src.AttackQueue.IconLock)
				if(src.AttackQueue.IconLock!=1)
					if(src.AttackQueue.IconLockUnder)
						src.underlays-=image(icon=src.AttackQueue.IconLock, pixel_x=src.AttackQueue.LockX, pixel_y=src.AttackQueue.LockY)
					else
						src.overlays-=image(icon=src.AttackQueue.IconLock, pixel_x=src.AttackQueue.LockX, pixel_y=src.AttackQueue.LockY)
				else
					if(!src.AuraLocked&&!src.HasKiControl())
						src.Auraz("Remove")