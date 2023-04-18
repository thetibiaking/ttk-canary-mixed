local mType = Game.createMonsterType("Lord Azaram")
local monster = {}

monster.description = "a Lord Azaram"
monster.experience = 41950
monster.outfit = {
	lookType = 1223,
	lookHead = 0,
	lookBody = 38,
	lookLegs = 94,
	lookFeet = 82,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "venom"
monster.corpse = 36434
monster.speed = 250
monster.manaCost = 0
monster.maxSummons = 3

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

monster.summons = {
	{name = "Condensed Sins", chance = 50, interval = 2000}
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
	{name = "berserk potion", minCount = 0, maxCount = 10, chance = 12000},
	{name = "piece of hell steel", minCount = 0, maxCount = 4, chance = 9000},
	{name = "red gem", minCount = 0, maxCount = 2, chance = 12000},
	{name = "blue gem", minCount = 0, maxCount = 2, chance = 12000},
	{name = "silver token", minCount = 0, maxCount = 2, chance = 9500},
	{name = "ancient liche bone", chance = 5200},
	{id = 26198, chance = 5200},-- collar of blue plasma
	{id = 26200, chance = 5200},-- collar of red plasma
	{name = "collar of green plasma", chance = 5200},
	{name = "giant sapphire", chance = 7000},
	{name = "haunted blade", chance = 9000},
	{name = "huge chunk of crude iron", chance = 4500},
	{name = "knight armor", chance = 15000},
	{name = "violet gem", minCount = 0, maxCount = 1, chance = 10000},
	{name = "yellow gem", minCount = 0, maxCount = 1, chance = 10000},
	{id = 26187, chance = 5000},-- ring of green plasma
	{id = 26189, chance = 5000},-- ring of red plasma
	{name = "young lich worm", chance = 200},
	{name = "bear skin", chance = 200},
	{name = "noble cape", chance = 200},
	{name = "terra helmet", chance = 200}
	
}
-- ALTEREI VALOR DE MELLE DE 200 E 600 PARA 500 E 900, RESPECTIVAMENTE.
-- ALTEREI VALOR DE PHYSICALDAMAGE 400 E 1000 PARA 600 E 1100 RESPECTIVAMENTE. ALTEREI CHANCE DE 25 PARA 40
-- ALTEREI VALOR DE EARTHDAMAGE 400 E 1000 PARA 600 E 1100 RESPECTIVAMENTE. ALTEREI CHANCE DE 15 PARA 35
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -900},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -600, maxDamage = -1100, length = 7, spread = 3, effect = CONST_ME_STONES, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -600, maxDamage = -1100, length = 7, spread = 3, effect = CONST_ME_POISONAREA, target = false}
}
-- ALTEREI VALOR COMBATI MINDAMAGE DE 150 PARA 250 E MAXDAMAGE DE 500 PARA 700.
monster.defenses = {
	defense = 25,
	armor = 78,
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_HEALING, minDamage = 250, maxDamage = 700, effect = CONST_ME_MAGIC_BLUE, target = false}
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
