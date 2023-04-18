local teleportToTown = TalkAction("/town")

function teleportToTown.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < 4 then
		return true
	end

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local town = Town(param) or Town(tonumber(param))
	if town then
		player:teleportTo(town:getTemplePosition())
	else
		player:sendCancelMessage("Town not found.")
	end
	return false
end

teleportToTown:separator(" ")
teleportToTown:register()
