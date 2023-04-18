local mType = Game.createMonsterType("Stalking Stalk")
local monster = {}

monster.name = "Stalking Stalk"
monster.description = "a stalking stalk"
monster.experience = 11569 
monster.outfit = {
	lookType = 1554,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2272
monster.Bestiary = {
	class = "Plant",
	race = BESTY_RACE_PLANT,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "Gnomprona"
	}

monster.health = 17100
monster.maxHealth = 17100
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44142
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
	{text = "Shriiiiek! Shriiiiek!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -25},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 35},
	{type = COMBAT_FIREDAMAGE, percent = 35},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -110},
	{name ="combat", interval = 600, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -500, length = 1, spread = 7, effect = CONST_ANI_FIRE, target = true},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_EXPLOSIONHIT},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_EARTHDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_SMALLPLANTS},
	{name ="stalkingstalk", interval = 1000, chance = 23, minDamage = 100, maxDamage = -400, target = true},
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "small diamond", chance = 50000, maxCount = 1},
	{name = "crystal coin", chance = 10000, maxCount = 3},
	{name = "small diamond", chance = 9700, maxCount = 1},
	{name = "dragon necklace", chance = 8000, maxCount = 1},
	{name = "green crystal fragment", chance = 5600, maxCount = 1},
	{name = "opal", chance = 4750, maxCount = 1},
	{name = "magma coat", chance = 3800},
	{name = "warrior's axe", chance = 3361},
	{name = "muck rod", chance = 2700},
	{name = "bow", chance = 1568, maxCount = 1},
	{name = "green gem", chance = 800, maxCount = 1},
}

mType:register(monster)
