local mType = Game.createMonsterType("naga archer")
local monster = {}

monster.name = "Naga Archer"
monster.description = "a naga archer"
monster.experience = 5520
monster.outfit = {
	lookType = 1537,
	lookHead = 53,
	lookBody = 7,
	lookLegs = 0,
	lookFeet = 78,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 4460
monster.maxHealth = 4460
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 44060
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
	targetDistance = 4,
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
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = -20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -20},
	{type = COMBAT_HOLYDAMAGE , percent = 20},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -210},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -170, maxDamage = -250, length = 3, spread = 2, effect = CONST_ME_MORTAREA},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -30, maxDamage = -80, range = 6, radius = 1, target = true, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_BLACKSMOKE}
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 13},
	{name = "naga archer scales", chance = 15468},
	{name = "naga earring", chance = 13623},
	{name = "naga armring", chance = 7569},
	{id = 2124, chance = 5913},
	{name = "crossbow", chance = 3974},
	{name = "hunting spear", chance = 3690},
	{name = "blue crystal shard", chance = 1987},
	{name = "bow", chance = 1845},
	{name = "silver brooch", chance = 851},
	{id = 7441, chance = 662},
	{name = "ornate crossbow", chance = 473},
	{name = "emerald bangle", chance = 473},
	{name = "elvish bow", chance = 426},
	{name = "crystal crossbow", chance = 378},
	{name = "gemmed figurine", chance = 189},
	{name = "bullseye potion", chance = 95}
}

mType:register(monster)
