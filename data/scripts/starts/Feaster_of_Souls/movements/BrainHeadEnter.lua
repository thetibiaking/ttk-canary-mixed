BRAIN_HEAD_ROOM_TELEPORT = {}

local tpConfig = {
	right = {
		inside = 37012,
		outside = 37013,
		exitPos = Position(31972, 32325, 10),
		enterPos = Position(31964, 32324, 10),
	},
	up = {
		inside = 37014,
		outside = 37015,
		exitPos = Position(31955, 32307, 10),
		enterPos = Position(31954, 32315, 10),
	},
	left = {
		inside = 37016,
		outside = 37017,
		exitPos = Position(31935, 32325, 10),
		enterPos = Position(31944, 32324, 10),
	},
	down = {
		inside = 37018,
		outside = 37019,
		exitPos = Position(31953, 32343, 10),
		enterPos = Position(31954, 32335, 10),
	},
}

local config = {
	timeStorage = 1,
	timeToKill = 5, -- minutes
	centerPosition = Position(31954, 32325, 10),
	playerPosition = Position(31963, 32325, 10),
	bossPosition = Position(31954, 32325, 10),
	exitPos = Position(32001, 32342, 10),
	miniBrainPositions = {
		Position(31953, 32324, 10),
		Position(31955, 32324, 10),
		Position(31955, 32326, 10),
		Position(31953, 32326, 10),
		Position(31945, 32320, 10),
		Position(31960, 32320, 10),
		Position(31961, 32331, 10),
		Position(31945, 32331, 10)
	},
}

-- Storage.FeasterOfSouls.brainHeadTimer
-- GlobalStorage.BrainHeadInSession
-- GlobalStorage.BrainHeadFirst
-- primeiro player entra e dispara evento, que vai setar storage e fechar sala, e chamar outro evento pra kikar

local BrainHeadEnter = MoveEvent()

local function clearHeadRoom(kickPlayers)
	local specs = Game.getSpectators(config.centerPosition, false, false, 13, 13, 13, 13)
	for _, spec in pairs(specs) do
		if spec:isPlayer() and kickPlayers then
			spec:teleportTo(config.exitPos)
		else
			spec:remove()
		end
	end
end

local function endSessionEvent()
	clearHeadRoom(true)
	Game.setStorageValue(GlobalStorage.BrainHeadInSession, 0)
	Game.setStorageValue(GlobalStorage.BrainHeadFirst, 0)
end

local function initSessionEvent()
	Game.setStorageValue(GlobalStorage.BrainHeadInSession, 1)
	addEvent(endSessionEvent, 240000)
end

local function init_brainHead_mechanics()
	clearHeadRoom(false)
	local boss = Game.createMonster("Brain Head", config.bossPosition)
	if boss then
		boss:registerEvent("BrainHeadHealthChange")
		boss:registerEvent("FeasterOfSoulsBossesKill")
	end
	for _, pos in pairs(config.miniBrainPositions) do
		Game.createMonster("Cerebellum", pos)
	end
end

function BrainHeadEnter.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end
	
	local aid = item:getActionId()
	local tpData = BRAIN_HEAD_ROOM_TELEPORT[aid]
	if not tpData then
		creature:teleportTo(fromPosition)
		return true
	end
	
	if not tpData.entering then
		creature:teleportTo(fromPosition)
		return true
	end
	
	if creature:getStorageValue(Storage.FeasterOfSouls.brainHeadTimer) > os.time() then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need wait to face this enemy again.")
		return true
	end
	
	if Game.getStorageValue(GlobalStorage.BrainHeadInSession) > 0 then
		creature:teleportTo(fromPosition)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The boss fight has already started.")
		return true
	end
	
	if Game.getStorageValue(GlobalStorage.BrainHeadFirst) <= 0 then
		addEvent(initSessionEvent, 60000)
		Game.setStorageValue(GlobalStorage.BrainHeadFirst, 1)
		init_brainHead_mechanics()
	end
	
	creature:teleportTo(tpData.pos)
	creature:setStorageValue(Storage.FeasterOfSouls.brainHeadTimer, os.time() + 72000)
	return true
end

BrainHeadEnter:type("stepin")

for dir, data in pairs(tpConfig) do
	BRAIN_HEAD_ROOM_TELEPORT[data.inside] = {pos = data.exitPos}
	BRAIN_HEAD_ROOM_TELEPORT[data.outside] = {pos = data.enterPos, entering = true}
	BrainHeadEnter:aid(data.inside)
	BrainHeadEnter:aid(data.outside)
end

BrainHeadEnter:register()