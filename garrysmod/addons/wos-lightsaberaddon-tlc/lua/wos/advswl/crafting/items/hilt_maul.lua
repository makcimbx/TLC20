local ITEM = {}

ITEM.Name = "Двойная Рукоятка Дарта Мола"

ITEM.Description = "Рукоятка светового меча"

ITEM.Type = WOSTYPE.HILT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/weapons/starwars/w_maul_saber_staff_hilt.mdl"

ITEM.OnEquip = function( wep )
	wep.UseHilt = "models/weapons/starwars/w_maul_saber_staff_hilt.mdl"
end

wOS:RegisterItem( ITEM )