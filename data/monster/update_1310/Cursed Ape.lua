local mType = Game.createMonsterType("Cursed Ape")
local monster = {}

monster.description = "a Cursed Ape"
monster.experience = 1860
monster.outfit = {
	lookType = 1592,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2347
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 250,
	CharmsPoints = 25,
	Stars = 2,
	Occurrence = 0,
	Locations = "Ghost Ship, Drefia, Ankrahmun Tombs, Mount Sternum Undead Cave between Thais and Kazordoon, \z
		Dark Cathedral, under Treasure Island, Isle of the Kings, Grothmok tunnels (in Dwarven Mines), Goroma, \z
		Ramoa, Lich Hell, Upper Spike."
	}

monster.health = 1700
monster.maxHealth = 1700
monster.race = "blood"
monster.corpse = 42073
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
	{name = "emerald bangle", chance = 540},
	{name = "small sapphire", chance = 5000},
	{name = "gold coin", chance = 100000, maxCount = 90},
	{name = "Ape Fur", chance = 810},
	{name = "Small Health Potion", chance = 3400, maxCount = 2},
	{name = "Plate Armor", chance = 60500},
	{name = "Kongra's Shoulderpad", chance = 410},
	{name = "strong health potion", chance = 2500},
	{name = "wyvern talisman", chance = 12300}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -498},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -360, maxDamage = -420, range = 7, radius = 4, effect = CONST_ME_MORTAREA, target = false},
	
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 45, maxDamage = 65, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000}
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
