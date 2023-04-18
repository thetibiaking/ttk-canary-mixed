local config = {
	[1] = {name = "House", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end

			local house = player:getHouse()
			if not house then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have a home.")
				return true
			end

			local houseEntry = house:getExitPosition()
			if not houseEntry then
				return true
			end

			player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have been teleported to the front of your house.')
			player:teleportTo(houseEntry)
		end
	},
	[2] = {name = "Temple", action =
		function(playerId)
			local player = Player(playerId)
			if not player then
				return true
			end

			player:sendModalringvip()
		end
	},
}

local blockedCitys = {"deport_darashia","deport_ab_dendriel","deport_carlin","deport_kazordoon","deport_thais","deport_venore","deport_ankrahmun","deport_edron","deport_farmine","deport_liberty_bay","deport_port_hope","deport_svargrond","deport_yalahar","deport_gray_beach","deport_rathleton","deport_roshamuul","deport_issavi","bounac","unnamed town","island of destiny","rookgaard","dawnport","dawnport tutorial","new rock vip"}
 

function Player:sendModalringvip()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Temples",
		message = "Which of the temples below would you like to be teleported to?",
	}

	for i, town in ipairs(Game.getTowns()) do
		if not table.contains(blockedCitys, town:getName():lower()) then
		
	
		
		 	local name = string.format("%s", town:getName())
		 	local choice = window:addChoice(name)
 
		 choice.templePosition = town:getTemplePosition()
		 	choice.cityName = town:getName()
		end
	end

	window:addButton("Go!",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local newPosition = choice.templePosition
				self:teleportTo(newPosition)
				self:sendTextMessage(MESSAGE_INFO_DESCR, string.format('You were teleported to the Temple of %s', choice.cityName))
			end
		end
	)
	window:setDefaultEnterButton("Go!")

	window:addButton("Return",
		function(button, choice)
			local self = Player(cid)
			if self then
				self:sendMainModalteleportcube()
			end
		end
	)

	window:addButton("Exit")
	window:sendToPlayer(self)
end

function Player:sendMainModalteleportcube()
	local cid = self:getId()
	local window = ModalWindow {
		title = "Teleport",
		message = "Where would you like to be teleported to?",
	}

	for index, choice in ipairs(config) do
		local name = string.format("%s", choice.name)
		local choice = window:addChoice(name)

        choice.index = index
	end

	window:addButton("Choose",
		function(button, choice)
			local self = Player(cid)
			if self and choice then
				local tmpChoice = config[choice.index]
				if tmpChoice then
					tmpChoice.action(cid)
				end
			end
		end
	)
	window:setDefaultEnterButton("Choose")

	window:addButton("Exit")
	window:sendToPlayer(self)
end

local teleportcube = Action()

function teleportcube.onUse(player, item, fromPosition, target, toPosition, isHotkey)

--if player:getStorageValue(Storage.Exaust.tempo) >= os.time() then
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are exausted.')
	--return true
    --end
	
	if player:getStorageValue(9817997) > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot use this item during the event.")
		return true
	end
	
if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) and not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot use this item while this battle.")
		return true
	end
	
---	player:setStorageValue(Storage.Exaust.tempo, os.time())
	player:sendMainModalteleportcube()

    return true
end


teleportcube:id(36468)
teleportcube:register()