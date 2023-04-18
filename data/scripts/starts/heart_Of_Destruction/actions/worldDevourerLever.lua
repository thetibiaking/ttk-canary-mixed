--== Default boss Lever Script

local config = {
	boss = "World Devourer",
	timeToKill = 10, -- minutes
	delayToDoAgain = 20, -- hours
	requiredlevel = 150,
	centerPosition = Position(32299, 31372, 14),
	roomPlayerPosition = Position(32291, 31372, 14),
	bossPosition = Position(32299, 31372, 14),
	kickPosition = Position(32272, 31381, 14),
	storage = 14333,
	range = {x = 13, y = 13},
	leverPositions = {
		Position(32272, 31374, 14),
		
		Position(32271, 31374, 14),
		Position(32271, 31375, 14),
		Position(32271, 31376, 14),
		Position(32271, 31377, 14),
		Position(32271, 31378, 14),
		
		Position(32272, 31375, 14),
		Position(32272, 31376, 14),
		Position(32272, 31377, 14),
		Position(32272, 31378, 14),
		
		Position(32273, 31374, 14),
		Position(32273, 31375, 14),
		Position(32273, 31376, 14),
		Position(32273, 31377, 14),
		Position(32273, 31378, 14),
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
	
	if #checked < 5 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Minimum of 5 people to face the boss.")
		-- return true
	end
	
	cleanRoomMonsters()
	
	-- execute here mechanics functions
	local cBoss = Game.createMonster(config.boss, config.bossPosition)
	
	-- teleport player and set storage
	for _, p in pairs(checked) do
		p:sendTextMessage(MESSAGE_STATUS_SMALL, "You have "..config.timeToKill.." minutes to defeat the boss.")
		p:teleportTo(config.roomPlayerPosition)
		p:setStorageValue(config.storage, os.time() + (config.delayToDoAgain * 3600))
	end
	
	addEvent(kickPlayers, config.timeToKill * 60000, toKick)
	return true
end

DefaultBossLever:aid(14332)
-- DefaultBossLever:uid()
DefaultBossLever:register()