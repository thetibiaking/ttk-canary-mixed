local days = 1 --dias que da de vip

local vip = Action()
function vip.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:addVipDays(days)
		item:remove(1)
	else
		player:sendCancelMessage("You can't use this when you're in a fight and in protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end


vip:id(5785) -- id vip item
vip:register()