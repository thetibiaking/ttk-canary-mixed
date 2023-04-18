-- Config
local tplist = {
    [64213] = {name = "Teleports", positions =
                 {{x = 17067, y = 16973, z = 6}, -- ilha npc
                  {x = 1116, y = 1094, z = 7}, -- treino
                  {x = 32208, y = 32281, z = 7}, -- Forja
                  {x = 32210, y = 32300, z = 6}, -- adventure Stone
              --    {x = 17066, y = 16961, z = 6}, -- Shop
                  },subareas = {'Ilha Npcs', 'Treiners', 'Forja', 'Adventure Stone'}
                },

	[64214] = {name = "Cidades", positions = 
                {{x = 32369, y = 32241, z = 7}, -- thais
                 {x = 32360, y = 31782, z = 7}, -- Carlin
                 {x = 33217, y = 31814, z = 8}, -- Edron
                 {x = 32957, y = 32076, z = 7}, -- venore
                 {x = 32732, y = 31634, z = 7}, -- Ab'Dendriel
                 {x = 32649, y = 31925, z = 11}, -- Kazordoon
                 {x = 33194, y = 32853, z = 8}, -- Ankrahmun
                 {x = 33023, y = 31521, z = 11}, -- Farmine
                 {x = 33213, y = 32454, z = 1}, -- Darashia
                 {x = 32317, y = 32826, z = 7}, -- Liberty Bay
                 {x = 32594, y = 32745, z = 7}, -- Port Hope
                 {x = 32212, y = 31132, z = 7}, -- Svargrond
                 {x = 32787, y = 31276, z = 7}, -- Yalahar
                 {x = 33447, y = 31323, z = 9}, -- Gray Island
                 {x = 33657, y = 31665, z = 8}, -- Krailos
                 {x = 33594, y = 31899, z = 6}, -- Oramond
                 {x = 33513, y = 32363, z = 6}, -- Roshamuul
                 {x = 33921, y = 31477, z = 5}, -- Issavi
                }, subareas = {'Thais', 'Carlin', 'Edron', 'Venore', 'Ab Dendriel',
                                'Kazordoon', 'Ankrahmun', 'Farmine', 'Darashia', 'Liberty Bay',
                                'Port Hope', 'Svargrond', 'Yalahar', 'Gray Island', 'Krailos',
                                'Oramond', 'Roshamuul', 'Issavi'
                }
              }
}
local firstid = 64213 -- Put your first action id used here
local lastid = 64214 -- Put your last action id used here

-- Config End
local teleports = MoveEvent()
function teleports.onStepIn(player, item, position, fromPosition)
    if not player:isPlayer() then
        return false
    end
  
    local tp = tplist[item.actionid]
    local quantity = table.getn(tp.positions)
  
    player:registerEvent("Teleport_Modal_Window")
  
    local title = "Zaferia Teleports"
    local message = "Lista de teleports"
      
    local window = ModalWindow(item.actionid, title, message)
    window:addButton(100, "Go")
    window:addButton(101, "Cancel")
      
    for i = 1, quantity do
        if tp.subareas[i] == nil then
            window:addChoice(i,"".. tp.name .." ".. i .."")
        else
            window:addChoice(i,"".. tp.subareas[i] .."")
        end
    end
  
    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
  
    if tp and quantity < 2 then
        player:unregisterEvent("Teleport_Modal_Window")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Teleported to '.. tp.name ..'.')
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:teleportTo(tp.positions[1])
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        window:sendToPlayer(player)
    end
    return true
end

for j = firstid, lastid do
    teleports:aid(j)
end

teleports:type("stepin")
teleports:register()

local modalTp = CreatureEvent("Teleport_Modal_Window")
modalTp:type("modalwindow")

function modalTp.onModalWindow(player, modalWindowId, buttonId, choiceId)
    player:unregisterEvent("Teleport_Modal_Window")
    if modalWindowId >= firstid and modalWindowId <= lastid then
        if buttonId == 100 then
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:teleportTo(tplist[modalWindowId].positions[choiceId])
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            if tplist[modalWindowId].subareas[choiceId] == nil then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Teleported to '.. tplist[modalWindowId].name ..' '.. choiceId ..'.')
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Teleported to '.. tplist[modalWindowId].subareas[choiceId] ..'.')
            end
        end
    end
    return true
end

modalTp:register()