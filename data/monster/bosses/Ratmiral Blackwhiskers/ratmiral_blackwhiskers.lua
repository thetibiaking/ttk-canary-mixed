local mType = Game.createMonsterType("Ratmiral Blackwhiskers")
local monster = {}

monster.description = "Ratmiral Blackwhiskers"
monster.experience = 6000
monster.outfit = {
	lookType = 1377,
	lookHead = 2,
	lookBody = 96,
	lookLegs = 78,
	lookFeet = 96,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "fire"
monster.corpse = 40207
monster.speed = 300
monster.manaCost = 0
monster.maxSummons = 4

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
	{name = "Pirat Cutthroat", chance = 80, interval = 1000, max = 2},
	{name = "Pirat Scoundrel", chance = 80, interval = 1000, max = 2}	
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
	{name = "Crystal Coin",  maxCount = 17, chance = 21988},
	{name = "red gem", chance = 7000},
	{name = "yellow gem", chance = 7000},	
	{name = "Golden Cheese Wedge", chance = 7000},	
	{name = "Golden Dustbin", chance = 7000},		
	{name = "Tiara", chance = 7000},
	{name = "Major Crystalline Token", maxCount = 5,chance = 5200},
	{name = "Make-Do Boots", chance = 500},
	{name = "Throwing Axe", chance = 500},
	{name = "Exotic Legs", chance = 500},	
	{name = "Makeshift Boots", chance = 500},	
	{name = "Jungle Bow", chance = 500},	
	{name = "Cheesy Membership Card", chance = 1000},
	{name = "Exotic Amulet", chance = 500},
	{name = "Raccoon Backpack", chance = 500},	
	{name = "Scrubbing Brush", chance = 150},
	{name = "Soap", chance = 150}	
}

monster.attacks = {
	{name="melee" ,interval = 2000 ,minDamage = -500 ,maxDamage= -1550},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -1500, range = 7, radius = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT, target = true},
	{name ="combat", interval = 2000, chance = 18, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -900, length = 4, spread = 3, effect = CONST_ME_GROUNDSHAKER, target = false},
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -950, range = 5, shootEffect = CONST_ANI_ROYALSPEAR, target = true},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -900, range = 5, shootEffect = CONST_ANI_BOLT, target = true}
}



monster.defenses = {
	defense = 30,
	armor = 30
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
