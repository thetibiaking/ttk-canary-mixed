local mType = Game.createMonsterType("Afflicted Strider")
local monster = {}

monster.description = "an afflicted strider"
monster.experience = 5700
monster.outfit = {
	lookType = 1403,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2094
monster.Bestiary = {
	class = "Vermin",
	race = BESTY_RACE_VERMIN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Antrum of the Fallen"
}

monster.health = 12000
monster.maxHealth = 12000
monster.race = "blood"
monster.corpse = 41554
monster.speed = 340
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
	interval = 5000,
	chance = 10,
	{text = "You're so little!", yell = false},
	{text = "Human flesh -  delicious!", yell = false},
	{text = "Crush the intruders!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 595300, maxCount = 100},
	{name = "gold coin", chance = 40000, maxCount = 99},
	{name = "small amethyst", chance = 6380, maxCount = 5},
	{name = "platinum coin", chance = 59800, maxCount = 5},
	{name = "afflicted strider worms", chance = 5980},
	{name = "double axe", chance = 10510},
	{name = "giant sword", chance = 1006},
	{name = "steel boots", chance = 380},
	{name = "meat", chance = 30000, maxCount = 6},
	{name = "assassin star", chance = 9750, maxCount = 5},
	{name = "titan axe", chance = 90},
	{name = "great health potion", chance = 5120, maxCount = 2},
	{name = "ultimate mana potion", chance = 5120, maxCount = 3}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -850},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -410, range = 3, effect = CONST_ME_HOLYAREA, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_HOLYDAMAGE, minDamage = -170, maxDamage = -400, range = 3, shootEffect = CONST_ANI_HOLY, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -250, maxDamage = -350, length = 4, spread = 1, effect = CONST_ME_FIREAREA, target = false}
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{name ="speed", interval = 2000, chance = 25, speedChange = 450, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 5},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = -15}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
