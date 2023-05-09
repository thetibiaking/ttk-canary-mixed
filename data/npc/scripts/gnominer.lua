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

local voices = { {text = 'Keep in mind that the candy melts after some time so better hurry or buy some new one.'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "Challenger") then
		if player:getStorageValue(Storage.PrimalOrdealQuest.GnompronaAcess) < 1 then
			npcHandler:say({
                "We are exploring this underground island and are gathering the abundant resources found here. Recently we have run into trouble though ...",
			}, cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
				npcHandler:say("Here it is.", cid)
				player:setStorageValue(Storage.PrimalOrdealQuest.PrimalOrdealQuest, 1)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Greeting message
keywordHandler:addGreetKeyword({"hi"}, {npcHandler = npcHandler, text = " Greetings on Gnomprona and welcome to operation challenger., |PLAYERNAME|."})
--Farewell message
keywordHandler:addFarewellKeyword({"asgha thrazi"}, {npcHandler = npcHandler, text = "Good bye, |PLAYERNAME|."})

npcHandler:addModule(FocusModule:new())