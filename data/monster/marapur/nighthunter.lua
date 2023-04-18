local mType = Game.createMonsterType("Nighthunter")
local monster = {}

monster.name = "Nighthunter"
monster.description = "a nighthunter"
monster.experience = 12647
monster.outfit = {
	lookType = 1552,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2270
monster.Bestiary = {
	class = "Mammal",
	race = BESTY_RACE_MAMMAL,
	toKill = 2500,
	FirstUnlock = 500,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 1,
	Occurrence = 0,
	Locations = "Gnomprona"
	}
	
monster.health = 19200
monster.maxHealth = 19200
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44134
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
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -25},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 210},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_POISONDAMAGE, minDamage = -1342, maxDamage = -3364, radius = 4, target = false, shootEffect = CONST_ME_GREEN_RINGS , effect = CONST_ME_HITBYPOISON},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_POISONDAMAGE, minDamage = -1342, maxDamage = -4764, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_EXPLOSIONHIT},

	
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "nighthunter wing", chance = 10000, maxCount = 2},
	{name = "red crystal fragment", chance = 9700, maxCount = 1},
	{name = "ultimate health potion", chance = 8000, maxCount = 3},
	{name = "green crystal shard", chance = 5600, maxCount = 1},
	{name = "cyan crystal fragment", chance = 4750},
	{name = "yellow gem", chance = 3800},
	{name = "warrior's axe", chance = 3361},
	{name = "crystal sword", chance = 2700},
	{name = "spellbook of mind control", chance = 1568, maxCount = 1},
	{name = "stone skin amulet", chance = 800, maxCount = 1},
}

mType:register(monster)
