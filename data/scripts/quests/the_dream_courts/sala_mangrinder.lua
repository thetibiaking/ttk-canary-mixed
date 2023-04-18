-- Malofur Mangrinder 

local config = {
	requiredLevel = 150,
	daily = true,
	roomCenterPosition = Position(1323, 1075, 7),
	playerPositions = {
		Position(1328, 1004, 7),
		Position(1328, 1005, 7),
		Position(1328, 1006, 7),
		Position(1328, 1007, 7),
		Position(1328, 1008, 7),
	},
	teleportPosition = Position(1330, 1079, 7),
	bossPosition = Position(1319, 1076, 7)
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
				if config.daily and participant:getStorageValue(Storage.Boos.MalofurMangrinder) > os.time() then
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendCancelMessage("Not all players are ready yet from last battle.")
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
		
		for i = 1, #specs do
			spec = specs[i]
			spec:remove()
		end

		-- Spawn boss
		Game.createMonster("Malofur Mangrinder", config.bossPosition)
		Game.createMonster("Whirling Blades", Position(1321, 1068, 7) )
		
		
		Game.createMonster("Whirling Blades", Position(1321, 1072, 7) )
		Game.createMonster("Whirling Blades", Position(1321, 1073, 7) )
		Game.createMonster("Whirling Blades", Position(1321, 1075, 7) )
		Game.createMonster("Whirling Blades", Position(1319, 1071, 7) )
		
		
		Game.createMonster("Whirling Blades", Position(1321, 1079, 7) )
		Game.createMonster("Whirling Blades", Position(1321, 1080, 7) )
		
		Game.createMonster("Whirling Blades", Position(1321, 1082, 7) )
		


		
		Game.createMonster("Whirling Blades", Position(1324, 1070, 7) )		
		Game.createMonster("Whirling Blades", Position(1324, 1075, 7) )
		Game.createMonster("Whirling Blades", Position(1324, 1076, 7) )
		Game.createMonster("Whirling Blades", Position(1324, 1077, 7) )		
		
		Game.createMonster("Whirling Blades", Position(1324, 1080, 7) )
		Game.createMonster("Whirling Blades", Position(1324, 1081, 7) )
		
		
		Game.createMonster("Whirling Blades", Position(1327, 1070, 7) )				
		Game.createMonster("Whirling Blades", Position(1327, 1073, 7) )
		
		
		Game.createMonster("Whirling Blades", Position(1329, 1072, 7) )		
		Game.createMonster("Whirling Blades", Position(1329, 1075, 7) )
		Game.createMonster("Whirling Blades", Position(1329, 1076, 7) )
		
		
		Game.createMonster("Whirling Blades", Position(1317, 1072, 7) )		
		Game.createMonster("Whirling Blades", Position(1317, 1073, 7) )
		Game.createMonster("Whirling Blades", Position(1318, 1080, 7) )
		
		
		


		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.MalofurMangrinder, os.time() + 20*60*60) -- 20 hours
		end
		
		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	end

	item:transform(9825)
	return true
end

leverboss:uid(1461)
leverboss:register()
