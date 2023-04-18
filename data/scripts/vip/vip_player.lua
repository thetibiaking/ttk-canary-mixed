local vipTime = TalkAction("!vip")

function vipTime.onSay(player, words, param)
	local tileLeft = player:getVipTimeLeft()
	if not tileLeft then
		player:sendTextMessage(MESSAGE_LOOT, "Seu tempo vip acabou.")
		return false
	end
	player:sendTextMessage(MESSAGE_LOOT, tileLeft .. " de vip restantes.")
	return false
end

vipTime:register()