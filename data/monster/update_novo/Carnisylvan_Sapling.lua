local mType = Game.createMonsterType("Carnisylvan Sapling")
local monster = {}

monster.description = "a Carnisylvan Sapling"
monster.experience = 200
monster.outfit = {
	lookType = 1419,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}


monster.health = 750
monster.maxHealth = 750
monster.race = "blood"
monster.corpse = 41720
monster.speed = 240
monster.manaCost = 450
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 20,
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
	{text = "Glamour, glitter, glistering things! Do you have any of those?", yell = false},
	{text = "Sweet dreams!", yell = false},
	{text = "You might be a threat! I'm sorry but I can't allow you to linger here.", yell = false},
	{text = "Let's try a step or two!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 30000, maxCount = 90},
	{name = "butterfly ring", chance = 292},
	{name = "Wand of Starstorm", chance = 892},
	{name = "carnisylvan finger", chance = 920},
	{name = "green mushroom", chance = 492}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -250},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -85, maxDamage = -135, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true},
	{name ="speed", interval = 2000, chance = 11, speedChange = -440, length = 4, spread = 2, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 7000},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = 0, maxDamage = -100, range = 4, shootEffect = CONST_ANI_LEAFSTAR, target = false},
	{name ="pixie skill reducer", interval = 2000, chance = 20, target = false}
}

monster.defenses = {
	defense = 45,
	armor = 50,
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 40, maxDamage = 75, effect = CONST_ME_MAGIC_GREEN, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 30},
	{type = COMBAT_EARTHDAMAGE, percent = 30},
	{type = COMBAT_FIREDAMAGE, percent = 30},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 100},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 30},
	{type = COMBAT_HOLYDAMAGE , percent = 30},
	{type = COMBAT_DEATHDAMAGE , percent = 30}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
