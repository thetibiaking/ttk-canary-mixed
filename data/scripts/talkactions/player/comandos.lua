local tutorPosition = TalkAction("!comandos")

function tutorPosition.onSay(player, words, param)

	local position = player:getPosition()
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "!autoloot -- !serverinfo -- !online - !bless - !buyhouse - !leavehouse - !sellhouse - !aol - !time -- !vial")
	return false
end

tutorPosition:register()
