local mType = Game.createMonsterType("Training Monk")
local monster = {}

monster.description = "a monk"
monster.experience = 0
monster.outfit = {
	lookType = 57,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 57
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 500,
	FirstUnlock = 25,
	SecondUnlock = 250,
	CharmsPoints = 15,
	Stars = 2,
	Occurrence = 0,
	Locations = "Edron Hero Cave, Triangle Tower near Thais, Maze of Lost Souls, Deeper Dark Cathedral, \z
		Isle of the Kings, Trade Quarter."
	}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "blood"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 600
monster.maxSummons = 0

monster.changeTarget = {
	interval = 1000,
	chance = 0
}

monster.strategiesTarget = {
	nearest = 70,
	health = 20,
	damage = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	targetDistance = 1,
	staticAttackChance = 100,
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	
}

monster.loot = {
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = 0}
}

monster.defenses = {
	defense = 1,
	armor = 1,
	{name ="combat", interval = 2000, chance = 100, type = COMBAT_HEALING, minDamage = 600, maxDamage = 2000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
}

monster.immunities = {
}

mType:register(monster)
