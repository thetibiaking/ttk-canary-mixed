local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_FIREFIELD_PVP_FULL)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local t = {
	{{x = 33386, y = 32639, z = 6}, {x = 33405, y = 32659, z6= 6}}
}

function onCastSpell(creature, var, isHotkey)
	for i = 1, #t do
		if creature:getPosition():isInRange(unpack(t[i])) then
			creature:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'You cannot use this spell in this area.')
			return false
		end
	end

	return combat:execute(creature, var)
end
