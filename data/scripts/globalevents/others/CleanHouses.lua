local cleanhouses = GlobalEvent("cleanhouses")

local config = {
    days = 7,
    log = true,
    file = "data/logs/cleanhouses.txt"
}

local function doWriteLogFile(file, text)
    local f = io.open(file, "a+")
    if not f then
        return false
    end

    f:write("[" .. os.date("%d/%m/%Y %H:%M:%S") .. "] " .. text .. "\n")
    f:close()
    return true
end



function cleanhouses.onStartup()
   local logs = "Houses Limpas:\n\n"
    local resultId = db.storeQuery("SELECT `h`.`id` AS `id`, `p`.`name` AS `playerName` FROM `houses` AS `h` LEFT JOIN `players` AS `p` ON `p`.`id` = `h`.`owner` WHERE `p`.`lastlogin` < UNIX_TIMESTAMP() - " .. config.days .. " * 24 * 60 * 60")
    if resultId == false then
        logs = string.format("%sNão havia casas para limpar.", logs)
    else
        repeat
            local house = House(result.getNumber(resultId, "id"))
            local playerName = result.getString(resultId, "playerName")
            if house ~= nil then
                logs = string.format("%sHouse: %s, Dono: %s\n", logs, house:getName(), playerName)
                house:setOwnerGuid(0)
            end

        until not result.next(resultId)
        result.free(resultId)
    end

    if config.log then
        doWriteLogFile(config.file, logs)
    end
   return true
end

cleanhouses:register()