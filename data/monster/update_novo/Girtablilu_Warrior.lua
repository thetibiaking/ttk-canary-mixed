local mType = Game.createMonsterType("Girtablilu Warrior")
local monster = {}

monster.description = "an Girtablilu Warrior"
monster.experience = 5600
monster.outfit = {
	lookType = 1407,
	lookHead = 114,
	lookBody = 116,
	lookLegs = 113,
	lookFeet = 113,
	lookAddons = 3,
	lookMount = 0
}

monster.raceId = 2099
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Ruins of Nuur"
}

monster.health = 8500
monster.maxHealth = 8500
monster.race = "blood"
monster.corpse = 40953
monster.speed = 400
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	pushable = true,
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
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Tip tap tip tap!", yell = false}
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 14},
	{name = "energy ring", chance = 2050},
	{name = "silver amulet", chance = 3000},
	{name = "sword ring", chance = 3050},
	{name = "girtablilu warrior carapace", chance = 6800},
	{name = "elven amulet", chance = 8100, maxCount = 2},
	{name = "life ring", chance = 5560},
	{name = "old girtablilu carapace", chance = 5120},
	{name = "ring of healing", chance = 3120},
	{name = "strange talisman", chance = 2110},
	{name = "axe ring", chance = 2220},
	{name = "power ring", chance = 1080},
	{name = "garlic necklace", chance = 2550},
	{name = "platinum amulet", chance = 1650},
	{name = "stone skin amulet", chance = 2600},
	{name = "necklace of the deep", chance = 1800}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350},
	{name ="arachnophobicawavedice", interval = 2000, chance = 20, minDamage = -250, maxDamage = -350, target = false},
	{name ="arachnophobicawaveenergy", interval = 2000, chance = 20, minDamage = -250, maxDamage = -350, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -350, radius = 4, effect = CONST_ME_BLOCKHIT, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -300, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = false}
}

monster.defenses = {
	defense = 0,
	armor = 70,
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 150, maxDamage = 550, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -15},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
