local setting = {
	["Monday"] = Position(1239, 1002, 7), --Plagueroot
	["Tuesday"] = Position(1325, 1007, 7), --Malofur Mangrinder
	["Wednesday"]  = Position(1412, 1006, 7), --Maxxenius 
	["Thursday"] = Position(1498, 1006, 7), --Alptramun
	["Friday"]  = Position(1583, 1007, 7), --Izcandar the Banished
	["Saturday"] = Position(1325, 1007, 7), --Malofur Mangrinder
	["Sunday"] = Position(1498, 1006, 7) --Alptramun
}

local bossdiario = MoveEvent()

function bossdiario.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = setting[os.date("%A")]
	if teleport then
		player:teleportTo(teleport)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Voce entrou no boss diario!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

bossdiario:type("stepin")
bossdiario:aid(60199)
bossdiario:register()
