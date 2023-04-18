local mType = Game.createMonsterType("Shrieking Cry-Stal")
local monster = {}

monster.name = "Shrieking Cry-Stal"
monster.description = "a shrieking cry-stal"
monster.experience = 13560 
monster.outfit = {
	lookType = 1560,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2278
monster.Bestiary = {
	class = "Construct",
	race = BESTY_RACE_CONSTRUCT,
	toKill = 5000,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Gnomprona"
	}


monster.health = 18700
monster.maxHealth = 18700
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44166
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
	{text = "La-la-la..AAAHHHH!!!", yell = false},
	{text = "SCREEECH...", yell = false}
}


monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = -5},
	{type = COMBAT_FIREDAMAGE, percent = 5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 5},
	{type = COMBAT_HOLYDAMAGE , percent = 100},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 210},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -1342, maxDamage = -4364, radius = 2, target = true, effect = CONST_ME_SOUND_GREEN},
	{name ="shrieking_spell_front_energy", interval = 1200, chance = 23, minDamage = 800, maxDamage = -3400, target = true},
	{name ="shrieking_spell", interval = 1200, chance = 23, minDamage = 700, maxDamage = -4300, target = true},
}

monster.defenses = {
	defense = 1,
	armor = 95
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "great spirit potion", chance = 10000, maxCount = 2},
	{name = "small diamond", chance = 9700, maxCount = 1},
	{name = "rusted armor", chance = 8000, maxCount = 1},
	{name = "green crystal fragment", chance = 8000, maxCount = 1}
}

mType:register(monster)
