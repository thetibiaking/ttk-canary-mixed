local mType = Game.createMonsterType("Rogue Naga")
local monster = {}

monster.name = "Rogue Naga"
monster.description = "a rogue naga"
monster.experience = 4380
monster.outfit = {
	lookType = 1543,
	lookHead = 0,
	lookBody = 13,
	lookLegs = 114,
	lookFeet = 71,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 5990
monster.maxHealth = 5990
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 44056
monster.speed = 300
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
	{text = "Intruder! Don't violate this sanctuary!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -210},
	{name ="rouge_dead_ring", interval = 1000, chance = 23, minDamage = 100, maxDamage = -400, target = false},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 6, target = true, effect = CONST_ME_EXPLOSIONAREA},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -364, radius = 6, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_HITBYFIRE},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_HITBYFIRE},
	
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 13},
	{name = "violet crystal shard", chance = 9361, maxCount = 2},
	{name = "corrupt naga scales", chance = 1568, maxCount = 2},
}

mType:register(monster)
