local mType = Game.createMonsterType("Timira the Many-Headed")
local monster = {}

monster.name = "timira the many-headed"
monster.description = "timira the many-headed"
monster.experience = 45500
monster.outfit = {
	lookType = 1542,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 75000
monster.maxHealth = 75000
monster.runHealth = 100
monster.race = "blood"
monster.corpse = 44547
monster.speed = 300
monster.summonCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5
}

monster.flags = {
	attackable = true,
	hostile = true,
	summonable = false,
	convinceable = false,
	illusionable = false,
	boss = true,
	ignoreSpawnBlock = false,
	pushable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	healthHidden = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 1,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Fear the wrath of the wronged!", yell = false}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "drunk", condition = true},
	{type = "bleed", condition = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 5},
	{type = COMBAT_EARTHDAMAGE, percent = 5},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = 20},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -330},
	{name ="tamiral_front_dead", interval = 1000, chance = 23, minDamage = 100, maxDamage = -2800, target = false},
	{name ="tamiral_front_ring", interval = 400, chance = 20, minDamage = 100, maxDamage = -2800, target = false},
	{name ="tamiral_front_energy", interval = 2000, chance = 20, minDamage = 100, maxDamage = -2800, target = false},
	{name ="combat", interval = 1200, chance = 19, type = COMBAT_FIREDAMAGE, minDamage = -342, maxDamage = -1364, radius = 6, target = false, shootEffect = CONST_ANI_FIRE , effect = CONST_ME_HITBYFIRE},
	{name ="combat", interval = 600, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -1500, length = 1, spread = 7, effect = CONST_ME_PURPLEENERGY, target = true},
	{name ="combat", interval = 800, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -1500, length = 1, spread = 7, effect = CONST_ME_MORTAREA, target = true},
	{name ="combat", interval = 2300, chance = 10, type = COMBAT_PHYSICALDAMAGE, minDamage = -200, maxDamage = -1500, length = 8, spread = 3, effect = CONST_ME_EXPLOSIONAREA, target = false},
}

monster.defenses = {
	defense = 1,
	armor = 78
}

monster.loot = {
	{name = "crystal coin", chance = 100000, maxCount = 12},
	{name = "ultimate mana potion", chance = 14275, maxCount = 2},
	{name = "ultimate health potion", chance = 15261},
	{name = "bullseye potion", chance = 14261},
	{name = "berserk potion", chance = 13261},
	{name = "mastermind potion", chance = 12261},
	{id = 44235, chance = 5200},
	{id = 44590, chance = 4930, maxCount = 1},
	{name = "giant emerald", chance = 4234},
	{name = "giant amethyst", chance = 2895},
	{name = "giant ruby", chance = 2140},
	{id = 44234, chance = 2090},
	{name = "giant sapphire", chance = 1989},
	{name = "frostflower boots", chance = 1112},
	{name = "enchanted turtle amulet", chance = 1034},
	{name=  "naga crossbow", chance = 957},
	{name = "feverbloom boots", chance = 403}
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

