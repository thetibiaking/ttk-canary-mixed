local mType = Game.createMonsterType("Iks Ahpututu")
local monster = {}

monster.description = "a Iks Ahpututu"
monster.experience = 1700
monster.outfit = {
	lookType = 1590,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2349
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 3,
	Occurrence = 0,
	Locations = "Drefia Grim Reaper Dungeons, deep in Drefia Wyrm Lair (after the Medusa Shield Quest), \z
		Edron (Hero Cave), Yalahar (Cemetery Quarter), Oramond Dungeon, \z
		  Abandoned Sewers and optionally in the Demon Oak Quest."
	}

monster.health = 1630
monster.maxHealth = 1630
monster.race = "blood"
monster.corpse = 42065
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
	targetDistance = 3,
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
	{name = "emerald bangle", chance = 540},
	{name = "small sapphire", chance = 5000},
	{name = "gold coin", chance = 100000, maxCount = 90},
	{name = "Tiger Eye", chance = 810},
	{name = "opal", chance = 3400},
	{name = "dragon ham", chance = 60500, maxCount = 3},
--	{name = "Daedal Chisel", chance = 410},
	{name = "strong health potion", chance = 2500},
--	{name = "Gold-Brocaded Cloth", chance = 12300},
--	{name = "Ritual Tooth", chance = 12300},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -320},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = 200, maxDamage = -350, range = 7, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = 220, maxDamage = -300, length = 7, spread = 3, effect = 216, target = false},
	{name ="combat", interval = 1000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = 500, maxDamage = -800, radius = 4, effect = 244, target = false},
}

monster.defenses = {
	defense = 35,
	armor = 35,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 130, maxDamage = 205, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 450, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
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
