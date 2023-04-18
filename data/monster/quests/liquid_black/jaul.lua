local mType = Game.createMonsterType("Jaul")
local monster = {}

monster.description = "Jaul"
monster.experience = 35000
monster.outfit = {
	lookType = 444,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = 100000
monster.race = "blood"
monster.corpse = 15220
monster.speed = 440
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 2000,
	chance = 50
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
	pushable = true,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 60,
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
	{text = "QJELL AFAR GOU JEY!!", yell = false},
	{text = "DIE!! KENH!!", yell = false}
}

monster.loot = {
	{name = "deepling axe", chance = 1000},
	{name = "depth calcei", chance = 1000},
	{id = 15408, chance = 1000},-- depth galea
	{name = "depth lorica", chance = 1000, unique = true},
	{name = "ornate chestplate", chance = 1000, unique = true},
	{name = "ornate legs", chance = 1000},
	{name = "ornate mace", chance = 1000},
	{name = "ornate shield", chance = 1000}
}
-- ALTERADO TODOS OS CHANCE PARA 30
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2500, condition = {type = CONDITION_POISON, totalDamage = 870, interval = 4000}},
	{name ="combat", interval = 2200, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = 0, maxDamage = -1000, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 3000, chance = 30, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -900, range = 7, radius = 7, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 1300, chance = 30, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -600, radius = 3, effect = CONST_ME_EXPLOSIONAREA, target = false},
	{name ="combat", interval = 1200, chance = 30, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -900, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = false},
	{name ="combat", interval = 1000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_HITBYFIRE, target = false},
	{name ="combat", interval = 1000, chance = 30, type = COMBAT_ICEDAMAGE, minDamage = -1000, maxDamage = -2000, length = 8, spread = 3, effect = CONST_ME_ICEAREA, target = false},
	{name ="combat", interval = 4000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -500, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_WATERSPLASH, target = false},
	{name ="speed", interval = 1900, chance = 30, speedChange = -700, range = 7, radius = 1, target = true, duration = 15000}
}

monster.defenses = {
	defense = 40,
	armor = 40,
	{name ="combat", interval = 5000, chance = 10, type = COMBAT_HEALING, minDamage = 1000, maxDamage = 10000, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 1},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
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
