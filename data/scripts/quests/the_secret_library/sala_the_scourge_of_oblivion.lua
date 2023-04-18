-- The Scourge Of Oblivion 

local config = {
	requiredLevel = 250,
	daily = true,
	roomCenterPosition = Position(32726, 32736, 11),
	playerPositions = {
		Position(32676, 32743, 11),
		Position(32676, 32741, 11),
		Position(32676, 32742, 11),		
		Position(32676, 32744, 11),
		Position(32676, 32745, 11),		
		Position(32677, 32741, 11),
		Position(32677, 32742, 11),
		Position(32677, 32743, 11),
		Position(32677, 32744, 11),
		Position(32677, 32745, 11),		
		
	},
	teleportPosition = Position(32718, 32747, 11),
	bossPosition = Position(32726, 32724, 11)
}

local leverboss = Action()

function leverboss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 32585 then		
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
				if config.daily and participant:getStorageValue(Storage.Boos.Oblivion) > os.time() then
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
		Game.createMonster("The Scourge Of Oblivion", config.bossPosition)

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.Oblivion, os.time() + 20*60*60) -- 20 hours
		end
		
		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	end

	item:transform(32585)
	return true
end

leverboss:uid(1484)
leverboss:register()
