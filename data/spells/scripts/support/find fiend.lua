local LEVEL_LOWER = 1
local LEVEL_SAME = 2
local LEVEL_HIGHER = 3

local DISTANCE_BESIDE = 1
local DISTANCE_CLOSE = 2
local DISTANCE_FAR = 3
local DISTANCE_VERYFAR = 4

local HARMLESS = 0
local TRIVIAL = 1
local EASY = 2
local MEDIUM = 3
local HARD = 4
local CHALLENGER =5

local directions = {
	[DIRECTION_NORTH] = "north",
	[DIRECTION_SOUTH] = "south",
	[DIRECTION_EAST] = "east",
	[DIRECTION_WEST] = "west",
	[DIRECTION_NORTHEAST] = "north-east",
	[DIRECTION_NORTHWEST] = "north-west",
	[DIRECTION_SOUTHEAST] = "south-east",
	[DIRECTION_SOUTHWEST] = "south-west"
}

local messages = {
	[DISTANCE_BESIDE] = {
		[LEVEL_LOWER] = "below you",
		[LEVEL_SAME] = "standing next to you",
		[LEVEL_HIGHER] = "above you"
	},
	[DISTANCE_CLOSE] = {
		[LEVEL_LOWER] = "on a lower level to the",
		[LEVEL_SAME] = "to the",
		[LEVEL_HIGHER] = "on a higher level to the"
	},
	[DISTANCE_FAR] = "far to the",
	[DISTANCE_VERYFAR] = "very far to the"
}

local difficulty = {
	[0] = "Harmless",
	[1] = "Trivial",
	[2] = "Easy",
	[3] = "Medium",
	[4] = "Hard",
	[5] = "Challenger"
}

function onCastSpell(creature)
	local targetMonster = nil
	local monsters = Game.getFiendishMonsters()
	
	for _, monster in pairs(monsters) do
		local mob = Creature(monster)
		if not targetMonster then
			targetMonster = mob
		end
		
		if (getDistanceBetween(creature:getPosition(), mob:getPosition()) <= (getDistanceBetween(creature:getPosition(), targetMonster:getPosition()))) then
			targetMonster = mob
		end
	end
	
	local playerposx, playerposy , playerposz = 0
	local positionDifference = {x = 0, y = 0, z = 0}

	local creaturePosition = creature:getPosition()
	local targetPosition = targetMonster:getPosition()
	positionDifference = {x = creaturePosition.x - targetPosition.x,	y = creaturePosition.y - targetPosition.y,	z = creaturePosition.z - targetPosition.z}
	
	local maxPositionDifference, direction = math.max(math.abs(positionDifference.x), math.abs(positionDifference.y))
	if maxPositionDifference >= 5 then
		local positionTangent = positionDifference.x ~= 0 and positionDifference.y / positionDifference.x or 10
		if math.abs(positionTangent) < 0.4142 then
			direction = positionDifference.x > 0 and DIRECTION_WEST or DIRECTION_EAST
			elseif math.abs(positionTangent) < 2.4142 then
			direction = positionTangent > 0 and (positionDifference.y > 0 and DIRECTION_NORTHWEST or DIRECTION_SOUTHEAST) or positionDifference.x > 0 and DIRECTION_SOUTHWEST or DIRECTION_NORTHEAST
			else
			direction = positionDifference.y > 0 and DIRECTION_NORTH or DIRECTION_SOUTH
		end
	end
	
	local level = positionDifference.z > 0 and LEVEL_HIGHER or positionDifference.z < 0 and LEVEL_LOWER or LEVEL_SAME
	local distance = maxPositionDifference < 5 and DISTANCE_BESIDE or maxPositionDifference < 101 and DISTANCE_CLOSE or maxPositionDifference < 275 and DISTANCE_FAR or DISTANCE_VERYFAR
	local message = messages[distance][level] or messages[distance]
	if distance ~= DISTANCE_BESIDE then
		message = message .. " " .. directions[direction]
	end
	
	local diffString = "Unknown"
	local stars = targetMonster:getType():BestiaryStars()
	if stars then
		diffString = difficulty[stars]
	end

	creature:sendTextMessage(MESSAGE_INFO_DESCR, 'The monster is ' .. message .. '. Be prepared to find a creature of difficulty level "' .. diffString .. '".')
	creaturePosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end
