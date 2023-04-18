-- local combat = Combat()
-- combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
-- combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)

-- local area = createCombatArea(AREA_CIRCLE3X3)
-- combat:setArea(area)

-- function spellCallbackTemp(param)
	-- local tile = Tile(Position(param.pos))
	-- if tile then
		-- if tile:getTopCreature() and tile:getTopCreature():isMonster() then
			-- if tile:getTopCreature():getName():lower() == "the duke of the depths" then
				-- tile:getTopCreature():addHealth(math.random(0, 5000))
			-- end
		-- elseif tile:getTopCreature() and tile:getTopCreature():isPlayer() then
			-- tile:getTopCreature():addHealth(- math.random(0, 1500))
		-- end
	-- end
-- end

-- function onTargetTile(cid, pos)
	-- local param = {}
	-- param.cid = cid
	-- param.pos = pos
	-- param.count = 0
	-- spellCallbackTemp(param)
-- end

-- setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

-- local function suicideHeart(creature)
	-- local monster = Creature(creature)
	-- if monster then
		-- local monsterPos = monster:getPosition()
		-- monster:remove()
		-- local fieryBlood = Game.createMonster("fiery blood", monsterPos, true, true)
		-- if fieryBlood then
			-- local var = {type = 1, number = fieryBlood:getId()}
			-- combat:execute(fieryBlood, var)
		-- end
	-- end
-- end

-- local fieryHeartThink = CreatureEvent("theDukeOfTheDepthsThink")
-- function fieryHeartThink.onThink(creature)
	-- if not creature:isMonster() then
		-- return true
	-- end
	-- local contadorHearts = 0
	-- local bossId
	-- if creature:getName():lower() == "the duke of the depths" then
		-- bossId = Creature(creature:getId())
		-- local spectators = Game.getSpectators(creature:getPosition(), false, false, 20, 20, 20, 20)
		-- for _, spectator in pairs(spectators) do
			-- if spectator:getName():lower() == "fiery heart" then
				-- contadorHearts = contadorHearts + 1
			-- end
		-- end
		-- if contadorHearts < 1 then
			-- if bossId then
				-- local oldBossHealth = bossId:getHealth()
				-- local oldBossPosition = bossId:getPosition()
				-- bossId:remove()
				-- local newBoss = Game.createMonster("the duke of the depths", oldBossPosition, true, true)
				-- if newBoss then
					-- newBoss:registerEvent("the duke heal fire damage")
					-- newBoss:addHealth(-(newBoss:getHealth() - oldBossHealth))
				-- end
			-- end
		-- end
	-- end

	-- if creature:getName():lower() == "fiery heart" then
		-- if creature then
			-- addEvent(suicideHeart, 20*1000, creature:getId())
		-- end
	-- end

	-- return true
-- end

local TheDukeOfTheDepths = {
	center = Position(33712, 32303, 15),
	fieryHeartPos = {
		Position(33712, 32299, 15),
		Position(33715, 32301, 15),
		Position(33714, 32305, 15),
		Position(33710, 32305, 15),
		Position(33709, 32301, 15),
	},
}

local function transformBoss(cid, newForm)
	local boss = Creature(cid)
	if not boss then
		return
	end
	local health = boss:getHealth()
	boss:setType(newForm)
	boss:setHealth(health)
end

local function getTileCreatureByName(tile, name)
	if not tile or not name then return false end
	local tileCreatures = tile:getCreatures()
	if tileCreatures then
		for _, creature in pairs(tileCreatures) do
			if creature:getName() == name then
				return creature
			end
		end
	end
	return false
end

local function getFieryHeartCount()
	local count = 0
	for _, pos in pairs(TheDukeOfTheDepths.fieryHeartPos) do
		local tile = Tile(pos)
		if tile then
			local creature = getTileCreatureByName(tile, "Fiery Heart")
			if creature then
				count = count + 1
			end
		end
	end
	return count
end

local fieryHeartThink = CreatureEvent("theDukeOfTheDepthsThink")

function fieryHeartThink.onThink(creature)
	local fieryCount = getFieryHeartCount()
	if creature:getName() == "The Duke Of The Depths" then
		if fieryCount > 0 then
			transformBoss(creature:getId(), "The Fire Empowered Duke")
		end
	elseif creature:getName() == "The Fire Empowered Duke" then
		if fieryCount < 1 then
			transformBoss(creature:getId(), "The Duke Of The Depths")
		end
	end
	return true
end

fieryHeartThink:register()
