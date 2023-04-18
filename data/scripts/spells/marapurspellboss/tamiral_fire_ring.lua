local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)

arr = {
	 {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},	
	 {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	 {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	 {0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0},
	 {0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
	 {1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1},
	 {0, 1, 1, 0, 0, 2, 0, 0, 1, 1, 0},
	 {0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0},
	 {0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0},
	 {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	 {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	 {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("tamiral_front_ring")
spell:words("###509")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()