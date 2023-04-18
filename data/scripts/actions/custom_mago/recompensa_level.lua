local recompensaLevel = CreatureEvent("recompensaLevel")

local table = 
{
	-- ﻿[level] = type = "item", id = {ITEM_ID, QUANTIDADE}, msg = "MENSAGEM"},
	-- [level] = type = "bank", id = {QUANTIDADE, 0}, msg = "MENSAGEM"},
	-- [level] = type = "addon", id = {ID_ADDON_FEMALE, ID_ADDON_MALE}, msg = "MENSAGEM"},
	-- [level] = type = "mount", id = {ID_MOUNT, 0}, msg = "MENSAGEM"},

	[20] = {type = "item", id = {2160, 5}, msg = "Voce ganhou 5 crystal coins por alcancar o level 20!"},
	[100] = {type = "item", id = {2160, 10}, msg = "Voce ganhou 10 crystal coins por alcancar o level 100!"},
	[150] = {type = "item", id = {2160, 15}, msg = "Voce ganhou 15 crystal coins por alcancar o level 150!"}	
}

local storage = 1500

function recompensaLevel.onAdvance(player, skill, oldLevel, newLevel)

	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return tr﻿﻿ue
	end

	for level, _ in pairs(table) do
		if newLevel >= level and player:getStorageValue(storage) < level then
			if table[level].type == "item" then	
				player:addItem(table[level].id[1], table[level].id[2])
			elseif table[level].type == "bank" then
				player:setBankBalance(player:getBankBalance() + table[level].id[1])
			elseif table[level].type == "addon" then
				player:addOutfitAddon(table[level].id[1], 3)
				player:addOutfitAddon(table[level].id[2], 3)
			elseif table[level].type == "mount" then
				player:addMount(table[level].id[1])
			else
				return false
			end
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, table[level].msg)
			player:setStorageValue(storage, level)
		end
	end
	player:save()
	return true
end

recompensaLevel:register()