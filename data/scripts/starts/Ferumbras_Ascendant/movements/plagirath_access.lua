local plagirathAccess = MoveEvent()

function plagirathAccess.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.FerumbrasAscension.TheLordOfTheLiceAccess) < 1 then
		local pos = player:getPosition()
		player:teleportTo(Position(33238, 31477, 13))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	player:teleportTo(Position(33238, 31477, 13))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

plagirathAccess:type("stepin")
plagirathAccess:aid(53800)
plagirathAccess:register()
