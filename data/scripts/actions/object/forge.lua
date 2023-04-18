local forge = Action()

function forge.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:openExaltedForge()
	return true
end

forge:id(41963, 41957, 41968, 41992)
forge:register()