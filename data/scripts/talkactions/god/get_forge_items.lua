local testTalk = TalkAction("/forgeitems")

function testTalk.onSay(player, words, param)

	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	
	if param == "dust" then
		player:addForgeDust(500)
	elseif param == "core" then
		player:addForgeCores(500)
	elseif param == "silver" then
		player:addSlivers(500)
	end


	return false
end

testTalk:separator(" ")
testTalk:register()
