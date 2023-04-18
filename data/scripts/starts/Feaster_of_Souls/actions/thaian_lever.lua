--== Default boss Lever Script

local config = {
	boss = "Thaian",
	timeToKill = 10, -- minutes
	delayToDoAgain = 20, -- hours
	requiredlevel = 150,
	centerPosition = Position(33813, 31896, 8),
	roomPlayerPosition = Position(33813, 31904, 8),
	bossPosition = Position(33812, 31890, 8),
	kickPosition = Position(33232, 31702, 7),
	storage = Storage.FeasterOfSouls.ThaianTimer,
	range = {x = 17, y = 17},
	leverPositions = {
		Position(33903, 31880, 8),
		Position(33902, 31880, 8),
		Position(33901, 31880, 8),
		Position(33900, 31880, 8),
		Position(33899, 31880, 8),
	},
}

local function kickPlayers(toKick)
	local range = config.range
	local specs = Game.getSpectators(config.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			if table.contains(toKick, spec:getId()) then
				spec:teleportTo(config.kickPosition)
			end
		end
	end
end

local function cleanRoomMonsters()
	local range = config.range
	local specs = Game.getSpectators(config.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if not spec:isPlayer() then
			spec:remove()
		end
	end
end

local function roomIsOcuped()
	local range = config.range
	local specs = Game.getSpectators(config.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			return true
		end
	end
	return false
end

local function getMonstersCount()
	local count = 0
	local range = config.range
	local specs = Game.getSpectators(config.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if spec:getName() == "Cursed Prospector" then
			count = count + 1
		end
	end
	return count
end

local monsters_positions = {
	Position(33815, 31892, 8),
	Position(33810, 31894, 8),
	Position(33811, 31898, 8),
	Position(33816, 31898, 8),
	Position(33813, 31902, 8),
}

local function spawnMonstersEvent()
	if not Creature("Thaian") then
		return
	end
	local count = getMonstersCount()
	if count < 8 then
		local randPos = monsters_positions[math.random(#monsters_positions)]
		Game.createMonster("Cursed Prospector", randPos)
	end
	addEvent(spawnMonstersEvent, 3000)
end

local DefaultBossLever = Action()

function DefaultBossLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if roomIsOcuped() then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the boss room.")
		return true
	end
	
	if player:getPosition() ~= config.leverPositions[1] then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You can\'t start the battle.")
		return true
	end
	
	local checked = {}
	local toKick = {}
	
	for _, pos in pairs(config.leverPositions) do
		local tile = Tile(pos)
		if tile then
			local creature = tile:getTopCreature()
			if creature and creature:isPlayer() then
				
				if creature:getLevel() < config.requiredlevel then
					player:sendTextMessage(MESSAGE_STATUS_SMALL, "All players must be level "..config.requiredlevel.." or higher")
					return true
				end
				
				if creature:getStorageValue(config.storage) > os.time() then
					player:sendTextMessage(MESSAGE_STATUS_SMALL, "All players must wait for the cooldown.")
					return true
				end
				
				table.insert(checked, creature)
				table.insert(toKick, creature:getId())
			end
		end
	end
	cleanRoomMonsters()
	
	-- execute here mechanics functions
	local cBoss = Game.createMonster(config.boss, config.bossPosition)
	if cBoss then
		cBoss:registerEvent("FeasterOfSoulsBossesKill")
	end
	addEvent(spawnMonstersEvent, 2000)
	
	-- teleport player and set storage
	for _, p in pairs(checked) do
		p:sendTextMessage(MESSAGE_STATUS_SMALL, "You have "..config.timeToKill.." minutes to defeat the boss.")
		p:teleportTo(config.roomPlayerPosition)
		p:setStorageValue(config.storage, os.time() + (config.delayToDoAgain * 3600))
	end
	
	addEvent(kickPlayers, config.timeToKill * 60000, toKick)
	return true
end

-- DefaultBossLever:aid(50009)
DefaultBossLever:aid(37020)
DefaultBossLever:register()