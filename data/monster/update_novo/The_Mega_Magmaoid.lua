local mType = Game.createMonsterType("The Mega Magmaoid")
local monster = {}

monster.description = "The Mega Magmaoid"
monster.experience = 80000
monster.outfit = {
	lookType = 1413,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "undead"
monster.corpse = 41682
monster.speed = 390
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8
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

monster.summons = {
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Your pain will be beyond imagination!", yell = false},
	{text = "You can't defeat me! I will resurrect and take your soul!", yell = false},
	{text = "Death is my ally!", yell = false},
	{text = "Welcome to my domain visitor!", yell = false},
	{text = "You will be my toy on the other side!", yell = false},
	{text = "You will endure agony beyond thy death!", yell = false},
	{text = "What a disgusting smell of life!", yell = false},
	{text = "Ahhh, your life energy tastes so delicious!", yell = false}
}

monster.loot = {
	{id = 40829, chance = 2500},
	{id = 40830, chance = 1000},
	{id = 40831, chance = 2500},
	{id = 40832, chance = 1000},
	{id = 40833, chance = 2500},
	{id = 40834, chance = 1000},
	{id = 40836, chance = 2500},
	{id = 40837, chance = 1000},
	{id = 40840, chance = 2500},
	{id = 40841, chance = 1000},
	{id = 40846, chance = 2500},
	{id = 40847, chance = 1000},
	{id = 40848, chance = 6000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000, condition = {type = CONDITION_POISON, totalDamage = 300, interval = 4000}},
	{name ="combat", interval = 3000, chance = 9, type = COMBAT_LIFEDRAIN, minDamage = -450, maxDamage = -800, range = 1, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="combat", interval = 1000, chance = 11, type = COMBAT_LIFEDRAIN, minDamage = -700, maxDamage = -700, radius = 3, effect = CONST_ME_MAGIC_RED, target = false},
	{name ="combat", interval = 2000, chance = 9, type = COMBAT_DEATHDAMAGE, minDamage = -350, maxDamage = -640, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	-- curse
	{name ="condition", type = CONDITION_CURSED, interval = 3000, chance = 15, minDamage = -540, maxDamage = -600, range = 1, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = -200, range = 7, effect = CONST_ME_MAGIC_RED, target = false, duration = 30000}
}

monster.defenses = {
	defense = 70,
	armor = 60,
	{name ="combat", interval = 1000, chance = 30, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = 1},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = -50},
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
