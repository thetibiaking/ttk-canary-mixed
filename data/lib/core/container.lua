function Container.isContainer(self)
	return true
end

function Container.getAutolootedText(self)
	if not self then
		return false
	end
	if (self:getItemHoldingCount() <= 0) then
		return false
	end
	local autolooted = ""
	for index = 0, self:getSize() - 1 do
		local tempItem = self:getItem(index)
		if tempItem then
			autolooted = string.format("%s, %s", autolooted, tempItem:getNameDescription())
		end
	end
	return autolooted
end

function Container.createLootItem(self, item, charm, prey)
	if self:getEmptySlots() == 0 then
		return 0
	end

	local itemCount = 0
	local randvalue = getLootRandom()
	local lootBlockType = ItemType(item.itemId)
	local chanceTo = item.chance

	if not lootBlockType then
		return
	end

-- Bestiary charm bonus
	if charm and lootBlockType:getType() == ITEM_TYPE_CREATUREPRODUCT then
		chanceTo = math.ceil((chanceTo * GLOBAL_CHARM_GUT) / 100)
	end

	-- Active prey loot bonus
	if prey ~= 100 then
		chanceTo = math.ceil((chanceTo * prey) / 100)
	end

	if randvalue < chanceTo then
		if lootBlockType:isStackable() then
			if item.maxCount >= 100 then
				item.maxCount = 100
			end
			--print(item.maxCount)
			local maxc, minc = item.maxCount or 1, item.minCount or 1
			itemCount = math.max(0, randvalue % (maxc - minc + 1)) + minc			
		else
			itemCount = 1
		end
	end
	
	local tmpItem = false
	while (itemCount > 0) do
		local n = math.min(itemCount, 100)
		itemCount = itemCount - n
		
		 tmpItem = self:addItem(item.itemId, n)
		if not tmpItem then
			return -1
		end

		if tmpItem:isContainer() then
			for i = 1, #item.childLoot do
				if not tmpItem:createLootItem(item.childLoot[i], charm, prey) then
					tmpItem:remove()
					return -1
				end
			end
		end

		if item.subType ~= -1 then
			tmpItem:transform(item.itemId, item.subType)
		elseif lootBlockType:isFluidContainer() then
			tmpItem:transform(item.itemId, 0)
		end

		if item.actionId ~= -1 then
			tmpItem:setActionId(item.actionId)
		end

		if item.text and item.text ~= "" then
			tmpItem:setText(item.text)
		end
	end
	return tmpItem and tmpItem.uid or 0
end


function Container:getRecursiveContainers()
	local list = { }

	for i = 0, self:getSize() do
		local container = self:getItem(i)

		if container and container:isContainer() then
			if container:getEmptySlots() == 0 then
				for _, _container in ipairs(container:getRecursiveContainers()) do
					table.insert(list, _container)
				end
			else
				table.insert(list, container)
			end
		end
	end
	return list
end

function Container.getItemsById(self, itemId)
    local list = {}
    for index = 0, (self:getSize() - 1) do
        local item = self:getItem(index)
        if item then
            if item:isContainer() then
                local rlist = item:getItemsById(itemId)
                if type(rlist) == 'table' then
                    for _, v in pairs(rlist) do
                        table.insert(list, v)
                    end
                end
            else
                if item:getId() == itemId then
                    table.insert(list, item)
                end
            end
        end
    end
    return list
end