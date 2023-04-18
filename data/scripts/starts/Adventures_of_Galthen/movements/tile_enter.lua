local tile_enter = MoveEvent()

local pos_data = {
	{from = Position(32582, 32481, 12), to = Position(32575, 32500, 12)}, -- lever room enter
	{from = Position(32582, 32500, 12), to = Position(32578, 32478, 12)}, -- lever room exit
	{from = Position(32615, 32507, 12), to = Position(32576, 32501, 12)}, -- room exit
}

function tile_enter.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end
	
	for _, data in pairs(pos_data) do
		local from = data.from
		if position.x == from.x and position.y == from.y and position.z == from.z then
			creature:teleportTo(data.to)
			return true
		end
	end
	
	return true
end

tile_enter:type("stepin")
for _, data in pairs(pos_data) do
	tile_enter:position(data.from)
end

tile_enter:register()