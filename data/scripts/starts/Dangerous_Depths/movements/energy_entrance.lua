local energyEntrance = MoveEvent()

function energyEntrance.onStepIn(creature, item, position, fromPosition, toPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item:getPosition() == Position(33831, 32138, 14) then
		if player:getStorageValue(Storage.DangerousDepths.Scouts.Status) >= 10 then
			player:teleportTo(Position(34023, 32037, 14))
		else
			player:setStorageValue(Storage.DangerousDepths.Scouts.Status,10)
			player:teleportTo(Position(34023, 32037, 14))
		end
	elseif item:getPosition() == Position(34021, 32037, 14) then
	end

	if item:getPosition() == Position(33784, 32205, 14) then
		if player:getStorageValue(Storage.DangerousDepths.Dwarves.Status) >= 10 then
			player:teleportTo(Position(33921, 32401, 14))
		else
			player:setStorageValue(Storage.DangerousDepths.Dwarves.Status,10)
			player:teleportTo(Position(33921, 32401, 14))
		end
	elseif item:getPosition() == Position(33921, 32402, 14) then
		player:teleportTo(Position(33782, 32205, 14))
	end

	if item:getPosition() == Position(33829, 32187, 14) then
		if player:getStorageValue(Storage.DangerousDepths.Gnomes.Status) >= 10 then
			player:teleportTo(Position(33982, 32236, 14))
		else
			player:setStorageValue(Storage.DangerousDepths.Gnomes.Status,10)
			player:teleportTo(Position(33982, 32236, 14))
		end
	elseif item:getPosition() == Position(33982, 32234, 14) then
		player:teleportTo(Position(33829, 32186, 14))
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

energyEntrance:type("stepin")
energyEntrance:aid(57232)
energyEntrance:register()
