local bossConfig = {
	[65115] = {
		boss = "Yirkas Blue Scales",
		storage = Storage.WereLionMiniBosses.YirkasBlueScales,
		timeToKill = 10, -- minutes
		requiredlevel = 100,
		centerPosition = Position(33157, 32251, 12),
		playerPosition = Position(33152, 32247, 12),
		bossPosition = Position(33157, 32251, 12),
		kickPosition = Position(33123, 32234, 12),
		range = {x = 12, y = 13},
	},
	[65121] = {
		boss = "Katex Blood Tongue",
		storage = Storage.WereLionMiniBosses.KatexBloodTongue,
		timeToKill = 10, -- minutes
		requiredlevel = 100,
		centerPosition = Position(33087, 32246, 12),
		playerPosition = Position(33085, 32240, 12),
		bossPosition = Position(33087, 32246, 12),
		kickPosition = Position(33123, 32234, 12),
		range = {x = 8, y = 22},
	},
	[65119] = {
		boss = "Srezz Yellow Eyes",
		storage = Storage.WereLionMiniBosses.SrezzYellowEyes,
		timeToKill = 10, -- minutes
		requiredlevel = 100,
		centerPosition = Position(33122, 32283, 12),
		playerPosition = Position(33121, 32277, 12),
		bossPosition = Position(33122, 32283, 12),
		kickPosition = Position(33123, 32234, 12),
		range = {x = 6, y = 9},
	},
	[65117] = {
		boss = "Utua Stone Sting",
		storage = Storage.WereLionMiniBosses.UtuaStoneSting,
		timeToKill = 10, -- minutes
		requiredlevel = 100,
		centerPosition = Position(33152, 32287, 12),
		playerPosition = Position(33150, 32283, 12),
		bossPosition = Position(33152, 32287, 12),
		kickPosition = Position(33123, 32234, 12),
		range = {x = 14, y = 16},
	},
}

local function kickPlayer(bossData, kickPid)
	local range = bossData.range
	local specs = Game.getSpectators(bossData.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			if spec:getId() == kickPid then
				spec:teleportTo(bossData.kickPosition)
				spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Time over.")
			end
		end
	end
end

local function roomIsOcuped(bossData)
	if not bossData then return true end
	local range = bossData.range
	local specs = Game.getSpectators(bossData.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			return true
		end
	end
	return false
end

local function cleanRoomMonsters(bossData)
	local range = bossData.range
	local specs = Game.getSpectators(bossData.centerPosition, false, false, range.x, range.x, range.y, range.y)
	for _, spec in pairs(specs) do
		if not spec:isPlayer() then
			spec:remove()
		end
	end
end

local feasterMini = MoveEvent()

function feasterMini.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end
	
	local aid = item:getActionId()
	local bossData = bossConfig[aid]
	if roomIsOcuped(bossData) then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only one player at a time.")
		return true
	end
	
	if creature:getLevel() < bossData.requiredlevel then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need level "..bossData.requiredlevel.." to this.")
		return true
	end
	
	if creature:getStorageValue(bossData.storage) > os.time() then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wait the cooldown.")
		return true
	end
	cleanRoomMonsters(bossData)
	
	Game.createMonster(bossData.boss, bossData.bossPosition)
	
	creature:teleportTo(bossData.playerPosition)
	
	creature:setStorageValue(bossData.storage, os.time() + 72000)
	
	addEvent(kickPlayer, bossData.timeToKill * 60000, bossData, creature:getId())
	return true
end

feasterMini:type("stepin")

for actionId, data in pairs(bossConfig) do
	feasterMini:aid(actionId)
end

feasterMini:register()