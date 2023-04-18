local mType = Game.createMonsterType("Gorerilla")
local monster = {}

monster.name = "Gorerilla"
monster.description = "a gorerilla"
monster.experience = 13172 
monster.outfit = {
	lookType = 1559,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2277
monster.Bestiary = {
	class = "Mammal",
	race = BESTY_RACE_MAMMAL,
	toKill = 5000,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "gnomprona"
	}
	
monster.health = 16850
monster.maxHealth = 16850
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44162
monster.speed = 215
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
	{text = "Shwooosh!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -5},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 210},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -642, maxDamage = -4064, radius = 4, target = false, effect = CONST_ME_EXPLOSIONAREA},
	--{name ="combat", interval = 1200, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 2, target = false, effect = CONST_ME_ENERGYHIT},
	{name ="combat", interval = 600, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -4700, length = 1, spread = 7, shootEffect = CONST_ANI_LARGEROCK, target = true},
	{name ="gorillera_spell", interval = 1200, chance = 23, minDamage = 100, maxDamage = -2800, target = false},
}

monster.defenses = {
	defense = 1,
	armor = 76
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 2},
	{name = "gorerilla mane", chance = 10000, maxCount = 1},
	{name = "gorerilla tail", chance = 9700, maxCount = 1},
	{name = "ultimate mana potion", chance = 8000, maxCount = 1},
	{name = "doublet", chance = 5600, maxCount = 1},
	{name = "magma coat", chance = 4750, maxCount = 1},
	{name = "black pearl", chance = 3800, maxCount = 5},
	{name = "crystal crossbow", chance = 3100}
}

mType:register(monster)
