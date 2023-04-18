local vipChecker = GlobalEvent("vipChecker")
function vipChecker.onThink(interval, lastExecution, thinkInterval)
	for _, player in ipairs(Game.getPlayers()) do
		checkVipPrivillegesEvent(player:getId())
	end
	return true
end

vipChecker:interval(1 * 60 * 60 * 1000) -- 1 hora
-- vipChecker:interval(5000)
vipChecker:register()
