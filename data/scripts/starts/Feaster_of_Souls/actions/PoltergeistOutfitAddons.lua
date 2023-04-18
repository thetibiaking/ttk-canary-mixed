local PoltergeistOutfitAddons = Action()

function PoltergeistOutfitAddons.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lookType = (player:getSex() == 0) and 1271 or 1270
	if not player:hasOutfit(lookType) then
		player:say("You not have Hand of the Inquisition Outfit", TALKTYPE_MONSTER_SAY)
		return true
	end
	
	if item:getId() == 37465 then
		if player:hasOutfit(lookType, 1) then
			player:say("Do you already have the addon 1", TALKTYPE_MONSTER_SAY)
			return true
		end
		player:addOutfitAddon(lookType, 1)
		player:say("The spooky hood is yours!", TALKTYPE_MONSTER_SAY)
		item:remove()
		return true
	end
	
	if item:getId() == 37466 then
		if not player:hasOutfit(lookType, 1) then
			player:say("You need the first addon", TALKTYPE_MONSTER_SAY)
			return true
		end
		if player:hasOutfit(lookType, 2) then
			player:say("Do you already have the addon 2", TALKTYPE_MONSTER_SAY)
			return true
		end
		player:addOutfitAddon(lookType, 2)
		player:say("You can use the ghost claw now!", TALKTYPE_MONSTER_SAY)
		item:remove()
		return true
	end
	
	return true
end

PoltergeistOutfitAddons:id(37465, 37466)
PoltergeistOutfitAddons:register()