local warzoneEntrance = MoveEvent()

function warzoneEntrance.onStepIn(creature, item, position, fromPosition, toPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local sol = Position(32208, 32093, 13)
	if item:getPosition() == Position(32042, 31938, 15) then
			player:teleportTo(sol)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
	local gelo = Position(32208, 32093, 13)
	if item:getPosition() == Position(32043, 31938, 15) then
		player:teleportTo(gelo)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
	local sol1 = Position(32208, 32093, 13)
	if item:getPosition() == Position(32042, 31939, 15) then
		player:teleportTo(sol1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
    local gelo1 = Position(32208, 32093, 13)
	if item:getPosition() == Position(32043, 31939, 15) then
		player:teleportTo(gelo1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

warzoneEntrance:type("stepin")
warzoneEntrance:aid(60200)
warzoneEntrance:register()
