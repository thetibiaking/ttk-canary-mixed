local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))

local terraBurst = Combat()
terraBurst:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
terraBurst:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
terraBurst:setArea(createCombatArea(AREA_SQUAREWAVE7, AREADIAGONAL_WAVE7))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 3.5)
	local max = (level / 5) + (maglevel * 7)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)

    if not(creature) or not(creature:isPlayer()) then
        return false
    end
    
    local grade = creature:upgradeSpellsWORD("Twin Burst")

    local cooldown = 0
    if (grade >= 3) then
        cooldown = 24
	return terraBurst:execute(creature, var)
    elseif (grade >= 2) then
        cooldown = 28
	return terraBurst:execute(creature, var)

    elseif (grade >= 1) then
        cooldown = 32
	return terraBurst:execute(creature, var)

    end
	return combat:execute(creature, var)


end




spell:group("attack")
spell:id(120)
spell:name("Terra Wave")
spell:words("exevo tera hur")
spell:level(38)
spell:mana(170)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()