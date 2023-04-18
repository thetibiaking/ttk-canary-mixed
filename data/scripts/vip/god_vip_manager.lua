local vipCommand = TalkAction("/vip")

function vipCommand.onSay(player, words, param)
	local howtouse = "How to use:\n /vip [playername], add, [value] | \n /vip [playername], remove \n(don't use [])"
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	
	if param == "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "missing parameter \n" ..howtouse)
		return false
	end
	local split = param:split(",")
	if not split[1] then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "missing command parameter \n" ..howtouse)
	end
	
	if not split[1] then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "missing parameter: PLAYER \n" ..howtouse)
	end
	local target = Player(split[1])
	if not target then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A player ".. split[1] .." is not online. \n" ..howtouse)
	end
	if not split[2] then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "missing parameter: ACTION (add/remove)\n" ..howtouse)
	end
	
	split[2] = split[2]:gsub("^%s*(.-)$", "%1")
	if split[2] == "add" then
		if split[3] then
			local count = tonumber(split[3])
			target:addVipDays(count)
			
			-- if target:customAddPremiumDays(count) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[" ..count.. "] dias de VIP enviados para: [" ..target:getName().. "]")
				return true
			-- else
				-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "missing parameter: VALUE. \n" ..howtouse)
				-- return true
			-- end
		end
	elseif split[2] == "remove" then
		target:removeVipTime()
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "vip de [" ..target:getName().. "] foi removido")
		return true
		-- if target:customRemovePremiumDays() then
		-- else
			-- player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "it was not possible to execute this, consult the developer. \n" ..howtouse)
			-- return true
		-- end
	end
	return false
end

vipCommand:separator(" ")
vipCommand:register()