-- Nur autorisierte User dürfen den verschlüsselten Script laden
local allowed = {
    [12345678] = true, -- deine UserId hier
    [87654321] = true  -- weitere erlaubte UserIds
}

if not allowed[game.Players.LocalPlayer.UserId] then
    return print("Du hast keinen Zugriff.")
end

-- Base64-kodierter echter Scriptcode
local encoded = "cHJpbnQoIkhhaSB2b24gZGlyIGJpc3QgYmVyZWNodGV0ISIp"  -- => print("Hai von dir bist berechtigt!")

-- Base64-Decoder
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c=0
        for i=1,8 do c=c + (x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

-- Ausführen
loadstring(decode(encoded))()
