local carnivalysAccess = Action()
function carnivalysAccess.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.actionid == 59605 then
		player:teleportTo(Position(32528, 32489, 11))
		player:getPosition():sendMagicEffect(CONST_ME_SMALLPLANTS)
		return true
	end
	
	
	player:teleportTo(Position(32419, 32460, 7))
	player:getPosition():sendMagicEffect(CONST_ME_SMALLPLANTS)
	return true
end

carnivalysAccess:aid(59605,59606)
carnivalysAccess:register()