local mirrorimaget = CreatureEvent("mirrorimaget")

function mirrorimaget.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if attacker:isPlayer() then
		local newForm = nil
		if attacker:isSorcerer() then
			newForm = "Sorcerer's Apparition"
		elseif attacker:isDruid() then
			newForm = "Druid's Apparition"
		elseif attacker:isPaladin() then
			newForm = "Paladin's Apparition"
		elseif attacker:isKnight() then
			newForm = "Knight's Apparition"
		end
		if newForm then
			creature:setType(newForm)
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

mirrorimaget:register()