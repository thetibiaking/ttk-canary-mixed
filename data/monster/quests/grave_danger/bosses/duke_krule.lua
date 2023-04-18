local mType = Game.createMonsterType("Duke Krule")
local monster = {}

monster.description = "a Duke Krule"
monster.experience = 46300
monster.outfit = {
	lookType = 1221,
	lookHead = 19,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "venom"
monster.corpse = 36434
monster.speed = 250
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
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
	{name = "platinum coin", minCount = 1, maxCount = 5, chance = 100000},
	{name = "crystal coin", minCount = 0, maxCount = 2, chance = 50000},
	{name = "supreme health potion", minCount = 0, maxCount = 6, chance = 35000},
	{name = "ultimate mana potion", minCount = 0, maxCount = 20, chance = 32000},
	{name = "ultimate spirit potion", minCount = 0, maxCount = 20, chance = 32000},
	{name = "bullseye potion", minCount = 0, maxCount = 10, chance = 12000},
	{name = "mastermind potion", minCount = 0, maxCount = 10, chance = 12000},
	{name = "berserk potion", minCount = 0, maxCount = 10, chance = 12000},
	{name = "piece of draconian steel", minCount = 0, maxCount = 3, chance = 9000},
	{name = "green gem", minCount = 0, maxCount = 2, chance = 12000},
	{name = "silver token", minCount = 0, maxCount = 2, chance = 9500},
	{name = "blue gem", chance = 11000},
	{name = "crusader helmet", chance = 6400},
	{name = "gold ingot", minCount = 0, maxCount = 1, chance = 10000},
	{name = "red gem", chance = 11000},
	{name = "terra hood", chance = 7800},
	{name = "yellow gem", chance = 9500},
	{name = "young lich worm", chance = 5800},
	{name = "bear skin", chance = 200},
	{name = "noble amulet", chance = 200},
	{name = "rotten heart", chance = 200},
	{name = "terra helmet", chance = 200}	
}
-- ALTERADO VALOR MELEE DE 200 E 600 PARA 400 E 900.
-- ALTERADO VALOR MANADRAIN DE 400 E 1000 PARA 500 E 1100
-- ALTERADO CHANCE PHYSICODAMAGE DE 19 PARA 60.
-- ALTERADO FIREDAMAGE DE 300 E 500 PARA 500 E 700
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -400, maxDamage = -900},
	{name ="combat", interval = 1800, chance = 60, type = COMBAT_MANADRAIN, minDamage = -500, maxDamage = -1100, length = 7, spread = 2, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 1800, chance = 60, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -1000, length = 7, spread = 3, effect = CONST_ME_BLOCKHIT, target = false},
	{name ="combat", interval = 1800, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -700, radius = 10, effect = CONST_ME_HITBYFIRE, target = false}
}
-- ALTERADO VALOR HEALING DE 150 E 350 PARA 500 E 800 RESPECTIVAMENTE. CHANCE ALTERADA DE 14 PARA 30
monster.defenses = {
	defense = 25,
	armor = 78,
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_HEALING, minDamage = 500, maxDamage = 800, effect = CONST_ME_MAGIC_BLUE, target = false}
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
