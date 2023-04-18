local mType = Game.createMonsterType("Izcandar the Banished")
local monster = {}

monster.description = "Izcandar the Banished"
monster.experience = 6900
monster.outfit = {
	lookType = 1137,
	lookHead = 1,
	lookBody = 114,
	lookLegs = 76,
	lookFeet = 0,
	lookAddons = 2,
	lookMount = 0
}
				
monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 350
monster.manaCost = 0
monster.maxSummons = 0

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

monster.loot = {
	{name = "crystal coin", chance = 100000, maxCount = 5},	
	{name = "giant emerald", chance = 12800},
	{name = "giant sapphire", chance = 100000},
	{name = "gold token", chance = 9000, maxCount = 6},
	{name = "silver token", chance = 9000, maxCount = 10},	
	{name = "supreme health potion", chance = 32800, maxCount = 20},
	{name = "ultimate mana potion", chance = 32800, maxCount = 20},
	{name = "ultimate spirit potion", chance = 32800, maxCount = 20},	
	{name = "Ornate Locket", chance = 1500, maxCount = 1},
	{name = "Purple Tendril Lantern", chance = 500, maxCount = 1},
	{name = "Soul Stone", chance = 400, maxCount = 1},	
	{name = "Turquoise Tendril Lantern", chance = 400, maxCount = 1},
	{name = "Summerblade", chance = 400, maxCount = 1},
	{name = "Winterblade", chance = 400, maxCount = 1}
}
-- AUMENTEO +100 NO MAXDAMAGE.
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -1400},
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -990, range = 7, shootEffect = CONST_ANI_FIRE, target = false},
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -990, radius = 3, effect = CONST_ME_FIREATTACK, target = true},
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -990, range = 7, shootEffect = CONST_ANI_FIRE, target = false},	
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -590, radius = 4, effect = CONST_ME_ICEAREA, target = true},
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -590, effect = CONST_ME_ICEATTACK, target = true},	
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_ICEDAMAGE, minDamage = -200, maxDamage = -590, radius = 4, effect = CONST_ME_ICEAREA, target = true},	
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -590, length = 5, spread = 3, effect = CONST_ME_ICEATTACK, target = false}
}

monster.defenses = {
	defense = 0,
	armor = 76
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
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
