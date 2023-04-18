local ferumbrasEnterPortal = MoveEvent()

function ferumbrasEnterPortal.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	local toPosition = Position(33270, 31474, 14)
	local backPosition = Position(33324, 31374, 14)
	
	if creature:getStorageValue(Storage.FerumbrasAscension.FerumbrasTimer) > os.time() then
		creature:teleportTo(backPosition)
		creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		creature:say('You have to wait to challenge this enemy again!', TALKTYPE_MONSTER_SAY)
		return true
	end
	
	creature:teleportTo(toPosition)
	return true
end

ferumbrasEnterPortal:type("stepin")

ferumbrasEnterPortal:aid(24846)

ferumbrasEnterPortal:register()