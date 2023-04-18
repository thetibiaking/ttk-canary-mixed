local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local minDistance = 2
	local malice = Creature("Goshnar's Malice")
	if not malice then
		return true
	end
	local malicePos = malice:getPosition()
	local cagePos = creature:getPosition()
	if cagePos:getDistance(malicePos) < minDistance then
		malice:addHealth(15000)
	end
	
	local summons = malice:getSummons()
	if summons and #summons > 0 then
		for _, summon in pairs(summons) do
			local summonPos = summon:getPosition()
			if cagePos:getDistance(summonPos) < minDistance then
				summon:addHealth(15000)
			end
		end
	end
	
	return true
end

spell:name("soulCageHealFriend")
spell:words("###502")
spell:isAggressive(true)
spell:needLearn(true)
spell:needDirection(false)
spell:register()