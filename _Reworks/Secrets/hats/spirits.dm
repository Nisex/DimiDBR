/*

let x = demon, y = holy and z = legendary

choice x y z

any choice gives Force + str scaling with pot/tier
    maybe scaling manastat w/ increase
    martial magic
    decreased void chance
    hats have a tier system to them, so its dual scaling


x = hellpower, scaling spirit sword = to tier + pot, sword punching, omnislash but cursed wounds vfx + cursed wounds, ultimate = dividing driver

y = holy power + spirit power, scaling hyprid strike, sword punching, giant aoe that makes space jtiles that fatigue and eat energy of ppl in it + heal u, ultimate = similar to gold cloth power up

z = legendary power, considered a staff, spirit flow, +spiritdamage, special move = homing bombs that manasteal/soulfire, do more dmgf the more mana/battery a person is missing, ultimate = wood golem

notes: p sure arcane beast ai is not functional

tiers:
    1 = path + Gravity ( waterwalk+godspeed+likewater+fluidform )
    2 = element passive + special move
    3 = ?
    4 = hat takeover mode(?) + ultimate
        an install or like symbiote i assume
*/

// use secrets framework since it is tiered

#define HAT_GLOBAL_PASSIVES list("MartialMagic")

/datum/SecretInfomation/Spirits_Of_The_World // when given make them make a choice, this choice will then pick these ones below
// place parent functions here
    givenSkills = listr("/obj/Skills/Buffs/SlotlessBuffs/Spirits/Base_Hat_Buff") // TODO: change this typing if wanted

    Goetic_Virtue

    Stellar_Constellation

    Elven_Sanctuary