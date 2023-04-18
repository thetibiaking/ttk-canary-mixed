-- /mounts playername

local mounts = TalkAction("/convite")
function mounts.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    local target
    if param == '' then
        target = player:getTarget()
        if not target then
            player:sendTextMessage(MESSAGE_ATTENTION, 'Unlocks all mounts for certain player. Usage: /mounts <player name>')
            return false
        end
    else
        target = Player(param)
    end

    if not target then
        player:sendTextMessage(MESSAGE_ATTENTION, 'Player ' .. param .. ' is not currently online.')
        return false
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD  then
        player:sendTextMessage(MESSAGE_ATTENTION, 'Cannot perform action.')
        return false
    end

    for i = 23, 23 do
        target:addMount(i)
    end

    player:sendTextMessage(MESSAGE_ATTENTION, 'a montaria foi entregue ao player.: ' .. target:getName())
    target:sendTextMessage(MESSAGE_ATTENTION, 'Voce recebeu uma montaria, por ter vindo codigo de referencia!')
    return false
end

mounts:separator(" ")
mounts:register()
