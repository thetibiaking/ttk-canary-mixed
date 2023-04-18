local mType = Game.createMonsterType("Gore Horn")
local monster = {}

monster.name = "Gore Horn"
monster.description = "a gore horn"
monster.experience = 12595 
monster.outfit = {
	lookType = 1548,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2266
monster.Bestiary = {
	class = "Mammal",
	race = BESTY_RACE_MAMMAL,
	toKill = 5000,
	FirstUnlock = 500,
	SecondUnlock = 1000,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "Gnomprona"
}
	
monster.health = 20620
monster.maxHealth = 20620
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44118
monster.speed = 191
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
	{text = "Rraaaaa!", yell = false}
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
	{type = COMBAT_ENERGYDAMAGE, percent = 35},
	{type = COMBAT_EARTHDAMAGE, percent = 50},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 210},
	--{name ="combat", interval = 600, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -500, length = 1, spread = 7, effect = CONST_ANI_FIRE, target = true},
	--{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_EXPLOSIONHIT},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -642, maxDamage = -4200, radius = 6, target = true, effect = CONST_ME_EXPLOSIONAREA},
	{name ="combat", interval = 600, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -642, maxDamage = -4400, radius = 4, target = false, effect = CONST_ME_ENERGYHIT},
	{name ="gorehornfronta", interval = 1000, chance = 23, minDamage = 600, maxDamage = -4400, target = false},
}

monster.defenses = {
	defense = 1,
	armor = 78
}

monster.loot = {
	{id = 44212, chance = 50000, maxCount = 1},
	{name = "crystal coin", chance = 10000, maxCount = 1},
	{id = 2231, chance = 9700, maxCount = 1},
	{name = "dwarven ring", chance = 8000, maxCount = 1},
	{name = "metal spats", chance = 5600, maxCount = 1},
	{name = "knight legs", chance = 4750, maxCount = 1},
	{name = "diamond sceptre", chance = 3800},
	{name = "doublet", chance = 3361},
	{name = "hammer of wrath", chance = 2700}
}

mType:register(monster)
