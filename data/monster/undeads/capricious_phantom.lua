local mType = Game.createMonsterType("Capricious Phantom")
local monster = {}

monster.description = "a capricious phantom"
monster.experience = 29900
monster.outfit = {
	lookType = 1298,
	lookHead = 81,
	lookBody = 114,
	lookLegs = 85,
	lookFeet = 83,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1932
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 5000,
	FirstUnlock = 25,
	SecondUnlock = 2500,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Ebb and Flow."
	}

monster.health = 33000
monster.maxHealth = 33000
monster.race = "undead"
monster.corpse = 38956
monster.speed = 300
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0
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
	interval = 5000,
	chance = 10,
	{text = "I hope you can't swim.", yell = false},
	{text = "Troubled Water. Troubled you!", yell = false},
	{text = "You should shiver!", yell = false},
	{text = "You will leak blood.", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 7540},
	{name = "platinum coin", chance = 8220, maxCount = 32},
	{name = "great spirit potion", chance = 32220, maxCount = 7},
	{name = "blue gem", chance = 5560},
	{name = "gold ingot", chance = 5560},
	{name = "violet gem", chance = 7560},
	{name = "wood cape", chance = 2920},
	{name = "ornate crossbow", chance = 2020},
	{name = "glacial rod", chance = 2920},
	{name = "fur armor", chance = 1920},
	{id = 38973, chance = 1460}, -- Capricious heart
	{id = 38980, chance = 1160}, -- Capricious robe
	{id = 26185, chance = 2920}, -- Ring of blue plasma
	{id = 26198, chance = 2920} -- Collar of blue plasma
	
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -800, maxDamage = -1800},
	{name ="combat", interval = 3000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -950, maxDamage = -2800, range = 7, radius = 3, shootEffect = CONST_ANI_POISONARROW, effect = CONST_ME_GREEN_RINGS, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -1950, length = 6, spread = 4, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="combat", interval = 3000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -850, maxDamage = -1500, radius = 3, effect = CONST_ME_ICETORNADO, target = false}
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