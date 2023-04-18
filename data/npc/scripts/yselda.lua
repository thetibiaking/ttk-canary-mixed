local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
	-- local player = Player(cid)
	-- if player then
		-- player:teleportTo(Position(33899, 31885, 8))
	-- end
	return false
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
-- npcHandler:setMessage(MESSAGE_GREET, "AAAAAAAAAAAAAH!!! ")

-- keywordHandler:addGreetKeyword({"hail king"}, {npcHandler = npcHandler, text = "I greet thee, my loyal subject |PLAYERNAME|."})

npcHandler:addModule(FocusModule:new())