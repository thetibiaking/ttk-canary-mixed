local mType = Game.createMonsterType("Bashmu")
local monster = {}

monster.description = "a bashmu"
monster.experience = 5000
monster.outfit = {
	lookType = 1408,
	lookHead = 123,
	lookBody = 123,
	lookLegs = 99,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}


monster.raceId = 2100
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Salt Caves"
}

monster.health = 8200
monster.maxHealth = 8200
monster.race = "blood"
monster.corpse = 40921
monster.speed = 300
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 70,
	damage = 30,
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
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
}

monster.loot = {
	{name = "gold coin", chance = 595300, maxCount = 100},
	{name = "gold coin", chance = 40000, maxCount = 99},
	{name = "small emerald", chance = 6380, maxCount = 5},
	{name = "platinum coin", chance = 59800, maxCount = 5},
	{id = 40879, chance = 3670, maxCount = 2},
	{name = "bashmu fang", chance = 3980},
	{name = "bashmu feather", chance = 1510},
	{name = "bashmu tongue", chance = 1006},
	{name = "fire sword", chance = 4380},
	{name = "meat", chance = 30000, maxCount = 6},
	{name = "dragon scale mail", chance = 1750},
	{name = "great health potion", chance = 5120, maxCount = 2},
	{name = "ultimate mana potion", chance = 5120, maxCount = 3}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -452},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -80, maxDamage = -400, range = 7, shootEffect = CONST_ANI_POISON, target = false},
	{name ="outfit", interval = 2000, chance = 1, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 3000, outfitItem = 3976},
	{name ="speed", interval = 2000, chance = 25, speedChange = -850, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true, duration = 12000},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -250, maxDamage = -600, length = 8, spread = 3, effect = CONST_ME_SOUND_RED, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -250, maxDamage = -600, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 65,
	armor = 65,
		{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 250, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 340, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
