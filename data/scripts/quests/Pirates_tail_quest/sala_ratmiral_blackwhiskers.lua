-- Ratmiral Blackwhiskers

local config = {				
			
	requiredLevel = 150,
	daily = true,
	roomCenterPosition = Position(33821, 31390, 7),
	playerPositions = {
		Position(33827, 31432, 6),
		Position(33828, 31432, 6),
		Position(33829, 31432, 6),
		Position(33830, 31432, 6),
		Position(33831, 31432, 6),
	},
	teleportPosition = Position(33832, 31384, 7),
	bossPosition = Position(33815, 31392, 7),
	ratoPosition = Position(33829, 31390, 7),
	ratooPosition = Position(33822, 31392, 7),
	ratoooPosition = Position(33825, 31384, 7)	
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
				if config.daily and participant:getStorageValue(Storage.Boos.Ratmiral) > os.time() then
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
		Game.createMonster("Ratmiral Blackwhiskers", config.bossPosition)
		Game.createMonster("Rateye Ric", config.ratoPosition)
		Game.createMonster("Rateye Ric", config.ratoPosition)		
		Game.createMonster("Rateye Ric", config.ratoPosition)	
		Game.createMonster("Rateye Ric", config.ratooPosition)
		Game.createMonster("Rateye Ric", config.ratooPosition)
		Game.createMonster("Rateye Ric", config.ratoooPosition)
		Game.createMonster("Rateye Ric", config.ratoooPosition)
		Game.createMonster("Rateye Ric", config.ratoooPosition)		

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.Ratmiral, os.time() + 20*60*60) -- 20 hours
		end
		
		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
		--rplayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, ('You have %o minutes before you get kicked out.'):format(bossConfig.time))
		
		local monster = Game.createMonster(config.boss, config.bossPosition)        
		
	end

	item:transform(9825)
	return true
end

 

leverboss:uid(60119)
leverboss:register()