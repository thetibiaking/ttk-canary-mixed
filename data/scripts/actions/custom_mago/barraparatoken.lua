local tibiaCoinItem = Action()
function tibiaCoinItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- local count = item:getCount()
	
	player:addTournamentCoinsBalance(1)
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	player:sendTextMessage("Adicionado pra voce 1 Tournament Coin no seu saldo.")
	item:remove(1)
	return true
end

tibiaCoinItem:id(15515)
tibiaCoinItem:register()