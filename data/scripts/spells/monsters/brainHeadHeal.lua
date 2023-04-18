local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local master = creature:getMaster()
	if not master then return false end
	
	local p1, p2 = creature:getPosition(), master:getPosition()
	if p1:getDistance(p2) <= 1 then
		master:addHealth(math.random(200, 1000))
	end
	
	return true
end

spell:name("brainHeadHeal")
spell:words("###501")
spell:isAggressive(true)
spell:needLearn(true)
spell:needDirection(false)
spell:register()