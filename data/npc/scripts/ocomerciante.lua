local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

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

local shop = {
	{id=32491, buy=80, sell=0, name='library ticket'},
	{id=38907, buy=80, sell=0, name='Phantasmal Jade'},
	{id=34784, buy=80, sell=0, name='mysterious scroll'},
	{id=5804, buy=30, sell=0, name='nose ring'},
	{id=5919, buy=30, sell=0, name='dragon claw'},
	{id=2659, buy=20, sell=0, name='ball gown'},
	{id=21725, buy=20, sell=0, name='furious frock'},
	{id=21708, buy=20, sell=0, name='vampire silk slippers'},
	{id=25429, buy=30, sell=0, name='boots of homecoming'},
	{id=13570, buy=20, sell=0, name='demon infant'},
	{id=35200, buy=20, sell=0, name='badbara'},	
	{id=35202, buy=20, sell=0, name='cryana'},
	{id=7959, buy=20, sell=0, name='firlefanz'},
	{id=21691, buy=40, sell=0, name='shrunken head necklace'},
	{id=22472, buy=1, sell=0, name='stamina refil'},
	{id=23663, buy=10, sell=0, name='Feedbag'},
	{id=20620, buy=10, sell=0, name='Zaoan chess box'},
	{id=29080, buy=10, sell=0, name='blossom bag'},
	{id=13760, buy=60, sell=0, name='wand of dimensions'},
	{id=13938, buy=10, sell=0, name='golden can of oil'},
	{id=36909, buy=40, sell=0, name='plushie of gazHaragoth'},
	{id=27628, buy=20, sell=0, name='astral shaper rune'},
	{id=13940, buy=100, sell=0, name='elemental spikes'},
	{id=13756, buy=10, sell=0, name='mages cap'},
	{id=24261, buy=2, sell=0, name='crest of the deep seas'},
	{id=33276, buy=2, sell=0, name='Bone fiddle'},                  
	{id=29211, buy=2, sell=0, name='Moon Mirror'},         
	{id=29212, buy=2, sell=0, name='Gleaming starlight vial'},         
	{id=29213, buy=2, sell=0, name='Shining sun catcher'},         
	{id=10513, buy=2, sell=0, name='Squeezing gear of girlpower'}, 
	{id=10515, buy=2, sell=0, name='Whacking driller of fate'},    
	{id=10511, buy=2, sell=0, name='Sneaky stabber of eliteness'}, 
	{id=13247, buy=10, sell=0, name='Hunting horn'},
	{id=35201, buy=20, sell=0, name='Tearesa'},
}

local function setNewTradeTable(table)
	local items, item = {}
	for i = 1, #table do
		item = table[i]
		items[item.id] = {id = item.id, buy = item.buy, sell = item.sell, subType = 0, name = item.name}
	end
	return items
end

local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	local itemsTable = setNewTradeTable(shop)
	if not ignoreCap and player:getFreeCapacity() < ItemType(itemsTable[item].id):getWeight(amount) then
		return player:sendTextMessage(MESSAGE_FAILURE, "You don't have enough cap.")
	end
	if itemsTable[item].buy then
		if player:removeItem(Npc():getCurrency(), amount * itemsTable[item].buy) then
			if amount > 1 then
				currencyName = ItemType(Npc():getCurrency()):getPluralName():lower()
			else
				currencyName = ItemType(Npc():getCurrency()):getName():lower()
			end
			player:addItem(itemsTable[item].id, amount)
			return player:sendTextMessage(MESSAGE_TRADE,
						"Bought "..amount.."x "..itemsTable[item].name.." for "..itemsTable[item].buy * amount.." "..currencyName..".")
		else
			return player:sendTextMessage(MESSAGE_FAILURE, "You don't have enough "..currencyName..".")
		end
	end

	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	return true
end

local function greetCallback(cid)
    return true
end


function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if not player then
		return false
	end
	
	if msgcontains(msg, "silver token") or msgcontains(msg, "silver") then
		npcHandler:say("Deseja trocar 30 silver tokens por 1 Golden Raid Token????  {yes}", cid)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 3 then
		if player:removeItem(25172, 30) then			
			player:addItem(21399, 1)
			npcHandler:say("Obrigado, agora voce possui uma moeda de troca na minha loja, fale {trade} para ver o que estou oferecendo.", cid)
		else
			npcHandler:say("Você nao possui silver tokens para trocar, arrume alguns e volte.", cid)
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'trade') then
		openShopWindow(cid, shop, onBuy, onSell)
		npcHandler:say({"Segue as Ofertas, " .. player:getName() .. ".  ",
		"Agradeco a preferencia."}, cid)
	else
		npcHandler:say("Nao Entendi????", cid)
	end
	
	
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Troco 30 {silver token} por 1 Golden Raid Token. {Trade} para ver a Loja")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
