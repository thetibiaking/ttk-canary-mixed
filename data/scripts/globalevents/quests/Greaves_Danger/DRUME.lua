local config = {
    monsterName = 'Drume',
    bossPosition = Position(1161, 1027, 7),
    centerPosition = Position(1161, 1027, 7),
    rangeX = 4,
    rangeY = 4
}

local function checkBoss(centerPosition, rangeX, rangeY, bossName)
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

local Drume = GlobalEvent("Drume")
function Drume.onThink(interval, lastExecution)
    if checkBoss(config.centerPosition, config.rangeX, config.rangeY, config.monsterName) then
        return true
    end

    local boss =
    Game.createMonster(config.monsterName, config.bossPosition, true, true)    
    return true
end

Drume:interval(1000)
Drume:register()