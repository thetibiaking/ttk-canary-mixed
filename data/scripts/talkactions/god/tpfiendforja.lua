local storageSet = TalkAction("/forja")

function storageSet.onSay(cid, words, param)
	local player = Player(cid)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local targetMonster = nil
	local monsters = Game.getFiendishMonsters()

	for _, monster in pairs(monsters) do
		local mob = Creature(monster)
		if not targetMonster then
			targetMonster = mob
		end
		
		if (getDistanceBetween(player:getPosition(), mob:getPosition()) <= (getDistanceBetween(player:getPosition(), targetMonster:getPosition()))) then
			targetMonster = mob
		end
	end
	
	if not targetMonster then
		return true
	end

	player:teleportTo(targetMonster:getPosition())
	return false
end

storageSet:separator(" ")
storageSet:register()