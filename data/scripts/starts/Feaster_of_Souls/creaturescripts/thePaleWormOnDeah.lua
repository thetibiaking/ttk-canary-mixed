local thePaleWormOnDeah = CreatureEvent("thePaleWormOnDeah")
function thePaleWormOnDeah.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	for pid, info in pairs(creature:getDamageMap()) do
		local tempCreature = Creature(pid)
		if tempCreature and tempCreature:isPlayer() then
			local looktype = false
			if tempCreature:getSex() == 0 then
				looktype = 1271
			else
				looktype = 1270
			end
			if looktype then
				if not tempCreature:hasOutfit(looktype) then
					tempCreature:addOutfit(looktype)
					tempCreature:say("Congratulations! You received Poltergeist Outfit", TALKTYPE_MONSTER_SAY)
				end
			end
		end
	end

	return true
end

thePaleWormOnDeah:register()
