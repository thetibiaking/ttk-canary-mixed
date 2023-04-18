local gold_rank = TalkAction("/top3")

function gold_rank.onSay(player, words, param)

	logCommand(player, words, param)

--local resultId = db.storeQuery("SELECT `lookbody` `lookfeet` `lookhead` `looklegs` `looktype`, `name` FROM `players` WHERE group_id < 3 ORDER BY balance DESC LIMIT 10")
local resultId = db.storeQuery("SELECT `name`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `lookmountbody`, `lookmountfeet`, `lookmounthead`, `lookmountlegs` FROM `players` WHERE group_id < 3 ORDER BY experience DESC LIMIT 3")

	if resultId ~= false then
		local str = ""
		local x = 0
		repeat
			x = x + 1
				str = str.."\n"..x.."- "..result.getDataString(resultId, "name").." ("..result.getDataInt(resultId, "experience")..")."
		until not result.next(resultId)
		if str == "" then
			str = "No highscore to show."
		end
		player:popupFYI("Current gold highscore for this server:\n" .. str)
	else
		player:sendCancelMessage("No highscore to show.")
	end
return false
end
gold_rank:separator(" ")
gold_rank:register()