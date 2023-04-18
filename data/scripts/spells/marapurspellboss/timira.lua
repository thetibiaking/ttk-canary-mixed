local spell = Spell("instant")

local area = {
	{0, 0, 1, 0, 0, 0, 0},
 	{0, 0, 1, 0, 0, 0, 0},
 	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0},
	{0, 0, 0, 0, 0, 1, 0},
	{0, 0, 0, 0, 0, 0, 1},
	{0, 0, 0, 0, 0, 0, 2},

}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(area))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.5)
	local max = (level / 5) + (maglevel * 4)
	return -min, -max
end

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("tamiral_front_dead")
spell:words("###504")
spell:isAggressive(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()