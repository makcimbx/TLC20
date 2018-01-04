local ITEM = {}

--The name of the item ( is also an identifier for spawning the item )
ITEM.Name = "Поврежденный кристалл ( Светло-Зеленый )"

--The description that appears with the item name
ITEM.Description = "Треснувший кристалл от собсвтенной силы."

--The category it belongs to
ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

--The model of the item on the floor / inventory
ITEM.Model = "models/lgreen4/lgreen4.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 5

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Corrupted" ] = true
	wep.UseColor = Color(127, 245, 32, 255)
end

wOS:RegisterItem( ITEM )