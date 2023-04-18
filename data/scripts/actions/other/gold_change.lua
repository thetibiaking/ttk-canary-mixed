local config = {
    [2148] = {changeTo = 2152},
    [2152]  = {changeBack = 2148, changeTo = 2160},
    [2160] = {changeBack = 2152}
}

local goldChange = Action()

function goldChange.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    local coin = config[item.itemid]
	
    if not coin then
        return false
    end

    if coin.changeTo and item.type == 100 then
        item:remove()
        player:addItem(coin.changeTo, 1)
    elseif coin.changeBack then
        item:transform(item.itemid, item.type - 1)
        player:addItem(coin.changeBack, 100)
    else
        return false
    end
    return true
end

goldChange:id(2148, 2152, 2160)
goldChange:register()