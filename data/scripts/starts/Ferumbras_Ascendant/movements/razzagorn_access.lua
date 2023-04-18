local razzagornAccess = MoveEvent()

function razzagornAccess.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.FerumbrasAscension.TheShatterer) >= 1 then
		player:teleportTo(Position(33437, 32443, 15))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		local pos = player:getPosition()
		player:teleportTo(Position(33437, 32443, 15))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

razzagornAccess:type("stepin")
razzagornAccess:aid(53801)
razzagornAccess:register()
