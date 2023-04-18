local mType = Game.createMonsterType("Rhindeer")
local monster = {}

monster.description = "a Rhindeer"
monster.experience = 5600
monster.outfit = {
	lookType = 1606,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2342
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "The Wreckoning"
	}

monster.health = 8650
monster.maxHealth = 8650
monster.race = "blood"
monster.corpse = 42230
monster.speed = 186
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Shriiiek", yell = true}
}

monster.loot = {
	{name = "Platinum Coin", chance = 100000, maxCount = 20},
	{name = "Violet Gem", chance = 540},
	{name = "Brown Crystal Splinter", chance = 5000},
	{name = "Rainbow Quartz", chance = 810},
--	{name = "Rhindeer Antlers", chance = 3400, maxCount = 2},
	{name = "Great Mana Potion", chance = 2500},
	{name = "Yellow Gem", chance = 60500, maxCount = 3},
	{name = "Knight Armor", chance = 410},
	{name = "Titan Axe", chance = 12300},
	{id = 3090, chance = 12300},
	{name = "Heavy Mace", chance = 12300},
	{name = "Mastermind Shield", chance = 12300},
	{id = 23543, chance = 12300}
	
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -475, effect = CONST_ME_GROUNDSHAKER, target = true},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -265, maxDamage = -411, range = 1, radius = 4, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -265, maxDamage = -337, range = 1, radius = 4, effect = CONST_ME_EXPLOSIONAREA, target = false},
}

monster.defenses = {
	defense = 68,
	armor = 68,

	}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
