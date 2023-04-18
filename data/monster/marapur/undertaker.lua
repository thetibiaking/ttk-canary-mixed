local mType = Game.createMonsterType("Undertaker")
local monster = {}

monster.name = "Undertaker"
monster.description = "a undertaker"
monster.experience = 13543 
monster.outfit = {
	lookType = 1551,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 20100
monster.maxHealth = 20100
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44130
monster.speed = 215
monster.summonCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5
}

monster.raceId = 2269
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 1,
	Occurrence = 0,
	Locations = "gnomprona"
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
	{text = "Hizzzzz!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -15},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 5},
	{type = COMBAT_DEATHDAMAGE , percent = 40}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -110},
	{name ="undetakerspell", interval = 1000, chance = 23, minDamage = 100, maxDamage = -400, target = false},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_EARTHDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_SMALLPLANTS},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_DEATHDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, shootEffect = CONST_ANI_DEADTH , effect = CONST_ME_MORTAREA},
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "great spirit potion", chance = 50000, maxCount = 3},
	{name = "undertaker fangs", chance = 10000, maxCount = 3},
	{name = "spider silk", chance = 9700, maxCount = 1},
	{name = "terra boots", chance = 8000, maxCount = 1},
	{name = "blue crystal shard", chance = 5600, maxCount = 1},
	{name = "terra legs", chance = 4750, maxCount = 1},
	{name = "necrotic rod", chance = 3800},
	{name = "relic sword", chance = 3361},
	{name = "butterfly ring", chance = 2700},
	{name = "wand of voodoo", chance = 1568, maxCount = 1},
	{name = "violet gem", chance = 800, maxCount = 1},
}

mType:register(monster)
