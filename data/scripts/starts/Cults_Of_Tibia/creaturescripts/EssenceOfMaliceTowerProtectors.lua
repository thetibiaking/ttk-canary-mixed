local bossList = {"Dorokoll The Mystic", "Eshtaba The Conjurer", "Eliz The Unyielding", "Mezlon The Defiler", "Malkhar Deathbringer"}

local EssenceOfMaliceTowerProtectors = CreatureEvent("EssenceOfMaliceTowerProtectors")
function EssenceOfMaliceTowerProtectors.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	
	local deaths = Game.getStorageValue(GlobalStorage.CultsOfTibia.EssenceOfMaliceMiniDeads)
	deaths = deaths + 1
	Game.setStorageValue(GlobalStorage.CultsOfTibia.EssenceOfMaliceMiniDeads, deaths)
	if deaths >= 5 then
		Game.createMonster("Essence Of Malice", Position(33098, 31920, 15))
		Game.setStorageValue(GlobalStorage.CultsOfTibia.EssenceOfMaliceMiniDeads, 0)
	end
	
	return true
end

EssenceOfMaliceTowerProtectors:register()
