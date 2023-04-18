local getLookNpc = TalkAction("/getLookNpc")

local lookStr = [[
<look type="%s" head="%s" body="%s" legs="%s" feet="%s" addons="%s"/>
]]

getLookNpc.onSay = function(player, words, param)
	if not player:getGroup():getAccess() then
		return false
	end
	
	local o = player:getOutfit()
	print(string.format(lookStr, o.lookType, o.lookHead, o.lookBody, o.lookLegs, o.lookFeet, o.lookAddons))
	
	return true
end
getLookNpc:separator(" ")
getLookNpc:register()