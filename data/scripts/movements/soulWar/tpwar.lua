local warzoneEntrance = MoveEvent()

function warzoneEntrance.onStepIn(creature, item, position, fromPosition, toPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local tppreto = Position(33857, 31833, 3)
	if item:getPosition() == Position(33624, 31422, 10) then
			player:teleportTo(tppreto)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
	local tpverde = Position(33988, 31001, 9)
	if item:getPosition() == Position(33615, 31422, 10) then
		player:teleportTo(tpverde)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
	local tpvermelho = Position(33948, 31027, 11)
	if item:getPosition() == Position(33618, 31422, 10) then
		player:teleportTo(tpvermelho)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
    local tpamarelo = Position(33886, 31188, 10)
	if item:getPosition() == Position(33627, 31422, 10) then
		player:teleportTo(tpamarelo)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
    local tproxo = Position(33881, 31002, 8)
	if item:getPosition() == Position(33621, 31422, 10) then
		player:teleportTo(tproxo)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce entrou")		
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

warzoneEntrance:type("stepin")
warzoneEntrance:aid(60201)
warzoneEntrance:register()
