local bless = TalkAction("!bless")

function bless.onSay(player, words, param)
	if player:isVip() then
		return Blessings.BuyAllBlesses(player)
	else
		player:sendCancelMessage("You need to be vip to use this command.")
	end
	return false
end

bless:register()
