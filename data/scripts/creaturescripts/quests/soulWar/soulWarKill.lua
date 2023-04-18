local soulWarBoss = CreatureEvent("SoulWarBoss")
function soulWarBoss.onKill(player, creature, target)
    
	if not creature or creature:isPlayer() then
        return true
    end
	
	local bosses = {
	 ["goshnar's greed"]       = {stg = 1024},
     ["goshnar's cruelty"]     = {stg = 1025},
     ["goshnar's malice"]      = {stg = 1026},
     ["goshnar's spite"]       = {stg = 1027},
     ["goshnar's hatred"]      = {stg = 1028},
     ["goshnar's megalomania"] = {stg = 1029}
	}	
	
    local boss = bosses[creature:getName():lower()]
    if boss then
        for playerid, damage in pairs(creature:getDamageMap()) do
            
            if player then
                if player:getStorageValue(boss.stg) < 1 then
                    player:setStorageValue(boss.stg, 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, creature:getName() .. " foi derrotado!")	
                end
            end
        end        
    end
    return true
end

soulWarBoss:register()
-- login_events.lua



