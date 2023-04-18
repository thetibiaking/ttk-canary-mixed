local mType = Game.createMonsterType("Tentacle South")
local monster = {}

monster.name = "Tentacle"
monster.description = "a tentacle"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 39951,
}

monster.health = 5000
monster.maxHealth = 5000
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

}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -170},
	{name ="combat", interval = 2500, chance = 35, type = COMBAT_ICEDAMAGE, minDamage = -100, maxDamage = -300, radius = 6, spread = 0, effect = CONST_ME_LOSEENERGY},
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
	monster:registerEvent("tentuglyTentacleDeath")
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)