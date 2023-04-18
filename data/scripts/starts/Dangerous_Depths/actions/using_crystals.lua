local beastPositions = {
	[1] = Position(33677, 32333, 15),
	[2] = Position(33677, 32337, 15),
	[3] = Position(33685, 32333, 15),
	[4] = Position(33685, 32337, 15),
}

local machinePositions ={
	[1] = {
		[1] = Position(33672, 32331, 15),
		[2] = Position(33673, 32331, 15),
		[3] = Position(33674, 32331, 15),
		[4] = Position(33675, 32331, 15),
	},
	[2] = {
		[1] = Position(33676, 32339, 15),
		[2] = Position(33677, 32339, 15),
		[3] = Position(33678, 32339, 15),
		[4] = Position(33679, 32339, 15),
	},
	[3] = {
		[1] = Position(33680, 32330, 15),
		[2] = Position(33681, 32330, 15),
		[3] = Position(33682, 32330, 15),
		[4] = Position(33683, 32330, 15),
	},
	[4] = {
		[1] = Position(33684, 32339, 15),
		[2] = Position(33685, 32339, 15),
		[3] = Position(33686, 32339, 15),
		[4] = Position(33687, 32339, 15),
	},
	[5] = {
		[1] = Position(33688, 32332, 15),
		[2] = Position(33689, 32332, 15),
		[3] = Position(33690, 32332, 15),
		[4] = Position(33691, 32332, 15),
	},
}

local fieryHearts = {
	[1] = Position(33712, 32299, 15),
	[2] = Position(33715, 32301, 15),
	[3] = Position(33714, 32305, 15),
	[4] = Position(33710, 32305, 15),
	[5] = Position(33709, 32301, 15),
}

local aggressiveLavasIV = {
	[1] = Position(33648, 32295, 15),
	[2] = Position(33648, 32313, 15),
}

local aggressiveLavasVI = {
	[1] = Position(33712, 32296, 15),
	[2] = Position(33712, 32310, 15),
}

local function startWarzoneIV()
	theBaronFromBelow_init()
end

local function startWarzoneV()
	theCountOfTheCore_init()

end

local function startWarzoneVI()
	TheDukeOfTheDepths_init()
end

local dangerousDepthCrystals = Action()
function dangerousDepthCrystals.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end

	if not target:isItem() then
	return false
	end

	if target:isCreature() then
	return false
	end

	local WarzoneVI = Position(33274, 32316, 15)
	local WarzoneIV = Position(33459, 32267, 15)
	local WarzoneV = Position(33323, 32109, 15)
	local geodeId = 30745
	local targetPosition = target:getPosition()

	if targetPosition == WarzoneIV and target:getId() == geodeId then -- Warzone 4 BOSS!!!
		if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneIV) < 30 then
			targetPosition:sendMagicEffect(CONST_ME_HITAREA)
			item:remove(1)
			if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneIV) < 0 then
				Game.setStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneIV, 0)
			end
			Game.setStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneIV, Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneIV) + 1)
			if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneIV) == 30 then
				local spectators = Game.getSpectators(targetPosition, false, true, 3, 3, 3, 3)
				for _, spectator in pairs(spectators) do
					if spectator:isPlayer() then
						spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This crystal geode is shaking from a battle nearby.")
					end
				end
				local stalagmites = Tile(Position(33460, 32267, 15)):getItemById(386)
				if stalagmites then
					stalagmites:remove()
					local teleport = Game.createItem(1387, 1, Position(33460, 32267, 15))
					teleport:setActionId(57243)
					addEvent(function()
						if teleport then
							teleport:remove(1)
							Game.createItem(386, 1, Position(33460, 32267, 15))
						end
					end, 8*1000)
					addEvent(clearForgotten, 30*60*1000, Position(33638, 32291, 15), Position(33675, 32313, 15), Position(33462, 32267, 15), GlobalStorage.DangerousDepths.Geodes.WarzoneIV)
					startWarzoneIV()
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The crystal geode can't carry any more crystals.")
		end
	end

	if targetPosition == WarzoneV and target:getId() == geodeId then -- Warzone 5 BOSS!!!
		if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneV) < 30 then
			targetPosition:sendMagicEffect(CONST_ME_HITAREA)
			item:remove(1)
			if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneV) < 0 then
				Game.setStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneV, 0)
			end
			Game.setStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneV, Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneV) + 1)
			if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneV) == 30 then
				local spectators = Game.getSpectators(targetPosition, false, true, 3, 3, 3, 3)
				for _, spectator in pairs(spectators) do
					if spectator:isPlayer() then
						spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This crystal geode is shaking from a battle nearby.")
					end
				end
				local stalagmites = Tile(Position(33324, 32109, 15)):getItemById(386)
				if stalagmites then
					stalagmites:remove()
					local teleport = Game.createItem(1387, 1, Position(33324, 32109, 15))
					teleport:setActionId(57243)
					addEvent(function()
						if teleport then
							teleport:remove(1)
							Game.createItem(386, 1, Position(33324, 32109, 15))
						end
					end, 8*1000)
					addEvent(clearForgotten, 30*60*1000, Position(33668, 32310, 15), Position(33695, 32343, 15), Position(33323, 32111, 15), GlobalStorage.DangerousDepths.Geodes.WarzoneV)
					startWarzoneV()
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The crystal geode can't carry any more crystals.")
		end
	end

	if targetPosition == WarzoneVI and target:getId() == geodeId then -- Warzone 6 BOSS!!!
		if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneVI) < 30 then
			targetPosition:sendMagicEffect(CONST_ME_HITAREA)
			item:remove(1)
			if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneVI) < 0 then
				Game.setStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneVI, 0)
			end
			Game.setStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneVI, Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneVI) + 1)
			if Game.getStorageValue(GlobalStorage.DangerousDepths.Geodes.WarzoneVI) == 30 then
				local spectators = Game.getSpectators(targetPosition, false, true, 3, 3, 3, 3)
				for _, spectator in pairs(spectators) do
					if spectator:isPlayer() then
						spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This crystal geode is shaking from a battle nearby.")
					end
				end
				local stalagmites = Tile(Position(33275, 32316, 15)):getItemById(386)
				if stalagmites then
					stalagmites:remove()
					local teleport = Game.createItem(1387, 1, Position(33275, 32316, 15))
					teleport:setActionId(57243)
					addEvent(function()
						if teleport then
							teleport:remove(1)
							Game.createItem(386, 1, Position(33275, 32316, 15))
						end
					end, 8*1000)
					addEvent(clearForgotten, 30*60*1000, Position(33684, 32293, 15), Position(33724, 32314, 15), Position(33275, 32318, 15), GlobalStorage.DangerousDepths.Geodes.WarzoneVI)
					startWarzoneVI()
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The crystal geode can't carry any more crystals.")
		end
	end

	return true
end

dangerousDepthCrystals:id(31993)
dangerousDepthCrystals:register()
