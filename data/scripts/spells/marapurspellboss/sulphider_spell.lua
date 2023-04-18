local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setArea(createCombatArea({
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 3, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0}}))

local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
combat1:setArea(createCombatArea({
{0, 0, 0, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{1, 1, 0, 0, 2, 0, 0, 1, 1},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 0, 0, 0}}))


local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    addEvent(runSpell, 2000, creature:getId(), combat, var)
    addEvent(runSpell, 3000, creature:getId(), combat1, var)
	return true
end

function runSpell(cid, combat, var)
    local creature = Creature(cid)
    if creature then
        combat:execute(creature, var)
    end
end

spell:name("sulphider_spell")
spell:words("###542")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()