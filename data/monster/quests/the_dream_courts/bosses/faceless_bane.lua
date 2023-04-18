local mType = Game.createMonsterType("Faceless Bane")
local monster = {}

monster.description = "a Faceless Bane"
monster.experience = 3000
monster.outfit = {
	lookType = 1122,
	lookHead = 0,
	lookBody = 4,
	lookLegs = 95,
	lookFeet = 4,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 50000
monster.maxHealth = 50000
monster.race = "blood"
monster.corpse = 34651
monster.speed = 300
monster.manaCost = 0
monster.maxSummons = 3

monster.changeTarget = {
	interval = 4000,
	chance = 10
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

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.summons = {
	{name = "Burster Spectre", chance = 30, interval = 1000, max = 1},
	{name = "Gazer Spectre", chance = 30, interval = 1000, max = 1},
	{name = "Ripper Spectre", chance = 30, interval = 1000, max = 1},
}

monster.loot = {
	{name = "Platinum Coin", chance = 100000,  maxCount = 10},
	{name = "Gold Ingot", chance = 2800,  maxCount = 2},
	{name = "Small Sapphire", chance = 2800, maxCount = 5},
	{name = "Cyan Crystal Fragment", chance = 2800,  maxCount = 1},
	{name = "Dagger", chance = 2800,  maxCount = 1},
	{name = "Green Crystal Shard", chance = 2800, maxCount = 1},
	{name = "Green Gem", chance = 2800,  maxCount = 1},
	{name = "Hailstorm Rod", chance = 2800,  maxCount = 1},
	{name = "Ice Rapier", chance = 2800,  maxCount = 1},
	{name = "Lightning Pendant", chance = 2800,  maxCount = 1},
	{name = "Orb", chance = 2800,  maxCount = 1},
	{name = "Red Crystal Fragment", chance = 2800,  maxCount = 1},
	{name = "red gem", chance = 2800,  maxCount = 1},
	{name = "Muck Rod", chance = 2800,  maxCount = 1},
	{name = "Snakebite Rod", chance = 12800,  maxCount = 1},
	{name = "Underworld Rod", chance = 12800,  maxCount = 1},
	{name = "Terra Rod", chance = 12800,  maxCount = 1},
	{name = "Book Backpack", chance = 400},
	{name = "Ectoplasmic Shield", chance = 400},
	{name = "Spirit Guide", chance = 400}	
}
-- ALTERADO CHANCE DE 20 PARA 30.
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -350, maxDamage = -700},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -370, maxDamage = -560, range = 7, shootEffect = CONST_ANI_FIRE, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -370, maxDamage = -660, radius = 3, effect = CONST_ME_FIREATTACK, target = true},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -560, length = 4, spread = 3, effect = CONST_ME_YELLOWENERGY, target = false},
	{name ="melee", interval = 2000, chance = 100, minDamage = 200, maxDamage = -470},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -790, radius = 4, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -560, radius = 4, effect = CONST_ME_EXPLOSIONAREA, target = true},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -640, length = 3, spread = 0, effect = CONST_ME_GROUNDSHAKER, target = false}
}

monster.defenses = {
	defense = 5,
	armor = 10
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -20},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = -20},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -20},
	{type = COMBAT_HOLYDAMAGE , percent = -20},
	{type = COMBAT_DEATHDAMAGE , percent = -20}
}

monster.heals = {
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
