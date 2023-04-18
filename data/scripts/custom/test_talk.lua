local test_talk = TalkAction("/test")

function test_talk.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
	return true
end

test_talk:separator(" ")
test_talk:register()