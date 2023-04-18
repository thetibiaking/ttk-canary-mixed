function canJoin(player)
	return player:getVocation():getId() ~= VOCATION_NONE or player:getAccountType() >= ACCOUNT_TYPE_SENIORTUTOR
end

local WORLD_ADVERTISING = 3

local muted = Condition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT)
muted:setParameter(CONDITION_PARAM_SUBID, WORLD_ADVERTISING)
muted:setParameter(CONDITION_PARAM_TICKS, 120000)

function onSpeak(player, type, message)
	if player:getAccountType() >= ACCOUNT_TYPE_GAMEMASTER then
		if type == TALKTYPE_CHANNEL_Y then
			return TALKTYPE_CHANNEL_O
		end
		return true
	end
	
	if player:getStorageValue(4561177) > os.time() then
		player:sendCancelMessage("Voce esta mutado em todos os Channels.")
		return false
	end
	
	if player:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, WORLD_ADVERTISING) then
		player:sendCancelMessage("Espere dois minutos para falar novamente.")
		return false
	end
	player:addCondition(muted)

	if type == TALKTYPE_CHANNEL_O then
		if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
			type = TALKTYPE_CHANNEL_Y
		end
	elseif type == TALKTYPE_CHANNEL_R1 then
		if not player:hasFlag(PlayerFlag_CanTalkRedChannel) then
			type = TALKTYPE_CHANNEL_Y
		end
	end
	return type
end
