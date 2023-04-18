local vial = TalkAction("!vial")

function vial.onSay(player, words, param)
	local switch = player:getStorageValue(81415) == -1 and 1 or -1
	
	if switch == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Vials Ativados.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Vials desativados.")
	end
	
	player:setStorageValue(81415, switch)

end

vial:register()
