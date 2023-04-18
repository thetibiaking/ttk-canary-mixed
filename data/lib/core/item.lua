function Item.getWorth(self)
	local coin_worth = {
		[2148] = 1,
		[2152] = 100,
		[2160] = 10000,
	}
	local worth = coin_worth[self:getId()]
	if worth then
		return worth
	end
	return false
end

function Item.getType(self)
	return ItemType(self:getId())
end

function Item.isContainer(self)
	return false
end

function Item.isCreature(self)
	return false
end

function Item.isMonster(self)
	return false
end

function Item.isNpc(self)
	return false
end

function Item.isPlayer(self)
	return false
end

function Item.isTeleport(self)
	return false
end

function Item.isTile(self)
	return false
end

function Item.setDescription(self, description)
	if description ~= '' then
		self:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
	else
		self:removeAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	end
end

function Item.setText(self, text)
	if text ~= '' then
		self:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
	else
		self:removeAttribute(ITEM_ATTRIBUTE_TEXT)
	end
end

function Item.setUniqueId(self, uniqueId)
	if type(uniqueId) ~= 'number' or uniqueId < 0 or uniqueId > 65535 then
		return false
	end

	self:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, uniqueId)
end

function Item.getNameDescription(self)
	local subType = self:getSubType()
	local itemType = self:getType()

	local buffer = {}

	local name = self:getName() or ''
	if(#name ~= 0) then
		if(itemType:isStackable() and subType > 1) then
			pushValues(buffer, ' ', subType, self:getPluralName())
		else
			local article = self:getArticle() or ''
			pushValues(buffer, ' ', select(#article ~= 0 and 1 or 2, article, name))
		end
	else
		pushValues(buffer, ' ', 'an item of type', self:getId())
	end

	return table.concat(buffer)
end

function pushValues(buffer, sep, ...)
	local argv = {...}
	local argc = #argv
	for k, v in ipairs(argv) do
		table.insert(buffer, v)
		if k < argc and sep then
			table.insert(buffer, sep)
		end
	end
end
