local deedOfOwnership = Action()
function deedOfOwnership.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if(player:getStorageValue(Storage.FerumbrasAscension.Blazebringer) ==1) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Voce ja tem a Montaria.')		
		return
	end	
	
		player:addMount(9)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You decipher something! You get a rift runner to accompany you on your journey.')
		player:setStorageValue(Storage.FerumbrasAscension.Blazebringer, 1)
		item:remove()
	
	return trued
end

deedOfOwnership:id(8694)
deedOfOwnership:register()