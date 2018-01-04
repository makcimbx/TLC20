local ITEM = {}

ITEM.Name = "Рукоятка Дарта Мола"

ITEM.Description = "Рукоятка светового меча"

ITEM.Type = WOSTYPE.HILT

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/starwars/cwa/lightsabers/darthmaul.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 15

ITEM.OnEquip = function( wep )
	wep.UseHilt = "models/starwars/cwa/lightsabers/darthmaul.mdl"
end

wOS:RegisterItem( ITEM )