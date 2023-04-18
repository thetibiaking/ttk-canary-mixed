local leidenHeal = CreatureEvent("LeidenHeal")

function leidenHeal.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature:getName():lower() == "leiden" then
		if attacker and attacker:isPlayer() then
			if primaryType == COMBAT_HEALING then
				primaryType = COMBAT_UNDEFINEDDAMAGE
			else
				primaryType = COMBAT_HEALING
			end
			if secondaryType == COMBAT_HEALING then
				secondaryType = COMBAT_UNDEFINEDDAMAGE
			else
				secondaryType = COMBAT_HEALING
			end
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

leidenHeal:register()

local leidenDeath = CreatureEvent("LeidenDead")
function leidenDeath.onDeath(creature, corpse, deathList)
	local pool = Tile(creature:getPosition()):getItemById(2016)
	if pool then
		pool:remove()
	end
	Game.createMonster("Ravennous Hunger", creature:getPosition(), true, true)
end

leidenDeath:register()