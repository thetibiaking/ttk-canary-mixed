local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setArea(createCombatArea({
{1, 1, 1},
{1, 3, 1},
{1, 1, 1}}))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat2:setArea(createCombatArea({
{0, 1, 1, 1, 0},
{1, 1, 0, 1, 1},
{1, 0, 2, 0, 1},
{1, 1, 0, 1, 1},
{0, 1, 1, 1, 0}}))

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
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
    addEvent(runSpell, 1000, creature:getId(), combat, var)
    addEvent(runSpell, 1600, creature:getId(), combat2, var)
    addEvent(runSpell, 2100, creature:getId(), combat3, var)
	return true
end

function runSpell(cid, combat, var)
    local creature = Creature(cid)
    if creature then
        combat:execute(creature, var)
    end
end

spell:name("esmeral_tortoise_spell")
spell:words("###526")
spell:blockWalls(true)
spell:needDirection(false)
spell:needLearn(true)
spell:register()