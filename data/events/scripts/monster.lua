local function doCheckAndQuickLoot(player, corpse)
	if not player or not corpse then
		return false
	end
	
	local party = player:getParty()
	
	if party then
		local leader = party:getLeader()
		if leader then
			local pPos, lPos = player:getPosition(), leader:getPosition()
			if pPos:getDistance(lPos) <= 60 then
				-- if leader:getStorageValue(Storage.autoLootEnabled) == 1 then
					if leader:quickLoot(corpse) then
						return true
					end
				-- end
			end
		end
	end
	
	
	-- if player:getStorageValue(Storage.autoLootEnabled) == 1 then
		if player:quickLoot(corpse) then
			return true
		end
	-- end
	return false
end

local function directGold(item, player)
	if not item or not player then return 0 end
	local COIN_TYPES = {
		[2148] = 1,
		[2152] = 100,
		[2160] = 10000,
	}
	local convertedToBank = 0
	if COIN_TYPES[item:getId()] then
		convertedToBank = convertedToBank + (item:getCount() * COIN_TYPES[item:getId()])
		item:remove()
	end
	if convertedToBank > 0 then
		player:setBankBalance(player:getBankBalance() + convertedToBank)
	end
	return convertedToBank
end


function Monster:onDropLoot(corpse)
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local mType = self:getType()
	if mType:isRewardBoss() then
		corpse:registerReward()
		return
	end

	local player = Player(corpse:getCorpseOwner())
	local autolooted = ""
	local toBank = 0
	
	if not player or player:getStamina() > 840 then
	
		local monsterLoot = mType:getLoot()
		local preyChanceBoost = 100
		local charmBonus = false
		if player and mType and mType:raceId() > 0 then
			preyChanceBoost = player:getPreyLootPercentage(mType:raceId())
			local charm = player:getCharmMonsterType(CHARM_GUT)
			if charm and charm:raceId() == mType:raceId() then
				charmBonus = true
			end
		end

		if self:isFiendish() then
			local loot = {itemId = 41944, chance = 100000, maxCount = 8, actionId = -1, subType = -1}
			local sliver = corpse:createLootItem(loot, false, 100)
			if not sliver then
				print('[Warning] DropLoot:', 'Could not add sleaver to fiendsh monster.')
			end
		end

		for i = 1, #monsterLoot do
			
			-- Gold direct to bank
			local item = corpse:createLootItem(monsterLoot[i], charmBonus, preyChanceBoost)
			if item > 0 then
				local tmpItem = Item(item)
				if player then
					if player:isVip() then
						toBank = toBank + directGold(tmpItem, player)
					end
				end
			end
			
		end
		if player then
			autolooted = corpse:getAutolootedText() or ""
		end

		if player then
			
			doCheckAndQuickLoot(player, corpse)
			local text = ("Loot of %s: %s"):format(mType:getNameDescription(), corpse:getContentDescription())
			if toBank > 0 then
				autolooted = string.format("%s, %s of money", autolooted, toBank)
			end
			
			local lootMsg = corpse:getContentDescription()
			if autolooted ~= "" and corpse:getContentDescription() == "nothing" then
				lootMsg = autolooted:gsub(",", "", 1) .. " that was autolooted"
			elseif autolooted ~= "" then
				lootMsg = corpse:getContentDescription() .. " (Auto Looted: " .. autolooted:gsub(",", "", 1) .. ")"
			end

			text = string.format("%s%s", text, lootMsg)

			if self:getName():lower() == (Game.getBoostedCreature()):lower() then
				 text = ("Loot of %s: %s (boosted loot)"):format(mType:getNameDescription(), lootMsg)
			else
				 text = ("Loot of %s: %s"):format(mType:getNameDescription(), lootMsg)			
			end

			if player:hasCondition(CONDITION_SPECIALPOTION_EFFECT, POTION_LOOT) then
				 text = ("Loot of %s: %s (potion loot)"):format(mType:getNameDescription(), lootMsg)
			else
				 text = ("Loot of %s: %s"):format(mType:getNameDescription(), lootMsg)			
			end

			if preyChanceBoost ~= 100 then
				text = text .. " (active prey bonus)"
			end
			if charmBonus then
				text = text .. " (active charm bonus)"
			end

			local party = player:getParty()
			if party then
				if autolooted ~= "" then
					text = string.format("%s by %s", text, player:getName())
				end
				party:broadcastPartyLoot(text)
			else
				player:sendTextMessage(MESSAGE_LOOT, text)
			end
			player:updateKillTracker(self, corpse)
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			party:broadcastPartyLoot(text)
		else
			player:sendTextMessage(MESSAGE_LOOT, text)
		end
	end
end

function Monster:onSpawn(position)
	if self:getType():isRewardBoss() then
		self:setReward(true)
	end

	if self:getName():lower() == "cobra scout" or 
		self:getName():lower() == "cobra vizier" or 
		self:getName():lower() == "cobra assassin" then
		if getGlobalStorageValue(GlobalStorage.CobraBastionFlask) >= os.time() then
			self:setHealth(self:getMaxHealth() * 0.75)
		end
	end

	if not self:getType():canSpawn(position) then
		self:remove()
	else
		local spec = Game.getSpectators(position, false, false)
		for _, pid in pairs(spec) do
			local monster = Monster(pid)
			if monster and not monster:getType():canSpawn(position) then
				monster:remove()
			end
		end

		if self:getName():lower() == 'iron servant replica' then
			local chance = math.random(100)
			if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismDiamond) >= 1
			and Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismGolden) >= 1 then
				if chance > 30 then
					local chance2 = math.random(2)
					if chance2 == 1 then
						Game.createMonster('diamond servant replica', self:getPosition(), false, true)
					elseif chance2 == 2 then
						Game.createMonster('golden servant replica', self:getPosition(), false, true)
					end
					self:remove()
				end
				return true
			end
			if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismDiamond) >= 1 then
				if chance > 30 then
					Game.createMonster('diamond servant replica', self:getPosition(), false, true)
					self:remove()
				end
			end
			if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.MechanismGolden) >= 1 then
				if chance > 30 then
					Game.createMonster('golden servant replica', self:getPosition(), false, true)
					self:remove()
				end
			end
			return true
		end
	end
end