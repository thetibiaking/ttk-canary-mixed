local mType = Game.createMonsterType("Headpecker")
local monster = {}

monster.name = "Headpecker"
monster.description = "a headpecker"
monster.experience = 13172 
monster.outfit = {
	lookType = 1557,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2275
monster.Bestiary = {
	class = "Bird",
	race = BESTY_RACE_BIRD,
	toKill = 5000,
	FirstUnlock = 2500,
	SecondUnlock = 100,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "gnomprona"
	}


monster.health = 16850
monster.maxHealth = 16850
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44158
monster.speed = 217
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
	{name ="combat", interval = 1000, chance = 19, type = COMBAT_POISONDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, effect = CONST_ME_HITBYPOISON},
	--{name ="combat", interval = 1200, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 2, target = false, effect = CONST_ME_ENERGYHIT},
	{name ="headpecker_spell", interval = 1200, chance = 23, minDamage = 100, maxDamage = -400, target = false},
	{name ="headpeckerslash", interval = 2000, chance = 20, minDamage = -1500, maxDamage = -4500, target = false}
}

monster.defenses = {
	defense = 1,
	armor = 68
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "headpecker beak", chance = 10000, maxCount = 1},
	{name = "headpecker feather", chance = 9700, maxCount = 3},
	{id = 2684, chance = 8000, maxCount = 1},
	{name = "furry club", chance = 5600, maxCount = 1},
	{name = "knife", chance = 4750, maxCount = 1},
	{name = "spike sword", chance = 3800, maxCount = 1},
	{name = "war hammer", chance = 3100},
	{name = "gold ingot", chance = 2700},
	{name = "titan axe", chance = 2450},
	{name = "blue gem", chance = 2300},
	{name = "wand of starstorm", chance = 1100}
}

mType:register(monster)
