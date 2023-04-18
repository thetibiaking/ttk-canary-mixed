local mType = Game.createMonsterType("Sulphider")
local monster = {}

monster.name = "Sulphider"
monster.description = "a sulphider"
monster.experience = 13328
monster.outfit = {
	lookType = 1546,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2264
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 5000,
	FirstUnlock = 500,
	SecondUnlock = 1000,
	CharmsPoints = 100,
	Stars = 1,
	Occurrence = 0,
	Locations = "gnompra"
}
	
monster.health = 21000
monster.maxHealth = 21000
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44110
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
	{text = "Tikkee...Takka...!", yell = false}
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
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -20},
	{type = COMBAT_HOLYDAMAGE , percent = -20},
	{type = COMBAT_DEATHDAMAGE , percent = 20}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = 110},
	{name ="sulphider_spell", interval = 1000, chance = 23, minDamage = 1400, maxDamage = -4400, target = true},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -1342, maxDamage = -4364, radius = 4, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_EXPLOSIONHIT},

	
}

monster.defenses = {
	defense = 1,
	armor = 63
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 13},
	{name = "sulphider shell", chance = 10000, maxCount = 1},
	{name = "sulphur powder", chance = 9700, maxCount = 1},
	{name = "ultimate mana potion", chance = 8000, maxCount = 1},
	{name = "white pearl", chance = 5600, maxCount = 1},
	{name = "fire axe", chance = 4750},
	{name = "amber staff", chance = 3800},
	{name = "crown shield", chance = 3361},
	{name = "amulet of loss", chance = 2700},
	{name = "magma boots", chance = 1568, maxCount = 1},
}

mType:register(monster)
