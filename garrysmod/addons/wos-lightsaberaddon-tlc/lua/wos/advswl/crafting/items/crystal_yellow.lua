local ITEM = {}

ITEM.Name = "Кристалл ( Желтый )"

ITEM.Description = "Базовый"

ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/yellow2/yellow2.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 15

ITEM.OnEquip = function( wep )
	wep.UseColor = Color( 255, 255, 0 )
end

wOS:RegisterItem( ITEM )