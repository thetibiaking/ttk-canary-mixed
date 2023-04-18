local tentuglyTentacleDeath = CreatureEvent("tentuglyTentacleDeath")

function tentuglyTentacleDeath.onDeath(creature, target)

	if not creature or not creature:isMonster() then
		return true
	end

	if Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) == 42 then
		local boss = Tile(Position(33668, 31178, 7)):getTopCreature()
		if boss then
			boss:teleportTo(Position(33722, 31182, 7))
			boss:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, 0)
		end
	end
    
	local monsterName = creature:getName():lower()
	local pos = creature:getPosition()
    
    local tentacle1 = Tile(33723, 31186, 7):getItemById(39947)
    local tentacle2 = Tile(33723, 31187, 7):getItemById(39947)
    local tentacle3 = Tile(33723, 31188, 7):getItemById(39947)
    local tentacle4 = Tile(33723, 31189, 7):getItemById(39947)
    -- Tentacle One
	if pos == Position(33723, 31185, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle1 then
			tentacle1:remove()
			Game.createMonster("Tentacle", Position(33723, 31186, 7), true, true)
		end
	elseif pos == Position(33723, 31186, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle2 then
			tentacle2:remove()
			Game.createMonster("Tentacle", Position(33723, 31187, 7), true, true)
		end
	elseif pos == Position(33723, 31187, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle3 then
			tentacle3:remove()
			Game.createMonster("Tentacle", Position(33723, 31188, 7), true, true)
		end
	elseif pos == Position(33723, 31188, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle4 then
			tentacle4:remove()
			Game.createMonster("Tentacle", Position(33723, 31189, 7), true, true)
		end
	elseif pos == Position(33723, 31189, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item1 = Tile(33723, 31190, 7):getItemById(39947)
		local item2 = Tile(33723, 31191, 7):getItemById(39944)

		if item1 then
			item1:remove()
		end

		if item2 then
			item2:remove()
		end

		Game.createItem(39948, 1, Position(33723, 31191, 7))
		Game.createItem(39945, 1, Position(33723, 31191, 7))
	end
    
    -- Tentacle Two
    local tentacle5 = Tile(33727, 31184, 7):getItemById(39947)
    local tentacle6 = Tile(33727, 31185, 7):getItemById(39947)
	if pos == Position(33727, 31183, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle5 then
			tentacle5:remove()
			Game.createMonster("Tentacle", Position(33727, 31184, 7), true, true)
		end
	elseif pos == Position(33727, 31184, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle6 then
			tentacle6:remove()
			Game.createMonster("Tentacle", Position(33727, 31185, 7), true, true)
		end
	elseif pos == Position(33727, 31185, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item3 = Tile(33727, 31186, 7):getItemById(39944)

		if item3 then
			item3:remove()
		end

		Game.createItem(39945, 1, Position(33727, 31186, 7))
	end


	-- Tentacle Two
	local tentacle7 = Tile(33731, 31180, 7):getItemById(39961)
	local tentacle8 = Tile(33732, 31180, 7):getItemById(39961)
	local tentacle9 = Tile(33733, 31180, 7):getItemById(39961)
	local tentacle10 = Tile(33734, 31180, 7):getItemById(39961)
	local tentacle11 = Tile(33735, 31180, 7):getItemById(39961)
	if pos == Position(33730, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle7 then
			tentacle7:remove()
			Game.createMonster("Tentacle East", Position(33731, 31180, 7), true, true)
		end
	elseif pos == Position(33731, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle8 then
			tentacle8:remove()
			Game.createMonster("Tentacle East", Position(33732, 31180, 7), true, true)
		end
	elseif pos == Position(33732, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle9 then
			tentacle9:remove()
			Game.createMonster("Tentacle East", Position(33733, 31180, 7), true, true)
		end
	elseif pos == Position(33733, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle10 then
			tentacle10:remove()
			Game.createMonster("Tentacle East", Position(33734, 31180, 7), true, true)
		end
	elseif pos == Position(33734, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle11 then
			tentacle11:remove()
			Game.createMonster("Tentacle East", Position(33735, 31180, 7), true, true)
		end
	elseif pos == Position(33735, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item4 = Tile(33736, 31180, 7):getItemById(39954)

		if item4 then
			item4:remove()
		end

		Game.createItem(39955, 1, Position(33736, 31180, 7))
	end
   
	-- Tentacle Three
	local tentacle12 = Tile(33723, 31180, 7):getItemById(39961)
	local tentacle13 = Tile(33724, 31180, 7):getItemById(39961)
	local tentacle14 = Tile(33725, 31180, 7):getItemById(39961)
	if pos == Position(33722, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle12 then
			tentacle12:remove()
			Game.createMonster("Tentacle East", Position(33723, 31180, 7), true, true)
		end
	elseif pos == Position(33723, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle13 then
			tentacle13:remove()
			Game.createMonster("Tentacle East", Position(33724, 31180, 7), true, true)
		end
	elseif pos == Position(33724, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle14 then
			tentacle14:remove()
			Game.createMonster("Tentacle East", Position(33725, 31180, 7), true, true)
		end
	elseif pos == Position(33725, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item5 = Tile(33726, 31180, 7):getItemById(39954)

		if item5 then
			item5:remove()
		end

		Game.createItem(39955, 1, Position(33726, 31180, 7))
	end

	-- Tentacle Four
	tentacle15 = Tile(33718, 31180, 7):getItemById(39947)
	tentacle16 = Tile(33718, 31179, 7):getItemById(39947)
	tentacle17 = Tile(33718, 31178, 7):getItemById(39947)
	if pos == Position(33718, 31181, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle15 then
			tentacle15:remove()
			Game.createMonster("Tentacle South", Position(33718, 31180, 7), true, true)
		end
	elseif pos == Position(33718, 31180, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle16 then
			tentacle16:remove()
			Game.createMonster("Tentacle South", Position(33718, 31179, 7), true, true)
		end
	elseif pos == Position(33718, 31179, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle17 then
			tentacle17:remove()
			Game.createMonster("Tentacle South", Position(33718, 31178, 7), true, true)
		end
	elseif pos == Position(33718, 31178, 7) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item6 = Tile(33718, 31177, 7):getItemById(40345)

		if item6 then
			item6:remove()
		end

		Game.createItem(39942, 1, Position(33718, 31176, 7))
	end

	-- Tentacle Five
	tentacle18 = Tile(33726, 31182, 6):getItemById(39947)
	tentacle19 = Tile(33726, 31181, 6):getItemById(39947)
	tentacle20 = Tile(33726, 31180, 6):getItemById(39947)
	tentacle21 = Tile(33726, 31179, 6):getItemById(39947)
	tentacle22 = Tile(33726, 31178, 6):getItemById(39947)

	if pos == Position(33726, 31183, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle18 then
			tentacle18:remove()
			Game.createMonster("Tentacle South", Position(33726, 31182, 6), true, true)
		end
	elseif pos == Position(33726, 31182, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle19 then
			tentacle19:remove()
			Game.createMonster("Tentacle South", Position(33726, 31181, 6), true, true)
		end
	elseif pos == Position(33726, 31181, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle20 then
			tentacle20:remove()
			Game.createMonster("Tentacle South", Position(33726, 31180, 6), true, true)
		end
	elseif pos == Position(33726, 31180, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle21 then
			tentacle21:remove()
			Game.createMonster("Tentacle South", Position(33726, 31179, 6), true, true)
		end
	elseif pos == Position(33726, 31179, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle22 then
			tentacle22:remove()
			Game.createMonster("Tentacle South", Position(33726, 31178, 6), true, true)
		end
	elseif pos == Position(33726, 31178, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item7 = Tile(33726, 31177, 6):getItemById(40345)

		if item7 then
			item7:remove()
		end

		Game.createItem(39942, 1, Position(33726, 31176, 6))
	end


	-- Tentacle Six
	tentacle23 = Tile(33718, 31187, 6):getItemById(39947)
	tentacle24 = Tile(33718, 31188, 6):getItemById(39947)
	tentacle25 = Tile(33718, 31189, 6):getItemById(39947)
	tentacle26 = Tile(33718, 31190, 6):getItemById(39947)
	if pos == Position(33718, 31186, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle23 then
			tentacle23:remove()
			Game.createMonster("Tentacle", Position(33718, 31187, 6), true, true)
		end
	elseif pos == Position(33718, 31187, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle24 then
			tentacle24:remove()
			Game.createMonster("Tentacle", Position(33718, 31188, 6), true, true)
		end
	elseif pos == Position(33718, 31188, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle25 then
			tentacle25:remove()
			Game.createMonster("Tentacle", Position(33718, 31189, 6), true, true)
		end
	elseif pos == Position(33718, 31189, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle26 then
			tentacle26:remove()
			Game.createMonster("Tentacle", Position(33718, 31190, 6), true, true)
		end
	elseif pos == Position(33718, 31190, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item8 = Tile(33718, 31191, 6):getItemById(39944)

		if item8 then
			item8:remove()
		end

		Game.createItem(39945, 1, Position(33718, 31191, 6))
	end

	-- Tentacle Seven
	tentacle27 = Tile(33716, 31181, 6):getItemById(39947)
	tentacle28 = Tile(33716, 31182, 6):getItemById(39947)
	if pos == Position(33716, 31180, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle27 then
			tentacle27:remove()
			Game.createMonster("Tentacle", Position(33716, 31181, 6), true, true)
		end
	elseif pos == Position(33716, 31181, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle28 then
			tentacle28:remove()
			Game.createMonster("Tentacle", Position(33716, 31182, 6), true, true)
		end
	elseif pos == Position(33716, 31182, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item10 = Tile(33716, 31183, 6):getItemById(39944)

		if item10 then
			item10:remove()
		end

		Game.createItem(39945, 1, Position(33716, 31183, 6))
	end

	-- Tentacle Nine
	tentacle29 = Tile(33714, 31180, 6):getItemById(39947)
	tentacle30 = Tile(33714, 31179, 6):getItemById(39947)
	tentacle31 = Tile(33714, 31178, 6):getItemById(39947)
	if pos == Position(33714, 31181, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle29 then
			tentacle29:remove()
			Game.createMonster("Tentacle South", Position(33714, 31180, 6), true, true)
		end
	elseif pos == Position(33714, 31180, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle30 then
			tentacle30:remove()
			Game.createMonster("Tentacle South", Position(33714, 31179, 6), true, true)
		end
	elseif pos == Position(33714, 31179, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle31 then
			tentacle31:remove()
			Game.createMonster("Tentacle South", Position(33714, 31178, 6), true, true)
		end
	elseif pos == Position(33714, 31178, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item11 = Tile(33714, 31177, 6):getItemById(40345)

		if item11 then
			item11:remove()
		end

		Game.createItem(39942, 1, Position(33714, 31176, 6))
	end


	-- Tentacle Ten
	tentacle32 = Tile(33713, 31185, 6):getItemById(39961)
	tentacle33 = Tile(33712, 31185, 6):getItemById(39961)
	tentacle34 = Tile(33714, 31178, 6):getItemById(39947)
	if pos == Position(33714, 31185, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle32 then
			tentacle32:remove()
			Game.createMonster("Tentacle West", Position(33713, 31185, 6), true, true)
		end
	elseif pos == Position(33713, 31185, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		if tentacle33 then
			tentacle33:remove()
			Game.createMonster("Tentacle West", Position(33712, 31185, 6), true, true)
		end
	elseif pos == Position(33712, 31185, 6) then
		Game.setStorageValue(Storage.TentuglysHead.TentaclesKilled, Game.getStorageValue(Storage.TentuglysHead.TentaclesKilled) +1)
		local item12 = Tile(33711, 31185, 6):getItemById(40346)

		if item12 then
			item12:remove()
		end

		Game.createItem(39957, 1, Position(33710, 31185, 6))
	end
	return true
end

tentuglyTentacleDeath:register()