local mType = Game.createMonsterType("parder")
local monster = {}

monster.name = "Parder"
monster.description = "a parder"
monster.experience = 1100
monster.outfit = {
	lookType = 1533,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 1200
monster.maxHealth = 1200
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 44039
monster.speed = 230
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
	chance = 5,
	{text = "Grrroaaar!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 1},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 1},
	{type = COMBAT_FIREDAMAGE, percent = 1},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 1},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -256},
	{name ="melee", interval = 2000, chance = 30, minDamage = 0, maxDamage = -256, effect="scratch"},
	{name ="combat", interval = 2000, chance = 22, type = COMBAT_PHYSICALDAMAGE, minDamage = -258, maxDamage = -292, length = 4, spread = 2, effect = CONST_ME_GROUNDSHAKER},
	{name ="combat", interval = 2000, chance = 22, type = COMBAT_LIFEDRAIN, minDamage = -83, maxDamage = -108, radius = 3, target = false, effect = CONST_ME_MAGIC_RED}
}

monster.defenses = {
	defense = 1,
	armor = 33
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 285},
	{name = "ham", chance = 24556},
	{name = "parder fur", chance = 18833},
	{name = "parder tooth", chance = 13833, maxCount = 2},
	{name = "red crystal fragment", chance = 13556},
	{name = "strong health potion", chance = 7889, maxCount = 3},
	{name = "barbarian axe", chance = 4556},
	{id = 7385, chance = 1333}
}

mType:register(monster)
