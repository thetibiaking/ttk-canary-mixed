local talk = TalkAction("!selltournament")

function talk.onSay(player, words, param)
	--[[if not player:getGroup():getAccess() then
		return true
	end]]--


	if param == "" then
		return player:sendCancelMessage("[Sell Tournament System] Escolha uma quantidade de Tournament.")
	end

	local param2 = param:gsub("%.", "")
	
	if tonumber(param2) and tonumber(param2) >= 1 and (tonumber(param2) % 1) == 0 then
		if player:getTournamentCoinsBalance() >= tonumber(param2) then
			local papel = player:addItem(29019)
			if papel then
				if player:removeTournamentCoinsBalance(tonumber(param2)) then
					papel:setCustomAttribute("pontosTour", tonumber(param2))
					papel:setCustomAttribute("sellerTour", tonumber(player:getAccountId()))
					papel:setAttribute("description", "[Sell Tournament System] Este documento vale "..param2.." Tournament para você usar na store.")
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Sell Tournament System] Você transferiu "..param2.." points para este documento, agora seu saldo de Tournament é "..player:getTournamentCoinsBalance().." Tournament.")
					player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
				else
					player:sendCancelMessage("[Sell Tournament System] Desculpe, não foi possivel remover os Tournament da sua conta.")	
				end
			else
				player:sendCancelMessage("[Sell Tournament System] Você não tem espaço para o documento, libere um slot na sua backpack.")
			end
		else
			player:sendCancelMessage("[Sell Tournament System] Desculpe, os Tournament não foram encontrados.")
		end
	else
		player:sendCancelMessage("[Sell Tournament System] Escolha a quantidade de Tournament que você quer transferir ao documento.")
	end
	return false
end



		
talk:separator(" ")
talk:register()