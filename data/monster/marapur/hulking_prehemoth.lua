local mType = Game.createMonsterType("Hulking Prehemoth")
local monster = {}

monster.name = "Hulking Prehemoth"
monster.description = "a hulking prehemoth"
monster.experience = 12690 
monster.outfit = {
	lookType = 1553,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2271
monster.Bestiary = {
	class = "Giant",
	race = BESTY_RACE_GIANT,
	toKill = 5000,
	FirstUnlock = 500,
	SecondUnlock = 1000,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "gnomprona"
	}
	
monster.health = 20700
monster.maxHealth = 20700
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44138
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
	{text = "SMAASH!", yell = false}
}


monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = 30},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 40},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -30},
	{type = COMBAT_HOLYDAMAGE , percent = -30},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 210},
	--{name ="combat", interval = 1000, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, effect = CONST_ME_ENERGYHIT},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -642, maxDamage = -4264, radius = 4, target = false, effect = CONST_ME_EXPLOSIONAREA},
	{name ="combat", interval = 600, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -4300, length = 1, spread = 7, shootEffect = CONST_ANI_LARGEROCK, target = true},
	--{name ="gorillera_spell", interval = 1200, chance = 23, minDamage = 100, maxDamage = -400, target = false},
}

monster.defenses = {
	defense = 1,
	armor = 84
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "prehemoth claw", chance = 10000, maxCount = 2},
	{name = "prehemoth horns", chance = 9800, maxCount = 2},
	{name = "ultimate health potion", chance = 9700, maxCount = 1},
	{name = "furry club", chance = 8000, maxCount = 1},
	{name = "war hammer", chance = 8000, maxCount = 1},
	{name = "doublet", chance = 5600, maxCount = 1},
	{name = "war axe", chance = 4600, maxCount = 1},
	{name = "silver brooch", chance = 2600, maxCount = 1},
	{id = 2127, chance = 1300, maxCount = 1},
}

mType:register(monster)
