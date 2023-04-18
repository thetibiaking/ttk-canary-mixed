local mType = Game.createMonsterType("Dark Carnisylvan")
local monster = {}

monster.description = "a Dark Carnisylvan"
monster.experience = 3900
monster.outfit = {
	lookType = 1418,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}


monster.raceId = 2109
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Forest of Life"
}


monster.health = 7500
monster.maxHealth = 7500
monster.race = "venom"
monster.corpse = 41729
monster.speed = 310
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25
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
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Ssshhh!", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 30000, maxCount = 90},
	{name = "butterfly ring", chance = 292},
	{name = "Wand of Starstorm", chance = 892},
	{name = "carnisylvan finger", chance = 920},
	{name = "green mushroom", chance = 492}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -180, maxDamage = -400, range = 5, radius = 5, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_PURPLEENERGY, target = true},
	{name ="reality reaver wave", interval = 2000, chance = 20, minDamage = -200, maxDamage = -350, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -80, maxDamage = -300, radius = 3, effect = CONST_ME_STUN, target = false}
}

monster.defenses = {
	defense = 45,
	armor = 45,
	{name ="invisible", interval = 2000, chance = 15, effect = CONST_ME_POFF},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 80, maxDamage = 210, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 10, speedChange = 330, effect = CONST_ME_HITAREA, target = false, duration = 8000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 15},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = -10},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 100},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
