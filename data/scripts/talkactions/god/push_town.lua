local pushTown = TalkAction("/t")

function pushTown.onSay(player, words, param)
	
	if not player:getGroup():getAccess() or player:getAccountType() < 4 then
		return true
	end

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end

pushTown:register()
