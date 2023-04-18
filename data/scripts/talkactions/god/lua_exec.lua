local lua = TalkAction("/lua")

function sendToPlayerLuaCallResult(player, ...)
   local n = select('#', ...)
   local result = setmetatable({ ... }, {
      __len = function()
         return n
      end,
   })

   local t = {}
   for i = 2, #result do
      local v = tostring(result[i])
      if v:len() > 0 then
         table.insert(t, v)
      end
   end

   if #t > 0 then
     player:sendCancelMessage(table.concat(t, ', '))
   end
end
function print_r ( t ) 
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end

function lua.onSay(player, words, param)
   if not player:getGroup():getAccess() then
      return true
   end
   if player:getAccountType() < ACCOUNT_TYPE_GOD then
      return false
   end

   sendToPlayerLuaCallResult(player, pcall(load(
      'local cid = ' .. player:getId() .. ' ' ..
         'local player = Player(cid) ' ..
         'local pos = player:getPosition() ' ..
         'local position = pos ' ..
         param
   )))

   return false
end

lua:separator(" ")
lua:register()