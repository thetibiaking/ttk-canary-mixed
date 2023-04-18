local mType = Game.createMonsterType("Sabretooth")
local monster = {}

monster.description = "a sabretooth"
monster.experience = 11931
monster.outfit = {
	lookType = 1549,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2267
monster.Bestiary = {
	class = "Mammal",
	race = BESTY_RACE_MAMMAL,
	toKill = 5000,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "Gnomprona"
	}

monster.health = 17300
monster.maxHealth = 17300
monster.race = "blood"
monster.corpse = 44122
monster.speed = 200
monster.manaCost = 420

monster.changeTarget = {
	interval = 2500,
	chance = 25
}

monster.strategiesTarget = {
	nearest = 70,
	damage = 30,
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "crystal coin", chance = 80000, maxCount = 5},
	{name = "platinum coin", chance = 100000, maxCount = 100},
	{name = "sabretooth", chance = 60000, maxCount = 3},
	{name = "green crystal fragment", chance = 10000, maxCount = 80},
	{name = "mould heart", chance = 8000},
	{name = "green gem", chance = 4000, maxCount = 60},
	{name = "stone skin amulet", chance = 5000,},
	{name = "gold ingot", chance = 14000, maxCount = 50},
	{name = "small topaz", chance = 15000, maxCount = 50},
	{name = "iron ore", chance = 15000, maxCount = 50},
	{name = "young lich worm", chance = 4000, maxCount = 3},
	{name = "terra amulet", chance = 5000,},
	{name = "terra mantle", chance = 4000,},
	{name = "terra boots", chance = 4000,}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -3100},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1500, maxDamage = -4550, radius = 3, effect = 215, target = false},
}

monster.defenses = {
	defense = 0,
	armor = 63,
	{name ="speed", interval = 2000, chance = 15, speedChange = 800, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = -10},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
