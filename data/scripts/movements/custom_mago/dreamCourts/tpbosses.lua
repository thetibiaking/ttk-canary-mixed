local settings = {
	["Sunday"] = {
		teleportPosition = Position(1239, 1008, 7)
	},
	["Monday"] = {
		teleportPosition = Position(1328, 1009, 7)
	},
	["Tuesday"] = {
		teleportPosition = Position(1415, 1009, 7)
	},
	["Wednesday"] = {
		teleportPosition = Position(1501, 1009, 7)
	},
	["Thursday"] = {
		teleportPosition = Position(1586, 1009, 7)
	},
	["Friday"] = {
		teleportPosition = Position(1328, 1009, 7)
	},
	["Saturday"] = {
		teleportPosition = Position(1586, 1009, 7)
	},
}

local bossEntrance = MoveEvent()

function bossEntrance.onStepIn(creature, item, position, fromPosition, toPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local setting = settings[os.date("%A")]
	if not setting then
		return true
	end

	player:teleportTo(setting.teleportPosition)
	return true
end

bossEntrance:type("stepin")
bossEntrance:aid(65534)
bossEntrance:register()
