local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)
combat:setArea(createCombatArea({
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 3, 1, 0},
{0, 0, 1, 0, 0}

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

spell:name("noxius_spell")
spell:words("###529")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()