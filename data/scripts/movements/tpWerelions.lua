local config = {
    [60001] = Position(33125, 32251, 10),
    [60000] = Position(33139, 32354, 5),
	[60002] = Position(33090, 32280, 12),
	[60003] = Position(33092, 32315, 11),
	[59133] = Position(34150, 30994, 11),
	[51237] = Position(33446, 31288, 14)
		
}

local tpWerelions  = Action()

function tpWerelions.onUse(player, item, fromPosition, itemEx, toPosition)
    for actionId, destination in pairs(config) do
        if item.actionid == actionId then
            player:teleportTo(destination)
            destination:sendMagicEffect(CONST_ME_POFF)
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            return true
        end
    end
end

tpWerelions:aid(60001, 60000, 60002, 60003,59133,51237)
tpWerelions:register()
