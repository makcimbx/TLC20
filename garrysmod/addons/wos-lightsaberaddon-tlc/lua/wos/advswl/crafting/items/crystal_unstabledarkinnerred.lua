local ITEM = {}

ITEM.Name = "Нестабильный Кристалл ( Dark Inner Красный )"

ITEM.Description = "Сломанный кристалл, дающий непостоянное лезвие"

ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

ITEM.Model = "models/red2/red2.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 1

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Unstable" ] = true
	wep.UseColor = Color( 255, 0, 0 )
	wep.UseDarkInner = 1
end

wOS:RegisterItem( ITEM )