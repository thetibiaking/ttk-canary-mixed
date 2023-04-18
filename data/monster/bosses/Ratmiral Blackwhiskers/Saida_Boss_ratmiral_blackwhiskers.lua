local config = {
    [61024] = Position(33826, 31424, 6)
}

local attributes = {
    centerPosition = Position( 33821, 31387, 7),
    rangeX = 40,
    rangeY = 40,
    monsterName = "Ratmiral Blackwhiskers"    
}

local saidaBossRatmiral = MoveEvent()

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

function saidaBossRatmiral.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    
    if not player then
        return true
    end
    
    if not checkBossSpite(attributes.centerPosition, attributes.rangeX, attributes.rangeY, attributes.monsterName) then
        player:addOutfitAddon(1372, 2)
		player:addOutfitAddon(1372, 1)
		player:addOutfitAddon(1371, 1)
		player:addOutfitAddon(1371, 2)
    end
    
    local teleport = config[item.actionid]
    if teleport then
        player:teleportTo(teleport)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        teleport:sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

saidaBossRatmiral:type("stepin")

for index, value in pairs(config) do
    saidaBossRatmiral:aid(index)
end

saidaBossRatmiral:register()
