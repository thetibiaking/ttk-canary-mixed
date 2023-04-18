local mType = Game.createMonsterType("Urmahlullu the Immaculate")
local monster = {}

monster.description = "urmahlullu the immaculate"
monster.experience = 0
monster.outfit = {
	lookType = 1197,
	lookHead = 57,
	lookBody = 75,
	lookLegs = 38,
	lookFeet = 86,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 512000
monster.maxHealth = 512000
monster.race = "blood"
monster.corpse = 0
monster.speed = 250
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
	runHealth = 10,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.events = {
	"UrmahlulluChanges"
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
}
--AUMENTEI A CHANCE DE 15 PARA 30. ADICIONEI +200 NO MINDAMAGE E MAXDAMAGE
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -350, maxDamage = -1300},
	{name ="combat", interval = 3000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -1000, radius = 4, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -1000, radius = 3, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -750, maxDamage = -1000, radius = 3, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="urmahlulluring", interval = 2000, chance = 30, minDamage = -650, maxDamage = -600, target = false}
}

monster.defenses = {
	defense = 84,
	armor = 84
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -30},
	{type = COMBAT_ENERGYDAMAGE, percent = 40},
	{type = COMBAT_EARTHDAMAGE, percent = -30},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = -30},
	{type = COMBAT_MANADRAIN, percent = -30},
	{type = COMBAT_DROWNDAMAGE, percent = -30},
	{type = COMBAT_ICEDAMAGE, percent = -30},
	{type = COMBAT_HOLYDAMAGE , percent = -30},
	{type = COMBAT_DEATHDAMAGE , percent = -30}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
