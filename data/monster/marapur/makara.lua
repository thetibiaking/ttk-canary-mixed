local mType = Game.createMonsterType("makara")
local monster = {}

monster.name = "Makara"
monster.description = "a makara"
monster.experience = 6148
monster.outfit = {
	lookType = 1565,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 4770
monster.maxHealth = 4770
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 44201
monster.speed = 300
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
	{text = "waddle waddle", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = -5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -15},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 5}
}

monster.attacks = {
	{name ="melee", interval = 1000, chance = 1000, minDamage = 0, maxDamage = -361},
	{name ="combat", interval = 1000, chance = 21, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -320, effect = CONST_ME_ICEATTACK},
	{name ="combat", interval = 1000, chance = 18, type = COMBAT_ICEDAMAGE, minDamage = -287, maxDamage = -758, radius = 4, target = false, effect = CONST_ME_ICEAREA}
}

monster.defenses = {
	defense = 1,
	armor = 74
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 13},
	{name = "makara fin", chance = 10323},
	{name = "makara tongue", chance = 9677},
	{name = "meat", chance = 8355},
	{name = "green crystal fragment", chance = 2871},
	{name = "green crystal shard", chance = 2581},
	{name = "yellow gem", chance = 2516},
	{name = "rainbow quartz", chance = 2452, maxCount = 2},
	{name = "cyan crystal fragment", chance = 2355},
	{name = "blue gem", chance = 2097},
	{name = "small diamond", chance = 1935, maxCount = 3},
	{name = "sea horse figurine", chance = 355}
}

mType:register(monster)
