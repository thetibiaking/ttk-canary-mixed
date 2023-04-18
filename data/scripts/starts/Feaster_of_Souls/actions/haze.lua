local hazeMount = Action()

function hazeMount.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:hasMount(162) then
		player:say("You already have this mount", TALKTYPE_MONSTER_SAY)
		return true
	end
	item:remove()
	player:addMount(162)
	player:say("You are now versed to ride the haze!", TALKTYPE_MONSTER_SAY)
	return true
end

hazeMount:id(37464)
hazeMount:register()