local spectralhorseshoe = Action()
function spectralhorseshoe.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if(player:getStorageValue(Storage.Boos.phantasmal_mont) == 1) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Voce ja tem a Montaria.')		
		return
	end	
	
		player:addMount(1447)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You got Horse Power.')
		player:setStorageValue(Storage.Boos.phantasmal_mont, 1)
		item:remove()
	
	return trued
end

spectralhorseshoe:id(38907)
spectralhorseshoe:register()