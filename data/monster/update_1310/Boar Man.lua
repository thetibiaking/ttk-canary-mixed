local mType = Game.createMonsterType("Boar Man")
local monster = {}

monster.description = "a Boar Man"
monster.experience = 7720
monster.outfit = {
	lookType = 1603,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2339
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 2,
	Occurrence = 0,
	Locations = "Kazordoon Dwarf Mines, Dwarf Bridge, deep Elvenbane, Tiquanda Dwarf Cave, Cormaya Dwarf Cave, \z
		Island of Destiny (Knights area), Beregar."
	}

monster.health = 9200
monster.maxHealth = 9200
monster.race = "blood"
monster.corpse = 42218
monster.speed = 186
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Shriiiek", yell = true}
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 10},
--	{name = "Boar Man Hoof", chance = 5000},
	{name = "Great Health Potion", chance = 100000, maxCount = 4},
	{name = "Crystal Mace", chance = 810},
	{name = "Tower Shield", chance = 3400},
	{name = "dragon ham", chance = 60500, maxCount = 3},
	{name = "wyvern fang", chance = 410},
	{name = "strong health potion", chance = 2500},
	{name = "wyvern talisman", chance = 12300}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -498},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = 375, maxDamage = -392, range = 7, shootEffect = CONST_ANI_THROWINGKNIFE, target = true},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = 386, maxDamage = -480, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, target = true},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -60, maxDamage = -140, range = 7, radius = 4, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_PURPLEENERGY, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -311, maxDamage = -400, length = 8, spread = 3, effect = CONST_ME_ENERGYHIT, target = false},
}

monster.defenses = {
	defense = 25,
	armor = 25,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 45, maxDamage = 65, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 300, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
