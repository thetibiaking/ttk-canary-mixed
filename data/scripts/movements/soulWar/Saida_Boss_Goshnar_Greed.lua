local config = {
    [60019] = Position(33621, 31426, 10)
}

local attributes = {
    centerPosition = Position(34060, 31092, 11),
    rangeX = 20,
    rangeY = 20,
    monsterName = "Goshnar's Greed",
    stg = 1024
}

local saidaBossSoulSpite = MoveEvent()

local function checkBossSpite(centerPosition, rangeX, rangeY, bossName)
    local spectators, spec = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
    for i = 1, #spectators do
        spec = spectators[i]
        if spec:isMonster() then
            if spec:getName() == bossName then
                return true
            end
        end
    end
    return false
end

function saidaBossSoulSpite.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    
    if not player then
        return true
    end
    
    if not checkBossSpite(attributes.centerPosition, attributes.rangeX, attributes.rangeY, attributes.monsterName) then
        if player:getStorageValue(attributes.stg) < 1 then
            player:setStorageValue(attributes.stg, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, attributes.monsterName .. " foi derrotado!")
        end
    end
    
    local teleport = config[item.actionid]
    if teleport then
        player:teleportTo(teleport)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

saidaBossSoulSpite:type("stepin")

for index, value in pairs(config) do
    saidaBossSoulSpite:aid(index)
end

saidaBossSoulSpite:register()
