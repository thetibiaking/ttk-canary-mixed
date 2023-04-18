local mType = Game.createMonsterType("Eyeless Devourer")
local monster = {}

monster.description = "an Eyeless Devourer"
monster.experience = 6000
monster.outfit = {
	lookType = 1399,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}


monster.health = 10000
monster.maxHealth = 10000
monster.race = "blood"
monster.corpse = 41531
monster.speed = 165
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8
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
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Chrchrchr", yell = true},
	{text = "Klonklonk", yell = true},
	{text = "Chrrrrr", yell = true},
	{text = "Crunch crunch", yell = true}
}

monster.loot = {
	{name = "gold coin", chance = 96000, maxCount = 100},
	{name = "platinum coin", chance = 56000, maxCount = 35},
	{name = "ultimate mana potion", chance = 8885},
	{name = "ultimate health potion", chance = 3880},
	{name = "eyeless devourer legs", chance = 5000, maxCount = 2},
	{name = "eyeless devourer maw", chance = 3000},
	{name = "eyeless devourer tongue", chance = 1220},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600, effect = CONST_ME_DRAWBLOOD},
	{name ="combat", interval = 3000, chance = 18, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -300, range = 7, effect = CONST_ME_MAGIC_RED, target = true},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -300, radius = 7, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 3000, chance = 14, type = COMBAT_ENERGYDAMAGE, minDamage = -40, maxDamage = -300, radius = 7, effect = CONST_ME_ENERGYHIT, target = false},
}

monster.defenses = {
	defense = 60,
	armor = 63
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = -5},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
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
