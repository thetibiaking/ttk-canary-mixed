local config = {
    [60001] = Position(33459, 31499, 13),
	[60002] = Position(33519, 31439, 13), 
	[60003] = Position(33458, 31406, 13), 
	[60004] = Position(33425, 31499, 13), 
	[60005] = Position(33428, 31406, 13),	
	[60006] = Position(33493, 31544, 13),
	[14344] = Position(32181, 31240, 14),
	[14323] = Position(32242, 31247, 14),
	[14342] = Position(32306, 31247, 14),   
	[14349] = Position(32203, 31285, 14), 
	[14346] = Position(32337, 31289, 14), 
	[14351] = Position(32272, 31381, 14), 
	[60300] = Position(34058, 31027, 11),	
	[60101] = Position(34091, 31087, 11),
	[60105] = Position(34095, 31060, 11),
	[60111] = Position(34064, 30992, 11)
}

local vortexBoses = MoveEvent()

function vortexBoses.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local targetPosition = config[item.uid]
    if not targetPosition then
        return true
    end

    player:teleportTo(targetPosition)
    targetPosition:sendMagicEffect(CONST_ME_TELEPORT)    
    return true
end

vortexBoses:type("stepin")

for index, value in pairs(config) do
    vortexBoses:uid(index)
end

vortexBoses:register()