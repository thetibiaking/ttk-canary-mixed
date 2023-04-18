local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setArea(createCombatArea({
{0, 0, 0, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 3, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 0, 0, 0}}))

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat4:setArea(createCombatArea({
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 3, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0}}))


local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat2:setArea(createCombatArea({
{0, 1, 1, 1, 0},
{1, 1, 0, 1, 1},
{1, 0, 2, 0, 1},
{1, 1, 0, 1, 1},
{0, 1, 1, 1, 0}}))

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat3:setArea(createCombatArea({
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},	
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
	 {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	 {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	 {0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0},
	 {0, 0, 1, 1, 0, 2, 0, 1, 1, 0, 0},
	 {0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0},
	 {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	 {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}))


local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	addEvent(runSpell, 3000, creature:getId(), combat, var)
    addEvent(runSpell, 1600, creature:getId(), combat2, var)
    addEvent(runSpell, 2100, creature:getId(), combat3, var)
    addEvent(runSpell, 3200, creature:getId(), combat4, var)
	return true
end

function runSpell(cid, combat, var)
    local creature = Creature(cid)
    if creature then
        combat:execute(creature, var)
    end
end

spell:name("gorillera_spell")
spell:words("###527")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()