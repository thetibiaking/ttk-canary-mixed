local area = createCombatArea({
 	{0, 1, 1, 1, 0},
 	{1, 1, 1, 1, 1},
 	{1, 1, 3, 1, 1},
	{1, 1, 1, 1, 1},
	{0, 1, 1, 1, 0},
 })

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
-- combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)

function onGetFormulaValues(player, skill, attack, factor)
    local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
    local min = 200
    local max = (player:getLevel() / 4) + ((((distanceSkill / 3) + 1) * (attack / 2)) * 0.7)
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combat:setArea(area)

local diamondArrow = Weapon(WEAPON_AMMO)

function diamondArrow.onUseWeapon(player, variant)
	return combat:execute(player, variant)
end

diamondArrow:id(29057)
diamondArrow:id(40736)
diamondArrow:level(150)
diamondArrow:attack(37)
diamondArrow:action("removecount")
diamondArrow:ammoType("arrow")
diamondArrow:shootType(CONST_ANI_DIAMONDARROW)
diamondArrow:maxHitChance(100)
diamondArrow:wieldUnproperly(true)
diamondArrow:register()
