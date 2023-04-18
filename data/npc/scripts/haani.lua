local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
    npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
    npcHandler:onThink()
end

local voices = { {text = 'Furniture! Best prices in town!'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'furniture'}, StdModule.say, {npcHandler = npcHandler, text = "Well, as you can see, I sell furniture. Ask me for a {trade} if you're interested to see my wares."})

npcHandler:setMessage(MESSAGE_GREET, "Furniture on sale! Don't miss the opportunity, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Beds, chairs, decoration, flowers, instruments! Buy them here!")
npcHandler:addModule(FocusModule:new())
