local mType = Game.createMonsterType("Ancient Lion Knight")
local monster = {}

monster.description = "an ancient lion knight"
monster.experience = 8100
monster.outfit = {
	lookType = 1071,
	lookHead = 57,
	lookBody = 78,
	lookLegs = 76,
	lookFeet = 76,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 33364
monster.speed = 260
monster.summonCost = 0
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
	staticAttackChance = 70,
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
	{name = "platinum coin", chance = 100000, maxCount = 5},
	{name = "dirty fur", chance = 53750},
	{name = "ham", chance = 53750},
	{id = 2237, chance = 47500},
	{id = 2247, chance = 28750},
	{name = "knife", chance = 25000},
	{name = "broken helmet", chance = 23750},
	{name = "dark armor", chance = 18750},
	{name = "bug meat", chance = 12500},
	{name = "combat knife", chance = 8750},
	{name = "plate armor", chance = 7500},
	{name = "studded shield", chance = 7500},
	{id = 2231, chance = 5000},
	{name = "cape", chance = 5000},
	{name = "life preserver", chance = 3750},
	{name = "dwarven shield", chance = 1250},
	{name = "Lion Spangenhelm", chance = 5},
	{name = "Lion Plate", chance = 5},
	{name = "Lion Shield", chance = 5},
	{name = "Lion Longsword", chance = 5},
	{name = "Lion Hammer", chance = 5},
	{name = "Lion Axe", chance = 5},
	{name = "Lion Longbow", chance = 5},
	{name = "Lion Spellbook", chance = 5},
	{name = "Lion Wand", chance = 5},
	{name = "Lion Amulet", chance = 5},
	{name = "Lion Rod", chance = 5}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 500, maxDamage = -950, effect = CONST_ME_DRAWBLOOD},
	{name ="combat", interval = 6000, chance = 40, type = COMBAT_HOLYDAMAGE, minDamage = -450, maxDamage = -950, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false},
	{name ="combat", interval = 2750, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -950, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 2500, chance = 40, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -950, radius = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 3300, chance = 40, type = COMBAT_ICEDAMAGE, minDamage = -450, maxDamage = -950, length = 4, spread = 0, effect = CONST_ME_ICEATTACK, target = false},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -950, radius = 4, effect = CONST_ME_BIGCLOUDS, target = false}
}

monster.defenses = {
	defense = 60,
	armor = 82,
	{name ="speed", interval = 1000, chance = 10, speedChange = 160, effect = CONST_ME_POFF, target = false, duration = 4000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 20},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = -30}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)
