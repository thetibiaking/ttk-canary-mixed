local mType = Game.createMonsterType("The Scourge Of Oblivion")
local monster = {}

monster.description = "The Scourge Of Oblivion"
monster.experience = 50000
monster.outfit = {
	lookType = 875,
	lookHead = 79,
	lookBody = 79,
	lookLegs = 60,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 500000
monster.maxHealth = 500000
monster.race = "venom"
monster.corpse = 26217
monster.speed = 400
monster.manaCost = 0
monster.maxSummons = 8

monster.changeTarget = {
	interval = 2000,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.summons = {
	{name = "Charger", chance = 15, interval = 1000, max = 3},
	{name = "Spark of Destruction", chance = 15, interval = 1000, max = 5}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "I AM DEVOURER!", yell = true}
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 15},
	{name = "crystal coin", chance = 100000, maxCount = 7},
	{name = "green crystal shard", chance = 100000, maxCount = 3},
	{name = "violet crystal shard", chance = 100000, maxCount = 3},
	{name = "spark sphere", chance = 100000},
	{name = "plasmatic lightning", chance = 100000},
	{name = "emerald bangle", chance = 100000},
	{name = "royal star", chance = 66666, maxCount = 100},
	{name = "small amethyst", chance = 66666, maxCount = 12},
	{name = "silver token", chance = 66666, maxCount = 12},
	{name = "mastermind potion", chance = 66666, maxCount = 10},
	{name = "ultimate mana potion", chance = 66666, maxCount = 6},
	{name = "giant emerald", chance = 66666},
	{name = "red gem", chance = 66666},
	{name = "small ruby", chance = 33333, maxCount = 12},
	{name = "bullseye potion", chance = 33333, maxCount = 10},
	{name = "gold token", chance = 33333, maxCount = 8},
	{name = "supreme health potion", chance = 33333, maxCount = 6},
	{name = "blue crystal shard", chance = 33333, maxCount = 3},
	{name = "giant sapphire", chance = 33333},
	{name = "green gem", chance = 33333},
	{id = 26198, chance = 33333},-- collar of blue plasma
	{name = "huge chunk of crude iron", chance = 33333},
	{name = "magic sulphur", chance = 33333},
	{name = "ring of the sky", chance = 33333},
	{name = "ultimate spirit potion", chance = 15000, maxCount = 20},
	{name = "small diamond", chance = 15000, maxCount = 12},
	{name = "small emerald", chance = 15000, maxCount = 12},
	{name = "rift shield", chance = 5000},
	{id = 7632, chance = 5000},
	{name = "arcane staff", chance = 5000},
	{name = "skullcracker armor", chance = 5000},
	{name = "chaos mace", chance = 5000},
	{name = "cat's paw", chance = 5000},
	{name = "piggy bank", chance = 5000},
	{name = "mysterious remains", chance = 5000},
	{name = "energy bar", chance = 5000},
	{name = "library ticket", chance = 200, unique = true},
	{name = "calamity", chance = 200, unique = true},
	{id = 6527, minCount = 0, maxCount = 5,chance = 10000}
}
-- ALTERADO VALRO CHANCE ENERGY DE 15 PARA 40
-- ALTERADO VALOR FIREDAMAGE DE 100 E 700 PARA 350 E 950. CHANCE ALTERADO DE 34 PARA 40
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 250, attack = 350},	
	{name ="drunk", interval = 2000, chance = 20, radius = 5, effect = CONST_ME_SMALLCLOUDS, target = false, duration = 9000},			
	{name ="combat",interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = -2405, range = 7, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYHIT, target = true},		
	{name ="choking fear drown", interval = 2000, chance = 20, target = false},			
	{name ="combat", interval = 1000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -350, maxDamage = -950, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true}
}
-- ALTERADO VALOR DE HEALING CHANVE 25 PARA 35
monster.defenses = {
	defense = 160,
	armor = 160,
	{name ="combat", interval = 6000, chance = 35, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 5000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 1000, chance = 8, speedChange = 1901, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}		
}

monster.reflects = {
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

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -20},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = -20},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -20},
	{type = COMBAT_HOLYDAMAGE , percent = -20},
	{type = COMBAT_DEATHDAMAGE , percent = -20}
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
