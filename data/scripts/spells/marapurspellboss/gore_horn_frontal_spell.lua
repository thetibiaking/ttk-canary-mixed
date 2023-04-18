local spell = Spell("instant")

local area = {
	{1},
 	{1},
 	{1},
	{1},
	{1},
	{1},
	{3},

}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setArea(createCombatArea(area))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.5)
	local max = (level / 5) + (maglevel * 4)
	return -min, -max
end

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("gorehornfronta")
spell:words("###525")
spell:isAggressive(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()