-- Mage Ot

local config = {
	requiredLevel = 150,
	daily = true,	
	roomCenterPosition = Position(1159, 960, 7),
	playerPositions = {		
		Position(1158, 981, 7),
		Position(1157, 981, 7),
		Position(1156, 981, 7),
		Position(1159, 981, 7),
		Position(1160, 981, 7),
		Position(1158, 982, 7),
		Position(1157, 982, 7),
		Position(1156, 982, 7),
		Position(1159, 982, 7),
		Position(1160, 982, 7),
	},
	teleportPosition = Position(1169, 957, 7),
	bossPosition = Position(1150, 959, 7)
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
				if config.daily and participant:getStorageValue(Storage.Boos.mageOt) > os.time() then
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
		Game.createMonster("Mage Ot", config.bossPosition)
		Game.createMonster("vaca", config.bossPosition)
		Game.createMonster("vaca", config.bossPosition)
		

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.mageOt, os.time() + 20*60*60) -- 20 hours
		end
		
		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	end

	item:transform(9825)
	return true
end

leverboss:uid(60120)
leverboss:register()