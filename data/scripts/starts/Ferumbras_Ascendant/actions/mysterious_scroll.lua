local ferumbrasAscendantMysterious = Action()
function ferumbrasAscendantMysterious.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if(player:getStorageValue(Storage.FerumbrasAscension.RiftRunner) ==1) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Voce ja tem a Montaria')		
		return
	end	
	
		player:addMount(87)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You decipher something! You get a rift runner to accompany you on your journey.')
		player:setStorageValue(Storage.FerumbrasAscension.RiftRunner, 1)
		item:remove()
	
	return trued
end

ferumbrasAscendantMysterious:id(34784)
ferumbrasAscendantMysterious:register()