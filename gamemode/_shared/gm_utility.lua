function util.GetAlivePlayers()
   local alive = {}
   for k, p in pairs(player.GetAll()) do
      if IsValid(p) and p:Alive() and p:Team() == 1 then
         table.insert(alive, p)
      end
   end

   return alive
end

function util.GetNextAlivePlayer( ply )
   local alive = util.GetAlivePlayers()

   if #alive < 1 then return nil end

   local prev = nil
   local choice = nil

   if IsValid(ply) then
      for k,p in pairs(alive) do
         if prev == ply then
            choice = p
         end

         prev = p
      end
   end

   if not IsValid(choice) then
      choice = alive[1]
   end

   return choice
end

function util.NestedHasValue( tab, str, index )
   for k, v in pairs(tab) do
      if v[index] ==  str then
         return true
      end
   end

   return false
end

--Rates as of 26/3/17 -- maybe automatic web conversion later? idk

CURRENCY_USD = 0
CURRENCY_GBP = 1
CURRENCY_EUR = 2
CURRENCY_AUD = 3
CURRENCY_SWE_KR = 4

function util.ConvertCurrency( _Amount, _Currency )

   if _Currency == nil || !isnumber( _Currency ) then return end

   local __converted = _Amount

   if _Currency == CURRENCY_GBP then
      __converted = __converted * 0.8
   elseif _Currency == CURRENCY_EUR then
      __converted = __converted * 0.92
   elseif _Currency == CURRENCY_AUD then
      __converted = __converted * 1.31
   elseif _Currency == CURRENCY_SWE_KR then
      __converted = __converted * 8.8
   end

   return __converted
end

function util.Glow(speed,r,g,b,a)
   if speed then
      color = {}
      color.r = math.sin(RealTime()*(speed or 1))*r
      color.b = math.sin(RealTime()*(speed or 1))*g
      color.g = math.sin(RealTime()*(speed or 1))*b
      color.a = a or 255
      return color.r, color.b, color.g, color.a
   end
end

local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function util.Base64Decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local fileColors = {};
local fileAbbrev = {};
local MsgC , print = _G.MsgC , _G.print
local incr = SERVER and 72 or 0 -- server side version of file gets different color from client... way less confusing like that
function dprint(...)
    local info = debug.getinfo(2)
    if not info then 
        print(...)
        return
    end
    
    local fname = info.short_src;
    if fileAbbrev[fname] then
        fname = fileAbbrev[fname];
    else
        local oldfname = fname;
        fname = string.Explode('/', fname);
        fname = fname[#fname];
        fileAbbrev[oldfname] = fname;
    end
    
    if not fileColors[fname] then
        incr = incr + 1;
        fileColors[fname] = HSVToColor(incr * 100 % 255, 1, 1)
    end
    
    MsgC(fileColors[fname], fname..':'..info.linedefined);
    print( '  ', ... )
end