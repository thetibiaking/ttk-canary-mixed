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

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({"almanac of magic"}, 10942, 600, 1)
shopModule:addBuyableItem({"animal fetish"}, 10154, 10000, 1)
shopModule:addBuyableItem({"baby rotworm"}, 10943, 600, 1)
shopModule:addBuyableItem({"bale of white cloth"}, 7500, 6000, 1)
shopModule:addBuyableItem({"bill"}, 2329, 8000, 1)
shopModule:addBuyableItem({"blood crystal"}, 9369, 50000, 1)
shopModule:addBuyableItem({"bloodkiss flower"}, 10159, 10000, 1)
shopModule:addBuyableItem({"bundle of rags"}, 10109, 5000, 1)
shopModule:addBuyableItem({"carrying device"}, 10615, 1000, 1)
shopModule:addBuyableItem({"cigar"}, 7499, 2000, 1)
shopModule:addBuyableItem({"cookbook"}, 2347, 150, 1)
shopModule:addBuyableItem({"damaged logbook"}, 14338, 40000, 1)
shopModule:addBuyableItem({"dark essence"}, 14352, 17000, 1)
shopModule:addBuyableItem({"deep crystal"}, 10158, 13000, 1)
shopModule:addBuyableItem({"elemental crystal"}, 10169, 8000, 1)
shopModule:addBuyableItem({"empty beer bottle"}, 11397, 600, 1)
shopModule:addBuyableItem({"exploding cookie"}, 8111, 100, 1)
shopModule:addBuyableItem({"exquisite silk"}, 12501, 4000, 1)
shopModule:addBuyableItem({"exquisite wood"}, 12503, 4000, 1)
shopModule:addBuyableItem({"faded last will"}, 12500, 600, 1)
shopModule:addBuyableItem({"family brooch"}, 4845, 1000, 1)
shopModule:addBuyableItem({"family signet ring"}, 7708, 15000, 1)
shopModule:addBuyableItem({"fan club membership card"}, 10308, 10000, 1)
shopModule:addBuyableItem({"filled carrying device"}, 10616, 1000, 1)
shopModule:addBuyableItem({"fishnapped goldfish"}, 8766, 7000, 1)
shopModule:addBuyableItem({"flask of crown polisher"}, 10926, 700, 1)
shopModule:addBuyableItem({"flask of extra greasy oil"}, 11106, 1000, 1)
shopModule:addBuyableItem({"flask of poison"}, 10760, 1000, 1)
shopModule:addBuyableItem({"flexible dragon scale"}, 12506, 4000, 1)
shopModule:addBuyableItem({"formula for a memory potion"}, 14351, 5000, 1)
shopModule:addBuyableItem({"funeral urn"}, 4858, 6000, 1)
shopModule:addBuyableItem({"ghost charm"}, 9737, 20000, 1)
shopModule:addBuyableItem({"ghost's tear"}, 9662, 50000, 1)
shopModule:addBuyableItem({"giant ape's hair"}, 4843, 24000, 1)
shopModule:addBuyableItem({"golem blueprint"}, 10165, 13500, 1)
shopModule:addBuyableItem({"golem head"}, 10173, 25000, 1)
shopModule:addBuyableItem({"headache pill"}, 10454, 350, 1)
shopModule:addBuyableItem({"ivory lyre"}, 36282, 5000, 1)
shopModule:addBuyableItem({"letterbag"}, 2330, 8000, 1)
shopModule:addBuyableItem({"lump of clay"}, 12285, 1000, 1)
shopModule:addBuyableItem({"machine crate"}, 10307, 8500, 1)
shopModule:addBuyableItem({"magic crystal"}, 12508, 4000, 1)
shopModule:addBuyableItem({"mago mechanic core"}, 10167, 13000, 1)
shopModule:addBuyableItem({"map to the unknown"}, 10928, 650, 1)
shopModule:addBuyableItem({"memory crystal"}, 7281, 500, 1)
shopModule:addBuyableItem({"memory stone"}, 4852, 3000, 1)
shopModule:addBuyableItem({"mystic root"}, 12507, 4000, 1)
shopModule:addBuyableItem({"nautical map"}, 10225, 5250, 1)
shopModule:addBuyableItem({"old iron"}, 12505, 4000, 1)
shopModule:addBuyableItem({"old power core"}, 10170, 13000, 1)
shopModule:addBuyableItem({"plans for a strange device"}, 10613, 1000, 1)
shopModule:addBuyableItem({"rare crystal"}, 11104, 1000, 1)
shopModule:addBuyableItem({"sacred earth"}, 12297, 1000, 1)
shopModule:addBuyableItem({"sceptre of sun and sea"}, 36249, 50000, 1)
shopModule:addBuyableItem({"shadow orb"}, 10155, 12500, 1)
shopModule:addBuyableItem({"sheet of tracing paper"}, 4854, 500, 1)
shopModule:addBuyableItem({"suspicious signet ring"}, 7697, 15000, 1)
shopModule:addBuyableItem({"snake destroyer"}, 4846, 8000, 1)
shopModule:addBuyableItem({"soul contract"}, 10945, 666, 1)
shopModule:addBuyableItem({"special flask"}, 14323, 5000, 1)
shopModule:addBuyableItem({"spectral cloth"}, 12502, 4000, 1)
shopModule:addBuyableItem({"spectral dress"}, 4847, 15000, 1)
shopModule:addBuyableItem({"spyreport"}, 2345, 3000, 1)
shopModule:addBuyableItem({"stabilizer"}, 10166, 12500, 1)
shopModule:addBuyableItem({"strange powder"}, 15389, 5000, 1)
shopModule:addBuyableItem({"strong sinew"}, 12504, 4000, 1)
shopModule:addBuyableItem({"tear of daraman"}, 2346, 16000, 1)
shopModule:addBuyableItem({"technomancer beard"}, 7699, 5000, 1)
shopModule:addBuyableItem({"the alchemists' formulas"}, 9733, 8000, 1)
shopModule:addBuyableItem({"the ring of the count"}, 8752, 10000, 1)
shopModule:addBuyableItem({"toy mouse"}, 7487, 16000, 1)
shopModule:addBuyableItem({"universal tool"}, 10944, 550, 1)
shopModule:addBuyableItem({"unworked sacred wood"}, 12295, 1000, 1)
shopModule:addBuyableItem({"whisper moss"}, 4838, 18000, 1)
shopModule:addBuyableItem({"worm queen tooth"}, 10157, 12500, 1)
shopModule:addBuyableItem({"wrinkled parchment"}, 14336, 4000, 1)
shopModule:addBuyableItem({"wolf tooth chain"}, 5940, 10000, 1)
shopModule:addBuyableItem({"dark moon mirror"}, 29030, 5000, 1)
shopModule:addBuyableItem({"empty starlight vial"}, 29032, 5000, 1)
shopModule:addBuyableItem({"dark sun catcher"}, 29034, 5000, 1)

local function onTradeRequest(cid)
	-- local player = Player(cid)
	--if player:getStorageValue(Storage.ThievesGuild.Mission08) ~= 3 then
	--	npcHandler:say("I don't know you and I don't have any dealings with people whom I don't trust.", cid)
	--	return false
	--end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hi there, |PLAYERNAME|! You look like you are eager to {trade}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|")

npcHandler:setCallback(CALLBACK_ONTRADEREQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
