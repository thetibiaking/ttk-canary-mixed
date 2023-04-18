local storageSet = TalkAction("/calaboca")

function storageSet.onSay(player, words, param)

	if player:getAccountType() < ACCOUNT_TYPE_TUTOR then
		return false
	end

	local split = param:split(",")
	if split[2] == nil then
		player:sendCancelMessage("Insufficient parameters.")
		return false
	end

	local target = Player(split[1])
	if target == nil then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	split[2] = split[2]:gsub("^%s*(.-)$", "%1")
	local ch = split[2]
	target:setStorageValue(4561177, os.time() + tonumber(ch) * 60 * 60)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "você foi mutado por  ".. player:getName() .." por ".. tonumber(ch).." horas.")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você mutou o jogador ".. target:getName() .." por ".. tonumber(ch).." horas.")
	return false
end

storageSet:separator(" ")
storageSet:register()
