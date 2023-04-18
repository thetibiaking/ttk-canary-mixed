local mType = Game.createMonsterType("Sulphur Spouter")
local monster = {}

monster.name = "Sulphur Spouter"
monster.description = "a sulphur spouter"
monster.experience = 11517
monster.outfit = {
	lookType = 1547,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2265
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 1,
	Occurrence = 0,
	Locations = "gnomprona"
	}
	
monster.health = 19000
monster.maxHealth = 19000
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44114
monster.speed = 215
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
	targetDistance = 3,
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
	{text = "Gruugl...!", yell = false}
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
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -0},
	{type = COMBAT_HOLYDAMAGE , percent = -20},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -110},
	{name ="sulphider_spell", interval = 1000, chance = 23, minDamage = 100, maxDamage = -400, target = true},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_EXPLOSIONHIT},

	
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 13},
	{name = "sulphur powder", chance = 9750, maxCount = 1},
	{name = "ultimate mana potion", chance = 8710, maxCount = 1},
	{name = "crystal coin", chance = 6700, maxCount = 1},
	{name = "yellow gem", chance = 5600, maxCount = 1},
	{name = "slightly rusted legs", chance = 4750},
	{name = "red gem", chance = 3800},
	{name = "warrior's shield", chance = 3361},
	{name = "knight legs", chance = 2700},
	{id = 26189, chance = 1568, maxCount = 1},
	{name = "fire sword", chance = 1568, maxCount = 1}
}

mType:register(monster)
