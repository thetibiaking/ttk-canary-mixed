local mType = Game.createMonsterType("Tentugly")
local monster = {}

monster.description = "a tentugly"
monster.experience = 19900
monster.outfit = {
	lookTypeEx = 39940,
}

monster.health = 40000
monster.maxHealth = 40000
monster.race = "blood"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.flags = {
	isSummonable = false,
	isAttackable = true,
	isHostile = true,
	isConvinceable = false,
	isPushable = false,
	rewardBoss = true,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetdistance = 1,
	runHealth = 0,
	isHealthHidden = false,
	canwalkonenergy = false,
	canwalkonfire = false,
	canwalkonpoison = false
}


monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "What are you... doing!", yell = false}
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 100},
	{name = "potato", chance = 100000},
	{name = "supreme health potion", chance = 88000},
	{name = "ultimate mana potion", chance = 82000},
	{name = "green gem", chance = 41790},
	{name = "mastermind potion", chance = 25370, maxCount = 1},
	{name = "bullseye potion", chance = 22390},
	{name = "ultimate spirit potion", chance = 16420},
	{name = "violet gem", chance = 14930},
	{name = "berserk potion", chance = 13430},
	{name = "blue gem", chance = 13430},
	{name = "red gem", chance = 8960},
	{name = "crystal coin", chance = 7960, maxCount = 5},
	{name = "yellow gem", chance = 6960},
	{name = "giant emerald", chance = 6860},
	{name = "terra legs", chance = 6760},
	{name = "terra rod", chance = 6660},
	{name = "terra hood", chance = 6560},
	{name = "terra hood", chance = 6560},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -170},
	{name ="combat", interval = 2500, chance = 35, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -300, radius = 6, spread = 0,  shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_LOSEENERGY},
	{name ="combat", interval = 2000, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -342, maxDamage = -364, radius = 6, target = true, effect = CONST_ME_EXPLOSIONAREA},
}

monster.defenses = {
	defense = 1,
	armor = 1
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
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
	monster:registerEvent("tentugly_on_health_change")
	
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)