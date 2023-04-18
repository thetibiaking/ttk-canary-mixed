local tibiaCoinItem = Action()
function tibiaCoinItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	player:sendCancelMessage("Entrou aqui")
		
	local accountId = getAccountNumberByPlayerName(player:getName())
	
	if accountId == 0 then
		return false
	end

	db.query("UPDATE `accounts` SET `coins` = (`coins`+ " .. 100 .. ") WHERE `id` = " .. accountId)
	
	player:sendCancelMessage("Adicionado pra voce: " .. 100 .. " Tibia Coins.")
	
	item:remove(1)
	
	return true
end

tibiaCoinItem:id(24774)
tibiaCoinItem:register()