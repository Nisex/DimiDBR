var
	WorldDamageMult=1 //Damage everyone in the world?
	WorldDefaultAcc=50 //Global accuracy
	WorldWhiffRate=25 // Global whiff
	WorldPUDrain=1 //Sets the drain of PU
	GetUpVar=1 // KO Timer
	list/GUILD_RANKINGS = list("Aegis" = 1, "Crimson Dawn" = 2, "Golden Circle" = 3, "Black Ifrit" = 5, "Revenants" = 6)
	list/CustomCommons=list("Majin","Half-Saiyan", "Android")
	list/GlobalLandingLocations = list()
	BaseUpdate=1 //Updates...base.
	WorldBaseAmount=1 //sets everyones base to a number....mod...bluh bluh.
	list/NoSagaRaces=list(/*"Saiyan", "Majin",*/ "Changeling", "Shinjin", "Demon", "Dragon")

	WipeStart//Holds the time (midnight) that the wipe started at. Used to define starting RPP and daily potential.
	DaysOfWipe
	RPPStarting=120//holds the starting value of rpp
	RPPStartingDays=2//holds the number of days you will achieve the starting limit in
	RPPHighest=0//global tracking for the highest amt of rpp
	RPPLimit=1600//This * RPP gain is the maximum RPP able to be acquired by default.  With EC included, this can be x1.5
	RPPDaily=60//This is the amount given daily.
	list/RPPTotal=list()//an associative list which is ckey = RPPTotal. reincarnating someone moves their RPPCurrent to this value
	list/RPPEventCharges=list()//an associative list which is ckey = total number of EventCharges ever gained. it is set to this value when they create a new character.
	PotentialDaily=1//amount of potential it can be assumed will be gained daily with minimal effort
	RPPBaseMult=1
	MoneyName="Dollars"
	list/obj/Special/Spawn/Spawns=list()

	DustControl=0 //Dust Toggle!
	GlobalTurfDestroyer //Global turf destroyer

	VoidsAllowed=1//Allow voids?
	VoidChance=100//Percent chance of void

	NearDeadX=150//these
	NearDeadY=150//are
	NearDeadZ=17//for (almost) dead people

	DeadX=150//these
	DeadY=150//are
	DeadZ=18//for dead people

	MajinZoneX=9//these
	MajinZoneY=63//are
	MajinZoneZ=1//for yummy people

	PhilosopherX=9//these
	PhilosopherY=63//are
	PhilosopherZ=1//for stoned* people

	MoonOut
	MakyoOut

	list/fusion_locs = list()

	PureMade=0
	BlueMade=0
	RedMade=0
	ChainMade=0
	BloodMade=0
	SealMade=0
	NobleMade=0
	RagnaMade=0
	EmptyMade=0
	StasisMade=0
	RelativityMade=0
	YukianesaMade=0
	BolverkMade=0
	OokamiMade=0


	list/WeaponSoul = list("Caledfwlch","Kusanagi","Durendal","Masamune","SoulCalibur","SoulEdge","Muramasa","Dainsleif","Ryui Jingu Bang","Green Dragon Crescent Blade")

	CaledfwlchTaken
	KusanagiTaken
	DurendalTaken
	MasamuneTaken
	SoulCaliburTaken
	SoulEdgeTaken
	MuramasaTaken
	DainsleifTaken
	WukongTaken
	GuanyuTaken

	list/ConstellationsBronze=list("Pegasus","Dragon","Cygnus","Andromeda","Phoenix")
	list/ConstellationsGold=list("Aries",/* "Taurus" */,"Gemini","Cancer","Leo","Virgo","Libra","Scorpio",/*"Sagittarius"*/,"Capricorn","Aquarius","Pisces")

	Era=1//Keeps track of tiiime

	list/ContractBroken=list()//Holds ckeys of contracts that were broken while people were offline
	list/TrueNames=list()//Holds list of true names that have been registered.

	SwordAscDamage = 0.05
	SwordAscAcc = 0.05
	SwordAscDelay = 0.05
	StaffAscDamage = 0.05
	StaffAscAcc = 0.05
	StaffAscDelay = 0.05
	ArmorAscDamage = 0.05
	ArmorAscDelay = 0.05
	ArmorAscAcc = 0.05

	CCDamageModifier = 0.33

