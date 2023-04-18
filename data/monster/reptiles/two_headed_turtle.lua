local mType = Game.createMonsterType("Two-Headed Turtle")
local monster = {}

monster.name = "Two-Headed Turtle"
monster.description = "a two-headed turtle"
monster.experience = 2930
monster.outfit = {
	lookType = 1535,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 5000
monster.maxHealth = 5000
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 1
monster.speed = 320
monster.summonCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5
}

monster.flags = {
	attackable = true,
	hostile = true,
	summonable = false,
	convinceable = false,
	illusionable = false,
	boss = false,
	ignoreSpawnBlock = false,
	pushable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	healthHidden = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 1,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Krk! Krk!", yell = false},
	{text = "BONK!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 120},
	{type = COMBAT_FIREDAMAGE, percent = -50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -50},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 110}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -391},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -266, maxDamage = -328, radius = 3, target = false, effect = CONST_ME_ENERGYHIT},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 3, target = false, effect = CONST_ME_ENERGYHIT},
	{name ="combat", interval = 1999, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -231, maxDamage = -328, radius = 1, target = false, effect = CONST_ME_EXPLOSIONAREA}
}

monster.defenses = {
	defense = 1,
	armor = 72
}

monster.loot = {
	{id = 3035, chance = 100000, maxCount = 27},
	{id = 239, chance = 15915},
	{id = 39409, chance = 15000},
	{id = 237, chance = 12615},
	{id = 39410, chance = 10964},
	{id = 3115, chance = 6491},
	{id = 819, chance = 4180},
	{id = 39408, chance = 3850},
	{id = 281, chance = 3447},
	{id = 24391, chance = 3044},
	{id = 828, chance = 2420},
	{id = 3017, chance = 2384},
	{id = 24392, chance = 2017},
	{id = 3371, chance = 1870},
	{id = 814, chance = 1577},
	{id = 3040, chance = 1430},
	{id = 3010, chance = 1283},
	{id = 8072, chance = 1283},
	{id = 3565, chance = 1100},
	{id = 10422, chance = 733},
	{id = 32769, chance = 440}
}

mType:register(monster)
