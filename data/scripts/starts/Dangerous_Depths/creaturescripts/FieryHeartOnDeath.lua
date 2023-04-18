local FieryHeartOnDeath = CreatureEvent("FieryHeartOnDeath")
function FieryHeartOnDeath.onDeath(creature)
	local pos = creature:getPosition()
	Game.createMonster("Fiery Blood", pos, true, true)
	return true
end

FieryHeartOnDeath:register()