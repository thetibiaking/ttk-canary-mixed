local rewards = {
    { id = 43984, name = "Alicorn Headguard" },
    { id = 43985, name = "Alicorn Quiver" },
    { id = 44017, name = "Alicorn Ring" },
    { id = 43988, name = "Arboreal Crown" },
    { id = 44023, name = "Arboreal Ring" },
    { id = 43989, name = "Arboreal Tome" },
    { id = 43987, name = "Arcanomancer Folio" },
    { id = 43986, name = "Arcanomancer Regalia" },
    { id = 44020, name = "Arcanomancer Sigil" },
    { id = 43982, name = "Spiritthorn Armor" },
    { id = 43983, name = "Spiritthorn Helmet" },
    { id = 44014, name = "Spiritthorn Ring" }
}

local bagyouDesire = Action()

function bagyouDesire.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received a ' .. rewardItem.name .. '.')
	return true
end

bagyouDesire:id(44381)
bagyouDesire:register()