local mType = Game.createMonsterType("Iks Pututu")
local monster = {}

monster.description = "a Iks Pututu"
monster.experience = 980
monster.outfit = {
	lookType = 1589,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2343
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Drefia Grim Reaper Dungeons, deep in Drefia Wyrm Lair (after the Medusa Shield Quest), \z
		Edron (Hero Cave), Yalahar (Cemetery Quarter), Oramond Dungeon, \z
		  Abandoned Sewers and optionally in the Demon Oak Quest."
	}

monster.health = 1310
monster.maxHealth = 1310
monster.race = "blood"
monster.corpse = 42061
monster.speed = 186
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Shriiiek", yell = true}
}

monster.loot = {
	{name = "emerald bangle", chance = 540},
	{name = "small sapphire", chance = 5000},
	{name = "Spellbook of Enlightenment", chance = 10000},
	{name = "Tiger Eye", chance = 810},
--	{name = "Gold-Brocaded Cloth", chance = 3400},
--	{name = "Rotten Feather", chance = 60500},
	{name = "Opal", chance = 410},
	{name = "Strong Mana Potion", chance = 2500},
	{name = "Gold Ingot", chance = 12300},
--	{name = "Ritual Tooth", chance = 12300},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -498},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = 386, maxDamage = -480, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, target = true},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -360, maxDamage = -420, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREATTACK, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_HOLYDAMAGE, minDamage = -400, maxDamage = -800, length = 4, spread = 0, effect = CONST_ME_STONES, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -800, length = 4, spread = 0, effect = CONST_ME_ORANGE_ENERGY_SPARK, target = false},

}

monster.defenses = {
	defense = 25,						 
	armor = 25,

}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
