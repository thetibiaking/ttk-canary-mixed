local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_ENERGYFIELD_PVP)
combat:setArea(createCombatArea(AREA_WALLFIELD_ENERGY, AREADIAGONAL_WALLFIELD_ENERGY))

local config = {
	area = { -- Scarlet
		from = Position(33386, 32639, 6),
		to = Position(33405, 32659, 6)
	},
}

function onCastSpell(creature, var, isHotkey)
	local player = creature:getPlayer()

	if player and isInRange(player:getPosition(), config.area.from, config.area.to) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you cannot use rune fields here.')
		return false
	end

	return combat:execute(creature, var)
end
