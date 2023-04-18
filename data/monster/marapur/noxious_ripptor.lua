local mType = Game.createMonsterType("Noxious Ripptor")
local monster = {}

monster.name = "Noxious Ripptor"
monster.description = "a noxious ripptor"
monster.experience = 13190 
monster.outfit = {
	lookType = 1558,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2276
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 5000,
	FirstUnlock = 100,
	SecondUnlock = 500,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 3,
	Locations = "gnomprona"
	}


monster.health = 21500
monster.maxHealth = 21500
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44155
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
	{text = "Krccchht!", yell = false}
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
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -110},
	--{name ="combat", interval = 1000, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, effect = CONST_ME_ENERGYHIT},
	--{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, effect = CONST_ME_EXPLOSIONAREA},
	--{name ="combat", interval = 600, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -500, length = 1, spread = 7, shootEffect = CONST_ANI_LARGEROCK, target = true},
	{name ="noxius_spell", interval = 1200, chance = 23, minDamage = 100, maxDamage = -400, target = true},
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "ripptor scales", chance = 10000, maxCount = 2},
	{name = "ultimate health potion", chance = 9700, maxCount = 1},
	{name = "ripptor claw", chance = 8000, maxCount = 1},
	{name = "sacred tree amulet", chance = 8000, maxCount = 1}
}

mType:register(monster)
