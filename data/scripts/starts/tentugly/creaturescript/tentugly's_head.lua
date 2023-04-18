local tent_healthChange = CreatureEvent("tentugly_on_health_change")

function tent_healthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if Game.getStorageValue(Storage.TentuglysHead.TeleportedTentugly) > 0 then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	
	if creature:getHealth() < 7000 then
		creature:teleportTo(Position(33668, 31178, 7))
		addEvent(SpawnTentacles, 2 * 10 * 100)
		Game.setStorageValue(Storage.TentuglysHead.TeleportedTentugly, 1)
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

tent_healthChange:register()

function SpawnTentacles()
	local tentacle1 = Tile(33723, 31191, 7):getItemById(39945)
	local tentacle2 = Tile(33727, 31186, 7):getItemById(39945)
	local tentacle3 = Tile(33736, 31180, 7):getItemById(39955)
	local tentacle4 = Tile(33726, 31180, 7):getItemById(39955)
	local tentacle5 = Tile(33718, 31176, 7):getItemById(39942)
	local tentacle6 = Tile(33726, 31176, 6):getItemById(39942)
	local tentacle7 = Tile(33718, 31191, 6):getItemById(39945)
	local tentacle8 = Tile(33710, 31185, 6):getItemById(39957)
	local tentacle9 = Tile(33716, 31183, 6):getItemById(39945)
	local tentacle10 = Tile(33714, 31176, 6):getItemById(39942)

	if tentacle1 then
		tentacle1:remove()

		Game.createItem(39944, 1, Position(33723, 31191, 7))
		Game.createItem(39947, 1, Position(33723, 31190, 7))
		Game.createItem(39947, 1, Position(33723, 31189, 7))
		Game.createItem(39947, 1, Position(33723, 31188, 7))
		Game.createItem(39947, 1, Position(33723, 31187, 7))
		Game.createItem(39947, 1, Position(33723, 31186, 7))
		Game.createMonster("Tentacle", Position(33723, 31185, 7), true, true)
	end

	if tentacle2 then
		tentacle2:remove()

		Game.createItem(39944, 1, Position(33727, 31186, 7))
		Game.createItem(39947, 1, Position(33727, 31185, 7))
		Game.createItem(39947, 1, Position(33727, 31184, 7))
		Game.createMonster("Tentacle", Position(33727, 31183, 7), true, true)
	end

	if tentacle3 then
		tentacle3:remove()

		Game.createItem(39954, 1, Position(33736, 31180, 7))
		Game.createItem(39961, 1, Position(33735, 31180, 7))
		Game.createItem(39961, 1, Position(33734, 31180, 7))
		Game.createItem(39961, 1, Position(33733, 31180, 7))
		Game.createItem(39961, 1, Position(33732, 31180, 7))
		Game.createItem(39961, 1, Position(33731, 31180, 7))
		Game.createMonster("Tentacle East", Position(33730, 31180, 7), true, true)
	end

	if tentacle4 then
		tentacle4:remove()

		Game.createItem(39954, 1, Position(33726, 31180, 7))
		Game.createItem(39961, 1, Position(33725, 31180, 7))
		Game.createItem(39961, 1, Position(33724, 31180, 7))
		Game.createItem(39961, 1, Position(33723, 31180, 7))
		Game.createMonster("Tentacle East", Position(33722, 31180, 7), true, true)
	end

	if tentacle5 then
		tentacle5:remove()

		Game.createItem(40345, 1, Position(33718, 31177, 7))
		Game.createItem(39947, 1, Position(33718, 31178, 7))
		Game.createItem(39947, 1, Position(33718, 31179, 7))
		Game.createItem(39947, 1, Position(33718, 31180, 7))
		Game.createMonster("Tentacle South", Position(33718, 31181, 7), true, true)
	end

	if tentacle6 then
		tentacle6:remove()

		Game.createItem(40345, 1, Position(33726, 31177, 6))
		Game.createItem(39947, 1, Position(33726, 31178, 6))
		Game.createItem(39947, 1, Position(33726, 31179, 6))
		Game.createItem(39947, 1, Position(33726, 31180, 6))
		Game.createItem(39947, 1, Position(33726, 31181, 6))
		Game.createItem(39947, 1, Position(33726, 31182, 6))
		Game.createMonster("Tentacle South", Position(33726, 31183, 6), true, true)
	end

	if tentacle7 then
		tentacle7:remove()

		Game.createItem(39944, 1, Position(33718, 31191, 6))
		Game.createItem(39947, 1, Position(33718, 31190, 6))
		Game.createItem(39947, 1, Position(33718, 31189, 6))
		Game.createItem(39947, 1, Position(33718, 31188, 6))
		Game.createItem(39947, 1, Position(33718, 31187, 6))
		Game.createMonster("Tentacle", Position(33718, 31186, 6), true, true)
	end

	if tentacle8 then
		tentacle8:remove()

		Game.createItem(40346, 1, Position(33711, 31185, 6))
		Game.createItem(39961, 1, Position(33712, 31185, 6))
		Game.createItem(39961, 1, Position(33713, 31185, 6))
		Game.createMonster("Tentacle West", Position(33714, 31185, 6), true, true)
	end

	if tentacle9 then
		tentacle9:remove()

		Game.createItem(39944, 1, Position(33716, 31183, 6))
		Game.createItem(39947, 1, Position(33716, 31182, 6))
		Game.createItem(39947, 1, Position(33716, 31181, 6))
		Game.createMonster("Tentacle", Position(33716, 31180, 6), true, true)
	end

	if tentacle10 then
		tentacle10:remove()

		Game.createItem(40345, 1, Position(33714, 31177, 6))
		Game.createItem(39947, 1, Position(33714, 31178, 6))
		Game.createItem(39947, 1, Position(33714, 31179, 6))
		Game.createItem(39947, 1, Position(33714, 31180, 6))
		Game.createMonster("Tentacle South", Position(33714, 31181, 6), true, true)
	end
	return true
end