local destination = {
	[19801] = Position(33614, 31414, 8), --Entrance
	[19802] = Position(33532, 31444, 8), -- Direita
	[19803] = Position(33549, 31444, 8), -- Esquerda
	[19804] = Position(33483, 31452, 9), -- Descer Andar
	[19805] = Position(33486, 31435, 8), -- Subir Andar
	[19806] = Position(33573, 31467, 9), -- 2 andar  baixo ir direita
	[19807] = Position(33556, 31469, 9), -- 2 andar  baixo ir esquerda
	[19808] = Position(33552, 31438, 9), -- 2 andar  MEIO ir Direita
	[19809] = Position(33538, 31440, 9), -- 2 andar  MEIO ir esquerda
	[19810] = Position(33542, 31412, 9), -- 2 andar  Cima ir Direita
	[19811] = Position(33529, 31410, 9)	 -- 2 andar  Cima ir esquerda	
		
}

local portHopeNetherworld = MoveEvent()

function portHopeNetherworld.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = destination[item.actionid]
	if teleport then
		player:teleportTo(teleport)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		teleport:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

portHopeNetherworld:type("stepin")

for index, value in pairs(destination) do
	portHopeNetherworld:aid(index)
end

portHopeNetherworld:register()
