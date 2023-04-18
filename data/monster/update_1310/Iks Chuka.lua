local mType = Game.createMonsterType("Iks Chuka")
local monster = {}

monster.description = "a Iks Chuka"
monster.experience = 1050
monster.outfit = {
	lookType = 1588,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 2345
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Drefia Grim Reaper Dungeons, deep in Drefia Wyrm Lair (after the Medusa Shield Quest), \z
		Edron (Hero Cave), Yalahar (Cemetery Quarter), Oramond Dungeon, \z
		  Abandoned Sewers and optionally in the Demon Oak Quest."
	}

monster.health = 1240
monster.maxHealth = 1240
monster.race = "blood"
monster.corpse = 42057
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
	{name = "gold coin", chance = 100000, maxCount = 90},
	{name = "Violet Crystal Shard", chance = 540},
	{name = "Royal Spear", chance = 3400, maxCount = 2},
	{name = "Green Crystal Splinter", chance = 810},
--	{name = "Rotten Feather", chance = 410},
--	{name = "Ritual Tooth", chance = 2500},
	{name = "Gold Ingot", chance = 60500},
--	{name = "Gold-Brocaded Cloth", chance = 12300}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 203, maxDamage = -250},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = 400, maxDamage = -500, range = 4, shootEffect = CONST_ANI_ENCHANTEDSPEAR, target = true},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -360, maxDamage = -420, range = 7, radius = 4, effect = CONST_ME_PURPLEENERGY, target = true},
}

monster.defenses = {
	defense = 30,
	armor = 29,

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
