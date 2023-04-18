local tree = Action()

local aiddata = {
	[38728] = Position(32526, 32489, 11),
	[38729] = Position(32418, 32460, 7),
}

function tree.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local pos = aiddata[item:getActionId()]
	if not pos then
		return true
	end
	
	player:teleportTo(pos)
	
	return true
end

for aid, pos in pairs(aiddata) do
	tree:aid(aid)
end

-- tree:register()