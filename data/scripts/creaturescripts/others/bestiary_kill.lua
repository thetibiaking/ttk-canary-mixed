local bestiaryOnKill = CreatureEvent("BestiaryOnKill")
function bestiaryOnKill.onKill(player, creature, lastHit)
	if not player:isPlayer() or not creature:isMonster() or creature:hasBeenSummoned() or creature:isPlayer() then
		return true
	end

	-- for cid, damage in pairs(creature:getDamageMap()) do
		-- local participant = Player(cid)
		-- if participant and participant:isPlayer() then
			-- participant:addBestiaryKill(creature:getName())
			-- participant:addBestiaryKill(creature:getName())
			-- if participant:isVip() then
				-- participant:addBestiaryKill(creature:getName())
			-- end
		-- end
	-- end
	
	for cid, damage in pairs(creature:getDamageMap()) do
		local attacker = Player(cid)
		if attacker then
			local amountToAdd = 2
			if attacker:hasBestiaryBettermentBonus() then
				amountToAdd = amountToAdd * 2
			end
			if attacker:isVip() then
				amountToAdd = amountToAdd + 1
			end
			attacker:addBestiaryKill(creature:getName(), amountToAdd)
		end
	end

	return true
end
bestiaryOnKill:register()
