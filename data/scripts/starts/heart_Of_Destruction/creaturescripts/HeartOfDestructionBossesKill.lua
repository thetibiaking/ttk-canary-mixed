local HeartOfDestructionBossesKill = CreatureEvent("HeartOfDestructionBossesKill")

local storagesBosses = {
	["Anomaly"] = Storage.HeartOfDestructionBossesKill.Anomaly,
	["Eradicator"] = Storage.HeartOfDestructionBossesKill.Eradicator,
	["Outburst"] = Storage.HeartOfDestructionBossesKill.Outburst,
	["Realityquake"] = Storage.HeartOfDestructionBossesKill.Realityquake,
	["Rupture"] = Storage.HeartOfDestructionBossesKill.Rupture,
}

function HeartOfDestructionBossesKill.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	
	local storage = storagesBosses[creature:getName()]
	if not storage then return true end

	for pid, info in pairs(creature:getDamageMap()) do
		local tempCreature = Creature(pid)
		if tempCreature:isPlayer() then
			tempCreature:setStorageValue(storage, 1)
		end
	end

	return true
end
HeartOfDestructionBossesKill:register()