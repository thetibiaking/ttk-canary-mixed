local mType = Game.createMonsterType("jungle moa")
local monster = {}

monster.name = "Jungle Moa"
monster.description = "a jungle moa"
monster.experience = 1200
monster.outfit = {
	lookType = 1534,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 1300
monster.maxHealth = 1300
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 44043
monster.speed = 210
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
	targetDistance = 1,
	healthHidden = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 1,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Kreeee. Kreeeee,", yell = false}
}

monster.loot = {
	{name = "gold coin", chance = 100000, maxCount = 227},
	{name = "meat", chance = 21096},
	{name = "jungle moa claw", chance = 20749},
	{name = "cyan crystal fragment", chance = 10965},
	{name = "jungle moa feather", chance = 10409, maxCount = 2},
	{name = "strong mana potion", chance = 9993, maxCount = 2},
	{name = "jungle moa egg", chance = 8328},
	{name = "doublet", chance = 4441},
	{name = "spellbook of enlightenment", chance = 1943}
}


monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -216},
	{name ="combat", interval = 2000, chance = 28, type = COMBAT_EARTHDAMAGE, minDamage = -80, maxDamage = -100, radius = 3, target = false, effect = CONST_ME_POISONAREA},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -130, length = 3, spread = 1, effect = CONST_ME_EXPLOSIONAREA},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -108, maxDamage = -119, range = 5, radius = 1, target = true, effect = CONST_ME_ENERGYAREA}
}

monster.defenses = {
	defense = 1,
	armor = 30
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 5},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 10}
}


monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}


mType:register(monster)
