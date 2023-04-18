-- lever Drume

local config = {
	requiredLevel = 100,
	daily = true,
	roomCenterPosition = Position(32440, 32522, 7),
	playerPositions = {
		Position(32457, 32508, 6),
		Position(32458, 32508, 6),
		Position(32459, 32508, 6),
		Position(32460, 32508, 6),
		Position(32461, 32508, 6)
	},
	teleportPosition = Position(32437, 32521, 7),
	bossPosition = Position(32447, 32512, 7)
}

local function kickAndClean(toKick)
	local specs = Game.getSpectators(config.roomCenterPosition, false, false, 23, 23, 20, 20)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			if table.contains(toKick, spec:getId()) then
				spec:teleportTo(Position(32453, 32503, 7))
				spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Time's up!.")
			end
		else
			spec:remove()
		end
	end
end

local leverboss = Action()

function leverboss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 36201 then
		-- Check if the player that pulled the lever is on the correct position
		if player:getPosition() ~= config.playerPositions[1] then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can\'t start the battle.")
			return true
		end
		
		local team, participant = {}

		for i = 1, #config.playerPositions do
			participant = Tile(config.playerPositions[i]):getTopCreature()
			
			-- Check there is a participant player
			if participant and participant:isPlayer() then
				-- Check participant level
				if participant:getLevel() < config.requiredLevel then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
						"All the players need to be level ".. config.requiredLevel .." or higher.")
					return true
				end

				-- Check participant boss timer
				if config.daily and participant:getStorageValue(Storage.Boos.drume) > os.time() then
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendCancelMessage("Not all players are ready yet from last battle.")
					return true
				end

				team[#team + 1] = participant
			end
		end

		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.roomCenterPosition, false, false, 19, 19, 19, 19)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the boss room.")
				return true
			end
		end
		
		
		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.roomCenterPosition, false, false, 19, 19, 19, 19)
		for i = 1, #specs do
			spec = specs[i]			
			spec:remove()
		end

		DRUME_INIT_MECHANICS()
		local toKick = {}
		
		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.drume, os.time() + 20*60*60) -- 20 hours
			table.insert(toKick, team[i]:getId())
		end
		
		addEvent(kickAndClean, 600000, team) -- 10 minutes to defeat the boss
		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	end
	
	return true
end

leverboss:uid(59600)
leverboss:register()