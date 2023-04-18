local misguided = {
	[1] = Position(32527, 32468, 10),
	[2] = Position(32528, 32468, 10),
	[3] = Position(32529, 32468, 10),
	[4] = Position(32530, 32468, 10),
	[5] = Position(32531, 32468, 10),
	[6] = Position(32532, 32468, 10),
	[7] = Position(32533, 32468, 10),
	[8] = Position(32534, 32468, 10),
	[9] = Position(32535, 32468, 10),
	[10] = Position(32536, 32468, 10),
	[11] = Position(32537, 32468, 10),
	[12] = Position(32538, 32468, 10)
}

local energyFence = MoveEvent()

function energyFence.onStepIn(creature, item, position, fromPosition)
	local firstCheck = Position(32350, 31657, 8)
	local secondCheck = Position(32327, 31692, 9)
	local misguidedFirst = Position(32527, 32468, 10)

	local player = creature:getPlayer()
	if not player then
		creature:teleportTo(fromPosition)
		return false
	end

	if position == firstCheck or position == Position(firstCheck.x + 1, firstCheck.y, firstCheck.z) or
	position == Position(firstCheck.x + 2, firstCheck.y, firstCheck.z) then
		if player:getStorageValue(Storage.CultsOfTibia.Humans.Vaporized) == 10 then
			player:setStorageValue(Storage.CultsOfTibia.Humans.Vaporized,10)					
			player:teleportTo(fromPosition, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"The combined powers of decaying souls \z
			roaming these halls may help breach this barrier, it needs but a vessel to bind them.")
		else
			player:teleportTo(fromPosition, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE,"The combined powers of decaying souls \z
			roaming these halls may help breach this barrier, it needs but a vessel to bind them.")
		end
	elseif position == secondCheck or position == Position(secondCheck.x + 1, secondCheck.y, secondCheck.z) then
		if player:getStorageValue(Storage.CultsOfTibia.Humans.Decaying) == 10 then
			player:setStorageValue(Storage.CultsOfTibia.Humans.Decayin,10)
			player:teleportTo(fromPosition, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The combined powers of decaying souls \z
			roaming these halls may help breach this barrier, it needs but a vessel to bind them.")
		else
			player:teleportTo(fromPosition, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The combined powers of decaying souls \z
			roaming these halls may help breach this barrier, it needs but a vessel to bind them.")
		end
	elseif misguided then
		for i, position in pairs(misguided) do
			if player:getStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms) >= 5 then
				
				player:setStorageValue(Storage.CultsOfTibia.Misguided.Exorcisms,5)
				player:teleportTo(fromPosition, true)
				break
			else
				player:teleportTo(fromPosition, true)
			end
		end
	end
	return true
end

energyFence:type("stepin")
energyFence:aid(5581)
energyFence:register()
