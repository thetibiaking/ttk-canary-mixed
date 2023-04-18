local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLESMOKE)
combat:setArea(createCombatArea({
{0 , 0, 0, 1, 0, 0, 0},
{0 , 0, 1, 1, 1, 0, 0},
{0 , 1, 1, 0, 1, 1, 0},
{1 , 1, 0, 2, 0, 1, 1},
{0 , 1, 1, 0, 1, 1, 0},
{0 , 0, 1, 1, 1, 0, 0},
{0 , 0, 0, 1, 0, 0, 0}

}))


local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	addEvent(runSpell, 3000, creature:getId(), combat, var)
	return true
end

function runSpell(cid, combat, var)
    local creature = Creature(cid)
    if creature then
        combat:execute(creature, var)
    end
end

spell:name("mercurial_menace_spell")
spell:words("###541")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()