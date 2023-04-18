local mType = Game.createMonsterType("Blemished Spawn")
local monster = {}

monster.description = "a blemished spawn"
monster.experience = 2600
monster.outfit = {
	lookType = 1401,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2093
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Antrum of the Fallen"
}

monster.health = 9000
monster.maxHealth = 9000
monster.race = "blood"
monster.corpse = 41536
monster.speed = 260
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Pik Pik Pik!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 200},
	{name = "platinum coin", chance = 999900, maxCount = 20},
	{name = "brown piece of cloth", chance = 15120},
	{name = "blemished spawn head", chance = 15120, maxCount = 15},
	{name = "blemished spawn abdomen", chance = 10470},
	{name = "white piece of cloth", chance = 10230},
	{name = "great mana potion", chance = 4960, maxCount = 2},
	{name = "great health potion", chance = 4950, maxCount = 2},
	{name = "blue piece of cloth", chance = 4440},
	{name = "red piece of cloth", chance = 2670},
	{name = "blemished spawn tail", chance = 2180},
	{name = "terra boots", chance = 1950},
	{name = "angelic axe", chance = 1420},
	{name = "terra legs", chance = 1160},
	{name = "terra mantle", chance = 870},
	{name = "muck rod", chance = 640},
	{name = "mushroom backpack", chance = 20},
	{name = "mycological bow", chance = 140}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -430},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -180, maxDamage = -350, range = 7, shootEffect = CONST_ANI_SMALLEARTH, effect = CONST_ME_SMALLPLANTS, target = false},
	{name ="poisonfield", interval = 2000, chance = 20, radius = 4, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -500, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -230, maxDamage = -260, length = 5, spread = 3, effect = CONST_ME_MAGIC_RED, target = false},
	-- poison
	{name ="condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -400, maxDamage = -640, range = 7, radius = 3, effect = CONST_ME_HITBYPOISON, target = false}
}

monster.defenses = {
	defense = 0,
	armor = 70,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 225, maxDamage = 380, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 15, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = -15},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
