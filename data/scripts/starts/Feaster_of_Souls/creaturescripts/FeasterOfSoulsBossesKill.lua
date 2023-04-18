

local FeasterOfSoulsBossesKill = CreatureEvent("FeasterOfSoulsBossesKill")

local storagesBosses = {
	["The Dread Maiden"] = Storage.FeasterOfSoulsBossesKill.theDreadMaiden,
	["The Fear Feaster"] = Storage.FeasterOfSoulsBossesKill.theFearFeaster,
	-- ["The Pale Worm"] = Storage.FeasterOfSoulsBossesKill.thePaleWorm,
	["The Unwelcome"] = Storage.FeasterOfSoulsBossesKill.theUnwelcome,
	["Brain Head"] = Storage.FeasterOfSoulsBossesKill.brainHead,
	["Thaian"] = Storage.FeasterOfSoulsBossesKill.thaian,
}

function FeasterOfSoulsBossesKill.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	
	
	local storage = storagesBosses[creature:getName()]
	if not storage then return true end

	for pid, info in pairs(creature:getDamageMap()) do
		local tempCreature = Creature(pid)
		if tempCreature then
			if tempCreature:isPlayer() then
				tempCreature:setStorageValue(storage, 1)
			end
		end
	end

	return true
end
FeasterOfSoulsBossesKill:register()