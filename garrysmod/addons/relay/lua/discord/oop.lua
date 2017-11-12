OOP = {}
OOP.Classes = {}
OOP.Objects = {}

function OOP:Register(class, tbl, inherit)
    OOP.Classes[class] = inherit and table.Merge(OOP.Classes[inherit], table.Copy(tbl)) or table.Copy(tbl)
    OOP.Classes[class].class = class
    OOP.Classes[class].__index = OOP.Classes[class]
end

function OOP:New(class, ...)
    if not OOP.Classes[class] then return nil end
    local tbl = {}
	setmetatable(tbl, table.Copy(OOP.Classes[class]))
	if tbl.Constructor then tbl:Constructor(...) end
    OOP.Objects[class] = OOP.Objects[class] or {}
    table.insert(OOP.Objects, tbl)
	return tbl
end
