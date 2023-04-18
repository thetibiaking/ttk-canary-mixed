-- local rewardStorage = 29998

-- local reward = TalkAction("!recebervip")

-- function reward.onSay(player, item, words, param)
    -- if player then
        -- if player:getStorageValue(rewardStorage) >= os.time() then
            -- player:sendCancelMessage("Voce recebeu sua vip, agora e so usar!")
        -- else
            -- player:setStorageValue(rewardStorage, os.time() + 24 * 60 * 60)
            -- player:getPosition():sendMagicEffect(CONST_ME_SMOKE)
			-- local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
			-- VipSystemOldRequireChanges
			-- player:setStorageValue(Storage.VipAccess, 1)
			-- inbox:addItem(16101, 1)
			-- item:remove(1)
         -- end
    -- end
-- end

-- reward:register()