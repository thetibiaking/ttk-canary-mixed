local warzoneEntrance = MoveEvent()

function warzoneEntrance.onStepIn(creature, item, position, fromPosition, toPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local warzoneVI = Position(33367, 32307, 15)
	if item:getPosition() == Position(33829, 32128, 14) then
			player:teleportTo(warzoneVI)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Entering the warzone.")		
	end
	local warzoneV = Position(33208, 32119, 15)
	if item:getPosition() == Position(33777, 32192, 14) then
		player:teleportTo(warzoneV)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Entering the warzone.")		
	end
	local warzoneIV = Position(33534, 32184, 15)
	if item:getPosition() == Position(33827, 32172, 14) then
		player:teleportTo(warzoneIV)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Entering the warzone.")		
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

warzoneEntrance:type("stepin")
warzoneEntrance:aid(57230)
warzoneEntrance:register()
