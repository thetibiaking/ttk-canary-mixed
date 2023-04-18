local config = {
    [61025] = Position(33491, 31545, 13)
}

local attributes = {
    centerPosition = Position(33443, 31546, 13),
    rangeX = 40,
    rangeY = 40,
    monsterName = "King Zelos"    
}

local saidaBossKingZelos = MoveEvent()

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

function saidaBossKingZelos.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    
    if not player then
        return true
    end
    
    if not checkBossSpite(attributes.centerPosition, attributes.rangeX, attributes.rangeY, attributes.monsterName) then
        player:addOutfitAddon(1243, 2)
		player:addOutfitAddon(1243, 1)
		player:addOutfitAddon(1244, 1)
		player:addOutfitAddon(1244, 2)
    end
    
    local teleport = config[item.actionid]
    if teleport then
        player:teleportTo(teleport)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

saidaBossKingZelos:type("stepin")

for index, value in pairs(config) do
    saidaBossKingZelos:aid(index)
end

saidaBossKingZelos:register()
