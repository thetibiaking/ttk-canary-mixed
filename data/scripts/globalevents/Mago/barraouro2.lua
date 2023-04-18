local config = {
    storage = 20000,
    pointItemId = 15515,
    pointsPerHour = 10,
    pointsPervip = 30,
    checkDuplicateIps = false
}

local onlinePointsEvent = GlobalEvent("GainPointPerVip")

function onlinePointsEvent.onThink(interval)
    local players = Game.getPlayers()
    if #players == 0 then
        return true
    end

    local checkIp = {}
    for _, player in pairs(players) do
        local ip = player:getIp()
        if ip ~= 0 and (not config.checkDuplicateIps or not checkIp[ip]) then
            checkIp[ip] = true
            local seconds = math.max(0, player:getStorageValue(config.storage))
            if seconds >= 3600 then
                player:setStorageValue(config.storage, 0)

                local quantidade = config.pointsPerHour
				-- VipSystemOldRequireChanges
                if player:isVip() then 
                    quantidade = config.pointsPervip
                end

                local item = player:addItem(config.pointItemId, quantidade)
                if item then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received ".. quantidade .." bars of gold for staying 1h online.")
                end
                return true
            end

            player:setStorageValue(config.storage, seconds +math.ceil(interval/1000))
        end
    end
    return true
end

onlinePointsEvent:interval(1000)
onlinePointsEvent:register()