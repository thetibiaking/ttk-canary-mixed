local aidTarget = {
	[4600] = {pos = Position(33564, 31494, 8), storage = Storage.FeasterOfSouls.UnazTheMeanTimer}, -- Enter Unaz The Mean
	[4601] = {pos = Position(33567, 31477, 8)}, -- Unaz The Mean Exit
	
	[4602] = {pos = Position(33467, 31398, 8), storage = Storage.FeasterOfSouls.IrgixTheFlimsyTimer}, -- Enter Irgix The Flimsy
	[4603] = {pos = Position(33493, 31400, 8)}, -- Irgix The Flimsy Exit
	
 	[4604] = {pos = Position(33505, 31487, 9), storage = Storage.FeasterOfSouls.VokTheFreakish}, -- Enter Vok The Freakish
	[4605] = {pos = Position(33509, 31452, 9)}-- Vok The Freakish Exit
}

local bossConfig = {
	[4600] = {
		boss = "Unaz The Mean",
		timeToKill = 10, -- minutes
		requiredlevel = 150,
		centerPosition = Position(33569, 31497, 8),
		playerPosition = Position(33564, 31493, 8),
		bossPosition = Position(33577, 31492, 8),
		kickPosition = Position(33567, 31477, 8),
		range = {x = 15, y = 12},
	},
	[4602] = {
		boss = "Irgix The Flimsy",
		timeToKill = 10, -- minutes
		requiredlevel = 150,
		centerPosition = Position(33467, 31400, 8),
		playerPosition = Position(33467, 31398, 8),
		bossPosition = Position(33468, 31405, 8),
		kickPosition = Position(33493, 31400, 8),
		range = {x = 10, y = 10},
	},
	[4604] = {
		boss = "Vok The Freakish",
		timeToKill = 10, -- minutes
		requiredlevel = 150,
		centerPosition = Position(33508, 31490, 9),
		playerPosition = Position(33507, 31486, 9),
		bossPosition = Position(33509, 31493, 9),
		kickPosition = Position(33509, 31452, 9),
		range = {x = 10, y = 10},
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
	local data = aidTarget[aid]
	if not data then
		return true
	end
	
	if not data.storage then
		creature:teleportTo(data.pos)
		return true
	end
	
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
	
	if creature:getStorageValue(data.storage) > os.time() then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wait the cooldown.")
		return true
	end
	cleanRoomMonsters(bossData)
	
	Game.createMonster(bossData.boss, bossData.bossPosition)
	
	creature:teleportTo(bossData.playerPosition)
	
	creature:setStorageValue(data.storage, os.time() + 72000)
	
	addEvent(kickPlayer, bossData.timeToKill * 60000, bossData, creature:getId())
	return true
end

feasterMini:type("stepin")

for actionId, data in pairs(aidTarget) do
	feasterMini:aid(actionId)
end

feasterMini:register()