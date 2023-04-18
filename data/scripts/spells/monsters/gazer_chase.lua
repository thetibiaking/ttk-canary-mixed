local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat:setFormula(COMBAT_FORMULA_DAMAGE, -250, 0, -430, 0)

local spell = Spell("instant")

local function getChainCreatures(creature)
	if not Creature(creature) then
		return false
	end
	local toDamage = {}
	local spectators = Game.getSpectators(creature:getPosition(), false, false, 6, 6, 9, 9)
	for _, target in pairs(spectators) do
		if target:getId() ~= creature:getId() and not (target:isMonster()) then
			local creaturePos = creature:getPosition()
			local path = creaturePos:getPathTo(target:getPosition(), 0, 0, true, true, 9)
			if path then
				for i=1, #path do
					creaturePos:getNextPosition(path[i], 1)
					creaturePos:sendMagicEffect(177)
				end
			end
			table.insert(toDamage, target)
		end
	end
	return toDamage
end

function spell.onCastSpell(creature, var)
	local damageRange = 5
	local chainCreatures = getChainCreatures(creature)
	if not chainCreatures then
		return false
	end
	for _, target in pairs(chainCreatures) do
		if Creature(target) and Creature(creature) then
			if (creature:getPosition():getDistance(target:getPosition())) <= damageRange then 
				local tempVar = {}
				tempVar.type = 1
				tempVar.number = target:getId()
				combat:execute(creature, tempVar)
			end
		end
	end
	-- return combat:execute(creature, var)
	return true
end

spell:name("gazer chase")
spell:words("###489")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(false)
spell:register()