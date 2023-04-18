-- Goshnar's Hatred

local config = {				
			
	requiredLevel = 400,
	daily = true,
	roomCenterPosition = Position(34126, 30993, 11),
	playerPositions = {
		Position(34147, 30996, 11),
		Position(34148, 30996, 11),
		Position(34149, 30996, 11),
		Position(34150, 30996, 11),
		Position(34151, 30996, 11),
	},
	teleportPosition = Position(34124, 30999, 11),
	bossPosition = Position(34126, 30988, 11)
}

local leverboss = Action()

function leverboss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then		
		-- Check if the player that pulled the lever is on the correct position
		if player:getPosition() ~= config.playerPositions[1] then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You can\'t start the battle.")
			return true
		end
		
		local team, participant = {}

		for i = 1, #config.playerPositions do
			participant = Tile(config.playerPositions[i]):getTopCreature()
			
			-- Check there is a participant player
			if participant and participant:isPlayer() then
				-- Check participant level
				if participant:getLevel() < config.requiredLevel then
					player:sendTextMessage(MESSAGE_STATUS_SMALL,
						"All the players need to be level ".. config.requiredLevel .." or higher.")
					return true
				end

				-- Check participant boss timer
				if config.daily and participant:getStorageValue(Storage.Boos.goshnarShatred) > os.time() then
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendCancelMessage("Não deu o tempo para o boss.")
					return true
				end

				team[#team + 1] = participant
			end
		end

		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.roomCenterPosition, false, false, 14, 14, 13, 13)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the boss room.")
				return true
			end			
		end
		
		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.roomCenterPosition, false, false, 14, 14, 13, 13)
		for i = 1, #specs do
			spec = specs[i]			
			spec:remove()
		end

		-- Spawn boss
		Game.createMonster("Goshnar's Hatred", config.bossPosition)
		Game.createMonster("Hateful Soul", Position(34121, 30996, 11))
		Game.createMonster("Hateful Soul", Position(34126, 30996, 11))
		Game.createMonster("Hateful Soul", Position(34132, 30996, 11))				
		
				
		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.goshnarShatred, os.time() + 20*60*60) -- 20 hours
		end		

		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)		
	end

	item:transform(9825)
	return true
end
 
leverboss:uid(60108)
leverboss:register()