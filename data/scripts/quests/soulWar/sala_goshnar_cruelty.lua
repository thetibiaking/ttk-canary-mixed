-- Goshnar's Cruelty

local config = {				
			
	requiredLevel = 400,
	daily = true,
	roomCenterPosition = Position(33856, 31865, 7),
	playerPositions = {
		Position(33854, 31853, 6),
		Position(33855, 31853, 6),
		Position(33856, 31853, 6),
		Position(33857, 31853, 6),
		Position(33858, 31853, 6)
	},
	teleportPosition = Position(33854, 31873, 7),
	bossPosition = Position(33852, 31860, 7)
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
				if config.daily and participant:getStorageValue(Storage.Boos.goshnarCruelty) > os.time() then
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
		Game.createMonster("Goshnar's Cruelty", config.bossPosition)
		Game.createMonster("Mean Maw", Position(33849, 31866, 7))
		Game.createMonster("Mean Maw", Position(33863, 31867, 7))
		Game.createMonster("Mean Maw", Position(33856, 31870, 7))				
				
		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			-- Assign boss timer
			team[i]:setStorageValue(Storage.Boos.goshnarCruelty, os.time() + 20*60*60) -- 20 hours
		end		

		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)		
	end

	item:transform(9825)
	return true
end


 

leverboss:uid(60104)
leverboss:register()
