local mType = Game.createMonsterType("Ember Beast")
local monster = {}

monster.description = "an ember beast"
monster.experience = 0
monster.outfit = {
	lookType = 498,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 4000
monster.maxHealth = 4000
monster.race = "undead"
monster.corpse = 0
monster.speed = 220
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
	rewardBoss = false,
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

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400},
	{name ="emberbeastarea", interval = 1000, chance = 20, minDamage = -200, maxDamage = -450, target = false},
	{name ="emberbeasthur", interval = 2000, chance = 10, minDamage = -200, maxDamage = -450, target = false}
}

monster.defenses = {
	defense = 5,
	armor = 10
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 50},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 50},
	{type = COMBAT_HOLYDAMAGE , percent = 50},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

local function getCreatureInMatrix(position, area, effect, name)
	local result = {}
	local colMiddle = math.floor(#area[1] / 2) + 1
	local lineMiddle = math.floor(#area / 2) + 1
	local posAjusted = Position(position.x - colMiddle, position.y - lineMiddle, position.z)
	for i = 1, #area do
		local line = area[i]
		for o = 1, #line do
			if area[i][o] == 1 then
				local pos = Position(posAjusted.x + o, posAjusted.y + i, posAjusted.z)
				local tile = Tile(pos)
				if effect then
					pos:sendMagicEffect(effect)
				end
				if tile and tile:isWalkable()then
					local creature = tile:getTopCreature()
					if creature then
						if creature:getName() == name then
							return creature
						end
					end
				end
			end
		end
	end
	return false
end

mType.onDisappear = function(monster, creature)
	local area = {
		{0,0,1,0,0},
		{0,1,1,1,0},
		{1,1,0,1,1},
		{0,1,1,1,0},
		{0,0,1,0,0},
	}
	local boss = getCreatureInMatrix(monster:getPosition(), area, 6, "The Count Of The Core")
	if boss then
		local toHeal = boss:getMaxHealth() - (boss:getMaxHealth() * 0.8)
		boss:addHealth(toHeal)
	end
end

mType:register(monster)
