local config = {
    [50010] = Position(33535, 31447, 8),	
    [50011] = Position(33547, 31444, 8),	
	[50012] = Position(33484, 31452, 9),
	[50013] = Position(33486, 31435, 8),
	[50014] = Position(33546, 31412, 9),
	[50015] = Position(33529, 31410, 9),
	[50016] = Position(33554, 31437, 9),
	[50017] = Position(33536, 31439, 9),
	[50018] = Position(33574, 31467, 9),
	[50019] = Position(33553, 31468, 9)
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