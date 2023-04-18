local mType = Game.createMonsterType("Alptramun")
local monster = {}

monster.description = "Alptramun"
monster.experience = 5500
monster.outfit = {
	lookType = 1143,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 34793
monster.speed = 400
monster.manaCost = 0
monster.maxSummons = 5

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
	
	{name = "energy bar", chance = 100000000, maxCount = 5},	
	{name = "crystal coin", chance = 100000000, maxCount = 1},
	{name = "platinum coin", chance = 100000000, maxCount = 5},
	{name = "skull staff", chance = 10000, maxCount = 5},
	{name = "royal star", chance = 10000, maxCount = 100},	
	{name = "supreme health potion", chance = 10000, maxCount = 3},
	{name = "ultimate spirit potion", chance = 10000, maxCount = 3},			
	{name = "blue gem", chance = 8000},
	{name = "green gem", chance = 8000},
	{name = "red gem", chance = 8000},
	{name = "Gold Ingot", chance = 8000},
	{name = "Huge Chunk of Crude Iron", chance = 5000},
	{name = "Giant Ruby", chance = 5840},
	{name = "Magic Sulphur", chance = 2740},
	{name = "silver token", chance = 1000, maxCount = 10},
	{name = "Gold Token", chance = 1000, maxCount = 5},
	{name = "Alptramun's Toothbrush", chance = 1000},	
	{name = "Pair of Dreamwalkers", chance = 200},
	{name = "Soul Stone", chance = 300},	
	{name = "Pomegranate", chance = 180},
	{name = "Dream Shroud", chance = 200}
	
	
	
}
--AUMENTEI +100 NO MAXDAMAGE. CHANCE AUMENTADA DE 15 PARA 30
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -2000},
	{name ="combat", interval = 4000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -1000, range = 7, length = 6, spread = 3, shootEffect = CONST_ANI_POISON, target = false},
	{name ="combat", interval = 4000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -600, range = 3, length = 6, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 4000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -150, maxDamage = -400, range = 3, length = 6, spread = 3, effect = CONST_ME_HITBYFIRE, target = false},
	{name ="stone shower", interval = 4000, chance = 10, minDamage = -100, maxDamage = -550, range = 7, target = false}
}

monster.defenses = {
	defense = 20,
	armor = 15,
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_HEALING, minDamage = 0, maxDamage = 7000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="combat", interval = 5000, chance = 30, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="invisible", interval = 2000, chance = 25, effect = CONST_ME_MAGIC_BLUE}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.heals = {
	{type = COMBAT_DEATHDAMAGE , percent = 500}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

monster.summons = {
	{name = "Mind-Wrecking Dream", chance = 20, interval = 1000, max = 3},
	{name = "Unpleasant Dream", chance = 20, interval = 1000, max = 3},
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
