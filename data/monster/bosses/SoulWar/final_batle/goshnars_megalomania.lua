local mType = Game.createMonsterType("Goshnar's Megalomania")
local monster = {}

monster.description = "Goshnar's Megalomania"
monster.experience = 6000
monster.outfit = {
	lookType = 1308,
	lookHead = 86,
	lookBody = 12,
	lookLegs = 31,
	lookFeet = 60,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 490000
monster.maxHealth = 490000
monster.race = "fire"
monster.corpse = 38721
monster.speed = 350
monster.manaCost = 0
monster.maxSummons = 8

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
	{name = "Soulsnatcher", chance = 80, interval = 1000, max = 4},
	{name = "Dreadful Harvester", chance = 80, interval = 1000, max = 4},
	{name = "Soul Cage", chance = 50, interval = 4000, max = 2}
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
	{name = "Spectral Horse Tack", maxCount = 1, chance = 500},
	{name = "Figurine of Hatred", maxCount = 1, chance = 500},
	{name = "Megalomania's Skull", maxCount = 1, chance = 500},
	{name = "Figurine of Megalomania", maxCount = 1, chance = 500},
	{name = "Megalomania's Essence", maxCount = 1, chance = 500},
	{name = "Figurine of Spite", maxCount = 1, chance = 500},
	{name = "Figurine of Greed", maxCount = 1, chance = 500},
	{name = "Megalomania's Essence", maxCount = 1, chance = 500},	
	{name = "Bag You Desire",  maxCount = 1, chance = 4}
}

monster.attacks = {
	{name="melee" ,interval="2000" ,minDamage="-1500" ,maxDamage="-3850"},	
	{name ="combat", interval = 2000, chance = 80, type = COMBAT_DEATHDAMAGE, minDamage = -750, maxDamage = -2800, length = 8, spread = 3, target = false},	
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -2800, radius = 4, target = false},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -720, maxDamage = -2700, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_MORTAREA, target = true},	
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -700, maxDamage = -2700, radius = 40, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -800, maxDamage = -2500, range = 7, shootEffect = CONST_ANI_FIRE, target = false},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -800, maxDamage = -2500, radius = 3, effect = CONST_ME_FIREATTACK, target = true},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -2500, length = 6, spread = 2, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -2550, radius = 5, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = true}
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
