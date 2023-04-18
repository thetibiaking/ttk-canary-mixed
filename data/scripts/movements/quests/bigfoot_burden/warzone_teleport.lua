local destinations = {
	[3140] = {teleportPosition = Position(32996, 31922, 10), storage = Storage.BigfootBurden.Warzone1Access, value = 1},
	[3141] = {teleportPosition = Position(33011, 31943, 11), storage = Storage.BigfootBurden.Warzone2Access, value = 2},
	[3142] = {teleportPosition = Position(32989, 31909, 12), storage = Storage.BigfootBurden.Warzone3Access, value = 3},
}

local warzoneTeleport = MoveEvent()

function warzoneTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local destination = destinations[item.uid]
	if not destination then
		return true
	end

	player:teleportTo(destination.teleportPosition)
	destination.teleportPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

warzoneTeleport:type("stepin")

for index, value in pairs(destinations) do
	warzoneTeleport:uid(index)
end

warzoneTeleport:register()
