--	Goshnar's Greed = 1024,
--	Goshnar's Cruelty = 1025,
--	Goshnar's Malice = 1026,
--	Goshnar's Spite = 1027,
--	Goshnar's Hatred = 1028,
--	Goshnar's Megalomania = 1029
--  player:teleportTo(Position(34060, 31028, 11))
local config = {
    [60113] = Position(34060, 31028, 11)
}

local soulWarMovimento = MoveEvent()

function soulWarMovimento.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    
    if not player then
        return true
    end
    
    local targetPosition = config[item.uid]
    if not targetPosition then
        return true
    end
    
    if (player:getStorageValue(1024) > 0 and player:getStorageValue(1025) > 0
        and player:getStorageValue(1026) > 0 and player:getStorageValue(1027) > 0
        and player:getStorageValue(1028) > 0) then
        player:teleportTo(targetPosition)
        targetPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end
    
    player:teleportTo(Position(33613, 31430, 10))
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bosses Incompletos!")
end

soulWarMovimento:type("stepin")

for index, value in pairs(config) do
    soulWarMovimento:uid(index)
end

soulWarMovimento:register()
