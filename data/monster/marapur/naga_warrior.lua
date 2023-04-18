local mType = Game.createMonsterType("naga warrior")
local monster = {}

monster.name = "Naga Warrior"
monster.description = "naga warrio"
monster.experience = 6330
monster.outfit = {
	lookType = 1539,
	lookHead = 85,
	lookBody = 57,
	lookLegs = 85,
	lookFeet = 86,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 5290
monster.maxHealth = 5290
monster.runHealth = 25
monster.race = "blood"
monster.corpse = 44064
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
	{text = "Fear the wrath of the wronged!", yell = false}
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
	{type = COMBAT_ENERGYDAMAGE, percent = 5},
	{type = COMBAT_EARTHDAMAGE, percent = 5},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 20},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -330},
	{name ="combat", interval = 2000, chance = 24, type = COMBAT_MANADRAIN, minDamage = -300, maxDamage = -340, radius = 3, target = false, effect = CONST_ME_DRAWBLOOD},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -250, maxDamage = -300, range = 1, radius = 1, target = true, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA}
}

monster.defenses = {
	defense = 1,
	armor = 78
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 12},
	{name = "dagger", chance = 34215},
	{name = "strong health potion", chance = 14275, maxCount = 2},
	{name = "naga warrior scales", chance = 12261},
	{name = "naga earring", chance = 7830, maxCount = 2},
	{id = 2419, chance = 4834},
	{name = "naga armring", chance = 2895},
	{name = "plate armor", chance = 2140},
	{name = "serpent sword", chance = 2090},
	{name = "spiky club", chance = 1989},
	{name = "violet crystal shard", chance = 1712},
	{name = "katana", chance = 1234},
	{name = "knight armor", chance = 1158},
	{id = 7441, chance = 957},
	{name = "relic sword", chance = 403}
}

mType:register(monster)
