local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))

local waveBurst = Combat()
waveBurst:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
waveBurst:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
waveBurst:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
waveBurst:setArea(createCombatArea(AREA_SQUAREWAVE7, AREADIAGONAL_WAVE7))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4.5)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local grade = creature:upgradeSpellsWORD("Twin Burst")

    local cooldown = 0
    if (grade >= 3) then
        cooldown = 24
	return waveBurst:execute(creature, var)
    elseif (grade >= 2) then
        cooldown = 28
	return waveBurst:execute(creature, var)

    elseif (grade >= 1) then
        cooldown = 32
	return waveBurst:execute(creature, var)

    end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(13)
spell:name("Energy Wave")
spell:words("exevo vis hur")
spell:level(38)
spell:mana(170)
spell:needDirection(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()