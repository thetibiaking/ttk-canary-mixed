local config = {
	roomCenterPosition = Position(32441, 32521, 7),
	exitPosition = Position(32453, 32503, 7),
	LionDeathStorage = 30116,
	UsurperDeathStorage = 30117,
	drumePosition = Position(32447, 32512, 7),
	kesarPosition = Position(32447, 32515, 7),
}

local function getRandomPosNear(p) -- getRandomPosNear(player:getPosition())
	local candidates = {
		Position(p.x-1,p.y-1,p.z),
		Position(p.x,p.y-1,p.z),
		Position(p.x+1,p.y-1,p.z),
		Position(p.x-1,p.y,p.z),
		Position(p.x+1,p.y,p.z),
		Position(p.x-1,p.y+1,p.z),
		Position(p.x,p.y+1,p.z),
		Position(p.x+1,p.y+1,p.z),
	}
	return candidates[math.random(#candidates)]
end

local groups = {
	{
		centerPos = Position(32442, 32522, 7),
		creatures = {
			"Lion Commander",
			-- "Lion warlock",
			-- "Lion Knight",
			-- "Lion Knight",
			-- "Lion Archer",
			-- "Lion Archer",
		},
	},
	{
		centerPos = Position(32439, 32516, 7),
		creatures = {
			"Usurper Commander",
			-- "Hardened Usurper Archer",
			-- "Hardened Usurper Archer",
			-- "Hardened Usurper Knight",
			-- "Hardened Usurper Knight",
			-- "Hardened Usurper Warlock",
		},
	},
	
	{
		centerPos = Position(32456, 32518, 7),
		creatures = {
			"Lion Commander",
			"Lion Commander",
			-- "Lion warlock",
			-- "Lion Knight",
			-- "Lion Archer",
			-- "Lion Archer",
		},
	},
	{
		centerPos = Position(32457, 32514, 7),
		creatures = {
			"Usurper Commander",
			"Usurper Commander",
			-- "Hardened Usurper Archer",
			-- "Hardened Usurper Knight",
			-- "Hardened Usurper Knight",
			-- "Hardened Usurper Warlock",
		},
	},
	
}

local function clearAllRoom(byKillLion)
	local specs = Game.getSpectators(config.roomCenterPosition, false, false, 23, 23, 20, 20)
	for _, spec in pairs(specs) do
		if spec:isPlayer() then
			spec:teleportTo(config.exitPosition)
			if byKillLion then
				spec:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Lion Commander's died.")
			end
		else
			spec:remove()
		end
	end
end

local function clearRoomBeforeEnter()
	local specs = Game.getSpectators(config.roomCenterPosition, false, false, 23, 23, 20, 20)
	for _, spec in pairs(specs) do
		if not spec:isPlayer() then
			spec:remove()
		end
	end
end

local function DRUME_NEXT_EVENT()
	local drume, kesar = Creature("Drume"), Creature("Kesar")
	if Game.getStorageValue(GlobalStorage.drume_spawned) <= 0 then
		if not drume then
		Game.createMonster("Drume", config.drumePosition)
		end
		if not kesar then
			Game.createMonster("Kesar", config.kesarPosition)
		end
		Game.setStorageValue(GlobalStorage.drume_spawned, 1)
	end
	
	-- local minis = {"preceptor lazare","grand commander soeren","grand chaplain gaunder"}
	-- for i = 1, 3 do
		-- if (math.random(0,100) >= 80) then
			-- addEvent(function()
				-- local drume = Creature("Drume")
				-- if drume then
					-- local near = getRandomPosNear(drume:getPosition())
					-- Game.createMonster(minis[math.random(#minis)], near)
				-- end
			-- end, 5000)
		-- end
	-- end
end

local function factionsCheckEvent()
	if Game.getStorageValue(config.UsurperDeathStorage) >= 3 then
		DRUME_NEXT_EVENT()
	end
	if Game.getStorageValue(config.LionDeathStorage) >= 3 then
		clearAllRoom(true)
	end
end

function DRUME_INIT_MECHANICS()
	clearRoomBeforeEnter()
	Game.setStorageValue(config.UsurperDeathStorage, 0)
	Game.setStorageValue(config.LionDeathStorage, 0)
	Game.setStorageValue(GlobalStorage.drume_spawned, 0)
	for _, data in pairs(groups) do
		for k, name in pairs(data.creatures) do
			local near = getRandomPosNear(data.centerPos)
			local new = Game.createMonster(name, near)
			if new then
				if new:getName() == "Usurper Commander" or new:getName() == "Lion Commander" then
					new:registerEvent("commanderPrepareDeath")
				end
			end
		end
	end
end

local commanderPrepareDeath = CreatureEvent("commanderPrepareDeath")
function commanderPrepareDeath.onPrepareDeath(creature, lastHitKiller, mostDamageKiller)
    if creature:getName() == "Usurper Commander" then
		Game.setStorageValue(config.UsurperDeathStorage, Game.getStorageValue(config.UsurperDeathStorage) + 1)
	elseif creature:getName() == "Lion Commander" then
		Game.setStorageValue(config.LionDeathStorage, Game.getStorageValue(config.LionDeathStorage) + 1)
	end
	factionsCheckEvent()
    return true
end
commanderPrepareDeath:register()