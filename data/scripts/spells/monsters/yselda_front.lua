local spell = Spell("instant")

local area = {
{1},
{0},
{1},
{0},
{1},
{0},
{1},
{0},
{3}
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setArea(createCombatArea(area))

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("yselda_front")
spell:words("###503")
spell:isAggressive(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()