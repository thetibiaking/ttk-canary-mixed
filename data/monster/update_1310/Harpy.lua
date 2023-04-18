local mType = Game.createMonsterType("Harpy")
local monster = {}

monster.description = "a Harpy"
monster.experience = 5720
monster.outfit = {
	lookType = 1604,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2340
monster.Bestiary = {
	class = "Bird",
	race = BESTY_RACE_BIRD,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Deeper Ingol, Ingol"
	}

monster.health = 7700
monster.maxHealth = 7700
monster.race = "blood"
monster.corpse = 42222
monster.speed = 186
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 2,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Shriiiek", yell = true}
}

monster.loot = {
	{name = "Platinum Coin", chance = 100000, maxCount = 20},
	{name = "Blue Crystal Shard", chance = 540},
	{name = "Violet Crystal Shard", chance = 5000},
--	{name = "Harpy Feathers", chance = 810},
	{name = "Gold Ring", chance = 3400},
	{name = "Great Spirit Potion", chance = 60500, maxCount = 3},
	{name = "Focus Cape", chance = 410},
	{name = "Ornate Crossbow", chance = 2500},
	{name = "Shockwave Amulet", chance = 12300},
	{name = "Wand of Defiance", chance = 12300},
	{name = "Magic Plate Armor", chance = 12300},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 300, maxDamage = -345},
	{name ="combat", interval = 2000, chance = 47, type = COMBAT_PHYSICALDAMAGE, minDamage = -296, maxDamage = -350, effect = CONST_ME_BIG_SCRATCH, target = true},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -260, maxDamage = -300, length = 5, spread = 3, effect = CONST_ME_SOUND_BLUE, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -360, maxDamage = -420, range = 7, radius = 4, effect = CONST_ME_ENERGYHIT, target = true},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -360, maxDamage = -420, range = 1, radius = 8, effect = CONST_ME_LIGHTBLUETELEPORT, target = false},
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -360, maxDamage = -420, range = 7, radius = 4, effect = CONST_ME_PURPLESMOKE, target = true},
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 0, maxDamage = 0, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
