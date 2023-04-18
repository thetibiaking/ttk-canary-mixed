local mType = Game.createMonsterType("The Abomination")
local monster = {}

monster.description = "The Abomination"
monster.experience = 500000
monster.outfit = {
	lookType = 1393,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 250000
monster.maxHealth = 250000
monster.race = "blood"
monster.corpse = 40998
monster.speed = 460
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 10
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
	canPushCreatures = false,
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
	{text = "*** STEALTH ***", yell = false},
	{text = "*** TIME ***", yell = false},
	{text = "*** IMPORTANT ***", yell = false},
	{text = "*** BRAINS *** SMALL ***", yell = false},
	{text = "*** DEATH ***", yell = false},
	{text = "*** FIRE *** HOME *** VICTORY ***", yell = false},
	{text = "*** EXISTENCE *** FUTILE ***", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 96000, maxCount = 30},
	{id = 40916, chance = 10000, maxCount = 4},
	{name = "ultimate mana potion", chance = 8885, maxCount = 10},
	{name = "ultimate health potion", chance = 3880, maxCount = 10},
	{name = "black pearl", chance = 7700, maxCount = 15},
	{id = 40876, chance = 1000},
	{id = 40877, chance = 1000},
	{id = 40878, chance = 1000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 90, attack = 120},
	{name ="speed", interval = 1000, chance = 12, speedChange = -800, radius = 6, effect = CONST_ME_POISONAREA, target = false, duration = 10000},
	{name ="combat", interval = 1000, chance = 9, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -650, radius = 4, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 1000, chance = 11, type = COMBAT_LIFEDRAIN, minDamage = -400, maxDamage = -900, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_SOUND_GREEN, target = true},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -850, length = 7, spread = 3, shootEffect = CONST_ANI_POISON, target = false}
}

monster.defenses = {
	defense = 20,
	armor = 15,
	{name ="combat", interval = 1000, chance = 1, type = COMBAT_HEALING, minDamage = 0, maxDamage = 15000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="combat", interval = 5000, chance = 30, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 25, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 50},
	{type = COMBAT_ENERGYDAMAGE, percent = 50},
	{type = COMBAT_EARTHDAMAGE, percent = 50},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 100},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 50},
	{type = COMBAT_HOLYDAMAGE , percent = 50},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
