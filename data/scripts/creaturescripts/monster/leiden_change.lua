local LeidenChanges = CreatureEvent("LeidenChanges")

function LeidenChanges.onHealthChange(creature, attacker, primaryDamage, primaryType,
															secondaryDamage, secondaryType)
	if creature:getName() == 'Leiden' then
		if creature:getHealth()<=28707 then
			position=creature:getPosition()
			creature:remove()
			Game.createMonster('Ravennous Hunger', position, true, true)			
		end
	end
		
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

LeidenChanges:register()

