local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setArea(createCombatArea(AREA_RING1_BURST3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 7)
	local max = (level / 5) + (maglevel * 10.5)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    if not(creature) or not(creature:isPlayer()) then
        return false
    end

    local grade = creature:upgradeSpellsWORD("Twin Burst")
    if (grade == 0) then
        creature:sendCancelMessage("You cannot cast this spell")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local cooldown = 0
    if (grade >= 3) then
        cooldown = 24
    elseif (grade >= 2) then
        cooldown = 28
    elseif (grade >= 1) then
        cooldown = 32
    end

    var.instantName = "Twin Burst"
    
    if creature:getStorageValue(32217) >= os.time() then
        creature:sendCancelMessage("You must wait before casting this spell again.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    var.instantName = "Twin Burst"
    combat:execute(creature, var)
    if (combat:execute(creature, var)) then
        -- Ice cooldown
        creature:setStorageValue(32217, os.time() + (cooldown))
        -- Earth cooldown
        creature:setStorageValue(32212, os.time() + (cooldown))
        return true
    end
    return true
end


spell:group("attack")
spell:id(262)
spell:name("Terra Burst")
spell:words("exevo ulus tera")
spell:level(1)
spell:mana(170)
spell:cooldown(1000 * 24) -- Cooldown is calculated on the casting
spell:groupCooldown(2 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()