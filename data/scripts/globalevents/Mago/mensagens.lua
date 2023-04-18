local AutoBroadCast = GlobalEvent("text")
function AutoBroadCast.onThink(interval, lastExecution)
    local messages = {

    "[INFO] 10 minutes in On Workouts will restore your stamina FULL",
    "[INFO] PROHIBITED HUNT AFK - Punicao BAN",
    "[INFO] Follow OT updates at https://discord.gg/qXpFb7DXSJ",
    "[INFO] End of year event follow through our website.",
    "[INFO] Any problems report to discord.",

}
    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_GAME_HIGHLIGHT) 
    return true
end
AutoBroadCast:interval(600000)
AutoBroadCast:register()