local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat:setArea(createCombatArea({
{0, 0, 0, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 3, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 0, 0, 0}}))



local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYPOISON)
combat2:setArea(createCombatArea({
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},	
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
	 {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
	 {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
	 {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
	 {0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 0},
	 {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
	 {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
	 {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}))


local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	addEvent(runSpell, 3000, creature:getId(), combat, var)
    addEvent(runSpell, 1600, creature:getId(), combat2, var)
	return true
end

function runSpell(cid, combat, var)
    local creature = Creature(cid)
    if creature then
        combat:execute(creature, var)
    end
end

spell:name("headpecker_spell")
spell:words("###528")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()