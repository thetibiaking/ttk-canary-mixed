local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(AREA_BEAM8))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 5.5)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

local exhaust = {}
function spell.onCastSpell(creature, var)
    if not(creature) or not(creature:isPlayer()) then
        return false
    end

    local grade = creature:upgradeSpellsWORD("Great Death Beam")
    if (grade == 0) then
        creature:sendCancelMessage("You cannot cast this spell")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local cooldown = 0
    if (grade >= 3) then
        cooldown = 6
    elseif (grade >= 2) then
        cooldown = 8
    elseif (grade >= 1) then
        cooldown = 10
    end

    var.runeName = "Beam Mastery"
    if (combat:execute(creature, var)) then
        local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 260)
        condition:setTicks((cooldown * 1000)/configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN))
        creature:addCondition(condition)
        return true
    end
	return false
end

spell:group("attack")
spell:id(260)
spell:name("Great Death Beam")
spell:words("exevo max mort")
spell:level(1)
spell:mana(140)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(1000) -- Cooldown is calculated on the casting
spell:groupCooldown(2 * 1000)
spell:needLearn(true)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
