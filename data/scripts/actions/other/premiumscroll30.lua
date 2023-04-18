local vipdobrya = true -- The choice is your if you want the script work then you leave it true

local vipbrya = {
    prem_days = 30, -- Edit how many days
}



local vip30 = Action()

function vip30.onUse(cid, item, fromPosition, itemEx, toPosition)
local player = Player(cid)
local days = player:getPremiumDays()

    if days > 0 then
	
        cid:sendTextMessage(19, "Sorry, Wait For Your Premium To Finish, To Use Again.")
    	
	else 
	
        Player(cid):addItem(2160, 200)
		player:getPosition():sendMagicEffect(31)
		cid:addPremiumDays(vipbrya.prem_days)
        cid:sendTextMessage(19, "Gratz you have obtained +30 premium days.")
        item:remove()
    
	end
end

vip30:id(16101)
vip30:register()