local function getCreaturesInMatrix(position, area, effect)
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
				if tile and tile:isWalkable()then
					if effect then
						pos:sendMagicEffect(effect)
					end
					local creature = tile:getTopCreature()
					if creature and creature:isPlayer() then
						table.insert(result, creature:getId())
					end
				end
			end
		end
	end
	return result
end

local theBaronFromBelow = {
	center = Position(33648, 32303, 15),
	holes = {
		Position(33652, 32307, 15),
		Position(33644, 32307, 15),
		Position(33644, 32299, 15),
		Position(33652, 32299, 15),
	},
	area = {
		{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
		{0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
		{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
		{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
		{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
		{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
		{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
		{0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
		{0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0}
	},
}

local function holeExplode(pos)
	local hole_item = Tile(pos):getItemById(389)
	hole_item:transform(388)
	local creatures = getCreaturesInMatrix(pos, theBaronFromBelow.area, 16)
	for k, cid in pairs(creatures) do
		local creature = Creature(cid)
		creature:addHealth(-(math.random(1000, 1500)), COMBAT_FIREDAMAGE)
	end
end

local function lavaHolesEvent(hole)
	if not hole then
		hole = 1
	end
	
	local Baron = Creature("The Baron From Below") or Creature("The Hungry Baron From Below")
	if not Baron then
		return
	end
	
	local holePos = theBaronFromBelow.holes[hole]
	local hole_item = Tile(holePos):getItemById(388)
	hole_item:transform(389)
	
	addEvent(function() holeExplode(holePos) end, 7000)
	
	local nextHole = (hole < 4) and hole + 1 or 1
	addEvent(lavaHolesEvent, 10000, nextHole)
end

function theBaronFromBelow_init()
	addEvent(function()
		local monstro = Game.createMonster("The Baron From Below", Position(33648, 32303, 15))
		if monstro then
			monstro:registerEvent("TheBaronFromBelowThink")
		end
		lavaHolesEvent(1)
	end, 4000)
end

local theCountOfTheCore = {
	center = Position(33681, 32335, 15),
	items_cannon = {
		[1] = {
			Position(33672, 32331, 15),
			Position(33673, 32331, 15),
			Position(33674, 32331, 15),
			Position(33675, 32331, 15),
		},
		[2] = {
			Position(33676, 32339, 15),
			Position(33677, 32339, 15),
			Position(33678, 32339, 15),
			Position(33679, 32339, 15),
		},
		[3] = {
			Position(33680, 32330, 15),
			Position(33681, 32330, 15),
			Position(33682, 32330, 15),
			Position(33683, 32330, 15),
		},
		[4] = {
			Position(33684, 32339, 15),
			Position(33685, 32339, 15),
			Position(33686, 32339, 15),
			Position(33687, 32339, 15),
		},
		[5] = {
			Position(33688, 32332, 15),
			Position(33689, 32332, 15),
			Position(33690, 32332, 15),
			Position(33691, 32332, 15),
		},
	},
	cannons = {
		{Position(33672, 32332, 15), Position(33675, 32338, 15)},
		{Position(33676, 32330, 15), Position(33679, 32338, 15)},
		{Position(33680, 32331, 15), Position(33683, 32340, 15)},
		{Position(33684, 32331, 15), Position(33687, 32338, 15)},
		{Position(33688, 32333, 15), Position(33691, 32338, 15)},
	},
	beast_positions = {
		Position(33674, 32334, 15),
		Position(33680, 32333, 15),
		Position(33686, 32335, 15),
		Position(33681, 32337, 15),
	},
}

local function init_cannons()
	CANNON_PÒSITIONS = {}
	local cannons = theCountOfTheCore.cannons
	for k, cannon in pairs(cannons) do
		CANNON_PÒSITIONS[k] = {}
		local p1, p2 = cannon[1], cannon[2]
		local xInit = (p1.x > p2.x) and p1.x or p2.x
		local xOver = (xInit == p1.x) and p2.x or p1.x
		local yInit = (p1.y > p2.y) and p1.y or p2.y
		local yOver = (yInit == p1.y) and p2.y or p1.y
		
		for x=xOver, xInit do
			for y=yOver, yInit do
				Position(x,y,p1.z):sendMagicEffect(15)
				table.insert(CANNON_PÒSITIONS[k], Position(x,y,p1.z))
			end
		end
	end
end

if not CANNON_PÒSITIONS then
	init_cannons()
end

local function transformCannonItems(cannon, id)
	local toId = (id == 31724) and 31723 or 31724
	local items_positions = theCountOfTheCore.items_cannon[cannon]
	for k, pos in pairs(items_positions) do
		local item_cannon = Tile(pos):getItemById(id)
		item_cannon:transform(toId)
	end
end

local function explodeCannon(cannon)
	local positions = CANNON_PÒSITIONS[cannon]
	for k, pos in pairs(positions) do
		local tile = Tile(pos)
		if tile and tile:isWalkable() then
			local creature = tile:getTopCreature()
			if creature then
				if creature:isPlayer() then
					creature:addHealth(-(math.random(0, 1500)), COMBAT_FIREDAMAGE)
				else
					if creature:getName() == "The Count Of The Core" then
						creature:addHealth(math.random(3000, 5000))
					end
				end
			end
			pos:sendMagicEffect(16)
		end
	end
	transformCannonItems(cannon, 31723)
end

local function summonEmberBeasts()
	local boss = Creature("The Count Of The Core")
	if not boss then
		return
	end
	
	local countBeast = 0
	local countSlime = 0
	local specs = Game.getSpectators(theCountOfTheCore.center, false, false, 14, 14, 7, 7)
	for _, spec in pairs(specs) do
		if spec:getName() == "Ember Beast" then
			countBeast = countBeast + 1
		elseif spec:getName() == "Snail Slime" then
			countSlime = countSlime + 1
		end
	end
	
	if countBeast < 3 then
		local positions = theCountOfTheCore.beast_positions
		local pos = positions[math.random(#positions)]
		Game.createMonster("Ember Beast", pos, false, true)
	end
	
	if countSlime < 5 then
		local positions = theCountOfTheCore.beast_positions
		local pos = positions[math.random(#positions)]
		Game.createMonster("Snail Slime", pos, false, true)
	end
	
	addEvent(summonEmberBeasts, 2000)
end

local function cannonEvent()
	local cannon = math.random(#CANNON_PÒSITIONS)

	local boss = Creature("The Count Of The Core")
	if not boss then
		return
	end
	
	transformCannonItems(cannon, 31724)
	addEvent(explodeCannon, 1500, cannon)
	addEvent(cannonEvent, 6000)
end

function theCountOfTheCore_init()
	Game.createMonster("The Count Of The Core", Position(33681, 32334, 15))
	summonEmberBeasts()
	cannonEvent()
end

local TheDukeOfTheDepths = {
	center = Position(33712, 32303, 15),
	fieryHeartPos = {
		Position(33712, 32299, 15),
		Position(33715, 32301, 15),
		Position(33714, 32305, 15),
		Position(33710, 32305, 15),
		Position(33709, 32301, 15),
	},
}

local function getTileCreatureByName(tile, name)
	if not tile or not name then return false end
	local tileCreatures = tile:getCreatures()
	if tileCreatures then
		for _, creature in pairs(tileCreatures) do
			if creature:getName() == name then
				return creature
			end
		end
	end
	return false
end

local function fieryHeartEvent()
	local boss = Creature("The Duke Of The Depths") or Creature("The Fire Empowered Duke")
	if not boss then
		return
	end
	local positions = TheDukeOfTheDepths.fieryHeartPos
	local pos = positions[math.random(#positions)]
	local tile = Tile(pos)
	if tile then
		local creature = getTileCreatureByName(tile, "Fiery Heart")
		if not creature then
			local fiery = Game.createMonster("Fiery Heart", pos)
			if fiery then
				fiery:registerEvent("FieryHeartThink")
			end
		end
	end
	addEvent(fieryHeartEvent, 10000)
end

local function agressiveLavaEvent()
	local boss = Creature("The Duke Of The Depths") or Creature("The Fire Empowered Duke")
	if not boss then
		return
	end
	
	local pos = TheDukeOfTheDepths.center
	local specs = Game.getSpectators(pos, false, false, 15, 15, 15, 15)
	local lavaCount = 0
	for _, spec in pairs(specs) do
		if spec:getName() == "Aggressive Lava" then
			lavaCount = lavaCount + 1
		end
	end
	
	if lavaCount < 4 then
		Game.createMonster("Aggressive Lava", pos)
	end
	
	addEvent(agressiveLavaEvent, 6000)
end

local function firstFieryHearts()
	for _, pos in pairs(TheDukeOfTheDepths.fieryHeartPos) do
		local tile = Tile(pos)
		if tile then
			local creature = getTileCreatureByName(tile, "Fiery Heart")
			if not creature then
				local fiery = Game.createMonster("Fiery Heart", pos)
				if fiery then
					fiery:registerEvent("FieryHeartThink")
				end
			end
		end
	end
	addEvent(fieryHeartEvent, 15000)
end

function TheDukeOfTheDepths_init()
	local boss = Game.createMonster("The Duke Of The Depths", TheDukeOfTheDepths.center, true, true)
	boss:registerEvent("theDukeOfTheDepthsThink")
	boss:registerEvent("theDukeHealFireDamage")
	firstFieryHearts()
	addEvent(agressiveLavaEvent, 9000)
end