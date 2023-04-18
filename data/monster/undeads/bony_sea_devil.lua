local mType = Game.createMonsterType("Bony Sea Devil")
local monster = {}

monster.description = "a bony sea devil"
monster.experience = 32500
monster.outfit = {
	lookType = 1294,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1926
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

monster.health = 28000
monster.maxHealth = 28000
monster.race = "undead"
monster.corpse = 38632
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
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Bling.", yell = false},
	{text = "Clank.", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 70540},
	{name = "platinum coin", chance = 90540, maxCount = 32},
	{name = "ultimate health potion", chance = 72220, maxCount = 7},
	{id = 7632, chance = 4560}, -- Giant shimmering pearl
	{id = 7633, chance = 4560}, -- Giant shimmering pearl
	{name = "gold ingot", chance = 3920},
	{name = "glacier kilt", chance = 2920},
	{name = "northwind rod", chance = 1920},
	{name = "wand of voodoo", chance = 4000},
	{name = "glacial rod", chance = 3450},
	{name = "green crystal fragment", chance = 2920},
	{name = "onyx chip", chance = 2000},
	{name = "rainbow quartz", chance = 1660, maxCount = 2},
	{id = 38764, chance = 860}, -- Rod
	{id = 38849, chance = 960}, -- Jaws
	{name = "skullcracker armor", chance = 1680},
	{name = "goblet of gloom", chance = 880}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -800, maxDamage = -1800},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -550, maxDamage = -1100, length = 5, spread = 3, effect = CONST_ME_GROUNDSHAKER, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -1000, radius = 7, effect = CONST_ME_BIGCLOUDS, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -800, maxDamage = -1200, range = 7, shootEffect = CONST_ANI_SNOWBALL, effect = CONST_ME_ICEATTACK, target = true}
}

monster.defenses = {
	defense = 80,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 40},
	{type = COMBAT_FIREDAMAGE, percent = -5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 60},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 5}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
