local exerciseCharges = 1800
local rewardStorage = 29978

local reward = TalkAction("!reward")

function reward.onSay(player, words, param)
    if player then
        if player:getStorageValue(rewardStorage) >= os.time() then
            player:sendCancelMessage("You already collected your daily reward.")
        else
            player:setStorageValue(rewardStorage, os.time() + 24 * 60 * 60)
            player:getPosition():sendMagicEffect(CONST_ME_SMOKE)

local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)

            if player:isSorcerer() then
                inbox:addItem(32389, exerciseCharges)
            elseif player:isDruid() then
                inbox:addItem(32388, exerciseCharges)
            elseif player:isPaladin() then
                inbox:addItem(32387, exerciseCharges)
            elseif player:isKnight() then
                if player:getSkillLevel(SKILL_SWORD) > player:getSkillLevel(SKILL_CLUB) and
                player:getSkillLevel(SKILL_SWORD) > player:getSkillLevel(SKILL_AXE) then
                   inbox:addItem(32384, exerciseCharges)
                elseif player:getSkillLevel(SKILL_CLUB) > player:getSkillLevel(SKILL_SWORD) and
                    player:getSkillLevel(SKILL_CLUB) > player:getSkillLevel(SKILL_AXE) then
                    inbox:addItem(32386, exerciseCharges)
                elseif player:getSkillLevel(SKILL_AXE) > player:getSkillLevel(SKILL_SWORD) and
                    player:getSkillLevel(SKILL_AXE) > player:getSkillLevel(SKILL_CLUB) then
                    inbox:addItem(32385, exerciseCharges)
                end
            end
        end
    end
end

reward:register()