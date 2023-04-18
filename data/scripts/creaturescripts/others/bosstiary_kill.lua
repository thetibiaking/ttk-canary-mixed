local bosstiaryOnKill = CreatureEvent("bosstiaryOnKill")
function bosstiaryOnKill.onKill(player, creature, lastHit)
	if not player:isPlayer() or not creature:isMonster() or creature:hasBeenSummoned() or creature:isPlayer() then
		return true
	end

	local mType = MonsterType(creature:getName())
	if not mType then
		return true
	end

	for cid, damage in pairs(creature:getDamageMap()) do
		local participant = Player(cid)
		if participant and participant:isPlayer() then
			BosstiarySystem.AddBossKillAmount(participant, mType)
		end
	end

	return true
end
bosstiaryOnKill:register()
