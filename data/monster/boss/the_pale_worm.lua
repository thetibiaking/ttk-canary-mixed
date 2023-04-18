local mType = Game.createMonsterType("The Pale Worm")
local monster = {}

monster.description = "a The Pale Worm"
monster.experience = 26000
monster.outfit = {
	lookType = 1272,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}


monster.health = 400000
monster.maxHealth = 400000
monster.race = "blood"
monster.corpse = 6324
monster.speed = 350
monster.manaCost = 0
monster.maxSummons = 5

monster.changeTarget = {
	interval = 4000,
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
	canPushItems = false,
	canPushCreatures = false,
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
	{text = "The smell of fear follows you.", yell = false},
	{text = "Your soul will burn.", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 70540 , maxCount = 2},
	{name = "mastermind Potion", chance = 90540, maxCount = 1},
	{name = "Supreme Health Potion", chance = 9220, maxCount = 4},
	{name = "Berserk Potion", chance = 5560, maxCount = 1},
	{name = "Bullseye Potion", chance = 5560, maxCount = 1},
	{name = "Mastermind Potion", chance = 55560, maxCount = 1},
	{name = "diamond", chance = 15560, maxCount = 1},
	{name = "Moonstone", chance = 5560},	
	{name = "White Gem", chance = 3500},
	{name = "pale Worm's Scalp", chance = 800},
	{name = "fabulous legs", chance = 800},
	{name = "ghost Chestplate", chance =500},
	{name = "pair of nightmare boots", chance = 700},
	{name = "Phantasmal Axe", chance = 800},
	{name = "Soulful Legs", chance = 800},
	{name = "Ghost Backpack", chance = 800}	,
	{id = 6527, minCount = 0, maxCount = 2,chance = 1000}
}
-- ALTERADO VALOR MAXIMO PARA 1100
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -1500},
	{name ="combat", interval = 3000, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -1100, radius = 4, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -1100, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 4000, chance = 50, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -1100, length = 8, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 4000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -1100, range = 5, length = 5, spread = 3, effect = CONST_ME_WHITE_ENERGY_SPARK, target = true}
}

monster.defenses = {
	defense = 110,
	armor = 120,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 650, maxDamage = 1200, effect = CONST_ME_MAGIC_RED, target = false}
}

monster.summons = {
	{name = "Greed Worm", chance = 80, interval = 1000, max = 5}
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
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
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