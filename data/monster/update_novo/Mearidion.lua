local mType = Game.createMonsterType("Mearidion")
local monster = {}

monster.description = "Mearidion"
monster.experience = 7500
monster.outfit = {
	lookType = 1425,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}


monster.health = 9000
monster.maxHealth = 9000
monster.race = "undead"
monster.corpse = 40973
monster.speed = 240
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0
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
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
}

monster.loot = {
}

monster.attacks = {
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -370, range = 7, radius = 3, shootEffect = CONST_ANI_POISONARROW, effect = CONST_ME_GREEN_RINGS, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -250, length = 6, spread = 4, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -50, maxDamage = -500, radius = 3, effect = CONST_ME_ICETORNADO, target = false},
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -50, maxDamage = -300, range = 7, radius = 4, effect = CONST_ME_ICEATTACK, target = true}
	-- Chain: const_me-> CONST_ME_ICEATTACK, combat_t->COMBAT_ICEDAMAGE
}

monster.defenses = {
	defense = 75,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 50},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)