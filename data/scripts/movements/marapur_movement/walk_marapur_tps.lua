local tile_enter = MoveEvent()

local pos_data = {
	{from = Position(33718, 32995, 8), to = Position(33705, 33000, 7)}, -- two turtle exit
	{from = Position(33709, 32998, 7), to = Position(33721, 32996, 8)}, -- turtle enter 
	{from = Position(33769, 32920, 7), to = Position(33781, 32696, 8)}, -- timiral boss
	{from = Position(33780, 32696, 8), to = Position(33769, 32921, 7)}, -- Marapur enter
	{from = Position(33808, 33072, 7), to = Position(33036, 32738, 2)}, -- Marapur exit
	{from = Position(33036, 32737, 2), to = Position(33808, 33073, 7)}, -- Marapur exit
	
	--{from = Position(33745, 32915, 9), to = Position(33752, 32877, 10)}, -- Marapur exit
	--{from = Position(33763, 32910, 9), to = Position(33768, 32912, 9)}, -- Marapur exit
	--{from = Position(33752, 32878, 10), to = Position(33746, 32915, 9)}, -- Marapur exit
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