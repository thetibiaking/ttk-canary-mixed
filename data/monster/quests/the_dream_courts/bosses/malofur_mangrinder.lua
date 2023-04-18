local mType = Game.createMonsterType("Malofur Mangrinder")
local monster = {}

monster.description = "Malofur Mangrinder"
monster.experience = 2000
monster.outfit = {
	lookType = 1120,
	lookHead = 19,
	lookBody = 22,
	lookLegs = 76,
	lookFeet = 22,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 34655
monster.speed = 400
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 2000,
	chance = 80
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
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 15000,
	chance = 10,
	{text = "RAAAARGH! I'M MASHING YE TO DUST BOOM!", yell = false},
	{text = "BOOOM!", yell = false},
	{text = "BOOOOM!!!", yell = false},
	{text = "BOOOOOM!!!", yell = false}
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
	{name = "Ring of the Sky", chance = 2000},
	{name = "Crunor Idol", chance = 2000},	
	{name = "Malofur's Lunchbox", chance = 400},
	{name = "Pomegranate", chance = 400},
	{name = "Resizer", chance = 400},
	{name = "Shoulder Plate", chance = 400}
	
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -1500},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -700, range = 7, shootEffect = CONST_ANI_LARGEROCK, target = false},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -1500, range = 7, radius = 6, effect = CONST_ME_HITAREA, target = false},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -250, maxDamage = -700, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -1500, range = 14, radius = 5, effect = CONST_ME_POFF, target = false},	
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -1500, radius = 14, effect = CONST_ME_LOSEENERGY, target = false},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -700, range = 7, radius = 4, effect = CONST_ME_ENERGYAREA, target = false}	
}

monster.defenses = {
	defense = 20,
	armor = 20
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 20},
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
