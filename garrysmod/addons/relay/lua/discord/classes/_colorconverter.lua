local ColorConverter = {}

function ColorConverter:num2hex(num)
    local hexstr = '0123456789abcdef'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '00' end
    return s
end

function ColorConverter:ToHex(clr)
    return self:num2hex(clr.r) .. self:num2hex(clr.g) .. self:num2hex(clr.b)
end

function ColorConverter:ToDecimal(clr)
    return tonumber(self:ToHex(clr), 16)
end

OOP:Register("ColorConverter", ColorConverter)