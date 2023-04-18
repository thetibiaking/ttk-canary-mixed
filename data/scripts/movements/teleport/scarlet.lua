local scarletAntiBug = MoveEvent()

function scarletAntiBug.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		creature:teleportTo(fromPosition)
		return false
	end

	player:teleportTo(Position(33395, 32665, 6))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

scarletAntiBug:type("stepin")
scarletAntiBug:aid(12989)
scarletAntiBug:register()