/mob/var/Power = 1

atom/var
	tmp/Using=0
	tmp/mob/Owner
	tmp/mob/Partner
	tmp/turf/Spawn_Location
	Health=100
	LastIconChange
	AdminInviso=0
	FlyOverAble=1
	IgnoreFlyOver=0
	UnFlyable=0
	// Current available power, a compilation of many factors. Editing will do nothing
	Level=1
	Speed=1
	Savable
	Builder
	Buildable=1
	Grabbable=1
	Distance=15
	Spawn_Timer=0
	Tabs
	isOutside
	isUnderwater
	PrevX
	PrevY
	PrevZ
	Password
	Password2
	Password3
	PasswordReception
area
	mouse_opacity=0
obj
	var/Attackable=1
	var/Destructable=1

mob/Health=100
mob/var
	last_online
	//Mechanical Variables
	KOTimer//moving this over here so mortal wounds aren't so weird.
	KOBrutal//If this is flagged, you won't recover some health when you awaken
	Voiding//void timer, TODO mode
	ScreenSize
	tmp/mob/Target
	tmp/obj/Control //An object you're controlling
	tmp/Manufactured
	tmp/PoseEnhancement//Pose for 3 seconds to get a bonus to rippling.
	tmp/PoseTime//timer
	tmp/BuffingUp=0//to stop people from pushing through weird buff behaviour
	tmp/WindingUp//new var for autohitsu
	tmp/PoweringUp=0
	tmp/PoweringDown=0
	tmp/Knockback//The distance to be knocked back.
	tmp/previousKnockBack // how far you were knocked back last time
	tmp/Knockbacked//The direction of knockback.
	tmp/Swapping//new var that controls swapping tomes/gears
	tmp/Shielding//used for fanciness
	tmp/Beaming=0//If true when a direction is pressed, do not move, but change directions.
	tmp/BeamCharging=0.5//Holds the length of time that a beam has been charging for
	tmp/BusterCharging=0//holds the length of time uve been trying to be megaman
	tmp/obj/Skills/Projectile/BusterTech//holds a buster technique, holy fuqq
	tmp/list/mob/BeingObserved=list()//this holds the observer, and sends them messages
	tmp/list/BeingTargetted=list() //list of mobs currently targetting
	tmp/is_dashing = 0
	tmp/verb_delay = 0
	tmp/GlowFilter
	tmp/ArmamentGlow
	tmp/FlickeringGlow
	tmp/MeditateTime
	tmp/datum/Party/party//party party party
	tmp/StunImmune
	tmp/GrabTime
	AntiGodDoor=0
	ZenkaiEXP=0
	custom_scent//cummies
	custom_powerup//dummies
	customPUnameInclude = FALSE
	fake_unlock=0
	MaimMastery=0
	//Stat Variables
	BaseOriginal=1
	RPPMult=1//Humangain
	EconomyMult=1
	Intelligence=1//technology modifier
	Imagination=1//enchantment modifier
	Intimidation=1//Adding this here for ezpz stuff.
	HealthCut=0
	EnergyMax=100
	Energy=100
	//todo: remove all energy
	EnergyMod=1
	EnergyOriginal=1
	EnergyAscension=1
	EnergyMultTotal=1
	EnergyTrans=1
	EnergyReplace=0
	//end todo
	EnergyCut=0
	EnergyExpenditure=1//Crank that drain if higher than 1
	EnergyUniqueness=1//EVERYONE'S A SNOWFLAKE
	EnergySignature//holds your unique energy signature
	list/EnergySignaturesKnown=list()//holds signatures you identified
	list/ai_alliances=list()//these classes of ai wont attack you
	tmp/list/obj/Items/Items=list()//items you have
	list/SkillsLocked=list()//paths of skills that have been locked out due to being prerequisites for upgraded versions
	tmp/SignatureSelecting=0//flag that disables checking for more sigs
	list/SignatureSelected=list()//names of signatures that have been selected already, so they can be removed from the global list when signature selection is activated
	list/SignatureStyles=list()//name & path of styles which can be selected from signature selection
	SignatureCheck=1//if 1, try to give signatures. if 0, do not
	tmp/list/obj/Skills/Skills=list()//skills you know
	tmp/list/obj/Skills/Queue/Queues=list()//queues you know
	tmp/list/obj/Skills/Projectile/Projectiles=list()//projectile attacks you know
	tmp/list/obj/Skills/AutoHit/AutoHits=list()//autohits you know
	tmp/list/obj/Skills/Buffs/Buffs=list()//buffs you know
	ManaCut=0
	ManaCapMult=1//x this value to mana cap
	StrAdded=0
	EndAdded=0
	ForAdded=0
	OffAdded=0
	DefAdded=0
	SpdAdded=0




	StrOriginal=1
	StrMultTotal=1
	StrChaos=1
	StrAscension=0
	StrReplace=0
	StrTax=0
	StrCut=0
	StrStolen=0
	StrEroded=0
	EndOriginal=1
	EndMultTotal=1
	EndChaos=1
	EndAscension=0
	EndReplace=0
	EndTax=0
	EndCut=0
	EndStolen=0
	EndEroded=0
	SpdMultTotal=1
	SpdOriginal=1
	SpdChaos=1
	SpdAscension=0
	SpdReplace=0
	SpdTax=0
	SpdCut=0
	SpdStolen=0
	SpdEroded=0
	ForOriginal=1
	ForMultTotal=1
	ForChaos=1
	ForReplace=0
	ForAscension=0
	ForTax=0
	ForCut=0
	ForStolen=0
	ForEroded=0
	OffOriginal=1
	OffMultTotal=1
	OffChaos=1
	OffAscension=0
	OffTax=0
	OffCut=0
	OffStolen=0
	OffEroded=0
	DefOriginal=1
	DefMultTotal=1
	DefChaos=1
	DefAscension=0
	DefTax=0
	DefCut=0
	DefStolen=0
	DefEroded=0
	//todo: remove all regen
	RegenMod=1
	RegenOriginal=1
	RegenMultTotal=1
	RegenChaos=1
	RegenAscension=0
	RegenReplace
	RegenTax=0
	RegenCut=0
	RegenEroded=0
	//end todo
	RecovMod=1
	RecovOriginal=1
	RecovMultTotal=1
	RecovChaos=1
	RecovAscension=0
	RecovReplace
	RecovTax=0
	RecovCut=0
	RecovEroded=0
	AngerPoint=50//get angry with this percent of health left
	AngerMessage//custom anger messages
	AngerColor
	HiddenAnger //hide BP from anger
	CalmAnger //Never get angry unless something forces you to.  Like maki.
	ExhaustedMessage
	ExhaustedColor
	BarelyStandingMessage
	BarelyStandingColor

	//TODO: remove all these bitches
	PowerApparent=0
	style_reset=0
	zenkai_reset=0
	cyber_reset=0
	jagan_reset=0
	sig_reset=0
	potential_reset=0//did they exceed potential ranges?
	hell_reset=0
	grimoire_reset=0

	Potential=1
	PotentialStatus="Distracted"
	PotentialRate=1
	PotentialCap=1
	potential_trans=0//entering trans state sets this
	potential_power_mult=1
	potential_last_checked=0
	PotentialDailyGain=0//how much potential can be obtained from NPCs
	PotentialLastDailyGain//when was the last date that daily gain was refreshed?
	RewardsLastGained//when was the last time you were rewarded?
	PowerBoost=1//Now it ain't borked!?
	PowerInvisible=1//only used for buffs now
	PotentialUnlocked//You need a better UP after a previous one.
	ContractPowered=0//Like UP, but with contracts.
	SummonContract//just for summoning
	SummonReturnTimer//5 minutes then spirit go byebye
	GodKi//When this is active, FUKKEN MAGIC
	Tension//yaaa yeet
	TensionLock//pls dont
	SealPersonal
	VanishPersonal
	VanishFlick
	VanishDuration

	//Battle Variables
	NoAnger //Can't get angry when this is flagged.
	NoRevert=0 //Transformations don't revert.
	NoVoid //YOU THOUGHT YOU WERE GONNA VOID, BITCH?!
	NoDeath=0 //it means no worries...for the rest of your daaaays
	NoForcedWhiff //HAKI ANTIWHIFF

	Flow=0//dojs
	Instinct=0//Penetrate AIS/WS

	PureDamage=0
	PureReduction=0

	LifeStealTrue//Inflict healthcut and regenerate your own healthcut.

	SoftStyle//attacks on user generate fatigue, attacks by user give more damage depending on fatigue of enemy
	HardStyle//attacks on user generate wounds, damage is reduced depending on how wounded enemy is
	CyberStigma//hitting enemy with attack does battery(mana) damage, less battery(mana) = more damage
	DeathField//Attacking user at all generates wounds!
	VoidField//As above but with Fatigue
	Unstoppable//Injuries are ignored

	SweepingStrike=0
	SpecialStrike=0
	StunningStrike=0//Buff and mob var only; this value *10 of inflicting 2 second stun on dodamage.

	Warping//You forcewarp.
	SuperDash//Mobs have this too now
	IaidoCounter//Once it hits ten, you get a zoom attack.

	SpiritHand//Str*=sqrt(For)
	SpiritFlow//For*=sqrt(Str) //TOD: Change to PowerFlow / PowerStream
	BetterAim=0//adds temporary homing to not-homing projectiles
	MovingCharge=0//Battlemage passive

	MeltyMessage//ppl need to know this shit
	MeltyBlood//isroth 'my blood hurts u' passive
	VenomMessage//fuck isroth being unique
	VenomBlood//fuck'em hard

	Quaking//When you dodamage someone, it makes the screen go shaka shaka.
	Burning
	Scorching
	Chilling
	Freezing
	Crushing
	Shattering
	Shocking
	Paralyzing
	Poisoning
	Toxic
	Confusing
	Disorienting
	Shearing
	Crippling

	Attunement//Double X effects, double Y effects
	VenomResistance//resistance to poison

	SenseRobbed=0
	tmp/startOfLaunch=0
	Launched=0
	Dunked=0
	tmp/Grounded=0
	tmp/Stunned
	Stasis//Can't take damage but can't take action.
	StasisFrozen//is in iceblock
	StasisStun//if you're iceblocked from stun rather than true stasis
	StasisSpace//if you're trapped in space prison

	WeightRestricted=0//Weighted Clothes

	Kaioken//Level of kaioken.
	KaiokenBP=1//Level of Kaioken intimidate.

	TechniqueMastery=0// Buffs cooldowns
	MovementMastery=0// Buffs PU effectivness
	BuffMastery=0//Buffs buffs, nerfs nerfs.
	QuickCast=0//Divdes how long it takes to cast a skill

	DeathKilled=0//You get one.
	DeathKillerTargets//used for deathkiller
	NoSoul//Immediately delete the character when they are truly dead

	DrainlessMana=0//No mana loss.
	LimitlessMagic=0//No magic restrains
	ManaStats=0//Boost stats depending on mana amount held
	ManaSealed=0//Won't generate capacity due to having their circuits stolen by fake philosopher stone
	ManaDeath=0//TOO MUCH MANA
	Binding//Holds the zplane of binding
	BindingTimer//Every time this goes off, the person is returned to their zplane.
	HearThoughts=1
	Phylactery//if 1, make sure their phylactery is in the world
	PhylacteryNerf=0//take this percent out of anger

	SpiritPower //makes you into an exorcist/spirit medium
	ShonenPower //makes you into a shonen protagonist
	HellPower //gives you demonic regen and raaaaaaaaaaaaaaage
	HellRisen //get up get power
	LegendaryPower //gives you power of a legend

	HolyMod=0//Does more damage to EVIL.
	AbyssMod=0//Does more damage to NON-GOOD.
	SlayerMod=0//Does more damage to NINGEN.

	FluidForm //All attacks whiff.
	GiantForm //All attacks roll minimum damage.
	Juggernaut //Unstunnable, can't be knocked back.
	Immortal //Not timeless, but won't die from age
	Spiritual//Demons and shinjin and yokai, o mai
	Restoration//better meditation
	Anaerobic//higher fatigue = more power
	Hustle//Attack faster as PU goes higher.
	MovementCharges=0//charges of zanzo/AIS currently possessed (which yan thinks should be replaced by ddash and reverse dash entirely)
	Infusion//Getting hit by elemental techs can grant you minor versions for ever seconds.
	InfusionElement
	Flicker//Auto procs zanzoken sometimes.
	Adrenaline//Go faster as health goes lower.
	Xenobiology//alien body structure
	Longlived
	Symbiote
	Metamorean

	//Appearance Variables
	MobColor=list(1,0,0, 0,1,0, 0,0,1, 0,0,0)//used to define proper color listing to return to mob wise
	Text_Color="#45fa3f"
	OOC_Color="#666666"
	Emote_Color="#f0fa33"

	Trait_Color//i guess it will be used for furries?!



	EyesSSJ='EyesSSJ.dmi'

	EyesSSJ3='EyesSSJ3.dmi'

	EyesSSJ4='EyesSSJ4.dmi'
	FurSSJ4
	ClothingSSJ4
	TailSSJ4

	EyesSSG='EyesSSG.dmi'

	EyesSSB='EyesSSB.dmi'

	EyesUI='EyesUI.dmi'

	ExpandBase

	SEAOffense='Soxx-Sacred_Armor_Offense.dmi'
	SEADefense='Soxx-Sacred_Armor_Defense.dmi'

	tmp/MirrorIcon

	//Knowledge Variables
	list/UnlockedTechnology=list()//this will hold the types of unlocked technology AND enchantment
	list/PotionTypes=list()//determines what herbs you can use

	GrimoiresMade//Holds how many Grimoire types you've made total

	Mechanized
	EnhanceChips
	EnhanceChipsMax=4
	PilotingProwess=0


	//Fusion Variables
	Name_Fusion
	Profile_Fusion
	Icon_Fusion
	Icon_FusionFat
	Icon_FusionClothes
	Icon_FusionClothesX
	Icon_FusionClothesY
	FusionCKey1//tracks first ckey
	FusionCKey2//tracks second ckey
	tmp/FusionObsLock=0//can only observed fused things
	FusionTimer=0

	PUDrainReduction=1//Reduces PU drain.
	PUSpeedModifier=1
	PURestrictionRemove//NOTHING IS SACRED

	Incorporeal=0


	ManaSeal
	Desperation
	KBRes=1//Divides knockback distance by this value.
	KBMult=1//Multiplies knockback distance by this value.
	KBAdd=0//Adds tiles of KB
	CriticalChance
	CriticalDamage
	CriticalBlock
	BlockChance
	StealsStats//Steals stats on hit.
	Erosion//Erodes stats on hit

	DebuffImmune//Void passive
	DebuffReversal//Ultima passive.
	ArcaneBladework//Allows you to use swords and staves at the same time.
	BleedHit//Deals 0.05 damage for each value when you hit someone.
	ManaLeak//Deals 0.05 mana damage for each value when you hit someone.
	OverClockNerf//Halves power.
	OverClockTime//duration of overclock.
	WeaponBreaker//Holds a value that allows sword breaking.
	EndlessAnger //Maki effect; anger doesn't fade.

	StableBP//Won't lose BP from health or energy drain.
	SureHit//All melee attacks hit.
	SureHitTimer//The active countdown.
	SureHitTimerLimit//The variable that makes sure that the timer works and resets it.
	SureDodge
	SureDodgeTimer
	SureDodgeTimerLimit
	tmp/CounterMasterTimer
	NoWhiff//Can't whiff.
	Steady//Consistent damage values.
	Purity//Can only damage what you're meant to damage...
	BeyondPurity//...nevermind
	SoulSteal=0//Like life steal, but it adds vai health instead of actual health.
	LifeSteal=0//localized variable.  Each level of Lifesteal adds 0.1x to how much life is stolen.
	LifeGeneration//Every 50 hits, this much health is generated.
	EnergySteal=0
	EnergyGeneration//Every 50 hits, this much energy percent is generated.
	HotHundred//No nerf on light attacks.
	Afterimages//Jitters effect.
	EnergySiphon//(not) Raiju skill.

	obj/Skills/Buffs/ActiveBuff//New buff variable.
	obj/Skills/Buffs/SpecialBuff//New buff variable.
	list/obj/Skills/Buffs/SlotlessBuffs=list()//New buff variable list.
	obj/Skills/Buffs/StanceBuff//New stance variable.
	obj/Skills/Buffs/NuStyle/StyleBuff//New style variable.

	Maimed=0
	MaimsOutstanding//Maims - cyber limbs
	MaimCooldown //Prevents maims from happening too quickly.

	Timeless//Doesn't give a FUK about era
	EraBirth//keeps track of birth date for future interests
	EraAge//Keeps track of the numbers
	EraBody
	EraDeathClock//when u get too old, this will hold a value that will say when u die
	tmp/EraDeathTrigger
	ModifyBaby=0
	ModifyEarly=0
	ModifyPrime=0
	ModifyLate=0
	ModifyFinal=0

	tmp/obj/Skills/Queue/AttackQueue//This variable holds an object which has queue stats.
	Pursuiting//Chasing people down.
	WoundIntent=0
	RPPTotal//all normal rpp acquired over your character(s) life(s).
	RPPCurrent=0//normal rpp acquired over THIS character life.
	RPPSpendable=0//the actual value you can use of your rpp current
	RPPSpent=0//how much rpp you've spent
	//as above, but for event
	RPPTotalEvent
	RPPCurrentEvent
	RPPSpendableEvent
	RPPSpentEvent
	//these are triggered by daily rewards
	RPPEventCharges//value from 7 to 0 which holds the number of event charges you have (they trigger automatically at rewards)
	EconomyEventCharges//value from 0 to ? which holds the number of economy-only charges you can trigger with daily rewards.

	RPPStartingDaysTriggered=0//increments
	RPPDonate=0//Used for elders; can help people hit cap sooner

	LastTeach=0
	Overview=1 //If overview is toggled on or not
	AFKTimer=3000 // AFK timer stuff
	AFKTimeLimit=3000 // AFK timer stuff
	AFKIcon='afk.dmi' // AFK icon
	AlienRacialActive // Active alien skill
	AlienRacialPassive // Passive alien skill
	Fishman
	RacialsSelected=0
	CustomObj1Icon=null
	CustomObj1State=null
	CustomObj1X=null
	CustomObj1Y=null
	CustomObj1Density=null
	CustomObj1Opacity=null
	CustomObj1Layer=3
	CustomTurfIcon='ArtificalObj.dmi'
	CustomTurfState="QuestionMark"
	CustomTurfRoof=0
	CustomTurfDensity=0
	CustomTurfOpacity=0
	tmp/mob/Transfering=0
	Asexual=0
	Warp=0
	list/GenRaces=new
	Rewarded
	Transforming=0
	TransformingBeyond=0
	tmp/Observing=0
	tmp/SaveDelay
	tmp/SenseCD
	Gender
	DisplayKey
	Oxygen=100
	OxygenMax=100
	PowerUp=0
	PowerDown=0
	image/ChargeIcon
	SSJ=0

	Race
	Class="Fighter"
	KO
	Build=0
	Inside=1
	ShallowMode=0
	UnderwaterMode=0
	Sight_Range=10
	Spawn="True Spawn"
	PureRPMode=0

	CyberizeMod = 0
	tmp/IconClicked=0
	tmp/NextAttack		//As world.time
	tmp/ContinuousAttacking
	tmp/mob/Grab
	Power_Multiplier=1 //This changes temporarily with the use of power altering abilities.
	PowerEroded=0
	Base=1
	StrMod=1
	EndMod=1
	ForMod=1
	OffMod=1
	DefMod=1
	SpdMod=1

	SuperDemonBody
	SuperDemonBody2
	TrueName//Holds true name for otherworldly beings
	RPPower=1 //Multiplies overall power, edited by admins to increase power when it is suited to do so.
	StealthRPPower=1//Multiplies power...invisibly!!
	StealthAdd=0//Adds power...invisibly!!
	Body=1
	//arent all of these useless anyway?
	PUConstant
	PUThresholdUp=0
	PUEffortless
	PUUnlimited

	ManaPU=0
	PowerControl=100
	ActiveBuffs=0
	SpecialSlot=0
	Anger=0
	AngerMax=1
	AngerStorage=1

	Tail
	TailIcon='Tail.dmi'
	TailIconWrapped='Tail-Wrapped.dmi'
	TailIconUnderlay
	Golden
	Emitter
	SSJ4Unlocked

	Regenning=0

	Dead=0
	DeadAge=0
	DeadTime
	KeepBody=0
	Flying
	Skimming//pretends you're flying
	Charge_Icon
	MortallyWounded
	TsukiyomiTime
	Lethal=0 //Lethality
	Timestamp=0 //Timestamp Setting
	CustomSpeed=1
	CustomChargeRate=1
	CustomPower=1
	CustomDistance=1
	CustomEfficiency=1
	CustomPoints=0
	Fusee=0
	Fused=0
	FusionTarget
	KiBlade=0
	ForceStrike=0
	GrabMove //THIS HAND OF MINE IS BURNING RED
	DelayedDamage
	CoinSetting="ZenniBag"
	StatModules=0
	EnhancedStrength=0
	EnhancedEndurance=0
	EnhancedAggression=0
	EnhancedReflexes=0
	EnhancedForce=0
	EnhancedSpeed=0
	InternalScouter=0
	NanoBoost=0
	NanoAnnounce=0
	BladeMode=0
	StealthSystems=0
	CombatCPU=0
	EnergyAssimilators=0
	EnhancedSmell=0
	Profile=null
	GimmickDesc=""
	GimmickTimer
	NormalIcon

	Meditating
	MeditationCD=0
	Mystic
	Maki
	Void //No sense, but also no thought reading.
	MaskType
	MaskAlpha
	StanceLock
	StanceActive
	Style
	StyleActive
	Hardening=0
	Confused//The amount of time you have reversed movement for.
	AngerMult//allows anger multipliers to stack. oh my god
	AngerThreshold//if you're not angry enough, this will make you angry enough
	AngerCD=0
	CyberCancel//Basically the same, but for cyber stuffs.
	CyberPowerAngerNerf
	CyberPassiveAngerNerf
	CyberActiveAngerNerf
	CyberStatAngerNerf
	ChakraCrusherUnlocked=0
	ChakraFreeze//If this is ticked, people have half PU gain.
	EnhancedHearing=0
	//New variables; Advanced Stances and Staves give offense and defense.  Swords give offense.  Armor gives defense.
	ElementalOffense
	ElementalDefense
	Poison=0
	Burn=0
	Slow=0
	Shatter=0
	Harden=0
	Shock=0
	Sheared=0
	Crippled=0
	Attracting=0
	Attracted=0
	tmp/mob/AttractedTo=0
	Terrifying=0
	Terrified=0
	tmp/mob/TerrifiedOf=0
	PotionCD=0
	Satiated=0//fooooood
	Drunk=0//get op in drunk fist
	Aged=0//ignore youth debuffs
	Doped=0//ignore bp wounds
	Antivenomed=0//Makes poison do half damage and reduces it by a much higher rate.
	Cooled=0//Same, but for burn (and chill now)
	Sprayed=0//Reduce cripple/shear
	Stabilized=0//Reduce shock/confuse
	Roided=0//When BP Poison is less than 1, gives you half of the reduced value back
	BloodDrain
	LifeDrain
	BurningShot
	ManaAmount=100
	ManaMax=100
	DoubleStrike
	TripleStrike
	Default_Hair



	LastBreath


	KiControlMastery=0


	PULock
	PUForce//overrides override...


	//JJBA vars
	TimeStop
	TimeFrozen
	WorldImmune=0


	//gates
	GatesNerf
	GatesNerfPerc

	TranceForm
	TranceCounter
	TranceObtained


	Godspeed

	DelayedKB
	tmp/mob/DelayedKBCatalyst

	HumanAscension//Fighting, Enchantment, or Technology.  Used for reversion code
	SaiyanAscension
	MonsterClass//Warrior, Shaman, Hunter
	MonsterSource//Power, determination, ingenuity
	MonsterAscension//Infernal, Celestial, Legendary
	AlienEvolutionStats//keeps aliens from double tapping stats
	ShinjinAscension


	Transformed=0
	Oozaru=0
	OozaruTimer//7.5 minutes to monkey around
	OozaruBase//Holds old base value.
	OozaruName//Holds old name
	StarPowered=0//Makyo dick on/off
	JaganBase//holds old base mod when using JEM
	AscensionsUnlocked=0
	AscensionsAcquired=0
	BioArmor//How much extra health you have
	BioArmorMax//The total amount of extra health you can have

	NPCImmune
	BuildGiven
	TurfInvincible=0
	TotalFatigue=0
	TotalInjury=0
	TotalCapacity=0//Philosopher stones are notably harder to meme with

	AerialRecovery
	HealthAnnounce25
	HealthAnnounce10
	InjuryAnnounce
	FatigueImmune
	InjuryImmune

	Secret
	Saga

	ConcealedPower//This hides vampires, werewolves, and makaioshins.
	BPPoison=1//Reduces BP by an amount.
	BPPoisonTimer//Determines how long it lasts.

	StaticWalk//Can walk through static
	SpaceWalk//Doesn't drown in space
	VenomImmune//Chill in ichor
	WalkThroughHell//Walk in lava
	WaterWalk//Walk through...water.  WOWZA
	RecoilDamage//If this has a value, you'll do damage to yourself.
	NoDodge//talk shit, get hit
	NoMiss//Did you talk shit...? >:T
	MaimStrike//yan with the innuendo... SLAP A BITCH'S ENTIRE ARM OFF
	CursedWounds//wounds ignore endurance reduction and wound intent
	SoulFire//damage mana capacity
	DarknessFlame//lets you have Darkness Flame effects
	AbsoluteZero//lets you have Absolute Zero effects
	FusionPowered//so you can be fatigue immune and regen energy in PU
	CyberLimb=0//The stuff replacing your maims
	//Consistency changes
	Pursuer=0//chase them down
	AuraLocked
	AuraLockedUnder=0
	AuraLock
	AuraX
	AuraY
	HairLocked
	HairLock
	HairBX
	HairBY
	HairX=0
	HairY=0
	HairUnderlay
	HairUnderlayX=0
	HairUnderlayY=0
	WillPower
	Regenerating
	Judgment
	PridefulRage
	Defiance
	DefianceCounter=0
	DefianceRetaliate
	Adaptation
	AdaptationCounter=0
	tmp/mob/AdaptationTarget
	AdaptationAnnounce
	mob/var/tmp/Swim=0
	NextSerum//holds realtime of the next time you can use a revitalization serum
	usedSerums = 0
	magicalMaimRecov = 0
	TarotCooldown//holds realtime of the next time you can use a tarot card
	TarotFate//holds your tartot trump
	AllowObservers//Allows people to observe you fighting!
	list/GlobalCooldowns = list()


	UnhingedForm // Gives more speed for less def/end
	HeavyHitter // Knockback mult
	Blubber = 0 // reverse knockbacks at 25% of total per tick
	DemonicDurability = 0 // Gain more endurance / pure red from anger


	SwordPunching = 0 // can punch with swords



	Extend
	CounterMaster

	AriaCount = 0
	UBWPath

	obj/Items/Armor/equippedArmor
	obj/Items/Sword/equippedSword
	obj/Items/WeightedClothing/equippedWeights
	equippedProsthetics = 0

/proc/reduceGodKi(mob/player, num)
	player.GodKi -= num
	if(num < 0)
		player.GodKi = 0