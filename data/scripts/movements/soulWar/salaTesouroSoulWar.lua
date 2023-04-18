--	Goshnar's Greed = 1024,
--	Goshnar's Cruelty = 1025,
--	Goshnar's Malice = 1026,
--	Goshnar's Spite = 1027,
--	Goshnar's Hatred = 1028,
--	Goshnar's Megalomania = 1029
--  player:teleportTo(Position(34060, 31028, 11))
local config = {
    [60114] = Position(33621, 31410, 10)
}

local salaTesouroSoulWar = MoveEvent()

function salaTesouroSoulWar.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    
    if not player then
        return true
    end
    
    local targetPosition = config[item.uid]
    if not targetPosition then
        return true
    end
    
    if player:getStorageValue(1029) > 0 then
        player:teleportTo(targetPosition)
        targetPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end
    
    player:teleportTo(Position(33621, 31418, 10))
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss Final Incompleto!")
end

salaTesouroSoulWar:type("stepin")

for index, value in pairs(config) do
    salaTesouroSoulWar:uid(index)
end

salaTesouroSoulWar:register()
