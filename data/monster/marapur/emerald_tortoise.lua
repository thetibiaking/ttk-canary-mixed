local mType = Game.createMonsterType("Emerald Tortoise")
local monster = {}

monster.name = "Emerald Tortoise"
monster.description = "a emerald tortoise"
monster.experience = 12129 
monster.outfit = {
	lookType = 1550,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2268
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 5000,
	FirstUnlock = 500,
	SecondUnlock = 1000,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "Gnomprona"
	}
	
monster.health = 22300
monster.maxHealth = 22300
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44126
monster.speed = 179
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
	targetDistance = 0,
	healthHidden = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 1,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Shllpp...!", yell = false}
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
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 220},
	--{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 6, target = true, effect = CONST_ME_EXPLOSIONAREA},
	--{name ="combat", interval = 1200, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 2, target = false, effect = CONST_ME_ENERGYHIT},
	{name ="esmeral_tortoise_spell", interval = 1200, chance = 23, minDamage = 600, maxDamage = -4400, target = false},
}

monster.defenses = {
	defense = 1,
	armor = 97
}

monster.loot = {
	{name = "emerald tortoise shell", chance = 50000, maxCount = 1},
	{name = "crystal coin", chance = 10000, maxCount = 3},
	{name = "great spirit potion", chance = 9700, maxCount = 1},
	{name = "green crystal fragment", chance = 8000, maxCount = 1},
	{name = "blue crystal shard", chance = 5600, maxCount = 1},
	{name = "violet gem", chance = 4750, maxCount = 1},
	{name = "white pearl", chance = 3800},
	{name = "red crystal fragment", chance = 3100},
	{name = "green crystal shard", chance = 2700},
	{name = "green gem", chance = 2650},
	{name = "orichalcum pearl", chance = 2550 , maxCount = 2},
	{id = 7632, chance = 2361},
	{name = "red gem", chance = 2300},
	{name = "black pearl", chance = 2700 , maxCount = 2}
}

mType:register(monster)
