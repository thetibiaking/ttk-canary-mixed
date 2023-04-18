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

local voices = { {text = 'Seja vem vindo!'} }
npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Ola |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Volte sempre |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Volte sempre |PLAYERNAME|.")

npcHandler:addModule(FocusModule:new())
