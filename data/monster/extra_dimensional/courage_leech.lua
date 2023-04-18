local mType = Game.createMonsterType("Courage Leech")
local monster = {}

monster.description = "a courage leech"
monster.experience = 23920
monster.outfit = {
	lookType = 1315,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1941
monster.Bestiary = {
	class = "Extra Dimensional",
	race = BESTY_RACE_EXTRA_DIMENSIONAL,
	toKill = 5000,
	FirstUnlock = 25,
	SecondUnlock = 2500,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Furious Crater."
	}

monster.health = 27000
monster.maxHealth = 27000
monster.race = "undead"
monster.corpse = 38744
monster.speed = 236
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
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
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Hiss.", yell = false},
	{text = "Zap! Zap!", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 10540},
	{name = "lightning legs", chance = 3500},
	{name = "ultimate health potion", chance = 52220, maxCount = 7},
	{name = "lightning pendant", chance = 3000},
	{name = "lightning headband", chance = 33500},
	{name = "gold ring", chance = 4500},
	{name = "jade hammer", chance = 3000},
	{name = "hammer of wrath", chance = 3000},
	{name = "onyx flail", chance = 3500},
	{name = "twiceslicer", chance = 3500},
	{name = "stone skin amulet", chance = 1500},
	{name = "nightmare blade", chance = 3000},
	{name = "demonrage sword", chance = 3000},
	{name = "dreaded cleaver", chance = 3000},
	{name = "butcher's axe", chance = 1000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -1200},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -1200, radius = 4, shootEffect = CONST_ANI_ETHEREALSPEAR, effect = CONST_ME_ENERGYAREA, target = true},
	{name ="combat", interval = 3000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -1200, radius = 4, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HOLYDAMAGE, minDamage = -750, maxDamage = -1000, range = 7, shootEffect = CONST_ANI_SMALLHOLY, effect = CONST_ME_HOLYDAMAGE, target = true}
	-- Chain: const_me-> CONST_ME_PINK_ENERGY_SPARK, combat_t->COMBAT_ENERGYDAMAGE
}

monster.defenses = {
	defense = 90,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = 50},
	{type = COMBAT_EARTHDAMAGE, percent = -20},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 30},
	{type = COMBAT_DEATHDAMAGE , percent = -25}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
