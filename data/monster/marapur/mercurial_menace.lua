local mType = Game.createMonsterType("Mercurial Menace")
local monster = {}

monster.name = "Mercurial Menace"
monster.description = "a mercurial menace"
monster.experience = 12095 
monster.outfit = {
	lookType = 1561,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}


monster.raceId = 2279
monster.Bestiary = {
	class = "Reptile",
	race = BESTY_RACE_REPTILE,
	toKill = 5000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 100,
	Stars = 3,
	Occurrence = 0,
	Locations = "Gnomprona"
	}
	
monster.health = 16800
monster.maxHealth = 16800
monster.runHealth = 25
monster.race = "venom"
monster.corpse = 44170
monster.speed = 190
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
	{text = "La-la-la..AAAHHHH!!!", yell = false},
	{text = "SCREEECH...", yell = false}
}


monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = -10},
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 100},
	{type = COMBAT_DEATHDAMAGE , percent = -5}
}

monster.attacks = {

	{name ="melee", interval = 2000, chance = 100, minDamage = -170, maxDamage = -110},
	{name ="combat", interval = 1000, chance = 19, type = COMBAT_ENERGYDAMAGE, minDamage = -342, maxDamage = -364, radius = 4, target = true, effect = CONST_ME_ENERGYAREA},
	--{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 2, target = true, effect = CONST_ME_PURPLESMOKE},
	--{name ="combat", interval = 600, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -500, length = 1, spread = 7, shootEffect = CONST_ANI_LARGEROCK, target = true},
	--{name ="shrieking_spell_front_energy", interval = 1200, chance = 23, minDamage = 100, maxDamage = -400, target = true},
	{name ="mercurial_menace_spell", interval = 1200, chance = 23, minDamage = 100, maxDamage = -400, target = true},
}

monster.defenses = {
	defense = 1,
	armor = 91
}

monster.loot = {
	{name = "crystal coin", chance = 50000, maxCount = 1},
	{name = "mercurial wing", chance = 10000, maxCount = 2},
	{name = "silver brooch", chance = 9700, maxCount = 1},
	--{name = "rusted armor", chance = 8000, maxCount = 1},
	--{name = "green crystal fragment", chance = 8000, maxCount = 1}
}

mType:register(monster)
