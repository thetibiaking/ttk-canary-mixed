local mType = Game.createMonsterType("Mantosaurus")
local monster = {}

monster.name = "Mantosaurus"
monster.description = "a mantosaurus"
monster.experience = 11569 
monster.outfit = {
	lookType = 1556,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2274
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 5000,
	FirstUnlock = 500,
	SecondUnlock = 1000,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "Gnomprona"
	}
	
monster.health = 17450
monster.maxHealth = 17450
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44150
monster.speed = 205
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
	{text = "Klkkk... Klkkk...!", yell = false}
}


monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -5},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -110},
	--{name ="combat", interval = 1000, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, effect = CONST_ME_ENERGYHIT},
	{name ="combat", interval = 500, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, effect = CONST_ME_ENERGYAREA},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_EXPLOSIONHIT},
	--{name ="combat", interval = 1200, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 2, target = false, effect = CONST_ME_ENERGYHIT},
	--{name ="headpecker_spell", interval = 1200, chance = 23, minDamage = 100, maxDamage = -400, target = false},
}

monster.defenses = {
	defense = 1,
	armor = 65
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "mantosaurus jaw", chance = 10000, maxCount = 1},
	{name = "silver brooch", chance = 9700, maxCount = 1},
	{name = "cyan crystal fragment", chance = 8000, maxCount = 1},
	{id = 6093, chance = 5600, maxCount = 1},
}

mType:register(monster)
