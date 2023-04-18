function convertTimeToText(segundos)
    local tempo_em_segundos = segundos
    local days, hours, minutes, seconds = 0, 0, 0, 0

    while tempo_em_segundos ~= 0 do
        if tempo_em_segundos >= 86400 then
            tempo_em_segundos = tempo_em_segundos - 86400
            days = days + 1
        elseif tempo_em_segundos >= 3600 then
            tempo_em_segundos = tempo_em_segundos - 3600
            hours = hours + 1
        elseif tempo_em_segundos >= 60 then
            tempo_em_segundos = tempo_em_segundos - 60
            minutes = minutes + 1
        else
            seconds = tempo_em_segundos
            tempo_em_segundos = 0
        end
    end

    local text = ""
    if days > 0 then
        text = text .. days .. (days == 1 and "[d] " or "[d] ") .. hours .. "[h] " .. minutes .. "[m] " .. seconds .. "[s] "
    elseif hours > 0 then
        text = text .. hours .. "[h] " .. minutes .. "[m] " .. seconds .. "[s]"
    elseif minutes > 0 then
        text = text .. minutes .. "[m] " .. seconds .. "[s]"
    else
        text = text .. seconds .. "[s]"
    end
    return text
end

-- function timeConvert(value, from, to)
	-- if not value or not from or to then return 0 end
	-- if type(from) ~= "string" or type(to) ~= "string" then return 0 end
	-- local unit = {msec = 1, sec = 1000, min = 60000, hour = 3600000, day = 86400000}
	-- if from == "msec" and to == "sec" then return value * 1000 end
	-- if from == "sec" and to == "min" then return value * 60 * 1000 end
-- end