local tCoins = TalkAction("/tc")

function tCoins.onSay(player, words, param)

	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end
	
  	local split  = param:split(",")
  	local name   = (split[1])
  	local amount = tonumber(split[2])
		
	local accountId = getAccountNumberByPlayerName(name)
	if accountId == 0 then
		return false
	end

	db.query("UPDATE `accounts` SET `coins` = (`coins`+ " .. amount .. ") WHERE `id` = " .. accountId)
	
	player:sendCancelMessage("Nome: " .. name .. ". Quantidade:" .. amount .. ".")

end

tCoins:separator(" ")
tCoins:register()