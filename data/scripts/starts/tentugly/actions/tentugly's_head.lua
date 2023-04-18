local config = {
    items = {39941, 39942, 39943, 39944, 39945, 39947, 39954, 39961, 40435, 40345},
}

local info = {
    bossName = "Tentugly",
    teleportPosition = Position(33721, 31185, 7),
    bossPosition = Position(33722, 31182, 7), 
    fromPosition_ = Position(33700, 31175, 7), 
    toPosition_ = Position(33742, 31194, 7), 
    exitPosition = Position(33800, 31357, 7),
     timer = Storage.TentuglysHead.Timer,
    room = Storage.TentuglysHead.RoomTimer
}

function clearBoatOne()
    local BoatOne = Position(33722, 31182, 7)
    local spectatorsBoatOne = Game.getSpectators(BoatOne, false, false, 30, 30, 30, 30)
    for i = 1, #spectatorsBoatOne do
        local spectatorBoatOne = spectatorsBoatOne[i]
        if spectatorBoatOne:isMonster() then
            spectatorBoatOne:remove()
        end
    end
    iterateArea(function(position)
        local tile = Tile(position)
        if not tile then
            return
        end
        local items = tile:getItems()
        if items then
            for i = 1, #items do
                local item = items[i]
                if isInArray(config.items, item:getId()) then
                    item:remove()
                end
            end
        end
    end,
    Position(33700, 31172, 7),
    Position(33739, 31191, 7))
end

function clearBoatTwo()
    local BoatTwo = Position(33722, 31182, 6)
    local spectatorsBoatTwo = Game.getSpectators(BoatTwo, false, false, 30, 30, 30, 30)
    for i = 1, #spectatorsBoatTwo do
        local spectatorBoatTwo = spectatorsBoatTwo[i]
        if spectatorBoatTwo:isMonster() then
            spectatorBoatTwo:remove()
        end
    end

    iterateArea(function(position)
        local tile = Tile(position)
        if not tile then
            return
        end
        local items = tile:getItems()
        if items then
            for i = 1, #items do
                local item = items[i]
                if isInArray(config.items, item:getId()) then
                    item:remove()
                end
            end
        end
    end,
    Position(33700, 31172, 6),
    Position(33739, 31191, 6))
end


function createTentacles()
     -- Tentacles
    local item1 = Tile(33723, 31191, 7):getItemById(39945)
    if not item1 then
        Game.createItem(39945, 1, Position(33723, 31191, 7))
    end

    local item2 = Tile(33727, 31186, 7):getItemById(39945)
    if not item2 then
        Game.createItem(39945, 1, Position(33727, 31186, 7))
    end

    local item3 = Tile(33736, 31180, 7):getItemById(39955)
    if not item3 then
        Game.createItem(39955, 1, Position(33736, 31180, 7))
    end

    local item4 = Tile(33726, 31180, 7):getItemById(39955)

    if not item4 then
        Game.createItem(39955, 1, Position(33726, 31180, 7))
    end
    
    local item5 = Tile(33718, 31176, 7):getItemById(39942)
    if not item5 then
        Game.createItem(39942, 1, Position(33718, 31176, 7))
    end

    local item6 = Tile(33726, 31176, 6):getItemById(39942)
    if not item6 then
        Game.createItem(39942, 1, Position(33726, 31176, 6))
    end
    
    local item7 = Tile(33718, 31191, 6):getItemById(39945)
    if not item7 then
        Game.createItem(39945, 1, Position(33718, 31191, 6))
    end
    
    local item8 = Tile(33710, 31185, 6):getItemById(39957)
    if not item8 then
        Game.createItem(39957, 1, Position(33710, 31185, 6))
    end

    local item9 = Tile(33716, 31183, 6):getItemById(39945)
    if not item9 then
        Game.createItem(39945, 1, Position(33716, 31183, 6))
    end

    local item10 = Tile(33714, 31176, 6):getItemById(39942)

    if not item10 then
        Game.createItem(39942, 1, Position(33714, 31176, 6))
    end
end

local function doCheckTentuglyRoom(player_id, fromPos, toPos)
	local Player = Player(player_id)
	if Player then
		for x = fromPos.x, toPos.x do
			for y = fromPos.y, toPos.y do
				for z = fromPos.z, toPos.z do
					local sqm = Tile(Position(x, y, z))
					if sqm then
						if sqm:getTopCreature() and sqm:getTopCreature():isPlayer() then
							Player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You must wait. Someone is challenging '..bossName..' now.')
							return false
						end
					end
				end
			end
		end
		-- Room cleaning
		for x = fromPos.x, toPos.x do
			for y = fromPos.y, toPos.y do
				for z = fromPos.z, toPos.z do
					local sqm = Tile(Position(x, y, z))
					if sqm and sqm:getTopCreature() then
						local monster = sqm:getTopCreature()
						if monster then
							monster:remove()
						end
					end
				end
			end
		end
	end
	return true
end

local tentuglyAction = Action()
function tentuglyAction.onUse(player, item, fromPosition, itemEx, toPosition)
	print(1)
    local playersTable = {}
    if item:getId() == 10029 then
        if doCheckTentuglyRoom(player:getId(), info.fromPosition_, info.toPosition_) then
            for i = 33727, 33731, 1 do
                
				local tile = Tile(Position(i, 31226, 6))
				local tmp_creature = tile and tile:getTopCreature() or nil
				Position(i, 31391, 6):sendMagicEffect(10)
				
                if tmp_creature and tmp_creature:isPlayer() then
					
                    if tmp_creature:getStorageValue(info.timer) > os.time() then -- exaust
                        tmp_creature:getPosition():sendMagicEffect(CONST_ME_POFF)
                        tmp_creature:sendCancelMessage('You are still exhausted from your last battle.')
                        return true
                   end

                   tmp_creature:teleportTo(info.teleportPosition, true)
                   tmp_creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                   table.insert(playersTable, tmp_creature:getId())
                   tmp_creature:setStorageValue(info.timer, os.time() + 12*60*60)

                   -- Cleaning room
                   if Game.getStorageValue(info.room) == 1 then
                        clearBoatOne()
                        clearBoatTwo()
                        createTentacles()
                        Game.setStorageValue(info.room, 0)
                    end

                   Game.setStorageValue(info.room, 1)
                   Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, 0)---Storage.PiratesTailQuest.TentuglysHead.TentaclesKilled
				  -- 69561
                   Game.setStorageValue(Storage.TentuglysHead.TeleportedTentugly, 0) ---Storage.PiratesTailQuest.TentuglysHead.TeleportedTentugly
               end
           end

           Game.createMonster(info.bossName, info.bossPosition, true, true)
       end
   end
   return true
end

tentuglyAction:uid(62310)
tentuglyAction:register()