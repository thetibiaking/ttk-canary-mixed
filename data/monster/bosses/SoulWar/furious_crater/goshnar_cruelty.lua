local mType = Game.createMonsterType("Goshnar's Cruelty")
local monster = {}

monster.description = "Goshnar's Cruelty"
monster.experience = 6000
monster.outfit = {
	lookType = 1303,
	lookHead = 86,
	lookBody = 12,
	lookLegs = 31,
	lookFeet = 60,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 290000
monster.maxHealth = 290000
monster.race = "fire"
monster.corpse = 38694
monster.speed = 280
monster.manaCost = 0
monster.maxSummons = 2

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
	staticAttackChance = 70,
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
	{name = "Dreadful Harvester", chance = 80, interval = 1000, max = 3}
	
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Cool down, will you?", yell = false},
	{text = "Freeze!", yell = false},
	{text = "Is this all you've got?", yell = false},
	{text = "Pay for your ignorance!", yell = false},
	{text = "And stay cool.", yell = false},
	{text = "Your cold dead body will be a marvelous ice statue.", yell = false}
}

monster.loot = {
	{name = "Crystal Coin", maxCount = 193, chance = 100000},
	{name = "Supreme Health Potion",  maxCount = 17, chance = 21988},
	{name = "Ultimate Mana Potion",  maxCount = 20, chance = 21988},
	{name = "Gold Ingot",  maxCount = 3, chance = 8735},
	{name = "Yellow Gem",  maxCount = 2, chance = 8735},
	{name = "Giant Amethyst",  maxCount = 2, chance = 8735},
	{name = "red gem",  maxCount = 2, chance = 8735},
	{name = "Giant Ruby",  maxCount = 1, chance = 8735},
	{name = "Green Gem",  maxCount = 1, chance = 8735},
	{name = "Cruelty's Claw", maxCount = 1, chance = 1000},
	{name = "Cruelty's Chest", maxCount = 1, chance = 1000},
	{name = "Figurine of Cruelty", maxCount = 1, chance = 500},	
	{name = "Bag You Desire",  maxCount = 1, chance = 4}
}

monster.attacks = {
	{name="melee" ,interval="2000" ,minDamage="-700" ,maxDamage="-2050"},	
	{name ="combat", interval = 2000, chance = 80, type = COMBAT_DEATHDAMAGE, minDamage = -950, maxDamage = -3720, length = 8, spread = 3, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = -1000, maxDamage = -3000, length = 7, spread = 3, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -1500, radius = 4, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -120, maxDamage = -1000, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 6000, chance = 80, type = COMBAT_HOLYDAMAGE, minDamage = -400, maxDamage = -1550, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -2500, radius = 40, effect = CONST_ME_MORTAREA, target = false}
}



monster.defenses = {
	defense = 30,
	armor = 30
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = 40},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 30},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
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
