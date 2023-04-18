local mType = Game.createMonsterType("Maxxenius")
local monster = {}

monster.description = "a Maxxenius"
monster.experience = 5500
monster.outfit = {
	lookType = 1142,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 34789
monster.speed = 350
monster.manaCost = 0
monster.maxSummons = 0

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
	{name = "Chaos Mace", chance = 2840},		
	{name = "Huge Chunk of Crude Iron", chance = 1840},	
	{name = "Ornate Locket", chance = 1840},	
	{name = "Giant Ruby", chance = 1840},	
	{name = "Energized Limb", chance = 400},
	{name = "Maxxenius Head", chance = 400},
	{name = "Brain in a Jar", chance = 400}
	
}
-- ALTERADO CHANCE DE 10 PARA 30.
-- ALTERADO MINDAMAGE DE 100 PARA 300
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -600, maxDamage = -1200},
	{name ="energy beam", interval = 2000, chance = 30, minDamage = -300, maxDamage = -750, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false},
	{name ="energy wave", interval = 2000, chance = 30, minDamage = -300, maxDamage = -750, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false},	
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -850, maxDamage = -1400, radius = 8, effect = CONST_ME_ENERGYHIT, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_MANADRAIN, minDamage = -650, maxDamage = -1500, length = 8, spread = 3, effect = CONST_ME_TELEPORT, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -650, maxDamage = -1500, length = 8, spread = 3, effect = CONST_ME_FIREATTACK, target = false},
	{name ="war golem skill reducer", interval = 2000, chance = 30, target = false},
	{name ="war golem electrify", interval = 2000, chance = 30, range = 2, target = false},
	{name ="glooth fairy skill reducer", interval = 2000, chance = 30, target = false},
	{name ="glooth fairy paralyze", interval = 2000, chance = 30, target = false}	
}

monster.defenses = {
	defense = 5,
	armor = 10
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 100},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.heals = {
	{type = COMBAT_ENERGYDAMAGE, percent = 500}
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
