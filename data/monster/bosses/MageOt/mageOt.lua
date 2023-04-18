local mType = Game.createMonsterType("Mage Ot")
local monster = {}

monster.description = "Mage Ot"
monster.experience = 6000
monster.outfit = {
	lookType = 303,
	lookHead = 10,
	lookBody = 10,
	lookLegs = 10,
	lookFeet = 10,
	lookAddons = 0,
	lookMount = 0
}
			     
monster.health = 600000
monster.maxHealth = 600000
monster.race = "fire"
monster.corpse = 5964
monster.speed = 450
monster.manaCost = 0
monster.maxSummons = 1

monster.changeTarget = {
	interval = 2000,
	chance = 100
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.summons = {
	{name = "Vaca", chance = 80, interval = 1000, max = 1}
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
	chance = 50,
	{text = "Gold Helmet???", yell = false},	
	{text = "Ja donatou HOJE?", yell = false},
	{text = "Pede o PIX do ADM!", yell = false},
	{text = "Segue o intagran do Mage OT", yell = false},
	{text = "Manda um GOD Lindu no HELP", yell = false},
	{text = "F", yell = false},	
	{text = "PK NUTELA", yell = false},	
	{text = "Nao participa da Reuniao e quer palpitar.... ", yell = false}
}

monster.loot = {	
	{name = "Golden Helmet", chance = 50},
	{name = "Rose Shield", chance = 50},
	{name = "Magic Longsword", chance = 50},
	{name = "Eagle Shield", chance = 50},
	{name = "Dragon scale helmet", chance = 50},
	{name = "Patched Boots", chance = 50},
	{name = "Native Armor", chance = 50},
	{name = "Winged Helmet", chance = 50},
	{name = "Crystal Wand", chance = 100},
	{name = "Bar of Gold", chance = 150},
	{name = "Diabolic Skull", chance = 100},
	{name = "Dream Matter", chance = 150},
	{name = "solar axe", chance = 50},
	{name = "Figurine of Greed", chance = 400},
	{name = "Figurine of Malice", chance = 400},
	{name = "Figurine of Cruelty", chance = 400},
	{name = "Figurine of Spite", chance = 400},
	{name = "Figurine of Megalomania", chance =400},
	{name = "Figurine of Megalomania", chance =400},	
	{id = 10513, chance = 300},
	{name = "Giant Emerald", chance = 3050},
	{name = "Giant Ruby", chance = 3050},
	{name = "Giant Sapphire", chance = 3050},
	{name = "Gold Token", chance = 3050},
	{name = "Greed's Arm", chance = 3050},	
	{name = "Major Crystalline Token", chance = 3050},
	{name = "Sandscourge Figurine", chance = 150},
	{name = "Snowbash Figurine", chance = 150},
	{name = "Vial of Hatred", chance = 150},
	{name = "Blessed Shield", chance = 50},
	{name = "Death Gaze", chance = 50},
	{name = "Great Shield", chance = 50},
	{name = "Shield of Corruption", chance = 300},
	{name = "Haunted Mirror Piece", chance = 300},
	{name = "Shield of Honour", chance = 50},
	{name = "Griffin Shield", chance = 50},
	{name = "Magic Plate Armor", chance = 1000},
	{name = "Dragon Scale Mail", chance = 1000},
	{name = "Prismatic Armor", chance = 800},
	{name = "Dream Shroud", chance = 200},
	{name = "Dwarven Armor", chance = 300},
	{name = "Dwarven Legs", chance = 600},
	{name = "Old Cape", chance = 50},
	{name = "White Dress", chance = 50},
	{name = "Dragon Scale Legs", chance = 50},
	{name = "Golden Legs", chance = 3000},
	{name = "Bast Legs", chance = 150},
	{name = "Prismatic Legs", chance = 700},
	{name = "Gill Legs", chance = 700},
	{name = "Hammer of Prophecy", chance = 50},
	{name = "Maimer", chance = 50},
	{name = "Skullcrusher", chance = 100},
	{name = "Book of Lies", chance = 100},
	{name = "Snake God's Wristguard", chance = 200},
	{name = "Spellbook of Dark Mysteries", chance = 200},
	{name = "Spellbook of Vigilance", chance = 200},
	{name = "Spirit Guide", chance = 300},
	{name = "Broken Amulet", chance = 100},
	{name = "Koshei's Ancient Amulet", chance = 300},
	{name = "Book Backpack", chance = 200},
	{name = "Cake Backpack", chance = 200},
	{name = "Crystal Backpack", chance = 200},
	{name = "Energetic Backpack", chance = 200},
	{name = "Heart Backpack", chance = 200},
	{name = "Pannier Backpack", chance = 200},
	{name = "Pillow Backpack", chance = 200},	
	{name = "Santa Backpack", chance = 200},	
	{name = "Birthday Backpack", chance = 200},
	{name = "moon mirror", chance = 600},	
	{name = "bone fiddle", chance = 600},		
	{name = "dragon scale boots", chance = 50},
	{name = "Swan Feather Cloak", chance = 400},	
	{name = "crystal coin", minCount = 0, maxCount = 20, chance = 50000},
	{name = "gold token", minCount = 0, maxCount = 3, chance = 15000},
	{name = "silver token", minCount = 0, maxCount = 3, chance = 25000},
	{name = "green gem", chance = 15500},
	{name = "red gem", chance = 18500},
	{name = "yellow gem", chance = 18500},
	{name = "giant sapphire", chance = 16500},
	{name = "collar of green plasma", chance = 15200},	
	{name = "gold ingot", minCount = 0, maxCount = 1, chance = 15000},
	{name = "red tome", chance = 18200},
	{name = "golem wrench", chance = 1200},	 
	{id = 26185, chance = 12000},-- ring of blue plasma
	{id = 26189, chance = 12000},-- ring of red plasma
	{name = "beast's nightmare-cushion", chance = 800},
	{name = "mage hat", chance = 4000},
	{name = "The Regalia of Suon", chance = 900},	
	{name = "Major Crystalline Token",minCount = 1, maxCount = 10, chance = 3050},
	{id = 2051, chance = 1470}
	
}

-- ADICIONEI LIFEDRAIN, MANA DRAIN E REDUÇÃO DE ML. 3 ULTIMAS LINHAS
monster.attacks = {
	{name="melee" ,interval = 2000 ,minDamage = -800, maxDamage= -2500},
	{name ="speed", interval = 2000, chance = 90, speedChange = -850, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_HITBYPOISON, target = false, duration = 30000},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -800, radius = 3, effect = CONST_ME_ICEAREA, target = true},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -500, maxDamage = -800, range = 20, shootEffect = CONST_ANI_ICE, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -800, length = 8, spread = 0, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -800, range = 20, shootEffect = CONST_ANI_FIRE, target = false},
	{name = "combat", type = COMBAT_LIFEDRAIN, interval = 2000, chance = 20, length = 8, spread = 3, minDamage = -800, maxDamage = -1700, effect = CONST_ME_SMALLCLOUDS},
	{name = "combat", type = COMBAT_LIFEDRAIN, interval = 2000, chance = 20, length = 8, spread = 3, minDamage = -800, maxDamage = -1700, effect = CONST_ME_SMALLCLOUDS},
	{name ="silencer skill reducer", interval = 2000, chance = 10, range = 3, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_MANADRAIN, minDamage = -40, maxDamage = -90, radius = 4, shootEffect = CONST_ANI_ONYXARROW, effect = CONST_ME_MAGIC_RED, target = true},	
}


-- ADICIONEI INVISIBILIDADEE CHANCE CE CURA. 3 ULTIMAS LINHAS
monster.defenses = {
	defense = 30,
	armor = 30,
	{name ="invisible", interval = 2000, chance = 25, effect = CONST_ME_MAGIC_BLUE},
	{name ="combat", interval = 1000, chance = 9, type = COMBAT_HEALING, minDamage = 1500, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="combat", interval = 1000, chance = 17, type = COMBAT_HEALING, minDamage = 600, maxDamage = 1000, effect = CONST_ME_MAGIC_BLUE, target = false},
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
