local function transformBoss(cid, newForm)
	local boss = Creature(cid)
	if not boss then
		return
	end
	local health = boss:getHealth()
	boss:setType(newForm)
	boss:setHealth(health)
end

local function hungryThink(cid)
	local baron = Creature(cid)
	if not baron then
		baron = Creature("The Baron From Below")
		if not baron then
			return
		end
	end
	local baronHealth = baron:getMaxHealth()
	baron:teleportTo(Position(33648, 32300, 15))
	transformBoss(baron:getId(), "The Hungry Baron From Below")
	local organicMatter = Game.createMonster("organic matter", Position(33647, 32300, 15), true, true)
	local toHealOnEat = baronHealth - (baronHealth * 0.7)
	for i=1, 3 do
		addEvent(function()
			if Creature(baron) then
				baron:say("Gulp!", TALKTYPE_MONSTER_SAY)
			end
		end, 2000 * i)
	end
	
	addEvent(function() 
		if Creature(organicMatter) and Creature(baron) then
			organicMatter:remove()
			local toheal = baron:getHealth() - (baron:getHealth() * 0.85)
			baron:addHealth(toheal)
			transformBoss(baron:getId(), "The Baron From Below")
			baron:registerEvent("TheBaronFromBelowThink")
		end
	end, 10000)
end

local theBaronFromBelowThink = CreatureEvent("TheBaronFromBelowThink")
function theBaronFromBelowThink.onThink(creature)
	if not creature:isMonster() then
		return true
	end

	if creature:getName():lower() == "the baron from below" then
		addEvent(hungryThink, 30*1000, creature:getId())
		creature:unregisterEvent("TheBaronFromBelowThink")
	end
	return true
end

theBaronFromBelowThink:register()

local theBaronFromBelowKill = CreatureEvent("TheBaronFromBelowKill")
function theBaronFromBelowKill.onKill(player, creature)
	if not player:isPlayer() then
		return true
	end

	if not creature:isMonster() then
		return true
	end

	if creature:getName():lower() == "organic matter" then
		for i = 1, 4 do
			Game.createMonster("aggressive matter", creature:getPosition(), true, false)
		end
	end
end

theBaronFromBelowKill:register()
