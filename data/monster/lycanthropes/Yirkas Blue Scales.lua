local mType = Game.createMonsterType("Yirkas Blue Scales")
local monster = {}

monster.description = "a yirkas blue"
monster.experience = 4900
monster.outfit = {
	lookType = 1196,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1817


monster.health = 8300
monster.maxHealth = 8300
monster.race = "blood"
monster.corpse = 36244
monster.speed = 380
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
	runHealth = 10,
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
	{name = "platinum coin", chance = 100000, maxCount = 3},
    {name = "great health potion", chance = 49970, maxCount = 3},
    {name = "meat", chance = 19070},
    {name = "axe", chance = 16810},
    {name = "knife", chance = 16620},    
    {name = "halberd", chance = 11480},
    {name = "red crystal fragment", chance = 9540},
    {name = "small enchanted amethyst", chance = 5760, maxCount = 5},
    {name = "life preserver", chance = 5670},
    {name = "red gem", chance = 5590},
    {name = "yellow gem", chance = 5420},
    {name = "combat knife", chance = 4700},
    {name = "green crystal fragment", chance = 4580},
    {name = "ratana", chance = 4280},
	{name = "Red Silk Flower", chance = 1000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -630, condition = {type = CONDITION_POISON, totalDamage = 15, interval = 4000}},
	{name ="speed", interval = 4000, chance = 20, speedChange = -370, range = 7, shootEffect = CONST_ANI_POISON, target = true, duration = 12000},
	{name ="combat", interval = 2000, chance = 7, type = COMBAT_EARTHDAMAGE, minDamage = -370, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 2000, chance = 9, type = COMBAT_LIFEDRAIN, minDamage = -370, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_SOUND_RED, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -370, maxDamage = -1000, range = 1, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = false},
	{name ="outfit", interval = 2000, chance = 11, range = 7, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 4000, outfitItem = 3976}
}

monster.defenses = {
	defense = 78,
	armor = 78,
	{name ="speed", interval = 2000, chance = 5, speedChange = 350, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -20},
	{type = COMBAT_EARTHDAMAGE, percent = 80},
	{type = COMBAT_FIREDAMAGE, percent = 0},
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

mType:register(monster)
