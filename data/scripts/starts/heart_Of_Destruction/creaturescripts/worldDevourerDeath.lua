local worldDevourerDeath = CreatureEvent("worldDevourerDeath")
function worldDevourerDeath.onDeath(creature)
	local centerRoom = Position(32299, 31372, 14)
	local specs = Game.getSpectators(centerRoom, false, true, 13, 13, 13, 13)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			spec:teleportTo(Position(32113, 31373, 14))
		end
	end
	return true
end
worldDevourerDeath:register()
