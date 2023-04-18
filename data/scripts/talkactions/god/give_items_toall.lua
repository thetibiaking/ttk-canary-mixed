local give_items = TalkAction("/all")

function give_items.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local split = param:split(",")
	
	if not split[1] then
		player:sendCancelMessage("Command param required.")
		return false
	end
	local id = tonumber(split[1]) or 0
	local count = split[2] or 1
	
	if not ItemType(id) then
		player:sendCancelMessage("Command param required.")
		return false
	end
	
	for _, p in pairs(Game.getPlayers()) do
		p:addItem(id, count)
	end
	return false
end

give_items:separator(" ")
give_items:register()
