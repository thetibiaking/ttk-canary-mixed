local yseldaOnHealthChange = CreatureEvent("yseldaOnHealthChange")

function yseldaOnHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if Game.getStorageValue(Storage.MegasylvanYselda.imortal) > 0 then
		return false
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

yseldaOnHealthChange:register()