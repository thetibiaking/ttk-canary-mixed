local mType = Game.createMonsterType("The Brainstealer")
local monster = {}

monster.description = "The Brainstealer"
monster.experience = 75000
monster.outfit = {
	lookType = 1412,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "blood"
monster.corpse = 41678
monster.speed = 350
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 0
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.events = {
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "crystal coin", chance = 100000, maxCount = 100},
	{name = "Berserk Potion", chance = 1000, maxCount = 15},
	{name = "Bullseye Potion", chance = 1000, maxCount = 15},
	{name = "Mastermind Potion", chance = 1000, maxCount = 15},
	{name = "Moonstone", chance = 1000},
	{name = "Ultimate Mana Potion", chance = 1000, maxCount = 50},
	{name = "Ultimate Spirit Potion", chance = 100, maxCount = 55},
	{name = "Violet Gem", chance = 1000},
	{name = "White Gem", chance = 1000},
	{name = "Supreme Health Potion", chance = 1000, maxCount = 55},
	{name = "Ultimate Health Potion", chance = 1000, maxCount = 55},
	{name = "Brainstealer's Tissue", chance = 500},
	{name = "Brainstealer's Brain", chance = 500},
	{name = "Brainstealer's Brainwave", chance = 500},
	{name = "Eldritch Breeches", chance = 25},
	{name = "Eldritch Cowl", chance = 25},
	{name = "Eldritch Hood", chance = 25},
	{name = "Eldritch Bow", chance = 25},
	{name = "Eldritch Quiver", chance = 25},
	{name = "Eldritch Claymore", chance = 25},
	{name = "Eldritch Greataxe", chance = 25},
	{name = "Eldritch Warmace", chance = 25},
	{name = "Eldritch Cuirass", chance = 25},
	{name = "Eldritch Tome", chance = 25},
	{name = "Eldritch Folio", chance = 25},
	{name = "Eldritch Rod", chance = 25},
	{name = "Eldritch Wand", chance = 25}
}

monster.attacks = {	
		{name ="melee", interval = 2000, chance = 100, minDamage = -1500, maxDamage = -2500},
		{name ="combat", interval = 2500, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -2000, length = 10, spread = 3, effect = CONST_ME_HITBYFIRE, target = false},
		{name ="speed", interval = 2000, chance = 25, speedChange = -600, radius = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 15000},
		{name ="combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -800, radius = 5, effect = CONST_ME_HITBYFIRE, target = false},
		{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -800, length = 10, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false},
		{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1300, length = 8, spread = 3, effect = CONST_ME_FIREATTACK, target = false}

}


monster.defenses = {
	defense = 64,
	armor = 52,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
