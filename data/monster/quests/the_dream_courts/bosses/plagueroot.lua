local mType = Game.createMonsterType("Plagueroot")
local monster = {}

monster.description = "a Plagueroot"
monster.experience = 5000
monster.outfit = {
	lookType = 1121,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "venom"
monster.corpse = 34660
monster.speed = 250
monster.manaCost = 0
monster.maxSummons = 6

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
	{name = "giant sapphire", chance = 12800}, 
	{name = "gold token", chance = 12000, maxCount = 2},
	{name = "silver token", chance = 12000, maxCount = 5},	
	{name = "Supreme Health Potion", chance = 100000000, maxCount = 3},
	{name = "Ultimate Mana Potion", chance = 100000000, maxCount = 3},
	{name = "Ultimate Spirit Potion", chance = 100000000, maxCount = 3},	
	{name = "Magic Sulphur", chance = 1000},
	{name = "Ring of the Sky", chance = 9000},
	{name = "Living Vine Bow", chance = 400},
	{name = "Abyss Hammer", chance = 400},
	{name = "Plagueroot Offshoot", chance = 400},
	{name = "Living Armor", chance = 400},
	{name = "Soul Stone", chance = 400}
}
--AUMENTEI +50 NO MINDAMAGE
monster.attacks = {	
	{name ="melee", interval = 2000, chance = 100, skill = 30, attack = 100, condition = {type = CONDITION_POISON, totalDamage = 5, interval = 4000}},
	{name ="combat", interval = 2000, chance = 34, type = COMBAT_EARTHDAMAGE, minDamage = -350, maxDamage = -1200, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = false},
	{name ="speed", interval = 2000, chance = 34, speedChange = -850, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = false, duration = 30000},
	{name ="combat", interval = 2000, chance = 34, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -1300, radius = 3, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 2000, chance = 34, type = COMBAT_PHYSICALDAMAGE, minDamage = -150, maxDamage = -1200, radius = 6, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -900, radius = 5, effect = CONST_ME_BLOCKHIT, target = false},
	{name ="combat", interval = 2000, chance = 34, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -900, length = 8, spread = 3, effect = CONST_ME_EXPLOSIONHIT, target = false}
	
}

monster.defenses = {
	defense = 150,
	armor = 165,
	{name ="combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 500, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 200, maxDamage = 300, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 1000, chance = 15, speedChange = 1800, effect = CONST_ME_MAGIC_RED, target = false, duration = 3000}
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
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

monster.summons = {
	{name = "Plant Abomination", chance = 13, interval = 1000, max = 3},
	{name = "Plant Attendant", chance = 13, interval = 1000, max = 3},
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
